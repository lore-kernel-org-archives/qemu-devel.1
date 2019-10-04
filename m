Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE656C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:14:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ACAB20867
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WKgbSbRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ACAB20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGKbQ-00007W-71
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 06:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2j-0005N3-67
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2h-0005Uo-AX
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:32 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:54621)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iGK2g-000594-Ud; Fri, 04 Oct 2019 05:38:31 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46l4YK34D2z9sRs; Fri,  4 Oct 2019 19:37:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570181877;
 bh=LrZVxyuWBaqlkbXslxNK7uWmeRD8cNDrcKqcQ3Wc2go=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WKgbSbRvshWEa9zkqSxHLsYXyYtru1/Fs2l+u8RNU26eOjjg87csubtCtszo3yh4O
 hhhUqixbWKaHBMFrwb539uj51SQ4rq/+OLJnuJgFSLxdYQA0+Q9JzSdn+nR4fQfSZQ
 rT6PtylHUnVvDjVEC2I3BPkM7YVdjeNZFdtV70CI=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 22/53] target/ppc: introduce get_dfp{64, 128}() helper functions
Date: Fri,  4 Oct 2019 19:37:16 +1000
Message-Id: <20191004093747.31350-23-david@gibson.dropbear.id.au>
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

The existing functions (now incorrectly) assume that the MSB and LSB of D=
FP
numbers are stored as consecutive 64-bit words in memory. Instead of acce=
ssing
the DFP numbers directly, introduce get_dfp{64,128}() helper functions to=
 ease
the switch to the correct representation.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190926185801.11176-2-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/dfp_helper.c | 52 ++++++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/target/ppc/dfp_helper.c b/target/ppc/dfp_helper.c
index 753399177c..e4369ebe9b 100644
--- a/target/ppc/dfp_helper.c
+++ b/target/ppc/dfp_helper.c
@@ -36,6 +36,17 @@
 #define LO_IDX 0
 #endif
=20
+static void get_dfp64(uint64_t *dst, uint64_t *dfp)
+{
+    dst[0] =3D dfp[0];
+}
+
+static void get_dfp128(uint64_t *dst, uint64_t *dfp)
+{
+    dst[0] =3D dfp[HI_IDX];
+    dst[1] =3D dfp[LO_IDX];
+}
+
 struct PPC_DFP {
     CPUPPCState *env;
     uint64_t t64[2], a64[2], b64[2];
@@ -129,7 +140,7 @@ static void dfp_prepare_decimal64(struct PPC_DFP *dfp=
, uint64_t *a,
     dfp->env =3D env;
=20
     if (a) {
-        dfp->a64[0] =3D *a;
+        get_dfp64(dfp->a64, a);
         decimal64ToNumber((decimal64 *)dfp->a64, &dfp->a);
     } else {
         dfp->a64[0] =3D 0;
@@ -137,7 +148,7 @@ static void dfp_prepare_decimal64(struct PPC_DFP *dfp=
, uint64_t *a,
     }
=20
     if (b) {
-        dfp->b64[0] =3D *b;
+        get_dfp64(dfp->b64, b);
         decimal64ToNumber((decimal64 *)dfp->b64, &dfp->b);
     } else {
         dfp->b64[0] =3D 0;
@@ -153,8 +164,7 @@ static void dfp_prepare_decimal128(struct PPC_DFP *df=
p, uint64_t *a,
     dfp->env =3D env;
=20
     if (a) {
-        dfp->a64[0] =3D a[HI_IDX];
-        dfp->a64[1] =3D a[LO_IDX];
+        get_dfp128(dfp->a64, a);
         decimal128ToNumber((decimal128 *)dfp->a64, &dfp->a);
     } else {
         dfp->a64[0] =3D dfp->a64[1] =3D 0;
@@ -162,8 +172,7 @@ static void dfp_prepare_decimal128(struct PPC_DFP *df=
p, uint64_t *a,
     }
=20
     if (b) {
-        dfp->b64[0] =3D b[HI_IDX];
-        dfp->b64[1] =3D b[LO_IDX];
+        get_dfp128(dfp->b64, b);
         decimal128ToNumber((decimal128 *)dfp->b64, &dfp->b);
     } else {
         dfp->b64[0] =3D dfp->b64[1] =3D 0;
@@ -617,10 +626,12 @@ uint32_t helper_##op(CPUPPCState *env, uint64_t *a,=
 uint64_t *b)         \
 {                                                                       =
 \
     struct PPC_DFP dfp;                                                 =
 \
     unsigned k;                                                         =
 \
+    uint64_t a64;                                                       =
 \
                                                                         =
 \
     dfp_prepare_decimal##size(&dfp, 0, b, env);                         =
 \
                                                                         =
 \
-    k =3D *a & 0x3F;                                                    =
   \
+    get_dfp64(&a64, a);                                                 =
 \
+    k =3D a64 & 0x3F;                                                   =
   \
                                                                         =
 \
     if (unlikely(decNumberIsSpecial(&dfp.b))) {                         =
 \
         dfp.crbf =3D 1;                                                 =
   \
@@ -817,11 +828,15 @@ void helper_##op(CPUPPCState *env, uint64_t *t, uin=
t64_t *a,            \
                  uint64_t *b, uint32_t rmc)                             =
\
 {                                                                       =
\
     struct PPC_DFP dfp;                                                 =
\
-    int32_t ref_sig =3D *a & 0x3F;                                      =
  \
+    uint64_t a64;                                                       =
\
+    int32_t ref_sig;                                                    =
\
     int32_t xmax =3D ((size) =3D=3D 64) ? 369 : 6111;                   =
      \
                                                                         =
\
     dfp_prepare_decimal##size(&dfp, 0, b, env);                         =
\
                                                                         =
\
+    get_dfp64(&a64, a);                                                 =
\
+    ref_sig =3D a64 & 0x3f;                                             =
  \
+                                                                        =
\
     _dfp_reround(rmc, ref_sig, xmax, &dfp);                             =
\
     decimal##size##FromNumber((decimal##size *)dfp.t64, &dfp.t,         =
\
                               &dfp.context);                            =
\
@@ -881,7 +896,12 @@ DFP_HELPER_RINT(drintnq, RINTN_PPs, 128)
 void helper_dctdp(CPUPPCState *env, uint64_t *t, uint64_t *b)
 {
     struct PPC_DFP dfp;
-    uint32_t b_short =3D *b;
+    uint64_t b64;
+    uint32_t b_short;
+
+    get_dfp64(&b64, b);
+    b_short =3D (uint32_t)b64;
+
     dfp_prepare_decimal64(&dfp, 0, 0, env);
     decimal32ToNumber((decimal32 *)&b_short, &dfp.t);
     decimal64FromNumber((decimal64 *)t, &dfp.t, &dfp.context);
@@ -891,8 +911,10 @@ void helper_dctdp(CPUPPCState *env, uint64_t *t, uin=
t64_t *b)
 void helper_dctqpq(CPUPPCState *env, uint64_t *t, uint64_t *b)
 {
     struct PPC_DFP dfp;
+    uint64_t b64;
     dfp_prepare_decimal128(&dfp, 0, 0, env);
-    decimal64ToNumber((decimal64 *)b, &dfp.t);
+    get_dfp64(&b64, b);
+    decimal64ToNumber((decimal64 *)&b64, &dfp.t);
=20
     dfp_check_for_VXSNAN_and_convert_to_QNaN(&dfp);
     dfp_set_FPRF_from_FRT(&dfp);
@@ -940,8 +962,10 @@ void helper_drdpq(CPUPPCState *env, uint64_t *t, uin=
t64_t *b)
 void helper_##op(CPUPPCState *env, uint64_t *t, uint64_t *b)            =
       \
 {                                                                       =
       \
     struct PPC_DFP dfp;                                                 =
       \
+    uint64_t b64;                                                       =
       \
     dfp_prepare_decimal##size(&dfp, 0, b, env);                         =
       \
-    decNumberFromInt64(&dfp.t, (int64_t)(*b));                          =
       \
+    get_dfp64(&b64, b);                                                 =
       \
+    decNumberFromInt64(&dfp.t, (int64_t)b64);                           =
       \
     decimal##size##FromNumber((decimal##size *)dfp.t64, &dfp.t, &dfp.con=
text); \
     CFFIX_PPs(&dfp);                                                    =
       \
                                                                         =
       \
@@ -1183,10 +1207,12 @@ static void dfp_set_raw_exp_128(uint64_t *t, uint=
64_t raw)
 void helper_##op(CPUPPCState *env, uint64_t *t, uint64_t *a, uint64_t *b=
) \
 {                                                                       =
  \
     struct PPC_DFP dfp;                                                 =
  \
-    uint64_t raw_qnan, raw_snan, raw_inf, max_exp;                      =
  \
+    uint64_t raw_qnan, raw_snan, raw_inf, max_exp, a64;                 =
  \
     int bias;                                                           =
  \
-    int64_t exp =3D *((int64_t *)a);                                    =
    \
+    int64_t exp;                                                        =
  \
                                                                         =
  \
+    get_dfp64(&a64, a);                                                 =
  \
+    exp =3D (int64_t)a64;                                               =
    \
     dfp_prepare_decimal##size(&dfp, 0, b, env);                         =
  \
                                                                         =
  \
     if ((size) =3D=3D 64) {                                             =
      \
--=20
2.21.0


