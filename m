Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC798C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409732133F
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="V3YAsP/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409732133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGKHA-0003te-QA
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 05:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2T-000579-8z
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2Q-0005Eb-SE
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:17 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57393 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iGK2Q-0005CL-67; Fri, 04 Oct 2019 05:38:14 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46l4YL0Wqkz9sRv; Fri,  4 Oct 2019 19:37:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570181878;
 bh=ItLkNPyo9aMFiziy6unAveqF9BXmWCRdpp0rapSTQiA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=V3YAsP/rZHlavUNxrWqMsKRWG7AtV1RgHydPnAJpejr1fLmZh62tm13qy7o3SKCAW
 X4/Zsn/Ebo2fA4EbwGRDzGKrNdFd7VnQXaSAyOaAX4piJ9MIHa9B+btvBH4YPBVwbO
 ABSElzOhLarGAlep08TJgg9nXpp9b3syG9eYR588=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 26/53] target/ppc: change struct PPC_DFP decimal storage from
 uint64[2] to ppc_vsr_t
Date: Fri,  4 Oct 2019 19:37:20 +1000
Message-Id: <20191004093747.31350-27-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191004093747.31350-1-david@gibson.dropbear.id.au>
References: <20191004093747.31350-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

There are several places in dfp_helper.c that access the decimal number
representations in struct PPC_DFP via HI_IDX and LO_IDX defines which are=
 set
at the top of dfp_helper.c according to the host endian.

However we can instead switch to using ppc_vsr_t for decimal numbers and =
then
make subsequent use of the existing VsrD() macros to access the correct
element regardless of host endian. Note that 64-bit decimals are stored i=
n the
LSB of ppc_vsr_t (equivalent to VsrD(1)).

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190926185801.11176-6-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/dfp_helper.c | 210 +++++++++++++++++++++-------------------
 1 file changed, 108 insertions(+), 102 deletions(-)

diff --git a/target/ppc/dfp_helper.c b/target/ppc/dfp_helper.c
index 8e1ea2971a..b72084d50a 100644
--- a/target/ppc/dfp_helper.c
+++ b/target/ppc/dfp_helper.c
@@ -36,31 +36,31 @@
 #define LO_IDX 0
 #endif
=20
-static void get_dfp64(uint64_t *dst, ppc_fprp_t *dfp)
+static void get_dfp64(ppc_vsr_t *dst, ppc_fprp_t *dfp)
 {
-    dst[0] =3D dfp->VsrD(0);
+    dst->VsrD(1) =3D dfp->VsrD(0);
 }
=20
-static void get_dfp128(uint64_t *dst, ppc_fprp_t *dfp)
+static void get_dfp128(ppc_vsr_t *dst, ppc_fprp_t *dfp)
 {
-    dst[HI_IDX] =3D dfp[0].VsrD(0);
-    dst[LO_IDX] =3D dfp[1].VsrD(0);
+    dst->VsrD(0) =3D dfp[0].VsrD(0);
+    dst->VsrD(1) =3D dfp[1].VsrD(0);
 }
=20
-static void set_dfp64(ppc_fprp_t *dfp, uint64_t *src)
+static void set_dfp64(ppc_fprp_t *dfp, ppc_vsr_t *src)
 {
-    dfp->VsrD(0) =3D src[0];
+    dfp->VsrD(0) =3D src->VsrD(1);
 }
=20
-static void set_dfp128(ppc_fprp_t *dfp, uint64_t *src)
+static void set_dfp128(ppc_fprp_t *dfp, ppc_vsr_t *src)
 {
-    dfp[0].VsrD(0) =3D src[HI_IDX];
-    dfp[1].VsrD(0) =3D src[LO_IDX];
+    dfp[0].VsrD(0) =3D src->VsrD(0);
+    dfp[1].VsrD(0) =3D src->VsrD(1);
 }
=20
 struct PPC_DFP {
     CPUPPCState *env;
-    uint64_t t64[2], a64[2], b64[2];
+    ppc_vsr_t vt, va, vb;
     decNumber t, a, b;
     decContext context;
     uint8_t crbf;
@@ -151,18 +151,18 @@ static void dfp_prepare_decimal64(struct PPC_DFP *d=
fp, ppc_fprp_t *a,
     dfp->env =3D env;
=20
     if (a) {
-        get_dfp64(dfp->a64, a);
-        decimal64ToNumber((decimal64 *)dfp->a64, &dfp->a);
+        get_dfp64(&dfp->va, a);
+        decimal64ToNumber((decimal64 *)&dfp->va.VsrD(1), &dfp->a);
     } else {
-        dfp->a64[0] =3D 0;
+        dfp->va.VsrD(1) =3D 0;
         decNumberZero(&dfp->a);
     }
=20
     if (b) {
-        get_dfp64(dfp->b64, b);
-        decimal64ToNumber((decimal64 *)dfp->b64, &dfp->b);
+        get_dfp64(&dfp->vb, b);
+        decimal64ToNumber((decimal64 *)&dfp->vb.VsrD(1), &dfp->b);
     } else {
-        dfp->b64[0] =3D 0;
+        dfp->vb.VsrD(1) =3D 0;
         decNumberZero(&dfp->b);
     }
 }
@@ -175,30 +175,30 @@ static void dfp_prepare_decimal128(struct PPC_DFP *=
dfp, ppc_fprp_t *a,
     dfp->env =3D env;
=20
     if (a) {
-        get_dfp128(dfp->a64, a);
-        decimal128ToNumber((decimal128 *)dfp->a64, &dfp->a);
+        get_dfp128(&dfp->va, a);
+        decimal128ToNumber((decimal128 *)&dfp->va, &dfp->a);
     } else {
-        dfp->a64[0] =3D dfp->a64[1] =3D 0;
+        dfp->va.VsrD(0) =3D dfp->va.VsrD(1) =3D 0;
         decNumberZero(&dfp->a);
     }
=20
     if (b) {
-        get_dfp128(dfp->b64, b);
-        decimal128ToNumber((decimal128 *)dfp->b64, &dfp->b);
+        get_dfp128(&dfp->vb, b);
+        decimal128ToNumber((decimal128 *)&dfp->vb, &dfp->b);
     } else {
-        dfp->b64[0] =3D dfp->b64[1] =3D 0;
+        dfp->vb.VsrD(0) =3D dfp->vb.VsrD(1) =3D 0;
         decNumberZero(&dfp->b);
     }
 }
=20
 static void dfp_finalize_decimal64(struct PPC_DFP *dfp)
 {
-    decimal64FromNumber((decimal64 *)&dfp->t64, &dfp->t, &dfp->context);
+    decimal64FromNumber((decimal64 *)&dfp->vt.VsrD(1), &dfp->t, &dfp->co=
ntext);
 }
=20
 static void dfp_finalize_decimal128(struct PPC_DFP *dfp)
 {
-    decimal128FromNumber((decimal128 *)&dfp->t64, &dfp->t, &dfp->context=
);
+    decimal128FromNumber((decimal128 *)&dfp->vt, &dfp->t, &dfp->context)=
;
 }
=20
 static void dfp_set_FPSCR_flag(struct PPC_DFP *dfp, uint64_t flag,
@@ -435,9 +435,9 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc=
_fprp_t *a,               \
     dfp_finalize_decimal##size(&dfp);                                   =
       \
     postprocs(&dfp);                                                    =
       \
     if (size =3D=3D 64) {                                               =
           \
-        set_dfp64(t, dfp.t64);                                          =
       \
+        set_dfp64(t, &dfp.vt);                                          =
       \
     } else if (size =3D=3D 128) {                                       =
           \
-        set_dfp128(t, dfp.t64);                                         =
       \
+        set_dfp128(t, &dfp.vt);                                         =
       \
     }                                                                   =
       \
 }
=20
@@ -647,12 +647,12 @@ uint32_t helper_##op(CPUPPCState *env, ppc_fprp_t *=
a, ppc_fprp_t *b)     \
 {                                                                       =
 \
     struct PPC_DFP dfp;                                                 =
 \
     unsigned k;                                                         =
 \
-    uint64_t a64;                                                       =
 \
+    ppc_vsr_t va;                                                       =
 \
                                                                         =
 \
     dfp_prepare_decimal##size(&dfp, 0, b, env);                         =
 \
                                                                         =
 \
-    get_dfp64(&a64, a);                                                 =
 \
-    k =3D a64 & 0x3F;                                                   =
   \
+    get_dfp64(&va, a);                                                  =
 \
+    k =3D va.VsrD(1) & 0x3F;                                            =
   \
                                                                         =
 \
     if (unlikely(decNumberIsSpecial(&dfp.b))) {                         =
 \
         dfp.crbf =3D 1;                                                 =
   \
@@ -755,9 +755,9 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc=
_fprp_t *b,        \
     QUA_PPs(&dfp);                                                      =
\
                                                                         =
\
     if (size =3D=3D 64) {                                               =
    \
-        set_dfp64(t, dfp.t64);                                          =
\
+        set_dfp64(t, &dfp.vt);                                          =
\
     } else if (size =3D=3D 128) {                                       =
    \
-        set_dfp128(t, dfp.t64);                                         =
\
+        set_dfp128(t, &dfp.vt);                                         =
\
     }                                                                   =
\
 }
=20
@@ -777,9 +777,9 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc=
_fprp_t *a,        \
     QUA_PPs(&dfp);                                                      =
\
                                                                         =
\
     if (size =3D=3D 64) {                                               =
    \
-        set_dfp64(t, dfp.t64);                                          =
\
+        set_dfp64(t, &dfp.vt);                                          =
\
     } else if (size =3D=3D 128) {                                       =
    \
-        set_dfp128(t, dfp.t64);                                         =
\
+        set_dfp128(t, &dfp.vt);                                         =
\
     }                                                                   =
\
 }
=20
@@ -845,23 +845,23 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, p=
pc_fprp_t *a,        \
                  ppc_fprp_t *b, uint32_t rmc)                           =
\
 {                                                                       =
\
     struct PPC_DFP dfp;                                                 =
\
-    uint64_t a64;                                                       =
\
+    ppc_vsr_t va;                                                       =
\
     int32_t ref_sig;                                                    =
\
     int32_t xmax =3D ((size) =3D=3D 64) ? 369 : 6111;                   =
      \
                                                                         =
\
     dfp_prepare_decimal##size(&dfp, 0, b, env);                         =
\
                                                                         =
\
-    get_dfp64(&a64, a);                                                 =
\
-    ref_sig =3D a64 & 0x3f;                                             =
  \
+    get_dfp64(&va, a);                                                  =
\
+    ref_sig =3D va.VsrD(1) & 0x3f;                                      =
  \
                                                                         =
\
     _dfp_reround(rmc, ref_sig, xmax, &dfp);                             =
\
     dfp_finalize_decimal##size(&dfp);                                   =
\
     QUA_PPs(&dfp);                                                      =
\
                                                                         =
\
     if (size =3D=3D 64) {                                               =
    \
-        set_dfp64(t, dfp.t64);                                          =
\
+        set_dfp64(t, &dfp.vt);                                          =
\
     } else if (size =3D=3D 128) {                                       =
    \
-        set_dfp128(t, dfp.t64);                                         =
\
+        set_dfp128(t, &dfp.vt);                                         =
\
     }                                                                   =
\
 }
=20
@@ -882,9 +882,9 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc=
_fprp_t *b,               \
     postprocs(&dfp);                                                    =
       \
                                                                         =
       \
     if (size =3D=3D 64) {                                               =
           \
-        set_dfp64(t, dfp.t64);                                          =
       \
+        set_dfp64(t, &dfp.vt);                                          =
       \
     } else if (size =3D=3D 128) {                                       =
           \
-        set_dfp128(t, dfp.t64);                                         =
       \
+        set_dfp128(t, &dfp.vt);                                         =
       \
     }                                                                   =
       \
 }
=20
@@ -910,39 +910,39 @@ DFP_HELPER_RINT(drintnq, RINTN_PPs, 128)
 void helper_dctdp(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)
 {
     struct PPC_DFP dfp;
-    uint64_t b64;
+    ppc_vsr_t vb;
     uint32_t b_short;
=20
-    get_dfp64(&b64, b);
-    b_short =3D (uint32_t)b64;
+    get_dfp64(&vb, b);
+    b_short =3D (uint32_t)vb.VsrD(1);
=20
     dfp_prepare_decimal64(&dfp, 0, 0, env);
     decimal32ToNumber((decimal32 *)&b_short, &dfp.t);
     dfp_finalize_decimal64(&dfp);
-    set_dfp64(t, dfp.t64);
+    set_dfp64(t, &dfp.vt);
     dfp_set_FPRF_from_FRT(&dfp);
 }
=20
 void helper_dctqpq(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)
 {
     struct PPC_DFP dfp;
-    uint64_t b64;
+    ppc_vsr_t vb;
     dfp_prepare_decimal128(&dfp, 0, 0, env);
-    get_dfp64(&b64, b);
-    decimal64ToNumber((decimal64 *)&b64, &dfp.t);
+    get_dfp64(&vb, b);
+    decimal64ToNumber((decimal64 *)&vb.VsrD(1), &dfp.t);
=20
     dfp_check_for_VXSNAN_and_convert_to_QNaN(&dfp);
     dfp_set_FPRF_from_FRT(&dfp);
=20
     dfp_finalize_decimal128(&dfp);
-    set_dfp128(t, dfp.t64);
+    set_dfp128(t, &dfp.vt);
 }
=20
 void helper_drsp(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)
 {
     struct PPC_DFP dfp;
     uint32_t t_short =3D 0;
-    uint64_t t64;
+    ppc_vsr_t vt;
     dfp_prepare_decimal64(&dfp, 0, b, env);
     decimal32FromNumber((decimal32 *)&t_short, &dfp.b, &dfp.context);
     decimal32ToNumber((decimal32 *)&t_short, &dfp.t);
@@ -952,16 +952,16 @@ void helper_drsp(CPUPPCState *env, ppc_fprp_t *t, p=
pc_fprp_t *b)
     dfp_check_for_UX(&dfp);
     dfp_check_for_XX(&dfp);
=20
-    t64 =3D (uint64_t)t_short;
-    set_dfp64(t, &t64);
+    vt.VsrD(1) =3D (uint64_t)t_short;
+    set_dfp64(t, &vt);
 }
=20
 void helper_drdpq(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)
 {
     struct PPC_DFP dfp;
     dfp_prepare_decimal128(&dfp, 0, b, env);
-    decimal64FromNumber((decimal64 *)&dfp.t64, &dfp.b, &dfp.context);
-    decimal64ToNumber((decimal64 *)&dfp.t64, &dfp.t);
+    decimal64FromNumber((decimal64 *)&dfp.vt.VsrD(1), &dfp.b, &dfp.conte=
xt);
+    decimal64ToNumber((decimal64 *)&dfp.vt.VsrD(1), &dfp.t);
=20
     dfp_check_for_VXSNAN_and_convert_to_QNaN(&dfp);
     dfp_set_FPRF_from_FRT_long(&dfp);
@@ -969,26 +969,26 @@ void helper_drdpq(CPUPPCState *env, ppc_fprp_t *t, =
ppc_fprp_t *b)
     dfp_check_for_UX(&dfp);
     dfp_check_for_XX(&dfp);
=20
-    dfp.t64[0] =3D dfp.t64[1] =3D 0;
+    dfp.vt.VsrD(0) =3D dfp.vt.VsrD(1) =3D 0;
     dfp_finalize_decimal64(&dfp);
-    set_dfp128(t, dfp.t64);
+    set_dfp128(t, &dfp.vt);
 }
=20
 #define DFP_HELPER_CFFIX(op, size)                                      =
       \
 void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)        =
       \
 {                                                                       =
       \
     struct PPC_DFP dfp;                                                 =
       \
-    uint64_t b64;                                                       =
       \
+    ppc_vsr_t vb;                                                       =
       \
     dfp_prepare_decimal##size(&dfp, 0, b, env);                         =
       \
-    get_dfp64(&b64, b);                                                 =
       \
-    decNumberFromInt64(&dfp.t, (int64_t)b64);                           =
       \
+    get_dfp64(&vb, b);                                                  =
       \
+    decNumberFromInt64(&dfp.t, (int64_t)vb.VsrD(1));                    =
       \
     dfp_finalize_decimal##size(&dfp);                                   =
       \
     CFFIX_PPs(&dfp);                                                    =
       \
                                                                         =
       \
     if (size =3D=3D 64) {                                               =
           \
-        set_dfp64(t, dfp.t64);                                          =
       \
+        set_dfp64(t, &dfp.vt);                                          =
       \
     } else if (size =3D=3D 128) {                                       =
           \
-        set_dfp128(t, dfp.t64);                                         =
       \
+        set_dfp128(t, &dfp.vt);                                         =
       \
     }                                                                   =
       \
 }
=20
@@ -1010,28 +1010,30 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t,=
 ppc_fprp_t *b)              \
     if (unlikely(decNumberIsSpecial(&dfp.b))) {                         =
      \
         uint64_t invalid_flags =3D FP_VX | FP_VXCVI;                    =
        \
         if (decNumberIsInfinite(&dfp.b)) {                              =
      \
-            dfp.t64[0] =3D decNumberIsNegative(&dfp.b) ? INT64_MIN : INT=
64_MAX; \
+            dfp.vt.VsrD(1) =3D decNumberIsNegative(&dfp.b) ? INT64_MIN :=
        \
+                                                           INT64_MAX;   =
      \
         } else { /* NaN */                                              =
      \
-            dfp.t64[0] =3D INT64_MIN;                                   =
        \
+            dfp.vt.VsrD(1) =3D INT64_MIN;                               =
        \
             if (decNumberIsSNaN(&dfp.b)) {                              =
      \
                 invalid_flags |=3D FP_VXSNAN;                           =
        \
             }                                                           =
      \
         }                                                               =
      \
         dfp_set_FPSCR_flag(&dfp, invalid_flags, FP_VE);                 =
      \
     } else if (unlikely(decNumberIsZero(&dfp.b))) {                     =
      \
-        dfp.t64[0] =3D 0;                                               =
        \
+        dfp.vt.VsrD(1) =3D 0;                                           =
        \
     } else {                                                            =
      \
         decNumberToIntegralExact(&dfp.b, &dfp.b, &dfp.context);         =
      \
-        dfp.t64[0] =3D decNumberIntegralToInt64(&dfp.b, &dfp.context);  =
        \
+        dfp.vt.VsrD(1) =3D decNumberIntegralToInt64(&dfp.b, &dfp.context=
);      \
         if (decContextTestStatus(&dfp.context, DEC_Invalid_operation)) {=
      \
-            dfp.t64[0] =3D decNumberIsNegative(&dfp.b) ? INT64_MIN : INT=
64_MAX; \
+            dfp.vt.VsrD(1) =3D decNumberIsNegative(&dfp.b) ? INT64_MIN :=
        \
+                                                           INT64_MAX;   =
      \
             dfp_set_FPSCR_flag(&dfp, FP_VX | FP_VXCVI, FP_VE);          =
      \
         } else {                                                        =
      \
             dfp_check_for_XX(&dfp);                                     =
      \
         }                                                               =
      \
     }                                                                   =
      \
                                                                         =
      \
-    set_dfp64(t, dfp.t64);                                              =
      \
+    set_dfp64(t, &dfp.vt);                                              =
      \
 }
=20
 DFP_HELPER_CTFIX(dctfix, 64)
@@ -1075,11 +1077,11 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t,=
 ppc_fprp_t *b,          \
     dfp_prepare_decimal##size(&dfp, 0, b, env);                         =
  \
                                                                         =
  \
     decNumberGetBCD(&dfp.b, digits);                                    =
  \
-    dfp.t64[0] =3D dfp.t64[1] =3D 0;                                    =
      \
+    dfp.vt.VsrD(0) =3D dfp.vt.VsrD(1) =3D 0;                            =
      \
     N =3D dfp.b.digits;                                                 =
    \
                                                                         =
  \
     for (i =3D 0; (i < N) && (i < (size)/4); i++) {                     =
    \
-        dfp_set_bcd_digit_##size(dfp.t64, digits[N-i-1], i);            =
  \
+        dfp_set_bcd_digit_##size(&dfp.vt.u64[0], digits[N - i - 1], i); =
  \
     }                                                                   =
  \
                                                                         =
  \
     if (sp & 2) {                                                       =
  \
@@ -1090,13 +1092,13 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t,=
 ppc_fprp_t *b,          \
         } else {                                                        =
  \
             sgn =3D ((sp & 1) ? 0xF : 0xC);                             =
    \
         }                                                               =
  \
-        dfp_set_sign_##size(dfp.t64, sgn);                              =
  \
+        dfp_set_sign_##size(&dfp.vt.u64[0], sgn);                       =
  \
     }                                                                   =
  \
                                                                         =
  \
     if (size =3D=3D 64) {                                               =
      \
-        set_dfp64(t, dfp.t64);                                          =
  \
+        set_dfp64(t, &dfp.vt);                                          =
  \
     } else if (size =3D=3D 128) {                                       =
      \
-        set_dfp128(t, dfp.t64);                                         =
  \
+        set_dfp128(t, &dfp.vt);                                         =
  \
     }                                                                   =
  \
 }
=20
@@ -1126,7 +1128,8 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, p=
pc_fprp_t *b,             \
     decNumberZero(&dfp.t);                                              =
     \
                                                                         =
     \
     if (s) {                                                            =
     \
-        uint8_t sgnNibble =3D dfp_get_bcd_digit_##size(dfp.b64, offset++=
);     \
+        uint8_t sgnNibble =3D dfp_get_bcd_digit_##size(&dfp.vb.u64[0],  =
       \
+                                                     offset++);         =
     \
         switch (sgnNibble) {                                            =
     \
         case 0xD:                                                       =
     \
         case 0xB:                                                       =
     \
@@ -1146,7 +1149,8 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, p=
pc_fprp_t *b,             \
                                                                         =
     \
     while (offset < (size) / 4) {                                       =
     \
         n++;                                                            =
     \
-        digits[(size) / 4 - n] =3D dfp_get_bcd_digit_##size(dfp.b64, off=
set++); \
+        digits[(size) / 4 - n] =3D dfp_get_bcd_digit_##size(&dfp.vb.u64[=
0],    \
+                                                          offset++);    =
     \
         if (digits[(size) / 4 - n] > 10) {                              =
     \
             dfp_set_FPSCR_flag(&dfp, FP_VX | FP_VXCVI, FPSCR_VE);       =
     \
             return;                                                     =
     \
@@ -1165,9 +1169,9 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, p=
pc_fprp_t *b,             \
     dfp_finalize_decimal##size(&dfp);                                   =
     \
     dfp_set_FPRF_from_FRT(&dfp);                                        =
     \
     if ((size) =3D=3D 64) {                                             =
         \
-        set_dfp64(t, dfp.t64);                                          =
     \
+        set_dfp64(t, &dfp.vt);                                          =
     \
     } else if ((size) =3D=3D 128) {                                     =
         \
-        set_dfp128(t, dfp.t64);                                         =
     \
+        set_dfp128(t, &dfp.vt);                                         =
     \
     }                                                                   =
     \
 }
=20
@@ -1178,30 +1182,30 @@ DFP_HELPER_ENBCD(denbcdq, 128)
 void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b) \
 {                                                              \
     struct PPC_DFP dfp;                                        \
-    uint64_t t64;                                              \
+    ppc_vsr_t vt;                                              \
                                                                \
     dfp_prepare_decimal##size(&dfp, 0, b, env);                \
                                                                \
     if (unlikely(decNumberIsSpecial(&dfp.b))) {                \
         if (decNumberIsInfinite(&dfp.b)) {                     \
-            t64 =3D -1;                                          \
+            vt.VsrD(1) =3D -1;                                   \
         } else if (decNumberIsSNaN(&dfp.b)) {                  \
-            t64 =3D -3;                                          \
+            vt.VsrD(1) =3D -3;                                   \
         } else if (decNumberIsQNaN(&dfp.b)) {                  \
-            t64 =3D -2;                                          \
+            vt.VsrD(1) =3D -2;                                   \
         } else {                                               \
             assert(0);                                         \
         }                                                      \
-        set_dfp64(t, &t64);                                    \
+        set_dfp64(t, &vt);                                     \
     } else {                                                   \
         if ((size) =3D=3D 64) {                                    \
-            t64 =3D dfp.b.exponent + 398;                        \
+            vt.VsrD(1) =3D dfp.b.exponent + 398;                 \
         } else if ((size) =3D=3D 128) {                            \
-            t64 =3D dfp.b.exponent + 6176;                       \
+            vt.VsrD(1) =3D dfp.b.exponent + 6176;                \
         } else {                                               \
             assert(0);                                         \
         }                                                      \
-        set_dfp64(t, &t64);                                    \
+        set_dfp64(t, &vt);                                     \
     }                                                          \
 }
=20
@@ -1225,12 +1229,13 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t,=
 ppc_fprp_t *a,          \
                  ppc_fprp_t *b)                                         =
  \
 {                                                                       =
  \
     struct PPC_DFP dfp;                                                 =
  \
-    uint64_t raw_qnan, raw_snan, raw_inf, max_exp, a64;                 =
  \
+    uint64_t raw_qnan, raw_snan, raw_inf, max_exp;                      =
  \
+    ppc_vsr_t va;                                                       =
  \
     int bias;                                                           =
  \
     int64_t exp;                                                        =
  \
                                                                         =
  \
-    get_dfp64(&a64, a);                                                 =
  \
-    exp =3D (int64_t)a64;                                               =
    \
+    get_dfp64(&va, a);                                                  =
  \
+    exp =3D (int64_t)va.VsrD(1);                                        =
    \
     dfp_prepare_decimal##size(&dfp, 0, b, env);                         =
  \
                                                                         =
  \
     if ((size) =3D=3D 64) {                                             =
      \
@@ -1250,14 +1255,14 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t,=
 ppc_fprp_t *a,          \
     }                                                                   =
  \
                                                                         =
  \
     if (unlikely((exp < 0) || (exp > max_exp))) {                       =
  \
-        dfp.t64[0] =3D dfp.b64[0];                                      =
    \
-        dfp.t64[1] =3D dfp.b64[1];                                      =
    \
+        dfp.vt.VsrD(0) =3D dfp.vb.VsrD(0);                              =
    \
+        dfp.vt.VsrD(1) =3D dfp.vb.VsrD(1);                              =
    \
         if (exp =3D=3D -1) {                                            =
      \
-            dfp_set_raw_exp_##size(dfp.t64, raw_inf);                   =
  \
+            dfp_set_raw_exp_##size(&dfp.vt.u64[0], raw_inf);            =
  \
         } else if (exp =3D=3D -3) {                                     =
      \
-            dfp_set_raw_exp_##size(dfp.t64, raw_snan);                  =
  \
+            dfp_set_raw_exp_##size(&dfp.vt.u64[0], raw_snan);           =
  \
         } else {                                                        =
  \
-            dfp_set_raw_exp_##size(dfp.t64, raw_qnan);                  =
  \
+            dfp_set_raw_exp_##size(&dfp.vt.u64[0], raw_qnan);           =
  \
         }                                                               =
  \
     } else {                                                            =
  \
         dfp.t =3D dfp.b;                                                =
    \
@@ -1268,9 +1273,9 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, p=
pc_fprp_t *a,          \
         dfp_finalize_decimal##size(&dfp);                               =
  \
     }                                                                   =
  \
     if (size =3D=3D 64) {                                               =
      \
-        set_dfp64(t, dfp.t64);                                          =
  \
+        set_dfp64(t, &dfp.vt);                                          =
  \
     } else if (size =3D=3D 128) {                                       =
      \
-        set_dfp128(t, dfp.t64);                                         =
  \
+        set_dfp128(t, &dfp.vt);                                         =
  \
     }                                                                   =
  \
 }
=20
@@ -1348,20 +1353,21 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t,=
 ppc_fprp_t *a,    \
         dfp_finalize_decimal##size(&dfp);                           \
     } else {                                                        \
         if ((size) =3D=3D 64) {                                         =
\
-            dfp.t64[0] =3D dfp.a64[0] & 0xFFFC000000000000ULL;        \
-            dfp_clear_lmd_from_g5msb(dfp.t64);                      \
+            dfp.vt.VsrD(1) =3D dfp.va.VsrD(1) &                       \
+                             0xFFFC000000000000ULL;                 \
+            dfp_clear_lmd_from_g5msb(&dfp.vt.VsrD(1));              \
         } else {                                                    \
-            dfp.t64[HI_IDX] =3D dfp.a64[HI_IDX] &                     \
-                              0xFFFFC00000000000ULL;                \
-            dfp_clear_lmd_from_g5msb(dfp.t64 + HI_IDX);             \
-            dfp.t64[LO_IDX] =3D 0;                                    \
+            dfp.vt.VsrD(0) =3D dfp.va.VsrD(0) &                       \
+                             0xFFFFC00000000000ULL;                 \
+            dfp_clear_lmd_from_g5msb(&dfp.vt.VsrD(0));              \
+            dfp.vt.VsrD(1) =3D 0;                                     \
         }                                                           \
     }                                                               \
                                                                     \
     if ((size) =3D=3D 64) {                                             =
\
-        set_dfp64(t, dfp.t64);                                      \
+        set_dfp64(t, &dfp.vt);                                      \
     } else {                                                        \
-        set_dfp128(t, dfp.t64);                                     \
+        set_dfp128(t, &dfp.vt);                                     \
     }                                                               \
 }
=20
--=20
2.21.0


