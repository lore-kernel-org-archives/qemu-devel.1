Received: from eggs.gnu.org ([2001:4830:134:3::10]:35310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fKgeW-0006G2-Ak
	for qemu-devel@nongnu.org; Mon, 21 May 2018 04:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fKgeV-00039E-Kn
	for qemu-devel@nongnu.org; Mon, 21 May 2018 04:58:48 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 21 May 2018 16:58:34 +0800
Message-Id: <20180521085834.15632-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2] nvme: Make nvme_init error handling code
 more readable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com

Coverity doesn't like the tests under fail label (report CID 1385847).
Reset the fields so the clean up order is more apparent.

Signed-off-by: Fam Zheng <famz@redhat.com>

---

v2: Don't play stupid. [Peter]
---
 block/nvme.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/nvme.c b/block/nvme.c
index 6f71122bf5..c2eb9e2a4e 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -566,6 +566,10 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
         return ret;
     }
 
+    /* Fields we've not touched should be zero-initialized by block layer
+     * already, but reset it anyway to make the error handling code easier to
+     * reason. */
+    s->regs = NULL;
     s->vfio = qemu_vfio_open_pci(device, errp);
     if (!s->vfio) {
         ret = -EINVAL;
-- 
2.14.3
