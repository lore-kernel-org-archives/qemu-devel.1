Received: from eggs.gnu.org ([2001:4830:134:3::10]:44445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gO2x0-0003xA-K8
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 10:56:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gO2wx-0000fm-6L
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 10:56:02 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:60337 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gO2ww-00077Q-V8
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 10:55:59 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Sat, 17 Nov 2018 16:54:30 +0100
Message-Id: <1542470080-5797-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1542470080-5797-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1542470080-5797-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 01/11] linux-user: Update MIPS specific prctl()
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Stefan Markovic <smarkovic@wavecomp.com>

Perform needed checks before actual prctl() PR_SET_FP_MODE and
PR_GET_FP_MODE work based on kernel implementation. Also, update
necessary hflags.

Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5c16692..280137d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9554,9 +9554,25 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         {
             CPUMIPSState *env = ((CPUMIPSState *)cpu_env);
             bool old_fr = env->CP0_Status & (1 << CP0St_FR);
+            bool old_fre = env->CP0_Config5 & (1 << CP0C5_FRE);
             bool new_fr = arg2 & TARGET_PR_FP_MODE_FR;
             bool new_fre = arg2 & TARGET_PR_FP_MODE_FRE;
 
+            const unsigned int known_bits = TARGET_PR_FP_MODE_FR |
+                                            TARGET_PR_FP_MODE_FRE;
+
+            /* If nothing to change, return right away, successfully.  */
+            if (old_fr == new_fr && old_fre == new_fre) {
+                return 0;
+            }
+            /* Check the value is valid */
+            if (arg2 & ~known_bits) {
+                return -TARGET_EOPNOTSUPP;
+            }
+            /* Setting FRE without FR is not supported.  */
+            if (new_fre && !new_fr) {
+                return -TARGET_EOPNOTSUPP;
+            }
             if (new_fr && !(env->active_fpu.fcr0 & (1 << FCR0_F64))) {
                 /* FR1 is not supported */
                 return -TARGET_EOPNOTSUPP;
@@ -9586,6 +9602,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 env->hflags |= MIPS_HFLAG_F64;
             } else {
                 env->CP0_Status &= ~(1 << CP0St_FR);
+                env->hflags &= ~MIPS_HFLAG_F64;
             }
             if (new_fre) {
                 env->CP0_Config5 |= (1 << CP0C5_FRE);
@@ -9594,6 +9611,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 }
             } else {
                 env->CP0_Config5 &= ~(1 << CP0C5_FRE);
+                env->hflags &= ~MIPS_HFLAG_FRE;
             }
 
             return 0;
-- 
2.7.4
