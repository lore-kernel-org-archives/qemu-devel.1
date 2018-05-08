Received: from eggs.gnu.org ([2001:4830:134:3::10]:44228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fG6Td-00009h-8c
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fG6Tc-0005YK-7R
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:37 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:39206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fG6Tb-0005Y3-W5
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:36 -0400
Received: by mail-lf0-x241.google.com with SMTP id j193-v6so47054095lfg.6
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 10:32:35 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue,  8 May 2018 19:31:42 +0200
Message-Id: <20180508173152.29327-27-edgar.iglesias@gmail.com>
In-Reply-To: <20180508173152.29327-1-edgar.iglesias@gmail.com>
References: <20180508173152.29327-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 26/36] target-microblaze: mmu: Prepare for
 64-bit addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Prepare for 64-bit addresses.
This makes no functional difference as the upper parts of
the 64-bit addresses are not yet reachable.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/mmu.c | 14 +++++++-------
 target/microblaze/mmu.h |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 231803ceea..a379968618 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -81,16 +81,16 @@ unsigned int mmu_translate(struct microblaze_mmu *mmu,
 {
     unsigned int i, hit = 0;
     unsigned int tlb_ex = 0, tlb_wr = 0, tlb_zsel;
-    unsigned int tlb_size;
-    uint32_t tlb_tag, tlb_rpn, mask, t0;
+    uint64_t tlb_tag, tlb_rpn, mask;
+    uint32_t tlb_size, t0;
 
     lu->err = ERR_MISS;
     for (i = 0; i < ARRAY_SIZE(mmu->rams[RAM_TAG]); i++) {
-        uint32_t t, d;
+        uint64_t t, d;
 
         /* Lookup and decode.  */
         t = mmu->rams[RAM_TAG][i];
-        D(qemu_log("TLB %d valid=%d\n", i, t & TLB_VALID));
+        D(qemu_log("TLB %d valid=%" PRId64 "\n", i, t & TLB_VALID));
         if (t & TLB_VALID) {
             tlb_size = tlb_decode_size((t & TLB_PAGESZ_MASK) >> 7);
             if (tlb_size < TARGET_PAGE_SIZE) {
@@ -98,10 +98,10 @@ unsigned int mmu_translate(struct microblaze_mmu *mmu,
                 abort();
             }
 
-            mask = ~(tlb_size - 1);
+            mask = ~((uint64_t)tlb_size - 1);
             tlb_tag = t & TLB_EPN_MASK;
             if ((vaddr & mask) != (tlb_tag & mask)) {
-                D(qemu_log("TLB %d vaddr=%x != tag=%x\n",
+                D(qemu_log("TLB %d vaddr=%" PRIx64 " != tag=%" PRIx64 "\n",
                            i, vaddr & mask, tlb_tag & mask));
                 continue;
             }
@@ -173,7 +173,7 @@ unsigned int mmu_translate(struct microblaze_mmu *mmu,
         }
     }
 done:
-    D(qemu_log("MMU vaddr=%x rw=%d tlb_wr=%d tlb_ex=%d hit=%d\n",
+    D(qemu_log("MMU vaddr=%" PRIx64 " rw=%d tlb_wr=%d tlb_ex=%d hit=%d\n",
               vaddr, rw, tlb_wr, tlb_ex, hit));
     return hit;
 }
diff --git a/target/microblaze/mmu.h b/target/microblaze/mmu.h
index 624becfded..1714caf82e 100644
--- a/target/microblaze/mmu.h
+++ b/target/microblaze/mmu.h
@@ -28,7 +28,7 @@
 #define RAM_TAG      0
 
 /* Tag portion */
-#define TLB_EPN_MASK          0xFFFFFC00 /* Effective Page Number */
+#define TLB_EPN_MASK          MAKE_64BIT_MASK(10, 64 - 10)
 #define TLB_PAGESZ_MASK       0x00000380
 #define TLB_PAGESZ(x)         (((x) & 0x7) << 7)
 #define PAGESZ_1K             0
@@ -42,7 +42,7 @@
 #define TLB_VALID             0x00000040 /* Entry is valid */
 
 /* Data portion */
-#define TLB_RPN_MASK          0xFFFFFC00 /* Real Page Number */
+#define TLB_RPN_MASK          MAKE_64BIT_MASK(10, 64 - 10)
 #define TLB_PERM_MASK         0x00000300
 #define TLB_EX                0x00000200 /* Instruction execution allowed */
 #define TLB_WR                0x00000100 /* Writes permitted */
@@ -63,7 +63,7 @@
 struct microblaze_mmu
 {
     /* Data and tag brams.  */
-    uint32_t rams[2][TLB_ENTRIES];
+    uint64_t rams[2][TLB_ENTRIES];
     /* We keep a separate ram for the tids to avoid the 48 bit tag width.  */
     uint8_t tids[TLB_ENTRIES];
     /* Control flops.  */
-- 
2.14.1
