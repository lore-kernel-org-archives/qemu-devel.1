Received: from eggs.gnu.org ([2001:4830:134:3::10]:54081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dYGsU-0007J9-05
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:12:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dYGsQ-0007n6-5f
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:12:49 -0400
Received: from ivanoab5.miniserver.com ([78.31.111.25]:42622
	helo=www.kot-begemot.co.uk)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1dYGsP-0007mb-PC
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:12:46 -0400
From: anton.ivanov@cambridgegreys.com
Date: Thu, 20 Jul 2017 20:12:25 +0100
Message-Id: <20170720191228.12342-3-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20170720191228.12342-1-anton.ivanov@cambridgegreys.com>
References: <20170720191228.12342-1-anton.ivanov@cambridgegreys.com>
Subject: [Qemu-devel] [PATCH v2 2/5] Migrate l2tpv3 to UDST Backend
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

1. Migrate L2TPv3 transport to the Unified Datagram Socket
Transport Backend.

2. Make v4/v6 behaviour identical to all other transports

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 net/l2tpv3.c     | 566 +++++++++++--------------------------------------------
 qapi-schema.json |   1 +
 qemu-options.hx  |   9 +-
 3 files changed, 117 insertions(+), 459 deletions(-)

diff --git a/net/l2tpv3.c b/net/l2tpv3.c
index 6745b78990..f52e0339a4 100644
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
@@ -30,23 +31,14 @@
 #include "clients.h"
 #include "qemu-common.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
 #include "qemu/option.h"
 #include "qemu/sockets.h"
 #include "qemu/iov.h"
 #include "qemu/main-loop.h"
+#include "udst.h"
 
 
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
@@ -57,31 +49,7 @@
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
@@ -90,229 +58,74 @@ typedef struct NetL2TPV3State {
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
+    bool ipv4;
     bool udp;
     bool has_counter;
     bool pin_counter;
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
+    NetUdstState *s = (NetUdstState *) us;
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
+            stl_be_p(counter, ++p->counter);
         }
     }
 }
 
-static ssize_t net_l2tpv3_receive_dgram_iov(NetClientState *nc,
-                    const struct iovec *iov,
-                    int iovcnt)
-{
-    NetL2TPV3State *s = DO_UPCAST(NetL2TPV3State, nc, nc);
 
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
-        }
-    }
-    return ret;
-}
-
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
-
-static int l2tpv3_verify_header(NetL2TPV3State *s, uint8_t *buf)
+static int l2tpv3_verify_header(void *us, uint8_t *buf)
 {
 
+    NetUdstState *s = (NetUdstState *) us;
+    L2TPV3TunnelParams *p = (L2TPV3TunnelParams *) s->params;
     uint32_t *session;
     uint64_t cookie;
 
-    if ((!s->udp) && (!s->ipv6)) {
+    if ((!p->udp) && (!p->ipv6)) {
         buf += sizeof(struct iphdr) /* fix for ipv4 raw */;
     }
 
@@ -321,21 +134,21 @@ static int l2tpv3_verify_header(NetL2TPV3State *s, uint8_t *buf)
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
@@ -344,214 +157,47 @@ static int l2tpv3_verify_header(NetL2TPV3State *s, uint8_t *buf)
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
-    /* FIXME error_setg(errp, ...) on failure */
     const NetdevL2TPv3Options *l2tpv3;
-    NetL2TPV3State *s;
+    NetUdstState *s;
     NetClientState *nc;
+    L2TPV3TunnelParams *p;
+
     int fd = -1, gairet;
     struct addrinfo hints;
     struct addrinfo *result = NULL;
     char *srcport, *dstport;
 
-    nc = qemu_new_net_client(&net_l2tpv3_info, peer, "l2tpv3", name);
+    nc = qemu_new_udst_net_client(name, peer);
+
+    s = DO_UPCAST(NetUdstState, nc, nc);
 
-    s = DO_UPCAST(NetL2TPV3State, nc, nc);
+    p = g_malloc(sizeof(L2TPV3TunnelParams));
 
-    s->queue_head = 0;
-    s->queue_tail = 0;
-    s->header_mismatch = false;
+    s->params = p;
 
     assert(netdev->type == NET_CLIENT_DRIVER_L2TPV3);
     l2tpv3 = &netdev->u.l2tpv3;
 
+    if ((l2tpv3->has_ipv4 && l2tpv3->ipv4) &&
+            (l2tpv3->has_ipv6 && l2tpv3->ipv6)) {
+        error_report("please choose either ipv4 or ipv6");
+        goto outerr;
+    }
+
     if (l2tpv3->has_ipv6 && l2tpv3->ipv6) {
-        s->ipv6 = l2tpv3->ipv6;
+        p->ipv6 = l2tpv3->ipv6;
+    } else {
+        p->ipv6 = false;
+    }
+
+    if (l2tpv3->has_ipv4 && l2tpv3->ipv4) {
+        p->ipv4 = l2tpv3->ipv4;
     } else {
-        s->ipv6 = false;
+        p->ipv4 = false;
     }
 
     if ((l2tpv3->has_offset) && (l2tpv3->offset > 256)) {
@@ -561,22 +207,22 @@ int net_init_l2tpv3(const Netdev *netdev,
 
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
@@ -585,52 +231,56 @@ int net_init_l2tpv3(const Netdev *netdev,
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
-        hints.ai_family = AF_INET;
+        if (p->ipv4) {
+            hints.ai_family = AF_INET;
+        } else {
+            hints.ai_family = AF_UNSPEC;
+        }
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
@@ -645,6 +295,16 @@ int net_init_l2tpv3(const Netdev *netdev,
         );
         goto outerr;
     }
+
+    /* Update flags to match actual result of name resolution */
+
+    if (result->ai_family == AF_INET) {
+        p->ipv4 = true;
+        p->ipv6 = false;
+    } else {
+        p->ipv6 = true;
+        p->ipv4 = false;
+    }
     fd = socket(result->ai_family, result->ai_socktype, result->ai_protocol);
     if (fd == -1) {
         fd = -errno;
@@ -661,12 +321,12 @@ int net_init_l2tpv3(const Netdev *netdev,
 
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
@@ -693,17 +353,17 @@ int net_init_l2tpv3(const Netdev *netdev,
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
@@ -711,27 +371,23 @@ int net_init_l2tpv3(const Netdev *netdev,
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
+    qemu_net_finalize_udst_init(s,
+        &l2tpv3_verify_header,
+        &l2tpv3_form_header,
+        fd);
+    p->counter = 0;
 
     snprintf(s->nc.info_str, sizeof(s->nc.info_str),
              "l2tpv3: connected");
     return 0;
 outerr:
+    error_setg(errp, "Cannot initialize L2TPv3 transport");
     qemu_del_net_client(nc);
     if (fd >= 0) {
         close(fd);
diff --git a/qapi-schema.json b/qapi-schema.json
index 62a044f006..91e27ca2b0 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3842,6 +3842,7 @@
     'dst':          'str',
     '*srcport':     'str',
     '*dstport':     'str',
+    '*ipv4':        'bool',
     '*ipv6':        'bool',
     '*udp':         'bool',
     '*cookie64':    'bool',
diff --git a/qemu-options.hx b/qemu-options.hx
index 9caf53fd76..20e0df6e9c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1947,8 +1947,8 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
 #endif
 #ifdef CONFIG_UDST
     "-netdev l2tpv3,id=str,src=srcaddr,dst=dstaddr[,srcport=srcport][,dstport=dstport]\n"
-    "         [,rxsession=rxsession],txsession=txsession[,ipv6=on/off][,udp=on/off]\n"
-    "         [,cookie64=on/off][,counter][,pincounter][,txcookie=txcookie]\n"
+    "         [,rxsession=rxsession],txsession=txsession[,ipv6=on/off][,ipv4=on/off]\n"
+    "         [,udp=on/off][,cookie64=on/off][,counter][,pincounter][,txcookie=txcookie]\n"
     "         [,rxcookie=rxcookie][,offset=offset]\n"
     "                configure a network backend with ID 'str' connected to\n"
     "                an Ethernet over L2TPv3 pseudowire.\n"
@@ -1963,6 +1963,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "                use 'srcport=' to specify source udp port\n"
     "                use 'dstport=' to specify destination udp port\n"
     "                use 'ipv6=on' to force v6\n"
+    "                use 'ipv4=on' to force v4\n"
     "                L2TPv3 uses cookies to prevent misconfiguration as\n"
     "                well as a weak security measure\n"
     "                use 'rxcookie=0x012345678' to specify a rxcookie\n"
@@ -2345,8 +2346,8 @@ qemu-system-i386 linux.img \
                  -net socket,mcast=239.192.168.1:1102,localaddr=1.2.3.4
 @end example
 
-@item -netdev l2tpv3,id=@var{id},src=@var{srcaddr},dst=@var{dstaddr}[,srcport=@var{srcport}][,dstport=@var{dstport}],txsession=@var{txsession}[,rxsession=@var{rxsession}][,ipv6][,udp][,cookie64][,counter][,pincounter][,txcookie=@var{txcookie}][,rxcookie=@var{rxcookie}][,offset=@var{offset}]
-@itemx -net l2tpv3[,vlan=@var{n}][,name=@var{name}],src=@var{srcaddr},dst=@var{dstaddr}[,srcport=@var{srcport}][,dstport=@var{dstport}],txsession=@var{txsession}[,rxsession=@var{rxsession}][,ipv6][,udp][,cookie64][,counter][,pincounter][,txcookie=@var{txcookie}][,rxcookie=@var{rxcookie}][,offset=@var{offset}]
+@item -netdev l2tpv3,id=@var{id},src=@var{srcaddr},dst=@var{dstaddr}[,srcport=@var{srcport}][,dstport=@var{dstport}],txsession=@var{txsession}[,rxsession=@var{rxsession}][,ipv6][,ipv4][,udp][,cookie64][,counter][,pincounter][,txcookie=@var{txcookie}][,rxcookie=@var{rxcookie}][,offset=@var{offset}]
+@itemx -net l2tpv3[,vlan=@var{n}][,name=@var{name}],src=@var{srcaddr},dst=@var{dstaddr}[,srcport=@var{srcport}][,dstport=@var{dstport}],txsession=@var{txsession}[,rxsession=@var{rxsession}][,ipv6][,ipv4][,udp][,cookie64][,counter][,pincounter][,txcookie=@var{txcookie}][,rxcookie=@var{rxcookie}][,offset=@var{offset}]
 Connect VLAN @var{n} to L2TPv3 pseudowire. L2TPv3 (RFC3391) is a popular
 protocol to transport Ethernet (and other Layer 2) data frames between
 two systems. It is present in routers, firewalls and the Linux kernel
-- 
2.11.0
