Received: from eggs.gnu.org ([2001:4830:134:3::10]:45136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gXAFb-0008Gy-Bp
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:32:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gXAFa-0001Tp-F9
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:32:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gXAFa-0001TX-8I
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:32:54 -0500
From: P J P <ppandit@redhat.com>
Date: Thu, 13 Dec 2018 01:00:36 +0530
Message-Id: <20181212193039.11445-4-ppandit@redhat.com>
In-Reply-To: <20181212193039.11445-1-ppandit@redhat.com>
References: <20181212193039.11445-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/6] pvrdma: check number of pages when
 creating rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Saar Amar <saaramar5@gmail.com>, Li Qiang <liq3ea@163.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

When creating CQ/QP rings, an object can have up to
PVRDMA_MAX_FAST_REG_PAGES=3D128 pages. Check 'npages' parameter
to avoid excessive memory allocation or a null dereference.

Reported-by: Li Qiang <liq3ea@163.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/rdma/vmw/pvrdma_cmd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

Update: No change, ack'd v1
  -> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02786.html

diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index 4f616d4177..e37fb18280 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -259,6 +259,11 @@ static int create_cq_ring(PCIDevice *pci_dev , Pvrdm=
aRing **ring,
     int rc =3D -EINVAL;
     char ring_name[MAX_RING_NAME_SZ];
=20
+    if (!nchunks || nchunks > PVRDMA_MAX_FAST_REG_PAGES) {
+        pr_dbg("invalid nchunks: %d\n", nchunks);
+        return rc;
+    }
+
     pr_dbg("pdir_dma=3D0x%llx\n", (long long unsigned int)pdir_dma);
     dir =3D rdma_pci_dma_map(pci_dev, pdir_dma, TARGET_PAGE_SIZE);
     if (!dir) {
@@ -371,6 +376,12 @@ static int create_qp_rings(PCIDevice *pci_dev, uint6=
4_t pdir_dma,
     char ring_name[MAX_RING_NAME_SZ];
     uint32_t wqe_sz;
=20
+    if (!spages || spages > PVRDMA_MAX_FAST_REG_PAGES
+        || !rpages || rpages > PVRDMA_MAX_FAST_REG_PAGES) {
+        pr_dbg("invalid pages: %d, %d\n", spages, rpages);
+        return rc;
+    }
+
     pr_dbg("pdir_dma=3D0x%llx\n", (long long unsigned int)pdir_dma);
     dir =3D rdma_pci_dma_map(pci_dev, pdir_dma, TARGET_PAGE_SIZE);
     if (!dir) {
--=20
2.19.2
