Received: from eggs.gnu.org ([2001:4830:134:3::10]:59073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gKmrT-0004lZ-Vx
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:08:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gKmrQ-0000LL-K7
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:08:51 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gKmrQ-0000HS-9g
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:08:48 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Thu,  8 Nov 2018 18:07:57 +0200
Message-Id: <20181108160818.5485-2-yuval.shaia@oracle.com>
In-Reply-To: <20181108160818.5485-1-yuval.shaia@oracle.com>
References: <20181108160818.5485-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v2 01/22] contrib/rdmacm-mux: Add
 implementation of RDMA User MAD multiplexer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com

RDMA MAD kernel module (ibcm) disallow more than one MAD-agent for a
given MAD class.
This does not go hand-by-hand with qemu pvrdma device's requirements
where each VM is MAD agent.
Fix it by adding implementation of RDMA MAD multiplexer service which on
one hand register as a sole MAD agent with the kernel module and on the
other hand gives service to more than one VM.

Design Overview:
----------------
A server process is registered to UMAD framework (for this to work the
rdma_cm kernel module needs to be unloaded) and creates a unix socket to
listen to incoming request from clients.
A client process (such as QEMU) connects to this unix socket and
registers with its own GID.

TX:
---
When client needs to send rdma_cm MAD message it construct it the same
way as without this multiplexer, i.e. creates a umad packet but this
time it writes its content to the socket instead of calling umad_send().
The server, upon receiving such a message fetch local_comm_id from it so
a context for this session can be maintain and relay the message to UMAD
layer by calling umad_send().

RX:
---
The server creates a worker thread to process incoming rdma_cm MAD
messages. When an incoming message arrived (umad_recv()) the server,
depending on the message type (attr_id) looks for target client by
either searching in gid->fd table or in local_comm_id->fd table. With
the extracted fd the server relays to incoming message to the client.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 MAINTAINERS                      |   1 +
 Makefile                         |   3 +
 Makefile.objs                    |   1 +
 contrib/rdmacm-mux/Makefile.objs |   4 +
 contrib/rdmacm-mux/main.c        | 770 +++++++++++++++++++++++++++++++
 contrib/rdmacm-mux/rdmacm-mux.h  |  56 +++
 6 files changed, 835 insertions(+)
 create mode 100644 contrib/rdmacm-mux/Makefile.objs
 create mode 100644 contrib/rdmacm-mux/main.c
 create mode 100644 contrib/rdmacm-mux/rdmacm-mux.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 98a1856afc..e087d58ac6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2231,6 +2231,7 @@ S: Maintained
 F: hw/rdma/*
 F: hw/rdma/vmw/*
 F: docs/pvrdma.txt
+F: contrib/rdmacm-mux/*
 
 Build and test automation
 -------------------------
diff --git a/Makefile b/Makefile
index f2947186a4..94072776ff 100644
--- a/Makefile
+++ b/Makefile
@@ -418,6 +418,7 @@ dummy := $(call unnest-vars,, \
                 elf2dmp-obj-y \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
+                rdmacm-mux-obj-y \
                 libvhost-user-obj-y \
                 vhost-user-scsi-obj-y \
                 vhost-user-blk-obj-y \
@@ -725,6 +726,8 @@ vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) libvhost-user.a
 	$(call LINK, $^)
 vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) libvhost-user.a
 	$(call LINK, $^)
+rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
+	$(call LINK, $^)
 
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
diff --git a/Makefile.objs b/Makefile.objs
index 1e1ff387d7..cc7df3ad80 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -194,6 +194,7 @@ vhost-user-scsi.o-cflags := $(LIBISCSI_CFLAGS)
 vhost-user-scsi.o-libs := $(LIBISCSI_LIBS)
 vhost-user-scsi-obj-y = contrib/vhost-user-scsi/
 vhost-user-blk-obj-y = contrib/vhost-user-blk/
+rdmacm-mux-obj-y = contrib/rdmacm-mux/
 
 ######################################################################
 trace-events-subdirs =
diff --git a/contrib/rdmacm-mux/Makefile.objs b/contrib/rdmacm-mux/Makefile.objs
new file mode 100644
index 0000000000..be3eacb6f7
--- /dev/null
+++ b/contrib/rdmacm-mux/Makefile.objs
@@ -0,0 +1,4 @@
+ifdef CONFIG_PVRDMA
+CFLAGS += -libumad -Wno-format-truncation
+rdmacm-mux-obj-y = main.o
+endif
diff --git a/contrib/rdmacm-mux/main.c b/contrib/rdmacm-mux/main.c
new file mode 100644
index 0000000000..0308074b15
--- /dev/null
+++ b/contrib/rdmacm-mux/main.c
@@ -0,0 +1,770 @@
+/*
+ * QEMU paravirtual RDMA - rdmacm-mux implementation
+ *
+ * Copyright (C) 2018 Oracle
+ * Copyright (C) 2018 Red Hat Inc
+ *
+ * Authors:
+ *     Yuval Shaia <yuval.shaia@oracle.com>
+ *     Marcel Apfelbaum <marcel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "sys/poll.h"
+#include "sys/ioctl.h"
+#include "pthread.h"
+#include "syslog.h"
+
+#include "infiniband/verbs.h"
+#include "infiniband/umad.h"
+#include "infiniband/umad_types.h"
+#include "infiniband/umad_sa.h"
+#include "infiniband/umad_cm.h"
+
+#include "rdmacm-mux.h"
+
+#define SCALE_US 1000
+#define COMMID_TTL 2 /* How many SCALE_US a context of MAD session is saved */
+#define SLEEP_SECS 5 /* This is used both in poll() and thread */
+#define SERVER_LISTEN_BACKLOG 10
+#define MAX_CLIENTS 4096
+#define MAD_RMPP_VERSION 0
+#define MAD_METHOD_MASK0 0x8
+
+#define IB_USER_MAD_LONGS_PER_METHOD_MASK (128 / (8 * sizeof(long)))
+
+#define CM_REQ_DGID_POS      80
+#define CM_SIDR_REQ_DGID_POS 44
+
+/* The below can be override by command line parameter */
+#define UNIX_SOCKET_PATH "/var/run/rdmacm-mux"
+#define RDMA_DEVICE "rxe0"
+#define RDMA_PORT_NUM 1
+
+typedef struct RdmaCmServerArgs {
+    char unix_socket_path[PATH_MAX];
+    char rdma_dev_name[NAME_MAX];
+    int rdma_port_num;
+} RdmaCMServerArgs;
+
+typedef struct CommId2FdEntry {
+    int fd;
+    int ttl; /* Initialized to 2, decrement each timeout, entry delete when 0 */
+    __be64 gid_ifid;
+} CommId2FdEntry;
+
+typedef struct RdmaCmUMadAgent {
+    int port_id;
+    int agent_id;
+    GHashTable *gid2fd; /* Used to find fd of a given gid */
+    GHashTable *commid2fd; /* Used to find fd on of a given comm_id */
+} RdmaCmUMadAgent;
+
+typedef struct RdmaCmServer {
+    bool run;
+    RdmaCMServerArgs args;
+    struct pollfd fds[MAX_CLIENTS];
+    int nfds;
+    RdmaCmUMadAgent umad_agent;
+    pthread_t umad_recv_thread;
+    pthread_rwlock_t lock;
+} RdmaCMServer;
+
+RdmaCMServer server = {0};
+
+static void usage(const char *progname)
+{
+    printf("Usage: %s [OPTION]...\n"
+           "Start a RDMA-CM multiplexer\n"
+           "\n"
+           "\t-h                    Show this help\n"
+           "\t-s unix-socket-path   Path to unix socket to listen on (default %s)\n"
+           "\t-d rdma-device-name   Name of RDMA device to register with (default %s)\n"
+           "\t-p rdma-device-port   Port number of RDMA device to register with (default %d)\n",
+           progname, UNIX_SOCKET_PATH, RDMA_DEVICE, RDMA_PORT_NUM);
+}
+
+static void help(const char *progname)
+{
+    fprintf(stderr, "Try '%s -h' for more information.\n", progname);
+}
+
+static void parse_args(int argc, char *argv[])
+{
+    int c;
+    char unix_socket_path[PATH_MAX];
+
+    strcpy(unix_socket_path, UNIX_SOCKET_PATH);
+    strncpy(server.args.rdma_dev_name, RDMA_DEVICE, NAME_MAX - 1);
+    server.args.rdma_port_num = RDMA_PORT_NUM;
+
+    while ((c = getopt(argc, argv, "hs:d:p:")) != -1) {
+        switch (c) {
+        case 'h':
+            usage(argv[0]);
+            exit(0);
+
+        case 's':
+            /* This is temporary, final name will build below */
+            strncpy(unix_socket_path, optarg, PATH_MAX);
+            break;
+
+        case 'd':
+            strncpy(server.args.rdma_dev_name, optarg, NAME_MAX - 1);
+            break;
+
+        case 'p':
+            server.args.rdma_port_num = atoi(optarg);
+            break;
+
+        default:
+            help(argv[0]);
+            exit(1);
+        }
+    }
+
+    /* Build unique unix-socket file name */
+    snprintf(server.args.unix_socket_path, PATH_MAX, "%s-%s-%d",
+             unix_socket_path, server.args.rdma_dev_name,
+             server.args.rdma_port_num);
+
+    syslog(LOG_INFO, "unix_socket_path=%s", server.args.unix_socket_path);
+    syslog(LOG_INFO, "rdma-device-name=%s", server.args.rdma_dev_name);
+    syslog(LOG_INFO, "rdma-device-port=%d", server.args.rdma_port_num);
+}
+
+static void hash_tbl_alloc(void)
+{
+
+    server.umad_agent.gid2fd = g_hash_table_new_full(g_int64_hash,
+                                                     g_int64_equal,
+                                                     g_free, g_free);
+    server.umad_agent.commid2fd = g_hash_table_new_full(g_int_hash,
+                                                        g_int_equal,
+                                                        g_free, g_free);
+}
+
+static void hash_tbl_free(void)
+{
+    if (server.umad_agent.commid2fd) {
+        g_hash_table_destroy(server.umad_agent.commid2fd);
+    }
+    if (server.umad_agent.gid2fd) {
+        g_hash_table_destroy(server.umad_agent.gid2fd);
+    }
+}
+
+
+static int _hash_tbl_search_fd_by_ifid(__be64 *gid_ifid)
+{
+    int *fd;
+
+    fd = g_hash_table_lookup(server.umad_agent.gid2fd, gid_ifid);
+    if (!fd) {
+        /* Let's try IPv4 */
+        *gid_ifid |= 0x00000000ffff0000;
+        fd = g_hash_table_lookup(server.umad_agent.gid2fd, gid_ifid);
+    }
+
+    return fd ? *fd : 0;
+}
+
+static int hash_tbl_search_fd_by_ifid(int *fd, __be64 *gid_ifid)
+{
+    pthread_rwlock_rdlock(&server.lock);
+    *fd = _hash_tbl_search_fd_by_ifid(gid_ifid);
+    pthread_rwlock_unlock(&server.lock);
+
+    if (!fd) {
+        syslog(LOG_WARNING, "Can't find matching for ifid 0x%llx\n", *gid_ifid);
+        return -ENOENT;
+    }
+
+    return 0;
+}
+
+static int hash_tbl_search_fd_by_comm_id(uint32_t comm_id, int *fd,
+                                         __be64 *gid_idid)
+{
+    CommId2FdEntry *fde;
+
+    pthread_rwlock_rdlock(&server.lock);
+    fde = g_hash_table_lookup(server.umad_agent.commid2fd, &comm_id);
+    pthread_rwlock_unlock(&server.lock);
+
+    if (!fde) {
+        syslog(LOG_WARNING, "Can't find matching for comm_id 0x%x\n", comm_id);
+        return -ENOENT;
+    }
+
+    *fd = fde->fd;
+    *gid_idid = fde->gid_ifid;
+
+    return 0;
+}
+
+static RdmaCmMuxErrCode add_fd_ifid_pair(int fd, __be64 gid_ifid)
+{
+    int fd1;
+
+    pthread_rwlock_wrlock(&server.lock);
+
+    fd1 = _hash_tbl_search_fd_by_ifid(&gid_ifid);
+    if (fd1) { /* record already exist - an error */
+        pthread_rwlock_unlock(&server.lock);
+        return fd == fd1 ? RDMACM_MUX_ERR_CODE_EEXIST :
+                           RDMACM_MUX_ERR_CODE_EACCES;
+    }
+
+    g_hash_table_insert(server.umad_agent.gid2fd, g_memdup(&gid_ifid,
+                        sizeof(gid_ifid)), g_memdup(&fd, sizeof(fd)));
+
+    pthread_rwlock_unlock(&server.lock);
+
+    syslog(LOG_INFO, "0x%lx registered on socket %d", (uint64_t)gid_ifid, fd);
+
+    return RDMACM_MUX_ERR_CODE_OK;
+}
+
+static RdmaCmMuxErrCode delete_fd_ifid_pair(int fd, __be64 gid_ifid)
+{
+    int fd1;
+
+    pthread_rwlock_wrlock(&server.lock);
+
+    fd1 = _hash_tbl_search_fd_by_ifid(&gid_ifid);
+    if (!fd1) { /* record not exist - an error */
+        pthread_rwlock_unlock(&server.lock);
+        return RDMACM_MUX_ERR_CODE_ENOTFOUND;
+    }
+
+    g_hash_table_remove(server.umad_agent.gid2fd, g_memdup(&gid_ifid,
+                        sizeof(gid_ifid)));
+    pthread_rwlock_unlock(&server.lock);
+
+    syslog(LOG_INFO, "0x%lx unregistered on socket %d", (uint64_t)gid_ifid, fd);
+
+    return RDMACM_MUX_ERR_CODE_OK;
+}
+
+static void hash_tbl_save_fd_comm_id_pair(int fd, uint32_t comm_id,
+                                          uint64_t gid_ifid)
+{
+    CommId2FdEntry fde = {fd, COMMID_TTL, gid_ifid};
+
+    pthread_rwlock_wrlock(&server.lock);
+    g_hash_table_insert(server.umad_agent.commid2fd,
+                        g_memdup(&comm_id, sizeof(comm_id)),
+                        g_memdup(&fde, sizeof(fde)));
+    pthread_rwlock_unlock(&server.lock);
+}
+
+static gboolean remove_old_comm_ids(gpointer key, gpointer value,
+                                    gpointer user_data)
+{
+    CommId2FdEntry *fde = (CommId2FdEntry *)value;
+
+    return !fde->ttl--;
+}
+
+static gboolean remove_entry_from_gid2fd(gpointer key, gpointer value,
+                                         gpointer user_data)
+{
+    if (*(int *)value == *(int *)user_data) {
+        syslog(LOG_INFO, "0x%lx unregistered on socket %d", *(uint64_t *)key,
+               *(int *)value);
+        return true;
+    }
+
+    return false;
+}
+
+static void hash_tbl_remove_fd_ifid_pair(int fd)
+{
+    pthread_rwlock_wrlock(&server.lock);
+    g_hash_table_foreach_remove(server.umad_agent.gid2fd,
+                                remove_entry_from_gid2fd, (gpointer)&fd);
+    pthread_rwlock_unlock(&server.lock);
+}
+
+static int get_fd(const char *mad, int *fd, __be64 *gid_ifid)
+{
+    struct umad_hdr *hdr = (struct umad_hdr *)mad;
+    char *data = (char *)hdr + sizeof(*hdr);
+    int32_t comm_id;
+    uint16_t attr_id = be16toh(hdr->attr_id);
+    int rc = 0;
+
+    switch (attr_id) {
+    case UMAD_CM_ATTR_REQ:
+        memcpy(gid_ifid, data + CM_REQ_DGID_POS, sizeof(*gid_ifid));
+        rc = hash_tbl_search_fd_by_ifid(fd, gid_ifid);
+        break;
+
+    case UMAD_CM_ATTR_SIDR_REQ:
+        memcpy(gid_ifid, data + CM_SIDR_REQ_DGID_POS, sizeof(*gid_ifid));
+        rc = hash_tbl_search_fd_by_ifid(fd, gid_ifid);
+        break;
+
+    case UMAD_CM_ATTR_REP:
+        /* Fall through */
+    case UMAD_CM_ATTR_REJ:
+        /* Fall through */
+    case UMAD_CM_ATTR_DREQ:
+        /* Fall through */
+    case UMAD_CM_ATTR_DREP:
+        /* Fall through */
+    case UMAD_CM_ATTR_RTU:
+        data += sizeof(comm_id);
+        /* Fall through */
+    case UMAD_CM_ATTR_SIDR_REP:
+        memcpy(&comm_id, data, sizeof(comm_id));
+        if (comm_id) {
+            rc = hash_tbl_search_fd_by_comm_id(comm_id, fd, gid_ifid);
+        }
+        break;
+
+    default:
+        rc = -EINVAL;
+        syslog(LOG_WARNING, "Unsupported attr_id 0x%x\n", attr_id);
+    }
+
+    return rc;
+}
+
+static void *umad_recv_thread_func(void *args)
+{
+    int rc;
+    RdmaCmMuxMsg msg = {0};
+    int fd = -2;
+
+    while (server.run) {
+        do {
+            msg.umad_len = sizeof(msg.umad.mad);
+            rc = umad_recv(server.umad_agent.port_id, &msg.umad, &msg.umad_len,
+                           SLEEP_SECS * SCALE_US);
+            if ((rc == -EIO) || (rc == -EINVAL)) {
+                syslog(LOG_CRIT, "Fatal error while trying to read MAD");
+            }
+
+            if (rc == -ETIMEDOUT) {
+                g_hash_table_foreach_remove(server.umad_agent.commid2fd,
+                                            remove_old_comm_ids, NULL);
+            }
+        } while (rc && server.run);
+
+        if (server.run) {
+            rc = get_fd(msg.umad.mad, &fd, &msg.hdr.sgid.global.interface_id);
+            if (rc) {
+                continue;
+            }
+
+            send(fd, &msg, sizeof(msg), 0);
+        }
+    }
+
+    return NULL;
+}
+
+static int read_and_process(int fd)
+{
+    int rc;
+    RdmaCmMuxMsg msg = {0};
+    struct umad_hdr *hdr;
+    uint32_t *comm_id;
+    uint16_t attr_id;
+
+    rc = recv(fd, &msg, sizeof(msg), 0);
+
+    if (rc < 0 && errno != EWOULDBLOCK) {
+        return -EIO;
+    }
+
+    if (!rc) {
+        return -EPIPE;
+    }
+
+    switch (msg.hdr.msg_type) {
+    case RDMACM_MUX_MSG_TYPE_REG:
+        rc = add_fd_ifid_pair(fd, msg.hdr.sgid.global.interface_id);
+        break;
+
+    case RDMACM_MUX_MSG_TYPE_UNREG:
+        rc = delete_fd_ifid_pair(fd, msg.hdr.sgid.global.interface_id);
+        break;
+
+    case RDMACM_MUX_MSG_TYPE_MAD:
+        /* If this is REQ or REP then store the pair comm_id,fd to be later
+         * used for other messages where gid is unknown */
+        hdr = (struct umad_hdr *)msg.umad.mad;
+        attr_id = be16toh(hdr->attr_id);
+        if ((attr_id == UMAD_CM_ATTR_REQ) || (attr_id == UMAD_CM_ATTR_DREQ) ||
+            (attr_id == UMAD_CM_ATTR_SIDR_REQ) ||
+            (attr_id == UMAD_CM_ATTR_REP) || (attr_id == UMAD_CM_ATTR_DREP)) {
+            comm_id = (uint32_t *)(msg.umad.mad + sizeof(*hdr));
+            hash_tbl_save_fd_comm_id_pair(fd, *comm_id,
+                                          msg.hdr.sgid.global.interface_id);
+        }
+
+        rc = umad_send(server.umad_agent.port_id, server.umad_agent.agent_id,
+                       &msg.umad, msg.umad_len, 1, 0);
+        if (rc) {
+            syslog(LOG_WARNING, "Fail to send MAD message, err=%d", rc);
+        }
+        break;
+
+    default:
+        syslog(LOG_WARNING, "Got invalid message (%d) from %d",
+               msg.hdr.msg_type, fd);
+        rc = RDMACM_MUX_ERR_CODE_EINVAL;
+    }
+
+    msg.hdr.msg_type = RDMACM_MUX_MSG_TYPE_RESP;
+    msg.hdr.err_code = rc;
+    rc = send(fd, &msg, sizeof(msg), 0);
+
+    return rc == sizeof(msg) ? 0 : -EPIPE;
+}
+
+static int accept_all(void)
+{
+    int fd, rc = 0;;
+
+    pthread_rwlock_wrlock(&server.lock);
+
+    do {
+        if ((server.nfds + 1) > MAX_CLIENTS) {
+            syslog(LOG_WARNING, "Too many clients (%d)", server.nfds);
+            rc = -EIO;
+            goto out;
+        }
+
+        fd = accept(server.fds[0].fd, NULL, NULL);
+        if (fd < 0) {
+            if (errno != EWOULDBLOCK) {
+                syslog(LOG_WARNING, "accept() failed");
+                rc = -EIO;
+                goto out;
+            }
+            break;
+        }
+
+        syslog(LOG_INFO, "Client connected on socket %d\n", fd);
+        server.fds[server.nfds].fd = fd;
+        server.fds[server.nfds].events = POLLIN;
+        server.nfds++;
+    } while (fd != -1);
+
+out:
+    pthread_rwlock_unlock(&server.lock);
+    return rc;
+}
+
+static void compress_fds(void)
+{
+    int i, j;
+    int closed = 0;
+
+    pthread_rwlock_wrlock(&server.lock);
+
+    for (i = 1; i < server.nfds; i++) {
+        if (!server.fds[i].fd) {
+            closed++;
+            for (j = i; j < server.nfds; j++) {
+                server.fds[j].fd = server.fds[j + 1].fd;
+            }
+        }
+    }
+
+    server.nfds -= closed;
+
+    pthread_rwlock_unlock(&server.lock);
+}
+
+static void close_fd(int idx)
+{
+    close(server.fds[idx].fd);
+    syslog(LOG_INFO, "Socket %d closed\n", server.fds[idx].fd);
+    hash_tbl_remove_fd_ifid_pair(server.fds[idx].fd);
+    server.fds[idx].fd = 0;
+}
+
+static void run(void)
+{
+    int rc, nfds, i;
+    bool compress = false;
+
+    syslog(LOG_INFO, "Service started");
+
+    while (server.run) {
+        rc = poll(server.fds, server.nfds, SLEEP_SECS * SCALE_US);
+        if (rc < 0) {
+            if (errno != EINTR) {
+                syslog(LOG_WARNING, "poll() failed");
+            }
+            continue;
+        }
+
+        if (rc == 0) {
+            continue;
+        }
+
+        nfds = server.nfds;
+        for (i = 0; i < nfds; i++) {
+            if (server.fds[i].revents == 0) {
+                continue;
+            }
+
+            if (server.fds[i].revents != POLLIN) {
+                if (i == 0) {
+                    syslog(LOG_NOTICE, "Unexpected poll() event (0x%x)\n",
+                           server.fds[i].revents);
+                } else {
+                    close_fd(i);
+                    compress = true;
+                }
+                continue;
+            }
+
+            if (i == 0) {
+                rc = accept_all();
+                if (rc) {
+                    continue;
+                }
+            } else {
+                rc = read_and_process(server.fds[i].fd);
+                if (rc) {
+                    close_fd(i);
+                    compress = true;
+                }
+            }
+        }
+
+        if (compress) {
+            compress = false;
+            compress_fds();
+        }
+    }
+}
+
+static void fini_listener(void)
+{
+    int i;
+
+    if (server.fds[0].fd <= 0) {
+        return;
+    }
+
+    for (i = server.nfds - 1; i >= 0; i--) {
+        if (server.fds[i].fd) {
+            close(server.fds[i].fd);
+        }
+    }
+
+    unlink(server.args.unix_socket_path);
+}
+
+static void fini_umad(void)
+{
+    if (server.umad_agent.agent_id) {
+        umad_unregister(server.umad_agent.port_id, server.umad_agent.agent_id);
+    }
+
+    if (server.umad_agent.port_id) {
+        umad_close_port(server.umad_agent.port_id);
+    }
+
+    hash_tbl_free();
+}
+
+static void fini(void)
+{
+    if (server.umad_recv_thread) {
+        pthread_join(server.umad_recv_thread, NULL);
+        server.umad_recv_thread = 0;
+    }
+    fini_umad();
+    fini_listener();
+    pthread_rwlock_destroy(&server.lock);
+
+    syslog(LOG_INFO, "Service going down");
+}
+
+static int init_listener(void)
+{
+    struct sockaddr_un sun;
+    int rc, on = 1;
+
+    server.fds[0].fd = socket(AF_UNIX, SOCK_STREAM, 0);
+    if (server.fds[0].fd < 0) {
+        syslog(LOG_ALERT, "socket() failed");
+        return -EIO;
+    }
+
+    rc = setsockopt(server.fds[0].fd, SOL_SOCKET, SO_REUSEADDR, (char *)&on,
+                    sizeof(on));
+    if (rc < 0) {
+        syslog(LOG_ALERT, "setsockopt() failed");
+        rc = -EIO;
+        goto err;
+    }
+
+    rc = ioctl(server.fds[0].fd, FIONBIO, (char *)&on);
+    if (rc < 0) {
+        syslog(LOG_ALERT, "ioctl() failed");
+        rc = -EIO;
+        goto err;
+    }
+
+    if (strlen(server.args.unix_socket_path) >= sizeof(sun.sun_path)) {
+        syslog(LOG_ALERT,
+               "Invalid unix_socket_path, size must be less than %ld\n",
+               sizeof(sun.sun_path));
+        rc = -EINVAL;
+        goto err;
+    }
+
+    sun.sun_family = AF_UNIX;
+    rc = snprintf(sun.sun_path, sizeof(sun.sun_path), "%s",
+                  server.args.unix_socket_path);
+    if (rc < 0 || rc >= sizeof(sun.sun_path)) {
+        syslog(LOG_ALERT, "Could not copy unix socket path\n");
+        rc = -EINVAL;
+        goto err;
+    }
+
+    rc = bind(server.fds[0].fd, (struct sockaddr *)&sun, sizeof(sun));
+    if (rc < 0) {
+        syslog(LOG_ALERT, "bind() failed");
+        rc = -EIO;
+        goto err;
+    }
+
+    rc = listen(server.fds[0].fd, SERVER_LISTEN_BACKLOG);
+    if (rc < 0) {
+        syslog(LOG_ALERT, "listen() failed");
+        rc = -EIO;
+        goto err;
+    }
+
+    server.fds[0].events = POLLIN;
+    server.nfds = 1;
+    server.run = true;
+
+    return 0;
+
+err:
+    close(server.fds[0].fd);
+    return rc;
+}
+
+static int init_umad(void)
+{
+    long method_mask[IB_USER_MAD_LONGS_PER_METHOD_MASK];
+
+    server.umad_agent.port_id = umad_open_port(server.args.rdma_dev_name,
+                                               server.args.rdma_port_num);
+
+    if (server.umad_agent.port_id < 0) {
+        syslog(LOG_WARNING, "umad_open_port() failed");
+        return -EIO;
+    }
+
+    memset(&method_mask, 0, sizeof(method_mask));
+    method_mask[0] = MAD_METHOD_MASK0;
+    server.umad_agent.agent_id = umad_register(server.umad_agent.port_id,
+                                               UMAD_CLASS_CM,
+                                               UMAD_SA_CLASS_VERSION,
+                                               MAD_RMPP_VERSION, method_mask);
+    if (server.umad_agent.agent_id < 0) {
+        syslog(LOG_WARNING, "umad_register() failed");
+        return -EIO;
+    }
+
+    hash_tbl_alloc();
+
+    return 0;
+}
+
+static void signal_handler(int sig, siginfo_t *siginfo, void *context)
+{
+    static bool warned;
+
+    /* Prevent stop if clients are connected */
+    if (server.nfds != 1) {
+        if (!warned) {
+            syslog(LOG_WARNING,
+                   "Can't stop while active client exist, resend SIGINT to overid");
+            warned = true;
+            return;
+        }
+    }
+
+    if (sig == SIGINT) {
+        server.run = false;
+        fini();
+    }
+
+    exit(0);
+}
+
+static int init(void)
+{
+    int rc;
+
+    rc = init_listener();
+    if (rc) {
+        return rc;
+    }
+
+    rc = init_umad();
+    if (rc) {
+        return rc;
+    }
+
+    pthread_rwlock_init(&server.lock, 0);
+
+    rc = pthread_create(&server.umad_recv_thread, NULL, umad_recv_thread_func,
+                        NULL);
+    if (!rc) {
+        return rc;
+    }
+
+    return 0;
+}
+
+int main(int argc, char *argv[])
+{
+    int rc;
+    struct sigaction sig = {0};
+
+    sig.sa_sigaction = &signal_handler;
+    sig.sa_flags = SA_SIGINFO;
+
+    if (sigaction(SIGINT, &sig, NULL) < 0) {
+        syslog(LOG_ERR, "Fail to install SIGINT handler\n");
+        return -EAGAIN;
+    }
+
+    memset(&server, 0, sizeof(server));
+
+    parse_args(argc, argv);
+
+    rc = init();
+    if (rc) {
+        syslog(LOG_ERR, "Fail to initialize server (%d)\n", rc);
+        rc = -EAGAIN;
+        goto out;
+    }
+
+    run();
+
+out:
+    fini();
+
+    return rc;
+}
diff --git a/contrib/rdmacm-mux/rdmacm-mux.h b/contrib/rdmacm-mux/rdmacm-mux.h
new file mode 100644
index 0000000000..03508d52b2
--- /dev/null
+++ b/contrib/rdmacm-mux/rdmacm-mux.h
@@ -0,0 +1,56 @@
+/*
+ * QEMU paravirtual RDMA - rdmacm-mux declarations
+ *
+ * Copyright (C) 2018 Oracle
+ * Copyright (C) 2018 Red Hat Inc
+ *
+ * Authors:
+ *     Yuval Shaia <yuval.shaia@oracle.com>
+ *     Marcel Apfelbaum <marcel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef RDMACM_MUX_H
+#define RDMACM_MUX_H
+
+#include "linux/if.h"
+#include "infiniband/verbs.h"
+#include "infiniband/umad.h"
+#include "rdma/rdma_user_cm.h"
+
+typedef enum RdmaCmMuxMsgType {
+    RDMACM_MUX_MSG_TYPE_REG   = 0,
+    RDMACM_MUX_MSG_TYPE_UNREG = 1,
+    RDMACM_MUX_MSG_TYPE_MAD   = 2,
+    RDMACM_MUX_MSG_TYPE_RESP  = 3,
+} RdmaCmMuxMsgType;
+
+typedef enum RdmaCmMuxErrCode {
+    RDMACM_MUX_ERR_CODE_OK        = 0,
+    RDMACM_MUX_ERR_CODE_EINVAL    = 1,
+    RDMACM_MUX_ERR_CODE_EEXIST    = 2,
+    RDMACM_MUX_ERR_CODE_EACCES    = 3,
+    RDMACM_MUX_ERR_CODE_ENOTFOUND = 4,
+} RdmaCmMuxErrCode;
+
+typedef struct RdmaCmMuxHdr {
+    RdmaCmMuxMsgType msg_type;
+    union ibv_gid sgid;
+    RdmaCmMuxErrCode err_code;
+} RdmaCmUHdr;
+
+typedef struct RdmaCmUMad {
+    struct ib_user_mad hdr;
+    char mad[RDMA_MAX_PRIVATE_DATA];
+} RdmaCmUMad;
+
+typedef struct RdmaCmMuxMsg {
+    RdmaCmUHdr hdr;
+    int umad_len;
+    RdmaCmUMad umad;
+} RdmaCmMuxMsg;
+
+#endif
-- 
2.17.2
