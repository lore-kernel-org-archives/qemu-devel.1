Received: from eggs.gnu.org ([2001:4830:134:3::10]:47975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gWi61-0002Nc-07
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 08:29:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gWi5v-0000gA-IK
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 08:29:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gWi5v-0000fm-Ae
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 08:29:03 -0500
From: P J P <ppandit@redhat.com>
Date: Tue, 11 Dec 2018 18:56:40 +0530
Message-Id: <20181211132642.3027-4-ppandit@redhat.com>
In-Reply-To: <20181211132642.3027-1-ppandit@redhat.com>
References: <20181211132642.3027-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/5] pvrdma: check number of pages when
 creating rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Yuval Shaia <yuval.shaia@oracle.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Saar Amar <saaramar5@gmail.com>, Li Qiang <liq3ea@163.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

When creating CQ/QP rings, an object can have up to
PVRDMA_MAX_FAST_REG_PAGES=3D128 pages. Check 'npages' parameter
to avoid excessive memory allocation or a null dereference.

Reported-by: Li Qiang <liq3ea@163.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/rdma/vmw/pvrdma_cmd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index 4faeb21631..ee2888259c 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -273,6 +273,10 @@ static int create_cq_ring(PCIDevice *pci_dev , Pvrdm=
aRing **ring,
         pr_dbg("Failed to map to CQ page table\n");
         goto out;
     }
+    if (!nchunks || nchunks > PVRDMA_MAX_FAST_REG_PAGES) {
+        pr_dbg("invalid nchunks: %d\n", nchunks);
+        goto out;
+    }
=20
     r =3D g_malloc(sizeof(*r));
     *ring =3D r;
@@ -389,6 +393,11 @@ static int create_qp_rings(PCIDevice *pci_dev, uint6=
4_t pdir_dma,
         pr_dbg("Failed to map to CQ page table\n");
         goto out;
     }
+    if (!spages || spages > PVRDMA_MAX_FAST_REG_PAGES
+        || !rpages || rpages > PVRDMA_MAX_FAST_REG_PAGES) {
+        pr_dbg("invalid pages: %d, %d\n", spages, rpages);
+        goto out;
+    }
=20
     sr =3D g_malloc(2 * sizeof(*rr));
     rr =3D &sr[1];
--=20
2.19.2
