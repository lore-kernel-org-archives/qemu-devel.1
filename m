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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46594C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 126DB206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhSCtG76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126DB206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hssvg-0003FS-Ay
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 14:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42773)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrF-0002FF-6w
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrE-0002nx-0z
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:49 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:45781)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hssrD-0002nc-Sj
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:47 -0400
Received: by mail-yb1-xb41.google.com with SMTP id s41so2569800ybe.12
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 10:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ecO/M3gLvEyQeFxd5TUkSAfubfu0V6F9TjGpO7Vv5Qk=;
 b=XhSCtG76twJN6GejJTLQcqo9JSNGGSrUAVj+RS5LYvVEjneSG/ZPuBlgFK/jKsxtM2
 vL14vxGi6Y/+dln6ffPbxosbNJ/l40RQ4f4WppOm4TwyjDYzWma07Wa8+4+oM+HV/vw+
 N8Ttz/nzB2SkzG/gJHRGdMpAvYxqohevHmh4klR9ELOjMY97YL3AbdYIOr4D1/NaFncE
 CUivNIu4MOtb5e3/zktEKEGADH8kmop6lPxv19vrJq/Vp37CygIEqgEtaCqF5jK29/4s
 xLdw4GW19jV1XJi6LEBuIXWGv1x/l/svTj1IxTlglh2kmaIl40Hj+0TXXPL+PwL6CRe6
 dnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ecO/M3gLvEyQeFxd5TUkSAfubfu0V6F9TjGpO7Vv5Qk=;
 b=N6+b+hyTYs+0SN0Q96gx6pyGVEXNM2UekgLmQ4WUXhVoxPGRA2fQTrAWnuIHr6iJe8
 5/PRCL9nVdpKJeICKe7JFaLN7CjcIEOxAgGGuavgqmPjBlCfFwHSuHOC2exyZB/Ibg1z
 xB9JTXGOWJgodqVZg4bvo4Bw3v+bv/DpRZuzDY5yliS4nJX4izCXat5DpQAtp2TcUMR/
 7CLsR6lfxVIkld0JW6O50uCFgBXE/LwdPuL/ak6bWYcilk+4zcKoVmRpXRlq6TRZohne
 WUvx78rZTDxzhAU2HvHVFygclWiwcVEdsbEiaYXGBka7H4/Evnm3MBeatjVMbluJybbZ
 Kb+Q==
X-Gm-Message-State: APjAAAWRJqmJQE6to+6OWXNRKAlgO1IaSogXQHlgfQdP26iMe7ZiyqHL
 JHnwOcjUXzx1/6IYdVuPzFb1lj3e
X-Google-Smtp-Source: APXvYqz6eOq+UTlRakWlYarhoPZzub+PaQuLOE9vSLFAEDr0bZ9FdMt1gQQt/JZ0MNU/4+Iuzi7yAQ==
X-Received: by 2002:a25:bd0f:: with SMTP id f15mr79210758ybk.151.1564595867174; 
 Wed, 31 Jul 2019 10:57:47 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id 206sm16077696ywk.44.2019.07.31.10.57.46
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 10:57:46 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:56:50 -0400
Message-Id: <20190731175702.4916-11-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731175702.4916-1-jan.bobek@gmail.com>
References: <20190731175702.4916-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: [Qemu-devel] [RFC PATCH v1 10/22] target/i386: reimplement (V)PXOR,
 (V)XORPS, (V)XORPD
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
 target/i386/translate.c      | 26 ++++++++++++++++++++++++--
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 8b4ac9115e..68dbeda047 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -354,7 +354,6 @@ static inline int satsw(int x)
 #define FMAXSW(a, b) ((int16_t)(a) > (int16_t)(b)) ? (a) : (b)
 
 #define FANDN(a, b) ((~(a)) & (b))
-#define FXOR(a, b) ((a) ^ (b))
 
 #define FCMPGTB(a, b) ((int8_t)(a) > (int8_t)(b) ? -1 : 0)
 #define FCMPGTW(a, b) ((int16_t)(a) > (int16_t)(b) ? -1 : 0)
@@ -396,7 +395,6 @@ SSE_HELPER_W(helper_pminsw, FMINSW)
 SSE_HELPER_W(helper_pmaxsw, FMAXSW)
 
 SSE_HELPER_Q(helper_pandn, FANDN)
-SSE_HELPER_Q(helper_pxor, FXOR)
 
 SSE_HELPER_B(helper_pcmpgtb, FCMPGTB)
 SSE_HELPER_W(helper_pcmpgtw, FCMPGTW)
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index 6a732ee489..a98b9f8f3f 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -87,7 +87,6 @@ SSE_HELPER_W(pminsw, FMINSW)
 SSE_HELPER_W(pmaxsw, FMAXSW)
 
 SSE_HELPER_Q(pandn, FANDN)
-SSE_HELPER_Q(pxor, FXOR)
 
 SSE_HELPER_B(pcmpgtb, FCMPGTB)
 SSE_HELPER_W(pcmpgtw, FCMPGTW)
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 28cd84432d..cfe285e3e5 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2759,7 +2759,7 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0x54] = { SSE_TOMBSTONE, SSE_TOMBSTONE }, /* andps, andpd */
     [0x55] = { gen_helper_pandn_xmm, gen_helper_pandn_xmm }, /* andnps, andnpd */
     [0x56] = { SSE_TOMBSTONE, SSE_TOMBSTONE }, /* orps, orpd */
-    [0x57] = { gen_helper_pxor_xmm, gen_helper_pxor_xmm }, /* xorps, xorpd */
+    [0x57] = { SSE_TOMBSTONE, SSE_TOMBSTONE }, /* xorps, xorpd */
     [0x58] = SSE_FOP(add),
     [0x59] = SSE_FOP(mul),
     [0x5a] = { gen_helper_cvtps2pd, gen_helper_cvtpd2ps,
@@ -2845,7 +2845,7 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0xec] = MMX_OP2(paddsb),
     [0xed] = MMX_OP2(paddsw),
     [0xee] = MMX_OP2(pmaxsw),
-    [0xef] = MMX_OP2(pxor),
+    [0xef] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0xf0] = { NULL, NULL, NULL, SSE_SPECIAL }, /* lddqu */
     [0xf1] = MMX_OP2(psllw),
     [0xf2] = MMX_OP2(pslld),
@@ -3188,6 +3188,17 @@ static inline void gen_gvec_ld_modrm_3(CPUX86State *env, DisasContext *s,
 #define gen_vorpd_xmm gen_vpor_xmm
 #define gen_vorpd_ymm gen_vpor_ymm
 
+#define gen_pxor_mm(env, s, modrm)   gen_gvec_ld_modrm_mm  ((env), (s), (modrm), MO_64, tcg_gen_gvec_xor, 0112)
+#define gen_pxor_xmm(env, s, modrm)  gen_gvec_ld_modrm_xmm ((env), (s), (modrm), MO_64, tcg_gen_gvec_xor, 0112)
+#define gen_vpxor_xmm(env, s, modrm) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), MO_64, tcg_gen_gvec_xor, 0123)
+#define gen_vpxor_ymm(env, s, modrm) gen_gvec_ld_modrm_vymm((env), (s), (modrm), MO_64, tcg_gen_gvec_xor, 0123)
+#define gen_xorps_xmm  gen_pxor_xmm
+#define gen_vxorps_xmm gen_vpxor_xmm
+#define gen_vxorps_ymm gen_vpxor_ymm
+#define gen_xorpd_xmm  gen_pxor_xmm
+#define gen_vxorpd_xmm gen_vpxor_xmm
+#define gen_vxorpd_ymm gen_vpxor_ymm
+
 static void gen_sse(CPUX86State *env, DisasContext *s, int b)
 {
     int b1, op1_offset, op2_offset, is_xmm, val;
@@ -3301,6 +3312,17 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
     case 0x56 | M_0F | P_66 | VEX_128: gen_vorpd_xmm(env, s, modrm); return;
     case 0x56 | M_0F | P_66 | VEX_256: gen_vorpd_ymm(env, s, modrm); return;
 
+    case 0xef | M_0F:                  gen_pxor_mm(env, s, modrm); return;
+    case 0xef | M_0F | P_66:           gen_pxor_xmm(env, s, modrm); return;
+    case 0xef | M_0F | P_66 | VEX_128: gen_vpxor_xmm(env, s, modrm); return;
+    case 0xef | M_0F | P_66 | VEX_256: gen_vpxor_ymm(env, s, modrm); return;
+    case 0x57 | M_0F:                  gen_xorps_xmm(env, s, modrm); return;
+    case 0x57 | M_0F | VEX_128:        gen_vxorps_xmm(env, s, modrm); return;
+    case 0x57 | M_0F | VEX_256:        gen_vxorps_ymm(env, s, modrm); return;
+    case 0x57 | M_0F | P_66:           gen_xorpd_xmm(env, s, modrm); return;
+    case 0x57 | M_0F | P_66 | VEX_128: gen_vxorpd_xmm(env, s, modrm); return;
+    case 0x57 | M_0F | P_66 | VEX_256: gen_vxorpd_ymm(env, s, modrm); return;
+
     default: break;
     }
 
-- 
2.20.1


