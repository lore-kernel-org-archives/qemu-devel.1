Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E954C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:16:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6999F20867
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GI1wqkd1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6999F20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGKdd-0002bk-Ly
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 06:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2m-0005Rp-5z
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2k-0005Yu-5A
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:35 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:45751)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iGK2j-0005Bl-NZ; Fri, 04 Oct 2019 05:38:34 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46l4YK65kFz9sRp; Fri,  4 Oct 2019 19:37:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570181877;
 bh=Kp19NRaTYZalRan3w5m7M/FYcimhEaePhZoUsGmS3Yo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GI1wqkd1AsnlZYxSm8/9JlHEIlHA3TGbACovzgWtse8XEITk8JXbybYkTnMo74f2U
 CIfeSaQAynH5dbeEmUQNq0jJ6khQlTE2JYEjC5gIQw74ighLh2Gg2YL5PrtF2uDPGW
 PpERNojWSxQtSXK8YpMTqIXA5UTzQ9CKIAo+Pnjo=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 25/53] target/ppc: introduce dfp_finalize_decimal{64,
 128}() helper functions
Date: Fri,  4 Oct 2019 19:37:19 +1000
Message-Id: <20191004093747.31350-26-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191004093747.31350-1-david@gibson.dropbear.id.au>
References: <20191004093747.31350-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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

Most of the DFP helper functions call decimal{64,128}FromNumber() just be=
fore
returning in order to convert the decNumber stored in dfp.t64 back to a
Decimal{64,128} to write back to the FP registers.

Introduce new dfp_finalize_decimal{64,128}() helper functions which both =
enable
the parameter list to be reduced considerably, and also help minimise the
changes required in the next patch.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190926185801.11176-5-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/dfp_helper.c | 42 ++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/target/ppc/dfp_helper.c b/target/ppc/dfp_helper.c
index ab5e91d8ed..8e1ea2971a 100644
--- a/target/ppc/dfp_helper.c
+++ b/target/ppc/dfp_helper.c
@@ -191,6 +191,16 @@ static void dfp_prepare_decimal128(struct PPC_DFP *d=
fp, ppc_fprp_t *a,
     }
 }
=20
+static void dfp_finalize_decimal64(struct PPC_DFP *dfp)
+{
+    decimal64FromNumber((decimal64 *)&dfp->t64, &dfp->t, &dfp->context);
+}
+
+static void dfp_finalize_decimal128(struct PPC_DFP *dfp)
+{
+    decimal128FromNumber((decimal128 *)&dfp->t64, &dfp->t, &dfp->context=
);
+}
+
 static void dfp_set_FPSCR_flag(struct PPC_DFP *dfp, uint64_t flag,
                 uint64_t enabled)
 {
@@ -422,7 +432,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc=
_fprp_t *a,               \
     struct PPC_DFP dfp;                                                 =
       \
     dfp_prepare_decimal##size(&dfp, a, b, env);                         =
       \
     dnop(&dfp.t, &dfp.a, &dfp.b, &dfp.context);                         =
       \
-    decimal##size##FromNumber((decimal##size *)dfp.t64, &dfp.t, &dfp.con=
text); \
+    dfp_finalize_decimal##size(&dfp);                                   =
       \
     postprocs(&dfp);                                                    =
       \
     if (size =3D=3D 64) {                                               =
           \
         set_dfp64(t, dfp.t64);                                          =
       \
@@ -491,7 +501,7 @@ uint32_t helper_##op(CPUPPCState *env, ppc_fprp_t *a,=
 ppc_fprp_t *b)           \
     struct PPC_DFP dfp;                                                 =
       \
     dfp_prepare_decimal##size(&dfp, a, b, env);                         =
       \
     dnop(&dfp.t, &dfp.a, &dfp.b, &dfp.context);                         =
       \
-    decimal##size##FromNumber((decimal##size *)dfp.t64, &dfp.t, &dfp.con=
text); \
+    dfp_finalize_decimal##size(&dfp);                                   =
       \
     postprocs(&dfp);                                                    =
       \
     return dfp.crbf;                                                    =
       \
 }
@@ -741,8 +751,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc=
_fprp_t *b,        \
     dfp.a.exponent =3D (int32_t)((int8_t)(te << 3) >> 3);               =
  \
                                                                         =
\
     dfp_quantize(rmc, &dfp);                                            =
\
-    decimal##size##FromNumber((decimal##size *)dfp.t64, &dfp.t,         =
\
-                              &dfp.context);                            =
\
+    dfp_finalize_decimal##size(&dfp);                                   =
\
     QUA_PPs(&dfp);                                                      =
\
                                                                         =
\
     if (size =3D=3D 64) {                                               =
    \
@@ -764,8 +773,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc=
_fprp_t *a,        \
     dfp_prepare_decimal##size(&dfp, a, b, env);                         =
\
                                                                         =
\
     dfp_quantize(rmc, &dfp);                                            =
\
-    decimal##size##FromNumber((decimal##size *)dfp.t64, &dfp.t,         =
\
-                              &dfp.context);                            =
\
+    dfp_finalize_decimal##size(&dfp);                                   =
\
     QUA_PPs(&dfp);                                                      =
\
                                                                         =
\
     if (size =3D=3D 64) {                                               =
    \
@@ -847,8 +855,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc=
_fprp_t *a,        \
     ref_sig =3D a64 & 0x3f;                                             =
  \
                                                                         =
\
     _dfp_reround(rmc, ref_sig, xmax, &dfp);                             =
\
-    decimal##size##FromNumber((decimal##size *)dfp.t64, &dfp.t,         =
\
-                              &dfp.context);                            =
\
+    dfp_finalize_decimal##size(&dfp);                                   =
\
     QUA_PPs(&dfp);                                                      =
\
                                                                         =
\
     if (size =3D=3D 64) {                                               =
    \
@@ -871,7 +878,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc=
_fprp_t *b,               \
                                                                         =
       \
     dfp_set_round_mode_from_immediate(r, rmc, &dfp);                    =
       \
     decNumberToIntegralExact(&dfp.t, &dfp.b, &dfp.context);             =
       \
-    decimal##size##FromNumber((decimal##size *)dfp.t64, &dfp.t, &dfp.con=
text); \
+    dfp_finalize_decimal##size(&dfp);                                   =
       \
     postprocs(&dfp);                                                    =
       \
                                                                         =
       \
     if (size =3D=3D 64) {                                               =
           \
@@ -911,7 +918,7 @@ void helper_dctdp(CPUPPCState *env, ppc_fprp_t *t, pp=
c_fprp_t *b)
=20
     dfp_prepare_decimal64(&dfp, 0, 0, env);
     decimal32ToNumber((decimal32 *)&b_short, &dfp.t);
-    decimal64FromNumber((decimal64 *)&dfp.t64, &dfp.t, &dfp.context);
+    dfp_finalize_decimal64(&dfp);
     set_dfp64(t, dfp.t64);
     dfp_set_FPRF_from_FRT(&dfp);
 }
@@ -927,7 +934,7 @@ void helper_dctqpq(CPUPPCState *env, ppc_fprp_t *t, p=
pc_fprp_t *b)
     dfp_check_for_VXSNAN_and_convert_to_QNaN(&dfp);
     dfp_set_FPRF_from_FRT(&dfp);
=20
-    decimal128FromNumber((decimal128 *)&dfp.t64, &dfp.t, &dfp.context);
+    dfp_finalize_decimal128(&dfp);
     set_dfp128(t, dfp.t64);
 }
=20
@@ -963,7 +970,7 @@ void helper_drdpq(CPUPPCState *env, ppc_fprp_t *t, pp=
c_fprp_t *b)
     dfp_check_for_XX(&dfp);
=20
     dfp.t64[0] =3D dfp.t64[1] =3D 0;
-    decimal64FromNumber((decimal64 *)dfp.t64, &dfp.t, &dfp.context);
+    dfp_finalize_decimal64(&dfp);
     set_dfp128(t, dfp.t64);
 }
=20
@@ -975,7 +982,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc=
_fprp_t *b)               \
     dfp_prepare_decimal##size(&dfp, 0, b, env);                         =
       \
     get_dfp64(&b64, b);                                                 =
       \
     decNumberFromInt64(&dfp.t, (int64_t)b64);                           =
       \
-    decimal##size##FromNumber((decimal##size *)dfp.t64, &dfp.t, &dfp.con=
text); \
+    dfp_finalize_decimal##size(&dfp);                                   =
       \
     CFFIX_PPs(&dfp);                                                    =
       \
                                                                         =
       \
     if (size =3D=3D 64) {                                               =
           \
@@ -1155,8 +1162,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, p=
pc_fprp_t *b,             \
     if (s && sgn)  {                                                    =
     \
         dfp.t.bits |=3D DECNEG;                                         =
       \
     }                                                                   =
     \
-    decimal##size##FromNumber((decimal##size *)dfp.t64, &dfp.t,         =
     \
-                              &dfp.context);                            =
     \
+    dfp_finalize_decimal##size(&dfp);                                   =
     \
     dfp_set_FPRF_from_FRT(&dfp);                                        =
     \
     if ((size) =3D=3D 64) {                                             =
         \
         set_dfp64(t, dfp.t64);                                          =
     \
@@ -1259,8 +1265,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, p=
pc_fprp_t *a,          \
             dfp.t.bits &=3D ~DECSPECIAL;                                =
    \
         }                                                               =
  \
         dfp.t.exponent =3D exp - bias;                                  =
    \
-        decimal##size##FromNumber((decimal##size *)dfp.t64, &dfp.t,     =
  \
-                                  &dfp.context);                        =
  \
+        dfp_finalize_decimal##size(&dfp);                               =
  \
     }                                                                   =
  \
     if (size =3D=3D 64) {                                               =
      \
         set_dfp64(t, dfp.t64);                                          =
  \
@@ -1340,8 +1345,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, p=
pc_fprp_t *a,    \
             dfp.t.digits =3D max_digits - 1;                          \
         }                                                           \
                                                                     \
-        decimal##size##FromNumber((decimal##size *)dfp.t64, &dfp.t, \
-                                  &dfp.context);                    \
+        dfp_finalize_decimal##size(&dfp);                           \
     } else {                                                        \
         if ((size) =3D=3D 64) {                                         =
\
             dfp.t64[0] =3D dfp.a64[0] & 0xFFFC000000000000ULL;        \
--=20
2.21.0


