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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C433BC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:05:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95045206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmgRbyuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95045206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hssz7-0001Nr-Rw
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 14:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42883)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrI-0002Rb-VG
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrH-0002tv-KH
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:52 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:36222)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hssrH-0002td-Fa
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:51 -0400
Received: by mail-yb1-xb42.google.com with SMTP id d9so18323478ybf.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 10:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lrmhZVG/ZO5RmiqtTQnFr3XryHW4Ewk2KiAQQytBZw0=;
 b=KmgRbyuCeElBJDKGlH8Np+hCNE9MP/r4H2Iw/d8T3IjRc4eL9MxGUpUUUA9HUufxX5
 RHCXj+qB7a/Ox+A56lYyZyqE39dthcx+wAt9xub8KxrniDKg67q/HhqIGNhV2sGaAvV8
 HBySGNaoA+5HQjSBXq/BqV6BcyocnPYb6aKvIezk7OaH7GTwzBes+IJgpVZ2t24/OILR
 kSGms4mmgZ5kQZc/3d+PiwTdM3qM5v0MD0G5HaGBe5eVMKlep3+ZyC+0GNAua40hcmMH
 oSvh772t0dd03uXKKvIVN1HD9SJ7bS7Qp7muSQjMGCDGXhDbmkIHrmYmbwchbzV+J2rq
 xAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lrmhZVG/ZO5RmiqtTQnFr3XryHW4Ewk2KiAQQytBZw0=;
 b=ZE66s0ZS68QylD+48/oMQDVYNYGCooCWXMjFvN6tKt00Dvg01mj12M8ThrQBQM1dhF
 +LS6Xsb+QQRn/fAqtkuHna4BGWeGrMft3xkOzPYiZr52p+cIdmSTAU5L3b+1K4OC4qEM
 I5bZdarblocfkWie6KVtlxOe34bFPbkt5w30UK95Q03N91ThD7SPYiCjKb0p1SV0oACD
 hfuB1WmQULTJ4TZBwYNHEJX9h2YIc2nbFlSuSCuCtUvwLuDP3kPM77dozweWC0hdB0oJ
 7ShjvS57UbU27tmHkckZ41kHjcbzH5cW8uk/3lMiLJ3s9rnmeGD1QX4RM8fOfA5Facxk
 z1Zg==
X-Gm-Message-State: APjAAAXbG9ejc3qO8DrDrrT15ULjHLBPoeQXI8WDHU46vPapcSBP5Kyw
 nacD/phmEnsKqRaLgnOhfKuDpIPI
X-Google-Smtp-Source: APXvYqy8j/pu+kh41Bu940KOf1gaCqbHQGZPIs4kEjYwbqat3dXEkEMwHmi9zZzASNb1b0AOT0CZCw==
X-Received: by 2002:a25:bb11:: with SMTP id z17mr69460876ybg.260.1564595870870; 
 Wed, 31 Jul 2019 10:57:50 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id 206sm16077696ywk.44.2019.07.31.10.57.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 10:57:50 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:56:56 -0400
Message-Id: <20190731175702.4916-17-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731175702.4916-1-jan.bobek@gmail.com>
References: <20190731175702.4916-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [RFC PATCH v1 16/22] target/i386: reimplement
 (V)PSUBS(B, W)
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
 target/i386/ops_sse.h        |  4 ----
 target/i386/ops_sse_header.h |  2 --
 target/i386/translate.c      | 19 +++++++++++++++++--
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 8c9b47fca4..f948adbc68 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -339,8 +339,6 @@ static inline int satsw(int x)
 
 #define FSUBUB(a, b) satub((a) - (b))
 #define FSUBUW(a, b) satuw((a) - (b))
-#define FSUBSB(a, b) satsb((int8_t)(a) - (int8_t)(b))
-#define FSUBSW(a, b) satsw((int16_t)(a) - (int16_t)(b))
 #define FMINUB(a, b) ((a) < (b)) ? (a) : (b)
 #define FMINSW(a, b) ((int16_t)(a) < (int16_t)(b)) ? (a) : (b)
 #define FMAXUB(a, b) ((a) > (b)) ? (a) : (b)
@@ -360,10 +358,8 @@ static inline int satsw(int x)
 #endif
 
 SSE_HELPER_B(helper_psubusb, FSUBUB)
-SSE_HELPER_B(helper_psubsb, FSUBSB)
 
 SSE_HELPER_W(helper_psubusw, FSUBUW)
-SSE_HELPER_W(helper_psubsw, FSUBSW)
 
 SSE_HELPER_B(helper_pminub, FMINUB)
 SSE_HELPER_B(helper_pmaxub, FMAXUB)
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index 8a31ade70c..20fb8aeccc 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -61,10 +61,8 @@ DEF_HELPER_3(glue(pslldq, SUFFIX), void, env, Reg, Reg)
     DEF_HELPER_3(glue(name, SUFFIX), void, env, Reg, Reg)
 
 SSE_HELPER_B(psubusb, FSUBUB)
-SSE_HELPER_B(psubsb, FSUBSB)
 
 SSE_HELPER_W(psubusw, FSUBUW)
-SSE_HELPER_W(psubsw, FSUBSW)
 
 SSE_HELPER_B(pminub, FMINUB)
 SSE_HELPER_B(pmaxub, FMAXUB)
diff --git a/target/i386/translate.c b/target/i386/translate.c
index e2ed8c20b3..894471861d 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2838,8 +2838,8 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0xe5] = MMX_OP2(pmulhw),
     [0xe6] = { NULL, gen_helper_cvttpd2dq, gen_helper_cvtdq2pd, gen_helper_cvtpd2dq },
     [0xe7] = { SSE_SPECIAL , SSE_SPECIAL },  /* movntq, movntq */
-    [0xe8] = MMX_OP2(psubsb),
-    [0xe9] = MMX_OP2(psubsw),
+    [0xe8] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
+    [0xe9] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0xea] = MMX_OP2(pminsw),
     [0xeb] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0xec] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
@@ -3186,6 +3186,11 @@ static inline void gen_gvec_ld_modrm_3(CPUX86State *env, DisasContext *s,
 #define gen_vpsub_xmm(env, s, modrm, vece) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), (vece), tcg_gen_gvec_sub, 0123)
 #define gen_vpsub_ymm(env, s, modrm, vece) gen_gvec_ld_modrm_vymm((env), (s), (modrm), (vece), tcg_gen_gvec_sub, 0123)
 
+#define gen_psubs_mm(env, s, modrm, vece)   gen_gvec_ld_modrm_mm  ((env), (s), (modrm), (vece), tcg_gen_gvec_sssub, 0112)
+#define gen_psubs_xmm(env, s, modrm, vece)  gen_gvec_ld_modrm_xmm ((env), (s), (modrm), (vece), tcg_gen_gvec_sssub, 0112)
+#define gen_vpsubs_xmm(env, s, modrm, vece) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), (vece), tcg_gen_gvec_sssub, 0123)
+#define gen_vpsubs_ymm(env, s, modrm, vece) gen_gvec_ld_modrm_vymm((env), (s), (modrm), (vece), tcg_gen_gvec_sssub, 0123)
+
 #define gen_pand_mm(env, s, modrm)   gen_gvec_ld_modrm_mm  ((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0112)
 #define gen_pand_xmm(env, s, modrm)  gen_gvec_ld_modrm_xmm ((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0112)
 #define gen_vpand_xmm(env, s, modrm) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0123)
@@ -3381,6 +3386,16 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
     case 0xfb | M_0F | P_66 | VEX_128: gen_vpsub_xmm(env, s, modrm, MO_64); return;
     case 0xfb | M_0F | P_66 | VEX_256: gen_vpsub_ymm(env, s, modrm, MO_64); return;
 
+    case 0xe8 | M_0F:                  gen_psubs_mm(env, s, modrm, MO_8); return;
+    case 0xe8 | M_0F | P_66:           gen_psubs_xmm(env, s, modrm, MO_8); return;
+    case 0xe8 | M_0F | P_66 | VEX_128: gen_vpsubs_xmm(env, s, modrm, MO_8); return;
+    case 0xe8 | M_0F | P_66 | VEX_256: gen_vpsubs_ymm(env, s, modrm, MO_8); return;
+
+    case 0xe9 | M_0F:                  gen_psubs_mm(env, s, modrm, MO_16); return;
+    case 0xe9 | M_0F | P_66:           gen_psubs_xmm(env, s, modrm, MO_16); return;
+    case 0xe9 | M_0F | P_66 | VEX_128: gen_vpsubs_xmm(env, s, modrm, MO_16); return;
+    case 0xe9 | M_0F | P_66 | VEX_256: gen_vpsubs_ymm(env, s, modrm, MO_16); return;
+
     case 0xdb | M_0F:                  gen_pand_mm(env, s, modrm); return;
     case 0xdb | M_0F | P_66:           gen_pand_xmm(env, s, modrm); return;
     case 0xdb | M_0F | P_66 | VEX_128: gen_vpand_xmm(env, s, modrm); return;
-- 
2.20.1


