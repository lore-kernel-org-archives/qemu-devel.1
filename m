Received: from eggs.gnu.org ([2001:4830:134:3::10]:41040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gKj5g-0005lD-JA
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:07:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gKj5X-0003L8-Ua
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:07:14 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Thu,  8 Nov 2018 13:06:27 +0100
Message-Id: <20181108120628.29926-2-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181108120628.29926-1-kbastian@mail.uni-paderborn.de>
References: <20181108120628.29926-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/2] target/riscv: Fix FCLASS_D being treated
 as RV64 only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kbastian@mail.uni-paderborn.de, mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com, Alistair.Francis@wdc.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/riscv/translate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 18d7b6d147..5359088e24 100644
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
2.19.1
