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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CB8C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:05:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4471206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjGwy4kb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4471206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hssyt-0000TV-1v
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 14:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42832)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrH-0002Lr-A0
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrG-0002qd-0K
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:51 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:46504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hssrF-0002pw-SG
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:49 -0400
Received: by mail-yb1-xb44.google.com with SMTP id a5so24731488ybo.13
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 10:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qOqDTxFtH/3YrZnFMnrtU1fae7f/i4Xpw9RfJj8CEIA=;
 b=WjGwy4kbutEvop+EAKk57CutipLQ838mde8k+PywgdSwCT57rX8Kbf5oT9Ju4tbhfq
 RFfQhKMWVnJmb2vQ4Xs+FAX/0RS7G/2ey0rvU72ryEqUvJPOl1tkSp0fJ55RN1xZ/c/a
 uKKKtmzp+xFDx6XgtzUSLH5nqUbeekPCutN3I8h3oN77NQ0hn+2HnCIFbVBp/LiXUiZ/
 EG0u69Z3ca6TYfBHEQaB00tPJmRtrFildamzVkjCZ14okvj6xil4wrQLY9Zrv+xEpBS3
 ASmJPiqNhS41rPfuWqkge078TaYapBhpm9cDR8y+u8Yi5BEpfdagOxs6oc3nEjodqNmT
 S+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qOqDTxFtH/3YrZnFMnrtU1fae7f/i4Xpw9RfJj8CEIA=;
 b=O9p4h1pc0hXz41JJ2OG5kWzS/8yQ4wrhVhaJC+eNU58N+g/BT4QOSj2N0j5nfnPow2
 MF5rzRKHNtWk8CadjYovrHyKRVnf6LK+Y49vZ2yZQQGf3Ceo5y+BlZWvIvru0xp7GZZg
 bCtct0Nj1DTYMrd2StxKf8cWaF3mXlVtzKf1VxVhIpsEp5OqsX5c9IhdzTG24oYdI1Cf
 taZKWb4Y81CV5ciFBh2m6PY9CATa2CkPEsn9y76Y099BXVbDNf1tI2NEah9FC4XwMqCR
 xrKCO1UXA0F+FnLyUK+pYKpzKOSet6nzg3IIzABTBonEshWfzJ+q3PIz0Qm8kJyXoXwb
 qQgw==
X-Gm-Message-State: APjAAAUR+YCNqokOY3PCcyXMDcOQPv3id/j9/3/5a9BW9xc2XWFzwnUc
 cn0m697Av8Nf2rh12glF91DKX0il
X-Google-Smtp-Source: APXvYqzxokb+SycQz1t1yMYEg3fsCqPydDjNuNyxYCSDA5ElksCFT0MHJq50oqap7i6+FKWhuSHfag==
X-Received: by 2002:a25:ba07:: with SMTP id t7mr16920323ybg.261.1564595869012; 
 Wed, 31 Jul 2019 10:57:49 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id 206sm16077696ywk.44.2019.07.31.10.57.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 10:57:48 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:56:53 -0400
Message-Id: <20190731175702.4916-14-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731175702.4916-1-jan.bobek@gmail.com>
References: <20190731175702.4916-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [RFC PATCH v1 13/22] target/i386: reimplement
 (V)PSUB(B, W, D, Q)
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
 target/i386/ops_sse_header.h |  5 -----
 target/i386/translate.c      | 33 +++++++++++++++++++++++++++++----
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 31a761a89a..59935a65be 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -342,7 +342,6 @@ static inline int satsw(int x)
 #define FADDSB(a, b) satsb((int8_t)(a) + (int8_t)(b))
 #define FADDSW(a, b) satsw((int16_t)(a) + (int16_t)(b))
 
-#define FSUB(a, b) ((a) - (b))
 #define FSUBUB(a, b) satub((a) - (b))
 #define FSUBUW(a, b) satuw((a) - (b))
 #define FSUBSB(a, b) satsb((int8_t)(a) - (int8_t)(b))
@@ -365,11 +364,6 @@ static inline int satsw(int x)
 #define FAVG(a, b) (((a) + (b) + 1) >> 1)
 #endif
 
-SSE_HELPER_B(helper_psubb, FSUB)
-SSE_HELPER_W(helper_psubw, FSUB)
-SSE_HELPER_L(helper_psubl, FSUB)
-SSE_HELPER_Q(helper_psubq, FSUB)
-
 SSE_HELPER_B(helper_paddusb, FADDUB)
 SSE_HELPER_B(helper_paddsb, FADDSB)
 SSE_HELPER_B(helper_psubusb, FSUBUB)
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index 5c69ab91d4..bcdbac99a0 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -60,11 +60,6 @@ DEF_HELPER_3(glue(pslldq, SUFFIX), void, env, Reg, Reg)
 #define SSE_HELPER_Q(name, F)\
     DEF_HELPER_3(glue(name, SUFFIX), void, env, Reg, Reg)
 
-SSE_HELPER_B(psubb, FSUB)
-SSE_HELPER_W(psubw, FSUB)
-SSE_HELPER_L(psubl, FSUB)
-SSE_HELPER_Q(psubq, FSUB)
-
 SSE_HELPER_B(paddusb, FADDUB)
 SSE_HELPER_B(paddsb, FADDSB)
 SSE_HELPER_B(psubusb, FSUBUB)
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 1dbeb49066..6f4dfd06a1 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2855,10 +2855,10 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0xf6] = MMX_OP2(psadbw),
     [0xf7] = { (SSEFunc_0_epp)gen_helper_maskmov_mmx,
                (SSEFunc_0_epp)gen_helper_maskmov_xmm }, /* XXX: casts */
-    [0xf8] = MMX_OP2(psubb),
-    [0xf9] = MMX_OP2(psubw),
-    [0xfa] = MMX_OP2(psubl),
-    [0xfb] = MMX_OP2(psubq),
+    [0xf8] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
+    [0xf9] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
+    [0xfa] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
+    [0xfb] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0xfc] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0xfd] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0xfe] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
@@ -3171,6 +3171,11 @@ static inline void gen_gvec_ld_modrm_3(CPUX86State *env, DisasContext *s,
 #define gen_vpadd_xmm(env, s, modrm, vece) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), (vece), tcg_gen_gvec_add, 0123)
 #define gen_vpadd_ymm(env, s, modrm, vece) gen_gvec_ld_modrm_vymm((env), (s), (modrm), (vece), tcg_gen_gvec_add, 0123)
 
+#define gen_psub_mm(env, s, modrm, vece)   gen_gvec_ld_modrm_mm  ((env), (s), (modrm), (vece), tcg_gen_gvec_sub, 0112)
+#define gen_psub_xmm(env, s, modrm, vece)  gen_gvec_ld_modrm_xmm ((env), (s), (modrm), (vece), tcg_gen_gvec_sub, 0112)
+#define gen_vpsub_xmm(env, s, modrm, vece) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), (vece), tcg_gen_gvec_sub, 0123)
+#define gen_vpsub_ymm(env, s, modrm, vece) gen_gvec_ld_modrm_vymm((env), (s), (modrm), (vece), tcg_gen_gvec_sub, 0123)
+
 #define gen_pand_mm(env, s, modrm)   gen_gvec_ld_modrm_mm  ((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0112)
 #define gen_pand_xmm(env, s, modrm)  gen_gvec_ld_modrm_xmm ((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0112)
 #define gen_vpand_xmm(env, s, modrm) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0123)
@@ -3326,6 +3331,26 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
     case 0xd4 | M_0F | P_66 | VEX_128: gen_vpadd_xmm(env, s, modrm, MO_64); return;
     case 0xd4 | M_0F | P_66 | VEX_256: gen_vpadd_ymm(env, s, modrm, MO_64); return;
 
+    case 0xf8 | M_0F:                  gen_psub_mm(env, s, modrm, MO_8); return;
+    case 0xf8 | M_0F | P_66:           gen_psub_xmm(env, s, modrm, MO_8); return;
+    case 0xf8 | M_0F | P_66 | VEX_128: gen_vpsub_xmm(env, s, modrm, MO_8); return;
+    case 0xf8 | M_0F | P_66 | VEX_256: gen_vpsub_ymm(env, s, modrm, MO_8); return;
+
+    case 0xf9 | M_0F:                  gen_psub_mm(env, s, modrm, MO_16); return;
+    case 0xf9 | M_0F | P_66:           gen_psub_xmm(env, s, modrm, MO_16); return;
+    case 0xf9 | M_0F | P_66 | VEX_128: gen_vpsub_xmm(env, s, modrm, MO_16); return;
+    case 0xf9 | M_0F | P_66 | VEX_256: gen_vpsub_ymm(env, s, modrm, MO_16); return;
+
+    case 0xfa | M_0F:                  gen_psub_mm(env, s, modrm, MO_32); return;
+    case 0xfa | M_0F | P_66:           gen_psub_xmm(env, s, modrm, MO_32); return;
+    case 0xfa | M_0F | P_66 | VEX_128: gen_vpsub_xmm(env, s, modrm, MO_32); return;
+    case 0xfa | M_0F | P_66 | VEX_256: gen_vpsub_ymm(env, s, modrm, MO_32); return;
+
+    case 0xfb | M_0F:                  gen_psub_mm(env, s, modrm, MO_64); return;
+    case 0xfb | M_0F | P_66:           gen_psub_xmm(env, s, modrm, MO_64); return;
+    case 0xfb | M_0F | P_66 | VEX_128: gen_vpsub_xmm(env, s, modrm, MO_64); return;
+    case 0xfb | M_0F | P_66 | VEX_256: gen_vpsub_ymm(env, s, modrm, MO_64); return;
+
     case 0xdb | M_0F:                  gen_pand_mm(env, s, modrm); return;
     case 0xdb | M_0F | P_66:           gen_pand_xmm(env, s, modrm); return;
     case 0xdb | M_0F | P_66 | VEX_128: gen_vpand_xmm(env, s, modrm); return;
-- 
2.20.1


