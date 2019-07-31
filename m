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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FE9C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:03:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229272067D
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4Mn1Z9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229272067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsswn-0005Q8-D1
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 14:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42754)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrE-0002DQ-IH
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrD-0002n1-8p
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:48 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:37570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hssrD-0002ln-48
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:47 -0400
Received: by mail-yb1-xb41.google.com with SMTP id i1so17409931ybo.4
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 10:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BTjCiZ+/q0ebvBZ9ZPiURBBWKzSYrYsZVU8BkSr9mlc=;
 b=E4Mn1Z9ZnifLm7HexQR82elARjWBp2hAqvyAxVNhWSMbM6O4x9/uVuQFWHB9/cGqSg
 n0i7Z37lLXyOUsqUZV22+iPZ+nDXUfWDkmEKu7VYTSeO2gysdUjcND90osQxt/EK/vIK
 WojaPIoEqvLIlsppLF8WpH6ELycBnTYEAzXyIlPei6vXrPmNDIWxcS+XLiAyZmQhrhUk
 n+2fuCbYdwivwih7xb36hsQ9ennmfe05F2jM27BcbEE8bRGEzMkcqsnjZ5JrOGiqPaxc
 sJR3LUfcBqm4JaZpBcMyEmcJKqHYK0lE6q8fAUZiee/0JOAu2FrbCxUZQmB2xxxl3saZ
 JenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BTjCiZ+/q0ebvBZ9ZPiURBBWKzSYrYsZVU8BkSr9mlc=;
 b=DQCKcMqkm++xO27iMEKl9ctO44skXepuPn5Tj0+7fORw1IMyUcZLkWuLEww6283FaC
 XrPfX0lM+Tcs6JAzOoh69aSmTRM9+g8C0z5aHpAr9xYGNzYL5Blgv/fuzsKcWRyUZ6Sp
 VhC0pzcxIdK530ycb/kPXA+KGuyiKY1y1f54IN9/1OPsWHbidPI/gaQDDcNuuAREntYT
 6GH2XKZoPxT17iDAJ3kWjcFWl0hFj4uV8GSwGgWoDDVGTm2P9ifKV1yBfnzTIASp64jt
 MTUV7Dw+ybavpovHG9gb2qpKmzLdSXrtX4xxi4bkT8tTvwgVzx2VuRX5aRBapH7jPYaa
 qXvw==
X-Gm-Message-State: APjAAAVn+LXXr+LLsK6GU+dtgbJlvlTW1buXiHaO1rJ+5XQYFw/jfiXK
 boAfvLi84WOM8/+yvlVJXFRIwaku
X-Google-Smtp-Source: APXvYqyrp6O+WFpQDg30ET7y7mlacjPA1PRBIIFlYavR8dbBK4Y4RW9qP/Z+31iGwGdIVzC+4PUGOw==
X-Received: by 2002:a25:3b56:: with SMTP id i83mr9131321yba.39.1564595866403; 
 Wed, 31 Jul 2019 10:57:46 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id 206sm16077696ywk.44.2019.07.31.10.57.45
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 10:57:45 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:56:49 -0400
Message-Id: <20190731175702.4916-10-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731175702.4916-1-jan.bobek@gmail.com>
References: <20190731175702.4916-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: [Qemu-devel] [RFC PATCH v1 09/22] target/i386: reimplement (V)POR,
 (V)ORPS, (V)ORPD
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
 target/i386/ops_sse.h        |  2 --
 target/i386/ops_sse_header.h |  1 -
 target/i386/translate.c      | 27 +++++++++++++++++++++++++--
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index b3ba23287d..8b4ac9115e 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -354,7 +354,6 @@ static inline int satsw(int x)
 #define FMAXSW(a, b) ((int16_t)(a) > (int16_t)(b)) ? (a) : (b)
 
 #define FANDN(a, b) ((~(a)) & (b))
-#define FOR(a, b) ((a) | (b))
 #define FXOR(a, b) ((a) ^ (b))
 
 #define FCMPGTB(a, b) ((int8_t)(a) > (int8_t)(b) ? -1 : 0)
@@ -397,7 +396,6 @@ SSE_HELPER_W(helper_pminsw, FMINSW)
 SSE_HELPER_W(helper_pmaxsw, FMAXSW)
 
 SSE_HELPER_Q(helper_pandn, FANDN)
-SSE_HELPER_Q(helper_por, FOR)
 SSE_HELPER_Q(helper_pxor, FXOR)
 
 SSE_HELPER_B(helper_pcmpgtb, FCMPGTB)
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index 63b4376389..6a732ee489 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -87,7 +87,6 @@ SSE_HELPER_W(pminsw, FMINSW)
 SSE_HELPER_W(pmaxsw, FMAXSW)
 
 SSE_HELPER_Q(pandn, FANDN)
-SSE_HELPER_Q(por, FOR)
 SSE_HELPER_Q(pxor, FXOR)
 
 SSE_HELPER_B(pcmpgtb, FCMPGTB)
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 3821733a4e..28cd84432d 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2758,7 +2758,7 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0x53] = { gen_helper_rcpps, NULL, gen_helper_rcpss, NULL },
     [0x54] = { SSE_TOMBSTONE, SSE_TOMBSTONE }, /* andps, andpd */
     [0x55] = { gen_helper_pandn_xmm, gen_helper_pandn_xmm }, /* andnps, andnpd */
-    [0x56] = { gen_helper_por_xmm, gen_helper_por_xmm }, /* orps, orpd */
+    [0x56] = { SSE_TOMBSTONE, SSE_TOMBSTONE }, /* orps, orpd */
     [0x57] = { gen_helper_pxor_xmm, gen_helper_pxor_xmm }, /* xorps, xorpd */
     [0x58] = SSE_FOP(add),
     [0x59] = SSE_FOP(mul),
@@ -2841,7 +2841,7 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0xe8] = MMX_OP2(psubsb),
     [0xe9] = MMX_OP2(psubsw),
     [0xea] = MMX_OP2(pminsw),
-    [0xeb] = MMX_OP2(por),
+    [0xeb] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0xec] = MMX_OP2(paddsb),
     [0xed] = MMX_OP2(paddsw),
     [0xee] = MMX_OP2(pmaxsw),
@@ -3177,6 +3177,17 @@ static inline void gen_gvec_ld_modrm_3(CPUX86State *env, DisasContext *s,
 #define gen_vandpd_xmm gen_vpand_xmm
 #define gen_vandpd_ymm gen_vpand_ymm
 
+#define gen_por_mm(env, s, modrm)   gen_gvec_ld_modrm_mm  ((env), (s), (modrm), MO_64, tcg_gen_gvec_or, 0112)
+#define gen_por_xmm(env, s, modrm)  gen_gvec_ld_modrm_xmm ((env), (s), (modrm), MO_64, tcg_gen_gvec_or, 0112)
+#define gen_vpor_xmm(env, s, modrm) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), MO_64, tcg_gen_gvec_or, 0123)
+#define gen_vpor_ymm(env, s, modrm) gen_gvec_ld_modrm_vymm((env), (s), (modrm), MO_64, tcg_gen_gvec_or, 0123)
+#define gen_orps_xmm  gen_por_xmm
+#define gen_vorps_xmm gen_vpor_xmm
+#define gen_vorps_ymm gen_vpor_ymm
+#define gen_orpd_xmm  gen_por_xmm
+#define gen_vorpd_xmm gen_vpor_xmm
+#define gen_vorpd_ymm gen_vpor_ymm
+
 static void gen_sse(CPUX86State *env, DisasContext *s, int b)
 {
     int b1, op1_offset, op2_offset, is_xmm, val;
@@ -3278,6 +3289,18 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
     case 0x54 | M_0F | P_66:           gen_andpd_xmm(env, s, modrm); return;
     case 0x54 | M_0F | P_66 | VEX_128: gen_vandpd_xmm(env, s, modrm); return;
     case 0x54 | M_0F | P_66 | VEX_256: gen_vandpd_ymm(env, s, modrm); return;
+
+    case 0xeb | M_0F:                  gen_por_mm(env, s, modrm); return;
+    case 0xeb | M_0F | P_66:           gen_por_xmm(env, s, modrm); return;
+    case 0xeb | M_0F | P_66 | VEX_128: gen_vpor_xmm(env, s, modrm); return;
+    case 0xeb | M_0F | P_66 | VEX_256: gen_vpor_ymm(env, s, modrm); return;
+    case 0x56 | M_0F:                  gen_orps_xmm(env, s, modrm); return;
+    case 0x56 | M_0F | VEX_128:        gen_vorps_xmm(env, s, modrm); return;
+    case 0x56 | M_0F | VEX_256:        gen_vorps_ymm(env, s, modrm); return;
+    case 0x56 | M_0F | P_66:           gen_orpd_xmm(env, s, modrm); return;
+    case 0x56 | M_0F | P_66 | VEX_128: gen_vorpd_xmm(env, s, modrm); return;
+    case 0x56 | M_0F | P_66 | VEX_256: gen_vorpd_ymm(env, s, modrm); return;
+
     default: break;
     }
 
-- 
2.20.1


