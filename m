Received: from eggs.gnu.org ([2001:4830:134:3::10]:37555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1gH81o-00032I-3t
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:56:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1gH81f-0002ww-F5
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:56:19 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:44850 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1gH81e-0002vb-W9
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:56:15 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Mon, 29 Oct 2018 14:55:15 +0100
Message-Id: <1540821315-28346-7-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1540821315-28346-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1540821315-28346-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 6/6] Add prctl() PR_SET_FP_MODE and
 PR_GET_FP_MODE implementations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, riku.voipio@iki.fi, laurent@vivier.eu

From: Stefan Markovic <smarkovic@wavecomp.com>

Implement MIPS specific prctl() PR_SET_FP_MODE and PR_GET_FP_MODE emulation.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/mips/target_syscall.h   |  2 ++
 linux-user/mips64/target_syscall.h |  2 ++
 linux-user/syscall.c               | 62 +++++++++++++++++++++++++++++++++++---
 3 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/linux-user/mips/target_syscall.h b/linux-user/mips/target_syscall.h
index 33177af..d5509a3 100644
--- a/linux-user/mips/target_syscall.h
+++ b/linux-user/mips/target_syscall.h
@@ -247,5 +247,7 @@ static inline abi_ulong target_shmlba(CPUMIPSState *env)
 /* MIPS-specific prctl() options */
 #define TARGET_PR_SET_FP_MODE  45
 #define TARGET_PR_GET_FP_MODE  46
+#define TARGET_PR_FP_MODE_FR   (1 << 0)
+#define TARGET_PR_FP_MODE_FRE  (1 << 1)
 
 #endif /* MIPS_TARGET_SYSCALL_H */
diff --git a/linux-user/mips64/target_syscall.h b/linux-user/mips64/target_syscall.h
index c1160e6..8ccc468 100644
--- a/linux-user/mips64/target_syscall.h
+++ b/linux-user/mips64/target_syscall.h
@@ -244,5 +244,7 @@ static inline abi_ulong target_shmlba(CPUMIPSState *env)
 /* MIPS-specific prctl() options */
 #define TARGET_PR_SET_FP_MODE  45
 #define TARGET_PR_GET_FP_MODE  46
+#define TARGET_PR_FP_MODE_FR   (1 << 0)
+#define TARGET_PR_FP_MODE_FRE  (1 << 1)
 
 #endif /* MIPS64_TARGET_SYSCALL_H */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 15b03e1..810a58b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9529,11 +9529,65 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_MIPS
         case TARGET_PR_GET_FP_MODE:
-            /* TODO: Implement TARGET_PR_SET_FP_MODE handling.*/
-            return -TARGET_EINVAL;
+        {
+            CPUMIPSState *env = ((CPUMIPSState *)cpu_env);
+            ret = 0;
+            if (env->CP0_Status & (1 << CP0St_FR)) {
+                ret |= TARGET_PR_FP_MODE_FR;
+            }
+            if (env->CP0_Config5 & (1 << CP0C5_FRE)) {
+                ret |= TARGET_PR_FP_MODE_FRE;
+            }
+            return ret;
+        }
         case TARGET_PR_SET_FP_MODE:
-            /* TODO: Implement TARGET_PR_GET_FP_MODE handling.*/
-            return -TARGET_EINVAL;
+        {
+            CPUMIPSState *env = ((CPUMIPSState *)cpu_env);
+            bool old_fr = env->CP0_Status & (1 << CP0St_FR);
+            bool new_fr = arg2 & TARGET_PR_FP_MODE_FR;
+            bool new_fre = arg2 & TARGET_PR_FP_MODE_FRE;
+
+            if (new_fr && !(env->active_fpu.fcr0 & (1 << FCR0_F64))) {
+                /* FR1 is not supported */
+                return -TARGET_EOPNOTSUPP;
+            }
+            if (!new_fr && (env->active_fpu.fcr0 & (1 << FCR0_F64))
+                && !(env->CP0_Status_rw_bitmask & (1 << CP0St_FR))) {
+                /* cannot set FR=0 */
+                return -TARGET_EOPNOTSUPP;
+            }
+            if (new_fre && !(env->active_fpu.fcr0 & (1 << FCR0_FREP))) {
+                /* Cannot set FRE=1 */
+                return -TARGET_EOPNOTSUPP;
+            }
+
+            int i;
+            fpr_t *fpr = env->active_fpu.fpr;
+            for (i = 0; i < 32 ; i += 2) {
+                if (!old_fr && new_fr) {
+                    fpr[i].w[!FP_ENDIAN_IDX] = fpr[i + 1].w[FP_ENDIAN_IDX];
+                } else if (old_fr && !new_fr) {
+                    fpr[i + 1].w[FP_ENDIAN_IDX] = fpr[i].w[!FP_ENDIAN_IDX];
+                }
+            }
+
+            if (new_fr) {
+                env->CP0_Status |= (1 << CP0St_FR);
+                env->hflags |= MIPS_HFLAG_F64;
+            } else {
+                env->CP0_Status &= ~(1 << CP0St_FR);
+            }
+            if (new_fre) {
+                env->CP0_Config5 |= (1 << CP0C5_FRE);
+                if (env->active_fpu.fcr0 & (1 << FCR0_FREP)) {
+                    env->hflags |= MIPS_HFLAG_FRE;
+                }
+            } else {
+                env->CP0_Config5 &= ~(1 << CP0C5_FRE);
+            }
+
+            return 0;
+        }
 #endif /* MIPS */
 #ifdef TARGET_AARCH64
         case TARGET_PR_SVE_SET_VL:
-- 
1.9.1
