Received: from eggs.gnu.org ([2001:4830:134:3::10]:56443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suratiamol@gmail.com>) id 1fVUic-0001O9-T9
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 00:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suratiamol@gmail.com>) id 1fVUib-0007LC-PB
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 00:27:42 -0400
From: Amol Surati <suratiamol@gmail.com>
Date: Wed, 20 Jun 2018 09:59:29 +0530
Message-Id: <20180620042930.24208-2-suratiamol@gmail.com>
In-Reply-To: <20180620042930.24208-1-suratiamol@gmail.com>
References: <20180620042930.24208-1-suratiamol@gmail.com>
Subject: [Qemu-devel] [PATCH 1/2] ide/hw/core: fix crash on processing a
 partial-sector-size DMA xfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, Amol Surati <suratiamol@gmail.com>, "open list:IDE" <qemu-block@nongnu.org>

Fixes: https://bugs.launchpad.net/qemu/+bug/1777315

QEMU's short PRD policy applies to a DMA transfer of size < 512 bytes.
But it fails to consider transfers which are >= 512 bytes, but are
not a multiple of 512 bytes.

Such transfers are not subject to the short PRD policy. They end up
violating the assumptions about the granularity of the IO sizes,
upon which depend the verification of the completion of the previous
transfer, and the advancement of the offset in preparation of the next.

Those violations result in the crash.

By forcing each transfer to be a multiple of sector size, such
transfers are subjected to the policy, and therefore culled before they
cause the crash.

Signed-off-by: Amol Surati <suratiamol@gmail.com>
---
 hw/ide/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 2c62efc536..14d135224b 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -836,6 +836,7 @@ static void ide_dma_cb(void *opaque, int ret)
 {
     IDEState *s = opaque;
     int n;
+    int32_t size_prepared;
     int64_t sector_num;
     uint64_t offset;
     bool stay_active = false;
@@ -886,7 +887,9 @@ static void ide_dma_cb(void *opaque, int ret)
     n = s->nsector;
     s->io_buffer_index = 0;
     s->io_buffer_size = n * 512;
-    if (s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer_size) < 512) {
+    size_prepared = s->bus->dma->ops->prepare_buf(s->bus->dma,
+                                                  s->io_buffer_size);
+    if (size_prepared <= 0 || size_prepared % 512) {
         /* The PRDs were too short. Reset the Active bit, but don't raise an
          * interrupt. */
         s->status = READY_STAT | SEEK_STAT;
-- 
2.17.1
