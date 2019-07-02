Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BC8C4646D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 830FE2146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Rp05CuXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830FE2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCjG-0002Lw-DL
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 02:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58560)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiByn-00056o-QN
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiByh-0002tA-4h
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:25 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50773 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiByf-0002oQ-Pz; Tue, 02 Jul 2019 02:09:19 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMh51rvz9sPh; Tue,  2 Jul 2019 16:09:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047744;
 bh=2SVQ8ze+kVfVPsZiItEnK7xYSb8sLorTuail945Mi8Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Rp05CuXKFQ99dmTuA3vW46x3/XufebyOeS46mjGwpelQZNHIMcm1V/ilxE2Z+BHs7
 5U6JoTuB0o5LOSUIJ3qnp+l+kZzyZWNv9wM6Z5JwSSGos13cfybPPW+kD34/RROXYr
 HtyCARVOC2IOu6tMyHSJNvSjPPzTsgKlS5V+64DE=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:20 +1000
Message-Id: <20190702060857.3926-13-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 12/49] target/ppc: remove getVSR()/putVSR() from
 fpu_helper.c
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
Cc: lvivier@redhat.com, aik@ozlabs.ru,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Since commit 8a14d31b00 "target/ppc: switch fpr/vsrl registers so all VSX
registers are in host endian order" functions getVSR() and putVSR() which=
 used
to convert the VSR registers into host endian order are no longer require=
d.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20190616123751.781-2-mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c | 762 +++++++++++++++++++---------------------
 1 file changed, 366 insertions(+), 396 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index ffbd19afa1..8da805d175 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -1803,35 +1803,35 @@ uint32_t helper_efdcmpeq(CPUPPCState *env, uint64=
_t op1, uint64_t op2)
 #define VSX_ADD_SUB(name, op, nels, tp, fld, sfprf, r2sp)               =
     \
 void helper_##name(CPUPPCState *env, uint32_t opcode)                   =
     \
 {                                                                       =
     \
-    ppc_vsr_t xt, xa, xb;                                               =
     \
+    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
       \
+    ppc_vsr_t *xa =3D &env->vsr[xA(opcode)];                            =
       \
+    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
       \
+    ppc_vsr_t t =3D *xt;                                                =
       \
     int i;                                                              =
     \
                                                                         =
     \
-    getVSR(xA(opcode), &xa, env);                                       =
     \
-    getVSR(xB(opcode), &xb, env);                                       =
     \
-    getVSR(xT(opcode), &xt, env);                                       =
     \
     helper_reset_fpstatus(env);                                         =
     \
                                                                         =
     \
     for (i =3D 0; i < nels; i++) {                                      =
       \
         float_status tstat =3D env->fp_status;                          =
       \
         set_float_exception_flags(0, &tstat);                           =
     \
-        xt.fld =3D tp##_##op(xa.fld, xb.fld, &tstat);                   =
       \
+        t.fld =3D tp##_##op(xa->fld, xb->fld, &tstat);                  =
       \
         env->fp_status.float_exception_flags |=3D tstat.float_exception_=
flags; \
                                                                         =
     \
         if (unlikely(tstat.float_exception_flags & float_flag_invalid)) =
{    \
             float_invalid_op_addsub(env, sfprf, GETPC(),                =
     \
-                                    tp##_classify(xa.fld) |             =
     \
-                                    tp##_classify(xb.fld));             =
     \
+                                    tp##_classify(xa->fld) |            =
     \
+                                    tp##_classify(xb->fld));            =
     \
         }                                                               =
     \
                                                                         =
     \
         if (r2sp) {                                                     =
     \
-            xt.fld =3D helper_frsp(env, xt.fld);                        =
       \
+            t.fld =3D helper_frsp(env, t.fld);                          =
       \
         }                                                               =
     \
                                                                         =
     \
         if (sfprf) {                                                    =
     \
-            helper_compute_fprf_float64(env, xt.fld);                   =
     \
+            helper_compute_fprf_float64(env, t.fld);                    =
     \
         }                                                               =
     \
     }                                                                   =
     \
-    putVSR(xT(opcode), &xt, env);                                       =
     \
+    *xt =3D t;                                                          =
       \
     do_float_check_status(env, GETPC());                                =
     \
 }
=20
@@ -1846,12 +1846,12 @@ VSX_ADD_SUB(xvsubsp, sub, 4, float32, VsrW(i), 0,=
 0)
=20
 void helper_xsaddqp(CPUPPCState *env, uint32_t opcode)
 {
-    ppc_vsr_t xt, xa, xb;
+    ppc_vsr_t *xt =3D &env->vsr[rD(opcode) + 32];
+    ppc_vsr_t *xa =3D &env->vsr[rA(opcode) + 32];
+    ppc_vsr_t *xb =3D &env->vsr[rB(opcode) + 32];
+    ppc_vsr_t t =3D *xt;
     float_status tstat;
=20
-    getVSR(rA(opcode) + 32, &xa, env);
-    getVSR(rB(opcode) + 32, &xb, env);
-    getVSR(rD(opcode) + 32, &xt, env);
     helper_reset_fpstatus(env);
=20
     tstat =3D env->fp_status;
@@ -1860,18 +1860,18 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t op=
code)
     }
=20
     set_float_exception_flags(0, &tstat);
-    xt.f128 =3D float128_add(xa.f128, xb.f128, &tstat);
+    t.f128 =3D float128_add(xa->f128, xb->f128, &tstat);
     env->fp_status.float_exception_flags |=3D tstat.float_exception_flag=
s;
=20
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
         float_invalid_op_addsub(env, 1, GETPC(),
-                                float128_classify(xa.f128) |
-                                float128_classify(xb.f128));
+                                float128_classify(xa->f128) |
+                                float128_classify(xb->f128));
     }
=20
-    helper_compute_fprf_float128(env, xt.f128);
+    helper_compute_fprf_float128(env, t.f128);
=20
-    putVSR(rD(opcode) + 32, &xt, env);
+    *xt =3D t;
     do_float_check_status(env, GETPC());
 }
=20
@@ -1886,36 +1886,36 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t op=
code)
 #define VSX_MUL(op, nels, tp, fld, sfprf, r2sp)                         =
     \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
     \
 {                                                                       =
     \
-    ppc_vsr_t xt, xa, xb;                                               =
     \
+    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
       \
+    ppc_vsr_t *xa =3D &env->vsr[xA(opcode)];                            =
       \
+    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
       \
+    ppc_vsr_t t =3D *xt;                                                =
       \
     int i;                                                              =
     \
                                                                         =
     \
-    getVSR(xA(opcode), &xa, env);                                       =
     \
-    getVSR(xB(opcode), &xb, env);                                       =
     \
-    getVSR(xT(opcode), &xt, env);                                       =
     \
     helper_reset_fpstatus(env);                                         =
     \
                                                                         =
     \
     for (i =3D 0; i < nels; i++) {                                      =
       \
         float_status tstat =3D env->fp_status;                          =
       \
         set_float_exception_flags(0, &tstat);                           =
     \
-        xt.fld =3D tp##_mul(xa.fld, xb.fld, &tstat);                    =
       \
+        t.fld =3D tp##_mul(xa->fld, xb->fld, &tstat);                   =
       \
         env->fp_status.float_exception_flags |=3D tstat.float_exception_=
flags; \
                                                                         =
     \
         if (unlikely(tstat.float_exception_flags & float_flag_invalid)) =
{    \
             float_invalid_op_mul(env, sfprf, GETPC(),                   =
     \
-                                 tp##_classify(xa.fld) |                =
     \
-                                 tp##_classify(xb.fld));                =
     \
+                                 tp##_classify(xa->fld) |               =
     \
+                                 tp##_classify(xb->fld));               =
     \
         }                                                               =
     \
                                                                         =
     \
         if (r2sp) {                                                     =
     \
-            xt.fld =3D helper_frsp(env, xt.fld);                        =
       \
+            t.fld =3D helper_frsp(env, t.fld);                          =
       \
         }                                                               =
     \
                                                                         =
     \
         if (sfprf) {                                                    =
     \
-            helper_compute_fprf_float64(env, xt.fld);                   =
     \
+            helper_compute_fprf_float64(env, t.fld);                    =
     \
         }                                                               =
     \
     }                                                                   =
     \
                                                                         =
     \
-    putVSR(xT(opcode), &xt, env);                                       =
     \
+    *xt =3D t;                                                          =
       \
     do_float_check_status(env, GETPC());                                =
     \
 }
=20
@@ -1926,13 +1926,12 @@ VSX_MUL(xvmulsp, 4, float32, VsrW(i), 0, 0)
=20
 void helper_xsmulqp(CPUPPCState *env, uint32_t opcode)
 {
-    ppc_vsr_t xt, xa, xb;
+    ppc_vsr_t *xt =3D &env->vsr[rD(opcode) + 32];
+    ppc_vsr_t *xa =3D &env->vsr[rA(opcode) + 32];
+    ppc_vsr_t *xb =3D &env->vsr[rB(opcode) + 32];
+    ppc_vsr_t t =3D *xt;
     float_status tstat;
=20
-    getVSR(rA(opcode) + 32, &xa, env);
-    getVSR(rB(opcode) + 32, &xb, env);
-    getVSR(rD(opcode) + 32, &xt, env);
-
     helper_reset_fpstatus(env);
     tstat =3D env->fp_status;
     if (unlikely(Rc(opcode) !=3D 0)) {
@@ -1940,17 +1939,17 @@ void helper_xsmulqp(CPUPPCState *env, uint32_t op=
code)
     }
=20
     set_float_exception_flags(0, &tstat);
-    xt.f128 =3D float128_mul(xa.f128, xb.f128, &tstat);
+    t.f128 =3D float128_mul(xa->f128, xb->f128, &tstat);
     env->fp_status.float_exception_flags |=3D tstat.float_exception_flag=
s;
=20
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
         float_invalid_op_mul(env, 1, GETPC(),
-                             float128_classify(xa.f128) |
-                             float128_classify(xb.f128));
+                             float128_classify(xa->f128) |
+                             float128_classify(xb->f128));
     }
-    helper_compute_fprf_float128(env, xt.f128);
+    helper_compute_fprf_float128(env, t.f128);
=20
-    putVSR(rD(opcode) + 32, &xt, env);
+    *xt =3D t;
     do_float_check_status(env, GETPC());
 }
=20
@@ -1965,39 +1964,39 @@ void helper_xsmulqp(CPUPPCState *env, uint32_t op=
code)
 #define VSX_DIV(op, nels, tp, fld, sfprf, r2sp)                         =
      \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
      \
 {                                                                       =
      \
-    ppc_vsr_t xt, xa, xb;                                               =
      \
+    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
        \
+    ppc_vsr_t *xa =3D &env->vsr[xA(opcode)];                            =
        \
+    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
        \
+    ppc_vsr_t t =3D *xt;                                                =
        \
     int i;                                                              =
      \
                                                                         =
      \
-    getVSR(xA(opcode), &xa, env);                                       =
      \
-    getVSR(xB(opcode), &xb, env);                                       =
      \
-    getVSR(xT(opcode), &xt, env);                                       =
      \
     helper_reset_fpstatus(env);                                         =
      \
                                                                         =
      \
     for (i =3D 0; i < nels; i++) {                                      =
        \
         float_status tstat =3D env->fp_status;                          =
        \
         set_float_exception_flags(0, &tstat);                           =
      \
-        xt.fld =3D tp##_div(xa.fld, xb.fld, &tstat);                    =
        \
+        t.fld =3D tp##_div(xa->fld, xb->fld, &tstat);                   =
        \
         env->fp_status.float_exception_flags |=3D tstat.float_exception_=
flags;  \
                                                                         =
      \
         if (unlikely(tstat.float_exception_flags & float_flag_invalid)) =
{     \
             float_invalid_op_div(env, sfprf, GETPC(),                   =
      \
-                                 tp##_classify(xa.fld) |                =
      \
-                                 tp##_classify(xb.fld));                =
      \
+                                 tp##_classify(xa->fld) |               =
      \
+                                 tp##_classify(xb->fld));               =
      \
         }                                                               =
      \
         if (unlikely(tstat.float_exception_flags & float_flag_divbyzero)=
) {   \
             float_zero_divide_excp(env, GETPC());                       =
      \
         }                                                               =
      \
                                                                         =
      \
         if (r2sp) {                                                     =
      \
-            xt.fld =3D helper_frsp(env, xt.fld);                        =
        \
+            t.fld =3D helper_frsp(env, t.fld);                          =
        \
         }                                                               =
      \
                                                                         =
      \
         if (sfprf) {                                                    =
      \
-            helper_compute_fprf_float64(env, xt.fld);                   =
      \
+            helper_compute_fprf_float64(env, t.fld);                    =
      \
         }                                                               =
      \
     }                                                                   =
      \
                                                                         =
      \
-    putVSR(xT(opcode), &xt, env);                                       =
      \
+    *xt =3D t;                                                          =
        \
     do_float_check_status(env, GETPC());                                =
      \
 }
=20
@@ -2008,13 +2007,12 @@ VSX_DIV(xvdivsp, 4, float32, VsrW(i), 0, 0)
=20
 void helper_xsdivqp(CPUPPCState *env, uint32_t opcode)
 {
-    ppc_vsr_t xt, xa, xb;
+    ppc_vsr_t *xt =3D &env->vsr[rD(opcode) + 32];
+    ppc_vsr_t *xa =3D &env->vsr[rA(opcode) + 32];
+    ppc_vsr_t *xb =3D &env->vsr[rB(opcode) + 32];
+    ppc_vsr_t t =3D *xt;
     float_status tstat;
=20
-    getVSR(rA(opcode) + 32, &xa, env);
-    getVSR(rB(opcode) + 32, &xb, env);
-    getVSR(rD(opcode) + 32, &xt, env);
-
     helper_reset_fpstatus(env);
     tstat =3D env->fp_status;
     if (unlikely(Rc(opcode) !=3D 0)) {
@@ -2022,20 +2020,20 @@ void helper_xsdivqp(CPUPPCState *env, uint32_t op=
code)
     }
=20
     set_float_exception_flags(0, &tstat);
-    xt.f128 =3D float128_div(xa.f128, xb.f128, &tstat);
+    t.f128 =3D float128_div(xa->f128, xb->f128, &tstat);
     env->fp_status.float_exception_flags |=3D tstat.float_exception_flag=
s;
=20
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
         float_invalid_op_div(env, 1, GETPC(),
-                             float128_classify(xa.f128) |
-                             float128_classify(xb.f128));
+                             float128_classify(xa->f128) |
+                             float128_classify(xb->f128));
     }
     if (unlikely(tstat.float_exception_flags & float_flag_divbyzero)) {
         float_zero_divide_excp(env, GETPC());
     }
=20
-    helper_compute_fprf_float128(env, xt.f128);
-    putVSR(rD(opcode) + 32, &xt, env);
+    helper_compute_fprf_float128(env, t.f128);
+    *xt =3D t;
     do_float_check_status(env, GETPC());
 }
=20
@@ -2050,29 +2048,29 @@ void helper_xsdivqp(CPUPPCState *env, uint32_t op=
code)
 #define VSX_RE(op, nels, tp, fld, sfprf, r2sp)                          =
      \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
      \
 {                                                                       =
      \
-    ppc_vsr_t xt, xb;                                                   =
      \
+    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
        \
+    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
        \
+    ppc_vsr_t t =3D *xt;                                                =
        \
     int i;                                                              =
      \
                                                                         =
      \
-    getVSR(xB(opcode), &xb, env);                                       =
      \
-    getVSR(xT(opcode), &xt, env);                                       =
      \
     helper_reset_fpstatus(env);                                         =
      \
                                                                         =
      \
     for (i =3D 0; i < nels; i++) {                                      =
        \
-        if (unlikely(tp##_is_signaling_nan(xb.fld, &env->fp_status))) { =
      \
+        if (unlikely(tp##_is_signaling_nan(xb->fld, &env->fp_status))) {=
      \
             float_invalid_op_vxsnan(env, GETPC());                      =
      \
         }                                                               =
      \
-        xt.fld =3D tp##_div(tp##_one, xb.fld, &env->fp_status);         =
        \
+        t.fld =3D tp##_div(tp##_one, xb->fld, &env->fp_status);         =
        \
                                                                         =
      \
         if (r2sp) {                                                     =
      \
-            xt.fld =3D helper_frsp(env, xt.fld);                        =
        \
+            t.fld =3D helper_frsp(env, t.fld);                          =
        \
         }                                                               =
      \
                                                                         =
      \
         if (sfprf) {                                                    =
      \
-            helper_compute_fprf_float64(env, xt.fld);                   =
      \
+            helper_compute_fprf_float64(env, t.fld);                    =
      \
         }                                                               =
      \
     }                                                                   =
      \
                                                                         =
      \
-    putVSR(xT(opcode), &xt, env);                                       =
      \
+    *xt =3D t;                                                          =
        \
     do_float_check_status(env, GETPC());                                =
      \
 }
=20
@@ -2092,37 +2090,37 @@ VSX_RE(xvresp, 4, float32, VsrW(i), 0, 0)
 #define VSX_SQRT(op, nels, tp, fld, sfprf, r2sp)                        =
     \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
     \
 {                                                                       =
     \
-    ppc_vsr_t xt, xb;                                                   =
     \
+    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
       \
+    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
       \
+    ppc_vsr_t t =3D *xt;                                                =
       \
     int i;                                                              =
     \
                                                                         =
     \
-    getVSR(xB(opcode), &xb, env);                                       =
     \
-    getVSR(xT(opcode), &xt, env);                                       =
     \
     helper_reset_fpstatus(env);                                         =
     \
                                                                         =
     \
     for (i =3D 0; i < nels; i++) {                                      =
       \
         float_status tstat =3D env->fp_status;                          =
       \
         set_float_exception_flags(0, &tstat);                           =
     \
-        xt.fld =3D tp##_sqrt(xb.fld, &tstat);                           =
       \
+        t.fld =3D tp##_sqrt(xb->fld, &tstat);                           =
       \
         env->fp_status.float_exception_flags |=3D tstat.float_exception_=
flags; \
                                                                         =
     \
         if (unlikely(tstat.float_exception_flags & float_flag_invalid)) =
{    \
-            if (tp##_is_neg(xb.fld) && !tp##_is_zero(xb.fld)) {         =
     \
+            if (tp##_is_neg(xb->fld) && !tp##_is_zero(xb->fld)) {       =
     \
                 float_invalid_op_vxsqrt(env, sfprf, GETPC());           =
     \
-            } else if (tp##_is_signaling_nan(xb.fld, &tstat)) {         =
     \
+            } else if (tp##_is_signaling_nan(xb->fld, &tstat)) {        =
     \
                 float_invalid_op_vxsnan(env, GETPC());                  =
     \
             }                                                           =
     \
         }                                                               =
     \
                                                                         =
     \
         if (r2sp) {                                                     =
     \
-            xt.fld =3D helper_frsp(env, xt.fld);                        =
       \
+            t.fld =3D helper_frsp(env, t.fld);                          =
       \
         }                                                               =
     \
                                                                         =
     \
         if (sfprf) {                                                    =
     \
-            helper_compute_fprf_float64(env, xt.fld);                   =
     \
+            helper_compute_fprf_float64(env, t.fld);                    =
     \
         }                                                               =
     \
     }                                                                   =
     \
                                                                         =
     \
-    putVSR(xT(opcode), &xt, env);                                       =
     \
+    *xt =3D t;                                                          =
       \
     do_float_check_status(env, GETPC());                                =
     \
 }
=20
@@ -2142,38 +2140,38 @@ VSX_SQRT(xvsqrtsp, 4, float32, VsrW(i), 0, 0)
 #define VSX_RSQRTE(op, nels, tp, fld, sfprf, r2sp)                      =
     \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
     \
 {                                                                       =
     \
-    ppc_vsr_t xt, xb;                                                   =
     \
+    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
       \
+    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
       \
+    ppc_vsr_t t =3D *xt;                                                =
       \
     int i;                                                              =
     \
                                                                         =
     \
-    getVSR(xB(opcode), &xb, env);                                       =
     \
-    getVSR(xT(opcode), &xt, env);                                       =
     \
     helper_reset_fpstatus(env);                                         =
     \
                                                                         =
     \
     for (i =3D 0; i < nels; i++) {                                      =
       \
         float_status tstat =3D env->fp_status;                          =
       \
         set_float_exception_flags(0, &tstat);                           =
     \
-        xt.fld =3D tp##_sqrt(xb.fld, &tstat);                           =
       \
-        xt.fld =3D tp##_div(tp##_one, xt.fld, &tstat);                  =
       \
+        t.fld =3D tp##_sqrt(xb->fld, &tstat);                           =
       \
+        t.fld =3D tp##_div(tp##_one, t.fld, &tstat);                    =
       \
         env->fp_status.float_exception_flags |=3D tstat.float_exception_=
flags; \
                                                                         =
     \
         if (unlikely(tstat.float_exception_flags & float_flag_invalid)) =
{    \
-            if (tp##_is_neg(xb.fld) && !tp##_is_zero(xb.fld)) {         =
     \
+            if (tp##_is_neg(xb->fld) && !tp##_is_zero(xb->fld)) {       =
     \
                 float_invalid_op_vxsqrt(env, sfprf, GETPC());           =
     \
-            } else if (tp##_is_signaling_nan(xb.fld, &tstat)) {         =
     \
+            } else if (tp##_is_signaling_nan(xb->fld, &tstat)) {        =
     \
                 float_invalid_op_vxsnan(env, GETPC());                  =
     \
             }                                                           =
     \
         }                                                               =
     \
                                                                         =
     \
         if (r2sp) {                                                     =
     \
-            xt.fld =3D helper_frsp(env, xt.fld);                        =
       \
+            t.fld =3D helper_frsp(env, t.fld);                          =
       \
         }                                                               =
     \
                                                                         =
     \
         if (sfprf) {                                                    =
     \
-            helper_compute_fprf_float64(env, xt.fld);                   =
     \
+            helper_compute_fprf_float64(env, t.fld);                    =
     \
         }                                                               =
     \
     }                                                                   =
     \
                                                                         =
     \
-    putVSR(xT(opcode), &xt, env);                                       =
     \
+    *xt =3D t;                                                          =
       \
     do_float_check_status(env, GETPC());                                =
     \
 }
=20
@@ -2195,37 +2193,35 @@ VSX_RSQRTE(xvrsqrtesp, 4, float32, VsrW(i), 0, 0)
 #define VSX_TDIV(op, nels, tp, fld, emin, emax, nbits)                  =
\
 void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
\
 {                                                                       =
\
-    ppc_vsr_t xa, xb;                                                   =
\
+    ppc_vsr_t *xa =3D &env->vsr[xA(opcode)];                            =
  \
+    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
  \
     int i;                                                              =
\
     int fe_flag =3D 0;                                                  =
  \
     int fg_flag =3D 0;                                                  =
  \
                                                                         =
\
-    getVSR(xA(opcode), &xa, env);                                       =
\
-    getVSR(xB(opcode), &xb, env);                                       =
\
-                                                                        =
\
     for (i =3D 0; i < nels; i++) {                                      =
  \
-        if (unlikely(tp##_is_infinity(xa.fld) ||                        =
\
-                     tp##_is_infinity(xb.fld) ||                        =
\
-                     tp##_is_zero(xb.fld))) {                           =
\
+        if (unlikely(tp##_is_infinity(xa->fld) ||                       =
\
+                     tp##_is_infinity(xb->fld) ||                       =
\
+                     tp##_is_zero(xb->fld))) {                          =
\
             fe_flag =3D 1;                                              =
  \
             fg_flag =3D 1;                                              =
  \
         } else {                                                        =
\
-            int e_a =3D ppc_##tp##_get_unbiased_exp(xa.fld);            =
  \
-            int e_b =3D ppc_##tp##_get_unbiased_exp(xb.fld);            =
  \
+            int e_a =3D ppc_##tp##_get_unbiased_exp(xa->fld);           =
  \
+            int e_b =3D ppc_##tp##_get_unbiased_exp(xb->fld);           =
  \
                                                                         =
\
-            if (unlikely(tp##_is_any_nan(xa.fld) ||                     =
\
-                         tp##_is_any_nan(xb.fld))) {                    =
\
+            if (unlikely(tp##_is_any_nan(xa->fld) ||                    =
\
+                         tp##_is_any_nan(xb->fld))) {                   =
\
                 fe_flag =3D 1;                                          =
  \
             } else if ((e_b <=3D emin) || (e_b >=3D (emax - 2))) {      =
    \
                 fe_flag =3D 1;                                          =
  \
-            } else if (!tp##_is_zero(xa.fld) &&                         =
\
+            } else if (!tp##_is_zero(xa->fld) &&                        =
\
                        (((e_a - e_b) >=3D emax) ||                      =
  \
                         ((e_a - e_b) <=3D (emin + 1)) ||                =
  \
                         (e_a <=3D (emin + nbits)))) {                   =
  \
                 fe_flag =3D 1;                                          =
  \
             }                                                           =
\
                                                                         =
\
-            if (unlikely(tp##_is_zero_or_denormal(xb.fld))) {           =
\
+            if (unlikely(tp##_is_zero_or_denormal(xb->fld))) {          =
\
                 /*                                                      =
\
                  * XB is not zero because of the above check and so     =
\
                  * must be denormalized.                                =
\
@@ -2255,34 +2251,31 @@ VSX_TDIV(xvtdivsp, 4, float32, VsrW(i), -126, 127=
, 23)
 #define VSX_TSQRT(op, nels, tp, fld, emin, nbits)                       =
\
 void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
\
 {                                                                       =
\
-    ppc_vsr_t xa, xb;                                                   =
\
+    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
  \
     int i;                                                              =
\
     int fe_flag =3D 0;                                                  =
  \
     int fg_flag =3D 0;                                                  =
  \
                                                                         =
\
-    getVSR(xA(opcode), &xa, env);                                       =
\
-    getVSR(xB(opcode), &xb, env);                                       =
\
-                                                                        =
\
     for (i =3D 0; i < nels; i++) {                                      =
  \
-        if (unlikely(tp##_is_infinity(xb.fld) ||                        =
\
-                     tp##_is_zero(xb.fld))) {                           =
\
+        if (unlikely(tp##_is_infinity(xb->fld) ||                       =
\
+                     tp##_is_zero(xb->fld))) {                          =
\
             fe_flag =3D 1;                                              =
  \
             fg_flag =3D 1;                                              =
  \
         } else {                                                        =
\
-            int e_b =3D ppc_##tp##_get_unbiased_exp(xb.fld);            =
  \
+            int e_b =3D ppc_##tp##_get_unbiased_exp(xb->fld);           =
  \
                                                                         =
\
-            if (unlikely(tp##_is_any_nan(xb.fld))) {                    =
\
+            if (unlikely(tp##_is_any_nan(xb->fld))) {                   =
\
                 fe_flag =3D 1;                                          =
  \
-            } else if (unlikely(tp##_is_zero(xb.fld))) {                =
\
+            } else if (unlikely(tp##_is_zero(xb->fld))) {               =
\
                 fe_flag =3D 1;                                          =
  \
-            } else if (unlikely(tp##_is_neg(xb.fld))) {                 =
\
+            } else if (unlikely(tp##_is_neg(xb->fld))) {                =
\
                 fe_flag =3D 1;                                          =
  \
-            } else if (!tp##_is_zero(xb.fld) &&                         =
\
+            } else if (!tp##_is_zero(xb->fld) &&                        =
\
                        (e_b <=3D (emin + nbits))) {                     =
  \
                 fe_flag =3D 1;                                          =
  \
             }                                                           =
\
                                                                         =
\
-            if (unlikely(tp##_is_zero_or_denormal(xb.fld))) {           =
\
+            if (unlikely(tp##_is_zero_or_denormal(xb->fld))) {          =
\
                 /*                                                      =
\
                  * XB is not zero because of the above check and        =
\
                  * therefore must be denormalized.                      =
\
@@ -2313,24 +2306,20 @@ VSX_TSQRT(xvtsqrtsp, 4, float32, VsrW(i), -126, 2=
3)
 #define VSX_MADD(op, nels, tp, fld, maddflgs, afrm, sfprf, r2sp)        =
      \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
      \
 {                                                                       =
      \
-    ppc_vsr_t xt_in, xa, xb, xt_out;                                    =
      \
-    ppc_vsr_t *b, *c;                                                   =
      \
+    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
        \
+    ppc_vsr_t *xa =3D &env->vsr[xA(opcode)];                            =
        \
+    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
        \
+    ppc_vsr_t t =3D *xt, *b, *c;                                        =
        \
     int i;                                                              =
      \
                                                                         =
      \
     if (afrm) { /* AxB + T */                                           =
      \
-        b =3D &xb;                                                      =
        \
-        c =3D &xt_in;                                                   =
        \
+        b =3D xb;                                                       =
        \
+        c =3D xt;                                                       =
        \
     } else { /* AxT + B */                                              =
      \
-        b =3D &xt_in;                                                   =
        \
-        c =3D &xb;                                                      =
        \
+        b =3D xt;                                                       =
        \
+        c =3D xb;                                                       =
        \
     }                                                                   =
      \
                                                                         =
      \
-    getVSR(xA(opcode), &xa, env);                                       =
      \
-    getVSR(xB(opcode), &xb, env);                                       =
      \
-    getVSR(xT(opcode), &xt_in, env);                                    =
      \
-                                                                        =
      \
-    xt_out =3D xt_in;                                                   =
        \
-                                                                        =
      \
     helper_reset_fpstatus(env);                                         =
      \
                                                                         =
      \
     for (i =3D 0; i < nels; i++) {                                      =
        \
@@ -2342,30 +2331,30 @@ void helper_##op(CPUPPCState *env, uint32_t opcod=
e)                           \
              * result to odd.                                           =
      \
              */                                                         =
      \
             set_float_rounding_mode(float_round_to_zero, &tstat);       =
      \
-            xt_out.fld =3D tp##_muladd(xa.fld, b->fld, c->fld,          =
        \
-                                       maddflgs, &tstat);               =
      \
-            xt_out.fld |=3D (get_float_exception_flags(&tstat) &        =
        \
-                              float_flag_inexact) !=3D 0;               =
        \
+            t.fld =3D tp##_muladd(xa->fld, b->fld, c->fld,              =
        \
+                                maddflgs, &tstat);                      =
      \
+            t.fld |=3D (get_float_exception_flags(&tstat) &             =
        \
+                      float_flag_inexact) !=3D 0;                       =
        \
         } else {                                                        =
      \
-            xt_out.fld =3D tp##_muladd(xa.fld, b->fld, c->fld,          =
        \
-                                        maddflgs, &tstat);              =
      \
+            t.fld =3D tp##_muladd(xa->fld, b->fld, c->fld,              =
        \
+                                maddflgs, &tstat);                      =
      \
         }                                                               =
      \
         env->fp_status.float_exception_flags |=3D tstat.float_exception_=
flags;  \
                                                                         =
      \
         if (unlikely(tstat.float_exception_flags & float_flag_invalid)) =
{     \
-            tp##_maddsub_update_excp(env, xa.fld, b->fld,               =
      \
+            tp##_maddsub_update_excp(env, xa->fld, b->fld,              =
      \
                                      c->fld, maddflgs, GETPC());        =
      \
         }                                                               =
      \
                                                                         =
      \
         if (r2sp) {                                                     =
      \
-            xt_out.fld =3D helper_frsp(env, xt_out.fld);                =
        \
+            t.fld =3D helper_frsp(env, t.fld);                          =
        \
         }                                                               =
      \
                                                                         =
      \
         if (sfprf) {                                                    =
      \
-            helper_compute_fprf_float64(env, xt_out.fld);               =
      \
+            helper_compute_fprf_float64(env, t.fld);                    =
      \
         }                                                               =
      \
     }                                                                   =
      \
-    putVSR(xT(opcode), &xt_out, env);                                   =
      \
+    *xt =3D t;                                                          =
        \
     do_float_check_status(env, GETPC());                                =
      \
 }
=20
@@ -2415,22 +2404,21 @@ VSX_MADD(xvnmsubmsp, 4, float32, VsrW(i), NMSUB_F=
LGS, 0, 0, 0)
 #define VSX_SCALAR_CMP_DP(op, cmp, exp, svxvc)                          =
      \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
      \
 {                                                                       =
      \
-    ppc_vsr_t xt, xa, xb;                                               =
      \
+    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
        \
+    ppc_vsr_t *xa =3D &env->vsr[xA(opcode)];                            =
        \
+    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
        \
+    ppc_vsr_t t =3D *xt;                                                =
        \
     bool vxsnan_flag =3D false, vxvc_flag =3D false, vex_flag =3D false;=
            \
                                                                         =
      \
-    getVSR(xA(opcode), &xa, env);                                       =
      \
-    getVSR(xB(opcode), &xb, env);                                       =
      \
-    getVSR(xT(opcode), &xt, env);                                       =
      \
-                                                                        =
      \
-    if (float64_is_signaling_nan(xa.VsrD(0), &env->fp_status) ||        =
      \
-        float64_is_signaling_nan(xb.VsrD(0), &env->fp_status)) {        =
      \
+    if (float64_is_signaling_nan(xa->VsrD(0), &env->fp_status) ||       =
      \
+        float64_is_signaling_nan(xb->VsrD(0), &env->fp_status)) {       =
      \
         vxsnan_flag =3D true;                                           =
        \
         if (fpscr_ve =3D=3D 0 && svxvc) {                               =
          \
             vxvc_flag =3D true;                                         =
        \
         }                                                               =
      \
     } else if (svxvc) {                                                 =
      \
-        vxvc_flag =3D float64_is_quiet_nan(xa.VsrD(0), &env->fp_status) =
||      \
-            float64_is_quiet_nan(xb.VsrD(0), &env->fp_status);          =
      \
+        vxvc_flag =3D float64_is_quiet_nan(xa->VsrD(0), &env->fp_status)=
 ||     \
+            float64_is_quiet_nan(xb->VsrD(0), &env->fp_status);         =
      \
     }                                                                   =
      \
     if (vxsnan_flag) {                                                  =
      \
         float_invalid_op_vxsnan(env, GETPC());                          =
      \
@@ -2441,15 +2429,16 @@ void helper_##op(CPUPPCState *env, uint32_t opcod=
e)                           \
     vex_flag =3D fpscr_ve && (vxvc_flag || vxsnan_flag);                =
        \
                                                                         =
      \
     if (!vex_flag) {                                                    =
      \
-        if (float64_##cmp(xb.VsrD(0), xa.VsrD(0), &env->fp_status) =3D=3D=
 exp) {  \
-            xt.VsrD(0) =3D -1;                                          =
        \
-            xt.VsrD(1) =3D 0;                                           =
        \
+        if (float64_##cmp(xb->VsrD(0), xa->VsrD(0),                     =
      \
+                          &env->fp_status) =3D=3D exp) {                =
          \
+            t.VsrD(0) =3D -1;                                           =
        \
+            t.VsrD(1) =3D 0;                                            =
        \
         } else {                                                        =
      \
-            xt.VsrD(0) =3D 0;                                           =
        \
-            xt.VsrD(1) =3D 0;                                           =
        \
+            t.VsrD(0) =3D 0;                                            =
        \
+            t.VsrD(1) =3D 0;                                            =
        \
         }                                                               =
      \
     }                                                                   =
      \
-    putVSR(xT(opcode), &xt, env);                                       =
      \
+    *xt =3D t;                                                          =
        \
     do_float_check_status(env, GETPC());                                =
      \
 }
=20
@@ -2460,18 +2449,16 @@ VSX_SCALAR_CMP_DP(xscmpnedp, eq, 0, 0)
=20
 void helper_xscmpexpdp(CPUPPCState *env, uint32_t opcode)
 {
-    ppc_vsr_t xa, xb;
+    ppc_vsr_t *xa =3D &env->vsr[xA(opcode)];
+    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];
     int64_t exp_a, exp_b;
     uint32_t cc;
=20
-    getVSR(xA(opcode), &xa, env);
-    getVSR(xB(opcode), &xb, env);
-
-    exp_a =3D extract64(xa.VsrD(0), 52, 11);
-    exp_b =3D extract64(xb.VsrD(0), 52, 11);
+    exp_a =3D extract64(xa->VsrD(0), 52, 11);
+    exp_b =3D extract64(xb->VsrD(0), 52, 11);
=20
-    if (unlikely(float64_is_any_nan(xa.VsrD(0)) ||
-                 float64_is_any_nan(xb.VsrD(0)))) {
+    if (unlikely(float64_is_any_nan(xa->VsrD(0)) ||
+                 float64_is_any_nan(xb->VsrD(0)))) {
         cc =3D CRF_SO;
     } else {
         if (exp_a < exp_b) {
@@ -2492,18 +2479,16 @@ void helper_xscmpexpdp(CPUPPCState *env, uint32_t=
 opcode)
=20
 void helper_xscmpexpqp(CPUPPCState *env, uint32_t opcode)
 {
-    ppc_vsr_t xa, xb;
+    ppc_vsr_t *xa =3D &env->vsr[rA(opcode) + 32];
+    ppc_vsr_t *xb =3D &env->vsr[rB(opcode) + 32];
     int64_t exp_a, exp_b;
     uint32_t cc;
=20
-    getVSR(rA(opcode) + 32, &xa, env);
-    getVSR(rB(opcode) + 32, &xb, env);
-
-    exp_a =3D extract64(xa.VsrD(0), 48, 15);
-    exp_b =3D extract64(xb.VsrD(0), 48, 15);
+    exp_a =3D extract64(xa->VsrD(0), 48, 15);
+    exp_b =3D extract64(xb->VsrD(0), 48, 15);
=20
-    if (unlikely(float128_is_any_nan(xa.f128) ||
-                 float128_is_any_nan(xb.f128))) {
+    if (unlikely(float128_is_any_nan(xa->f128) ||
+                 float128_is_any_nan(xb->f128))) {
         cc =3D CRF_SO;
     } else {
         if (exp_a < exp_b) {
@@ -2525,23 +2510,22 @@ void helper_xscmpexpqp(CPUPPCState *env, uint32_t=
 opcode)
 #define VSX_SCALAR_CMP(op, ordered)                                     =
 \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
 \
 {                                                                       =
 \
-    ppc_vsr_t xa, xb;                                                   =
 \
+    ppc_vsr_t *xa =3D &env->vsr[xA(opcode)];                            =
   \
+    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
   \
     uint32_t cc =3D 0;                                                  =
   \
     bool vxsnan_flag =3D false, vxvc_flag =3D false;                    =
     \
                                                                         =
 \
     helper_reset_fpstatus(env);                                         =
 \
-    getVSR(xA(opcode), &xa, env);                                       =
 \
-    getVSR(xB(opcode), &xb, env);                                       =
 \
                                                                         =
 \
-    if (float64_is_signaling_nan(xa.VsrD(0), &env->fp_status) ||        =
 \
-        float64_is_signaling_nan(xb.VsrD(0), &env->fp_status)) {        =
 \
+    if (float64_is_signaling_nan(xa->VsrD(0), &env->fp_status) ||       =
 \
+        float64_is_signaling_nan(xb->VsrD(0), &env->fp_status)) {       =
 \
         vxsnan_flag =3D true;                                           =
   \
         cc =3D CRF_SO;                                                  =
   \
         if (fpscr_ve =3D=3D 0 && ordered) {                             =
     \
             vxvc_flag =3D true;                                         =
   \
         }                                                               =
 \
-    } else if (float64_is_quiet_nan(xa.VsrD(0), &env->fp_status) ||     =
 \
-               float64_is_quiet_nan(xb.VsrD(0), &env->fp_status)) {     =
 \
+    } else if (float64_is_quiet_nan(xa->VsrD(0), &env->fp_status) ||    =
 \
+               float64_is_quiet_nan(xb->VsrD(0), &env->fp_status)) {    =
 \
         cc =3D CRF_SO;                                                  =
   \
         if (ordered) {                                                  =
 \
             vxvc_flag =3D true;                                         =
   \
@@ -2554,9 +2538,9 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)=
                      \
         float_invalid_op_vxvc(env, 0, GETPC());                         =
 \
     }                                                                   =
 \
                                                                         =
 \
-    if (float64_lt(xa.VsrD(0), xb.VsrD(0), &env->fp_status)) {          =
 \
+    if (float64_lt(xa->VsrD(0), xb->VsrD(0), &env->fp_status)) {        =
 \
         cc |=3D CRF_LT;                                                 =
   \
-    } else if (!float64_le(xa.VsrD(0), xb.VsrD(0), &env->fp_status)) {  =
 \
+    } else if (!float64_le(xa->VsrD(0), xb->VsrD(0), &env->fp_status)) {=
 \
         cc |=3D CRF_GT;                                                 =
   \
     } else {                                                            =
 \
         cc |=3D CRF_EQ;                                                 =
   \
@@ -2575,23 +2559,22 @@ VSX_SCALAR_CMP(xscmpudp, 0)
 #define VSX_SCALAR_CMPQ(op, ordered)                                    =
\
 void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
\
 {                                                                       =
\
-    ppc_vsr_t xa, xb;                                                   =
\
+    ppc_vsr_t *xa =3D &env->vsr[rA(opcode) + 32];                       =
  \
+    ppc_vsr_t *xb =3D &env->vsr[rB(opcode) + 32];                       =
  \
     uint32_t cc =3D 0;                                                  =
  \
     bool vxsnan_flag =3D false, vxvc_flag =3D false;                    =
    \
                                                                         =
\
     helper_reset_fpstatus(env);                                         =
\
-    getVSR(rA(opcode) + 32, &xa, env);                                  =
\
-    getVSR(rB(opcode) + 32, &xb, env);                                  =
\
                                                                         =
\
-    if (float128_is_signaling_nan(xa.f128, &env->fp_status) ||          =
\
-        float128_is_signaling_nan(xb.f128, &env->fp_status)) {          =
\
+    if (float128_is_signaling_nan(xa->f128, &env->fp_status) ||         =
\
+        float128_is_signaling_nan(xb->f128, &env->fp_status)) {         =
\
         vxsnan_flag =3D true;                                           =
  \
         cc =3D CRF_SO;                                                  =
  \
         if (fpscr_ve =3D=3D 0 && ordered) {                             =
    \
             vxvc_flag =3D true;                                         =
  \
         }                                                               =
\
-    } else if (float128_is_quiet_nan(xa.f128, &env->fp_status) ||       =
\
-               float128_is_quiet_nan(xb.f128, &env->fp_status)) {       =
\
+    } else if (float128_is_quiet_nan(xa->f128, &env->fp_status) ||      =
\
+               float128_is_quiet_nan(xb->f128, &env->fp_status)) {      =
\
         cc =3D CRF_SO;                                                  =
  \
         if (ordered) {                                                  =
\
             vxvc_flag =3D true;                                         =
  \
@@ -2604,9 +2587,9 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)=
                     \
         float_invalid_op_vxvc(env, 0, GETPC());                         =
\
     }                                                                   =
\
                                                                         =
\
-    if (float128_lt(xa.f128, xb.f128, &env->fp_status)) {               =
\
+    if (float128_lt(xa->f128, xb->f128, &env->fp_status)) {             =
\
         cc |=3D CRF_LT;                                                 =
  \
-    } else if (!float128_le(xa.f128, xb.f128, &env->fp_status)) {       =
\
+    } else if (!float128_le(xa->f128, xb->f128, &env->fp_status)) {     =
\
         cc |=3D CRF_GT;                                                 =
  \
     } else {                                                            =
\
         cc |=3D CRF_EQ;                                                 =
  \
@@ -2633,22 +2616,21 @@ VSX_SCALAR_CMPQ(xscmpuqp, 0)
 #define VSX_MAX_MIN(name, op, nels, tp, fld)                            =
      \
 void helper_##name(CPUPPCState *env, uint32_t opcode)                   =
      \
 {                                                                       =
      \
-    ppc_vsr_t xt, xa, xb;                                               =
      \
+    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
        \
+    ppc_vsr_t *xa =3D &env->vsr[xA(opcode)];                            =
        \
+    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
        \
+    ppc_vsr_t t =3D *xt;                                                =
        \
     int i;                                                              =
      \
                                                                         =
      \
-    getVSR(xA(opcode), &xa, env);                                       =
      \
-    getVSR(xB(opcode), &xb, env);                                       =
      \
-    getVSR(xT(opcode), &xt, env);                                       =
      \
-                                                                        =
      \
     for (i =3D 0; i < nels; i++) {                                      =
        \
-        xt.fld =3D tp##_##op(xa.fld, xb.fld, &env->fp_status);          =
        \
-        if (unlikely(tp##_is_signaling_nan(xa.fld, &env->fp_status) ||  =
      \
-                     tp##_is_signaling_nan(xb.fld, &env->fp_status))) { =
      \
+        t.fld =3D tp##_##op(xa->fld, xb->fld, &env->fp_status);         =
        \
+        if (unlikely(tp##_is_signaling_nan(xa->fld, &env->fp_status) || =
      \
+                     tp##_is_signaling_nan(xb->fld, &env->fp_status))) {=
      \
             float_invalid_op_vxsnan(env, GETPC());                      =
      \
         }                                                               =
      \
     }                                                                   =
      \
                                                                         =
      \
-    putVSR(xT(opcode), &xt, env);                                       =
      \
+    *xt =3D t;                                                          =
        \
     do_float_check_status(env, GETPC());                                =
      \
 }
=20
@@ -2662,27 +2644,26 @@ VSX_MAX_MIN(xvminsp, minnum, 4, float32, VsrW(i))
 #define VSX_MAX_MINC(name, max)                                         =
      \
 void helper_##name(CPUPPCState *env, uint32_t opcode)                   =
      \
 {                                                                       =
      \
-    ppc_vsr_t xt, xa, xb;                                               =
      \
+    ppc_vsr_t *xt =3D &env->vsr[rD(opcode) + 32];                       =
        \
+    ppc_vsr_t *xa =3D &env->vsr[rA(opcode) + 32];                       =
        \
+    ppc_vsr_t *xb =3D &env->vsr[rB(opcode) + 32];                       =
        \
+    ppc_vsr_t t =3D *xt;                                                =
        \
     bool vxsnan_flag =3D false, vex_flag =3D false;                     =
          \
                                                                         =
      \
-    getVSR(rA(opcode) + 32, &xa, env);                                  =
      \
-    getVSR(rB(opcode) + 32, &xb, env);                                  =
      \
-    getVSR(rD(opcode) + 32, &xt, env);                                  =
      \
-                                                                        =
      \
-    if (unlikely(float64_is_any_nan(xa.VsrD(0)) ||                      =
      \
-                 float64_is_any_nan(xb.VsrD(0)))) {                     =
      \
-        if (float64_is_signaling_nan(xa.VsrD(0), &env->fp_status) ||    =
      \
-            float64_is_signaling_nan(xb.VsrD(0), &env->fp_status)) {    =
      \
+    if (unlikely(float64_is_any_nan(xa->VsrD(0)) ||                     =
      \
+                 float64_is_any_nan(xb->VsrD(0)))) {                    =
      \
+        if (float64_is_signaling_nan(xa->VsrD(0), &env->fp_status) ||   =
      \
+            float64_is_signaling_nan(xb->VsrD(0), &env->fp_status)) {   =
      \
             vxsnan_flag =3D true;                                       =
        \
         }                                                               =
      \
-        xt.VsrD(0) =3D xb.VsrD(0);                                      =
        \
+        t.VsrD(0) =3D xb->VsrD(0);                                      =
        \
     } else if ((max &&                                                  =
      \
-               !float64_lt(xa.VsrD(0), xb.VsrD(0), &env->fp_status)) || =
      \
+               !float64_lt(xa->VsrD(0), xb->VsrD(0), &env->fp_status)) |=
|     \
                (!max &&                                                 =
      \
-               float64_lt(xa.VsrD(0), xb.VsrD(0), &env->fp_status))) {  =
      \
-        xt.VsrD(0) =3D xa.VsrD(0);                                      =
        \
+               float64_lt(xa->VsrD(0), xb->VsrD(0), &env->fp_status))) {=
      \
+        t.VsrD(0) =3D xa->VsrD(0);                                      =
        \
     } else {                                                            =
      \
-        xt.VsrD(0) =3D xb.VsrD(0);                                      =
        \
+        t.VsrD(0) =3D xb->VsrD(0);                                      =
        \
     }                                                                   =
      \
                                                                         =
      \
     vex_flag =3D fpscr_ve & vxsnan_flag;                                =
        \
@@ -2690,7 +2671,7 @@ void helper_##name(CPUPPCState *env, uint32_t opcod=
e)                         \
         float_invalid_op_vxsnan(env, GETPC());                          =
      \
     }                                                                   =
      \
     if (!vex_flag) {                                                    =
      \
-        putVSR(rD(opcode) + 32, &xt, env);                              =
      \
+        *xt =3D t;                                                      =
        \
     }                                                                   =
      \
 }                                                                       =
      \
=20
@@ -2700,44 +2681,46 @@ VSX_MAX_MINC(xsmincdp, 0);
 #define VSX_MAX_MINJ(name, max)                                         =
      \
 void helper_##name(CPUPPCState *env, uint32_t opcode)                   =
      \
 {                                                                       =
      \
-    ppc_vsr_t xt, xa, xb;                                               =
      \
+    ppc_vsr_t *xt =3D &env->vsr[rD(opcode) + 32];                       =
        \
+    ppc_vsr_t *xa =3D &env->vsr[rA(opcode) + 32];                       =
        \
+    ppc_vsr_t *xb =3D &env->vsr[rB(opcode) + 32];                       =
        \
+    ppc_vsr_t t =3D *xt;                                                =
        \
     bool vxsnan_flag =3D false, vex_flag =3D false;                     =
          \
                                                                         =
      \
-    getVSR(rA(opcode) + 32, &xa, env);                                  =
      \
-    getVSR(rB(opcode) + 32, &xb, env);                                  =
      \
-    getVSR(rD(opcode) + 32, &xt, env);                                  =
      \
-                                                                        =
      \
-    if (unlikely(float64_is_any_nan(xa.VsrD(0)))) {                     =
      \
-        if (float64_is_signaling_nan(xa.VsrD(0), &env->fp_status)) {    =
      \
+    if (unlikely(float64_is_any_nan(xa->VsrD(0)))) {                    =
      \
+        if (float64_is_signaling_nan(xa->VsrD(0), &env->fp_status)) {   =
      \
             vxsnan_flag =3D true;                                       =
        \
         }                                                               =
      \
-        xt.VsrD(0) =3D xa.VsrD(0);                                      =
        \
-    } else if (unlikely(float64_is_any_nan(xb.VsrD(0)))) {              =
      \
-        if (float64_is_signaling_nan(xb.VsrD(0), &env->fp_status)) {    =
      \
+        t.VsrD(0) =3D xa->VsrD(0);                                      =
        \
+    } else if (unlikely(float64_is_any_nan(xb->VsrD(0)))) {             =
      \
+        if (float64_is_signaling_nan(xb->VsrD(0), &env->fp_status)) {   =
      \
             vxsnan_flag =3D true;                                       =
        \
         }                                                               =
      \
-        xt.VsrD(0) =3D xb.VsrD(0);                                      =
        \
-    } else if (float64_is_zero(xa.VsrD(0)) && float64_is_zero(xb.VsrD(0)=
)) {  \
+        t.VsrD(0) =3D xb->VsrD(0);                                      =
        \
+    } else if (float64_is_zero(xa->VsrD(0)) &&                          =
      \
+               float64_is_zero(xb->VsrD(0))) {                          =
      \
         if (max) {                                                      =
      \
-            if (!float64_is_neg(xa.VsrD(0)) || !float64_is_neg(xb.VsrD(0=
))) { \
-                xt.VsrD(0) =3D 0ULL;                                    =
        \
+            if (!float64_is_neg(xa->VsrD(0)) ||                         =
      \
+                !float64_is_neg(xb->VsrD(0))) {                         =
      \
+                t.VsrD(0) =3D 0ULL;                                     =
        \
             } else {                                                    =
      \
-                xt.VsrD(0) =3D 0x8000000000000000ULL;                   =
        \
+                t.VsrD(0) =3D 0x8000000000000000ULL;                    =
        \
             }                                                           =
      \
         } else {                                                        =
      \
-            if (float64_is_neg(xa.VsrD(0)) || float64_is_neg(xb.VsrD(0))=
) {   \
-                xt.VsrD(0) =3D 0x8000000000000000ULL;                   =
        \
+            if (float64_is_neg(xa->VsrD(0)) ||                          =
      \
+                float64_is_neg(xb->VsrD(0))) {                          =
      \
+                t.VsrD(0) =3D 0x8000000000000000ULL;                    =
        \
             } else {                                                    =
      \
-                xt.VsrD(0) =3D 0ULL;                                    =
        \
+                t.VsrD(0) =3D 0ULL;                                     =
        \
             }                                                           =
      \
         }                                                               =
      \
     } else if ((max &&                                                  =
      \
-               !float64_lt(xa.VsrD(0), xb.VsrD(0), &env->fp_status)) || =
      \
+               !float64_lt(xa->VsrD(0), xb->VsrD(0), &env->fp_status)) |=
|     \
                (!max &&                                                 =
      \
-               float64_lt(xa.VsrD(0), xb.VsrD(0), &env->fp_status))) {  =
      \
-        xt.VsrD(0) =3D xa.VsrD(0);                                      =
        \
+               float64_lt(xa->VsrD(0), xb->VsrD(0), &env->fp_status))) {=
      \
+        t.VsrD(0) =3D xa->VsrD(0);                                      =
        \
     } else {                                                            =
      \
-        xt.VsrD(0) =3D xb.VsrD(0);                                      =
        \
+        t.VsrD(0) =3D xb->VsrD(0);                                      =
        \
     }                                                                   =
      \
                                                                         =
      \
     vex_flag =3D fpscr_ve & vxsnan_flag;                                =
        \
@@ -2745,7 +2728,7 @@ void helper_##name(CPUPPCState *env, uint32_t opcod=
e)                         \
         float_invalid_op_vxsnan(env, GETPC());                          =
      \
     }                                                                   =
      \
     if (!vex_flag) {                                                    =
      \
-        putVSR(rD(opcode) + 32, &xt, env);                              =
      \
+        *xt =3D t;                                                      =
        \
     }                                                                   =
      \
 }                                                                       =
      \
=20
@@ -2765,39 +2748,38 @@ VSX_MAX_MINJ(xsminjdp, 0);
 #define VSX_CMP(op, nels, tp, fld, cmp, svxvc, exp)                     =
  \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
  \
 {                                                                       =
  \
-    ppc_vsr_t xt, xa, xb;                                               =
  \
+    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
    \
+    ppc_vsr_t *xa =3D &env->vsr[xA(opcode)];                            =
    \
+    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
    \
+    ppc_vsr_t t =3D *xt;                                                =
    \
     int i;                                                              =
  \
     int all_true =3D 1;                                                 =
    \
     int all_false =3D 1;                                                =
    \
                                                                         =
  \
-    getVSR(xA(opcode), &xa, env);                                       =
  \
-    getVSR(xB(opcode), &xb, env);                                       =
  \
-    getVSR(xT(opcode), &xt, env);                                       =
  \
-                                                                        =
  \
     for (i =3D 0; i < nels; i++) {                                      =
    \
-        if (unlikely(tp##_is_any_nan(xa.fld) ||                         =
  \
-                     tp##_is_any_nan(xb.fld))) {                        =
  \
-            if (tp##_is_signaling_nan(xa.fld, &env->fp_status) ||       =
  \
-                tp##_is_signaling_nan(xb.fld, &env->fp_status)) {       =
  \
+        if (unlikely(tp##_is_any_nan(xa->fld) ||                        =
  \
+                     tp##_is_any_nan(xb->fld))) {                       =
  \
+            if (tp##_is_signaling_nan(xa->fld, &env->fp_status) ||      =
  \
+                tp##_is_signaling_nan(xb->fld, &env->fp_status)) {      =
  \
                 float_invalid_op_vxsnan(env, GETPC());                  =
  \
             }                                                           =
  \
             if (svxvc) {                                                =
  \
                 float_invalid_op_vxvc(env, 0, GETPC());                 =
  \
             }                                                           =
  \
-            xt.fld =3D 0;                                               =
    \
+            t.fld =3D 0;                                                =
    \
             all_true =3D 0;                                             =
    \
         } else {                                                        =
  \
-            if (tp##_##cmp(xb.fld, xa.fld, &env->fp_status) =3D=3D exp) =
{     \
-                xt.fld =3D -1;                                          =
    \
+            if (tp##_##cmp(xb->fld, xa->fld, &env->fp_status) =3D=3D exp=
) {   \
+                t.fld =3D -1;                                           =
    \
                 all_false =3D 0;                                        =
    \
             } else {                                                    =
  \
-                xt.fld =3D 0;                                           =
    \
+                t.fld =3D 0;                                            =
    \
                 all_true =3D 0;                                         =
    \
             }                                                           =
  \
         }                                                               =
  \
     }                                                                   =
  \
                                                                         =
  \
-    putVSR(xT(opcode), &xt, env);                                       =
  \
+    *xt =3D t;                                                          =
    \
     if ((opcode >> (31 - 21)) & 1) {                                    =
  \
         env->crf[6] =3D (all_true ? 0x8 : 0) | (all_false ? 0x2 : 0);   =
    \
     }                                                                   =
  \
@@ -2826,25 +2808,24 @@ VSX_CMP(xvcmpnesp, 4, float32, VsrW(i), eq, 0, 0)
 #define VSX_CVT_FP_TO_FP(op, nels, stp, ttp, sfld, tfld, sfprf)    \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                \
 {                                                                  \
-    ppc_vsr_t xt, xb;                                              \
+    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                         \
+    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                         \
+    ppc_vsr_t t =3D *xt;                                             \
     int i;                                                         \
                                                                    \
-    getVSR(xB(opcode), &xb, env);                                  \
-    getVSR(xT(opcode), &xt, env);                                  \
-                                                                   \
     for (i =3D 0; i < nels; i++) {                                   \
-        xt.tfld =3D stp##_to_##ttp(xb.sfld, &env->fp_status);        \
-        if (unlikely(stp##_is_signaling_nan(xb.sfld,               \
+        t.tfld =3D stp##_to_##ttp(xb->sfld, &env->fp_status);        \
+        if (unlikely(stp##_is_signaling_nan(xb->sfld,              \
                                             &env->fp_status))) {   \
             float_invalid_op_vxsnan(env, GETPC());                 \
-            xt.tfld =3D ttp##_snan_to_qnan(xt.tfld);                 \
+            t.tfld =3D ttp##_snan_to_qnan(t.tfld);                   \
         }                                                          \
         if (sfprf) {                                               \
-            helper_compute_fprf_##ttp(env, xt.tfld);               \
+            helper_compute_fprf_##ttp(env, t.tfld);                \
         }                                                          \
     }                                                              \
                                                                    \
-    putVSR(xT(opcode), &xt, env);                                  \
+    *xt =3D t;                                                       \
     do_float_check_status(env, GETPC());                           \
 }
=20
@@ -2866,25 +2847,24 @@ VSX_CVT_FP_TO_FP(xvcvspdp, 2, float32, float64, V=
srW(2 * i), VsrD(i), 0)
 #define VSX_CVT_FP_TO_FP_VECTOR(op, nels, stp, ttp, sfld, tfld, sfprf)  =
  \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
  \
 {                                                                       =
\
-    ppc_vsr_t xt, xb;                                                   =
\
+    ppc_vsr_t *xt =3D &env->vsr[rD(opcode) + 32];                       =
  \
+    ppc_vsr_t *xb =3D &env->vsr[rB(opcode) + 32];                       =
  \
+    ppc_vsr_t t =3D *xt;                                                =
  \
     int i;                                                              =
\
                                                                         =
\
-    getVSR(rB(opcode) + 32, &xb, env);                                  =
\
-    getVSR(rD(opcode) + 32, &xt, env);                                  =
\
-                                                                        =
\
     for (i =3D 0; i < nels; i++) {                                      =
  \
-        xt.tfld =3D stp##_to_##ttp(xb.sfld, &env->fp_status);           =
  \
-        if (unlikely(stp##_is_signaling_nan(xb.sfld,                    =
\
+        t.tfld =3D stp##_to_##ttp(xb->sfld, &env->fp_status);           =
  \
+        if (unlikely(stp##_is_signaling_nan(xb->sfld,                   =
\
                                             &env->fp_status))) {        =
\
             float_invalid_op_vxsnan(env, GETPC());                      =
\
-            xt.tfld =3D ttp##_snan_to_qnan(xt.tfld);                    =
  \
+            t.tfld =3D ttp##_snan_to_qnan(t.tfld);                      =
  \
         }                                                               =
\
         if (sfprf) {                                                    =
\
-            helper_compute_fprf_##ttp(env, xt.tfld);                    =
\
+            helper_compute_fprf_##ttp(env, t.tfld);                     =
\
         }                                                               =
\
     }                                                                   =
\
                                                                         =
\
-    putVSR(rD(opcode) + 32, &xt, env);                                  =
\
+    *xt =3D t;                                                          =
  \
     do_float_check_status(env, GETPC());                                =
\
 }
=20
@@ -2904,25 +2884,24 @@ VSX_CVT_FP_TO_FP_VECTOR(xscvdpqp, 1, float64, flo=
at128, VsrD(0), f128, 1)
 #define VSX_CVT_FP_TO_FP_HP(op, nels, stp, ttp, sfld, tfld, sfprf) \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                \
 {                                                                  \
-    ppc_vsr_t xt, xb;                                              \
+    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                         \
+    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                         \
+    ppc_vsr_t t =3D { };                                             \
     int i;                                                         \
                                                                    \
-    getVSR(xB(opcode), &xb, env);                                  \
-    memset(&xt, 0, sizeof(xt));                                    \
-                                                                   \
     for (i =3D 0; i < nels; i++) {                                   \
-        xt.tfld =3D stp##_to_##ttp(xb.sfld, 1, &env->fp_status);     \
-        if (unlikely(stp##_is_signaling_nan(xb.sfld,               \
+        t.tfld =3D stp##_to_##ttp(xb->sfld, 1, &env->fp_status);     \
+        if (unlikely(stp##_is_signaling_nan(xb->sfld,              \
                                             &env->fp_status))) {   \
             float_invalid_op_vxsnan(env, GETPC());                 \
-            xt.tfld =3D ttp##_snan_to_qnan(xt.tfld);                 \
+            t.tfld =3D ttp##_snan_to_qnan(t.tfld);                   \
         }                                                          \
         if (sfprf) {                                               \
-            helper_compute_fprf_##ttp(env, xt.tfld);               \
+            helper_compute_fprf_##ttp(env, t.tfld);                \
         }                                                          \
     }                                                              \
                                                                    \
-    putVSR(xT(opcode), &xt, env);                                  \
+    *xt =3D t;                                                       \
     do_float_check_status(env, GETPC());                           \
 }
=20
@@ -2937,26 +2916,25 @@ VSX_CVT_FP_TO_FP_HP(xvcvhpsp, 4, float16, float32=
, VsrH(2 * i + 1), VsrW(i), 0)
  */
 void helper_xscvqpdp(CPUPPCState *env, uint32_t opcode)
 {
-    ppc_vsr_t xt, xb;
+    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];
+    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];
+    ppc_vsr_t t =3D { };
     float_status tstat;
=20
-    getVSR(rB(opcode) + 32, &xb, env);
-    memset(&xt, 0, sizeof(xt));
-
     tstat =3D env->fp_status;
     if (unlikely(Rc(opcode) !=3D 0)) {
         tstat.float_rounding_mode =3D float_round_to_odd;
     }
=20
-    xt.VsrD(0) =3D float128_to_float64(xb.f128, &tstat);
+    t.VsrD(0) =3D float128_to_float64(xb->f128, &tstat);
     env->fp_status.float_exception_flags |=3D tstat.float_exception_flag=
s;
-    if (unlikely(float128_is_signaling_nan(xb.f128, &tstat))) {
+    if (unlikely(float128_is_signaling_nan(xb->f128, &tstat))) {
         float_invalid_op_vxsnan(env, GETPC());
-        xt.VsrD(0) =3D float64_snan_to_qnan(xt.VsrD(0));
+        t.VsrD(0) =3D float64_snan_to_qnan(t.VsrD(0));
     }
-    helper_compute_fprf_float64(env, xt.VsrD(0));
+    helper_compute_fprf_float64(env, t.VsrD(0));
=20
-    putVSR(rD(opcode) + 32, &xt, env);
+    *xt =3D t;
     do_float_check_status(env, GETPC());
 }
=20
@@ -2990,24 +2968,23 @@ uint64_t helper_xscvspdpn(CPUPPCState *env, uint6=
4_t xb)
 void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
     \
 {                                                                       =
     \
     int all_flags =3D env->fp_status.float_exception_flags, flags;      =
       \
-    ppc_vsr_t xt, xb;                                                   =
     \
+    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
       \
+    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
       \
+    ppc_vsr_t t =3D *xt;                                                =
       \
     int i;                                                              =
     \
                                                                         =
     \
-    getVSR(xB(opcode), &xb, env);                                       =
     \
-    getVSR(xT(opcode), &xt, env);                                       =
     \
-                                                                        =
     \
     for (i =3D 0; i < nels; i++) {                                      =
       \
         env->fp_status.float_exception_flags =3D 0;                     =
       \
-        xt.tfld =3D stp##_to_##ttp##_round_to_zero(xb.sfld, &env->fp_sta=
tus);  \
+        t.tfld =3D stp##_to_##ttp##_round_to_zero(xb->sfld, &env->fp_sta=
tus);  \
         flags =3D env->fp_status.float_exception_flags;                 =
       \
         if (unlikely(flags & float_flag_invalid)) {                     =
     \
-            float_invalid_cvt(env, 0, GETPC(), stp##_classify(xb.sfld));=
     \
-            xt.tfld =3D rnan;                                           =
       \
+            float_invalid_cvt(env, 0, GETPC(), stp##_classify(xb->sfld))=
;    \
+            t.tfld =3D rnan;                                            =
       \
         }                                                               =
     \
         all_flags |=3D flags;                                           =
       \
     }                                                                   =
     \
                                                                         =
     \
-    putVSR(xT(opcode), &xt, env);                                       =
     \
+    *xt =3D t;                                                          =
       \
     env->fp_status.float_exception_flags =3D all_flags;                 =
       \
     do_float_check_status(env, GETPC());                                =
     \
 }
@@ -3042,18 +3019,17 @@ VSX_CVT_FP_TO_INT(xvcvspuxws, 4, float32, uint32,=
 VsrW(i), VsrW(i), 0U)
 #define VSX_CVT_FP_TO_INT_VECTOR(op, stp, ttp, sfld, tfld, rnan)        =
     \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
     \
 {                                                                       =
     \
-    ppc_vsr_t xt, xb;                                                   =
     \
+    ppc_vsr_t *xt =3D &env->vsr[rD(opcode) + 32];                       =
       \
+    ppc_vsr_t *xb =3D &env->vsr[rB(opcode) + 32];                       =
       \
+    ppc_vsr_t t =3D { };                                                =
       \
                                                                         =
     \
-    getVSR(rB(opcode) + 32, &xb, env);                                  =
     \
-    memset(&xt, 0, sizeof(xt));                                         =
     \
-                                                                        =
     \
-    xt.tfld =3D stp##_to_##ttp##_round_to_zero(xb.sfld, &env->fp_status)=
;      \
+    t.tfld =3D stp##_to_##ttp##_round_to_zero(xb->sfld, &env->fp_status)=
;      \
     if (env->fp_status.float_exception_flags & float_flag_invalid) {    =
     \
-        float_invalid_cvt(env, 0, GETPC(), stp##_classify(xb.sfld));    =
     \
-        xt.tfld =3D rnan;                                               =
       \
+        float_invalid_cvt(env, 0, GETPC(), stp##_classify(xb->sfld));   =
     \
+        t.tfld =3D rnan;                                                =
       \
     }                                                                   =
     \
                                                                         =
     \
-    putVSR(rD(opcode) + 32, &xt, env);                                  =
     \
+    *xt =3D t;                                                          =
       \
     do_float_check_status(env, GETPC());                                =
     \
 }
=20
@@ -3079,23 +3055,22 @@ VSX_CVT_FP_TO_INT_VECTOR(xscvqpuwz, float128, uin=
t32, f128, VsrD(0), 0x0ULL)
 #define VSX_CVT_INT_TO_FP(op, nels, stp, ttp, sfld, tfld, sfprf, r2sp)  =
\
 void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
\
 {                                                                       =
\
-    ppc_vsr_t xt, xb;                                                   =
\
+    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
  \
+    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
  \
+    ppc_vsr_t t =3D *xt;                                                =
  \
     int i;                                                              =
\
                                                                         =
\
-    getVSR(xB(opcode), &xb, env);                                       =
\
-    getVSR(xT(opcode), &xt, env);                                       =
\
-                                                                        =
\
     for (i =3D 0; i < nels; i++) {                                      =
  \
-        xt.tfld =3D stp##_to_##ttp(xb.sfld, &env->fp_status);           =
  \
+        t.tfld =3D stp##_to_##ttp(xb->sfld, &env->fp_status);           =
  \
         if (r2sp) {                                                     =
\
-            xt.tfld =3D helper_frsp(env, xt.tfld);                      =
  \
+            t.tfld =3D helper_frsp(env, t.tfld);                        =
  \
         }                                                               =
\
         if (sfprf) {                                                    =
\
-            helper_compute_fprf_float64(env, xt.tfld);                  =
\
+            helper_compute_fprf_float64(env, t.tfld);                   =
\
         }                                                               =
\
     }                                                                   =
\
                                                                         =
\
-    putVSR(xT(opcode), &xt, env);                                       =
\
+    *xt =3D t;                                                          =
  \
     do_float_check_status(env, GETPC());                                =
\
 }
=20
@@ -3123,15 +3098,14 @@ VSX_CVT_INT_TO_FP(xvcvuxwsp, 4, uint32, float32, =
VsrW(i), VsrW(i), 0, 0)
 #define VSX_CVT_INT_TO_FP_VECTOR(op, stp, ttp, sfld, tfld)              =
\
 void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
\
 {                                                                       =
\
-    ppc_vsr_t xt, xb;                                                   =
\
-                                                                        =
\
-    getVSR(rB(opcode) + 32, &xb, env);                                  =
\
-    getVSR(rD(opcode) + 32, &xt, env);                                  =
\
+    ppc_vsr_t *xt =3D &env->vsr[rD(opcode) + 32];                       =
  \
+    ppc_vsr_t *xb =3D &env->vsr[rB(opcode) + 32];                       =
  \
+    ppc_vsr_t t =3D *xt;                                                =
  \
                                                                         =
\
-    xt.tfld =3D stp##_to_##ttp(xb.sfld, &env->fp_status);               =
  \
-    helper_compute_fprf_##ttp(env, xt.tfld);                            =
\
+    t.tfld =3D stp##_to_##ttp(xb->sfld, &env->fp_status);               =
  \
+    helper_compute_fprf_##ttp(env, t.tfld);                             =
\
                                                                         =
\
-    putVSR(xT(opcode) + 32, &xt, env);                                  =
\
+    *xt =3D t;                                                          =
  \
     do_float_check_status(env, GETPC());                                =
\
 }
=20
@@ -3157,25 +3131,25 @@ VSX_CVT_INT_TO_FP_VECTOR(xscvudqp, uint64, float1=
28, VsrD(0), f128)
 #define VSX_ROUND(op, nels, tp, fld, rmode, sfprf)                     \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                    \
 {                                                                      \
-    ppc_vsr_t xt, xb;                                                  \
+    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
 \
+    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
 \
+    ppc_vsr_t t =3D *xt;                                                =
 \
     int i;                                                             \
-    getVSR(xB(opcode), &xb, env);                                      \
-    getVSR(xT(opcode), &xt, env);                                      \
                                                                        \
     if (rmode !=3D FLOAT_ROUND_CURRENT) {                               =
 \
         set_float_rounding_mode(rmode, &env->fp_status);               \
     }                                                                  \
                                                                        \
     for (i =3D 0; i < nels; i++) {                                      =
 \
-        if (unlikely(tp##_is_signaling_nan(xb.fld,                     \
+        if (unlikely(tp##_is_signaling_nan(xb->fld,                    \
                                            &env->fp_status))) {        \
             float_invalid_op_vxsnan(env, GETPC());                     \
-            xt.fld =3D tp##_snan_to_qnan(xb.fld);                       =
 \
+            t.fld =3D tp##_snan_to_qnan(xb->fld);                       =
 \
         } else {                                                       \
-            xt.fld =3D tp##_round_to_int(xb.fld, &env->fp_status);      =
 \
+            t.fld =3D tp##_round_to_int(xb->fld, &env->fp_status);      =
 \
         }                                                              \
         if (sfprf) {                                                   \
-            helper_compute_fprf_float64(env, xt.fld);                  \
+            helper_compute_fprf_float64(env, t.fld);                   \
         }                                                              \
     }                                                                  \
                                                                        \
@@ -3189,7 +3163,7 @@ void helper_##op(CPUPPCState *env, uint32_t opcode)=
                    \
         env->fp_status.float_exception_flags &=3D ~float_flag_inexact;  =
 \
     }                                                                  \
                                                                        \
-    putVSR(xT(opcode), &xt, env);                                      \
+    *xt =3D t;                                                          =
 \
     do_float_check_status(env, GETPC());                               \
 }
=20
@@ -3225,21 +3199,21 @@ uint64_t helper_xsrsp(CPUPPCState *env, uint64_t =
xb)
 #define VSX_XXPERM(op, indexed)                                       \
 void helper_##op(CPUPPCState *env, uint32_t opcode)                   \
 {                                                                     \
-    ppc_vsr_t xt, xa, pcv, xto;                                       \
+    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
\
+    ppc_vsr_t *xa =3D &env->vsr[xA(opcode)];                            =
\
+    ppc_vsr_t *pcv =3D &env->vsr[xB(opcode)];                           =
\
+    ppc_vsr_t t =3D *xt;                                                =
\
     int i, idx;                                                       \
                                                                       \
-    getVSR(xA(opcode), &xa, env);                                     \
-    getVSR(xT(opcode), &xt, env);                                     \
-    getVSR(xB(opcode), &pcv, env);                                    \
-                                                                      \
     for (i =3D 0; i < 16; i++) {                                        =
\
-        idx =3D pcv.VsrB(i) & 0x1F;                                     =
\
+        idx =3D pcv->VsrB(i) & 0x1F;                                    =
\
         if (indexed) {                                                \
             idx =3D 31 - idx;                                           =
\
         }                                                             \
-        xto.VsrB(i) =3D (idx <=3D 15) ? xa.VsrB(idx) : xt.VsrB(idx - 16)=
; \
+        t.VsrB(i) =3D (idx <=3D 15) ? xa->VsrB(idx)                     =
  \
+                                : xt->VsrB(idx - 16);                 \
     }                                                                 \
-    putVSR(xT(opcode), &xto, env);                                    \
+    *xt =3D t;                                                          =
\
 }
=20
 VSX_XXPERM(xxperm, 0)
@@ -3247,22 +3221,21 @@ VSX_XXPERM(xxpermr, 1)
=20
 void helper_xvxsigsp(CPUPPCState *env, uint32_t opcode)
 {
-    ppc_vsr_t xt, xb;
+    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];
+    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];
+    ppc_vsr_t t =3D { };
     uint32_t exp, i, fraction;
=20
-    getVSR(xB(opcode), &xb, env);
-    memset(&xt, 0, sizeof(xt));
-
     for (i =3D 0; i < 4; i++) {
-        exp =3D (xb.VsrW(i) >> 23) & 0xFF;
-        fraction =3D xb.VsrW(i) & 0x7FFFFF;
+        exp =3D (xb->VsrW(i) >> 23) & 0xFF;
+        fraction =3D xb->VsrW(i) & 0x7FFFFF;
         if (exp !=3D 0 && exp !=3D 255) {
-            xt.VsrW(i) =3D fraction | 0x00800000;
+            t.VsrW(i) =3D fraction | 0x00800000;
         } else {
-            xt.VsrW(i) =3D fraction;
+            t.VsrW(i) =3D fraction;
         }
     }
-    putVSR(xT(opcode), &xt, env);
+    *xt =3D t;
 }
=20
 /*
@@ -3279,27 +3252,28 @@ void helper_xvxsigsp(CPUPPCState *env, uint32_t o=
pcode)
 #define VSX_TEST_DC(op, nels, xbn, tp, fld, tfld, fld_max, scrf)  \
 void helper_##op(CPUPPCState *env, uint32_t opcode)         \
 {                                                           \
-    ppc_vsr_t xt, xb;                                       \
+    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                  \
+    ppc_vsr_t *xb =3D &env->vsr[xbn];                         \
+    ppc_vsr_t t =3D { };                                      \
     uint32_t i, sign, dcmx;                                 \
     uint32_t cc, match =3D 0;                                 \
                                                             \
-    getVSR(xbn, &xb, env);                                  \
     if (!scrf) {                                            \
-        memset(&xt, 0, sizeof(xt));                         \
         dcmx =3D DCMX_XV(opcode);                             \
     } else {                                                \
+        t =3D *xt;                                            \
         dcmx =3D DCMX(opcode);                                \
     }                                                       \
                                                             \
     for (i =3D 0; i < nels; i++) {                            \
-        sign =3D tp##_is_neg(xb.fld);                         \
-        if (tp##_is_any_nan(xb.fld)) {                      \
+        sign =3D tp##_is_neg(xb->fld);                        \
+        if (tp##_is_any_nan(xb->fld)) {                     \
             match =3D extract32(dcmx, 6, 1);                  \
-        } else if (tp##_is_infinity(xb.fld)) {              \
+        } else if (tp##_is_infinity(xb->fld)) {             \
             match =3D extract32(dcmx, 4 + !sign, 1);          \
-        } else if (tp##_is_zero(xb.fld)) {                  \
+        } else if (tp##_is_zero(xb->fld)) {                 \
             match =3D extract32(dcmx, 2 + !sign, 1);          \
-        } else if (tp##_is_zero_or_denormal(xb.fld)) {      \
+        } else if (tp##_is_zero_or_denormal(xb->fld)) {     \
             match =3D extract32(dcmx, 0 + !sign, 1);          \
         }                                                   \
                                                             \
@@ -3309,12 +3283,12 @@ void helper_##op(CPUPPCState *env, uint32_t opcod=
e)         \
             env->fpscr |=3D cc << FPSCR_FPRF;                 \
             env->crf[BF(opcode)] =3D cc;                      \
         } else {                                            \
-            xt.tfld =3D match ? fld_max : 0;                  \
+            t.tfld =3D match ? fld_max : 0;                   \
         }                                                   \
         match =3D 0;                                          \
     }                                                       \
     if (!scrf) {                                            \
-        putVSR(xT(opcode), &xt, env);                       \
+        *xt =3D t;                                            \
     }                                                       \
 }
=20
@@ -3325,29 +3299,28 @@ VSX_TEST_DC(xststdcqp, 1, (rB(opcode) + 32), floa=
t128, f128, VsrD(0), 0, 1)
=20
 void helper_xststdcsp(CPUPPCState *env, uint32_t opcode)
 {
-    ppc_vsr_t xb;
+    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];
     uint32_t dcmx, sign, exp;
     uint32_t cc, match =3D 0, not_sp =3D 0;
=20
-    getVSR(xB(opcode), &xb, env);
     dcmx =3D DCMX(opcode);
-    exp =3D (xb.VsrD(0) >> 52) & 0x7FF;
+    exp =3D (xb->VsrD(0) >> 52) & 0x7FF;
=20
-    sign =3D float64_is_neg(xb.VsrD(0));
-    if (float64_is_any_nan(xb.VsrD(0))) {
+    sign =3D float64_is_neg(xb->VsrD(0));
+    if (float64_is_any_nan(xb->VsrD(0))) {
         match =3D extract32(dcmx, 6, 1);
-    } else if (float64_is_infinity(xb.VsrD(0))) {
+    } else if (float64_is_infinity(xb->VsrD(0))) {
         match =3D extract32(dcmx, 4 + !sign, 1);
-    } else if (float64_is_zero(xb.VsrD(0))) {
+    } else if (float64_is_zero(xb->VsrD(0))) {
         match =3D extract32(dcmx, 2 + !sign, 1);
-    } else if (float64_is_zero_or_denormal(xb.VsrD(0)) ||
+    } else if (float64_is_zero_or_denormal(xb->VsrD(0)) ||
                (exp > 0 && exp < 0x381)) {
         match =3D extract32(dcmx, 0 + !sign, 1);
     }
=20
-    not_sp =3D !float64_eq(xb.VsrD(0),
+    not_sp =3D !float64_eq(xb->VsrD(0),
                          float32_to_float64(
-                             float64_to_float32(xb.VsrD(0), &env->fp_sta=
tus),
+                             float64_to_float32(xb->VsrD(0), &env->fp_st=
atus),
                              &env->fp_status), &env->fp_status);
=20
     cc =3D sign << CRF_LT_BIT | match << CRF_EQ_BIT | not_sp << CRF_SO_B=
IT;
@@ -3358,16 +3331,15 @@ void helper_xststdcsp(CPUPPCState *env, uint32_t =
opcode)
=20
 void helper_xsrqpi(CPUPPCState *env, uint32_t opcode)
 {
-    ppc_vsr_t xb;
-    ppc_vsr_t xt;
+    ppc_vsr_t *xt =3D &env->vsr[rD(opcode) + 32];
+    ppc_vsr_t *xb =3D &env->vsr[rB(opcode) + 32];
+    ppc_vsr_t t =3D { };
     uint8_t r =3D Rrm(opcode);
     uint8_t ex =3D Rc(opcode);
     uint8_t rmc =3D RMC(opcode);
     uint8_t rmode =3D 0;
     float_status tstat;
=20
-    getVSR(rB(opcode) + 32, &xb, env);
-    memset(&xt, 0, sizeof(xt));
     helper_reset_fpstatus(env);
=20
     if (r =3D=3D 0 && rmc =3D=3D 0) {
@@ -3396,13 +3368,13 @@ void helper_xsrqpi(CPUPPCState *env, uint32_t opc=
ode)
     tstat =3D env->fp_status;
     set_float_exception_flags(0, &tstat);
     set_float_rounding_mode(rmode, &tstat);
-    xt.f128 =3D float128_round_to_int(xb.f128, &tstat);
+    t.f128 =3D float128_round_to_int(xb->f128, &tstat);
     env->fp_status.float_exception_flags |=3D tstat.float_exception_flag=
s;
=20
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
-        if (float128_is_signaling_nan(xb.f128, &tstat)) {
+        if (float128_is_signaling_nan(xb->f128, &tstat)) {
             float_invalid_op_vxsnan(env, GETPC());
-            xt.f128 =3D float128_snan_to_qnan(xt.f128);
+            t.f128 =3D float128_snan_to_qnan(t.f128);
         }
     }
=20
@@ -3410,23 +3382,22 @@ void helper_xsrqpi(CPUPPCState *env, uint32_t opc=
ode)
         env->fp_status.float_exception_flags &=3D ~float_flag_inexact;
     }
=20
-    helper_compute_fprf_float128(env, xt.f128);
+    helper_compute_fprf_float128(env, t.f128);
     do_float_check_status(env, GETPC());
-    putVSR(rD(opcode) + 32, &xt, env);
+    *xt =3D t;
 }
=20
 void helper_xsrqpxp(CPUPPCState *env, uint32_t opcode)
 {
-    ppc_vsr_t xb;
-    ppc_vsr_t xt;
+    ppc_vsr_t *xt =3D &env->vsr[rD(opcode) + 32];
+    ppc_vsr_t *xb =3D &env->vsr[rB(opcode) + 32];
+    ppc_vsr_t t =3D { };
     uint8_t r =3D Rrm(opcode);
     uint8_t rmc =3D RMC(opcode);
     uint8_t rmode =3D 0;
     floatx80 round_res;
     float_status tstat;
=20
-    getVSR(rB(opcode) + 32, &xb, env);
-    memset(&xt, 0, sizeof(xt));
     helper_reset_fpstatus(env);
=20
     if (r =3D=3D 0 && rmc =3D=3D 0) {
@@ -3455,30 +3426,29 @@ void helper_xsrqpxp(CPUPPCState *env, uint32_t op=
code)
     tstat =3D env->fp_status;
     set_float_exception_flags(0, &tstat);
     set_float_rounding_mode(rmode, &tstat);
-    round_res =3D float128_to_floatx80(xb.f128, &tstat);
-    xt.f128 =3D floatx80_to_float128(round_res, &tstat);
+    round_res =3D float128_to_floatx80(xb->f128, &tstat);
+    t.f128 =3D floatx80_to_float128(round_res, &tstat);
     env->fp_status.float_exception_flags |=3D tstat.float_exception_flag=
s;
=20
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
-        if (float128_is_signaling_nan(xb.f128, &tstat)) {
+        if (float128_is_signaling_nan(xb->f128, &tstat)) {
             float_invalid_op_vxsnan(env, GETPC());
-            xt.f128 =3D float128_snan_to_qnan(xt.f128);
+            t.f128 =3D float128_snan_to_qnan(t.f128);
         }
     }
=20
-    helper_compute_fprf_float128(env, xt.f128);
-    putVSR(rD(opcode) + 32, &xt, env);
+    helper_compute_fprf_float128(env, t.f128);
+    *xt =3D t;
     do_float_check_status(env, GETPC());
 }
=20
 void helper_xssqrtqp(CPUPPCState *env, uint32_t opcode)
 {
-    ppc_vsr_t xb;
-    ppc_vsr_t xt;
+    ppc_vsr_t *xt =3D &env->vsr[rD(opcode) + 32];
+    ppc_vsr_t *xb =3D &env->vsr[rB(opcode) + 32];
+    ppc_vsr_t t =3D { };
     float_status tstat;
=20
-    getVSR(rB(opcode) + 32, &xb, env);
-    memset(&xt, 0, sizeof(xt));
     helper_reset_fpstatus(env);
=20
     tstat =3D env->fp_status;
@@ -3487,34 +3457,34 @@ void helper_xssqrtqp(CPUPPCState *env, uint32_t o=
pcode)
     }
=20
     set_float_exception_flags(0, &tstat);
-    xt.f128 =3D float128_sqrt(xb.f128, &tstat);
+    t.f128 =3D float128_sqrt(xb->f128, &tstat);
     env->fp_status.float_exception_flags |=3D tstat.float_exception_flag=
s;
=20
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
-        if (float128_is_signaling_nan(xb.f128, &tstat)) {
+        if (float128_is_signaling_nan(xb->f128, &tstat)) {
             float_invalid_op_vxsnan(env, GETPC());
-            xt.f128 =3D float128_snan_to_qnan(xb.f128);
-        } else if  (float128_is_quiet_nan(xb.f128, &tstat)) {
-            xt.f128 =3D xb.f128;
-        } else if (float128_is_neg(xb.f128) && !float128_is_zero(xb.f128=
)) {
+            t.f128 =3D float128_snan_to_qnan(xb->f128);
+        } else if (float128_is_quiet_nan(xb->f128, &tstat)) {
+            t.f128 =3D xb->f128;
+        } else if (float128_is_neg(xb->f128) && !float128_is_zero(xb->f1=
28)) {
             float_invalid_op_vxsqrt(env, 1, GETPC());
-            xt.f128 =3D float128_default_nan(&env->fp_status);
+            t.f128 =3D float128_default_nan(&env->fp_status);
         }
     }
=20
-    helper_compute_fprf_float128(env, xt.f128);
-    putVSR(rD(opcode) + 32, &xt, env);
+    helper_compute_fprf_float128(env, t.f128);
+    *xt =3D t;
     do_float_check_status(env, GETPC());
 }
=20
 void helper_xssubqp(CPUPPCState *env, uint32_t opcode)
 {
-    ppc_vsr_t xt, xa, xb;
+    ppc_vsr_t *xt =3D &env->vsr[rD(opcode) + 32];
+    ppc_vsr_t *xa =3D &env->vsr[rA(opcode) + 32];
+    ppc_vsr_t *xb =3D &env->vsr[rB(opcode) + 32];
+    ppc_vsr_t t =3D *xt;
     float_status tstat;
=20
-    getVSR(rA(opcode) + 32, &xa, env);
-    getVSR(rB(opcode) + 32, &xb, env);
-    getVSR(rD(opcode) + 32, &xt, env);
     helper_reset_fpstatus(env);
=20
     tstat =3D env->fp_status;
@@ -3523,16 +3493,16 @@ void helper_xssubqp(CPUPPCState *env, uint32_t op=
code)
     }
=20
     set_float_exception_flags(0, &tstat);
-    xt.f128 =3D float128_sub(xa.f128, xb.f128, &tstat);
+    t.f128 =3D float128_sub(xa->f128, xb->f128, &tstat);
     env->fp_status.float_exception_flags |=3D tstat.float_exception_flag=
s;
=20
     if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
         float_invalid_op_addsub(env, 1, GETPC(),
-                                float128_classify(xa.f128) |
-                                float128_classify(xb.f128));
+                                float128_classify(xa->f128) |
+                                float128_classify(xb->f128));
     }
=20
-    helper_compute_fprf_float128(env, xt.f128);
-    putVSR(rD(opcode) + 32, &xt, env);
+    helper_compute_fprf_float128(env, t.f128);
+    *xt =3D t;
     do_float_check_status(env, GETPC());
 }
--=20
2.21.0


