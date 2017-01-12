Received: from eggs.gnu.org ([2001:4830:134:3::10]:55688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZG-0000Hw-Ih
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZF-0006rU-Q5
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:46 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cRVZF-0006rQ-Lr
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:45 -0500
Received: by mail-qk0-x243.google.com with SMTP id e1so952578qkh.1
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 18:56:45 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 11 Jan 2017 18:55:59 -0800
Message-Id: <20170112025606.27332-24-rth@twiddle.net>
In-Reply-To: <20170112025606.27332-1-rth@twiddle.net>
References: <20170112025606.27332-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 23/30] target-sparc: implement auto-demapping
 for UA2005 CPUs
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
Message-Id: <2bf424bff7e4dee34fcbcada4fd490205f392823.1484165352.git.atar4qemu@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sparc/ldst_helper.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 0447d4e..57b3b97 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -210,6 +210,28 @@ static void replace_tlb_1bit_lru(SparcTLBEntry *tlb,
 {
     unsigned int i, replace_used;
 
+    if (cpu_has_hypervisor(env1)) {
+        uint64_t new_vaddr = tlb_tag & ~0x1fffULL;
+        uint64_t new_size = 8192ULL << 3 * TTE_PGSIZE(tlb_tte);
+        uint32_t new_ctx = tlb_tag & 0x1fffU;
+        for (i = 0; i < 64; i++) {
+            uint32_t ctx = tlb[i].tag & 0x1fffU;
+            /* check if new mapping overlaps an existing one */
+            if (new_ctx == ctx) {
+                uint64_t vaddr = tlb[i].tag & ~0x1fffULL;
+                uint64_t size = 8192ULL << 3 * TTE_PGSIZE(tlb[i].tte);
+                if (new_vaddr == vaddr
+                    || (new_vaddr < vaddr + size
+                        && vaddr < new_vaddr + new_size)) {
+                    DPRINTF_MMU("auto demap entry [%d] %lx->%lx\n", i, vaddr,
+                                new_vaddr);
+                    replace_tlb_entry(&tlb[i], tlb_tag, tlb_tte, env1);
+                    return;
+                }
+            }
+
+        }
+    }
     /* Try replacing invalid entry */
     for (i = 0; i < 64; i++) {
         if (!TTE_IS_VALID(tlb[i].tte)) {
-- 
2.9.3
