Received: from eggs.gnu.org ([209.51.188.92]:46768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXpR-0005jc-9X
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXpP-0003Gq-7H
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:41 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:42854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXpN-0002X6-95
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:38 -0500
Received: by mail-wr1-x434.google.com with SMTP id q18so1049192wrx.9
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:32:04 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.32.02 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:32:03 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:31:15 +0000
Message-Id: <20190107163117.16269-36-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 35/37] target/arm: Emit barriers for A32/T32
 load-acquire/store-release insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Now that MTTCG is here, the comment in the 32-bit Arm decoder that
"Since the emulation does not have barriers, the acquire/release
semantics need no special handling" is no longer true. Emit the
correct barriers for the load-acquire/store-release insns, as
we already do in the A64 decoder.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/translate.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index ed3db0c3946..66cf28c8cbe 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9733,6 +9733,8 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                     rd = (insn >> 12) & 0xf;
                     if (insn & (1 << 23)) {
                         /* load/store exclusive */
+                        bool is_ld = extract32(insn, 20, 1);
+                        bool is_lasr = !extract32(insn, 8, 1);
                         int op2 = (insn >> 8) & 3;
                         op1 = (insn >> 21) & 0x3;
 
@@ -9760,11 +9762,12 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                         addr = tcg_temp_local_new_i32();
                         load_reg_var(s, addr, rn);
 
-                        /* Since the emulation does not have barriers,
-                           the acquire/release semantics need no special
-                           handling */
+                        if (is_lasr && !is_ld) {
+                            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+                        }
+
                         if (op2 == 0) {
-                            if (insn & (1 << 20)) {
+                            if (is_ld) {
                                 tmp = tcg_temp_new_i32();
                                 switch (op1) {
                                 case 0: /* lda */
@@ -9810,7 +9813,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                                 }
                                 tcg_temp_free_i32(tmp);
                             }
-                        } else if (insn & (1 << 20)) {
+                        } else if (is_ld) {
                             switch (op1) {
                             case 0: /* ldrex */
                                 gen_load_exclusive(s, rd, 15, addr, 2);
@@ -9847,6 +9850,10 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                             }
                         }
                         tcg_temp_free_i32(addr);
+
+                        if (is_lasr && is_ld) {
+                            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+                        }
                     } else if ((insn & 0x00300f00) == 0) {
                         /* 0bcccc_0001_0x00_xxxx_xxxx_0000_1001_xxxx
                         *  - SWP, SWPB
@@ -10862,6 +10869,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 tcg_gen_addi_i32(tmp, tmp, s->pc);
                 store_reg(s, 15, tmp);
             } else {
+                bool is_lasr = false;
+                bool is_ld = extract32(insn, 20, 1);
                 int op2 = (insn >> 6) & 0x3;
                 op = (insn >> 4) & 0x3;
                 switch (op2) {
@@ -10883,12 +10892,18 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 case 3:
                     /* Load-acquire/store-release exclusive */
                     ARCH(8);
+                    is_lasr = true;
                     break;
                 }
+
+                if (is_lasr && !is_ld) {
+                    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+                }
+
                 addr = tcg_temp_local_new_i32();
                 load_reg_var(s, addr, rn);
                 if (!(op2 & 1)) {
-                    if (insn & (1 << 20)) {
+                    if (is_ld) {
                         tmp = tcg_temp_new_i32();
                         switch (op) {
                         case 0: /* ldab */
@@ -10927,12 +10942,16 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                         }
                         tcg_temp_free_i32(tmp);
                     }
-                } else if (insn & (1 << 20)) {
+                } else if (is_ld) {
                     gen_load_exclusive(s, rs, rd, addr, op);
                 } else {
                     gen_store_exclusive(s, rm, rs, rd, addr, op);
                 }
                 tcg_temp_free_i32(addr);
+
+                if (is_lasr && is_ld) {
+                    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+                }
             }
         } else {
             /* Load/store multiple, RFE, SRS.  */
-- 
2.19.2
