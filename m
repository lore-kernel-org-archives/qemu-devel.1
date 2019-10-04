Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFD2C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 997712070B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DMJDvoQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 997712070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGKYR-0005VB-Sa
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 06:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2l-0005Qt-Hb
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2j-0005Y7-FV
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:35 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:59571)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iGK2i-0005AE-OX; Fri, 04 Oct 2019 05:38:33 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46l4YK25F0z9sRl; Fri,  4 Oct 2019 19:37:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570181877;
 bh=ODUVroHcw7bqpVKU/GVdfxZ08nfiOmzFG3I1ffK+QKU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DMJDvoQZI/bwt65Fsjfv0LedV7ch7P2bXaoSWpZIUmbM1zXqhM/nGpiil1OwdifQ4
 xmK4P/EU9kwmSxrsJVYkDx0JCD/rulBUMVtc8G4r7foZ7VeY81cKxwPA53JF1O6l1B
 np3+2mntqF+K3TEe71XxXub2bycKYua4Mp6bPxOo=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 23/53] target/ppc: introduce set_dfp{64, 128}() helper functions
Date: Fri,  4 Oct 2019 19:37:17 +1000
Message-Id: <20191004093747.31350-24-david@gibson.dropbear.id.au>
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
the DFP numbers directly, introduce set_dfp{64,128}() helper functions to=
 ease
the switch to the correct representation.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190926185801.11176-3-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/dfp_helper.c | 90 ++++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 42 deletions(-)

diff --git a/target/ppc/dfp_helper.c b/target/ppc/dfp_helper.c
index e4369ebe9b..3923a072b2 100644
--- a/target/ppc/dfp_helper.c
+++ b/target/ppc/dfp_helper.c
@@ -47,6 +47,17 @@ static void get_dfp128(uint64_t *dst, uint64_t *dfp)
     dst[1] =3D dfp[LO_IDX];
 }
=20
+static void set_dfp64(uint64_t *dfp, uint64_t *src)
+{
+    dfp[0] =3D src[0];
+}
+
+static void set_dfp128(uint64_t *dfp, uint64_t *src)
+{
+    dfp[0] =3D src[HI_IDX];
+    dfp[1] =3D src[LO_IDX];
+}
+
 struct PPC_DFP {
     CPUPPCState *env;
     uint64_t t64[2], a64[2], b64[2];
@@ -413,10 +424,9 @@ void helper_##op(CPUPPCState *env, uint64_t *t, uint=
64_t *a, uint64_t *b)      \
     decimal##size##FromNumber((decimal##size *)dfp.t64, &dfp.t, &dfp.con=
text); \
     postprocs(&dfp);                                                    =
       \
     if (size =3D=3D 64) {                                               =
           \
-        t[0] =3D dfp.t64[0];                                            =
         \
+        set_dfp64(t, dfp.t64);                                          =
       \
     } else if (size =3D=3D 128) {                                       =
           \
-        t[0] =3D dfp.t64[HI_IDX];                                       =
         \
-        t[1] =3D dfp.t64[LO_IDX];                                       =
         \
+        set_dfp128(t, dfp.t64);                                         =
       \
     }                                                                   =
       \
 }
=20
@@ -735,10 +745,9 @@ void helper_##op(CPUPPCState *env, uint64_t *t, uint=
64_t *b,            \
     QUA_PPs(&dfp);                                                      =
\
                                                                         =
\
     if (size =3D=3D 64) {                                               =
    \
-        t[0] =3D dfp.t64[0];                                            =
  \
+        set_dfp64(t, dfp.t64);                                          =
\
     } else if (size =3D=3D 128) {                                       =
    \
-        t[0] =3D dfp.t64[HI_IDX];                                       =
  \
-        t[1] =3D dfp.t64[LO_IDX];                                       =
  \
+        set_dfp128(t, dfp.t64);                                         =
\
     }                                                                   =
\
 }
=20
@@ -759,10 +768,9 @@ void helper_##op(CPUPPCState *env, uint64_t *t, uint=
64_t *a,            \
     QUA_PPs(&dfp);                                                      =
\
                                                                         =
\
     if (size =3D=3D 64) {                                               =
    \
-        t[0] =3D dfp.t64[0];                                            =
  \
+        set_dfp64(t, dfp.t64);                                          =
\
     } else if (size =3D=3D 128) {                                       =
    \
-        t[0] =3D dfp.t64[HI_IDX];                                       =
  \
-        t[1] =3D dfp.t64[LO_IDX];                                       =
  \
+        set_dfp128(t, dfp.t64);                                         =
\
     }                                                                   =
\
 }
=20
@@ -843,10 +851,9 @@ void helper_##op(CPUPPCState *env, uint64_t *t, uint=
64_t *a,            \
     QUA_PPs(&dfp);                                                      =
\
                                                                         =
\
     if (size =3D=3D 64) {                                               =
    \
-        t[0] =3D dfp.t64[0];                                            =
  \
+        set_dfp64(t, dfp.t64);                                          =
\
     } else if (size =3D=3D 128) {                                       =
    \
-        t[0] =3D dfp.t64[HI_IDX];                                       =
  \
-        t[1] =3D dfp.t64[LO_IDX];                                       =
  \
+        set_dfp128(t, dfp.t64);                                         =
\
     }                                                                   =
\
 }
=20
@@ -867,10 +874,9 @@ void helper_##op(CPUPPCState *env, uint64_t *t, uint=
64_t *b,                   \
     postprocs(&dfp);                                                    =
       \
                                                                         =
       \
     if (size =3D=3D 64) {                                               =
           \
-        t[0] =3D dfp.t64[0];                                            =
         \
+        set_dfp64(t, dfp.t64);                                          =
       \
     } else if (size =3D=3D 128) {                                       =
           \
-        t[0] =3D dfp.t64[HI_IDX];                                       =
         \
-        t[1] =3D dfp.t64[LO_IDX];                                       =
         \
+        set_dfp128(t, dfp.t64);                                         =
       \
     }                                                                   =
       \
 }
=20
@@ -904,7 +910,8 @@ void helper_dctdp(CPUPPCState *env, uint64_t *t, uint=
64_t *b)
=20
     dfp_prepare_decimal64(&dfp, 0, 0, env);
     decimal32ToNumber((decimal32 *)&b_short, &dfp.t);
-    decimal64FromNumber((decimal64 *)t, &dfp.t, &dfp.context);
+    decimal64FromNumber((decimal64 *)&dfp.t64, &dfp.t, &dfp.context);
+    set_dfp64(t, dfp.t64);
     dfp_set_FPRF_from_FRT(&dfp);
 }
=20
@@ -920,14 +927,14 @@ void helper_dctqpq(CPUPPCState *env, uint64_t *t, u=
int64_t *b)
     dfp_set_FPRF_from_FRT(&dfp);
=20
     decimal128FromNumber((decimal128 *)&dfp.t64, &dfp.t, &dfp.context);
-    t[0] =3D dfp.t64[HI_IDX];
-    t[1] =3D dfp.t64[LO_IDX];
+    set_dfp128(t, dfp.t64);
 }
=20
 void helper_drsp(CPUPPCState *env, uint64_t *t, uint64_t *b)
 {
     struct PPC_DFP dfp;
     uint32_t t_short =3D 0;
+    uint64_t t64;
     dfp_prepare_decimal64(&dfp, 0, b, env);
     decimal32FromNumber((decimal32 *)&t_short, &dfp.b, &dfp.context);
     decimal32ToNumber((decimal32 *)&t_short, &dfp.t);
@@ -937,7 +944,8 @@ void helper_drsp(CPUPPCState *env, uint64_t *t, uint6=
4_t *b)
     dfp_check_for_UX(&dfp);
     dfp_check_for_XX(&dfp);
=20
-    *t =3D t_short;
+    t64 =3D (uint64_t)t_short;
+    set_dfp64(t, &t64);
 }
=20
 void helper_drdpq(CPUPPCState *env, uint64_t *t, uint64_t *b)
@@ -953,9 +961,9 @@ void helper_drdpq(CPUPPCState *env, uint64_t *t, uint=
64_t *b)
     dfp_check_for_UX(&dfp);
     dfp_check_for_XX(&dfp);
=20
+    dfp.t64[0] =3D dfp.t64[1] =3D 0;
     decimal64FromNumber((decimal64 *)dfp.t64, &dfp.t, &dfp.context);
-    t[0] =3D dfp.t64[0];
-    t[1] =3D 0;
+    set_dfp128(t, dfp.t64);
 }
=20
 #define DFP_HELPER_CFFIX(op, size)                                      =
       \
@@ -970,10 +978,9 @@ void helper_##op(CPUPPCState *env, uint64_t *t, uint=
64_t *b)                   \
     CFFIX_PPs(&dfp);                                                    =
       \
                                                                         =
       \
     if (size =3D=3D 64) {                                               =
           \
-        t[0] =3D dfp.t64[0];                                            =
         \
+        set_dfp64(t, dfp.t64);                                          =
       \
     } else if (size =3D=3D 128) {                                       =
           \
-        t[0] =3D dfp.t64[HI_IDX];                                       =
         \
-        t[1] =3D dfp.t64[LO_IDX];                                       =
         \
+        set_dfp128(t, dfp.t64);                                         =
       \
     }                                                                   =
       \
 }
=20
@@ -1016,7 +1023,7 @@ void helper_##op(CPUPPCState *env, uint64_t *t, uin=
t64_t *b)                  \
         }                                                               =
      \
     }                                                                   =
      \
                                                                         =
      \
-    *t =3D dfp.t64[0];                                                  =
        \
+    set_dfp64(t, dfp.t64);                                              =
      \
 }
=20
 DFP_HELPER_CTFIX(dctfix, 64)
@@ -1078,10 +1085,9 @@ void helper_##op(CPUPPCState *env, uint64_t *t, ui=
nt64_t *b, uint32_t sp) \
     }                                                                   =
  \
                                                                         =
  \
     if (size =3D=3D 64) {                                               =
      \
-        t[0] =3D dfp.t64[0];                                            =
    \
+        set_dfp64(t, dfp.t64);                                          =
  \
     } else if (size =3D=3D 128) {                                       =
      \
-        t[0] =3D dfp.t64[HI_IDX];                                       =
    \
-        t[1] =3D dfp.t64[LO_IDX];                                       =
    \
+        set_dfp128(t, dfp.t64);                                         =
  \
     }                                                                   =
  \
 }
=20
@@ -1150,10 +1156,9 @@ void helper_##op(CPUPPCState *env, uint64_t *t, ui=
nt64_t *b, uint32_t s)     \
                               &dfp.context);                            =
     \
     dfp_set_FPRF_from_FRT(&dfp);                                        =
     \
     if ((size) =3D=3D 64) {                                             =
         \
-        t[0] =3D dfp.t64[0];                                            =
       \
+        set_dfp64(t, dfp.t64);                                          =
     \
     } else if ((size) =3D=3D 128) {                                     =
         \
-        t[0] =3D dfp.t64[HI_IDX];                                       =
       \
-        t[1] =3D dfp.t64[LO_IDX];                                       =
       \
+        set_dfp128(t, dfp.t64);                                         =
     \
     }                                                                   =
     \
 }
=20
@@ -1164,27 +1169,30 @@ DFP_HELPER_ENBCD(denbcdq, 128)
 void helper_##op(CPUPPCState *env, uint64_t *t, uint64_t *b)   \
 {                                                              \
     struct PPC_DFP dfp;                                        \
+    uint64_t t64;                                              \
                                                                \
     dfp_prepare_decimal##size(&dfp, 0, b, env);                \
                                                                \
     if (unlikely(decNumberIsSpecial(&dfp.b))) {                \
         if (decNumberIsInfinite(&dfp.b)) {                     \
-            *t =3D -1;                                           \
+            t64 =3D -1;                                          \
         } else if (decNumberIsSNaN(&dfp.b)) {                  \
-            *t =3D -3;                                           \
+            t64 =3D -3;                                          \
         } else if (decNumberIsQNaN(&dfp.b)) {                  \
-            *t =3D -2;                                           \
+            t64 =3D -2;                                          \
         } else {                                               \
             assert(0);                                         \
         }                                                      \
+        set_dfp64(t, &t64);                                    \
     } else {                                                   \
         if ((size) =3D=3D 64) {                                    \
-            *t =3D dfp.b.exponent + 398;                         \
+            t64 =3D dfp.b.exponent + 398;                        \
         } else if ((size) =3D=3D 128) {                            \
-            *t =3D dfp.b.exponent + 6176;                        \
+            t64 =3D dfp.b.exponent + 6176;                       \
         } else {                                               \
             assert(0);                                         \
         }                                                      \
+        set_dfp64(t, &t64);                                    \
     }                                                          \
 }
=20
@@ -1251,10 +1259,9 @@ void helper_##op(CPUPPCState *env, uint64_t *t, ui=
nt64_t *a, uint64_t *b) \
                                   &dfp.context);                        =
  \
     }                                                                   =
  \
     if (size =3D=3D 64) {                                               =
      \
-        t[0] =3D dfp.t64[0];                                            =
    \
+        set_dfp64(t, dfp.t64);                                          =
  \
     } else if (size =3D=3D 128) {                                       =
      \
-        t[0] =3D dfp.t64[HI_IDX];                                       =
    \
-        t[1] =3D dfp.t64[LO_IDX];                                       =
    \
+        set_dfp128(t, dfp.t64);                                         =
  \
     }                                                                   =
  \
 }
=20
@@ -1344,10 +1351,9 @@ void helper_##op(CPUPPCState *env, uint64_t *t, ui=
nt64_t *a,        \
     }                                                               \
                                                                     \
     if ((size) =3D=3D 64) {                                             =
\
-        t[0] =3D dfp.t64[0];                                          \
+        set_dfp64(t, dfp.t64);                                      \
     } else {                                                        \
-        t[0] =3D dfp.t64[HI_IDX];                                     \
-        t[1] =3D dfp.t64[LO_IDX];                                     \
+        set_dfp128(t, dfp.t64);                                     \
     }                                                               \
 }
=20
--=20
2.21.0


