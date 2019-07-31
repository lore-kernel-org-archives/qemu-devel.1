Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB912C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:03:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7D42067D
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRiwfkX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7D42067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hssx2-00063p-Pc
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 14:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42899)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrJ-0002Uv-Iw
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrI-0002vH-Bs
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:53 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:43097)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hssrI-0002uZ-7U
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:52 -0400
Received: by mail-yw1-xc44.google.com with SMTP id n205so25261603ywb.10
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 10:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M4/3ExEjJuGXnyFh1NZkWxyCI3Eunoxw4SVaU+Tn7IU=;
 b=DRiwfkX7hrvoUzu//FKcV7gVS7rFEmpJClFrrrqabTZUQG4coRzu6cbLxfSL9yDp4Q
 FZ2BynZflTdelMA2HfsbSHjoNrS0c8Et1/+bvWxVUdHtTuhX3StvLBav4saDrRODNU2t
 1QNyoVR19MN+GT8UQG5jPofIRwVNFEGGFKCOA0FepTHXQx723kfu8Yvra9IsxDZ17bP/
 pAcIkpHOIGDlgjFbxnKqsnULHAklx4oeGJa2vxITOVIZRDiT1rAKQG9kL/dT4zDFp6Cl
 ErfXVedj0Njh8YFn9SM2oUlYRyWVqpcOti6GKwYBvQDMNA16FO7CccW93bAPJgLPn245
 S66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M4/3ExEjJuGXnyFh1NZkWxyCI3Eunoxw4SVaU+Tn7IU=;
 b=qOCb0EAjyxT2ROjxPJQBn/51CdE7KeNu4RawHQJpx3KNkyF2qG7iK+WgBRLhxFwyfD
 TLmRi9EmUljsELOUO4x1BonS84Wu0NRFI9uGRMBmqY/0YXFLIi7OQPiimKGqu+8rhWTV
 eSn5Z42BH8LP2WY79JzQy46gSRTDn64qMfXnzBaPJ2BUkjjbUrkTkC3kAhTkmfnnTa0h
 E+qEw0medU5sXaEhzn2EQw9ZnwUpMWBEQq1kezsEHLcD3nD3c0cpvGT/E9Iu9hG5uNmt
 0pII2L5pX3XSKKQH9fNWlvdDf7unyw9ZfDCFvw4htzGlahn+TMtDcwnXjxBSMX9UXCjv
 fR3A==
X-Gm-Message-State: APjAAAXrjM9+zs07ElAXoTqKDFWKaLgFMTyzBBV6pV4WqwQ5CLrvzAbO
 fTEbG34O92qkPg4kRUleFVhmyZis
X-Google-Smtp-Source: APXvYqxd2CkGcmZ5eIkUZ+ApaKPQDXN2UkfqOSRObQpB25/nBqdQym/kSfq0RVoWgLVfp2zT4HSxNg==
X-Received: by 2002:a81:a186:: with SMTP id
 y128mr77236315ywg.128.1564595871611; 
 Wed, 31 Jul 2019 10:57:51 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id 206sm16077696ywk.44.2019.07.31.10.57.51
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 10:57:51 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:56:57 -0400
Message-Id: <20190731175702.4916-18-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731175702.4916-1-jan.bobek@gmail.com>
References: <20190731175702.4916-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [RFC PATCH v1 17/22] target/i386: reimplement
 (V)PSUBUS(B, W)
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jan Bobek <jan.bobek@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the gvec infrastructure to achieve the desired functionality.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/ops_sse.h        |  6 ------
 target/i386/ops_sse_header.h |  4 ----
 target/i386/translate.c      | 19 +++++++++++++++++--
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index f948adbc68..4f00f3273d 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -337,8 +337,6 @@ static inline int satsw(int x)
     }
 }
 
-#define FSUBUB(a, b) satub((a) - (b))
-#define FSUBUW(a, b) satuw((a) - (b))
 #define FMINUB(a, b) ((a) < (b)) ? (a) : (b)
 #define FMINSW(a, b) ((int16_t)(a) < (int16_t)(b)) ? (a) : (b)
 #define FMAXUB(a, b) ((a) > (b)) ? (a) : (b)
@@ -357,10 +355,6 @@ static inline int satsw(int x)
 #define FAVG(a, b) (((a) + (b) + 1) >> 1)
 #endif
 
-SSE_HELPER_B(helper_psubusb, FSUBUB)
-
-SSE_HELPER_W(helper_psubusw, FSUBUW)
-
 SSE_HELPER_B(helper_pminub, FMINUB)
 SSE_HELPER_B(helper_pmaxub, FMAXUB)
 
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index 20fb8aeccc..829c132ae4 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -60,10 +60,6 @@ DEF_HELPER_3(glue(pslldq, SUFFIX), void, env, Reg, Reg)
 #define SSE_HELPER_Q(name, F)\
     DEF_HELPER_3(glue(name, SUFFIX), void, env, Reg, Reg)
 
-SSE_HELPER_B(psubusb, FSUBUB)
-
-SSE_HELPER_W(psubusw, FSUBUW)
-
 SSE_HELPER_B(pminub, FMINUB)
 SSE_HELPER_B(pmaxub, FMAXUB)
 
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 894471861d..5b19e9ac4b 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2822,8 +2822,8 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0xd5] = MMX_OP2(pmullw),
     [0xd6] = { NULL, SSE_SPECIAL, SSE_SPECIAL, SSE_SPECIAL },
     [0xd7] = { SSE_SPECIAL, SSE_SPECIAL }, /* pmovmskb */
-    [0xd8] = MMX_OP2(psubusb),
-    [0xd9] = MMX_OP2(psubusw),
+    [0xd8] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
+    [0xd9] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0xda] = MMX_OP2(pminub),
     [0xdb] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0xdc] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
@@ -3191,6 +3191,11 @@ static inline void gen_gvec_ld_modrm_3(CPUX86State *env, DisasContext *s,
 #define gen_vpsubs_xmm(env, s, modrm, vece) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), (vece), tcg_gen_gvec_sssub, 0123)
 #define gen_vpsubs_ymm(env, s, modrm, vece) gen_gvec_ld_modrm_vymm((env), (s), (modrm), (vece), tcg_gen_gvec_sssub, 0123)
 
+#define gen_psubus_mm(env, s, modrm, vece)   gen_gvec_ld_modrm_mm  ((env), (s), (modrm), (vece), tcg_gen_gvec_ussub, 0112)
+#define gen_psubus_xmm(env, s, modrm, vece)  gen_gvec_ld_modrm_xmm ((env), (s), (modrm), (vece), tcg_gen_gvec_ussub, 0112)
+#define gen_vpsubus_xmm(env, s, modrm, vece) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), (vece), tcg_gen_gvec_ussub, 0123)
+#define gen_vpsubus_ymm(env, s, modrm, vece) gen_gvec_ld_modrm_vymm((env), (s), (modrm), (vece), tcg_gen_gvec_ussub, 0123)
+
 #define gen_pand_mm(env, s, modrm)   gen_gvec_ld_modrm_mm  ((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0112)
 #define gen_pand_xmm(env, s, modrm)  gen_gvec_ld_modrm_xmm ((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0112)
 #define gen_vpand_xmm(env, s, modrm) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0123)
@@ -3386,6 +3391,16 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
     case 0xfb | M_0F | P_66 | VEX_128: gen_vpsub_xmm(env, s, modrm, MO_64); return;
     case 0xfb | M_0F | P_66 | VEX_256: gen_vpsub_ymm(env, s, modrm, MO_64); return;
 
+    case 0xd8 | M_0F:                  gen_psubus_mm(env, s, modrm, MO_8); return;
+    case 0xd8 | M_0F | P_66:           gen_psubus_xmm(env, s, modrm, MO_8); return;
+    case 0xd8 | M_0F | P_66 | VEX_128: gen_vpsubus_xmm(env, s, modrm, MO_8); return;
+    case 0xd8 | M_0F | P_66 | VEX_256: gen_vpsubus_ymm(env, s, modrm, MO_8); return;
+
+    case 0xd9 | M_0F:                  gen_psubus_mm(env, s, modrm, MO_16); return;
+    case 0xd9 | M_0F | P_66:           gen_psubus_xmm(env, s, modrm, MO_16); return;
+    case 0xd9 | M_0F | P_66 | VEX_128: gen_vpsubus_xmm(env, s, modrm, MO_16); return;
+    case 0xd9 | M_0F | P_66 | VEX_256: gen_vpsubus_ymm(env, s, modrm, MO_16); return;
+
     case 0xe8 | M_0F:                  gen_psubs_mm(env, s, modrm, MO_8); return;
     case 0xe8 | M_0F | P_66:           gen_psubs_xmm(env, s, modrm, MO_8); return;
     case 0xe8 | M_0F | P_66 | VEX_128: gen_vpsubs_xmm(env, s, modrm, MO_8); return;
-- 
2.20.1


