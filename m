Received: from eggs.gnu.org ([2001:4830:134:3::10]:45098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gXAFW-00088h-HL
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:32:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gXAFU-0001Q0-Bk
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:32:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:8614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gXAFU-0001Pg-6C
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:32:48 -0500
From: P J P <ppandit@redhat.com>
Date: Thu, 13 Dec 2018 01:00:34 +0530
Message-Id: <20181212193039.11445-2-ppandit@redhat.com>
In-Reply-To: <20181212193039.11445-1-ppandit@redhat.com>
References: <20181212193039.11445-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/6] rdma: check num_sge does not exceed
 MAX_SGE
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

rdma back-end has scatter/gather array ibv_sge[MAX_SGE=3D4] set
to have 4 elements. A guest could send a 'PvrdmaSqWqe' ring element
with 'num_sge' set to > MAX_SGE, which may lead to OOB access issue.
Add check to avoid it.

Reported-by: Saar Amar <saaramar5@gmail.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/rdma/rdma_backend.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Update: No change, ack'd v1
  -> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02783.html

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index ae1e4dcb29..bd4710d16f 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -476,9 +476,9 @@ void rdma_backend_post_send(RdmaBackendDev *backend_d=
ev,
     }
=20
     pr_dbg("num_sge=3D%d\n", num_sge);
-    if (!num_sge) {
-        pr_dbg("num_sge=3D0\n");
-        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_NO_SGE, ctx);
+    if (!num_sge || num_sge > MAX_SGE) {
+        pr_dbg("invalid num_sge=3D%d\n", num_sge);
+        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_INV_NUM_SGE, ctx);
         return;
     }
=20
@@ -603,9 +603,9 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_d=
ev,
     }
=20
     pr_dbg("num_sge=3D%d\n", num_sge);
-    if (!num_sge) {
-        pr_dbg("num_sge=3D0\n");
-        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_NO_SGE, ctx);
+    if (!num_sge || num_sge > MAX_SGE) {
+        pr_dbg("invalid num_sge=3D%d\n", num_sge);
+        complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_INV_NUM_SGE, ctx);
         return;
     }
=20
--=20
2.19.2
