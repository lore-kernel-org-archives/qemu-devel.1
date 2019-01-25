Received: from eggs.gnu.org ([209.51.188.92]:36014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnAe7-0004QF-RN
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:12:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnAPd-0005OT-Oq
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:57:26 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnAPd-0005Nm-J7
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:57:25 -0500
Received: by mail-pl1-x642.google.com with SMTP id e5so5205419plb.5
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 14:57:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 25 Jan 2019 14:57:13 -0800
Message-Id: <20190125225714.10234-7-richard.henderson@linaro.org>
In-Reply-To: <20190125225714.10234-1-richard.henderson@linaro.org>
References: <20190125225714.10234-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 5/6] linux-user: Implement PR_PAC_RESET_KEYS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_syscall.h |  7 ++++++
 linux-user/syscall.c                | 33 +++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/linux-user/aarch64/target_syscall.h b/linux-user/aarch64/target_syscall.h
index 937fd7989e..b595e5da82 100644
--- a/linux-user/aarch64/target_syscall.h
+++ b/linux-user/aarch64/target_syscall.h
@@ -22,6 +22,13 @@ struct target_pt_regs {
 #define TARGET_PR_SVE_SET_VL  50
 #define TARGET_PR_SVE_GET_VL  51
 
+#define TARGET_PR_PAC_RESET_KEYS 54
+# define TARGET_PR_PAC_APIAKEY   (1 << 0)
+# define TARGET_PR_PAC_APIBKEY   (1 << 1)
+# define TARGET_PR_PAC_APDAKEY   (1 << 2)
+# define TARGET_PR_PAC_APDBKEY   (1 << 3)
+# define TARGET_PR_PAC_APGAKEY   (1 << 4)
+
 void arm_init_pauth_key(ARMPACKey *key);
 
 #endif /* AARCH64_TARGET_SYSCALL_H */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b5786d4fc1..3e2949aa2f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9691,6 +9691,39 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 }
             }
             return ret;
+        case TARGET_PR_PAC_RESET_KEYS:
+            {
+                CPUARMState *env = cpu_env;
+                ARMCPU *cpu = arm_env_get_cpu(env);
+
+                if (cpu_isar_feature(aa64_pauth, cpu)) {
+                    int all = (TARGET_PR_PAC_APIAKEY | TARGET_PR_PAC_APIBKEY |
+                               TARGET_PR_PAC_APDAKEY | TARGET_PR_PAC_APDBKEY |
+                               TARGET_PR_PAC_APGAKEY);
+                    if (arg2 == 0) {
+                        arg2 = all;
+                    } else if (arg2 & ~all) {
+                        return -TARGET_EINVAL;
+                    }
+                    if (arg2 & TARGET_PR_PAC_APIAKEY) {
+                        arm_init_pauth_key(&env->apia_key);
+                    }
+                    if (arg2 & TARGET_PR_PAC_APIBKEY) {
+                        arm_init_pauth_key(&env->apib_key);
+                    }
+                    if (arg2 & TARGET_PR_PAC_APDAKEY) {
+                        arm_init_pauth_key(&env->apda_key);
+                    }
+                    if (arg2 & TARGET_PR_PAC_APDBKEY) {
+                        arm_init_pauth_key(&env->apdb_key);
+                    }
+                    if (arg2 & TARGET_PR_PAC_APGAKEY) {
+                        arm_init_pauth_key(&env->apga_key);
+                    }
+                    return 0;
+                }
+            }
+            return -TARGET_EINVAL;
 #endif /* AARCH64 */
         case PR_GET_SECCOMP:
         case PR_SET_SECCOMP:
-- 
2.17.2
