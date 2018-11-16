Received: from eggs.gnu.org ([2001:4830:134:3::10]:59644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gNlhh-0000JP-7Y
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 16:31:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gNlhd-0001ft-7I
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 16:31:03 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:40584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gNlhb-0001fM-Pb
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 16:30:59 -0500
Received: by mail-pl1-x62f.google.com with SMTP id b22-v6so6273541pls.7
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 13:30:59 -0800 (PST)
Date: Fri, 16 Nov 2018 13:30:42 -0800
Message-Id: <20181116213045.19825-3-palmer@sifive.com>
In-Reply-To: <20181116213045.19825-1-palmer@sifive.com>
References: <20181116213045.19825-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 2/4] target/riscv: Fix FCLASS_D being treated as
 RV64 only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/translate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 18d7b6d1471d..5359088e24bc 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1237,13 +1237,14 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
         tcg_temp_free(t0);
         break;
 
-#if defined(TARGET_RISCV64)
     case OPC_RISC_FMV_X_D:
         /* also OPC_RISC_FCLASS_D */
         switch (rm) {
+#if defined(TARGET_RISCV64)
         case 0: /* FMV */
             gen_set_gpr(rd, cpu_fpr[rs1]);
             break;
+#endif
         case 1:
             t0 = tcg_temp_new();
             gen_helper_fclass_d(t0, cpu_fpr[rs1]);
@@ -1255,6 +1256,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
         }
         break;
 
+#if defined(TARGET_RISCV64)
     case OPC_RISC_FMV_D_X:
         t0 = tcg_temp_new();
         gen_get_gpr(t0, rs1);
-- 
2.18.1
