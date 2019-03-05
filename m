Received: from eggs.gnu.org ([209.51.188.92]:54602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHZ-0001dC-VN
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHT-0000op-Vd
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:09 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:41450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1DHT-0000nW-O2
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:03 -0500
Received: by mail-wr1-x436.google.com with SMTP id n2so10244447wrw.8
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 08:51:03 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id 2sm10071495wrg.89.2019.03.05.08.51.01
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Mar 2019 08:51:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Mar 2019 16:50:36 +0000
Message-Id: <20190305165051.26860-8-peter.maydell@linaro.org>
In-Reply-To: <20190305165051.26860-1-peter.maydell@linaro.org>
References: <20190305165051.26860-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/22] target/arm: Rearrange disas_data_proc_reg
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

This decoding more closely matches the ARMv8.4 Table C4-6,
Encoding table for Data Processing - Register Group.

In particular, op2 == 0 is now more than just Add/sub (with carry).

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190301200501.16533-7-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 98 ++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 41 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index eaeb43577df..12d2649c204 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4494,11 +4494,10 @@ static void disas_data_proc_3src(DisasContext *s, uint32_t insn)
 }
 
 /* Add/subtract (with carry)
- *  31 30 29 28 27 26 25 24 23 22 21  20  16  15   10  9    5 4   0
- * +--+--+--+------------------------+------+---------+------+-----+
- * |sf|op| S| 1  1  0  1  0  0  0  0 |  rm  | opcode2 |  Rn  |  Rd |
- * +--+--+--+------------------------+------+---------+------+-----+
- *                                            [000000]
+ *  31 30 29 28 27 26 25 24 23 22 21  20  16  15       10  9    5 4   0
+ * +--+--+--+------------------------+------+-------------+------+-----+
+ * |sf|op| S| 1  1  0  1  0  0  0  0 |  rm  | 0 0 0 0 0 0 |  Rn  |  Rd |
+ * +--+--+--+------------------------+------+-------------+------+-----+
  */
 
 static void disas_adc_sbc(DisasContext *s, uint32_t insn)
@@ -4506,11 +4505,6 @@ static void disas_adc_sbc(DisasContext *s, uint32_t insn)
     unsigned int sf, op, setflags, rm, rn, rd;
     TCGv_i64 tcg_y, tcg_rn, tcg_rd;
 
-    if (extract32(insn, 10, 6) != 0) {
-        unallocated_encoding(s);
-        return;
-    }
-
     sf = extract32(insn, 31, 1);
     op = extract32(insn, 30, 1);
     setflags = extract32(insn, 29, 1);
@@ -5164,47 +5158,69 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Data processing - register */
+/*
+ * Data processing - register
+ *  31  30 29  28      25    21  20  16      10         0
+ * +--+---+--+---+-------+-----+-------+-------+---------+
+ * |  |op0|  |op1| 1 0 1 | op2 |       |  op3  |         |
+ * +--+---+--+---+-------+-----+-------+-------+---------+
+ */
 static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
 {
-    switch (extract32(insn, 24, 5)) {
-    case 0x0a: /* Logical (shifted register) */
-        disas_logic_reg(s, insn);
-        break;
-    case 0x0b: /* Add/subtract */
-        if (insn & (1 << 21)) { /* (extended register) */
-            disas_add_sub_ext_reg(s, insn);
+    int op0 = extract32(insn, 30, 1);
+    int op1 = extract32(insn, 28, 1);
+    int op2 = extract32(insn, 21, 4);
+    int op3 = extract32(insn, 10, 6);
+
+    if (!op1) {
+        if (op2 & 8) {
+            if (op2 & 1) {
+                /* Add/sub (extended register) */
+                disas_add_sub_ext_reg(s, insn);
+            } else {
+                /* Add/sub (shifted register) */
+                disas_add_sub_reg(s, insn);
+            }
         } else {
-            disas_add_sub_reg(s, insn);
+            /* Logical (shifted register) */
+            disas_logic_reg(s, insn);
         }
-        break;
-    case 0x1b: /* Data-processing (3 source) */
-        disas_data_proc_3src(s, insn);
-        break;
-    case 0x1a:
-        switch (extract32(insn, 21, 3)) {
-        case 0x0: /* Add/subtract (with carry) */
+        return;
+    }
+
+    switch (op2) {
+    case 0x0:
+        switch (op3) {
+        case 0x00: /* Add/subtract (with carry) */
             disas_adc_sbc(s, insn);
             break;
-        case 0x2: /* Conditional compare */
-            disas_cc(s, insn); /* both imm and reg forms */
-            break;
-        case 0x4: /* Conditional select */
-            disas_cond_select(s, insn);
-            break;
-        case 0x6: /* Data-processing */
-            if (insn & (1 << 30)) { /* (1 source) */
-                disas_data_proc_1src(s, insn);
-            } else {            /* (2 source) */
-                disas_data_proc_2src(s, insn);
-            }
-            break;
+
         default:
-            unallocated_encoding(s);
-            break;
+            goto do_unallocated;
         }
         break;
+
+    case 0x2: /* Conditional compare */
+        disas_cc(s, insn); /* both imm and reg forms */
+        break;
+
+    case 0x4: /* Conditional select */
+        disas_cond_select(s, insn);
+        break;
+
+    case 0x6: /* Data-processing */
+        if (op0) {    /* (1 source) */
+            disas_data_proc_1src(s, insn);
+        } else {      /* (2 source) */
+            disas_data_proc_2src(s, insn);
+        }
+        break;
+    case 0x8 ... 0xf: /* (3 source) */
+        disas_data_proc_3src(s, insn);
+        break;
+
     default:
+    do_unallocated:
         unallocated_encoding(s);
         break;
     }
-- 
2.20.1
