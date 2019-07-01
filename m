Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B6BC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C94F214AE
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C94F214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhwds-0004AK-Is
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 09:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40925)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhwKY-00025t-Jd
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhwKQ-00029U-As
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:26:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47818)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hhwJz-0001ln-S3; Mon, 01 Jul 2019 09:26:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 47E0F3082B71;
 Mon,  1 Jul 2019 13:26:08 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FB4F6085B;
 Mon,  1 Jul 2019 13:26:05 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 15:24:59 +0200
Message-Id: <20190701132516.26392-11-philmd@redhat.com>
In-Reply-To: <20190701132516.26392-1-philmd@redhat.com>
References: <20190701132516.26392-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 01 Jul 2019 13:26:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 10/27] target/arm: Move CPU state dumping
 routines to cpu.c
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Yang Zhong <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <drjones@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>,
 Rob Bradford <robert.bradford@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/cpu.c           | 226 +++++++++++++++++++++++++++++++++++++
 target/arm/cpu.h           |   2 -
 target/arm/translate-a64.c | 128 ---------------------
 target/arm/translate.c     |  88 ---------------
 target/arm/translate.h     |   5 -
 5 files changed, 226 insertions(+), 223 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 376db154f0..1f73631bac 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -19,6 +19,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/qemu-print.h"
 #include "qemu-common.h"
 #include "target/arm/idau.h"
 #include "qemu/module.h"
@@ -676,6 +677,231 @@ static void arm_disas_set_info(CPUState *cpu, disas=
semble_info *info)
 #endif
 }
=20
+#ifdef TARGET_AARCH64
+
+static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+{
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    CPUARMState *env =3D &cpu->env;
+    uint32_t psr =3D pstate_read(env);
+    int i;
+    int el =3D arm_current_el(env);
+    const char *ns_status;
+
+    qemu_fprintf(f, " PC=3D%016" PRIx64 " ", env->pc);
+    for (i =3D 0; i < 32; i++) {
+        if (i =3D=3D 31) {
+            qemu_fprintf(f, " SP=3D%016" PRIx64 "\n", env->xregs[i]);
+        } else {
+            qemu_fprintf(f, "X%02d=3D%016" PRIx64 "%s", i, env->xregs[i]=
,
+                         (i + 2) % 3 ? " " : "\n");
+        }
+    }
+
+    if (arm_feature(env, ARM_FEATURE_EL3) && el !=3D 3) {
+        ns_status =3D env->cp15.scr_el3 & SCR_NS ? "NS " : "S ";
+    } else {
+        ns_status =3D "";
+    }
+    qemu_fprintf(f, "PSTATE=3D%08x %c%c%c%c %sEL%d%c",
+                 psr,
+                 psr & PSTATE_N ? 'N' : '-',
+                 psr & PSTATE_Z ? 'Z' : '-',
+                 psr & PSTATE_C ? 'C' : '-',
+                 psr & PSTATE_V ? 'V' : '-',
+                 ns_status,
+                 el,
+                 psr & PSTATE_SP ? 'h' : 't');
+
+    if (cpu_isar_feature(aa64_bti, cpu)) {
+        qemu_fprintf(f, "  BTYPE=3D%d", (psr & PSTATE_BTYPE) >> 10);
+    }
+    if (!(flags & CPU_DUMP_FPU)) {
+        qemu_fprintf(f, "\n");
+        return;
+    }
+    if (fp_exception_el(env, el) !=3D 0) {
+        qemu_fprintf(f, "    FPU disabled\n");
+        return;
+    }
+    qemu_fprintf(f, "     FPCR=3D%08x FPSR=3D%08x\n",
+                 vfp_get_fpcr(env), vfp_get_fpsr(env));
+
+    if (cpu_isar_feature(aa64_sve, cpu) && sve_exception_el(env, el) =3D=
=3D 0) {
+        int j, zcr_len =3D sve_zcr_len_for_el(env, el);
+
+        for (i =3D 0; i <=3D FFR_PRED_NUM; i++) {
+            bool eol;
+            if (i =3D=3D FFR_PRED_NUM) {
+                qemu_fprintf(f, "FFR=3D");
+                /* It's last, so end the line.  */
+                eol =3D true;
+            } else {
+                qemu_fprintf(f, "P%02d=3D", i);
+                switch (zcr_len) {
+                case 0:
+                    eol =3D i % 8 =3D=3D 7;
+                    break;
+                case 1:
+                    eol =3D i % 6 =3D=3D 5;
+                    break;
+                case 2:
+                case 3:
+                    eol =3D i % 3 =3D=3D 2;
+                    break;
+                default:
+                    /* More than one quadword per predicate.  */
+                    eol =3D true;
+                    break;
+                }
+            }
+            for (j =3D zcr_len / 4; j >=3D 0; j--) {
+                int digits;
+                if (j * 4 + 4 <=3D zcr_len + 1) {
+                    digits =3D 16;
+                } else {
+                    digits =3D (zcr_len % 4 + 1) * 4;
+                }
+                qemu_fprintf(f, "%0*" PRIx64 "%s", digits,
+                             env->vfp.pregs[i].p[j],
+                             j ? ":" : eol ? "\n" : " ");
+            }
+        }
+
+        for (i =3D 0; i < 32; i++) {
+            if (zcr_len =3D=3D 0) {
+                qemu_fprintf(f, "Z%02d=3D%016" PRIx64 ":%016" PRIx64 "%s=
",
+                             i, env->vfp.zregs[i].d[1],
+                             env->vfp.zregs[i].d[0], i & 1 ? "\n" : " ")=
;
+            } else if (zcr_len =3D=3D 1) {
+                qemu_fprintf(f, "Z%02d=3D%016" PRIx64 ":%016" PRIx64
+                             ":%016" PRIx64 ":%016" PRIx64 "\n",
+                             i, env->vfp.zregs[i].d[3], env->vfp.zregs[i=
].d[2],
+                             env->vfp.zregs[i].d[1], env->vfp.zregs[i].d=
[0]);
+            } else {
+                for (j =3D zcr_len; j >=3D 0; j--) {
+                    bool odd =3D (zcr_len - j) % 2 !=3D 0;
+                    if (j =3D=3D zcr_len) {
+                        qemu_fprintf(f, "Z%02d[%x-%x]=3D", i, j, j - 1);
+                    } else if (!odd) {
+                        if (j > 0) {
+                            qemu_fprintf(f, "   [%x-%x]=3D", j, j - 1);
+                        } else {
+                            qemu_fprintf(f, "     [%x]=3D", j);
+                        }
+                    }
+                    qemu_fprintf(f, "%016" PRIx64 ":%016" PRIx64 "%s",
+                                 env->vfp.zregs[i].d[j * 2 + 1],
+                                 env->vfp.zregs[i].d[j * 2],
+                                 odd || j =3D=3D 0 ? "\n" : ":");
+                }
+            }
+        }
+    } else {
+        for (i =3D 0; i < 32; i++) {
+            uint64_t *q =3D aa64_vfp_qreg(env, i);
+            qemu_fprintf(f, "Q%02d=3D%016" PRIx64 ":%016" PRIx64 "%s",
+                         i, q[1], q[0], (i & 1 ? "\n" : " "));
+        }
+    }
+}
+
+#else
+
+static inline void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int fla=
gs)
+{
+    g_assert_not_reached();
+}
+
+#endif
+
+static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+{
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    CPUARMState *env =3D &cpu->env;
+    int i;
+
+    if (is_a64(env)) {
+        aarch64_cpu_dump_state(cs, f, flags);
+        return;
+    }
+
+    for (i =3D 0; i < 16; i++) {
+        qemu_fprintf(f, "R%02d=3D%08x", i, env->regs[i]);
+        if ((i % 4) =3D=3D 3) {
+            qemu_fprintf(f, "\n");
+        } else {
+            qemu_fprintf(f, " ");
+        }
+    }
+
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        uint32_t xpsr =3D xpsr_read(env);
+        const char *mode;
+        const char *ns_status =3D "";
+
+        if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+            ns_status =3D env->v7m.secure ? "S " : "NS ";
+        }
+
+        if (xpsr & XPSR_EXCP) {
+            mode =3D "handler";
+        } else {
+            if (env->v7m.control[env->v7m.secure] & R_V7M_CONTROL_NPRIV_=
MASK) {
+                mode =3D "unpriv-thread";
+            } else {
+                mode =3D "priv-thread";
+            }
+        }
+
+        qemu_fprintf(f, "XPSR=3D%08x %c%c%c%c %c %s%s\n",
+                     xpsr,
+                     xpsr & XPSR_N ? 'N' : '-',
+                     xpsr & XPSR_Z ? 'Z' : '-',
+                     xpsr & XPSR_C ? 'C' : '-',
+                     xpsr & XPSR_V ? 'V' : '-',
+                     xpsr & XPSR_T ? 'T' : 'A',
+                     ns_status,
+                     mode);
+    } else {
+        uint32_t psr =3D cpsr_read(env);
+        const char *ns_status =3D "";
+
+        if (arm_feature(env, ARM_FEATURE_EL3) &&
+            (psr & CPSR_M) !=3D ARM_CPU_MODE_MON) {
+            ns_status =3D env->cp15.scr_el3 & SCR_NS ? "NS " : "S ";
+        }
+
+        qemu_fprintf(f, "PSR=3D%08x %c%c%c%c %c %s%s%d\n",
+                     psr,
+                     psr & CPSR_N ? 'N' : '-',
+                     psr & CPSR_Z ? 'Z' : '-',
+                     psr & CPSR_C ? 'C' : '-',
+                     psr & CPSR_V ? 'V' : '-',
+                     psr & CPSR_T ? 'T' : 'A',
+                     ns_status,
+                     aarch32_mode_name(psr), (psr & 0x10) ? 32 : 26);
+    }
+
+    if (flags & CPU_DUMP_FPU) {
+        int numvfpregs =3D 0;
+        if (arm_feature(env, ARM_FEATURE_VFP)) {
+            numvfpregs +=3D 16;
+        }
+        if (arm_feature(env, ARM_FEATURE_VFP3)) {
+            numvfpregs +=3D 16;
+        }
+        for (i =3D 0; i < numvfpregs; i++) {
+            uint64_t v =3D *aa32_vfp_dreg(env, i);
+            qemu_fprintf(f, "s%02d=3D%08x s%02d=3D%08x d%02d=3D%016" PRI=
x64 "\n",
+                         i * 2, (uint32_t)v,
+                         i * 2 + 1, (uint32_t)(v >> 32),
+                         i, v);
+        }
+        qemu_fprintf(f, "FPSCR: %08x\n", vfp_get_fpscr(env));
+    }
+}
+
 uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz)
 {
     uint32_t Aff1 =3D idx / clustersz;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f9da672be5..a9be18660f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -929,8 +929,6 @@ void arm_cpu_do_interrupt(CPUState *cpu);
 void arm_v7m_cpu_do_interrupt(CPUState *cpu);
 bool arm_cpu_exec_interrupt(CPUState *cpu, int int_req);
=20
-void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags);
-
 hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                          MemTxAttrs *attrs);
=20
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 97f4164fbb..d3231477a2 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -27,7 +27,6 @@
 #include "translate.h"
 #include "internals.h"
 #include "qemu/host-utils.h"
-#include "qemu/qemu-print.h"
=20
 #include "hw/semihosting/semihost.h"
 #include "exec/gen-icount.h"
@@ -152,133 +151,6 @@ static void set_btype(DisasContext *s, int val)
     s->btype =3D -1;
 }
=20
-void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
-{
-    ARMCPU *cpu =3D ARM_CPU(cs);
-    CPUARMState *env =3D &cpu->env;
-    uint32_t psr =3D pstate_read(env);
-    int i;
-    int el =3D arm_current_el(env);
-    const char *ns_status;
-
-    qemu_fprintf(f, " PC=3D%016" PRIx64 " ", env->pc);
-    for (i =3D 0; i < 32; i++) {
-        if (i =3D=3D 31) {
-            qemu_fprintf(f, " SP=3D%016" PRIx64 "\n", env->xregs[i]);
-        } else {
-            qemu_fprintf(f, "X%02d=3D%016" PRIx64 "%s", i, env->xregs[i]=
,
-                         (i + 2) % 3 ? " " : "\n");
-        }
-    }
-
-    if (arm_feature(env, ARM_FEATURE_EL3) && el !=3D 3) {
-        ns_status =3D env->cp15.scr_el3 & SCR_NS ? "NS " : "S ";
-    } else {
-        ns_status =3D "";
-    }
-    qemu_fprintf(f, "PSTATE=3D%08x %c%c%c%c %sEL%d%c",
-                 psr,
-                 psr & PSTATE_N ? 'N' : '-',
-                 psr & PSTATE_Z ? 'Z' : '-',
-                 psr & PSTATE_C ? 'C' : '-',
-                 psr & PSTATE_V ? 'V' : '-',
-                 ns_status,
-                 el,
-                 psr & PSTATE_SP ? 'h' : 't');
-
-    if (cpu_isar_feature(aa64_bti, cpu)) {
-        qemu_fprintf(f, "  BTYPE=3D%d", (psr & PSTATE_BTYPE) >> 10);
-    }
-    if (!(flags & CPU_DUMP_FPU)) {
-        qemu_fprintf(f, "\n");
-        return;
-    }
-    if (fp_exception_el(env, el) !=3D 0) {
-        qemu_fprintf(f, "    FPU disabled\n");
-        return;
-    }
-    qemu_fprintf(f, "     FPCR=3D%08x FPSR=3D%08x\n",
-                 vfp_get_fpcr(env), vfp_get_fpsr(env));
-
-    if (cpu_isar_feature(aa64_sve, cpu) && sve_exception_el(env, el) =3D=
=3D 0) {
-        int j, zcr_len =3D sve_zcr_len_for_el(env, el);
-
-        for (i =3D 0; i <=3D FFR_PRED_NUM; i++) {
-            bool eol;
-            if (i =3D=3D FFR_PRED_NUM) {
-                qemu_fprintf(f, "FFR=3D");
-                /* It's last, so end the line.  */
-                eol =3D true;
-            } else {
-                qemu_fprintf(f, "P%02d=3D", i);
-                switch (zcr_len) {
-                case 0:
-                    eol =3D i % 8 =3D=3D 7;
-                    break;
-                case 1:
-                    eol =3D i % 6 =3D=3D 5;
-                    break;
-                case 2:
-                case 3:
-                    eol =3D i % 3 =3D=3D 2;
-                    break;
-                default:
-                    /* More than one quadword per predicate.  */
-                    eol =3D true;
-                    break;
-                }
-            }
-            for (j =3D zcr_len / 4; j >=3D 0; j--) {
-                int digits;
-                if (j * 4 + 4 <=3D zcr_len + 1) {
-                    digits =3D 16;
-                } else {
-                    digits =3D (zcr_len % 4 + 1) * 4;
-                }
-                qemu_fprintf(f, "%0*" PRIx64 "%s", digits,
-                             env->vfp.pregs[i].p[j],
-                             j ? ":" : eol ? "\n" : " ");
-            }
-        }
-
-        for (i =3D 0; i < 32; i++) {
-            if (zcr_len =3D=3D 0) {
-                qemu_fprintf(f, "Z%02d=3D%016" PRIx64 ":%016" PRIx64 "%s=
",
-                             i, env->vfp.zregs[i].d[1],
-                             env->vfp.zregs[i].d[0], i & 1 ? "\n" : " ")=
;
-            } else if (zcr_len =3D=3D 1) {
-                qemu_fprintf(f, "Z%02d=3D%016" PRIx64 ":%016" PRIx64
-                             ":%016" PRIx64 ":%016" PRIx64 "\n",
-                             i, env->vfp.zregs[i].d[3], env->vfp.zregs[i=
].d[2],
-                             env->vfp.zregs[i].d[1], env->vfp.zregs[i].d=
[0]);
-            } else {
-                for (j =3D zcr_len; j >=3D 0; j--) {
-                    bool odd =3D (zcr_len - j) % 2 !=3D 0;
-                    if (j =3D=3D zcr_len) {
-                        qemu_fprintf(f, "Z%02d[%x-%x]=3D", i, j, j - 1);
-                    } else if (!odd) {
-                        if (j > 0) {
-                            qemu_fprintf(f, "   [%x-%x]=3D", j, j - 1);
-                        } else {
-                            qemu_fprintf(f, "     [%x]=3D", j);
-                        }
-                    }
-                    qemu_fprintf(f, "%016" PRIx64 ":%016" PRIx64 "%s",
-                                 env->vfp.zregs[i].d[j * 2 + 1],
-                                 env->vfp.zregs[i].d[j * 2],
-                                 odd || j =3D=3D 0 ? "\n" : ":");
-                }
-            }
-        }
-    } else {
-        for (i =3D 0; i < 32; i++) {
-            uint64_t *q =3D aa64_vfp_qreg(env, i);
-            qemu_fprintf(f, "Q%02d=3D%016" PRIx64 ":%016" PRIx64 "%s",
-                         i, q[1], q[0], (i & 1 ? "\n" : " "));
-        }
-    }
-}
-
 void gen_a64_set_pc_im(uint64_t val)
 {
     tcg_gen_movi_i64(cpu_pc, val);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index c6bdf026b4..a5d7723423 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -28,7 +28,6 @@
 #include "tcg-op-gvec.h"
 #include "qemu/log.h"
 #include "qemu/bitops.h"
-#include "qemu/qemu-print.h"
 #include "arm_ldst.h"
 #include "hw/semihosting/semihost.h"
=20
@@ -12342,93 +12341,6 @@ void gen_intermediate_code(CPUState *cpu, Transl=
ationBlock *tb, int max_insns)
     translator_loop(ops, &dc.base, cpu, tb, max_insns);
 }
=20
-void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
-{
-    ARMCPU *cpu =3D ARM_CPU(cs);
-    CPUARMState *env =3D &cpu->env;
-    int i;
-
-    if (is_a64(env)) {
-        aarch64_cpu_dump_state(cs, f, flags);
-        return;
-    }
-
-    for (i =3D 0; i < 16; i++) {
-        qemu_fprintf(f, "R%02d=3D%08x", i, env->regs[i]);
-        if ((i % 4) =3D=3D 3) {
-            qemu_fprintf(f, "\n");
-        } else {
-            qemu_fprintf(f, " ");
-        }
-    }
-
-    if (arm_feature(env, ARM_FEATURE_M)) {
-        uint32_t xpsr =3D xpsr_read(env);
-        const char *mode;
-        const char *ns_status =3D "";
-
-        if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
-            ns_status =3D env->v7m.secure ? "S " : "NS ";
-        }
-
-        if (xpsr & XPSR_EXCP) {
-            mode =3D "handler";
-        } else {
-            if (env->v7m.control[env->v7m.secure] & R_V7M_CONTROL_NPRIV_=
MASK) {
-                mode =3D "unpriv-thread";
-            } else {
-                mode =3D "priv-thread";
-            }
-        }
-
-        qemu_fprintf(f, "XPSR=3D%08x %c%c%c%c %c %s%s\n",
-                     xpsr,
-                     xpsr & XPSR_N ? 'N' : '-',
-                     xpsr & XPSR_Z ? 'Z' : '-',
-                     xpsr & XPSR_C ? 'C' : '-',
-                     xpsr & XPSR_V ? 'V' : '-',
-                     xpsr & XPSR_T ? 'T' : 'A',
-                     ns_status,
-                     mode);
-    } else {
-        uint32_t psr =3D cpsr_read(env);
-        const char *ns_status =3D "";
-
-        if (arm_feature(env, ARM_FEATURE_EL3) &&
-            (psr & CPSR_M) !=3D ARM_CPU_MODE_MON) {
-            ns_status =3D env->cp15.scr_el3 & SCR_NS ? "NS " : "S ";
-        }
-
-        qemu_fprintf(f, "PSR=3D%08x %c%c%c%c %c %s%s%d\n",
-                     psr,
-                     psr & CPSR_N ? 'N' : '-',
-                     psr & CPSR_Z ? 'Z' : '-',
-                     psr & CPSR_C ? 'C' : '-',
-                     psr & CPSR_V ? 'V' : '-',
-                     psr & CPSR_T ? 'T' : 'A',
-                     ns_status,
-                     aarch32_mode_name(psr), (psr & 0x10) ? 32 : 26);
-    }
-
-    if (flags & CPU_DUMP_FPU) {
-        int numvfpregs =3D 0;
-        if (arm_feature(env, ARM_FEATURE_VFP)) {
-            numvfpregs +=3D 16;
-        }
-        if (arm_feature(env, ARM_FEATURE_VFP3)) {
-            numvfpregs +=3D 16;
-        }
-        for (i =3D 0; i < numvfpregs; i++) {
-            uint64_t v =3D *aa32_vfp_dreg(env, i);
-            qemu_fprintf(f, "s%02d=3D%08x s%02d=3D%08x d%02d=3D%016" PRI=
x64 "\n",
-                         i * 2, (uint32_t)v,
-                         i * 2 + 1, (uint32_t)(v >> 32),
-                         i, v);
-        }
-        qemu_fprintf(f, "FPSCR: %08x\n", vfp_get_fpscr(env));
-    }
-}
-
 void restore_state_to_opc(CPUARMState *env, TranslationBlock *tb,
                           target_ulong *data)
 {
diff --git a/target/arm/translate.h b/target/arm/translate.h
index bc1617809d..a20f6e2056 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -169,7 +169,6 @@ static inline void disas_set_insn_syndrome(DisasConte=
xt *s, uint32_t syn)
 #ifdef TARGET_AARCH64
 void a64_translate_init(void);
 void gen_a64_set_pc_im(uint64_t val);
-void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 extern const TranslatorOps aarch64_translator_ops;
 #else
 static inline void a64_translate_init(void)
@@ -179,10 +178,6 @@ static inline void a64_translate_init(void)
 static inline void gen_a64_set_pc_im(uint64_t val)
 {
 }
-
-static inline void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int fla=
gs)
-{
-}
 #endif
=20
 void arm_test_cc(DisasCompare *cmp, int cc);
--=20
2.20.1


