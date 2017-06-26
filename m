Received: from eggs.gnu.org ([2001:4830:134:3::10]:34284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPQrw-0005nU-FI
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPQrr-0006MP-Hf
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:03:44 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:36677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dPQrr-0006M4-AY
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:03:39 -0400
Received: by mail-wm0-x22a.google.com with SMTP id 62so2976373wmw.1
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 03:03:39 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 26 Jun 2017 11:04:22 +0100
Message-Id: <20170626100422.6390-1-alex.bennee@linaro.org>
In-Reply-To: <149838046604.6497.6648018844505723967.stgit@frigg.lan>
References: <149838046604.6497.6648018844505723967.stgit@frigg.lan>
Subject: [Qemu-devel] [PATCH] fixup! Pass generic CPUState to
 gen_intermediate_code()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: vilanova@ac.upc.edu
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Stafford Horne <shorne@gmail.com>

---
 target/hppa/translate.c     | 5 ++---
 target/nios2/translate.c    | 5 ++---
 target/openrisc/translate.c | 3 +--
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index e10abc5e04..900870cd5a 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3740,10 +3740,9 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
     return gen_illegal(ctx);
 }
 
-void gen_intermediate_code(CPUHPPAState *env, struct TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 {
-    HPPACPU *cpu = hppa_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUHPPAState *env = cs->env_ptr;
     DisasContext ctx;
     ExitStatus ret;
     int num_insns, max_insns, i;
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 2f3c2e5dfb..8b97d6585f 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -799,10 +799,9 @@ static void gen_exception(DisasContext *dc, uint32_t excp)
 }
 
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUNios2State *env, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
-    Nios2CPU *cpu = nios2_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUNios2State *env = cs->env_ptr;
     DisasContext dc1, *dc = &dc1;
     int num_insns;
     int max_insns;
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index aaac359d5b..4a28c96e53 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1520,9 +1520,8 @@ static void disas_openrisc_insn(DisasContext *dc, OpenRISCCPU *cpu)
 
 void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb)
 {
-    OpenRISCState *env = cpu->env_ptr;
+    CPUOpenRISCState *env = cpu->env_ptr;
     OpenRISCCPU *or_cpu = openrisc_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
     struct DisasContext ctx, *dc = &ctx;
     uint32_t pc_start;
     uint32_t next_page_start;
-- 
2.13.0
