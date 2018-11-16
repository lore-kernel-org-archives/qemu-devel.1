Received: from eggs.gnu.org ([2001:4830:134:3::10]:59700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gNlhn-0000Mb-0V
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 16:31:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gNlhm-0001jZ-4Z
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 16:31:10 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gNlhi-0001i7-Nx
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 16:31:07 -0500
Received: by mail-pl1-x643.google.com with SMTP id u6so836221plm.8
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 13:31:04 -0800 (PST)
Date: Fri, 16 Nov 2018 13:30:44 -0800
Message-Id: <20181116213045.19825-5-palmer@sifive.com>
In-Reply-To: <20181116213045.19825-1-palmer@sifive.com>
References: <20181116213045.19825-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 4/4] RISC-V: Respect fences for user-only
 emulators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@sifive.com>

Our current fence implementation ignores fences for the user-only
configurations.  This is incorrect but unlikely to manifest: it requires
multi-threaded user-only code that takes advantage of the weakness in
the host's memory model and can be inlined by TCG.

This patch simply treats fences the same way for all our emulators.
I've given it to testing as I don't want to construct a test that would
actually trigger the failure.

Our fence implementation has an additional deficiency where we map all
RISC-V fences to full fences.  Now that we have a formal memory model
for RISC-V we can start to take advantage of the strength bits on our
fence instructions.  This requires a bit more though, so I'm going to
split it out because the implementation is still correct without taking
advantage of these weaker fences.

Thanks to Richard Henderson for pointing out both of the issues.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/translate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index f44eb9c41b48..312bf298b3c2 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1776,7 +1776,6 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
                      GET_RM(ctx->opcode));
         break;
     case OPC_RISC_FENCE:
-#ifndef CONFIG_USER_ONLY
         if (ctx->opcode & 0x1000) {
             /* FENCE_I is a no-op in QEMU,
              * however we need to end the translation block */
@@ -1787,7 +1786,6 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
             /* FENCE is a full memory barrier. */
             tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
         }
-#endif
         break;
     case OPC_RISC_SYSTEM:
         gen_system(env, ctx, MASK_OP_SYSTEM(ctx->opcode), rd, rs1,
-- 
2.18.1
