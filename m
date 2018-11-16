Received: from eggs.gnu.org ([2001:4830:134:3::10]:59696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gNlhm-0000Ma-RT
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 16:31:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gNlhi-0001iu-Py
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 16:31:10 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gNlhh-0001gr-Fl
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 16:31:05 -0500
Received: by mail-pl1-x644.google.com with SMTP id t13so8750650ply.13
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 13:31:02 -0800 (PST)
Date: Fri, 16 Nov 2018 13:30:43 -0800
Message-Id: <20181116213045.19825-4-palmer@sifive.com>
In-Reply-To: <20181116213045.19825-1-palmer@sifive.com>
References: <20181116213045.19825-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 3/4] target/riscv: Fix sfence.vm/a both
 available in any priv version
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

sfence.vm has been replaced in priv v1.10 spec by sfence.vma.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/translate.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 5359088e24bc..f44eb9c41b48 100644
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
2.18.1
