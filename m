Received: from eggs.gnu.org ([2001:4830:134:3::10]:33625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gEZDD-0005fr-ER
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gEZD8-0007gT-JU
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:21:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gEZD3-0007Xq-8T
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:21:27 -0400
From: P J P <ppandit@redhat.com>
Date: Mon, 22 Oct 2018 17:49:07 +0530
Message-Id: <20181022121907.13635-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] ppc/pnv: check size before data buffer
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
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Moguofang <moguofang@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While performing PowerNV memory r/w operations, the access length
'sz' could exceed the data[4] buffer size. Add check to avoid OOB
access.

Reported-by: Moguofang <moguofang@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/ppc/pnv_lpc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index d7721320a2..f5e5bd4053 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -158,6 +158,10 @@ static void pnv_lpc_do_eccb(PnvLpcController *lpc, uint64_t cmd)
     uint8_t data[4];
     bool success;
 
+    if (sz > sizeof(data)) {
+        return;
+    }
+
     if (cmd & ECCB_CTL_READ) {
         success = opb_read(lpc, opb_addr, data, sz);
         if (success) {
-- 
2.17.2
