Received: from eggs.gnu.org ([2001:4830:134:3::10]:49798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dk95E-0002uB-Te
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dk95C-00064E-1j
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:19:04 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 22 Aug 2017 15:18:30 +0200
Message-Id: <20170822131832.20191-9-pbonzini@redhat.com>
In-Reply-To: <20170822131832.20191-1-pbonzini@redhat.com>
References: <20170822131832.20191-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 08/10] scsi: build qemu-pr-helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, famz@redhat.com

Introduce a privileged helper to run persistent reservation commands.
This lets virtual machines send persistent reservations without using
CAP_SYS_RAWIO or out-of-tree patches.  The helper uses Unix permissions
and SCM_RIGHTS to restrict access to processes that can access its socket
and prove that they have an open file descriptor for a raw SCSI device.

The next patch will also correct the usage of persistent reservations
with multipath devices.

It would also be possible to support for Linux's IOC_PR_* ioctls in
the future, to support NVMe devices.  For now, however, only SCSI is
supported.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                   |   9 +-
 configure                  |   2 +-
 docs/interop/pr-helper.rst |  78 ++++++
 docs/pr-manager.rst        |  33 +++
 scsi/pr-helper.h           |  13 +
 scsi/qemu-pr-helper.c      | 657 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 790 insertions(+), 2 deletions(-)
 create mode 100644 docs/interop/pr-helper.rst
 create mode 100644 scsi/pr-helper.h
 create mode 100644 scsi/qemu-pr-helper.c

diff --git a/Makefile b/Makefile
index 97a58a0f4e..bfd4f69ecd 100644
--- a/Makefile
+++ b/Makefile
@@ -209,6 +209,9 @@ ifdef BUILD_DOCS
 DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 qemu-ga.8
 DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
 DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7
+ifdef CONFIG_LINUX
+DOCS+=scsi/qemu-pr-helper.8
+endif
 ifdef CONFIG_VIRTFS
 DOCS+=fsdev/virtfs-proxy-helper.1
 endif
@@ -384,6 +387,8 @@ qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
 fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p-marshal.o fsdev/9p-iov-marshal.o $(COMMON_LDADDS)
 fsdev/virtfs-proxy-helper$(EXESUF): LIBS += -lcap
 
+scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+
 qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
 
@@ -491,7 +496,7 @@ clean:
 	rm -f *.msi
 	find . \( -name '*.so' -o -name '*.dll' -o -name '*.mo' -o -name '*.[oda]' \) -type f -exec rm {} +
 	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga TAGS cscope.* *.pod *~ */*~
-	rm -f fsdev/*.pod
+	rm -f fsdev/*.pod scsi/*.pod
 	rm -f qemu-img-cmds.h
 	rm -f ui/shader/*-vert.h ui/shader/*-frag.h
 	@# May not be present in GENERATED_FILES
@@ -590,6 +595,7 @@ endif
 ifdef CONFIG_VIRTFS
 	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
 	$(INSTALL_DATA) fsdev/virtfs-proxy-helper.1 "$(DESTDIR)$(mandir)/man1"
+	$(INSTALL_DATA) scsi/qemu-pr-helper.8 "$(DESTDIR)$(mandir)/man8"
 endif
 
 install-datadir:
@@ -718,6 +724,7 @@ qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
 qemu.1: qemu-option-trace.texi
 qemu-img.1: qemu-img.texi qemu-option-trace.texi qemu-img-cmds.texi
 fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helper.texi
+scsi/qemu-pr-helper.8: scsi/qemu-pr-helper.texi
 qemu-nbd.8: qemu-nbd.texi qemu-option-trace.texi
 qemu-ga.8: qemu-ga.texi
 
diff --git a/configure b/configure
index dd73cce62f..772aff18d6 100755
--- a/configure
+++ b/configure
@@ -6545,7 +6545,7 @@ fi
 
 # build tree in object directory in case the source is not in the current directory
 DIRS="tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests/qapi-schema tests/tcg/xtensa tests/qemu-iotests"
-DIRS="$DIRS docs docs/interop fsdev"
+DIRS="$DIRS docs docs/interop fsdev scsi"
 DIRS="$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
 DIRS="$DIRS roms/seabios roms/vgabios"
 DIRS="$DIRS qapi-generated"
diff --git a/docs/interop/pr-helper.rst b/docs/interop/pr-helper.rst
new file mode 100644
index 0000000000..765174c31f
--- /dev/null
+++ b/docs/interop/pr-helper.rst
@@ -0,0 +1,78 @@
+..
+
+======================================
+Persistent reservation helper protocol
+======================================
+
+QEMU's SCSI passthrough devices, ``scsi-block`` and ``scsi-generic``,
+can delegate implementation of persistent reservations to an external
+(and typically privilege) program.  Persistent Reservations allow
+restricting access to block devices to specific initiators in a shared
+storage setup.
+
+For a more detailed reference please refer the the SCSI Primary
+Commands standard, specifically the section on Reservations and the
+"PERSISTENT RESERVE IN" and "PERSISTENT RESERVE OUT" commands.
+
+This document describes the socket protocol used between QEMU's
+``pr-manager-helper`` object and the external program.
+
+.. contents::
+
+Connection and initialization
+-----------------------------
+
+After connecting to the helper program's socket, the helper starts a simple
+feature negotiation process by writing four bytes corresponding to
+the features it exposes (``supported_features``).  QEMU also writes
+four bytes corresponding to the desired features of the helper program
+(``requested_features``).
+
+If a bit is 1 in ``requested_features`` and 0 in ``supported_features``,
+the corresponding feature is not supported by the helper and the connection
+is closed.  On the other hand, it is acceptable for a bit to be 0 in
+``requested_features`` and 1 in ``supported_features``; in this case,
+he helper will not enable the feature.
+
+Right now no feature is defined, so the two parts always write four
+zero bytes.
+
+All data transmitted on the socket is big-endian.
+
+Command format
+--------------
+
+A command consists of a request and a response.  A request consists
+of a 16-byte SCSI CDB.  A file descriptor must be passed to the helper
+together with the SCSI CDB using ancillary data.
+
+The CDB has the following limitations:
+
+- the command (stored in the first byte) must be one of 0x5E
+  (PERSISTENT RESERVE IN) or 0x5F (PERSISTENT RESERVE OUT).
+
+- the allocation length (stored in bytes 7-8 of the CDB for PERSISTENT
+  RESERVE IN) or parameter list length (stored in bytes 5-8 of the CDB
+  for PERSISTENT RESERVE OUT) is limited to 8 KiB.
+
+For PERSISTENT RESERVE OUT, the parameter list is sent right after the
+CDB.
+
+The helper's reply has the following fixed structure:
+
+- 4 bytes for the SCSI status
+
+- 96 bytes for the SCSI sense data
+
+The sense data is always sent to keep the protocol simple, even though
+it is only valid if the SCSI status is CHECK CONDITION (0x02).
+
+For PERSISTENT RESERVE IN, the data is sent right after the sense
+data if the SCSI status is GOOD (0x00).
+
+It is invalid to send multiple commands concurrently on the same
+socket.  It is however possible to connect multiple sockets to the
+helper and send multiple commands to the helper for one or more
+file descriptors.
+
+If the protocol is violated, the helper closes the socket.
diff --git a/docs/pr-manager.rst b/docs/pr-manager.rst
index b6089fb57c..7107e59fb8 100644
--- a/docs/pr-manager.rst
+++ b/docs/pr-manager.rst
@@ -49,3 +49,36 @@ Alternatively, using ``-blockdev``::
           -object pr-manager-helper,id=helper0,path=/var/run/qemu-pr-helper.sock
           -blockdev node-name=hd,driver=raw,file.driver=host_device,file.filename=/dev/sdb,file.pr-manager=helper0
           -device scsi-block,drive=hd
+
+----------------------------------
+Invoking :program:`qemu-pr-helper`
+----------------------------------
+
+QEMU provides an implementation of the persistent reservation helper,
+called :program:`qemu-pr-helper`.  The helper should be started as a
+system service and supports the following option:
+
+-d, --daemon              run in the background
+-q, --quiet               decrease verbosity
+-f, --pidfile=path        PID file when running as a daemon
+-k, --socket=path         path to the socket
+-T, --trace=trace-opts    tracing options
+
+By default, the socket and PID file are placed in the runtime state
+directory, for example :file:`/var/run/qemu-pr-helper.sock` and
+:file:`/var/run/qemu-pr-helper.pid`.  The PID file is not created
+unless :option:`-d` is passed too.
+
+:program:`qemu-pr-helper` can also use the systemd socket activation
+protocol.  In this case, the systemd socket unit should specify a
+Unix stream socket, like this::
+
+    [Socket]
+    ListenStream=/var/run/qemu-pr-helper.sock
+
+After connecting to the socket, :program:`qemu-pr-helper`` can optionally drop
+root privileges, except for those capabilities that are needed for
+its operation.  To do this, add the following options:
+
+-u, --user=user           user to drop privileges to
+-g, --group=group         group to drop privileges to
diff --git a/scsi/pr-helper.h b/scsi/pr-helper.h
new file mode 100644
index 0000000000..2c7ccc9928
--- /dev/null
+++ b/scsi/pr-helper.h
@@ -0,0 +1,13 @@
+#ifndef QEMU_PR_HELPER_H
+#define QEMU_PR_HELPER_H 1
+
+#define PR_HELPER_CDB_SIZE     16
+#define PR_HELPER_SENSE_SIZE   96
+#define PR_HELPER_DATA_SIZE    8192
+
+typedef struct PRHelperResponse {
+    int32_t result;
+    uint8_t sense[PR_HELPER_SENSE_SIZE];
+} PRHelperResponse;
+
+#endif
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
new file mode 100644
index 0000000000..d52234af0f
--- /dev/null
+++ b/scsi/qemu-pr-helper.c
@@ -0,0 +1,657 @@
+/*
+ * Helper to forward persistent reservation commands to libmpathpersist
+ *
+ * Copyright (C) 2017 Red Hat, Inc. <pbonzini@redhat.com>
+ *
+ * Author: Paolo Bonzini <pbonzini@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; under version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include <getopt.h>
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "qemu/cutils.h"
+#include "qemu/main-loop.h"
+#include "qemu/error-report.h"
+#include "qemu/config-file.h"
+#include "qemu/bswap.h"
+#include "qemu/log.h"
+#include "qemu/systemd.h"
+#include "qapi/util.h"
+#include "qapi/qmp/qstring.h"
+#include "io/channel-socket.h"
+#include "trace/control.h"
+#include "qemu-version.h"
+
+#include "block/aio.h"
+#include "block/thread-pool.h"
+
+#include "scsi/constants.h"
+#include "scsi/utils.h"
+#include "pr-helper.h"
+#include <sys/ioctl.h>
+#include <linux/dm-ioctl.h>
+#include <scsi/sg.h>
+
+#ifdef CONFIG_LIBCAP
+#include <cap-ng.h>
+#endif
+#include <pwd.h>
+#include <grp.h>
+
+
+#define PR_OUT_FIXED_PARAM_SIZE 24
+
+static char *socket_path;
+static char *pidfile;
+static enum { RUNNING, TERMINATE, TERMINATING } state;
+static QIOChannelSocket *server_ioc;
+static int server_watch;
+static int num_active_sockets = 1;
+static int verbose;
+
+#ifdef CONFIG_LIBCAP
+static int uid = -1;
+static int gid = -1;
+#endif
+
+static void usage(const char *name)
+{
+    (printf) (
+"Usage: %s [OPTIONS] FILE\n"
+"Persistent Reservation helper program for QEMU\n"
+"\n"
+"  -h, --help                display this help and exit\n"
+"  -V, --version             output version information and exit\n"
+"\n"
+"  -d, --daemon              run in the background\n"
+"  -f, --pidfile=PATH        PID file when running as a daemon\n"
+"                            (default '%s')\n"
+"  -k, --socket=PATH         path to the unix socket\n"
+"                            (default '%s')\n"
+"  -T, --trace [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
+"                            specify tracing options\n"
+#ifdef CONFIG_LIBCAP
+"  -u, --user=USER           user to drop privileges to\n"
+"  -g, --group=GROUP         group to drop privileges to\n"
+#endif
+"\n"
+QEMU_HELP_BOTTOM "\n"
+    , name, pidfile, socket_path);
+}
+
+static void version(const char *name)
+{
+    printf(
+"%s " QEMU_VERSION QEMU_PKGVERSION "\n"
+"Written by Paolo Bonzini.\n"
+"\n"
+QEMU_COPYRIGHT "\n"
+"This is free software; see the source for copying conditions.  There is NO\n"
+"warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.\n"
+    , name);
+}
+
+/* SG_IO support */
+
+typedef struct PRHelperSGIOData {
+    int fd;
+    const uint8_t *cdb;
+    uint8_t *sense;
+    uint8_t *buf;
+    int sz;
+    int dir;
+} PRHelperSGIOData;
+
+static int do_sgio_worker(void *opaque)
+{
+    PRHelperSGIOData *data = opaque;
+    struct sg_io_hdr io_hdr;
+    int ret;
+    int status;
+    SCSISense sense_code;
+
+    memset(data->sense, 0, PR_HELPER_SENSE_SIZE);
+    memset(&io_hdr, 0, sizeof(io_hdr));
+    io_hdr.interface_id = 'S';
+    io_hdr.cmd_len = PR_HELPER_CDB_SIZE;
+    io_hdr.cmdp = (uint8_t *)data->cdb;
+    io_hdr.sbp = data->sense;
+    io_hdr.mx_sb_len = PR_HELPER_SENSE_SIZE;
+    io_hdr.timeout = 1;
+    io_hdr.dxfer_direction = data->dir;
+    io_hdr.dxferp = (char *)data->buf;
+    io_hdr.dxfer_len = data->sz;
+    ret = ioctl(data->fd, SG_IO, &io_hdr);
+    status = sg_io_sense_from_errno(ret < 0 ? errno : 0, &io_hdr,
+                                    &sense_code);
+    if (status == CHECK_CONDITION &&
+        !(io_hdr.driver_status & SG_ERR_DRIVER_SENSE)) {
+        scsi_build_sense(data->sense, sense_code);
+    }
+
+    return status;
+}
+
+static int do_sgio(int fd, const uint8_t *cdb, uint8_t *sense,
+                    uint8_t *buf, int sz, int dir)
+{
+    ThreadPool *pool = aio_get_thread_pool(qemu_get_aio_context());
+
+    PRHelperSGIOData data = {
+        .fd = fd,
+        .cdb = cdb,
+        .sense = sense,
+        .buf = buf,
+        .sz = sz,
+        .dir = dir,
+    };
+
+    return thread_pool_submit_co(pool, do_sgio_worker, &data);
+}
+
+static int do_pr_in(int fd, const uint8_t *cdb, uint8_t *sense,
+                    uint8_t *data, int sz)
+{
+    return do_sgio(fd, cdb, sense, data, sz,
+                   SG_DXFER_FROM_DEV);
+}
+
+static int do_pr_out(int fd, const uint8_t *cdb, uint8_t *sense,
+                     const uint8_t *param, int sz)
+{
+    return do_sgio(fd, cdb, sense, (uint8_t *)param, sz,
+                   SG_DXFER_TO_DEV);
+}
+
+/* Client */
+
+typedef struct PRHelperClient {
+    QIOChannelSocket *ioc;
+    Coroutine *co;
+    int fd;
+    uint8_t data[PR_HELPER_DATA_SIZE];
+} PRHelperClient;
+
+typedef struct PRHelperRequest {
+    int fd;
+    size_t sz;
+    uint8_t cdb[PR_HELPER_CDB_SIZE];
+} PRHelperRequest;
+
+static int prh_read(PRHelperClient *client, void *buf, int sz, Error **errp)
+{
+    while (sz > 0) {
+        int *fds = NULL;
+        size_t nfds = 0;
+        int i;
+        struct iovec iov;
+        ssize_t n_read;
+
+        iov.iov_base = buf;
+        iov.iov_len = sz;
+        n_read = qio_channel_readv_full(QIO_CHANNEL(client->ioc), &iov, 1,
+                                        &fds, &nfds, errp);
+
+        if (n_read == QIO_CHANNEL_ERR_BLOCK) {
+            qio_channel_yield(QIO_CHANNEL(client->ioc), G_IO_IN);
+            continue;
+        }
+        if (n_read <= 0) {
+            return n_read ? n_read : -1;
+        }
+
+        /* Stash one file descriptor per request.  */
+        if (nfds) {
+            for (i = 0; i < nfds; i++) {
+                if (client->fd == -1) {
+                    client->fd = fds[i++];
+                } else {
+                    close(fds[i]);
+                }
+            }
+            g_free(fds);
+        }
+
+        buf += n_read;
+        sz -= n_read;
+    }
+
+    return 0;
+}
+
+static int prh_read_request(PRHelperClient *client, PRHelperRequest *req,
+                            PRHelperResponse *resp, Error **errp)
+{
+    uint32_t sz;
+
+    if (prh_read(client, req->cdb, sizeof(req->cdb), NULL) < 0) {
+        return -1;
+    }
+
+    if (client->fd == -1) {
+        error_setg(errp, "No file descriptor in request.");
+        return -1;
+    }
+
+    if (req->cdb[0] != PERSISTENT_RESERVE_OUT &&
+        req->cdb[0] != PERSISTENT_RESERVE_IN) {
+        error_setg(errp, "Invalid CDB, closing socket.");
+        goto out_close;
+    }
+
+    sz = scsi_cdb_xfer(req->cdb);
+    if (sz > sizeof(client->data)) {
+        goto out_close;
+    }
+
+    if (req->cdb[0] == PERSISTENT_RESERVE_OUT) {
+        if (qio_channel_read_all(QIO_CHANNEL(client->ioc),
+                                 (char *)client->data, sz,
+                                 errp) < 0) {
+            goto out_close;
+        }
+        if (sz < PR_OUT_FIXED_PARAM_SIZE) {
+            /* Illegal request, Parameter list length error.  Not a fatal
+             * error, so read the data and do not close the socket.
+            */
+            scsi_build_sense(resp->sense, SENSE_CODE(INVALID_PARAM_LEN));
+            resp->result = CHECK_CONDITION;
+            sz = 0;
+            close(client->fd);
+            client->fd = -1;
+        }
+    }
+
+    req->fd = client->fd;
+    req->sz = sz;
+    client->fd = -1;
+    return sz;
+
+out_close:
+    close(client->fd);
+    client->fd = -1;
+    return -1;
+}
+
+static int prh_write_response(PRHelperClient *client, PRHelperRequest *req,
+                              PRHelperResponse *resp, Error **errp)
+{
+    ssize_t r;
+
+    resp->result = cpu_to_be32(resp->result);
+    r = qio_channel_write_all(QIO_CHANNEL(client->ioc),
+                              (char *) resp, sizeof(*resp), errp);
+    if (r < 0) {
+        return r;
+    }
+
+    if (req->cdb[0] == PERSISTENT_RESERVE_IN && resp->result == GOOD) {
+        assert(req->sz <= sizeof(client->data));
+        r = qio_channel_write_all(QIO_CHANNEL(client->ioc),
+                                  (char *) client->data,
+                                  req->sz, errp);
+    }
+    return r < 0 ? r : 0;
+}
+
+static void prh_co_entry(void *opaque)
+{
+    PRHelperClient *client = opaque;
+    Error *local_err = NULL;
+    uint32_t flags;
+    int r;
+
+    qio_channel_set_blocking(QIO_CHANNEL(client->ioc),
+                             false, NULL);
+    qio_channel_attach_aio_context(QIO_CHANNEL(client->ioc),
+                                   qemu_get_aio_context());
+
+    /* A very simple negotiation for future extensibility.  No features
+     * are defined so write 0.
+     */
+    flags = cpu_to_be32(0);
+    r = qio_channel_write_all(QIO_CHANNEL(client->ioc),
+                             (char *) &flags, sizeof(flags), NULL);
+    if (r < 0) {
+        goto out;
+    }
+
+    r = qio_channel_read_all(QIO_CHANNEL(client->ioc),
+                             (char *) &flags, sizeof(flags), NULL);
+    if (be32_to_cpu(flags) != 0 || r < 0) {
+        goto out;
+    }
+
+    while (atomic_read(&state) == RUNNING) {
+        PRHelperRequest req;
+        PRHelperResponse resp;
+        int sz;
+
+        sz = prh_read_request(client, &req, &resp, &local_err);
+        if (sz < 0) {
+            break;
+        }
+
+        if (sz > 0) {
+            num_active_sockets++;
+            if (req.cdb[0] == PERSISTENT_RESERVE_OUT) {
+                r = do_pr_out(req.fd, req.cdb, resp.sense, client->data, sz);
+            } else {
+                r = do_pr_in(req.fd, req.cdb, resp.sense, client->data, sz);
+            }
+            num_active_sockets--;
+            close(req.fd);
+            if (r == -1) {
+                break;
+            }
+            resp.result = r;
+        }
+
+        if (prh_write_response(client, &req, &resp, &local_err) < 0) {
+            break;
+        }
+    }
+
+    if (local_err) {
+        if (verbose == 0) {
+            error_free(local_err);
+        } else {
+            error_report_err(local_err);
+        }
+    }
+
+out:
+    qio_channel_detach_aio_context(QIO_CHANNEL(client->ioc));
+    object_unref(OBJECT(client->ioc));
+    g_free(client);
+}
+
+static gboolean accept_client(QIOChannel *ioc, GIOCondition cond, gpointer opaque)
+{
+    QIOChannelSocket *cioc;
+    PRHelperClient *prh;
+
+    cioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
+                                     NULL);
+    if (!cioc) {
+        return TRUE;
+    }
+
+    prh = g_new(PRHelperClient, 1);
+    prh->ioc = cioc;
+    prh->fd = -1;
+    prh->co = qemu_coroutine_create(prh_co_entry, prh);
+    qemu_coroutine_enter(prh->co);
+
+    return TRUE;
+}
+
+
+/*
+ * Check socket parameters compatibility when socket activation is used.
+ */
+static const char *socket_activation_validate_opts(void)
+{
+    if (socket_path != NULL) {
+        return "Unix socket can't be set when using socket activation";
+    }
+
+    return NULL;
+}
+
+static void compute_default_paths(void)
+{
+    socket_path = qemu_get_local_state_pathname("run/qemu-pr-helper.sock");
+    pidfile = qemu_get_local_state_pathname("run/qemu-pr-helper.pid");
+}
+
+static void termsig_handler(int signum)
+{
+    atomic_cmpxchg(&state, RUNNING, TERMINATE);
+    qemu_notify_event();
+}
+
+static void close_server_socket(void)
+{
+    g_assert(server_ioc);
+
+    g_source_remove(server_watch);
+    server_watch = -1;
+    object_unref(OBJECT(server_ioc));
+    num_active_sockets--;
+}
+
+#ifdef CONFIG_LIBCAP
+static int drop_privileges(void)
+{
+    /* clear all capabilities */
+    capng_clear(CAPNG_SELECT_BOTH);
+
+    if (capng_update(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED,
+                     CAP_SYS_RAWIO) < 0) {
+        return -1;
+    }
+
+    /* Change user/group id, retaining the capabilities.  Because file descriptors
+     * are passed via SCM_RIGHTS, we don't need supplementary groups (and in
+     * fact the helper can run as "nobody").
+     */
+    if (capng_change_id(uid != -1 ? uid : getuid(),
+                        gid != -1 ? gid : getgid(),
+                        CAPNG_DROP_SUPP_GRP | CAPNG_CLEAR_BOUNDING)) {
+        return -1;
+    }
+
+    return 0;
+}
+#endif
+
+int main(int argc, char **argv)
+{
+    const char *sopt = "hVk:fdT:u:g:q";
+    struct option lopt[] = {
+        { "help", no_argument, NULL, 'h' },
+        { "version", no_argument, NULL, 'V' },
+        { "socket", required_argument, NULL, 'k' },
+        { "pidfile", no_argument, NULL, 'f' },
+        { "daemon", no_argument, NULL, 'd' },
+        { "trace", required_argument, NULL, 'T' },
+        { "user", required_argument, NULL, 'u' },
+        { "group", required_argument, NULL, 'g' },
+        { "quiet", no_argument, NULL, 'q' },
+        { NULL, 0, NULL, 0 }
+    };
+    int opt_ind = 0;
+    int quiet = 0;
+    char ch;
+    Error *local_err = NULL;
+    char *trace_file = NULL;
+    bool daemonize = false;
+    unsigned socket_activation;
+
+    struct sigaction sa_sigterm;
+    memset(&sa_sigterm, 0, sizeof(sa_sigterm));
+    sa_sigterm.sa_handler = termsig_handler;
+    sigaction(SIGTERM, &sa_sigterm, NULL);
+    sigaction(SIGINT, &sa_sigterm, NULL);
+    sigaction(SIGHUP, &sa_sigterm, NULL);
+
+    signal(SIGPIPE, SIG_IGN);
+
+    compute_default_paths();
+
+    module_call_init(MODULE_INIT_TRACE);
+    module_call_init(MODULE_INIT_QOM);
+    qemu_add_opts(&qemu_trace_opts);
+    qemu_init_exec_dir(argv[0]);
+
+    while ((ch = getopt_long(argc, argv, sopt, lopt, &opt_ind)) != -1) {
+        switch (ch) {
+        case 'k':
+            socket_path = optarg;
+            if (socket_path[0] != '/') {
+                error_report("socket path must be absolute");
+                exit(EXIT_FAILURE);
+            }
+            break;
+        case 'f':
+            pidfile = optarg;
+            break;
+#ifdef CONFIG_LIBCAP
+        case 'u': {
+            unsigned long res;
+            struct passwd *userinfo = getpwnam(optarg);
+            if (userinfo) {
+                uid = userinfo->pw_uid;
+            } else if (qemu_strtoul(optarg, NULL, 10, &res) == 0 &&
+                       (uid_t)res == res) {
+                uid = res;
+            } else {
+                error_report("invalid user '%s'", optarg);
+                exit(EXIT_FAILURE);
+            }
+            break;
+        }
+        case 'g': {
+            unsigned long res;
+            struct group *groupinfo = getgrnam(optarg);
+            if (groupinfo) {
+                gid = groupinfo->gr_gid;
+            } else if (qemu_strtoul(optarg, NULL, 10, &res) == 0 &&
+                       (gid_t)res == res) {
+                gid = res;
+            } else {
+                error_report("invalid group '%s'", optarg);
+                exit(EXIT_FAILURE);
+            }
+            break;
+        }
+#else
+        case 'u':
+        case 'g':
+            error_report("-%c not supported by this %s", ch, argv[0]);
+            exit(1);
+#endif
+        case 'd':
+            daemonize = true;
+            break;
+        case 'q':
+            quiet = 1;
+            break;
+        case 'T':
+            g_free(trace_file);
+            trace_file = trace_opt_parse(optarg);
+            break;
+        case 'V':
+            version(argv[0]);
+            exit(0);
+            break;
+        case 'h':
+            usage(argv[0]);
+            exit(0);
+            break;
+        case '?':
+            error_report("Try `%s --help' for more information.", argv[0]);
+            exit(EXIT_FAILURE);
+        }
+    }
+
+    /* set verbosity */
+    verbose = !quiet;
+
+    if (!trace_init_backends()) {
+        exit(1);
+    }
+    trace_init_file(trace_file);
+    qemu_set_log(LOG_TRACE);
+
+#ifdef CONFIG_MPATH
+    dm_init();
+    multipath_pr_init();
+#endif
+
+    socket_activation = check_socket_activation();
+    if (socket_activation == 0) {
+        SocketAddress saddr = {
+            .type = SOCKET_ADDRESS_TYPE_UNIX,
+            .u.q_unix.path = g_strdup(socket_path)
+        };
+        server_ioc = qio_channel_socket_new();
+        if (qio_channel_socket_listen_sync(server_ioc, &saddr, &local_err) < 0) {
+            object_unref(OBJECT(server_ioc));
+            error_report_err(local_err);
+            return 1;
+        }
+        g_free(saddr.u.q_unix.path);
+    } else {
+        /* Using socket activation - check user didn't use -p etc. */
+        const char *err_msg = socket_activation_validate_opts();
+        if (err_msg != NULL) {
+            error_report("%s", err_msg);
+            exit(EXIT_FAILURE);
+        }
+
+        /* Can only listen on a single socket.  */
+        if (socket_activation > 1) {
+            error_report("%s does not support socket activation with LISTEN_FDS > 1",
+                         argv[0]);
+            exit(EXIT_FAILURE);
+        }
+        server_ioc = qio_channel_socket_new_fd(FIRST_SOCKET_ACTIVATION_FD,
+                                               &local_err);
+        if (server_ioc == NULL) {
+            error_report("Failed to use socket activation: %s",
+                         error_get_pretty(local_err));
+            exit(EXIT_FAILURE);
+        }
+        socket_path = NULL;
+    }
+
+    if (qemu_init_main_loop(&local_err)) {
+        error_report_err(local_err);
+        exit(EXIT_FAILURE);
+    }
+
+    server_watch = qio_channel_add_watch(QIO_CHANNEL(server_ioc),
+                                         G_IO_IN,
+                                         accept_client,
+                                         NULL, NULL);
+
+#ifdef CONFIG_LIBCAP
+    if (drop_privileges() < 0) {
+        error_report("Failed to drop privileges: %s", strerror(errno));
+        exit(EXIT_FAILURE);
+    }
+#endif
+
+    if (daemonize) {
+        if (daemon(0, 0) < 0) {
+            error_report("Failed to daemonize: %s", strerror(errno));
+            exit(EXIT_FAILURE);
+        }
+    }
+
+    state = RUNNING;
+    do {
+        main_loop_wait(false);
+        if (state == TERMINATE) {
+            state = TERMINATING;
+            close_server_socket();
+        }
+    } while (num_active_sockets > 0);
+
+    exit(EXIT_SUCCESS);
+}
-- 
2.13.5
