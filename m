Received: from eggs.gnu.org ([2001:4830:134:3::10]:55648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZD-00006x-3e
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZC-0006qn-C1
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:43 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cRVZC-0006qe-9L
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:42 -0500
Received: by mail-qk0-x243.google.com with SMTP id 11so961044qkl.0
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 18:56:42 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 11 Jan 2017 18:55:58 -0800
Message-Id: <20170112025606.27332-23-rth@twiddle.net>
In-Reply-To: <20170112025606.27332-1-rth@twiddle.net>
References: <20170112025606.27332-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 22/30] target-sparc: allow 256M sized pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com, mark.cave-ayland@ilande.co.uk, peter.maydell@linaro.org

From: Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <18b3a791b00745313e47347b5221ae7d534a7d36.1484165352.git.atar4qemu@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
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
2.9.3
