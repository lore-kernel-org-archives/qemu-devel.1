Received: from eggs.gnu.org ([209.51.188.92]:40385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB43v-0000nh-SH
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB43u-000328-11
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:01:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38724
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB43t-0002xe-JF
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:01:45 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31KrYVw156183
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:01:40 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rksyp8mgu-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:01:39 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:01:38 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:58:44 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190401210011.16009-11-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/97] target/arm: Dump SVE state if enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

Also fold the FPCR/FPSR state onto the same line as PSTATE,
and mention but do not dump disabled FPU state.

Cc: qemu-stable@nongnu.org (3.0.1)
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 2bf5f3f91bb4e3faa2a19aec042138a938afbf6a)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/translate-a64.c | 93 +++++++++++++++++++++++++++++++++-----
 1 file changed, 82 insertions(+), 11 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 358f169c75..b29dc49c4f 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -152,8 +152,7 @@ void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
     } else {
         ns_status =3D "";
     }
-
-    cpu_fprintf(f, "\nPSTATE=3D%08x %c%c%c%c %sEL%d%c\n",
+    cpu_fprintf(f, "PSTATE=3D%08x %c%c%c%c %sEL%d%c",
                 psr,
                 psr & PSTATE_N ? 'N' : '-',
                 psr & PSTATE_Z ? 'Z' : '-',
@@ -163,17 +162,89 @@ void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
                 el,
                 psr & PSTATE_SP ? 'h' : 't');
=20
-    if (flags & CPU_DUMP_FPU) {
-        int numvfpregs =3D 32;
-        for (i =3D 0; i < numvfpregs; i++) {
+    if (!(flags & CPU_DUMP_FPU)) {
+        cpu_fprintf(f, "\n");
+        return;
+    }
+    cpu_fprintf(f, "     FPCR=3D%08x FPSR=3D%08x\n",
+                vfp_get_fpcr(env), vfp_get_fpsr(env));
+
+    if (arm_feature(env, ARM_FEATURE_SVE)) {
+        int j, zcr_len =3D env->vfp.zcr_el[1] & 0xf; /* fix for system m=
ode */
+
+        for (i =3D 0; i <=3D FFR_PRED_NUM; i++) {
+            bool eol;
+            if (i =3D=3D FFR_PRED_NUM) {
+                cpu_fprintf(f, "FFR=3D");
+                /* It's last, so end the line.  */
+                eol =3D true;
+            } else {
+                cpu_fprintf(f, "P%02d=3D", i);
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
+                cpu_fprintf(f, "%0*" PRIx64 "%s", digits,
+                            env->vfp.pregs[i].p[j],
+                            j ? ":" : eol ? "\n" : " ");
+            }
+        }
+
+        for (i =3D 0; i < 32; i++) {
+            if (zcr_len =3D=3D 0) {
+                cpu_fprintf(f, "Z%02d=3D%016" PRIx64 ":%016" PRIx64 "%s"=
,
+                            i, env->vfp.zregs[i].d[1],
+                            env->vfp.zregs[i].d[0], i & 1 ? "\n" : " ");
+            } else if (zcr_len =3D=3D 1) {
+                cpu_fprintf(f, "Z%02d=3D%016" PRIx64 ":%016" PRIx64
+                            ":%016" PRIx64 ":%016" PRIx64 "\n",
+                            i, env->vfp.zregs[i].d[3], env->vfp.zregs[i]=
.d[2],
+                            env->vfp.zregs[i].d[1], env->vfp.zregs[i].d[=
0]);
+            } else {
+                for (j =3D zcr_len; j >=3D 0; j--) {
+                    bool odd =3D (zcr_len - j) % 2 !=3D 0;
+                    if (j =3D=3D zcr_len) {
+                        cpu_fprintf(f, "Z%02d[%x-%x]=3D", i, j, j - 1);
+                    } else if (!odd) {
+                        if (j > 0) {
+                            cpu_fprintf(f, "   [%x-%x]=3D", j, j - 1);
+                        } else {
+                            cpu_fprintf(f, "     [%x]=3D", j);
+                        }
+                    }
+                    cpu_fprintf(f, "%016" PRIx64 ":%016" PRIx64 "%s",
+                                env->vfp.zregs[i].d[j * 2 + 1],
+                                env->vfp.zregs[i].d[j * 2],
+                                odd || j =3D=3D 0 ? "\n" : ":");
+                }
+            }
+        }
+    } else {
+        for (i =3D 0; i < 32; i++) {
             uint64_t *q =3D aa64_vfp_qreg(env, i);
-            uint64_t vlo =3D q[0];
-            uint64_t vhi =3D q[1];
-            cpu_fprintf(f, "q%02d=3D%016" PRIx64 ":%016" PRIx64 "%c",
-                        i, vhi, vlo, (i & 1 ? '\n' : ' '));
+            cpu_fprintf(f, "Q%02d=3D%016" PRIx64 ":%016" PRIx64 "%s",
+                        i, q[1], q[0], (i & 1 ? "\n" : " "));
         }
-        cpu_fprintf(f, "FPCR: %08x  FPSR: %08x\n",
-                    vfp_get_fpcr(env), vfp_get_fpsr(env));
     }
 }
=20
--=20
2.17.1
