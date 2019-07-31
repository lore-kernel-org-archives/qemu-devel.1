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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AAEC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:01:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5821D206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uI/rhecQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5821D206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hssux-0001xI-IW
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 14:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42737)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrD-0002Am-Mq
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrC-0002kj-Bu
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:47 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:43095)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hssrC-0002kK-6t
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:46 -0400
Received: by mail-yw1-xc42.google.com with SMTP id n205so25261520ywb.10
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 10:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4d3RfxvWrL3pS5CIKpyaSSwwN3flwpgu4uNrI6R0JKY=;
 b=uI/rhecQG8ykYxRJMYkNLXgoe4c5jUJuFVqjw2w1nWzzA8XpjDX9XVbqG68C0iMIj4
 A/hkGID8rc1fcDjfT6i2dW604FrcJAA8+2solVJiABsbhW0+TQwD1FhQPwHYt6ifApNE
 5rIvEA4jRT/uSA5NJhXSrf8MPvoCmZDG5KVT9KXgmlW1q8f2wv0bPUk/uaPP1KNNI8QQ
 28nGqJMlmN9PwmCecDA4tFSqIdhGLKjZ1n9RwNjzMefugc+PPsVtp5ma6sv0uSanB2Hp
 XdWfc0UjZgaCMTvcqvaTkEEsLCbMaHBNp2YLOc18HvASFfbKYU6DLw2t3UkGBQg6nGDZ
 4hkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4d3RfxvWrL3pS5CIKpyaSSwwN3flwpgu4uNrI6R0JKY=;
 b=TFVY5GKy7yiUCy0al2wL2B3WmJZDo+vS3IbEYkLvhpfBlZXCpj/+WYDPBD59dySmJa
 1V0auWxXGFlAh13YFokGodZ1DDy0r4xd97BA0zaNBA9MXN/gYM4TKp/3nHK8/nC2+DFd
 fku7LLTmvNGsZr0ywgMYR7X9/kPN2Ri77uOU/AE5vWEBC+cLjnC2B5TmPujHGPrQmprs
 R8fWrl91NjDhg7iScFztahZvBxQ6lgKaoyJ5ZJ7LTuKZN/Q83cEirrdLdi5JrgN0ZhAf
 Bz4NNC/J1ZRUPMLuEoYlxLD0EELZdynqlZFSlsC2J2aDZqfWum20q4PGIdLnE8BCa5ND
 8Snw==
X-Gm-Message-State: APjAAAURdoo82m6wKfu+l9djy0+MlRkvRvGCLCfNB3PH+qBoyG4BYnRe
 XZI0/RsD8BnE9u+SsY7sEuAqxZsW
X-Google-Smtp-Source: APXvYqz/esu6UpTPlXvA00D6ddh4n6eqyyCCl7R8/vY14vk/XXIdcnuEgisIOYsCwFq/AF22dEmhhQ==
X-Received: by 2002:a81:70d0:: with SMTP id
 l199mr78458053ywc.397.1564595865571; 
 Wed, 31 Jul 2019 10:57:45 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id 206sm16077696ywk.44.2019.07.31.10.57.44
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 10:57:45 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:56:48 -0400
Message-Id: <20190731175702.4916-9-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731175702.4916-1-jan.bobek@gmail.com>
References: <20190731175702.4916-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
Subject: [Qemu-devel] [RFC PATCH v1 08/22] target/i386: reimplement (V)PAND,
 (V)ANDPS, (V)ANDPD
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

Note: This commit adds several bits which will not be part of the
final patch series and which are only present to allow for incremenal
write-and-test development cycle. Notably, the SSE_TOMBSTONE define
will go away entirely with all of the tables, and nothing will follow
the new dispatch switch in gen_sse.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/ops_sse.h        |  2 --
 target/i386/ops_sse_header.h |  1 -
 target/i386/translate.c      | 49 ++++++++++++++++++++++++++++++++++--
 3 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index ed05989768..b3ba23287d 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -353,7 +353,6 @@ static inline int satsw(int x)
 #define FMAXUB(a, b) ((a) > (b)) ? (a) : (b)
 #define FMAXSW(a, b) ((int16_t)(a) > (int16_t)(b)) ? (a) : (b)
 
-#define FAND(a, b) ((a) & (b))
 #define FANDN(a, b) ((~(a)) & (b))
 #define FOR(a, b) ((a) | (b))
 #define FXOR(a, b) ((a) ^ (b))
@@ -397,7 +396,6 @@ SSE_HELPER_B(helper_pmaxub, FMAXUB)
 SSE_HELPER_W(helper_pminsw, FMINSW)
 SSE_HELPER_W(helper_pmaxsw, FMAXSW)
 
-SSE_HELPER_Q(helper_pand, FAND)
 SSE_HELPER_Q(helper_pandn, FANDN)
 SSE_HELPER_Q(helper_por, FOR)
 SSE_HELPER_Q(helper_pxor, FXOR)
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index 094aafc573..63b4376389 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -86,7 +86,6 @@ SSE_HELPER_B(pmaxub, FMAXUB)
 SSE_HELPER_W(pminsw, FMINSW)
 SSE_HELPER_W(pmaxsw, FMAXSW)
 
-SSE_HELPER_Q(pand, FAND)
 SSE_HELPER_Q(pandn, FANDN)
 SSE_HELPER_Q(por, FOR)
 SSE_HELPER_Q(pxor, FXOR)
diff --git a/target/i386/translate.c b/target/i386/translate.c
index d576b3345c..3821733a4e 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -23,6 +23,7 @@
 #include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg-op.h"
+#include "tcg-op-gvec.h"
 #include "exec/cpu_ldst.h"
 #include "exec/translator.h"
 
@@ -2723,6 +2724,7 @@ typedef void (*SSEFunc_0_eppt)(TCGv_ptr env, TCGv_ptr reg_a, TCGv_ptr reg_b,
 
 #define SSE_SPECIAL ((void *)1)
 #define SSE_DUMMY ((void *)2)
+#define SSE_TOMBSTONE ((void *)3)
 
 #define MMX_OP2(x) { gen_helper_ ## x ## _mmx, gen_helper_ ## x ## _xmm }
 #define SSE_FOP(x) { gen_helper_ ## x ## ps, gen_helper_ ## x ## pd, \
@@ -2754,7 +2756,7 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0x51] = SSE_FOP(sqrt),
     [0x52] = { gen_helper_rsqrtps, NULL, gen_helper_rsqrtss, NULL },
     [0x53] = { gen_helper_rcpps, NULL, gen_helper_rcpss, NULL },
-    [0x54] = { gen_helper_pand_xmm, gen_helper_pand_xmm }, /* andps, andpd */
+    [0x54] = { SSE_TOMBSTONE, SSE_TOMBSTONE }, /* andps, andpd */
     [0x55] = { gen_helper_pandn_xmm, gen_helper_pandn_xmm }, /* andnps, andnpd */
     [0x56] = { gen_helper_por_xmm, gen_helper_por_xmm }, /* orps, orpd */
     [0x57] = { gen_helper_pxor_xmm, gen_helper_pxor_xmm }, /* xorps, xorpd */
@@ -2823,7 +2825,7 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0xd8] = MMX_OP2(psubusb),
     [0xd9] = MMX_OP2(psubusw),
     [0xda] = MMX_OP2(pminub),
-    [0xdb] = MMX_OP2(pand),
+    [0xdb] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0xdc] = MMX_OP2(paddusb),
     [0xdd] = MMX_OP2(paddusw),
     [0xde] = MMX_OP2(pmaxub),
@@ -3164,6 +3166,17 @@ static inline void gen_gvec_ld_modrm_3(CPUX86State *env, DisasContext *s,
                         gen_ld_modrm_VxHxWx,                            \
                         gen_gvec_2_fp, (opctl))
 
+#define gen_pand_mm(env, s, modrm)   gen_gvec_ld_modrm_mm  ((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0112)
+#define gen_pand_xmm(env, s, modrm)  gen_gvec_ld_modrm_xmm ((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0112)
+#define gen_vpand_xmm(env, s, modrm) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0123)
+#define gen_vpand_ymm(env, s, modrm) gen_gvec_ld_modrm_vymm((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0123)
+#define gen_andps_xmm  gen_pand_xmm
+#define gen_vandps_xmm gen_vpand_xmm
+#define gen_vandps_ymm gen_vpand_ymm
+#define gen_andpd_xmm  gen_pand_xmm
+#define gen_vandpd_xmm gen_vpand_xmm
+#define gen_vandpd_ymm gen_vpand_ymm
+
 static void gen_sse(CPUX86State *env, DisasContext *s, int b)
 {
     int b1, op1_offset, op2_offset, is_xmm, val;
@@ -3238,6 +3251,38 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
         reg |= REX_R(s);
     }
     mod = (modrm >> 6) & 3;
+
+    enum {
+        M_0F    = 0x01 << 8,
+        M_0F38  = 0x02 << 8,
+        M_0F3A  = 0x04 << 8,
+        P_66    = 0x08 << 8,
+        P_F3    = 0x10 << 8,
+        P_F2    = 0x20 << 8,
+        VEX_128 = 0x40 << 8,
+        VEX_256 = 0x80 << 8,
+    };
+
+    switch(b | M_0F
+           | (s->prefix & PREFIX_DATA ? P_66 : 0)
+           | (s->prefix & PREFIX_REPZ ? P_F3 : 0)
+           | (s->prefix & PREFIX_REPNZ ? P_F2 : 0)
+           | (s->prefix & PREFIX_VEX ? (s->vex_l ? VEX_256 : VEX_128) : 0)) {
+    case 0xdb | M_0F:                  gen_pand_mm(env, s, modrm); return;
+    case 0xdb | M_0F | P_66:           gen_pand_xmm(env, s, modrm); return;
+    case 0xdb | M_0F | P_66 | VEX_128: gen_vpand_xmm(env, s, modrm); return;
+    case 0xdb | M_0F | P_66 | VEX_256: gen_vpand_ymm(env, s, modrm); return;
+    case 0x54 | M_0F:                  gen_andps_xmm(env, s, modrm); return;
+    case 0x54 | M_0F | VEX_128:        gen_vandps_xmm(env, s, modrm); return;
+    case 0x54 | M_0F | VEX_256:        gen_vandps_ymm(env, s, modrm); return;
+    case 0x54 | M_0F | P_66:           gen_andpd_xmm(env, s, modrm); return;
+    case 0x54 | M_0F | P_66 | VEX_128: gen_vandpd_xmm(env, s, modrm); return;
+    case 0x54 | M_0F | P_66 | VEX_256: gen_vandpd_ymm(env, s, modrm); return;
+    default: break;
+    }
+
+    assert(sse_fn_epp != SSE_TOMBSTONE);
+
     if (sse_fn_epp == SSE_SPECIAL) {
         b |= (b1 << 8);
         switch(b) {
-- 
2.20.1


