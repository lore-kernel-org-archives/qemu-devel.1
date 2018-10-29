Received: from eggs.gnu.org ([2001:4830:134:3::10]:34403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH9Lg-0008Sr-Ec
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:21:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH9Lb-0003PS-Td
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:21:00 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39627 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gH9Lb-0003Ja-Dg
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:55 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 29 Oct 2018 16:20:17 +0100
Message-Id: <1540826418-5501-27-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540826418-5501-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540826418-5501-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 26/27] linux-user: Determine the desired FPU
 mode from MIPS.abiflags
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

Floating-point mode is calculated from MIPS.abiflags FP ABI value
(based on kernel implementation). Illegal combinations are rejected.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/mips/cpu_loop.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index c9c20cf..97e4957 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -740,6 +740,34 @@ void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
     struct image_info *info = ts->info;
     int i;
 
+    struct mode_req {
+        bool single;
+        bool soft;
+        bool fr1;
+        bool frdefault;
+        bool fre;
+    };
+
+    static const struct mode_req fpu_reqs[] = {
+        [MIPS_ABI_FP_ANY]    = { true,  true,  true,  true,  true  },
+        [MIPS_ABI_FP_DOUBLE] = { false, false, false, true,  true  },
+        [MIPS_ABI_FP_SINGLE] = { true,  false, false, false, false },
+        [MIPS_ABI_FP_SOFT]   = { false, true,  false, false, false },
+        [MIPS_ABI_FP_OLD_64] = { false, false, false, false, false },
+        [MIPS_ABI_FP_XX]     = { false, false, true,  true,  true  },
+        [MIPS_ABI_FP_64]     = { false, false, true,  false, false },
+        [MIPS_ABI_FP_64A]    = { false, false, true,  false, true  }
+    };
+
+    /*
+     * Mode requirements when .MIPS.abiflags is not present in the ELF.
+     * Not present means that everything is acceptable except FR1.
+     */
+    static struct mode_req none_req = { true, true, false, true, true };
+
+    struct mode_req prog_req;
+    struct mode_req interp_req;
+
     for(i = 0; i < 32; i++) {
         env->active_tc.gpr[i] = regs->regs[i];
     }
@@ -747,6 +775,53 @@ void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
     if (regs->cp0_epc & 1) {
         env->hflags |= MIPS_HFLAG_M16;
     }
+
+#ifdef TARGET_ABI_MIPSO32
+# define MAX_FP_ABI MIPS_ABI_FP_64A
+#else
+# define MAX_FP_ABI MIPS_ABI_FP_SOFT
+#endif
+     if ((info->fp_abi > MAX_FP_ABI && info->fp_abi != MIPS_ABI_FP_UNKNOWN)
+        || (info->interp_fp_abi > MAX_FP_ABI &&
+            info->interp_fp_abi != MIPS_ABI_FP_UNKNOWN)) {
+        fprintf(stderr, "qemu: Unexpected FPU mode\n");
+        exit(1);
+    }
+
+    prog_req = (info->fp_abi == MIPS_ABI_FP_UNKNOWN) ? none_req
+                                            : fpu_reqs[info->fp_abi];
+    interp_req = (info->interp_fp_abi == MIPS_ABI_FP_UNKNOWN) ? none_req
+                                            : fpu_reqs[info->interp_fp_abi];
+
+    prog_req.single &= interp_req.single;
+    prog_req.soft &= interp_req.soft;
+    prog_req.fr1 &= interp_req.fr1;
+    prog_req.frdefault &= interp_req.frdefault;
+    prog_req.fre &= interp_req.fre;
+
+    bool cpu_has_mips_r2_r6 = env->insn_flags & ISA_MIPS32R2 ||
+                              env->insn_flags & ISA_MIPS64R2 ||
+                              env->insn_flags & ISA_MIPS32R6 ||
+                              env->insn_flags & ISA_MIPS64R6;
+
+    if (prog_req.fre && !prog_req.frdefault && !prog_req.fr1) {
+        env->CP0_Config5 |= (1 << CP0C5_FRE);
+        if (env->active_fpu.fcr0 & (1 << FCR0_FREP)) {
+            env->hflags |= MIPS_HFLAG_FRE;
+        }
+    } else if ((prog_req.fr1 && prog_req.frdefault) ||
+         (prog_req.single && !prog_req.frdefault)) {
+        if ((env->active_fpu.fcr0 & (1 << FCR0_F64)
+            && cpu_has_mips_r2_r6) || prog_req.fr1) {
+            env->CP0_Status |= (1 << CP0St_FR);
+            env->hflags |= MIPS_HFLAG_F64;
+        }
+    } else  if (!prog_req.fre && !prog_req.frdefault &&
+          !prog_req.fr1 && !prog_req.single && !prog_req.soft) {
+        fprintf(stderr, "qemu: Can't find a matching FPU mode\n");
+        exit(1);
+    }
+
     if (env->insn_flags & ISA_NANOMIPS32) {
         return;
     }
-- 
2.7.4
