Received: from eggs.gnu.org ([209.51.188.92]:42027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnc6-00084w-OK
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnc5-0004ZC-Qn
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:34 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnc5-0004Yj-LZ
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:33 -0400
Received: by mail-pf1-x443.google.com with SMTP id 10so3978639pfo.5
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  3 May 2019 22:52:54 -0700
Message-Id: <20190504055300.18426-26-richard.henderson@linaro.org>
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 25/31] target/cris: Use tcg_gen_abs_tl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, david@redhat.com

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/cris/translate.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index b005a5c20e..31b40a57f9 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -1686,18 +1686,11 @@ static int dec_cmp_r(CPUCRISState *env, DisasContext *dc)
 
 static int dec_abs_r(CPUCRISState *env, DisasContext *dc)
 {
-    TCGv t0;
-
     LOG_DIS("abs $r%u, $r%u\n",
             dc->op1, dc->op2);
     cris_cc_mask(dc, CC_MASK_NZ);
 
-    t0 = tcg_temp_new();
-    tcg_gen_sari_tl(t0, cpu_R[dc->op1], 31);
-    tcg_gen_xor_tl(cpu_R[dc->op2], cpu_R[dc->op1], t0);
-    tcg_gen_sub_tl(cpu_R[dc->op2], cpu_R[dc->op2], t0);
-    tcg_temp_free(t0);
-
+    tcg_gen_abs_tl(cpu_R[dc->op2], cpu_R[dc->op1]);
     cris_alu(dc, CC_OP_MOVE,
             cpu_R[dc->op2], cpu_R[dc->op2], cpu_R[dc->op2], 4);
     return 2;
-- 
2.17.1
