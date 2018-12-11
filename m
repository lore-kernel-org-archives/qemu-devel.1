Received: from eggs.gnu.org ([2001:4830:134:3::10]:47923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gWi5p-0002FF-2D
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 08:28:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gWi5n-0000au-VD
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 08:28:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gWi5n-0000a8-Ow
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 08:28:55 -0500
From: P J P <ppandit@redhat.com>
Date: Tue, 11 Dec 2018 18:56:38 +0530
Message-Id: <20181211132642.3027-2-ppandit@redhat.com>
In-Reply-To: <20181211132642.3027-1-ppandit@redhat.com>
References: <20181211132642.3027-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/5] rdma: check that num_sge does not exceed
 MAX_SGE
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

rdma back-end has scatter/gather array ibv_sge[MAX_SGE=3D4] set
to have 4 elements. A guest could send a 'PvrdmaSqWqe' ring element
with 'num_sge' set to > MAX_SGE, which may lead to OOB access issue.
Add check to avoid it.

Reported-by: Saar Amar <saaramar5@gmail.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/rdma/rdma_backend.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index d7a4bbd91f..0b3b98a94c 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -311,8 +311,8 @@ void rdma_backend_post_send(RdmaBackendDev *backend_d=
ev,
     }
=20
     pr_dbg("num_sge=3D%d\n", num_sge);
-    if (!num_sge) {
-        pr_dbg("num_sge=3D0\n");
+    if (!num_sge || num_sge > MAX_SGE) {
+        pr_dbg("invalid num_sge=3D%d\n", num_sge);
         comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_NO_SGE, ctx);
         return;
     }
@@ -390,8 +390,8 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_d=
ev,
     }
=20
     pr_dbg("num_sge=3D%d\n", num_sge);
-    if (!num_sge) {
-        pr_dbg("num_sge=3D0\n");
+    if (!num_sge || num_sge > MAX_SGE) {
+        pr_dbg("invalid num_sge=3D%d\n", num_sge);
         comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_NO_SGE, ctx);
         return;
     }
--=20
2.19.2
