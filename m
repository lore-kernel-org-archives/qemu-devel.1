Received: from eggs.gnu.org ([2001:4830:134:3::10]:37255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTytW-0006ud-5G
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTytR-0002yJ-E3
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:54 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cTytR-0002xt-7r
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:49 -0500
Received: by mail-wm0-x242.google.com with SMTP id c85so7558871wmi.1
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:39:49 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 18 Jan 2017 23:38:36 +0100
Message-Id: <1484779123-18968-24-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
References: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
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
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, rth@twiddle.net, Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/ldst_helper.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index d4eee33..4f55388 100644
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
2.7.2
