Received: from eggs.gnu.org ([2001:4830:134:3::10]:54999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCD-0007Ie-To
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJC5-0000xY-Rq
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:05:55 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34717)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gXJC4-0000qz-0v
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:05:52 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 13 Dec 2018 00:03:50 -0500
Message-Id: <20181213050453.9677-11-cota@braap.org>
In-Reply-To: <20181213050453.9677-1-cota@braap.org>
References: <20181213050453.9677-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 10/73] cris: convert to helper_cpu_halted_set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

And fix the temp leak along the way.

Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/cris/translate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index 11b2c11174..f059745ec0 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -2829,8 +2829,9 @@ static int dec_rfe_etc(CPUCRISState *env, DisasContext *dc)
     cris_cc_mask(dc, 0);
 
     if (dc->op2 == 15) {
-        tcg_gen_st_i32(tcg_const_i32(1), cpu_env,
-                       -offsetof(CRISCPU, env) + offsetof(CPUState, halted));
+        TCGv_i32 tmp = tcg_const_i32(1);
+        gen_helper_cpu_halted_set(cpu_env, tmp);
+        tcg_temp_free_i32(tmp);
         tcg_gen_movi_tl(env_pc, dc->pc + 2);
         t_gen_raise_exception(EXCP_HLT);
         return 2;
-- 
2.17.1
