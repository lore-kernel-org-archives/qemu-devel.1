Received: from eggs.gnu.org ([209.51.188.92]:52066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwtXn-0008QI-18
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwtXl-0007PW-54
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:02 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:44724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gwtXj-0007He-7r
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:01 -0500
Received: by mail-wr1-x42e.google.com with SMTP id w2so17186777wrt.11
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 10:57:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	c18sm29065085wre.32.2019.02.21.10.57.45 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 21 Feb 2019 10:57:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Feb 2019 18:57:22 +0000
Message-Id: <20190221185739.25362-5-peter.maydell@linaro.org>
In-Reply-To: <20190221185739.25362-1-peter.maydell@linaro.org>
References: <20190221185739.25362-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/21] target/arm: Restructure disas_fp_int_conv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

For opcodes 0-5, move some if conditions into the structure
of a switch statement.  For opcodes 6 & 7, decode everything
at once with a second switch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190215192302.27855-2-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 94 ++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 45 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index af8e4fd4be1..dbce24fe32c 100644
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
2.20.1
