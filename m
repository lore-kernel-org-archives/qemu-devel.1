Received: from eggs.gnu.org ([2001:4830:134:3::10]:43791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wzssyqa@gmail.com>) id 1eRG11-0006El-5i
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 06:24:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wzssyqa@gmail.com>) id 1eRG0x-0000F3-7J
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 06:24:55 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:41990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wzssyqa@gmail.com>) id 1eRG0w-0000Ea-UI
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 06:24:51 -0500
Received: by mail-pg0-x241.google.com with SMTP id q67so1187032pga.9
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 03:24:50 -0800 (PST)
Sender: YunQiang Su <wzssyqa@gmail.com>
From: YunQiang Su <syq@debian.org>
Date: Tue, 19 Dec 2017 19:24:38 +0800
Message-Id: <20171219112438.6065-1-syq@debian.org>
Subject: [Qemu-devel] [PATCH] linux-user: Fix support MIPS o32 FP64 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: YunQiang Su <syq@debian.org>

MIPS o32 has a mode called FP64, who has 32 64Bit FPU registers.
To use it:
  add PR_GET_FP_MODE and PR_SET_FP_MODE options for prctl
  set CP0St_FR when binary as EF_MIPS_FP64

https://dmz-portal.mips.com/wiki/MIPS_O32_ABI_-_FR0_and_FR1_Interlinking
Signed-off-by: YunQiang Su <syq@debian.org>
---
 linux-user/main.c    |  3 +++
 linux-user/syscall.c | 24 +++++++++++++++++++++
 target/mips/cpu.c    | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/mips/cpu.h    |  9 ++++++++
 4 files changed, 95 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index 2fd2a143ed..f2b02a99a2 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4750,6 +4750,9 @@ int main(int argc, char **argv, char **envp)
             }
             restore_snan_bit_mode(env);
         }
+        if ((info->elf_flags & EF_MIPS_FP64) != 0) {
+            env->CP0_Status |= (1 << CP0St_FR);
+        }
     }
 #elif defined(TARGET_NIOS2)
     {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 11c9116c4a..664dacda33 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10530,6 +10530,30 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
              * need. */
             ret = -TARGET_EINVAL;
             break;
+#ifdef TARGET_MIPS
+        case PR_GET_FP_MODE:
+        {
+            CPUMIPSState *env = ((CPUMIPSState *)cpu_env);
+            ret = 0;
+            if (env->CP0_Status & (1 << CP0St_FR)) {
+                ret |= PR_FP_MODE_FR;
+            }
+            if (env->CP0_Config5 & (1 << CP0C5_FRE)) {
+                ret |= PR_FP_MODE_FRE;
+            }
+            break;
+        }
+        case PR_SET_FP_MODE:
+        {
+            CPUMIPSState *env = ((CPUMIPSState *)cpu_env);
+            ret = mips_prctl_set_fp_mode(env, arg2);
+            if (ret < 0) {
+                ret = -TARGET_EOPNOTSUPP;
+                goto fail;
+            }
+            break;
+        }
+#endif
         default:
             /* Most prctl options have no pointer arguments */
             ret = get_errno(prctl(arg1, arg2, arg3, arg4, arg5));
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 069f93560e..6cf1907f9c 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -246,4 +246,63 @@ static void mips_cpu_register_types(void)
     }
 }
 
+#ifdef CONFIG_USER_ONLY
+abi_long mips_prctl_set_fp_mode(CPUMIPSState *env, abi_long arg2)
+{
+    abi_long ret;
+    CPUState *other_cpu;
+    bool old_fr = env->CP0_Status & (1 << CP0St_FR);
+    bool new_fr = arg2 & PR_FP_MODE_FR;
+    bool new_fre = arg2 & PR_FP_MODE_FRE;
+
+    if (new_fr && !(env->active_fpu.fcr0 & (1 << FCR0_F64))) {
+        /* FR1 is not supported */
+        ret = -1;
+        return ret;
+    }
+
+    if (!new_fr && (env->active_fpu.fcr0 & (1 << FCR0_F64))
+        && !(env->CP0_Status_rw_bitmask & (1 << CP0St_FR))) {
+        /* cannot set FR=0 */
+        ret = -1;
+        return ret;
+    }
+
+    if (new_fre && !(env->active_fpu.fcr0 & (1 << FCR0_FREP))) {
+        /* Cannot set FRE=1 */
+        ret = -1;
+        return ret;
+    }
+
+    start_exclusive();
+    CPU_FOREACH(other_cpu) {
+        int i;
+        MIPSCPU *cpu = MIPS_CPU(other_cpu);
+        env = &cpu->env;
+        for (i = 0; i < 32 ; i += 2) {
+            fpr_t *fpr = env->active_fpu.fpr;
+            if (!old_fr && new_fr) {
+                fpr[i].w[!FP_ENDIAN_IDX] = fpr[i + 1].w[FP_ENDIAN_IDX];
+            } else if (old_fr && !new_fr) {
+                fpr[i + 1].w[FP_ENDIAN_IDX] = fpr[i].w[!FP_ENDIAN_IDX];
+            }
+        }
+        if (new_fr) {
+            env->CP0_Status |= (1 << CP0St_FR);
+        } else {
+            env->CP0_Status &= ~(1 << CP0St_FR);
+        }
+        if (new_fre) {
+            env->CP0_Config5 |= (1 << CP0C5_FRE);
+        } else {
+            env->CP0_Config5 &= ~(1 << CP0C5_FRE);
+        }
+        compute_hflags(env);
+    }
+    end_exclusive();
+    ret = 0;
+    return ret;
+}
+#endif
+
 type_init(mips_cpu_register_types)
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 7f8ba5ff3e..b5d9aac6d0 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -769,4 +769,13 @@ static inline void cpu_get_tb_cpu_state(CPUMIPSState *env, target_ulong *pc,
                             MIPS_HFLAG_HWRENA_ULR);
 }
 
+/* prctl interface.  */
+#if defined(CONFIG_USER_ONLY)
+#define PR_SET_FP_MODE 45
+#define PR_GET_FP_MODE 46
+#define PR_FP_MODE_FR  (1 << 0)
+#define PR_FP_MODE_FRE (1 << 1)
+abi_long mips_prctl_set_fp_mode(CPUMIPSState *env, abi_long arg2);
+#endif
+
 #endif /* MIPS_CPU_H */
-- 
2.15.1
