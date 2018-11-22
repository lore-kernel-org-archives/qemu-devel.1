Received: from eggs.gnu.org ([2001:4830:134:3::10]:37308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPsFY-0001rP-AK
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:54:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPsFW-0000ze-4a
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:54:44 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 22 Nov 2018 17:54:13 +0100
Message-Id: <20181122165417.23894-10-kwolf@redhat.com>
In-Reply-To: <20181122165417.23894-1-kwolf@redhat.com>
References: <20181122165417.23894-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/13] nvme: call blk_drain in NVMe reset code
 to avoid lockups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Igor Druzhinin <igor.druzhinin@citrix.com>

When blk_flush called in NVMe reset path S/C queues are already freed
which means that re-entering AIO handling loop having some IO requests
unfinished will lockup or crash as their SG structures being potentially
reused. Call blk_drain before freeing the queues to avoid this nasty
scenario.

Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index d0226e7fdc..28d284346d 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -797,6 +797,8 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
 {
     int i;
=20
+    blk_drain(n->conf.blk);
+
     for (i =3D 0; i < n->num_queues; i++) {
         if (n->sq[i] !=3D NULL) {
             nvme_free_sq(n->sq[i], n);
--=20
2.19.1
