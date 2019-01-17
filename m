Received: from eggs.gnu.org ([209.51.188.92]:58017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk67d-0006nl-BG
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:46:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk67b-0005zf-9B
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:46:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gk67Z-0005xT-BO
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:46:06 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 17 Jan 2019 15:43:54 +0400
Message-Id: <20190117114359.5164-23-marcandre.lureau@redhat.com>
In-Reply-To: <20190117114359.5164-1-marcandre.lureau@redhat.com>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 22/27] slirp: improve send_packet() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, pbonzini@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>

Use a more descriptive name for the callback.

Reuse the SlirpWriteCb type. Wrap it to check that all data has been writ=
ten.

Return a ssize_t for potential error handling and data-loss reporting.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/net/net.h |  2 +-
 slirp/libslirp.h  | 11 +++++++----
 slirp/slirp.h     |  2 ++
 net/net.c         |  4 ++--
 net/slirp.c       |  9 +++++----
 slirp/ncsi.c      |  2 +-
 slirp/slirp.c     | 17 ++++++++++++++---
 7 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index 643295d1637..075cc012671 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -146,7 +146,7 @@ ssize_t qemu_sendv_packet(NetClientState *nc, const s=
truct iovec *iov,
                           int iovcnt);
 ssize_t qemu_sendv_packet_async(NetClientState *nc, const struct iovec *=
iov,
                                 int iovcnt, NetPacketSent *sent_cb);
-void qemu_send_packet(NetClientState *nc, const uint8_t *buf, int size);
+ssize_t qemu_send_packet(NetClientState *nc, const uint8_t *buf, int siz=
e);
 ssize_t qemu_send_packet_raw(NetClientState *nc, const uint8_t *buf, int=
 size);
 ssize_t qemu_send_packet_async(NetClientState *nc, const uint8_t *buf,
                                int size, NetPacketSent *sent_cb);
diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 02cbec9f8be..8e5d4ed11b5 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -15,7 +15,7 @@
=20
 typedef struct Slirp Slirp;
=20
-typedef int (*SlirpWriteCb)(const void *buf, size_t len, void *opaque);
+typedef ssize_t (*SlirpWriteCb)(const void *buf, size_t len, void *opaqu=
e);
 typedef void (*SlirpTimerCb)(void *opaque);
=20
 /*
@@ -23,10 +23,13 @@ typedef void (*SlirpTimerCb)(void *opaque);
  */
 typedef struct SlirpCb {
     /*
-     * Send an ethernet frame to the guest network. The opaque parameter
-     * is the one given to slirp_init().
+     * Send an ethernet frame to the guest network. The opaque
+     * parameter is the one given to slirp_init(). The function
+     * doesn't need to send all the data and may return <len (no
+     * buffering is done on libslirp side, so the data will be dropped
+     * in this case). <0 reports an IO error.
      */
-    void (*output)(void *opaque, const uint8_t *pkt, int pkt_len);
+    SlirpWriteCb send_packet;
     /* Print a message for an error due to guest misbehavior.  */
     void (*guest_error)(const char *msg);
     /* Return the virtual clock value in nanoseconds */
diff --git a/slirp/slirp.h b/slirp/slirp.h
index 05b8364c07c..752a4cd8c81 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -269,4 +269,6 @@ struct tcpcb *tcp_drop(struct tcpcb *tp, int err);
 struct socket *
 slirp_find_ctl_socket(Slirp *slirp, struct in_addr guest_addr, int guest=
_port);
=20
+void slirp_send_packet_all(Slirp *slirp, const void *buf, size_t len);
+
 #endif
diff --git a/net/net.c b/net/net.c
index 3acbdccd61b..5dcff7fe2ab 100644
--- a/net/net.c
+++ b/net/net.c
@@ -668,9 +668,9 @@ ssize_t qemu_send_packet_async(NetClientState *sender=
,
                                              buf, size, sent_cb);
 }
=20
-void qemu_send_packet(NetClientState *nc, const uint8_t *buf, int size)
+ssize_t qemu_send_packet(NetClientState *nc, const uint8_t *buf, int siz=
e)
 {
-    qemu_send_packet_async(nc, buf, size, NULL);
+    return qemu_send_packet_async(nc, buf, size, NULL);
 }
=20
 ssize_t qemu_send_packet_raw(NetClientState *nc, const uint8_t *buf, int=
 size)
diff --git a/net/slirp.c b/net/slirp.c
index 7b4f9f5c5ee..664ff1c0022 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -108,11 +108,12 @@ static void slirp_smb_cleanup(SlirpState *s);
 static inline void slirp_smb_cleanup(SlirpState *s) { }
 #endif
=20
-static void net_slirp_output(void *opaque, const uint8_t *pkt, int pkt_l=
en)
+static ssize_t net_slirp_send_packet(const void *pkt, size_t pkt_len,
+                                     void *opaque)
 {
     SlirpState *s =3D opaque;
=20
-    qemu_send_packet(&s->nc, pkt, pkt_len);
+    return qemu_send_packet(&s->nc, pkt, pkt_len);
 }
=20
 static ssize_t net_slirp_receive(NetClientState *nc, const uint8_t *buf,=
 size_t size)
@@ -197,7 +198,7 @@ static void net_slirp_unregister_poll_fd(int fd)
 }
=20
 static const SlirpCb slirp_cb =3D {
-    .output =3D net_slirp_output,
+    .send_packet =3D net_slirp_send_packet,
     .guest_error =3D net_slirp_guest_error,
     .clock_get_ns =3D net_slirp_clock_get_ns,
     .timer_new =3D net_slirp_timer_new,
@@ -780,7 +781,7 @@ static void guestfwd_read(void *opaque, const uint8_t=
 *buf, int size)
     slirp_socket_recv(fwd->slirp, fwd->server, fwd->port, buf, size);
 }
=20
-static int guestfwd_write(const void *buf, size_t len, void *chr)
+static ssize_t guestfwd_write(const void *buf, size_t len, void *chr)
 {
     return qemu_chr_fe_write_all(chr, buf, len);
 }
diff --git a/slirp/ncsi.c b/slirp/ncsi.c
index 327f17543ce..359f52c2840 100644
--- a/slirp/ncsi.c
+++ b/slirp/ncsi.c
@@ -162,5 +162,5 @@ void ncsi_input(Slirp *slirp, const uint8_t *pkt, int=
 pkt_len)
     *pchecksum =3D htonl(checksum);
     ncsi_rsp_len +=3D 4;
=20
-    slirp->cb->output(slirp->opaque, ncsi_reply, ETH_HLEN + ncsi_rsp_len=
);
+    slirp_send_packet_all(slirp, ncsi_reply, ETH_HLEN + ncsi_rsp_len);
 }
diff --git a/slirp/slirp.c b/slirp/slirp.c
index c7e15e88c0c..f42d31fb632 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -800,7 +800,7 @@ static void arp_input(Slirp *slirp, const uint8_t *pk=
t, int pkt_len)
             rah->ar_sip =3D ah->ar_tip;
             memcpy(rah->ar_tha, ah->ar_sha, ETH_ALEN);
             rah->ar_tip =3D ah->ar_sip;
-            slirp->cb->output(slirp->opaque, arp_reply, sizeof(arp_reply=
));
+            slirp_send_packet_all(slirp, arp_reply, sizeof(arp_reply));
         }
         break;
     case ARPOP_REPLY:
@@ -900,7 +900,7 @@ static int if_encap4(Slirp *slirp, struct mbuf *ifm, =
struct ethhdr *eh,
             /* target IP */
             rah->ar_tip =3D iph->ip_dst.s_addr;
             slirp->client_ipaddr =3D iph->ip_dst;
-            slirp->cb->output(slirp->opaque, arp_req, sizeof(arp_req));
+            slirp_send_packet_all(slirp, arp_req, sizeof(arp_req));
             ifm->resolution_requested =3D true;
=20
             /* Expire request and drop outgoing packet after 1 second */
@@ -985,7 +985,7 @@ int if_encap(Slirp *slirp, struct mbuf *ifm)
               eh->h_dest[0], eh->h_dest[1], eh->h_dest[2],
               eh->h_dest[3], eh->h_dest[4], eh->h_dest[5]);
     memcpy(buf + sizeof(struct ethhdr), ifm->m_data, ifm->m_len);
-    slirp->cb->output(slirp->opaque, buf, ifm->m_len + ETH_HLEN);
+    slirp_send_packet_all(slirp, buf, ifm->m_len + ETH_HLEN);
     return 1;
 }
=20
@@ -1152,3 +1152,14 @@ void slirp_socket_recv(Slirp *slirp, struct in_add=
r guest_addr, int guest_port,
     if (ret > 0)
         tcp_output(sototcpcb(so));
 }
+
+void slirp_send_packet_all(Slirp *slirp, const void *buf, size_t len)
+{
+    ssize_t ret =3D slirp->cb->send_packet(buf, len, slirp->opaque);
+
+    if (ret < 0) {
+        g_critical("Failed to send packet, ret: %zd", ret);
+    } else if (ret < len) {
+        DEBUG_ERROR("send_packet() didn't send all data: %zd < %zu", ret=
, len);
+    }
+}
--=20
2.20.1.98.gecbdaf0899
