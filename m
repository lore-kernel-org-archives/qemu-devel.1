Received: from eggs.gnu.org ([2001:4830:134:3::10]:40617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1duT9W-0004P3-4B
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1duT9M-0005bH-3m
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40638
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1duT9L-0005ac-Un
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:00 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8K0haxN108285
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 20:45:59 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d3brr6mqd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 20:45:59 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 19 Sep 2017 18:45:58 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 19 Sep 2017 19:45:10 -0500
In-Reply-To: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
References: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20170920004521.9417-2-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 01/12] slirp: fix clearing ifq_so from pending
 packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, Peter Maydell <peter.maydell@linaro.org>

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

The if_fastq and if_batchq contain not only packets, but queues of packet=
s
for the same socket. When sofree frees a socket, it thus has to clear ifq=
_so
from all the packets from the queues, not only the first.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 1201d308519f1e915866d7583d5136d03cc1d384)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 slirp/socket.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/slirp/socket.c b/slirp/socket.c
index ecec0295a9..cb7b5b608d 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -60,29 +60,36 @@ socreate(Slirp *slirp)
 }
=20
 /*
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
+/*
  * remque and free a socket, clobber cache
  */
 void
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
2.11.0
