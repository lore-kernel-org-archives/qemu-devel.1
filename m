Received: from eggs.gnu.org ([2001:4830:134:3::10]:48982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eClTd-0004l8-Nm
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 06:58:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eClTd-0003TL-0z
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 06:58:33 -0500
From: P J P <ppandit@redhat.com>
Date: Thu,  9 Nov 2017 17:28:14 +0530
Message-Id: <20171109115814.28232-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH] highbank: validate register offset before
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Moguofang <moguofang@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

An 'offset' parameter sent to highbank register r/w functions
could be greater than number(NUM_REGS=0x200) of hb registers,
leading to an OOB access issue. Add check to avoid it.

Reported-by: Moguofang (Dennis mo) <moguofang@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/arm/highbank.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 354c6b25a8..94df151454 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -117,6 +117,9 @@ static void hb_regs_write(void *opaque, hwaddr offset,
         }
     }
 
+    if (offset / 4 >= NUM_REGS) {
+        return;
+    }
     regs[offset/4] = value;
 }
 
@@ -124,6 +127,10 @@ static uint64_t hb_regs_read(void *opaque, hwaddr offset,
                              unsigned size)
 {
     uint32_t *regs = opaque;
+
+    if (offset / 4 >= NUM_REGS) {
+        return 0;
+    }
     uint32_t value = regs[offset/4];
 
     if ((offset == 0x100) || (offset == 0x108) || (offset == 0x10C)) {
-- 
2.13.6
