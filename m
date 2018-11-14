Received: from eggs.gnu.org ([2001:4830:134:3::10]:58806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuQr-0000BW-5J
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:38:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gMuQp-0001Ek-Jg
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:38:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gMuQp-0001CN-7R
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 07:38:07 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Nov 2018 16:36:09 +0400
Message-Id: <20181114123643.24091-8-marcandre.lureau@redhat.com>
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 07/41] slirp: add clock_get_ns()
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
Cc: samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/libslirp.h |  6 ++++++
 net/slirp.c      | 19 +++++++++++++++++++
 slirp/if.c       |  2 +-
 slirp/ip6_icmp.c |  6 ++++--
 slirp/slirp.c    | 11 ++++++-----
 5 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/slirp/libslirp.h b/slirp/libslirp.h
index 16ced2aa0f..fcebcd1e58 100644
--- a/slirp/libslirp.h
+++ b/slirp/libslirp.h
@@ -5,9 +5,15 @@
=20
 typedef struct Slirp Slirp;
=20
+typedef enum SlirpClockType {
+    SLIRP_CLOCK_VIRTUAL,
+    SLIRP_CLOCK_REALTIME,
+} SlirpClockType;
+
 typedef struct SlirpCb {
     void (*output)(void *opaque, const uint8_t *pkt, int pkt_len);
     int (*chr_write_all)(void *chr, const void *buf, size_t len);
+    int64_t (*clock_get_ns)(SlirpClockType type);
 } SlirpCb;
=20
=20
diff --git a/net/slirp.c b/net/slirp.c
index 5c1f676487..af6c643b82 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -145,9 +145,28 @@ static int net_slirp_chr_write_all(void *chr, const =
void *buf, size_t len)
     return qemu_chr_fe_write_all(chr, buf, len);
 }
=20
+static QEMUClockType slirp_clock_to_qemu(SlirpClockType type)
+{
+    switch (type) {
+    case SLIRP_CLOCK_VIRTUAL:
+        return QEMU_CLOCK_VIRTUAL;
+    case SLIRP_CLOCK_REALTIME:
+        return QEMU_CLOCK_REALTIME;
+    }
+
+    g_warn_if_reached();
+    return QEMU_CLOCK_REALTIME;
+}
+
+static int64_t net_slirp_clock_get_ns(SlirpClockType type)
+{
+    return qemu_clock_get_ns(slirp_clock_to_qemu(type));
+}
+
 static SlirpCb slirp_cb =3D {
     .output =3D net_slirp_output,
     .chr_write_all =3D net_slirp_chr_write_all,
+    .clock_get_ns =3D net_slirp_clock_get_ns,
 };
=20
 static int net_slirp_init(NetClientState *peer, const char *model,
diff --git a/slirp/if.c b/slirp/if.c
index 590753c658..1c96869831 100644
--- a/slirp/if.c
+++ b/slirp/if.c
@@ -150,7 +150,7 @@ diddit:
  */
 void if_start(Slirp *slirp)
 {
-    uint64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+    uint64_t now =3D slirp->cb->clock_get_ns(SLIRP_CLOCK_REALTIME);
     bool from_batchq =3D false;
     struct mbuf *ifm, *ifm_next, *ifqt;
=20
diff --git a/slirp/ip6_icmp.c b/slirp/ip6_icmp.c
index cd1e0b9fe1..0f80d49ef9 100644
--- a/slirp/ip6_icmp.c
+++ b/slirp/ip6_icmp.c
@@ -17,7 +17,8 @@ static void ra_timer_handler(void *opaque)
 {
     Slirp *slirp =3D opaque;
     timer_mod(slirp->ra_timer,
-              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + NDP_Interval);
+              slirp->cb->clock_get_ns(SLIRP_CLOCK_VIRTUAL) / SCALE_MS +
+              NDP_Interval);
     ndp_send_ra(slirp);
 }
=20
@@ -31,7 +32,8 @@ void icmp6_init(Slirp *slirp)
                                      SCALE_MS, QEMU_TIMER_ATTR_EXTERNAL,
                                      ra_timer_handler, slirp);
     timer_mod(slirp->ra_timer,
-              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + NDP_Interval);
+              slirp->cb->clock_get_ns(SLIRP_CLOCK_VIRTUAL) / SCALE_MS +
+              NDP_Interval);
 }
=20
 void icmp6_cleanup(Slirp *slirp)
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 4e809e5d7f..979495e88b 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -571,15 +571,15 @@ void slirp_pollfds_fill(GArray *pollfds, uint32_t *=
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
-    curtime =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    curtime =3D slirp->cb->clock_get_ns(SLIRP_CLOCK_REALTIME) / SCALE_MS=
;
=20
     QTAILQ_FOREACH(slirp, &slirp_instances, entry) {
         /*
@@ -947,7 +947,8 @@ static int if_encap4(Slirp *slirp, struct mbuf *ifm, =
struct ethhdr *eh,
             ifm->resolution_requested =3D true;
=20
             /* Expire request and drop outgoing packet after 1 second */
-            ifm->expiration_date =3D qemu_clock_get_ns(QEMU_CLOCK_REALTI=
ME) + 1000000000ULL;
+            ifm->expiration_date =3D slirp->cb->clock_get_ns(SLIRP_CLOCK=
_REALTIME)
+                + 1000000000ULL;
         }
         return 0;
     } else {
@@ -974,7 +975,7 @@ static int if_encap6(Slirp *slirp, struct mbuf *ifm, =
struct ethhdr *eh,
             ndp_send_ns(slirp, ip6h->ip_dst);
             ifm->resolution_requested =3D true;
             ifm->expiration_date =3D
-                qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + 1000000000ULL;
+                slirp->cb->clock_get_ns(SLIRP_CLOCK_REALTIME) + 10000000=
00ULL;
         }
         return 0;
     } else {
--=20
2.19.1.708.g4ede3d42df
