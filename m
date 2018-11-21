Received: from eggs.gnu.org ([2001:4830:134:3::10]:50821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPafV-0004wy-22
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:08:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPafQ-0002JW-CH
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:08:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gPafQ-0002Ih-5P
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:08:16 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Nov 2018 02:06:28 +0400
Message-Id: <20181121220647.18844-12-marcandre.lureau@redhat.com>
In-Reply-To: <20181121220647.18844-1-marcandre.lureau@redhat.com>
References: <20181121220647.18844-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-3.2 v2 11/30] slirp: add clock_get_ns()
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/libslirp.h |  2 ++
 net/slirp.c      |  6 ++++++
 slirp/if.c       |  2 +-
 slirp/ip6_icmp.c |  4 ++--
 slirp/slirp.c    | 12 +++++-------
 5 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index d7c2b1ae71..ea019828e8 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -17,6 +17,8 @@ typedef struct SlirpCb {
     void (*output)(void *opaque, const uint8_t *pkt, int pkt_len);
     /* Print a message for an error due to guest misbehavior.  */
     void (*guest_error)(const char *msg);
+    /* Return the virtual clock value in nanoseconds */
+    int64_t (*clock_get_ns)(void);
 } SlirpCb;
=20
=20
diff --git a/net/slirp.c b/net/slirp.c
index 6eeb54d7b1..c7062b51c2 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -163,9 +163,15 @@ static void net_slirp_guest_error(const char *msg)
     qemu_log_mask(LOG_GUEST_ERROR, "%s", msg);
 }
=20
+static int64_t net_slirp_clock_get_ns(void)
+{
+    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+}
+
 static const SlirpCb slirp_cb =3D {
     .output =3D net_slirp_output,
     .guest_error =3D net_slirp_guest_error,
+    .clock_get_ns =3D net_slirp_clock_get_ns,
 };
=20
 static int net_slirp_init(NetClientState *peer, const char *model,
diff --git a/slirp/if.c b/slirp/if.c
index ce4f5fac53..73e3705740 100644
--- a/slirp/if.c
+++ b/slirp/if.c
@@ -148,7 +148,7 @@ diddit:
  */
 void if_start(Slirp *slirp)
 {
-    uint64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    uint64_t now =3D slirp->cb->clock_get_ns();
     bool from_batchq =3D false;
     struct mbuf *ifm, *ifm_next, *ifqt;
=20
diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index 595a62c8d4..6e2d952f17 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -17,7 +17,7 @@ static void ra_timer_handler(void *opaque)
 {
     Slirp *slirp =3D opaque;
     timer_mod(slirp->ra_timer,
-              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + NDP_Interval);
+              slirp->cb->clock_get_ns() / SCALE_MS + NDP_Interval);
     ndp_send_ra(slirp);
 }
=20
@@ -31,7 +31,7 @@ void icmp6_init(Slirp *slirp)
                                      SCALE_MS, QEMU_TIMER_ATTR_EXTERNAL,
                                      ra_timer_handler, slirp);
     timer_mod(slirp->ra_timer,
-              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + NDP_Interval);
+              slirp->cb->clock_get_ns() / SCALE_MS + NDP_Interval);
 }
=20
 void icmp6_cleanup(Slirp *slirp)
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 9ace0e3d4b..76b1f2f3e0 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -573,15 +573,15 @@ void slirp_pollfds_fill(GArray *pollfds, uint32_t *=
timeout)
=20
 void slirp_pollfds_poll(GArray *pollfds, int select_error)
 {
-    Slirp *slirp;
+    Slirp *slirp =3D QTAILQ_FIRST(&slirp_instances);
     struct socket *so, *so_next;
     int ret;
=20
-    if (QTAILQ_EMPTY(&slirp_instances)) {
+    if (!slirp) {
         return;
     }
=20
-    curtime =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+    curtime =3D slirp->cb->clock_get_ns() / SCALE_MS;
=20
     QTAILQ_FOREACH(slirp, &slirp_instances, entry) {
         /*
@@ -908,8 +908,7 @@ static int if_encap4(Slirp *slirp, struct mbuf *ifm, =
struct ethhdr *eh,
             ifm->resolution_requested =3D true;
=20
             /* Expire request and drop outgoing packet after 1 second */
-            ifm->expiration_date =3D
-                qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 1000000000ULL;
+            ifm->expiration_date =3D slirp->cb->clock_get_ns() + 1000000=
000ULL;
         }
         return 0;
     } else {
@@ -935,8 +934,7 @@ static int if_encap6(Slirp *slirp, struct mbuf *ifm, =
struct ethhdr *eh,
         if (!ifm->resolution_requested) {
             ndp_send_ns(slirp, ip6h->ip_dst);
             ifm->resolution_requested =3D true;
-            ifm->expiration_date =3D
-                qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 1000000000ULL;
+            ifm->expiration_date =3D slirp->cb->clock_get_ns() + 1000000=
000ULL;
         }
         return 0;
     } else {
--=20
2.20.0.rc1
