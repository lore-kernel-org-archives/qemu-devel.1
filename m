Received: from eggs.gnu.org ([2001:4830:134:3::10]:51004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gIOFi-0002Yn-5n
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 21:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gIOFf-0004tk-1I
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 21:27:58 -0400
From: Li Qiang <liq3ea@gmail.com>
Date: Thu,  1 Nov 2018 18:22:43 -0700
Message-Id: <1541121763-3277-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] nvme: fix oob access issue(CVE-2018-16847)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: keith.busch@intel.com, kwolf@redhat.com, mreitz@redhat.com
Cc: pbonzini@redhat.com, ppandit@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

Currently, the nvme_cmb_ops mr doesn't check the addr and size.
This can lead an oob access issue. This is triggerable in the guest.
Add check to avoid this issue.

Fixes CVE-2018-16847.

Reported-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/block/nvme.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index fc7dacb..d097add 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1175,6 +1175,10 @@ static void nvme_cmb_write(void *opaque, hwaddr addr, uint64_t data,
     unsigned size)
 {
     NvmeCtrl *n = (NvmeCtrl *)opaque;
+
+    if (addr + size > NVME_CMBSZ_GETSIZE(n->bar.cmbsz)) {
+        return;
+    }
     memcpy(&n->cmbuf[addr], &data, size);
 }
 
@@ -1183,6 +1187,9 @@ static uint64_t nvme_cmb_read(void *opaque, hwaddr addr, unsigned size)
     uint64_t val;
     NvmeCtrl *n = (NvmeCtrl *)opaque;
 
+    if (addr + size > NVME_CMBSZ_GETSIZE(n->bar.cmbsz)) {
+        return 0;
+    }
     memcpy(&val, &n->cmbuf[addr], size);
     return val;
 }
-- 
1.8.3.1
