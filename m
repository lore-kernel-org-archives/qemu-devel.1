Received: from eggs.gnu.org ([209.51.188.92]:59176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMH-0008J2-M0
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMC-0003lz-87
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:08:01 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:46409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbMB-0003To-Uu
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:56 -0500
Received: by mail-wr1-x42d.google.com with SMTP id l9so7609865wrt.13
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:07:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.07.31
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:07:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:34 +0000
Message-Id: <20190201160653.13829-29-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 28/47] target/arm/translate-a64: Don't
 underdecode SIMD ld/st single
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In the AdvSIMD load/store single structure encodings, the
non-post-indexed case should have zeroes in [20:16] (which is the
Rm field for the post-indexed case). Bit 31 must also be zero
(a check we got right in ldst_multiple but not here). Correctly
UNDEF these unallocated encodings.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20190125182626.9221-5-peter.maydell@linaro.org
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
