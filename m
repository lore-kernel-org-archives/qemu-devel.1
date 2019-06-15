Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC93C31E51
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 16:09:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 190992183F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 16:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 190992183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33066 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcBEh-0008Qe-Bw
	for qemu-devel@archiver.kernel.org; Sat, 15 Jun 2019 12:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36046)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hcArH-0004NH-9z
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 11:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hcArE-0001VP-OI
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 11:44:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48988)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hcAr9-0001Dj-Rr; Sat, 15 Jun 2019 11:44:40 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0BD523082B15;
 Sat, 15 Jun 2019 15:44:39 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-41.brq.redhat.com [10.40.204.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E37301001938;
 Sat, 15 Jun 2019 15:44:32 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 15 Jun 2019 17:43:47 +0200
Message-Id: <20190615154352.26824-19-philmd@redhat.com>
In-Reply-To: <20190615154352.26824-1-philmd@redhat.com>
References: <20190615154352.26824-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Sat, 15 Jun 2019 15:44:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 18/23] target/arm: Move CPU state dumping
 routines to helper.c
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Samuel Ortiz <sameo@linux.intel.com>,
 Robert Bradford <robert.bradford@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Samuel Ortiz <sameo@linux.intel.com>

They're not TCG specific and should be living the generic helper file
instead.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Reviewed-by: Robert Bradford <robert.bradford@intel.com>
[PMD: Rebased]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/helper.c        | 214 +++++++++++++++++++++++++++++++++++++
 target/arm/internals.h     |   8 ++
 target/arm/translate-a64.c | 127 ----------------------
 target/arm/translate.c     |  87 ---------------
 target/arm/translate.h     |   5 -
 5 files changed, 222 insertions(+), 219 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a4af02c984..8c32b2bc0d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11293,4 +11293,218 @@ void aarch64_sve_change_el(CPUARMState *env, in=
t old_el,
         aarch64_sve_narrow_vq(env, new_len + 1);
     }
 }
+
+void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
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
 #endif
+
+void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
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
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 06e676bf62..56281d8ece 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1042,4 +1042,12 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t =
address,
                        int *prot, bool *is_subpage,
                        ARMMMUFaultInfo *fi, uint32_t *mregion);
=20
+#ifdef TARGET_AARCH64
+void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags);
+#else
+static inline void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int fla=
gs)
+{
+}
+#endif
+
 #endif
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index ae739f6575..8abe1f0e4f 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -152,133 +152,6 @@ static void set_btype(DisasContext *s, int val)
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
index d0ab3e27e6..1e50627690 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12416,93 +12416,6 @@ void gen_intermediate_code(CPUState *cpu, Transl=
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
index dc06dce767..1dd3ac0a41 100644
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


