Received: from eggs.gnu.org ([209.51.188.92]:54465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gn6Bk-0004K7-Rs
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:26:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gn6Bi-0002e4-Id
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:26:48 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:32938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gn6Bi-0002U7-9E
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:26:46 -0500
Received: by mail-wm1-x342.google.com with SMTP id r24so5392397wmh.0
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 10:26:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Jan 2019 18:26:23 +0000
Message-Id: <20190125182626.9221-5-peter.maydell@linaro.org>
In-Reply-To: <20190125182626.9221-1-peter.maydell@linaro.org>
References: <20190125182626.9221-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/7] target/arm/translate-a64: Don't
 underdecode SIMD ld/st single
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Laurent Desnogues <laurent.desnogues@gmail.com>

In the AdvSIMD load/store single structure encodings, the
non-post-indexed case should have zeroes in [20:16] (which is the
Rm field for the post-indexed case). Bit 31 must also be zero
(a check we got right in ldst_multiple but not here). Correctly
UNDEF these unallocated encodings.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c1f0cad7691..2cade64ed25 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3409,6 +3409,7 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
 {
     int rt = extract32(insn, 0, 5);
     int rn = extract32(insn, 5, 5);
+    int rm = extract32(insn, 16, 5);
     int size = extract32(insn, 10, 2);
     int S = extract32(insn, 12, 1);
     int opc = extract32(insn, 13, 3);
@@ -3424,6 +3425,15 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
     int ebytes, xs;
     TCGv_i64 tcg_addr, tcg_rn, tcg_ebytes;
 
+    if (extract32(insn, 31, 1)) {
+        unallocated_encoding(s);
+        return;
+    }
+    if (!is_postidx && rm != 0) {
+        unallocated_encoding(s);
+        return;
+    }
+
     switch (scale) {
     case 3:
         if (!is_load || S) {
@@ -3501,7 +3511,6 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
     }
 
     if (is_postidx) {
-        int rm = extract32(insn, 16, 5);
         if (rm == 31) {
             tcg_gen_mov_i64(tcg_rn, tcg_addr);
         } else {
-- 
2.20.1
