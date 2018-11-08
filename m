Received: from eggs.gnu.org ([2001:4830:134:3::10]:41055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gKj5k-0005lg-3a
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:07:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gKj5e-0003O7-Ak
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:07:19 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Thu,  8 Nov 2018 13:06:28 +0100
Message-Id: <20181108120628.29926-3-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181108120628.29926-1-kbastian@mail.uni-paderborn.de>
References: <20181108120628.29926-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] target/riscv: Fix sfence.vm/a both
 available in any priv version
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

sfence.vm has been replaced in priv v1.10 spec by sfence.vma.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/riscv/translate.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 5359088e24..f44eb9c41b 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1292,10 +1292,14 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
 #ifndef CONFIG_USER_ONLY
     /* Extract funct7 value and check whether it matches SFENCE.VMA */
     if ((opc == OPC_RISC_ECALL) && ((csr >> 5) == 9)) {
-        /* sfence.vma */
-        /* TODO: handle ASID specific fences */
-        gen_helper_tlb_flush(cpu_env);
-        return;
+        if (env->priv_ver == PRIV_VERSION_1_10_0) {
+            /* sfence.vma */
+            /* TODO: handle ASID specific fences */
+            gen_helper_tlb_flush(cpu_env);
+            return;
+        } else {
+            gen_exception_illegal(ctx);
+        }
     }
 #endif
 
@@ -1342,7 +1346,11 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
             gen_helper_wfi(cpu_env);
             break;
         case 0x104: /* SFENCE.VM */
-            gen_helper_tlb_flush(cpu_env);
+            if (env->priv_ver <= PRIV_VERSION_1_09_1) {
+                gen_helper_tlb_flush(cpu_env);
+            } else {
+                gen_exception_illegal(ctx);
+            }
             break;
 #endif
         default:
-- 
2.19.1
