Received: from eggs.gnu.org ([2001:4830:134:3::10]:40982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZORX-0000gN-GK
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gZORW-0005FY-H4
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:27 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:57916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gZORP-0004yG-7Z
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:06:21 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 19 Dec 2018 00:04:27 +0100
Message-Id: <20181218230442.27887-50-samuel.thibault@ens-lyon.org>
In-Reply-To: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
References: <20181218230442.27887-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 49/64] slirp: use virtual time for packet
 expiration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Make all packets expiration time based on virtual clock.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
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
index 4949d17c73..91210dc00a 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -582,7 +582,7 @@ void slirp_pollfds_poll(GArray *pollfds, int select_e=
rror)
         return;
     }
=20
-    curtime =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    curtime =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
=20
     QTAILQ_FOREACH(slirp, &slirp_instances, entry) {
         /*
@@ -909,7 +909,8 @@ static int if_encap4(Slirp *slirp, struct mbuf *ifm, =
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
@@ -936,7 +937,7 @@ static int if_encap6(Slirp *slirp, struct mbuf *ifm, =
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
2.19.2
