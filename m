Received: from eggs.gnu.org ([2001:4830:134:3::10]:50756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPafI-0004ld-26
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:08:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPafH-0002FU-8L
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:08:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gPafH-0002F7-3O
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:08:07 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Nov 2018 02:06:27 +0400
Message-Id: <20181121220647.18844-11-marcandre.lureau@redhat.com>
In-Reply-To: <20181121220647.18844-1-marcandre.lureau@redhat.com>
References: <20181121220647.18844-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-3.2 v2 10/30] slirp: use virtual time
 for packet expiration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Make all packets expiration time based on virtual clock.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/if.c    | 2 +-
 slirp/slirp.c | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/slirp/if.c b/slirp/if.c
index aa88cc4e76..ce4f5fac53 100644
--- a/slirp/if.c
+++ b/slirp/if.c
@@ -148,7 +148,7 @@ diddit:
  */
 void if_start(Slirp *slirp)
 {
-    uint64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+    uint64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     bool from_batchq =3D false;
     struct mbuf *ifm, *ifm_next, *ifqt;
=20
diff --git a/slirp/slirp.c b/slirp/slirp.c
index cc361885ed..9ace0e3d4b 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -581,7 +581,7 @@ void slirp_pollfds_poll(GArray *pollfds, int select_e=
rror)
         return;
     }
=20
-    curtime =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    curtime =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
=20
     QTAILQ_FOREACH(slirp, &slirp_instances, entry) {
         /*
@@ -908,7 +908,8 @@ static int if_encap4(Slirp *slirp, struct mbuf *ifm, =
struct ethhdr *eh,
             ifm->resolution_requested =3D true;
=20
             /* Expire request and drop outgoing packet after 1 second */
-            ifm->expiration_date =3D qemu_clock_get_ns(QEMU_CLOCK_REALTI=
ME) + 1000000000ULL;
+            ifm->expiration_date =3D
+                qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 1000000000ULL;
         }
         return 0;
     } else {
@@ -935,7 +936,7 @@ static int if_encap6(Slirp *slirp, struct mbuf *ifm, =
struct ethhdr *eh,
             ndp_send_ns(slirp, ip6h->ip_dst);
             ifm->resolution_requested =3D true;
             ifm->expiration_date =3D
-                qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + 1000000000ULL;
+                qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 1000000000ULL;
         }
         return 0;
     } else {
--=20
2.20.0.rc1
