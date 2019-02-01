Received: from eggs.gnu.org ([209.51.188.92]:58937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMC-0008F2-3O
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbM9-0003hf-Tc
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:56 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:34190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbM9-0003W8-JV
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:53 -0500
Received: by mail-wr1-x42d.google.com with SMTP id f7so7744098wrp.1
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:07:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.07.33
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:07:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:36 +0000
Message-Id: <20190201160653.13829-31-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 30/47] target/arm/translate-a64: Don't
 underdecode FP insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In the encoding groups
 * floating-point data-processing (1 source)
 * floating-point data-processing (2 source)
 * floating-point data-processing (3 source)
 * floating-point immediate
 * floating-point compare
 * floating-ponit conditional compare
 * floating-point conditional select

bit 31 is M and bit 29 is S (and bit 30 is 0, already checked at
this point in the decode). None of these groups allocate any
encoding for M=1 or S=1. We checked this in disas_fp_compare(),
disas_fp_ccomp() and disas_fp_csel(), but missed it in disas_fp_1src(),
disas_fp_2src(), disas_fp_3src() and disas_fp_imm().

We also missed that in the fp immediate encoding the imm5 field
must be all zeroes.

Correctly UNDEF the unallocated encodings here.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20190125182626.9221-7-peter.maydell@linaro.org
---
 target/arm/translate-a64.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 94907f0ae97..6c4b20daf2c 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5636,11 +5636,17 @@ static void handle_fp_fcvt(DisasContext *s, int opcode,
  */
 static void disas_fp_1src(DisasContext *s, uint32_t insn)
 {
+    int mos = extract32(insn, 29, 3);
     int type = extract32(insn, 22, 2);
     int opcode = extract32(insn, 15, 6);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
 
+    if (mos) {
+        unallocated_encoding(s);
+        return;
+    }
+
     switch (opcode) {
     case 0x4: case 0x5: case 0x7:
     {
@@ -5867,13 +5873,14 @@ static void handle_fp_2src_half(DisasContext *s, int opcode,
  */
 static void disas_fp_2src(DisasContext *s, uint32_t insn)
 {
+    int mos = extract32(insn, 29, 3);
     int type = extract32(insn, 22, 2);
     int rd = extract32(insn, 0, 5);
     int rn = extract32(insn, 5, 5);
     int rm = extract32(insn, 16, 5);
     int opcode = extract32(insn, 12, 4);
 
-    if (opcode > 8) {
+    if (opcode > 8 || mos) {
         unallocated_encoding(s);
         return;
     }
@@ -6028,6 +6035,7 @@ static void handle_fp_3src_half(DisasContext *s, bool o0, bool o1,
  */
 static void disas_fp_3src(DisasContext *s, uint32_t insn)
 {
+    int mos = extract32(insn, 29, 3);
     int type = extract32(insn, 22, 2);
     int rd = extract32(insn, 0, 5);
     int rn = extract32(insn, 5, 5);
@@ -6036,6 +6044,11 @@ static void disas_fp_3src(DisasContext *s, uint32_t insn)
     bool o0 = extract32(insn, 15, 1);
     bool o1 = extract32(insn, 21, 1);
 
+    if (mos) {
+        unallocated_encoding(s);
+        return;
+    }
+
     switch (type) {
     case 0:
         if (!fp_access_check(s)) {
@@ -6105,12 +6118,19 @@ uint64_t vfp_expand_imm(int size, uint8_t imm8)
 static void disas_fp_imm(DisasContext *s, uint32_t insn)
 {
     int rd = extract32(insn, 0, 5);
+    int imm5 = extract32(insn, 5, 5);
     int imm8 = extract32(insn, 13, 8);
     int type = extract32(insn, 22, 2);
+    int mos = extract32(insn, 29, 3);
     uint64_t imm;
     TCGv_i64 tcg_res;
     TCGMemOp sz;
 
+    if (mos || imm5) {
+        unallocated_encoding(s);
+        return;
+    }
+
     switch (type) {
     case 0:
         sz = MO_32;
-- 
2.20.1
