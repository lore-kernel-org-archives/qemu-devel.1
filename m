Received: from eggs.gnu.org ([209.51.188.92]:53335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grFli-0003l5-6S
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:29:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grFlh-00069f-CB
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:29:06 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grFlh-00069H-6V
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:29:05 -0500
Received: by mail-wr1-x442.google.com with SMTP id z15so4070691wrn.1
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 21:29:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Feb 2019 05:28:56 +0000
Message-Id: <20190206052857.5077-3-richard.henderson@linaro.org>
In-Reply-To: <20190206052857.5077-1-richard.henderson@linaro.org>
References: <20190206052857.5077-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 2/3] target/arm: Restructure
 disas_fp_int_conv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

For opcodes 0-5, move some if conditions into the structure
of a switch statement.  For opcodes 6 & 7, decode everything
at once with a second switch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 94 ++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 45 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e002251ac6..2f849a6951 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -6541,68 +6541,72 @@ static void disas_fp_int_conv(DisasContext *s, uint32_t insn)
     int type = extract32(insn, 22, 2);
     bool sbit = extract32(insn, 29, 1);
     bool sf = extract32(insn, 31, 1);
+    bool itof = false;
 
     if (sbit) {
-        unallocated_encoding(s);
-        return;
+        goto do_unallocated;
     }
 
-    if (opcode > 5) {
-        /* FMOV */
-        bool itof = opcode & 1;
-
-        if (rmode >= 2) {
-            unallocated_encoding(s);
-            return;
-        }
-
-        switch (sf << 3 | type << 1 | rmode) {
-        case 0x0: /* 32 bit */
-        case 0xa: /* 64 bit */
-        case 0xd: /* 64 bit to top half of quad */
-            break;
-        case 0x6: /* 16-bit float, 32-bit int */
-        case 0xe: /* 16-bit float, 64-bit int */
-            if (dc_isar_feature(aa64_fp16, s)) {
-                break;
-            }
-            /* fallthru */
-        default:
-            /* all other sf/type/rmode combinations are invalid */
-            unallocated_encoding(s);
-            return;
-        }
-
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_fmov(s, rd, rn, type, itof);
-    } else {
-        /* actual FP conversions */
-        bool itof = extract32(opcode, 1, 1);
-
-        if (rmode != 0 && opcode > 1) {
-            unallocated_encoding(s);
-            return;
+    switch (opcode) {
+    case 2: /* SCVTF */
+    case 3: /* UCVTF */
+        itof = true;
+        /* fallthru */
+    case 4: /* FCVTAS */
+    case 5: /* FCVTAU */
+        if (rmode != 0) {
+            goto do_unallocated;
         }
+        /* fallthru */
+    case 0: /* FCVT[NPMZ]S */
+    case 1: /* FCVT[NPMZ]U */
         switch (type) {
         case 0: /* float32 */
         case 1: /* float64 */
             break;
         case 3: /* float16 */
-            if (dc_isar_feature(aa64_fp16, s)) {
-                break;
+            if (!dc_isar_feature(aa64_fp16, s)) {
+                goto do_unallocated;
             }
-            /* fallthru */
+            break;
         default:
-            unallocated_encoding(s);
-            return;
+            goto do_unallocated;
         }
-
         if (!fp_access_check(s)) {
             return;
         }
         handle_fpfpcvt(s, rd, rn, opcode, itof, rmode, 64, sf, type);
+        break;
+
+    default:
+        switch (sf << 7 | type << 5 | rmode << 3 | opcode) {
+        case 0b01100110: /* FMOV half <-> 32-bit int */
+        case 0b01100111:
+        case 0b11100110: /* FMOV half <-> 64-bit int */
+        case 0b11100111:
+            if (!dc_isar_feature(aa64_fp16, s)) {
+                goto do_unallocated;
+            }
+            /* fallthru */
+        case 0b00000110: /* FMOV 32-bit */
+        case 0b00000111:
+        case 0b10100110: /* FMOV 64-bit */
+        case 0b10100111:
+        case 0b11001110: /* FMOV top half of 128-bit */
+        case 0b11001111:
+            if (!fp_access_check(s)) {
+                return;
+            }
+            itof = opcode & 1;
+            handle_fmov(s, rd, rn, type, itof);
+            break;
+
+        default:
+        do_unallocated:
+            unallocated_encoding(s);
+            return;
+        }
+        break;
     }
 }
 
-- 
2.17.2
