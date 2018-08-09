Received: from eggs.gnu.org ([2001:4830:134:3::10]:37827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fnboj-0006pU-0Z
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fnboi-0003FL-1u
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:53 -0400
Received: from mail-pl0-x232.google.com ([2607:f8b0:400e:c01::232]:44408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fnboh-0003Eu-QF
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:51 -0400
Received: by mail-pl0-x232.google.com with SMTP id ba4-v6so1929280plb.11
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 20:40:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  8 Aug 2018 20:40:32 -0700
Message-Id: <20180809034033.10579-11-richard.henderson@linaro.org>
In-Reply-To: <20180809034033.10579-1-richard.henderson@linaro.org>
References: <20180809034033.10579-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 10/11] target/arm: Dump SVE state if enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-stable@nongnu.org

Also fold the FPCR/FPSR state onto the same line as PSTATE,
and mention but do not dump disabled FPU state.

Cc: qemu-stable@nongnu.org (3.0.1)
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 95 +++++++++++++++++++++++++++++++++-----
 1 file changed, 83 insertions(+), 12 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 358f169c75..b29dc49c4f 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -152,8 +152,7 @@ void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
     } else {
         ns_status = "";
     }
-
-    cpu_fprintf(f, "\nPSTATE=%08x %c%c%c%c %sEL%d%c\n",
+    cpu_fprintf(f, "PSTATE=%08x %c%c%c%c %sEL%d%c",
                 psr,
                 psr & PSTATE_N ? 'N' : '-',
                 psr & PSTATE_Z ? 'Z' : '-',
@@ -163,17 +162,89 @@ void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
                 el,
                 psr & PSTATE_SP ? 'h' : 't');
 
-    if (flags & CPU_DUMP_FPU) {
-        int numvfpregs = 32;
-        for (i = 0; i < numvfpregs; i++) {
-            uint64_t *q = aa64_vfp_qreg(env, i);
-            uint64_t vlo = q[0];
-            uint64_t vhi = q[1];
-            cpu_fprintf(f, "q%02d=%016" PRIx64 ":%016" PRIx64 "%c",
-                        i, vhi, vlo, (i & 1 ? '\n' : ' '));
+    if (!(flags & CPU_DUMP_FPU)) {
+        cpu_fprintf(f, "\n");
+        return;
+    }
+    cpu_fprintf(f, "     FPCR=%08x FPSR=%08x\n",
+                vfp_get_fpcr(env), vfp_get_fpsr(env));
+
+    if (arm_feature(env, ARM_FEATURE_SVE)) {
+        int j, zcr_len = env->vfp.zcr_el[1] & 0xf; /* fix for system mode */
+
+        for (i = 0; i <= FFR_PRED_NUM; i++) {
+            bool eol;
+            if (i == FFR_PRED_NUM) {
+                cpu_fprintf(f, "FFR=");
+                /* It's last, so end the line.  */
+                eol = true;
+            } else {
+                cpu_fprintf(f, "P%02d=", i);
+                switch (zcr_len) {
+                case 0:
+                    eol = i % 8 == 7;
+                    break;
+                case 1:
+                    eol = i % 6 == 5;
+                    break;
+                case 2:
+                case 3:
+                    eol = i % 3 == 2;
+                    break;
+                default:
+                    /* More than one quadword per predicate.  */
+                    eol = true;
+                    break;
+                }
+            }
+            for (j = zcr_len / 4; j >= 0; j--) {
+                int digits;
+                if (j * 4 + 4 <= zcr_len + 1) {
+                    digits = 16;
+                } else {
+                    digits = (zcr_len % 4 + 1) * 4;
+                }
+                cpu_fprintf(f, "%0*" PRIx64 "%s", digits,
+                            env->vfp.pregs[i].p[j],
+                            j ? ":" : eol ? "\n" : " ");
+            }
+        }
+
+        for (i = 0; i < 32; i++) {
+            if (zcr_len == 0) {
+                cpu_fprintf(f, "Z%02d=%016" PRIx64 ":%016" PRIx64 "%s",
+                            i, env->vfp.zregs[i].d[1],
+                            env->vfp.zregs[i].d[0], i & 1 ? "\n" : " ");
+            } else if (zcr_len == 1) {
+                cpu_fprintf(f, "Z%02d=%016" PRIx64 ":%016" PRIx64
+                            ":%016" PRIx64 ":%016" PRIx64 "\n",
+                            i, env->vfp.zregs[i].d[3], env->vfp.zregs[i].d[2],
+                            env->vfp.zregs[i].d[1], env->vfp.zregs[i].d[0]);
+            } else {
+                for (j = zcr_len; j >= 0; j--) {
+                    bool odd = (zcr_len - j) % 2 != 0;
+                    if (j == zcr_len) {
+                        cpu_fprintf(f, "Z%02d[%x-%x]=", i, j, j - 1);
+                    } else if (!odd) {
+                        if (j > 0) {
+                            cpu_fprintf(f, "   [%x-%x]=", j, j - 1);
+                        } else {
+                            cpu_fprintf(f, "     [%x]=", j);
+                        }
+                    }
+                    cpu_fprintf(f, "%016" PRIx64 ":%016" PRIx64 "%s",
+                                env->vfp.zregs[i].d[j * 2 + 1],
+                                env->vfp.zregs[i].d[j * 2],
+                                odd || j == 0 ? "\n" : ":");
+                }
+            }
+        }
+    } else {
+        for (i = 0; i < 32; i++) {
+            uint64_t *q = aa64_vfp_qreg(env, i);
+            cpu_fprintf(f, "Q%02d=%016" PRIx64 ":%016" PRIx64 "%s",
+                        i, q[1], q[0], (i & 1 ? "\n" : " "));
         }
-        cpu_fprintf(f, "FPCR: %08x  FPSR: %08x\n",
-                    vfp_get_fpcr(env), vfp_get_fpsr(env));
     }
 }
 
-- 
2.17.1
