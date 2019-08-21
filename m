Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8029EC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:42:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DE9B2339F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="few4hEf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE9B2339F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0LFs-0006fC-Ma
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 03:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0M-0004TY-8n
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0K-0007zE-DD
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:02 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:38203)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0L0J-0007tA-Mv; Wed, 21 Aug 2019 03:26:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46Czj93d4qz9sPG; Wed, 21 Aug 2019 17:25:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566372349;
 bh=kYrwrHDGsqHYYDsnZUEggVz/9A6beTZ/ZYAXuq0uvho=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=few4hEf6HGQVUibWxSKAIWC0zpVrYywzGUUgAahA9Hd6rgpqOL5Ai78+QV8wsQd9d
 c5Gieri89OX4Sb7tMkWCtj3lXy+mxAzh2PVkTyaH2SqaW1n5g9ti/6m3H+0mJp2m5q
 Ae+KMdNG84nQ67WnzAGtI5ePKO5kXE55OF9gkf+4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 21 Aug 2019 17:25:07 +1000
Message-Id: <20190821072542.23090-8-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821072542.23090-1-david@gibson.dropbear.id.au>
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 07/42] target/ppc: Optimize emulation of vsl and
 vsr instructions
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
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 groug@kaod.org, qemu-ppc@nongnu.org,
 Stefan Brankovic <stefan.brankovic@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Brankovic <stefan.brankovic@rt-rk.com>

Optimization of altivec instructions vsl and vsr(Vector Shift Left/Rigt).
Perform shift operation (left and right respectively) on 128 bit value of
register vA by value specified in bits 125-127 of register vB. Lowest 3
bits in each byte element of register vB must be identical or result is
undefined.

For vsl instruction, the first step is bits 125-127 of register vB have
to be saved in variable sh. Then, the highest sh bits of the lower
doubleword element of register vA are saved in variable shifted,
in order not to lose those bits when shift operation is performed on
the lower doubleword element of register vA, which is the next
step. After shifting the lower doubleword element shift operation
is performed on higher doubleword element of vA, with replacement of
the lowest sh bits(that are now 0) with bits saved in shifted.

For vsr instruction, firstly, the bits 125-127 of register vB have
to be saved in variable sh. Then, the lowest sh bits of the higher
doubleword element of register vA are saved in variable shifted,
in odred not to lose those bits when the shift operation is
performed on the higher doubleword element of register vA, which is
the next step. After shifting higher doubleword element, shift operation
is performed on lower doubleword element of vA, with replacement of
highest sh bits(that are now 0) with bits saved in shifted.

Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <1563200574-11098-3-git-send-email-stefan.brankovic@rt-rk.com=
>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h                 |   2 -
 target/ppc/int_helper.c             |  35 ----------
 target/ppc/translate/vmx-impl.inc.c | 101 +++++++++++++++++++++++++++-
 3 files changed, 99 insertions(+), 39 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 121d7868d0..6fb823c7b4 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -217,8 +217,6 @@ DEF_HELPER_3(vrlb, void, avr, avr, avr)
 DEF_HELPER_3(vrlh, void, avr, avr, avr)
 DEF_HELPER_3(vrlw, void, avr, avr, avr)
 DEF_HELPER_3(vrld, void, avr, avr, avr)
-DEF_HELPER_3(vsl, void, avr, avr, avr)
-DEF_HELPER_3(vsr, void, avr, avr, avr)
 DEF_HELPER_4(vsldoi, void, avr, avr, avr, i32)
 DEF_HELPER_3(vextractub, void, avr, avr, i32)
 DEF_HELPER_3(vextractuh, void, avr, avr, i32)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 5dcca5362b..d2cad787ad 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1740,41 +1740,6 @@ VEXTU_X_DO(vextuhrx, 16, 0)
 VEXTU_X_DO(vextuwrx, 32, 0)
 #undef VEXTU_X_DO
=20
-/*
- * The specification says that the results are undefined if all of the
- * shift counts are not identical.  We check to make sure that they
- * are to conform to what real hardware appears to do.
- */
-#define VSHIFT(suffix, leftp)                                           =
\
-    void helper_vs##suffix(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)    =
\
-    {                                                                   =
\
-        int shift =3D b->VsrB(15) & 0x7;                                =
  \
-        int doit =3D 1;                                                 =
  \
-        int i;                                                          =
\
-                                                                        =
\
-        for (i =3D 0; i < ARRAY_SIZE(r->u8); i++) {                     =
  \
-            doit =3D doit && ((b->u8[i] & 0x7) =3D=3D shift);           =
      \
-        }                                                               =
\
-        if (doit) {                                                     =
\
-            if (shift =3D=3D 0) {                                       =
    \
-                *r =3D *a;                                              =
  \
-            } else if (leftp) {                                         =
\
-                uint64_t carry =3D a->VsrD(1) >> (64 - shift);          =
  \
-                                                                        =
\
-                r->VsrD(0) =3D (a->VsrD(0) << shift) | carry;           =
  \
-                r->VsrD(1) =3D a->VsrD(1) << shift;                     =
  \
-            } else {                                                    =
\
-                uint64_t carry =3D a->VsrD(0) << (64 - shift);          =
  \
-                                                                        =
\
-                r->VsrD(1) =3D (a->VsrD(1) >> shift) | carry;           =
  \
-                r->VsrD(0) =3D a->VsrD(0) >> shift;                     =
  \
-            }                                                           =
\
-        }                                                               =
\
-    }
-VSHIFT(l, 1)
-VSHIFT(r, 0)
-#undef VSHIFT
-
 void helper_vslv(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     int i;
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
index a9fe3c7834..e06e65adb2 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -570,6 +570,103 @@ static void trans_lvsr(DisasContext *ctx)
     tcg_temp_free(EA);
 }
=20
+/*
+ * vsl VRT,VRA,VRB - Vector Shift Left
+ *
+ * Shifting left 128 bit value of vA by value specified in bits 125-127 =
of vB.
+ * Lowest 3 bits in each byte element of register vB must be identical o=
r
+ * result is undefined.
+ */
+static void trans_vsl(DisasContext *ctx)
+{
+    int VT =3D rD(ctx->opcode);
+    int VA =3D rA(ctx->opcode);
+    int VB =3D rB(ctx->opcode);
+    TCGv_i64 avrA =3D tcg_temp_new_i64();
+    TCGv_i64 avrB =3D tcg_temp_new_i64();
+    TCGv_i64 sh =3D tcg_temp_new_i64();
+    TCGv_i64 shifted =3D tcg_temp_new_i64();
+    TCGv_i64 tmp =3D tcg_temp_new_i64();
+
+    /* Place bits 125-127 of vB in sh. */
+    get_avr64(avrB, VB, false);
+    tcg_gen_andi_i64(sh, avrB, 0x07ULL);
+
+    /*
+     * Save highest sh bits of lower doubleword element of vA in variabl=
e
+     * shifted and perform shift on lower doubleword.
+     */
+    get_avr64(avrA, VA, false);
+    tcg_gen_subfi_i64(tmp, 64, sh);
+    tcg_gen_shr_i64(shifted, avrA, tmp);
+    tcg_gen_andi_i64(shifted, shifted, 0x7fULL);
+    tcg_gen_shl_i64(avrA, avrA, sh);
+    set_avr64(VT, avrA, false);
+
+    /*
+     * Perform shift on higher doubleword element of vA and replace lowe=
st
+     * sh bits with shifted.
+     */
+    get_avr64(avrA, VA, true);
+    tcg_gen_shl_i64(avrA, avrA, sh);
+    tcg_gen_or_i64(avrA, avrA, shifted);
+    set_avr64(VT, avrA, true);
+
+    tcg_temp_free_i64(avrA);
+    tcg_temp_free_i64(avrB);
+    tcg_temp_free_i64(sh);
+    tcg_temp_free_i64(shifted);
+    tcg_temp_free_i64(tmp);
+}
+
+/*
+ * vsr VRT,VRA,VRB - Vector Shift Right
+ *
+ * Shifting right 128 bit value of vA by value specified in bits 125-127=
 of vB.
+ * Lowest 3 bits in each byte element of register vB must be identical o=
r
+ * result is undefined.
+ */
+static void trans_vsr(DisasContext *ctx)
+{
+    int VT =3D rD(ctx->opcode);
+    int VA =3D rA(ctx->opcode);
+    int VB =3D rB(ctx->opcode);
+    TCGv_i64 avrA =3D tcg_temp_new_i64();
+    TCGv_i64 avrB =3D tcg_temp_new_i64();
+    TCGv_i64 sh =3D tcg_temp_new_i64();
+    TCGv_i64 shifted =3D tcg_temp_new_i64();
+    TCGv_i64 tmp =3D tcg_temp_new_i64();
+
+    /* Place bits 125-127 of vB in sh. */
+    get_avr64(avrB, VB, false);
+    tcg_gen_andi_i64(sh, avrB, 0x07ULL);
+
+    /*
+     * Save lowest sh bits of higher doubleword element of vA in variabl=
e
+     * shifted and perform shift on higher doubleword.
+     */
+    get_avr64(avrA, VA, true);
+    tcg_gen_subfi_i64(tmp, 64, sh);
+    tcg_gen_shl_i64(shifted, avrA, tmp);
+    tcg_gen_andi_i64(shifted, shifted, 0xfe00000000000000ULL);
+    tcg_gen_shr_i64(avrA, avrA, sh);
+    set_avr64(VT, avrA, true);
+    /*
+     * Perform shift on lower doubleword element of vA and replace highe=
st
+     * sh bits with shifted.
+     */
+    get_avr64(avrA, VA, false);
+    tcg_gen_shr_i64(avrA, avrA, sh);
+    tcg_gen_or_i64(avrA, avrA, shifted);
+    set_avr64(VT, avrA, false);
+
+    tcg_temp_free_i64(avrA);
+    tcg_temp_free_i64(avrB);
+    tcg_temp_free_i64(sh);
+    tcg_temp_free_i64(shifted);
+    tcg_temp_free_i64(tmp);
+}
+
 GEN_VXFORM(vmuloub, 4, 0);
 GEN_VXFORM(vmulouh, 4, 1);
 GEN_VXFORM(vmulouw, 4, 2);
@@ -682,11 +779,11 @@ GEN_VXFORM(vrld, 2, 3);
 GEN_VXFORM(vrldmi, 2, 3);
 GEN_VXFORM_DUAL(vrld, PPC_NONE, PPC2_ALTIVEC_207, \
                 vrldmi, PPC_NONE, PPC2_ISA300)
-GEN_VXFORM(vsl, 2, 7);
+GEN_VXFORM_TRANS(vsl, 2, 7);
 GEN_VXFORM(vrldnm, 2, 7);
 GEN_VXFORM_DUAL(vsl, PPC_ALTIVEC, PPC_NONE, \
                 vrldnm, PPC_NONE, PPC2_ISA300)
-GEN_VXFORM(vsr, 2, 11);
+GEN_VXFORM_TRANS(vsr, 2, 11);
 GEN_VXFORM_ENV(vpkuhum, 7, 0);
 GEN_VXFORM_ENV(vpkuwum, 7, 1);
 GEN_VXFORM_ENV(vpkudum, 7, 17);
--=20
2.21.0


