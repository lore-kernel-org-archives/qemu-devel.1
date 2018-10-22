Received: from eggs.gnu.org ([2001:4830:134:3::10]:60412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gEZ8N-0003FP-9G
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:16:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gEZ8K-0003Op-0l
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:16:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gEZ8I-0003IX-2P
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:16:30 -0400
From: P J P <ppandit@redhat.com>
Date: Mon, 22 Oct 2018 17:44:16 +0530
Message-Id: <20181022121416.13425-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] nvme: check size before memcpy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Keith Busch <keith.busch@intel.com>, Caihongzhu <caihongzhu@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While in nvme_mmio_read, memcpy could read past the 'n->bar'
buffer, if addr offset was pointing towards its tail end.
Add check to avoid OOB access.

Reported-by: Caihongzhu <caihongzhu@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/block/nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index fc7dacb816..87afc19b61 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1059,7 +1059,7 @@ static uint64_t nvme_mmio_read(void *opaque, hwaddr addr, unsigned size)
         /* should RAZ, fall through for now */
     }
 
-    if (addr < sizeof(n->bar)) {
+    if (addr + size <= sizeof(n->bar)) {
         memcpy(&val, ptr + addr, size);
     } else {
         NVME_GUEST_ERR(nvme_ub_mmiord_invalid_ofs,
-- 
2.17.2
