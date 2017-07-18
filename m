Received: from eggs.gnu.org ([2001:4830:134:3::10]:55979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dXLer-0000ed-9i
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dXLel-0001bF-Rr
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:06:57 -0400
Received: from ivanoab5.miniserver.com ([78.31.111.25]:42296
	helo=www.kot-begemot.co.uk)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1dXLel-0001Zt-DC
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:06:51 -0400
From: anton.ivanov@cambridgegreys.com
Date: Tue, 18 Jul 2017 07:06:27 +0100
Message-Id: <20170718060627.2107-1-anton.ivanov@cambridgegreys.com>
Subject: [Qemu-devel] [PATCH] Unified Socket Transport
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

1. Creates a common recvmmsg backend for socket transports
2. Migrates L2TPv3 to the new backend
3. Adds gre socket transport - a vm can attach directly to GRE
4. Adds raw socket transport - a vm can attach directly to an
Ethernet interface
5. Adds simplistic static VXLAN tunnel transport (no
control plane).
6. Sets up some of the infrastructure for future addition of
sendmmsg

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 configure          |  10 +-
 net/Makefile.objs  |   2 +-
 net/clients.h      |   8 +
 net/gre.c          | 314 +++++++++++++++++++++++++++++++
 net/l2tpv3.c       | 531 ++++++++---------------------------------------------
 net/net.c          |  19 +-
 net/queue.c        |  21 +--
 net/raw.c          | 123 +++++++++++++
 net/unified.c      | 406 ++++++++++++++++++++++++++++++++++++++++
 net/unified.h      | 118 ++++++++++++
 net/vxlan-static.c | 229 +++++++++++++++++++++++
 qapi-schema.json   |  91 ++++++++-
 12 files changed, 1392 insertions(+), 480 deletions(-)
 create mode 100644 net/gre.c
 create mode 100644 net/raw.c
 create mode 100644 net/unified.c
 create mode 100644 net/unified.h
 create mode 100644 net/vxlan-static.c

diff --git a/configure b/configure
index a3f0522e8f..99a60b723c 100755
--- a/configure
+++ b/configure
@@ -1862,7 +1862,7 @@ if ! compile_object -Werror ; then
 fi
 
 ##########################################
-# L2TPV3 probe
+# UNIFIED probe
 
 cat > $TMPC <<EOF
 #include <sys/socket.h>
@@ -1870,9 +1870,9 @@ cat > $TMPC <<EOF
 int main(void) { return sizeof(struct mmsghdr); }
 EOF
 if compile_prog "" "" ; then
-  l2tpv3=yes
+  unified=yes
 else
-  l2tpv3=no
+  unified=no
 fi
 
 ##########################################
@@ -5458,8 +5458,8 @@ fi
 if test "$netmap" = "yes" ; then
   echo "CONFIG_NETMAP=y" >> $config_host_mak
 fi
-if test "$l2tpv3" = "yes" ; then
-  echo "CONFIG_L2TPV3=y" >> $config_host_mak
+if test "$unified" = "yes" ; then
+  echo "CONFIG_UNIFIED=y" >> $config_host_mak
 fi
 if test "$cap_ng" = "yes" ; then
   echo "CONFIG_LIBCAP=y" >> $config_host_mak
diff --git a/net/Makefile.objs b/net/Makefile.objs
index 67ba5e26fb..440360f714 100644
--- a/net/Makefile.objs
+++ b/net/Makefile.objs
@@ -2,7 +2,7 @@ common-obj-y = net.o queue.o checksum.o util.o hub.o
 common-obj-y += socket.o
 common-obj-y += dump.o
 common-obj-y += eth.o
-common-obj-$(CONFIG_L2TPV3) += l2tpv3.o
+common-obj-$(CONFIG_UNIFIED) += l2tpv3.o unified.o raw.o gre.o vxlan-static.o
 common-obj-$(CONFIG_POSIX) += vhost-user.o
 common-obj-$(CONFIG_SLIRP) += slirp.o
 common-obj-$(CONFIG_VDE) += vde.o
diff --git a/net/clients.h b/net/clients.h
index 5cae479730..f91b879101 100644
--- a/net/clients.h
+++ b/net/clients.h
@@ -49,6 +49,14 @@ int net_init_bridge(const Netdev *netdev, const char *name,
 
 int net_init_l2tpv3(const Netdev *netdev, const char *name,
                     NetClientState *peer, Error **errp);
+
+int net_init_raw(const Netdev *netdev, const char *name,
+                    NetClientState *peer, Error **errp);
+
+int net_init_gre(const Netdev *netdev, const char *name,
+                    NetClientState *peer, Error **errp);
+int net_init_vxlan(const Netdev *netdev, const char *name,
+                    NetClientState *peer, Error **errp);
 #ifdef CONFIG_VDE
 int net_init_vde(const Netdev *netdev, const char *name,
                  NetClientState *peer, Error **errp);
diff --git a/net/gre.c b/net/gre.c
new file mode 100644
index 0000000000..2197b7581d
--- /dev/null
+++ b/net/gre.c
@@ -0,0 +1,314 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2015-2017 Cambridge GREys Limited
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ * Copyright (c) 2012-2014 Cisco Systems
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
+#include "unified.h"
+
+/* IANA-assigned IP protocol ID for GRE */
+
+
+#ifndef IPPROTO_GRE
+#define IPPROTO_GRE 0x2F
+#endif
+
+#define GRE_MODE_CHECKSUM     htons(8 << 12)   /* checksum */
+#define GRE_MODE_RESERVED     htons(4 << 12)   /* unused */
+#define GRE_MODE_KEY          htons(2 << 12)   /* KEY present */
+#define GRE_MODE_SEQUENCE     htons(1 << 12)   /* no sequence */
+
+
+/* GRE TYPE for Ethernet in GRE aka GRETAP */
+
+#define GRE_IRB htons(0x6558)
+
+struct gre_minimal_header {
+   uint16_t header;
+   uint16_t arptype;
+};
+
+typedef struct GRETunnelParams {
+    /*
+     * GRE parameters
+     */
+
+    uint32_t rx_key;
+    uint32_t tx_key;
+    uint32_t sequence;
+
+    /* Flags */
+
+    bool ipv6;
+    bool udp;
+    bool has_sequence;
+    bool pin_sequence;
+    bool checksum;
+    bool key;
+
+    /* Precomputed GRE specific offsets */
+
+    uint32_t key_offset;
+    uint32_t sequence_offset;
+    uint32_t checksum_offset;
+
+    struct gre_minimal_header header_bits;
+
+} GRETunnelParams;
+
+
+
+static void gre_form_header(void *us)
+{
+    NetUnifiedState *s = (NetUnifiedState *) us;
+    GRETunnelParams *p = (GRETunnelParams *) s->params;
+
+    uint32_t *sequence;
+
+    *((uint32_t *) s->header_buf) = *((uint32_t *) &p->header_bits);
+
+    if (p->key) {
+        stl_be_p(
+            (uint32_t *) (s->header_buf + p->key_offset),
+            p->tx_key
+        );
+    }
+    if (p->has_sequence) {
+        sequence = (uint32_t *)(s->header_buf + p->sequence_offset);
+        if (p->pin_sequence) {
+            *sequence = 0;
+        } else {
+            stl_be_p(sequence, ++p->sequence);
+        }
+    }
+}
+
+static int gre_verify_header(void *us, uint8_t *buf)
+{
+
+    NetUnifiedState *s = (NetUnifiedState *) us;
+    GRETunnelParams *p = (GRETunnelParams *) s->params;
+    uint32_t key;
+
+
+    if (!p->ipv6) {
+        buf += sizeof(struct iphdr) /* fix for ipv4 raw */;
+    }
+
+    if (*((uint32_t *) buf) != *((uint32_t *) &p->header_bits)) {
+        if (!s->header_mismatch) {
+            error_report("header type disagreement, expecting %0x, got %0x",
+                *((uint32_t *) &p->header_bits), *((uint32_t *) buf));
+        }
+        return -1;
+    }
+
+    if (p->key) {
+        key = ldl_be_p(buf + p->key_offset);
+        if (key != p->rx_key) {
+            if (!s->header_mismatch) {
+                error_report("unknown key id %0x, expecting %0x",
+                    key, p->rx_key);
+            }
+            return -1;
+        }
+    }
+    return 0;
+}
+
+int net_init_gre(const Netdev *netdev,
+                    const char *name,
+                    NetClientState *peer, Error **errp)
+{
+    /* FIXME error_setg(errp, ...) on failure */
+    const NetdevGREOptions *gre;
+    NetUnifiedState *s;
+    NetClientState *nc;
+    GRETunnelParams *p;
+
+    int fd = -1, gairet;
+    struct addrinfo hints;
+    struct addrinfo *result = NULL;
+
+    nc = qemu_new_unified_net_client(name, peer);
+
+    s = DO_UPCAST(NetUnifiedState, nc, nc);
+
+    p = g_malloc(sizeof(GRETunnelParams));
+
+    s->params = p;
+    p->header_bits.arptype = GRE_IRB;
+    p->header_bits.header = 0;
+
+    s->form_header = &gre_form_header;
+    s->verify_header = &gre_verify_header;
+    s->queue_head = 0;
+    s->queue_tail = 0;
+    s->header_mismatch = false;
+
+    assert(netdev->type == NET_CLIENT_DRIVER_GRE);
+    gre = &netdev->u.gre;
+
+    if (gre->has_ipv6 && gre->ipv6) {
+        p->ipv6 = gre->ipv6;
+    } else {
+        p->ipv6 = false;
+    }
+
+    s->offset = 4;
+    p->key_offset = 4;
+    p->sequence_offset = 4;
+    p->checksum_offset = 4;
+
+    if (gre->has_rxkey || gre->has_txkey) {
+        if (gre->has_rxkey && gre->has_txkey) {
+            p->key = true;
+            p->header_bits.header |= GRE_MODE_KEY;
+        } else {
+            goto outerr;
+        }
+    } else {
+        p->key = false;
+    }
+
+    if (p->key) {
+        p->rx_key = gre->rxkey;
+        p->tx_key = gre->txkey;
+        s->offset += 4;
+        p->sequence_offset += 4;
+    }
+
+
+    if (gre->has_sequence && gre->sequence) {
+        s->offset += 4;
+        p->has_sequence = true;
+        p->header_bits.header |= GRE_MODE_SEQUENCE;
+    } else {
+        p->sequence = false;
+    }
+
+    if (gre->has_pinsequence && gre->pinsequence) {
+        /* pin sequence implies that there is sequence */
+        p->has_sequence = true;
+        p->pin_sequence = true;
+    } else {
+        p->pin_sequence = false;
+    }
+
+    memset(&hints, 0, sizeof(hints));
+
+    if (p->ipv6) {
+        hints.ai_family = AF_INET6;
+    } else {
+        hints.ai_family = AF_INET;
+    }
+
+    hints.ai_socktype = SOCK_RAW;
+    hints.ai_protocol = IPPROTO_GRE;
+
+    gairet = getaddrinfo(gre->src, NULL, &hints, &result);
+
+    if ((gairet != 0) || (result == NULL)) {
+        error_report(
+            "gre_open : could not resolve src, errno = %s",
+            gai_strerror(gairet)
+        );
+        goto outerr;
+    }
+    fd = socket(result->ai_family, result->ai_socktype, result->ai_protocol);
+    if (fd == -1) {
+        fd = -errno;
+        error_report("gre_open : socket creation failed, errno = %d", -fd);
+        goto outerr;
+    }
+    if (bind(fd, (struct sockaddr *) result->ai_addr, result->ai_addrlen)) {
+        error_report("gre_open :  could not bind socket err=%i", errno);
+        goto outerr;
+    }
+    if (result) {
+        freeaddrinfo(result);
+    }
+
+    memset(&hints, 0, sizeof(hints));
+
+    if (p->ipv6) {
+        hints.ai_family = AF_INET6;
+    } else {
+        hints.ai_family = AF_INET;
+    }
+    hints.ai_socktype = SOCK_RAW;
+    hints.ai_protocol = IPPROTO_GRE;
+
+    result = NULL;
+    gairet = getaddrinfo(gre->dst, NULL, &hints, &result);
+    if ((gairet != 0) || (result == NULL)) {
+        error_report(
+            "gre_open : could not resolve dst, error = %s",
+            gai_strerror(gairet)
+        );
+        goto outerr;
+    }
+
+    s->dgram_dst = g_new0(struct sockaddr_storage, 1);
+    memcpy(s->dgram_dst, result->ai_addr, result->ai_addrlen);
+    s->dst_size = result->ai_addrlen;
+
+    if (result) {
+        freeaddrinfo(result);
+    }
+
+    if ((p->ipv6) || (p->udp)) {
+        s->header_size = s->offset;
+    } else {
+        s->header_size = s->offset + sizeof(struct iphdr);
+    }
+
+    qemu_net_finalize_unified_init(s, fd);
+
+    p->sequence = 0;
+
+    snprintf(s->nc.info_str, sizeof(s->nc.info_str),
+             "gre: connected");
+    return 0;
+outerr:
+    qemu_del_net_client(nc);
+    if (fd >= 0) {
+        close(fd);
+    }
+    if (result) {
+        freeaddrinfo(result);
+    }
+    return -1;
+}
+
diff --git a/net/l2tpv3.c b/net/l2tpv3.c
index 6745b78990..05413c9cbd 100644
--- a/net/l2tpv3.c
+++ b/net/l2tpv3.c
@@ -1,6 +1,7 @@
 /*
  * QEMU System Emulator
  *
+ * Copyright (c) 2015-2017 Cambridge Greys Limited
  * Copyright (c) 2003-2008 Fabrice Bellard
  * Copyright (c) 2012-2014 Cisco Systems
  *
@@ -34,19 +35,9 @@
 #include "qemu/sockets.h"
 #include "qemu/iov.h"
 #include "qemu/main-loop.h"
+#include "unified.h"
 
 
-/* The buffer size needs to be investigated for optimum numbers and
- * optimum means of paging in on different systems. This size is
- * chosen to be sufficient to accommodate one packet with some headers
- */
-
-#define BUFFER_ALIGN sysconf(_SC_PAGESIZE)
-#define BUFFER_SIZE 2048
-#define IOVSIZE 2
-#define MAX_L2TPV3_MSGCNT 64
-#define MAX_L2TPV3_IOVCNT (MAX_L2TPV3_MSGCNT * IOVSIZE)
-
 /* Header set to 0x30000 signifies a data packet */
 
 #define L2TPV3_DATA_PACKET 0x30000
@@ -57,31 +48,7 @@
 #define IPPROTO_L2TP 0x73
 #endif
 
-typedef struct NetL2TPV3State {
-    NetClientState nc;
-    int fd;
-
-    /*
-     * these are used for xmit - that happens packet a time
-     * and for first sign of life packet (easier to parse that once)
-     */
-
-    uint8_t *header_buf;
-    struct iovec *vec;
-
-    /*
-     * these are used for receive - try to "eat" up to 32 packets at a time
-     */
-
-    struct mmsghdr *msgvec;
-
-    /*
-     * peer address
-     */
-
-    struct sockaddr_storage *dgram_dst;
-    uint32_t dst_size;
-
+typedef struct L2TPV3TunnelParams {
     /*
      * L2TPv3 parameters
      */
@@ -90,37 +57,8 @@ typedef struct NetL2TPV3State {
     uint64_t tx_cookie;
     uint32_t rx_session;
     uint32_t tx_session;
-    uint32_t header_size;
     uint32_t counter;
 
-    /*
-    * DOS avoidance in error handling
-    */
-
-    bool header_mismatch;
-
-    /*
-     * Ring buffer handling
-     */
-
-    int queue_head;
-    int queue_tail;
-    int queue_depth;
-
-    /*
-     * Precomputed offsets
-     */
-
-    uint32_t offset;
-    uint32_t cookie_offset;
-    uint32_t counter_offset;
-    uint32_t session_offset;
-
-    /* Poll Control */
-
-    bool read_poll;
-    bool write_poll;
-
     /* Flags */
 
     bool ipv6;
@@ -130,189 +68,62 @@ typedef struct NetL2TPV3State {
     bool cookie;
     bool cookie_is_64;
 
-} NetL2TPV3State;
-
-static void net_l2tpv3_send(void *opaque);
-static void l2tpv3_writable(void *opaque);
-
-static void l2tpv3_update_fd_handler(NetL2TPV3State *s)
-{
-    qemu_set_fd_handler(s->fd,
-                        s->read_poll ? net_l2tpv3_send : NULL,
-                        s->write_poll ? l2tpv3_writable : NULL,
-                        s);
-}
-
-static void l2tpv3_read_poll(NetL2TPV3State *s, bool enable)
-{
-    if (s->read_poll != enable) {
-        s->read_poll = enable;
-        l2tpv3_update_fd_handler(s);
-    }
-}
+    /* Precomputed L2TPV3 specific offsets */
+    uint32_t cookie_offset;
+    uint32_t counter_offset;
+    uint32_t session_offset;
 
-static void l2tpv3_write_poll(NetL2TPV3State *s, bool enable)
-{
-    if (s->write_poll != enable) {
-        s->write_poll = enable;
-        l2tpv3_update_fd_handler(s);
-    }
-}
+} L2TPV3TunnelParams;
 
-static void l2tpv3_writable(void *opaque)
-{
-    NetL2TPV3State *s = opaque;
-    l2tpv3_write_poll(s, false);
-    qemu_flush_queued_packets(&s->nc);
-}
 
-static void l2tpv3_send_completed(NetClientState *nc, ssize_t len)
-{
-    NetL2TPV3State *s = DO_UPCAST(NetL2TPV3State, nc, nc);
-    l2tpv3_read_poll(s, true);
-}
 
-static void l2tpv3_poll(NetClientState *nc, bool enable)
+static void l2tpv3_form_header(void *us)
 {
-    NetL2TPV3State *s = DO_UPCAST(NetL2TPV3State, nc, nc);
-    l2tpv3_write_poll(s, enable);
-    l2tpv3_read_poll(s, enable);
-}
+    NetUnifiedState *s = (NetUnifiedState *) us;
+    L2TPV3TunnelParams *p = (L2TPV3TunnelParams *) s->params;
 
-static void l2tpv3_form_header(NetL2TPV3State *s)
-{
     uint32_t *counter;
 
-    if (s->udp) {
+    if (p->udp) {
         stl_be_p((uint32_t *) s->header_buf, L2TPV3_DATA_PACKET);
     }
     stl_be_p(
-            (uint32_t *) (s->header_buf + s->session_offset),
-            s->tx_session
+            (uint32_t *) (s->header_buf + p->session_offset),
+            p->tx_session
         );
-    if (s->cookie) {
-        if (s->cookie_is_64) {
+    if (p->cookie) {
+        if (p->cookie_is_64) {
             stq_be_p(
-                (uint64_t *)(s->header_buf + s->cookie_offset),
-                s->tx_cookie
+                (uint64_t *)(s->header_buf + p->cookie_offset),
+                p->tx_cookie
             );
         } else {
             stl_be_p(
-                (uint32_t *) (s->header_buf + s->cookie_offset),
-                s->tx_cookie
+                (uint32_t *) (s->header_buf + p->cookie_offset),
+                p->tx_cookie
             );
         }
     }
-    if (s->has_counter) {
-        counter = (uint32_t *)(s->header_buf + s->counter_offset);
-        if (s->pin_counter) {
+    if (p->has_counter) {
+        counter = (uint32_t *)(s->header_buf + p->counter_offset);
+        if (p->pin_counter) {
             *counter = 0;
         } else {
-            stl_be_p(counter, ++s->counter);
-        }
-    }
-}
-
-static ssize_t net_l2tpv3_receive_dgram_iov(NetClientState *nc,
-                    const struct iovec *iov,
-                    int iovcnt)
-{
-    NetL2TPV3State *s = DO_UPCAST(NetL2TPV3State, nc, nc);
-
-    struct msghdr message;
-    int ret;
-
-    if (iovcnt > MAX_L2TPV3_IOVCNT - 1) {
-        error_report(
-            "iovec too long %d > %d, change l2tpv3.h",
-            iovcnt, MAX_L2TPV3_IOVCNT
-        );
-        return -1;
-    }
-    l2tpv3_form_header(s);
-    memcpy(s->vec + 1, iov, iovcnt * sizeof(struct iovec));
-    s->vec->iov_base = s->header_buf;
-    s->vec->iov_len = s->offset;
-    message.msg_name = s->dgram_dst;
-    message.msg_namelen = s->dst_size;
-    message.msg_iov = s->vec;
-    message.msg_iovlen = iovcnt + 1;
-    message.msg_control = NULL;
-    message.msg_controllen = 0;
-    message.msg_flags = 0;
-    do {
-        ret = sendmsg(s->fd, &message, 0);
-    } while ((ret == -1) && (errno == EINTR));
-    if (ret > 0) {
-        ret -= s->offset;
-    } else if (ret == 0) {
-        /* belt and braces - should not occur on DGRAM
-        * we should get an error and never a 0 send
-        */
-        ret = iov_size(iov, iovcnt);
-    } else {
-        /* signal upper layer that socket buffer is full */
-        ret = -errno;
-        if (ret == -EAGAIN || ret == -ENOBUFS) {
-            l2tpv3_write_poll(s, true);
-            ret = 0;
+            stl_be_p(counter, ++p->counter);
         }
     }
-    return ret;
 }
 
-static ssize_t net_l2tpv3_receive_dgram(NetClientState *nc,
-                    const uint8_t *buf,
-                    size_t size)
-{
-    NetL2TPV3State *s = DO_UPCAST(NetL2TPV3State, nc, nc);
-
-    struct iovec *vec;
-    struct msghdr message;
-    ssize_t ret = 0;
-
-    l2tpv3_form_header(s);
-    vec = s->vec;
-    vec->iov_base = s->header_buf;
-    vec->iov_len = s->offset;
-    vec++;
-    vec->iov_base = (void *) buf;
-    vec->iov_len = size;
-    message.msg_name = s->dgram_dst;
-    message.msg_namelen = s->dst_size;
-    message.msg_iov = s->vec;
-    message.msg_iovlen = 2;
-    message.msg_control = NULL;
-    message.msg_controllen = 0;
-    message.msg_flags = 0;
-    do {
-        ret = sendmsg(s->fd, &message, 0);
-    } while ((ret == -1) && (errno == EINTR));
-    if (ret > 0) {
-        ret -= s->offset;
-    } else if (ret == 0) {
-        /* belt and braces - should not occur on DGRAM
-        * we should get an error and never a 0 send
-        */
-        ret = size;
-    } else {
-        ret = -errno;
-        if (ret == -EAGAIN || ret == -ENOBUFS) {
-            /* signal upper layer that socket buffer is full */
-            l2tpv3_write_poll(s, true);
-            ret = 0;
-        }
-    }
-    return ret;
-}
 
-static int l2tpv3_verify_header(NetL2TPV3State *s, uint8_t *buf)
+static int l2tpv3_verify_header(void *us, uint8_t *buf)
 {
 
+    NetUnifiedState *s = (NetUnifiedState *) us;
+    L2TPV3TunnelParams *p = (L2TPV3TunnelParams *) s->params;
     uint32_t *session;
     uint64_t cookie;
 
-    if ((!s->udp) && (!s->ipv6)) {
+    if ((!p->udp) && (!p->ipv6)) {
         buf += sizeof(struct iphdr) /* fix for ipv4 raw */;
     }
 
@@ -321,21 +132,21 @@ static int l2tpv3_verify_header(NetL2TPV3State *s, uint8_t *buf)
     * that anyway.
     */
 
-    if (s->cookie) {
-        if (s->cookie_is_64) {
-            cookie = ldq_be_p(buf + s->cookie_offset);
+    if (p->cookie) {
+        if (p->cookie_is_64) {
+            cookie = ldq_be_p(buf + p->cookie_offset);
         } else {
-            cookie = ldl_be_p(buf + s->cookie_offset) & 0xffffffffULL;
+            cookie = ldl_be_p(buf + p->cookie_offset) & 0xffffffffULL;
         }
-        if (cookie != s->rx_cookie) {
+        if (cookie != p->rx_cookie) {
             if (!s->header_mismatch) {
                 error_report("unknown cookie id");
             }
             return -1;
         }
     }
-    session = (uint32_t *) (buf + s->session_offset);
-    if (ldl_be_p(session) != s->rx_session) {
+    session = (uint32_t *) (buf + p->session_offset);
+    if (ldl_be_p(session) != p->rx_session) {
         if (!s->header_mismatch) {
             error_report("session mismatch");
         }
@@ -344,203 +155,31 @@ static int l2tpv3_verify_header(NetL2TPV3State *s, uint8_t *buf)
     return 0;
 }
 
-static void net_l2tpv3_process_queue(NetL2TPV3State *s)
-{
-    int size = 0;
-    struct iovec *vec;
-    bool bad_read;
-    int data_size;
-    struct mmsghdr *msgvec;
-
-    /* go into ring mode only if there is a "pending" tail */
-    if (s->queue_depth > 0) {
-        do {
-            msgvec = s->msgvec + s->queue_tail;
-            if (msgvec->msg_len > 0) {
-                data_size = msgvec->msg_len - s->header_size;
-                vec = msgvec->msg_hdr.msg_iov;
-                if ((data_size > 0) &&
-                    (l2tpv3_verify_header(s, vec->iov_base) == 0)) {
-                    vec++;
-                    /* Use the legacy delivery for now, we will
-                     * switch to using our own ring as a queueing mechanism
-                     * at a later date
-                     */
-                    size = qemu_send_packet_async(
-                            &s->nc,
-                            vec->iov_base,
-                            data_size,
-                            l2tpv3_send_completed
-                        );
-                    if (size == 0) {
-                        l2tpv3_read_poll(s, false);
-                    }
-                    bad_read = false;
-                } else {
-                    bad_read = true;
-                    if (!s->header_mismatch) {
-                        /* report error only once */
-                        error_report("l2tpv3 header verification failed");
-                        s->header_mismatch = true;
-                    }
-                }
-            } else {
-                bad_read = true;
-            }
-            s->queue_tail = (s->queue_tail + 1) % MAX_L2TPV3_MSGCNT;
-            s->queue_depth--;
-        } while (
-                (s->queue_depth > 0) &&
-                 qemu_can_send_packet(&s->nc) &&
-                ((size > 0) || bad_read)
-            );
-    }
-}
-
-static void net_l2tpv3_send(void *opaque)
-{
-    NetL2TPV3State *s = opaque;
-    int target_count, count;
-    struct mmsghdr *msgvec;
-
-    /* go into ring mode only if there is a "pending" tail */
-
-    if (s->queue_depth) {
-
-        /* The ring buffer we use has variable intake
-         * count of how much we can read varies - adjust accordingly
-         */
-
-        target_count = MAX_L2TPV3_MSGCNT - s->queue_depth;
-
-        /* Ensure we do not overrun the ring when we have
-         * a lot of enqueued packets
-         */
-
-        if (s->queue_head + target_count > MAX_L2TPV3_MSGCNT) {
-            target_count = MAX_L2TPV3_MSGCNT - s->queue_head;
-        }
-    } else {
-
-        /* we do not have any pending packets - we can use
-        * the whole message vector linearly instead of using
-        * it as a ring
-        */
-
-        s->queue_head = 0;
-        s->queue_tail = 0;
-        target_count = MAX_L2TPV3_MSGCNT;
-    }
-
-    msgvec = s->msgvec + s->queue_head;
-    if (target_count > 0) {
-        do {
-            count = recvmmsg(
-                s->fd,
-                msgvec,
-                target_count, MSG_DONTWAIT, NULL);
-        } while ((count == -1) && (errno == EINTR));
-        if (count < 0) {
-            /* Recv error - we still need to flush packets here,
-             * (re)set queue head to current position
-             */
-            count = 0;
-        }
-        s->queue_head = (s->queue_head + count) % MAX_L2TPV3_MSGCNT;
-        s->queue_depth += count;
-    }
-    net_l2tpv3_process_queue(s);
-}
-
-static void destroy_vector(struct mmsghdr *msgvec, int count, int iovcount)
-{
-    int i, j;
-    struct iovec *iov;
-    struct mmsghdr *cleanup = msgvec;
-    if (cleanup) {
-        for (i = 0; i < count; i++) {
-            if (cleanup->msg_hdr.msg_iov) {
-                iov = cleanup->msg_hdr.msg_iov;
-                for (j = 0; j < iovcount; j++) {
-                    g_free(iov->iov_base);
-                    iov++;
-                }
-                g_free(cleanup->msg_hdr.msg_iov);
-            }
-            cleanup++;
-        }
-        g_free(msgvec);
-    }
-}
-
-static struct mmsghdr *build_l2tpv3_vector(NetL2TPV3State *s, int count)
-{
-    int i;
-    struct iovec *iov;
-    struct mmsghdr *msgvec, *result;
-
-    msgvec = g_new(struct mmsghdr, count);
-    result = msgvec;
-    for (i = 0; i < count ; i++) {
-        msgvec->msg_hdr.msg_name = NULL;
-        msgvec->msg_hdr.msg_namelen = 0;
-        iov =  g_new(struct iovec, IOVSIZE);
-        msgvec->msg_hdr.msg_iov = iov;
-        iov->iov_base = g_malloc(s->header_size);
-        iov->iov_len = s->header_size;
-        iov++ ;
-        iov->iov_base = qemu_memalign(BUFFER_ALIGN, BUFFER_SIZE);
-        iov->iov_len = BUFFER_SIZE;
-        msgvec->msg_hdr.msg_iovlen = 2;
-        msgvec->msg_hdr.msg_control = NULL;
-        msgvec->msg_hdr.msg_controllen = 0;
-        msgvec->msg_hdr.msg_flags = 0;
-        msgvec++;
-    }
-    return result;
-}
-
-static void net_l2tpv3_cleanup(NetClientState *nc)
-{
-    NetL2TPV3State *s = DO_UPCAST(NetL2TPV3State, nc, nc);
-    qemu_purge_queued_packets(nc);
-    l2tpv3_read_poll(s, false);
-    l2tpv3_write_poll(s, false);
-    if (s->fd >= 0) {
-        close(s->fd);
-    }
-    destroy_vector(s->msgvec, MAX_L2TPV3_MSGCNT, IOVSIZE);
-    g_free(s->vec);
-    g_free(s->header_buf);
-    g_free(s->dgram_dst);
-}
-
-static NetClientInfo net_l2tpv3_info = {
-    .type = NET_CLIENT_DRIVER_L2TPV3,
-    .size = sizeof(NetL2TPV3State),
-    .receive = net_l2tpv3_receive_dgram,
-    .receive_iov = net_l2tpv3_receive_dgram_iov,
-    .poll = l2tpv3_poll,
-    .cleanup = net_l2tpv3_cleanup,
-};
-
 int net_init_l2tpv3(const Netdev *netdev,
                     const char *name,
                     NetClientState *peer, Error **errp)
 {
     /* FIXME error_setg(errp, ...) on failure */
     const NetdevL2TPv3Options *l2tpv3;
-    NetL2TPV3State *s;
+    NetUnifiedState *s;
     NetClientState *nc;
+    L2TPV3TunnelParams *p;
+
     int fd = -1, gairet;
     struct addrinfo hints;
     struct addrinfo *result = NULL;
     char *srcport, *dstport;
 
-    nc = qemu_new_net_client(&net_l2tpv3_info, peer, "l2tpv3", name);
+    nc = qemu_new_unified_net_client(name, peer);
+
+    s = DO_UPCAST(NetUnifiedState, nc, nc);
+
+    p = g_malloc(sizeof(L2TPV3TunnelParams));
 
-    s = DO_UPCAST(NetL2TPV3State, nc, nc);
+    s->params = p;
 
+    s->form_header = &l2tpv3_form_header;
+    s->verify_header = &l2tpv3_verify_header;
     s->queue_head = 0;
     s->queue_tail = 0;
     s->header_mismatch = false;
@@ -549,9 +188,9 @@ int net_init_l2tpv3(const Netdev *netdev,
     l2tpv3 = &netdev->u.l2tpv3;
 
     if (l2tpv3->has_ipv6 && l2tpv3->ipv6) {
-        s->ipv6 = l2tpv3->ipv6;
+        p->ipv6 = l2tpv3->ipv6;
     } else {
-        s->ipv6 = false;
+        p->ipv6 = false;
     }
 
     if ((l2tpv3->has_offset) && (l2tpv3->offset > 256)) {
@@ -561,22 +200,22 @@ int net_init_l2tpv3(const Netdev *netdev,
 
     if (l2tpv3->has_rxcookie || l2tpv3->has_txcookie) {
         if (l2tpv3->has_rxcookie && l2tpv3->has_txcookie) {
-            s->cookie = true;
+            p->cookie = true;
         } else {
             goto outerr;
         }
     } else {
-        s->cookie = false;
+        p->cookie = false;
     }
 
     if (l2tpv3->has_cookie64 || l2tpv3->cookie64) {
-        s->cookie_is_64  = true;
+        p->cookie_is_64  = true;
     } else {
-        s->cookie_is_64  = false;
+        p->cookie_is_64  = false;
     }
 
     if (l2tpv3->has_udp && l2tpv3->udp) {
-        s->udp = true;
+        p->udp = true;
         if (!(l2tpv3->has_srcport && l2tpv3->has_dstport)) {
             error_report("l2tpv3_open : need both src and dst port for udp");
             goto outerr;
@@ -585,52 +224,52 @@ int net_init_l2tpv3(const Netdev *netdev,
             dstport = l2tpv3->dstport;
         }
     } else {
-        s->udp = false;
+        p->udp = false;
         srcport = NULL;
         dstport = NULL;
     }
 
 
     s->offset = 4;
-    s->session_offset = 0;
-    s->cookie_offset = 4;
-    s->counter_offset = 4;
+    p->session_offset = 0;
+    p->cookie_offset = 4;
+    p->counter_offset = 4;
 
-    s->tx_session = l2tpv3->txsession;
+    p->tx_session = l2tpv3->txsession;
     if (l2tpv3->has_rxsession) {
-        s->rx_session = l2tpv3->rxsession;
+        p->rx_session = l2tpv3->rxsession;
     } else {
-        s->rx_session = s->tx_session;
+        p->rx_session = p->tx_session;
     }
 
-    if (s->cookie) {
-        s->rx_cookie = l2tpv3->rxcookie;
-        s->tx_cookie = l2tpv3->txcookie;
-        if (s->cookie_is_64 == true) {
+    if (p->cookie) {
+        p->rx_cookie = l2tpv3->rxcookie;
+        p->tx_cookie = l2tpv3->txcookie;
+        if (p->cookie_is_64 == true) {
             /* 64 bit cookie */
             s->offset += 8;
-            s->counter_offset += 8;
+            p->counter_offset += 8;
         } else {
             /* 32 bit cookie */
             s->offset += 4;
-            s->counter_offset += 4;
+            p->counter_offset += 4;
         }
     }
 
     memset(&hints, 0, sizeof(hints));
 
-    if (s->ipv6) {
+    if (p->ipv6) {
         hints.ai_family = AF_INET6;
     } else {
         hints.ai_family = AF_INET;
     }
-    if (s->udp) {
+    if (p->udp) {
         hints.ai_socktype = SOCK_DGRAM;
         hints.ai_protocol = 0;
         s->offset += 4;
-        s->counter_offset += 4;
-        s->session_offset += 4;
-        s->cookie_offset += 4;
+        p->counter_offset += 4;
+        p->session_offset += 4;
+        p->cookie_offset += 4;
     } else {
         hints.ai_socktype = SOCK_RAW;
         hints.ai_protocol = IPPROTO_L2TP;
@@ -661,12 +300,12 @@ int net_init_l2tpv3(const Netdev *netdev,
 
     memset(&hints, 0, sizeof(hints));
 
-    if (s->ipv6) {
+    if (p->ipv6) {
         hints.ai_family = AF_INET6;
     } else {
         hints.ai_family = AF_INET;
     }
-    if (s->udp) {
+    if (p->udp) {
         hints.ai_socktype = SOCK_DGRAM;
         hints.ai_protocol = 0;
     } else {
@@ -693,17 +332,17 @@ int net_init_l2tpv3(const Netdev *netdev,
     }
 
     if (l2tpv3->has_counter && l2tpv3->counter) {
-        s->has_counter = true;
+        p->has_counter = true;
         s->offset += 4;
     } else {
-        s->has_counter = false;
+        p->has_counter = false;
     }
 
     if (l2tpv3->has_pincounter && l2tpv3->pincounter) {
-        s->has_counter = true;  /* pin counter implies that there is counter */
-        s->pin_counter = true;
+        p->has_counter = true;  /* pin counter implies that there is counter */
+        p->pin_counter = true;
     } else {
-        s->pin_counter = false;
+        p->pin_counter = false;
     }
 
     if (l2tpv3->has_offset) {
@@ -711,22 +350,14 @@ int net_init_l2tpv3(const Netdev *netdev,
         s->offset += l2tpv3->offset;
     }
 
-    if ((s->ipv6) || (s->udp)) {
+    if ((p->ipv6) || (p->udp)) {
         s->header_size = s->offset;
     } else {
         s->header_size = s->offset + sizeof(struct iphdr);
     }
 
-    s->msgvec = build_l2tpv3_vector(s, MAX_L2TPV3_MSGCNT);
-    s->vec = g_new(struct iovec, MAX_L2TPV3_IOVCNT);
-    s->header_buf = g_malloc(s->header_size);
-
-    qemu_set_nonblock(fd);
-
-    s->fd = fd;
-    s->counter = 0;
-
-    l2tpv3_read_poll(s, true);
+    qemu_net_finalize_unified_init(s, fd);
+    p->counter = 0;
 
     snprintf(s->nc.info_str, sizeof(s->nc.info_str),
              "l2tpv3: connected");
diff --git a/net/net.c b/net/net.c
index 6235aabed8..4d9f0deb06 100644
--- a/net/net.c
+++ b/net/net.c
@@ -959,8 +959,11 @@ static int (* const net_client_init_fun[NET_CLIENT_DRIVER__MAX])(
 #ifdef CONFIG_VHOST_NET_USED
         [NET_CLIENT_DRIVER_VHOST_USER] = net_init_vhost_user,
 #endif
-#ifdef CONFIG_L2TPV3
-        [NET_CLIENT_DRIVER_L2TPV3]    = net_init_l2tpv3,
+#ifdef CONFIG_UNIFIED
+        [NET_CLIENT_DRIVER_RAW]    = net_init_raw,
+        [NET_CLIENT_DRIVER_GRE]    = net_init_gre,
+        [NET_CLIENT_DRIVER_VXLAN]  = net_init_vxlan,
+        [NET_CLIENT_DRIVER_L2TPV3] = net_init_l2tpv3,
 #endif
 };
 
@@ -1008,6 +1011,18 @@ static int net_client_init1(const void *object, bool is_netdev, Error **errp)
             legacy.type = NET_CLIENT_DRIVER_TAP;
             legacy.u.tap = opts->u.tap;
             break;
+        case NET_LEGACY_OPTIONS_TYPE_RAW:
+            legacy.type = NET_CLIENT_DRIVER_RAW;
+            legacy.u.raw = opts->u.raw;
+            break;
+        case NET_LEGACY_OPTIONS_TYPE_GRE:
+            legacy.type = NET_CLIENT_DRIVER_GRE;
+            legacy.u.gre = opts->u.gre;
+            break;
+        case NET_LEGACY_OPTIONS_TYPE_VXLAN:
+            legacy.type = NET_CLIENT_DRIVER_VXLAN;
+            legacy.u.vxlan = opts->u.vxlan;
+            break;
         case NET_LEGACY_OPTIONS_TYPE_L2TPV3:
             legacy.type = NET_CLIENT_DRIVER_L2TPV3;
             legacy.u.l2tpv3 = opts->u.l2tpv3;
diff --git a/net/queue.c b/net/queue.c
index 9c32abdb8f..1825fa06e8 100644
--- a/net/queue.c
+++ b/net/queue.c
@@ -25,6 +25,7 @@
 #include "net/queue.h"
 #include "qemu/queue.h"
 #include "net/net.h"
+#include "packet.h"
 
 /* The delivery handler may only return zero if it will call
  * qemu_net_queue_flush() when it determines that it is once again able
@@ -40,26 +41,6 @@
  * unbounded queueing.
  */
 
-struct NetPacket {
-    QTAILQ_ENTRY(NetPacket) entry;
-    NetClientState *sender;
-    unsigned flags;
-    int size;
-    NetPacketSent *sent_cb;
-    uint8_t data[0];
-};
-
-struct NetQueue {
-    void *opaque;
-    uint32_t nq_maxlen;
-    uint32_t nq_count;
-    NetQueueDeliverFunc *deliver;
-
-    QTAILQ_HEAD(packets, NetPacket) packets;
-
-    unsigned delivering : 1;
-};
-
 NetQueue *qemu_new_net_queue(NetQueueDeliverFunc *deliver, void *opaque)
 {
     NetQueue *queue;
diff --git a/net/raw.c b/net/raw.c
new file mode 100644
index 0000000000..73e2fd9fe3
--- /dev/null
+++ b/net/raw.c
@@ -0,0 +1,123 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2015-2017 Cambridge Greys Limited
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ * Copyright (c) 2012-2014 Cisco Systems
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
+#include <linux/ip.h>
+#include <netdb.h>
+#include <sys/ioctl.h>
+#include <net/if.h>
+#include "net/net.h"
+ #include <sys/socket.h>
+#include <linux/if_packet.h>
+#include <net/ethernet.h>
+#include "clients.h"
+#include "qemu-common.h"
+#include "qemu/error-report.h"
+#include "qemu/option.h"
+#include "qemu/sockets.h"
+#include "qemu/iov.h"
+#include "qemu/main-loop.h"
+#include "unified.h"
+
+static int noop(void *us, uint8_t *buf)
+{
+    return 0;
+}
+
+int net_init_raw(const Netdev *netdev,
+                    const char *name,
+                    NetClientState *peer, Error **errp)
+{
+
+    const NetdevRawOptions *raw;
+    NetUnifiedState *s;
+    NetClientState *nc;
+
+    int fd = -1;
+    int err;
+
+    struct ifreq ifr;
+    struct sockaddr_ll sock;
+
+
+    nc = qemu_new_unified_net_client(name, peer);
+
+    s = DO_UPCAST(NetUnifiedState, nc, nc);
+
+    fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
+    if (fd == -1) {
+        err = -errno;
+        error_report("raw_open : raw socket creation failed, errno = %d", -err);
+        goto outerr;
+    }
+
+
+    s->form_header = NULL;
+    s->verify_header = &noop;
+    s->queue_head = 0;
+    s->queue_tail = 0;
+    s->header_mismatch = false;
+    s->dgram_dst = NULL;
+    s->dst_size = 0;
+
+    assert(netdev->type == NET_CLIENT_DRIVER_RAW);
+    raw = &netdev->u.raw;
+
+    memset(&ifr, 0, sizeof(struct ifreq));
+    strncpy((char *) &ifr.ifr_name, raw->ifname, sizeof(ifr.ifr_name) - 1);
+
+    if (ioctl(fd, SIOCGIFINDEX, (void *) &ifr) < 0) {
+        err = -errno;
+        error_report("SIOCGIFINDEX, failed to get raw interface index for %s",
+            raw->ifname);
+        goto outerr;
+    }
+
+    sock.sll_family = AF_PACKET;
+    sock.sll_protocol = htons(ETH_P_ALL);
+    sock.sll_ifindex = ifr.ifr_ifindex;
+
+    if (bind(fd, (struct sockaddr *) &sock, sizeof(struct sockaddr_ll)) < 0) {
+        error_report("raw: failed to bind raw socket");
+        err = -errno;
+        goto outerr;
+    }
+
+    s->offset = 0;
+
+    qemu_net_finalize_unified_init(s, fd);
+
+    snprintf(s->nc.info_str, sizeof(s->nc.info_str),
+             "raw: connected");
+    return 0;
+outerr:
+    qemu_del_net_client(nc);
+    if (fd >= 0) {
+        close(fd);
+    }
+    return -1;
+}
+
diff --git a/net/unified.c b/net/unified.c
new file mode 100644
index 0000000000..f15d1e1eed
--- /dev/null
+++ b/net/unified.c
@@ -0,0 +1,406 @@
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
+#include "unified.h"
+
+static void net_unified_send(void *opaque);
+static void unified_writable(void *opaque);
+
+static void unified_update_fd_handler(NetUnifiedState *s)
+{
+    qemu_set_fd_handler(s->fd,
+                        s->read_poll ? net_unified_send : NULL,
+                        s->write_poll ? unified_writable : NULL,
+                        s);
+}
+
+static void unified_read_poll(NetUnifiedState *s, bool enable)
+{
+    if (s->read_poll != enable) {
+        s->read_poll = enable;
+        unified_update_fd_handler(s);
+    }
+}
+
+static void unified_write_poll(NetUnifiedState *s, bool enable)
+{
+    if (s->write_poll != enable) {
+        s->write_poll = enable;
+        unified_update_fd_handler(s);
+    }
+}
+
+static void unified_writable(void *opaque)
+{
+    NetUnifiedState *s = opaque;
+    unified_write_poll(s, false);
+    qemu_flush_queued_packets(&s->nc);
+}
+
+static void unified_send_completed(NetClientState *nc, ssize_t len)
+{
+    NetUnifiedState *s = DO_UPCAST(NetUnifiedState, nc, nc);
+    unified_read_poll(s, true);
+}
+
+static void unified_poll(NetClientState *nc, bool enable)
+{
+    NetUnifiedState *s = DO_UPCAST(NetUnifiedState, nc, nc);
+    unified_write_poll(s, enable);
+    unified_read_poll(s, enable);
+}
+
+static ssize_t net_unified_receive_dgram_iov(NetClientState *nc,
+                    const struct iovec *iov,
+                    int iovcnt)
+{
+    NetUnifiedState *s = DO_UPCAST(NetUnifiedState, nc, nc);
+
+    struct msghdr message;
+    int ret;
+
+    if (iovcnt > MAX_UNIFIED_IOVCNT - 1) {
+        error_report(
+            "iovec too long %d > %d, change unified.h",
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
+            unified_write_poll(s, true);
+            ret = 0;
+        }
+    }
+    return ret;
+}
+
+static ssize_t net_unified_receive_dgram(NetClientState *nc,
+                    const uint8_t *buf,
+                    size_t size)
+{
+    NetUnifiedState *s = DO_UPCAST(NetUnifiedState, nc, nc);
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
+            unified_write_poll(s, true);
+            ret = 0;
+        }
+    }
+    return ret;
+}
+
+
+static void net_unified_process_queue(NetUnifiedState *s)
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
+                            unified_send_completed
+                        );
+                    if (size == 0) {
+                        unified_read_poll(s, false);
+                    }
+                    bad_read = false;
+                } else {
+                    bad_read = true;
+                    if (!s->header_mismatch) {
+                        /* report error only once */
+                        error_report("unified header verification failed");
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
+static void net_unified_send(void *opaque)
+{
+    NetUnifiedState *s = opaque;
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
+    net_unified_process_queue(s);
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
+static struct mmsghdr *build_unified_vector(NetUnifiedState *s, int count)
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
+static void net_unified_cleanup(NetClientState *nc)
+{
+    NetUnifiedState *s = DO_UPCAST(NetUnifiedState, nc, nc);
+    qemu_purge_queued_packets(nc);
+    unified_read_poll(s, false);
+    unified_write_poll(s, false);
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
+static NetClientInfo net_unified_info = {
+    /* we share this one for all types for now, wrong I know :) */
+    .type = NET_CLIENT_DRIVER_L2TPV3,
+    .size = sizeof(NetUnifiedState),
+    .receive = net_unified_receive_dgram,
+    .receive_iov = net_unified_receive_dgram_iov,
+    .poll = unified_poll,
+    .cleanup = net_unified_cleanup,
+};
+
+NetClientState *qemu_new_unified_net_client(const char *name,
+                    NetClientState *peer) {
+    return qemu_new_net_client(&net_unified_info, peer, "unified", name);
+}
+
+void qemu_net_finalize_unified_init(NetUnifiedState *s, int fd)
+{
+
+    s->msgvec = build_unified_vector(s, MAX_UNIFIED_MSGCNT);
+    s->vec = g_new(struct iovec, MAX_UNIFIED_IOVCNT);
+    if (s->header_size > 0) {
+        s->header_buf = g_malloc(s->header_size);
+    } else {
+        s->header_buf = NULL;
+    }
+    qemu_set_nonblock(fd);
+
+    s->fd = fd;
+    unified_read_poll(s, true);
+
+}
+
diff --git a/net/unified.h b/net/unified.h
new file mode 100644
index 0000000000..97ec743f0e
--- /dev/null
+++ b/net/unified.h
@@ -0,0 +1,118 @@
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
+typedef struct NetUnifiedState {
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
+} NetUnifiedState;
+
+extern NetClientState *qemu_new_unified_net_client(const char *name,
+                    NetClientState *peer);
+
+extern void qemu_net_finalize_unified_init(NetUnifiedState *s, int fd);
+#endif
diff --git a/net/vxlan-static.c b/net/vxlan-static.c
new file mode 100644
index 0000000000..11265897fb
--- /dev/null
+++ b/net/vxlan-static.c
@@ -0,0 +1,229 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ * Copyright (c) 2012-2014 Cisco Systems
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
+#include "unified.h"
+
+
+/* vxlan header RRRRIRRR in top byte, 3 bytes reserved */
+#define HEADER_RESERVED 24
+#define VNID_RESERVED 8
+#define VXLAN_BIT 3
+#define VXLAN_DATA_PACKET (1 << (HEADER_RESERVED + VXLAN_BIT))
+#define VNID_OFFSET 4
+#define VXLAN_HEADER_SIZE 8
+
+typedef struct VXLANTunnelParams {
+
+    /* Rather skimpy - VXLAN is very simple at present */
+
+    uint32_t vnid;
+
+} VXLANTunnelParams;
+
+
+
+static void vxlan_form_header(void *us)
+{
+    NetUnifiedState *s = (NetUnifiedState *) us;
+    VXLANTunnelParams *p = (VXLANTunnelParams *) s->params;
+
+    stl_be_p((uint32_t *) s->header_buf, VXLAN_DATA_PACKET);
+    stl_be_p(
+            (uint32_t *) (s->header_buf + VNID_OFFSET),
+            p->vnid
+        );
+}
+static int vxlan_verify_header(void *us, uint8_t *buf)
+{
+
+    NetUnifiedState *s = (NetUnifiedState *) us;
+    VXLANTunnelParams *p = (VXLANTunnelParams *) s->params;
+    uint32_t header;
+    uint32_t vnid;
+
+    header = ldl_be_p(buf);
+    if ((header & VXLAN_DATA_PACKET) == 0) {
+        if (!s->header_mismatch) {
+            error_report(
+                "header type disagreement, expecting %0x, got %0x",
+                VXLAN_DATA_PACKET, header
+            );
+        }
+        return -1;
+    }
+
+    vnid = ldl_be_p(buf + VNID_OFFSET);
+    if (vnid != p->vnid) {
+        if (!s->header_mismatch) {
+            error_report("unknown vnid id %0x, expecting %0x", vnid, p->vnid);
+        }
+        return -1;
+    }
+    return 0;
+}
+
+int net_init_vxlan(const Netdev *netdev,
+                    const char *name,
+                    NetClientState *peer, Error **errp)
+{
+    /* FIXME error_setg(errp, ...) on failure */
+    const NetdevVXLANOptions *vxlan;
+    NetUnifiedState *s;
+    NetClientState *nc;
+    VXLANTunnelParams *p;
+
+    int fd = -1, gairet;
+    struct addrinfo hints;
+    struct addrinfo *result = NULL;
+    const char *default_port = "4789";
+    const char *srcport;
+    const char *dstport;
+
+    nc = qemu_new_unified_net_client(name, peer);
+
+    s = DO_UPCAST(NetUnifiedState, nc, nc);
+
+    p = g_malloc(sizeof(VXLANTunnelParams));
+
+    s->params = p;
+
+    s->form_header = &vxlan_form_header;
+    s->verify_header = &vxlan_verify_header;
+    s->queue_head = 0;
+    s->queue_tail = 0;
+    s->header_mismatch = false;
+    s->header_size = VXLAN_HEADER_SIZE;
+
+    assert(netdev->type == NET_CLIENT_DRIVER_VXLAN);
+    vxlan = &netdev->u.vxlan;
+
+    if (vxlan->has_srcport) {
+        srcport = vxlan->srcport;
+    } else {
+        srcport = default_port;
+    }
+
+    if (vxlan->has_dstport) {
+        dstport = vxlan->dstport;
+    } else {
+        dstport = default_port;
+    }
+    s->offset = VXLAN_HEADER_SIZE;
+
+    /* we store it shifted to the correct position, so we do not need
+     * to recompute it each time
+     */
+
+    p->vnid = vxlan->vnid << VNID_RESERVED;
+
+    memset(&hints, 0, sizeof(hints));
+
+    if (vxlan->has_ipv6) {
+        hints.ai_family = AF_INET6;
+    } else {
+        hints.ai_family = AF_INET;
+    }
+
+    hints.ai_socktype = SOCK_DGRAM;
+    hints.ai_protocol = 0;
+
+    gairet = getaddrinfo(vxlan->src, srcport, &hints, &result);
+
+    if ((gairet != 0) || (result == NULL)) {
+        error_report(
+            "vxlan_open : could not resolve src, errno = %s",
+            gai_strerror(gairet)
+        );
+        goto outerr;
+    }
+    fd = socket(result->ai_family, result->ai_socktype, result->ai_protocol);
+    if (fd == -1) {
+        fd = -errno;
+        error_report("vxlan_open : socket creation failed, errno = %d", -fd);
+        goto outerr;
+    }
+    if (bind(fd, (struct sockaddr *) result->ai_addr, result->ai_addrlen)) {
+        error_report("vxlan_open :  could not bind socket err=%i", errno);
+        goto outerr;
+    }
+    if (result) {
+        freeaddrinfo(result);
+    }
+
+    memset(&hints, 0, sizeof(hints));
+
+    if (vxlan->has_ipv6) {
+        hints.ai_family = AF_INET6;
+    } else {
+        hints.ai_family = AF_INET;
+    }
+    hints.ai_socktype = SOCK_DGRAM;
+    hints.ai_protocol = 0;
+
+    result = NULL;
+    gairet = getaddrinfo(vxlan->dst, dstport, &hints, &result);
+    if ((gairet != 0) || (result == NULL)) {
+        error_report(
+            "vxlan_open : could not resolve dst, error = %s",
+            gai_strerror(gairet)
+        );
+        goto outerr;
+    }
+
+    s->dgram_dst = g_new0(struct sockaddr_storage, 1);
+    memcpy(s->dgram_dst, result->ai_addr, result->ai_addrlen);
+    s->dst_size = result->ai_addrlen;
+
+    if (result) {
+        freeaddrinfo(result);
+    }
+
+    qemu_net_finalize_unified_init(s, fd);
+
+    snprintf(s->nc.info_str, sizeof(s->nc.info_str),
+             "vxlan: connected");
+    return 0;
+outerr:
+    qemu_del_net_client(nc);
+    if (fd >= 0) {
+        close(fd);
+    }
+    if (result) {
+        freeaddrinfo(result);
+    }
+    return -1;
+}
+
diff --git a/qapi-schema.json b/qapi-schema.json
index ab438ead70..40ef09dded 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -2785,6 +2785,57 @@
 ##
 { 'command': 'migrate_set_speed', 'data': {'value': 'int'} }
 
+
+##
+# @NetdevRawOptions:
+#
+# Connect the VLAN to an network interface using raw sockets
+#
+# @ifname: network interface name
+#
+
+# Since 2.9
+##
+{ 'struct': 'NetdevRawOptions',
+  'data': {
+    'ifname':          'str'
+} }
+
+##
+# @NetdevGREOptions:
+#
+# Connect the VLAN to Ethernet over Ethernet over GRE (GRETAP) tunnel
+#
+# @src: source address
+#
+# @dst: destination address
+#
+# @ipv6: force the use of ipv6
+#
+# @sequence: have sequence counter
+#
+# @pinsequence: pin sequence counter to zero -
+#              workaround for buggy implementations or
+#              networks with packet reorder
+#
+# @txkey: 32 bit transmit key
+#
+# @rxkey: 32 bit receive key
+#
+# Note - gre checksums are not supported at present
+#
+#
+# Since 2.9
+##
+{ 'struct': 'NetdevGREOptions',
+  'data': {
+    'src':          'str',
+    'dst':          'str',
+    '*ipv6':        'bool',
+    '*sequence':     'bool',
+    '*pinsequence':  'bool',
+    '*txkey':    'uint32',
+    '*rxkey':    'uint32' } }
 ##
 # @migrate-set-cache-size:
 #
@@ -3849,6 +3900,33 @@
     '*offset':      'uint32' } }
 
 ##
+# @NetdevVXLANOptions:
+#
+# Connect the VLAN to a VXLAN Static Tunnel
+#
+# @src: source address
+#
+# @dst: destination address
+#
+# @vnid: Virtual Network Identifier
+#
+# @srcport: source port
+#
+# @dstport: destination port
+#
+# @ipv6: force the use of ipv6
+##
+# Since 2.9
+{ 'struct': 'NetdevVXLANOptions',
+  'data': {
+    'src':          'str',
+    'dst':          'str',
+    '*srcport':     'str',
+    '*dstport':     'str',
+    '*ipv6':        'bool',
+    'vnid':         'uint32' } }
+
+##
 # @NetdevVdeOptions:
 #
 # Connect the VLAN to a vde switch running on the host.
@@ -3965,7 +4043,8 @@
 # Since: 2.7
 ##
 { 'enum': 'NetClientDriver',
-  'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde', 'dump',
+  'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'raw', 'gre',
+            'vxlan', 'socket', 'vde', 'dump',
             'bridge', 'hubport', 'netmap', 'vhost-user' ] }
 
 ##
@@ -3980,6 +4059,8 @@
 # Since: 1.2
 #
 # 'l2tpv3' - since 2.1
+# 'gre' - since 2.9
+# 'raw' - since 2.9
 ##
 { 'union': 'Netdev',
   'base': { 'id': 'str', 'type': 'NetClientDriver' },
@@ -3990,6 +4071,9 @@
     'user':     'NetdevUserOptions',
     'tap':      'NetdevTapOptions',
     'l2tpv3':   'NetdevL2TPv3Options',
+    'raw':      'NetdevRawOptions',
+    'gre':      'NetdevGREOptions',
+    'vxlan':    'NetdevVXLANOptions',
     'socket':   'NetdevSocketOptions',
     'vde':      'NetdevVdeOptions',
     'dump':     'NetdevDumpOptions',
@@ -4027,7 +4111,7 @@
 ##
 { 'enum': 'NetLegacyOptionsType',
   'data': ['none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
-           'dump', 'bridge', 'netmap', 'vhost-user'] }
+           'raw', 'gre', 'vxlan', 'dump', 'bridge', 'netmap', 'vhost-user'] }
 
 ##
 # @NetLegacyOptions:
@@ -4045,6 +4129,9 @@
     'user':     'NetdevUserOptions',
     'tap':      'NetdevTapOptions',
     'l2tpv3':   'NetdevL2TPv3Options',
+    'raw':      'NetdevRawOptions',
+    'gre':      'NetdevGREOptions',
+    'vxlan':    'NetdevVXLANOptions',
     'socket':   'NetdevSocketOptions',
     'vde':      'NetdevVdeOptions',
     'dump':     'NetdevDumpOptions',
-- 
2.11.0
