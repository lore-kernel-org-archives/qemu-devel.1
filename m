Received: from eggs.gnu.org ([2001:4830:134:3::10]:54079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dYGsT-0007J7-Vw
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:12:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dYGsP-0007mq-JE
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:12:49 -0400
Received: from ivanoab5.miniserver.com ([78.31.111.25]:42619
	helo=www.kot-begemot.co.uk)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1dYGsP-0007mQ-8s
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:12:45 -0400
From: anton.ivanov@cambridgegreys.com
Date: Thu, 20 Jul 2017 20:12:24 +0100
Message-Id: <20170720191228.12342-2-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20170720191228.12342-1-anton.ivanov@cambridgegreys.com>
References: <20170720191228.12342-1-anton.ivanov@cambridgegreys.com>
Subject: [Qemu-devel] [PATCH v2 1/5] Unified Datagram Socket Transports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Basic infrastructure to start moving datagram based transports
to a common infrastructure as well as introduce several
additional transports.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 configure         |  12 +-
 net/Makefile.objs |   2 +-
 net/net.c         |   4 +-
 net/udst.c        | 420 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 net/udst.h        | 121 ++++++++++++++++
 qapi-schema.json  |  19 ++-
 qemu-options.hx   |   2 +-
 7 files changed, 569 insertions(+), 11 deletions(-)
 create mode 100644 net/udst.c
 create mode 100644 net/udst.h

diff --git a/configure b/configure
index bad50f5368..00c911c49b 100755
--- a/configure
+++ b/configure
@@ -1862,7 +1862,9 @@ if ! compile_object -Werror ; then
 fi
 
 ##########################################
-# L2TPV3 probe
+# UDST probe
+# identical to L2TPv3 probe used for both
+# during migration of L2TPv3 to udst backend
 
 cat > $TMPC <<EOF
 #include <sys/socket.h>
@@ -1870,9 +1872,9 @@ cat > $TMPC <<EOF
 int main(void) { return sizeof(struct mmsghdr); }
 EOF
 if compile_prog "" "" ; then
-  l2tpv3=yes
+  udst=yes
 else
-  l2tpv3=no
+  udst=no
 fi
 
 ##########################################
@@ -5491,8 +5493,8 @@ fi
 if test "$netmap" = "yes" ; then
   echo "CONFIG_NETMAP=y" >> $config_host_mak
 fi
-if test "$l2tpv3" = "yes" ; then
-  echo "CONFIG_L2TPV3=y" >> $config_host_mak
+if test "$udst" = "yes" ; then
+  echo "CONFIG_UDST=y" >> $config_host_mak
 fi
 if test "$cap_ng" = "yes" ; then
   echo "CONFIG_LIBCAP=y" >> $config_host_mak
diff --git a/net/Makefile.objs b/net/Makefile.objs
index 67ba5e26fb..ffdfb96bd0 100644
--- a/net/Makefile.objs
+++ b/net/Makefile.objs
@@ -2,7 +2,7 @@ common-obj-y = net.o queue.o checksum.o util.o hub.o
 common-obj-y += socket.o
 common-obj-y += dump.o
 common-obj-y += eth.o
-common-obj-$(CONFIG_L2TPV3) += l2tpv3.o
+common-obj-$(CONFIG_UDST) += udst.o l2tpv3.o
 common-obj-$(CONFIG_POSIX) += vhost-user.o
 common-obj-$(CONFIG_SLIRP) += slirp.o
 common-obj-$(CONFIG_VDE) += vde.o
diff --git a/net/net.c b/net/net.c
index 0e28099554..723a256260 100644
--- a/net/net.c
+++ b/net/net.c
@@ -960,8 +960,8 @@ static int (* const net_client_init_fun[NET_CLIENT_DRIVER__MAX])(
 #ifdef CONFIG_VHOST_NET_USED
         [NET_CLIENT_DRIVER_VHOST_USER] = net_init_vhost_user,
 #endif
-#ifdef CONFIG_L2TPV3
-        [NET_CLIENT_DRIVER_L2TPV3]    = net_init_l2tpv3,
+#ifdef CONFIG_UDST
+        [NET_CLIENT_DRIVER_L2TPV3] = net_init_l2tpv3,
 #endif
 };
 
diff --git a/net/udst.c b/net/udst.c
new file mode 100644
index 0000000000..612c90cb3a
--- /dev/null
+++ b/net/udst.c
@@ -0,0 +1,420 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2015-2017 Cambridge Greys Limited
+ * Copyright (c) 2012-2014 Cisco Systems
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+/*
+ * Udst Datagram Socket Transport Backend
+ * This transport is not intended to be initiated directly by an end-user
+ * It is used as a backend for other transports which use recv/sendmmsg
+ * socket functions for RX/TX.
+ */
+
+#include "qemu/osdep.h"
+#include <linux/ip.h>
+#include <netdb.h>
+#include "net/net.h"
+#include "clients.h"
+#include "qemu-common.h"
+#include "qemu/error-report.h"
+#include "qemu/option.h"
+#include "qemu/sockets.h"
+#include "qemu/iov.h"
+#include "qemu/main-loop.h"
+#include "udst.h"
+
+static void net_udst_send(void *opaque);
+static void udst_writable(void *opaque);
+
+static void udst_update_fd_handler(NetUdstState *s)
+{
+    qemu_set_fd_handler(s->fd,
+                        s->read_poll ? net_udst_send : NULL,
+                        s->write_poll ? udst_writable : NULL,
+                        s);
+}
+
+static void udst_read_poll(NetUdstState *s, bool enable)
+{
+    if (s->read_poll != enable) {
+        s->read_poll = enable;
+        udst_update_fd_handler(s);
+    }
+}
+
+static void udst_write_poll(NetUdstState *s, bool enable)
+{
+    if (s->write_poll != enable) {
+        s->write_poll = enable;
+        udst_update_fd_handler(s);
+    }
+}
+
+static void udst_writable(void *opaque)
+{
+    NetUdstState *s = opaque;
+    udst_write_poll(s, false);
+    qemu_flush_queued_packets(&s->nc);
+}
+
+static void udst_send_completed(NetClientState *nc, ssize_t len)
+{
+    NetUdstState *s = DO_UPCAST(NetUdstState, nc, nc);
+    udst_read_poll(s, true);
+}
+
+static void udst_poll(NetClientState *nc, bool enable)
+{
+    NetUdstState *s = DO_UPCAST(NetUdstState, nc, nc);
+    udst_write_poll(s, enable);
+    udst_read_poll(s, enable);
+}
+
+static ssize_t net_udst_receive_dgram_iov(NetClientState *nc,
+                    const struct iovec *iov,
+                    int iovcnt)
+{
+    NetUdstState *s = DO_UPCAST(NetUdstState, nc, nc);
+
+    struct msghdr message;
+    int ret;
+
+    if (iovcnt > MAX_UNIFIED_IOVCNT - 1) {
+        error_report(
+            "iovec too long %d > %d, change udst.h",
+            iovcnt, MAX_UNIFIED_IOVCNT
+        );
+        return -1;
+    }
+    if (s->offset > 0) {
+        s->form_header(s);
+        memcpy(s->vec + 1, iov, iovcnt * sizeof(struct iovec));
+        s->vec->iov_base = s->header_buf;
+        s->vec->iov_len = s->offset;
+        message.msg_iovlen = iovcnt + 1;
+    } else {
+        memcpy(s->vec, iov, iovcnt * sizeof(struct iovec));
+        message.msg_iovlen = iovcnt;
+    }
+    message.msg_name = s->dgram_dst;
+    message.msg_namelen = s->dst_size;
+    message.msg_iov = s->vec;
+    message.msg_control = NULL;
+    message.msg_controllen = 0;
+    message.msg_flags = 0;
+    do {
+        ret = sendmsg(s->fd, &message, 0);
+    } while ((ret == -1) && (errno == EINTR));
+    if (ret > 0) {
+        ret -= s->offset;
+    } else if (ret == 0) {
+        /* belt and braces - should not occur on DGRAM
+        * we should get an error and never a 0 send
+        */
+        ret = iov_size(iov, iovcnt);
+    } else {
+        /* signal upper layer that socket buffer is full */
+        ret = -errno;
+        if (ret == -EAGAIN || ret == -ENOBUFS) {
+            udst_write_poll(s, true);
+            ret = 0;
+        }
+    }
+    return ret;
+}
+
+static ssize_t net_udst_receive_dgram(NetClientState *nc,
+                    const uint8_t *buf,
+                    size_t size)
+{
+    NetUdstState *s = DO_UPCAST(NetUdstState, nc, nc);
+
+    struct iovec *vec;
+    struct msghdr message;
+    ssize_t ret = 0;
+
+    vec = s->vec;
+    if (s->offset > 0) {
+        s->form_header(s);
+        vec->iov_base = s->header_buf;
+        vec->iov_len = s->offset;
+        message.msg_iovlen = 2;
+        vec++;
+    } else {
+        message.msg_iovlen = 1;
+    }
+    vec->iov_base = (void *) buf;
+    vec->iov_len = size;
+    message.msg_name = s->dgram_dst;
+    message.msg_namelen = s->dst_size;
+    message.msg_iov = s->vec;
+    message.msg_control = NULL;
+    message.msg_controllen = 0;
+    message.msg_flags = 0;
+    do {
+        ret = sendmsg(s->fd, &message, 0);
+    } while ((ret == -1) && (errno == EINTR));
+    if (ret > 0) {
+        ret -= s->offset;
+    } else if (ret == 0) {
+        /* belt and braces - should not occur on DGRAM
+        * we should get an error and never a 0 send
+        */
+        ret = size;
+    } else {
+        ret = -errno;
+        if (ret == -EAGAIN || ret == -ENOBUFS) {
+            /* signal upper layer that socket buffer is full */
+            udst_write_poll(s, true);
+            ret = 0;
+        }
+    }
+    return ret;
+}
+
+
+static void net_udst_process_queue(NetUdstState *s)
+{
+    int size = 0;
+    struct iovec *vec;
+    bool bad_read;
+    int data_size;
+    struct mmsghdr *msgvec;
+
+    /* go into ring mode only if there is a "pending" tail */
+    if (s->queue_depth > 0) {
+        do {
+            msgvec = s->msgvec + s->queue_tail;
+            if (msgvec->msg_len > 0) {
+                data_size = msgvec->msg_len - s->header_size;
+                vec = msgvec->msg_hdr.msg_iov;
+                if ((data_size > 0) &&
+                    (s->verify_header(s, vec->iov_base) == 0)) {
+                    if (s->header_size > 0) {
+                        vec++;
+                    }
+                    /* Use the legacy delivery for now, we will
+                     * switch to using our own ring as a queueing mechanism
+                     * at a later date
+                     */
+                    size = qemu_send_packet_async(
+                            &s->nc,
+                            vec->iov_base,
+                            data_size,
+                            udst_send_completed
+                        );
+                    if (size == 0) {
+                        udst_read_poll(s, false);
+                    }
+                    bad_read = false;
+                } else {
+                    bad_read = true;
+                    if (!s->header_mismatch) {
+                        /* report error only once */
+                        error_report("udst header verification failed");
+                        s->header_mismatch = true;
+                    }
+                }
+            } else {
+                bad_read = true;
+            }
+            s->queue_tail = (s->queue_tail + 1) % MAX_UNIFIED_MSGCNT;
+            s->queue_depth--;
+        } while (
+                (s->queue_depth > 0) &&
+                 qemu_can_send_packet(&s->nc) &&
+                ((size > 0) || bad_read)
+            );
+    }
+}
+
+static void net_udst_send(void *opaque)
+{
+    NetUdstState *s = opaque;
+    int target_count, count;
+    struct mmsghdr *msgvec;
+
+    /* go into ring mode only if there is a "pending" tail */
+
+    if (s->queue_depth) {
+
+        /* The ring buffer we use has variable intake
+         * count of how much we can read varies - adjust accordingly
+         */
+
+        target_count = MAX_UNIFIED_MSGCNT - s->queue_depth;
+
+        /* Ensure we do not overrun the ring when we have
+         * a lot of enqueued packets
+         */
+
+        if (s->queue_head + target_count > MAX_UNIFIED_MSGCNT) {
+            target_count = MAX_UNIFIED_MSGCNT - s->queue_head;
+        }
+    } else {
+
+        /* we do not have any pending packets - we can use
+        * the whole message vector linearly instead of using
+        * it as a ring
+        */
+
+        s->queue_head = 0;
+        s->queue_tail = 0;
+        target_count = MAX_UNIFIED_MSGCNT;
+    }
+
+    msgvec = s->msgvec + s->queue_head;
+    if (target_count > 0) {
+        do {
+            count = recvmmsg(
+                s->fd,
+                msgvec,
+                target_count, MSG_DONTWAIT, NULL);
+        } while ((count == -1) && (errno == EINTR));
+        if (count < 0) {
+            /* Recv error - we still need to flush packets here,
+             * (re)set queue head to current position
+             */
+            count = 0;
+        }
+        s->queue_head = (s->queue_head + count) % MAX_UNIFIED_MSGCNT;
+        s->queue_depth += count;
+    }
+    net_udst_process_queue(s);
+}
+
+static void destroy_vector(struct mmsghdr *msgvec, int count, int iovcount)
+{
+    int i, j;
+    struct iovec *iov;
+    struct mmsghdr *cleanup = msgvec;
+    if (cleanup) {
+        for (i = 0; i < count; i++) {
+            if (cleanup->msg_hdr.msg_iov) {
+                iov = cleanup->msg_hdr.msg_iov;
+                for (j = 0; j < iovcount; j++) {
+                    g_free(iov->iov_base);
+                    iov++;
+                }
+                g_free(cleanup->msg_hdr.msg_iov);
+            }
+            cleanup++;
+        }
+        g_free(msgvec);
+    }
+}
+
+
+
+static struct mmsghdr *build_udst_vector(NetUdstState *s, int count)
+{
+    int i;
+    struct iovec *iov;
+    struct mmsghdr *msgvec, *result;
+
+    msgvec = g_new(struct mmsghdr, count);
+    result = msgvec;
+    for (i = 0; i < count ; i++) {
+        msgvec->msg_hdr.msg_name = NULL;
+        msgvec->msg_hdr.msg_namelen = 0;
+        iov =  g_new(struct iovec, IOVSIZE);
+        msgvec->msg_hdr.msg_iov = iov;
+        if (s->header_size > 0) {
+            iov->iov_base = g_malloc(s->header_size);
+            iov->iov_len = s->header_size;
+            iov++ ;
+        }
+        iov->iov_base = qemu_memalign(BUFFER_ALIGN, BUFFER_SIZE);
+        iov->iov_len = BUFFER_SIZE;
+        msgvec->msg_hdr.msg_iovlen = 2;
+        msgvec->msg_hdr.msg_control = NULL;
+        msgvec->msg_hdr.msg_controllen = 0;
+        msgvec->msg_hdr.msg_flags = 0;
+        msgvec++;
+    }
+    return result;
+}
+
+static void net_udst_cleanup(NetClientState *nc)
+{
+    NetUdstState *s = DO_UPCAST(NetUdstState, nc, nc);
+    qemu_purge_queued_packets(nc);
+    udst_read_poll(s, false);
+    udst_write_poll(s, false);
+    if (s->fd >= 0) {
+        close(s->fd);
+    }
+    if (s->header_size > 0) {
+        destroy_vector(s->msgvec, MAX_UNIFIED_MSGCNT, IOVSIZE);
+    } else {
+        destroy_vector(s->msgvec, MAX_UNIFIED_MSGCNT, 1);
+    }
+    g_free(s->vec);
+    if (s->header_buf != NULL) {
+        g_free(s->header_buf);
+    }
+    if (s->dgram_dst != NULL) {
+        g_free(s->dgram_dst);
+    }
+}
+
+static NetClientInfo net_udst_info = {
+    /* we share this one for all types for now, wrong I know :) */
+    .type = NET_CLIENT_DRIVER_UDST,
+    .size = sizeof(NetUdstState),
+    .receive = net_udst_receive_dgram,
+    .receive_iov = net_udst_receive_dgram_iov,
+    .poll = udst_poll,
+    .cleanup = net_udst_cleanup,
+};
+
+NetClientState *qemu_new_udst_net_client(const char *name,
+                    NetClientState *peer) {
+    return qemu_new_net_client(&net_udst_info, peer, "udst", name);
+}
+
+void qemu_net_finalize_udst_init(NetUdstState *s,
+        int (*verify_header)(void *s, uint8_t *buf),
+        void (*form_header)(void *s),
+        int fd)
+{
+
+    s->form_header = form_header;
+    s->verify_header = verify_header;
+    s->queue_head = 0;
+    s->queue_tail = 0;
+    s->header_mismatch = false;
+    s->msgvec = build_udst_vector(s, MAX_UNIFIED_MSGCNT);
+    s->vec = g_new(struct iovec, MAX_UNIFIED_IOVCNT);
+    if (s->header_size > 0) {
+        s->header_buf = g_malloc(s->header_size);
+    } else {
+        s->header_buf = NULL;
+    }
+    qemu_set_nonblock(fd);
+
+    s->fd = fd;
+    udst_read_poll(s, true);
+
+}
diff --git a/net/udst.h b/net/udst.h
new file mode 100644
index 0000000000..2a6b44c74d
--- /dev/null
+++ b/net/udst.h
@@ -0,0 +1,121 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2015-2017 Cambridge Greys Limited
+ * Copyright (c) 2012-2014 Cisco Systems
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+
+
+#define BUFFER_ALIGN sysconf(_SC_PAGESIZE)
+#define BUFFER_SIZE 2048
+#define IOVSIZE 2
+#define MAX_UNIFIED_MSGCNT 64
+#define MAX_UNIFIED_IOVCNT (MAX_UNIFIED_MSGCNT * IOVSIZE)
+
+#ifndef QEMU_NET_UNIFIED_H
+#define QEMU_NET_UNIFIED_H
+
+typedef struct NetUdstState {
+    NetClientState nc;
+
+    int fd;
+
+    /*
+     * these are used for xmit - that happens packet a time
+     * and for first sign of life packet (easier to parse that once)
+     */
+
+    uint8_t *header_buf;
+    struct iovec *vec;
+
+    /*
+     * these are used for receive - try to "eat" up to 32 packets at a time
+     */
+
+    struct mmsghdr *msgvec;
+
+    /*
+     * peer address
+     */
+
+    struct sockaddr_storage *dgram_dst;
+    uint32_t dst_size;
+
+    /*
+     * Internal Queue
+     */
+
+    /*
+    * DOS avoidance in error handling
+    */
+
+    /* Easier to keep l2tpv3 specific */
+
+    bool header_mismatch;
+
+    /*
+     *
+     * Ring buffer handling
+     *
+     */
+
+    int queue_head;
+    int queue_tail;
+    int queue_depth;
+
+    /*
+     * Offset to data - common for all protocols
+     */
+
+    uint32_t offset;
+
+    /*
+     * Header size - common for all protocols
+     */
+
+    uint32_t header_size;
+    /* Poll Control */
+
+    bool read_poll;
+    bool write_poll;
+
+    /* Parameters */
+
+    void *params;
+
+    /* header forming functions */
+
+    int (*verify_header)(void *s, uint8_t *buf);
+    void (*form_header)(void *s);
+
+} NetUdstState;
+
+extern NetClientState *qemu_new_udst_net_client(const char *name,
+                    NetClientState *peer);
+
+extern void qemu_net_finalize_udst_init(NetUdstState *s,
+        int (*verify_header)(void *s, uint8_t *buf),
+        void (*form_header)(void *s),
+        int fd);
+#endif
diff --git a/qapi-schema.json b/qapi-schema.json
index 8b015bee2e..62a044f006 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3854,6 +3854,18 @@
     '*offset':      'uint32' } }
 
 ##
+# @NetdevUdstOptions:
+#
+# Common Datagram backend for unified datagram
+# socket transports
+# Should not be instantiated directly
+
+# Since: 2.11
+##
+{ 'struct': 'NetdevUdstOptions',
+  'data': { } }
+
+##
 # @NetdevVdeOptions:
 #
 # Connect the VLAN to a vde switch running on the host.
@@ -3971,7 +3983,7 @@
 ##
 { 'enum': 'NetClientDriver',
   'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde', 'dump',
-            'bridge', 'hubport', 'netmap', 'vhost-user' ] }
+            'bridge', 'hubport', 'netmap', 'vhost-user', 'udst' ] }
 
 ##
 # @Netdev:
@@ -3985,6 +3997,8 @@
 # Since: 1.2
 #
 # 'l2tpv3' - since 2.1
+#
+# 'udst' - since 2.11
 ##
 { 'union': 'Netdev',
   'base': { 'id': 'str', 'type': 'NetClientDriver' },
@@ -4001,7 +4015,8 @@
     'bridge':   'NetdevBridgeOptions',
     'hubport':  'NetdevHubPortOptions',
     'netmap':   'NetdevNetmapOptions',
-    'vhost-user': 'NetdevVhostUserOptions' } }
+    'vhost-user': 'NetdevVhostUserOptions',
+    'udst':     'NetdevUdstOptions' } }
 
 ##
 # @NetLegacy:
diff --git a/qemu-options.hx b/qemu-options.hx
index 746b5fa75d..9caf53fd76 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1945,7 +1945,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "                connected to a bridge (default=" DEFAULT_BRIDGE_INTERFACE ")\n"
     "                using the program 'helper (default=" DEFAULT_BRIDGE_HELPER ")\n"
 #endif
-#ifdef __linux__
+#ifdef CONFIG_UDST
     "-netdev l2tpv3,id=str,src=srcaddr,dst=dstaddr[,srcport=srcport][,dstport=dstport]\n"
     "         [,rxsession=rxsession],txsession=txsession[,ipv6=on/off][,udp=on/off]\n"
     "         [,cookie64=on/off][,counter][,pincounter][,txcookie=txcookie]\n"
-- 
2.11.0
