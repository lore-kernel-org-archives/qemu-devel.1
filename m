Received: from eggs.gnu.org ([2001:4830:134:3::10]:55180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPOX-0006vA-7A
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:21:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPOW-0001KT-FX
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:21:17 -0500
Received: from mail-wj0-x244.google.com ([2a00:1450:400c:c01::244]:35708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cRPOW-0001Je-A5
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:21:16 -0500
Received: by mail-wj0-x244.google.com with SMTP id ey1so13027078wjd.2
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 12:21:16 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 11 Jan 2017 21:19:53 +0100
Message-Id: <18b3a791b00745313e47347b5221ae7d534a7d36.1484165352.git.atar4qemu@gmail.com>
In-Reply-To: <cover.1484165352.git.atar4qemu@gmail.com>
References: <cover.1484165352.git.atar4qemu@gmail.com>
In-Reply-To: <cover.1484165352.git.atar4qemu@gmail.com>
References: <cover.1484165352.git.atar4qemu@gmail.com>
Subject: [Qemu-devel] [PATCH v2 22/30] target-sparc: allow 256M sized pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/mmu_helper.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 044e88c..fa70dc0 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -456,23 +456,7 @@ static inline int ultrasparc_tag_match(SparcTLBEntry *tlb,
                                        uint64_t address, uint64_t context,
                                        hwaddr *physical)
 {
-    uint64_t mask;
-
-    switch (TTE_PGSIZE(tlb->tte)) {
-    default:
-    case 0x0: /* 8k */
-        mask = 0xffffffffffffe000ULL;
-        break;
-    case 0x1: /* 64k */
-        mask = 0xffffffffffff0000ULL;
-        break;
-    case 0x2: /* 512k */
-        mask = 0xfffffffffff80000ULL;
-        break;
-    case 0x3: /* 4M */
-        mask = 0xffffffffffc00000ULL;
-        break;
-    }
+    uint64_t mask = -(8192ULL << 3 * TTE_PGSIZE(tlb->tte));
 
     /* valid, context match, virtual address match? */
     if (TTE_IS_VALID(tlb->tte) &&
-- 
1.8.3.1
