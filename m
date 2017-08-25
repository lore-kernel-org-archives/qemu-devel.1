Received: from eggs.gnu.org ([2001:4830:134:3::10]:41570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dlNEN-000146-1f
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 18:37:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dlNEI-000573-JG
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 18:37:35 -0400
Received: from hera.aquilenet.fr ([141.255.128.1]:33178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1dlNEI-000558-C1
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 18:37:30 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat, 26 Aug 2017 00:37:21 +0200
Message-Id: <20170825223721.2052-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] slirp: fix clearing ifq_so from pending packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, f4bug@amsat.org, ppandit@redhat.com, jan.kiszka@siemens.com, thuth@redhat.com, wjjzhang@tencent.com

The if_fastq and if_batchq contain not only packets, but queues of packet=
s
for the same socket. When sofree frees a socket, it thus has to clear ifq=
_so
from all the packets from the queues, not only the first.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Acked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 slirp/socket.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/slirp/socket.c b/slirp/socket.c
index ecec0295a9..cb7b5b608d 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -59,6 +59,27 @@ socreate(Slirp *slirp)
   return(so);
 }
=20
+/*
+ * Remove references to so from the given message queue.
+ */
+static void
+soqfree(struct socket *so, struct quehead *qh)
+{
+    struct mbuf *ifq;
+
+    for (ifq =3D (struct mbuf *) qh->qh_link;
+             (struct quehead *) ifq !=3D qh;
+             ifq =3D ifq->ifq_next) {
+        if (ifq->ifq_so =3D=3D so) {
+            struct mbuf *ifm;
+            ifq->ifq_so =3D NULL;
+            for (ifm =3D ifq->ifs_next; ifm !=3D ifq; ifm =3D ifm->ifs_n=
ext) {
+                ifm->ifq_so =3D NULL;
+            }
+        }
+    }
+}
+
 /*
  * remque and free a socket, clobber cache
  */
@@ -66,23 +87,9 @@ void
 sofree(struct socket *so)
 {
   Slirp *slirp =3D so->slirp;
-  struct mbuf *ifm;
=20
-  for (ifm =3D (struct mbuf *) slirp->if_fastq.qh_link;
-       (struct quehead *) ifm !=3D &slirp->if_fastq;
-       ifm =3D ifm->ifq_next) {
-    if (ifm->ifq_so =3D=3D so) {
-      ifm->ifq_so =3D NULL;
-    }
-  }
-
-  for (ifm =3D (struct mbuf *) slirp->if_batchq.qh_link;
-       (struct quehead *) ifm !=3D &slirp->if_batchq;
-       ifm =3D ifm->ifq_next) {
-    if (ifm->ifq_so =3D=3D so) {
-      ifm->ifq_so =3D NULL;
-    }
-  }
+  soqfree(so, &slirp->if_fastq);
+  soqfree(so, &slirp->if_batchq);
=20
   if (so->so_emu=3D=3DEMU_RSH && so->extra) {
 	sofree(so->extra);
--=20
2.14.1
