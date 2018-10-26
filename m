Received: from eggs.gnu.org ([2001:4830:134:3::10]:52168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gG1LW-0007we-Hw
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 08:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gG1LS-00087z-Iy
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 08:36:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gG1LS-000878-Cz
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 08:36:06 -0400
From: P J P <ppandit@redhat.com>
Date: Fri, 26 Oct 2018 18:03:58 +0530
Message-Id: <20181026123358.2554-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v2] ppc/pnv: check size before data buffer
 access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Moguofang <moguofang@huawei.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While performing PowerNV memory r/w operations, the access length
'sz' could exceed the data[4] buffer size. Add check to avoid OOB
access.

Reported-by: Moguofang <moguofang@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/ppc/pnv_lpc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Update v2: add error log message
  -> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg05750.html

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index d7721320a2..172a915cfc 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -155,9 +155,15 @@ static void pnv_lpc_do_eccb(PnvLpcController *lpc, uint64_t cmd)
     /* XXX Check for magic bits at the top, addr size etc... */
     unsigned int sz = (cmd & ECCB_CTL_SZ_MASK) >> ECCB_CTL_SZ_LSH;
     uint32_t opb_addr = cmd & ECCB_CTL_ADDR_MASK;
-    uint8_t data[4];
+    uint8_t data[8];
     bool success;
 
+    if (sz > sizeof(data)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "ECCB: invalid operation at @0x%08x size %d\n", opb_addr, sz);
+        return;
+    }
+
     if (cmd & ECCB_CTL_READ) {
         success = opb_read(lpc, opb_addr, data, sz);
         if (success) {
-- 
2.17.2
