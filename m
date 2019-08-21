Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CED7C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:32:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D99AA2332A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="NNuX0NB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99AA2332A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0L6z-0002qF-Gr
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 03:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0M-0004TE-3Q
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0K-0007z9-Cw
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:01 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:42071)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0L0J-0007sy-LE; Wed, 21 Aug 2019 03:26:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46Czj91gHVz9sND; Wed, 21 Aug 2019 17:25:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566372349;
 bh=W0SUWrowz5QUfB8a0jGTaV1ZYR7DK6nAsa+DrTnUQvc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NNuX0NB6n6B64qkQ0rMzBzAnRgxCR0trp/QjPHA7MS0CchZPSnPBJnqkqf1dHb6ht
 RKqtuelIJs4yhRZ9zljhaQHPJhb5F0/0u1GxVipUNnbXPMS1AGdYHmr1yUn90BE0FH
 pKuEXmwlgIKwCsNl9oJ6qzrl1/YGPXP9qMnAgFws=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 21 Aug 2019 17:25:10 +1000
Message-Id: <20190821072542.23090-11-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821072542.23090-1-david@gibson.dropbear.id.au>
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 10/42] target/ppc: Optimize emulation of vclzd
 instruction
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

Optimize Altivec instruction vclzd (Vector Count Leading Zeros Doubleword=
).
This instruction counts the number of leading zeros of each doubleword el=
ement
in source register and places result in the appropriate doubleword elemen=
t of
destination register.

Using tcg-s count leading zeros instruction two times(once for each
doubleword element of source register vB) and placing result in
appropriate doubleword element of destination register vD.

Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <1563200574-11098-6-git-send-email-stefan.brankovic@rt-rk.com=
>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h                 |  1 -
 target/ppc/int_helper.c             |  3 ---
 target/ppc/translate/vmx-impl.inc.c | 28 +++++++++++++++++++++++++++-
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 9b486a0c37..e203f76bf1 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -311,7 +311,6 @@ DEF_HELPER_4(vctsxs, void, env, avr, avr, i32)
 DEF_HELPER_2(vclzb, void, avr, avr)
 DEF_HELPER_2(vclzh, void, avr, avr)
 DEF_HELPER_2(vclzw, void, avr, avr)
-DEF_HELPER_2(vclzd, void, avr, avr)
 DEF_HELPER_2(vctzb, void, avr, avr)
 DEF_HELPER_2(vctzh, void, avr, avr)
 DEF_HELPER_2(vctzw, void, avr, avr)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index a265cb07c5..b82765db33 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1820,17 +1820,14 @@ VUPK(lsw, s64, s32, UPKLO)
 #define clzb(v) ((v) ? clz32((uint32_t)(v) << 24) : 8)
 #define clzh(v) ((v) ? clz32((uint32_t)(v) << 16) : 16)
 #define clzw(v) clz32((v))
-#define clzd(v) clz64((v))
=20
 VGENERIC_DO(clzb, u8)
 VGENERIC_DO(clzh, u16)
 VGENERIC_DO(clzw, u32)
-VGENERIC_DO(clzd, u64)
=20
 #undef clzb
 #undef clzh
 #undef clzw
-#undef clzd
=20
 #define ctzb(v) ((v) ? ctz32(v) : 8)
 #define ctzh(v) ((v) ? ctz32(v) : 16)
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
index 13153352e4..3372c2c3d3 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -742,6 +742,32 @@ static void trans_vgbbd(DisasContext *ctx)
     tcg_temp_free_i64(avr[1]);
 }
=20
+/*
+ * vclzd VRT,VRB - Vector Count Leading Zeros Doubleword
+ *
+ * Counting the number of leading zero bits of each doubleword element i=
n source
+ * register and placing result in appropriate doubleword element of dest=
ination
+ * register.
+ */
+static void trans_vclzd(DisasContext *ctx)
+{
+    int VT =3D rD(ctx->opcode);
+    int VB =3D rB(ctx->opcode);
+    TCGv_i64 avr =3D tcg_temp_new_i64();
+
+    /* high doubleword */
+    get_avr64(avr, VB, true);
+    tcg_gen_clzi_i64(avr, avr, 64);
+    set_avr64(VT, avr, true);
+
+    /* low doubleword */
+    get_avr64(avr, VB, false);
+    tcg_gen_clzi_i64(avr, avr, 64);
+    set_avr64(VT, avr, false);
+
+    tcg_temp_free_i64(avr);
+}
+
 GEN_VXFORM(vmuloub, 4, 0);
 GEN_VXFORM(vmulouh, 4, 1);
 GEN_VXFORM(vmulouw, 4, 2);
@@ -1258,7 +1284,7 @@ GEN_VAFORM_PAIRED(vmaddfp, vnmsubfp, 23)
 GEN_VXFORM_NOA(vclzb, 1, 28)
 GEN_VXFORM_NOA(vclzh, 1, 29)
 GEN_VXFORM_NOA(vclzw, 1, 30)
-GEN_VXFORM_NOA(vclzd, 1, 31)
+GEN_VXFORM_TRANS(vclzd, 1, 31)
 GEN_VXFORM_NOA_2(vnegw, 1, 24, 6)
 GEN_VXFORM_NOA_2(vnegd, 1, 24, 7)
 GEN_VXFORM_NOA_2(vextsb2w, 1, 24, 16)
--=20
2.21.0


