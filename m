Received: from eggs.gnu.org ([2001:4830:134:3::10]:57854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMs2-0005y9-AT
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMs1-0006rm-Br
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:38 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235]:42109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fxMs0-0006oj-Vj
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:37 -0400
Received: by mail-lj1-x235.google.com with SMTP id f1-v6so4785597ljc.9
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 18:44:36 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue,  4 Sep 2018 18:43:44 -0700
Message-Id: <20180905014352.970-8-jcmvbkbc@gmail.com>
In-Reply-To: <20180905014352.970-1-jcmvbkbc@gmail.com>
References: <20180905014352.970-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 07/15] target/xtensa: extract test for alloca
 exception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

- mark movsp instruction;
- put test for alloca exception right after the test for window
  underflow;

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index deedd4c973ef..9b59f35a1de7 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1078,6 +1078,13 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
         tcg_temp_free(tmp);
     }
 
+    if (op_flags & XTENSA_OP_ALLOCA) {
+        TCGv_i32 tmp = tcg_const_i32(dc->pc);
+
+        gen_helper_movsp(cpu_env, tmp);
+        tcg_temp_free(tmp);
+    }
+
     for (slot = 0; slot < slots; ++slot) {
         XtensaOpcodeOps *ops = slot_prop[slot].ops;
 
@@ -1918,10 +1925,7 @@ static void translate_movp(DisasContext *dc, const uint32_t arg[],
 static void translate_movsp(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
-    TCGv_i32 pc = tcg_const_i32(dc->pc);
-    gen_helper_movsp(cpu_env, pc);
     tcg_gen_mov_i32(cpu_R[arg[0]], cpu_R[arg[1]]);
-    tcg_temp_free(pc);
 }
 
 static void translate_mul16(DisasContext *dc, const uint32_t arg[],
@@ -3062,6 +3066,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "movsp",
         .translate = translate_movsp,
         .windowed_register_op = 0x3,
+        .op_flags = XTENSA_OP_ALLOCA,
     }, {
         .name = "movt",
         .translate = translate_movp,
-- 
2.11.0
