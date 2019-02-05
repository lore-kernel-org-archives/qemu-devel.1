Received: from eggs.gnu.org ([209.51.188.92]:35829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AQ-0001rl-QI
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AK-0000VF-J7
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:48 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:36749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr4AC-0000Nv-Sv
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:40 -0500
Received: by mail-wr1-x42b.google.com with SMTP id z3so4483221wrv.3
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 09:05:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id w13sm5583164wmf.5.2019.02.05.09.05.25
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 09:05:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Feb 2019 17:04:58 +0000
Message-Id: <20190205170510.21984-11-peter.maydell@linaro.org>
In-Reply-To: <20190205170510.21984-1-peter.maydell@linaro.org>
References: <20190205170510.21984-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/22] linux-user: Implement PR_PAC_RESET_KEYS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190201195404.30486-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/aarch64/target_syscall.h |  7 ++++++
 linux-user/syscall.c                | 36 +++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/linux-user/aarch64/target_syscall.h b/linux-user/aarch64/target_syscall.h
index 937fd7989e7..b595e5da820 100644
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
index b5786d4fc1f..bf076cbf8c4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9691,6 +9691,42 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 }
             }
             return ret;
+        case TARGET_PR_PAC_RESET_KEYS:
+            {
+                CPUARMState *env = cpu_env;
+                ARMCPU *cpu = arm_env_get_cpu(env);
+
+                if (arg3 || arg4 || arg5) {
+                    return -TARGET_EINVAL;
+                }
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
2.20.1
