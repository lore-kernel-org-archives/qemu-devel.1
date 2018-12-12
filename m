Received: from eggs.gnu.org ([2001:4830:134:3::10]:50187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gX8oJ-00062o-7N
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 13:00:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gX8oE-0005ro-OP
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 13:00:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gX8oE-0005qD-Go
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 13:00:34 -0500
From: P J P <ppandit@redhat.com>
Date: Wed, 12 Dec 2018 23:28:17 +0530
Message-Id: <20181212175817.815-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] pvrdma: release device resources in case of an
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Li Qiang <liq3ea@163.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

If during pvrdma device initialisation an error occurs,
pvrdma_realize() does not release memory resources, leading
to memory leakage.

Reported-by: Li Qiang <liq3ea@163.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/rdma/vmw/pvrdma_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 8a03ab4669..b65f8662df 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -579,7 +579,7 @@ static void pvrdma_shutdown_notifier(Notifier *n, voi=
d *opaque)
=20
 static void pvrdma_realize(PCIDevice *pdev, Error **errp)
 {
-    int rc;
+    int rc =3D 0;
     PVRDMADev *dev =3D PVRDMA_DEV(pdev);
     Object *memdev_root;
     bool ram_shared =3D false;
@@ -655,6 +655,7 @@ static void pvrdma_realize(PCIDevice *pdev, Error **e=
rrp)
=20
 out:
     if (rc) {
+        pvrdma_fini(pdev);
         error_append_hint(errp, "Device fail to load\n");
     }
 }
--=20
2.19.2
