Received: from eggs.gnu.org ([2001:4830:134:3::10]:35218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cS1LF-00063n-Il
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:52:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cS1LC-0002Pd-FR
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:52:25 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:51908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cS1LC-0002PA-5C
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:52:22 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 13 Jan 2017 13:52:03 +0100
Message-Id: <1484311923-28637-6-git-send-email-laurent@vivier.eu>
In-Reply-To: <1484311923-28637-1-git-send-email-laurent@vivier.eu>
References: <1484311923-28637-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v2 5/5] target-m68k: increment/decrement with SP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, rth@twiddle.net, Laurent Vivier <laurent@vivier.eu>

On 680x0 family only.

Address Register indirect With postincrement:

When using the stack pointer (A7) with byte size data, the register
is incremented by two.

Address Register indirect With predecrement:

When using the stack pointer (A7) with byte size data, the register
is decremented by two.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index cf5d8dd..727c189 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -725,7 +725,12 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
         }
         reg = get_areg(s, reg0);
         tmp = tcg_temp_new();
-        tcg_gen_subi_i32(tmp, reg, opsize_bytes(opsize));
+        if (reg0 == 7 && opsize == OS_BYTE &&
+            m68k_feature(s->env, M68K_FEATURE_M68000)) {
+            tcg_gen_subi_i32(tmp, reg, 2);
+        } else {
+            tcg_gen_subi_i32(tmp, reg, opsize_bytes(opsize));
+        }
         return tmp;
     case 5: /* Indirect displacement.  */
         reg = get_areg(s, reg0);
@@ -801,7 +806,12 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
         result = gen_ldst(s, opsize, reg, val, what);
         if (what == EA_STORE || !addrp) {
             TCGv tmp = tcg_temp_new();
-            tcg_gen_addi_i32(tmp, reg, opsize_bytes(opsize));
+            if (reg0 == 7 && opsize == OS_BYTE &&
+                m68k_feature(s->env, M68K_FEATURE_M68000)) {
+                tcg_gen_subi_i32(tmp, reg, 2);
+            } else {
+                tcg_gen_addi_i32(tmp, reg, opsize_bytes(opsize));
+            }
             delay_set_areg(s, reg0, tmp, true);
         }
         return result;
-- 
2.7.4
