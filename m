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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CB2C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0145F206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWumgjyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0145F206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hst0h-0004jf-7O
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 14:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43019)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrO-0002lP-6k
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrM-00038X-Hg
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:58 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:34189)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hssrM-00036y-CM
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:56 -0400
Received: by mail-yw1-xc41.google.com with SMTP id q128so25297435ywc.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 10:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oqUdiwvpgwp0hHDM9ysTSzyqe47m4ce56JCVOIeEHmY=;
 b=BWumgjyq0o/VcCVjotfjXxDGjA1iy36NneGBTFDswWdiwvmKS+Xt3LbPbNkJ1Emyou
 QJ0spsRD+HiUXk5b4bHdqdYUq3TbYwVzN23tO81/q2td2JsaaKFJQWd7mbaRj9ABC7fY
 EXxc47e4aUIIe+SzGSKVLpc+4JHX8QmDqZYPT1hHBgqaSB2SJfdf0hV/jFjsGCRFJW23
 C5OxdHurh1NgJQVHs8w8FUtpXL1EQ5nCHCKdWIh1eYZsc6S8WWCpoNZHC/01/mhsreHu
 5a1oPi7vABHGTtrrDbNqy5tuN6c2EvX/l2uiiBHbDcSgWuu/fvS/YazLuCEW/2LMGoMt
 HPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oqUdiwvpgwp0hHDM9ysTSzyqe47m4ce56JCVOIeEHmY=;
 b=bp8OuiSviW2J7MVWIS4I435/muE5a6Q9Yx93bbVKa9VNAqYtzcCEyatO0xHOAfmFHX
 F4F89n8c/kwTNXZMotZjWmfMmNGSWK0JxZ3/xJyUyFSKtfrIw51gDr4QDoh0XB8tGhAT
 saUhMoNRCBKopAjlHmzu43RteSrrZAvaJODjyrbe48BXypBcl4aYnpbrZyfVy0poICO8
 3N4mLvZ63r2hqz7JB46a4DopqElYPAowIWHzsP7GpJ70VEuJYz3t09Ms46Fz7dgLxS7S
 3s74Kq3tdhGNXhHtnO9vuNEGacIA/j8+2WLgZIOOdPYyG1WsnrQ5OW3qVO7WebDQmSxK
 WqRA==
X-Gm-Message-State: APjAAAX2ef/20+r9QGbistSl3rwWxbdRPsbgTvZ23g70N6nzsj0A7SuX
 dK8hqlo4zoGgsRtAUPr+jB/MK3po
X-Google-Smtp-Source: APXvYqwkfB9+RwHa+pFjdy4Eoz4FDaOxLyXqH43ffjEgJqfmIWTblMuSw0c7z9ARReKPBA3Jhw9CYA==
X-Received: by 2002:a81:a497:: with SMTP id
 b145mr70471253ywh.271.1564595875738; 
 Wed, 31 Jul 2019 10:57:55 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id 206sm16077696ywk.44.2019.07.31.10.57.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 10:57:55 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:57:02 -0400
Message-Id: <20190731175702.4916-23-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731175702.4916-1-jan.bobek@gmail.com>
References: <20190731175702.4916-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
Subject: [Qemu-devel] [RFC PATCH v1 22/22] target/i386: reimplement (V)P(EQ,
 CMP)(B, W, D)
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
 target/i386/ops_sse.h        | 13 -------
 target/i386/ops_sse_header.h |  8 -----
 target/i386/translate.c      | 66 ++++++++++++++++++++++++++++++++----
 3 files changed, 60 insertions(+), 27 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 75ff686bb6..b6ace9410f 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -337,11 +337,6 @@ static inline int satsw(int x)
     }
 }
 
-#define FCMPGTB(a, b) ((int8_t)(a) > (int8_t)(b) ? -1 : 0)
-#define FCMPGTW(a, b) ((int16_t)(a) > (int16_t)(b) ? -1 : 0)
-#define FCMPGTL(a, b) ((int32_t)(a) > (int32_t)(b) ? -1 : 0)
-#define FCMPEQ(a, b) ((a) == (b) ? -1 : 0)
-
 #define FMULLW(a, b) ((a) * (b))
 #define FMULHRW(a, b) (((int16_t)(a) * (int16_t)(b) + 0x8000) >> 16)
 #define FMULHUW(a, b) ((a) * (b) >> 16)
@@ -350,14 +345,6 @@ static inline int satsw(int x)
 #define FAVG(a, b) (((a) + (b) + 1) >> 1)
 #endif
 
-SSE_HELPER_B(helper_pcmpgtb, FCMPGTB)
-SSE_HELPER_W(helper_pcmpgtw, FCMPGTW)
-SSE_HELPER_L(helper_pcmpgtl, FCMPGTL)
-
-SSE_HELPER_B(helper_pcmpeqb, FCMPEQ)
-SSE_HELPER_W(helper_pcmpeqw, FCMPEQ)
-SSE_HELPER_L(helper_pcmpeql, FCMPEQ)
-
 SSE_HELPER_W(helper_pmullw, FMULLW)
 #if SHIFT == 0
 SSE_HELPER_W(helper_pmulhrw, FMULHRW)
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index 9c7451d28e..d8e33dff6b 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -60,14 +60,6 @@ DEF_HELPER_3(glue(pslldq, SUFFIX), void, env, Reg, Reg)
 #define SSE_HELPER_Q(name, F)\
     DEF_HELPER_3(glue(name, SUFFIX), void, env, Reg, Reg)
 
-SSE_HELPER_B(pcmpgtb, FCMPGTB)
-SSE_HELPER_W(pcmpgtw, FCMPGTW)
-SSE_HELPER_L(pcmpgtl, FCMPGTL)
-
-SSE_HELPER_B(pcmpeqb, FCMPEQ)
-SSE_HELPER_W(pcmpeqw, FCMPEQ)
-SSE_HELPER_L(pcmpeql, FCMPEQ)
-
 SSE_HELPER_W(pmullw, FMULLW)
 #if SHIFT == 0
 SSE_HELPER_W(pmulhrw, FMULHRW)
diff --git a/target/i386/translate.c b/target/i386/translate.c
index d08d2cedce..729509e1ff 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2783,9 +2783,9 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0x61] = MMX_OP2(punpcklwd),
     [0x62] = MMX_OP2(punpckldq),
     [0x63] = MMX_OP2(packsswb),
-    [0x64] = MMX_OP2(pcmpgtb),
-    [0x65] = MMX_OP2(pcmpgtw),
-    [0x66] = MMX_OP2(pcmpgtl),
+    [0x64] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
+    [0x65] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
+    [0x66] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0x67] = MMX_OP2(packuswb),
     [0x68] = MMX_OP2(punpckhbw),
     [0x69] = MMX_OP2(punpckhwd),
@@ -2802,9 +2802,9 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0x71] = { SSE_SPECIAL, SSE_SPECIAL }, /* shiftw */
     [0x72] = { SSE_SPECIAL, SSE_SPECIAL }, /* shiftd */
     [0x73] = { SSE_SPECIAL, SSE_SPECIAL }, /* shiftq */
-    [0x74] = MMX_OP2(pcmpeqb),
-    [0x75] = MMX_OP2(pcmpeqw),
-    [0x76] = MMX_OP2(pcmpeql),
+    [0x74] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
+    [0x75] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
+    [0x76] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0x77] = { SSE_DUMMY }, /* emms */
     [0x78] = { NULL, SSE_SPECIAL, NULL, SSE_SPECIAL }, /* extrq_i, insertq_i */
     [0x79] = { NULL, gen_helper_extrq_r, NULL, gen_helper_insertq_r },
@@ -3216,6 +3216,30 @@ static inline void gen_gvec_ld_modrm_3(CPUX86State *env, DisasContext *s,
 #define gen_vpmaxu_xmm(env, s, modrm, vece) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), (vece), tcg_gen_gvec_umax, 0123)
 #define gen_vpmaxu_ymm(env, s, modrm, vece) gen_gvec_ld_modrm_vymm((env), (s), (modrm), (vece), tcg_gen_gvec_umax, 0123)
 
+static inline void gen_gvec_cmpeq(unsigned vece, uint32_t dofs,
+                                  uint32_t aofs, uint32_t bofs,
+                                  uint32_t oprsz, uint32_t maxsz)
+{
+    tcg_gen_gvec_cmp(TCG_COND_EQ, vece, dofs, aofs, bofs, oprsz, maxsz);
+}
+
+#define gen_pcmpeq_mm(env, s, modrm, vece)   gen_gvec_ld_modrm_mm  ((env), (s), (modrm), (vece), gen_gvec_cmpeq, 0112)
+#define gen_pcmpeq_xmm(env, s, modrm, vece)  gen_gvec_ld_modrm_xmm ((env), (s), (modrm), (vece), gen_gvec_cmpeq, 0112)
+#define gen_vpcmpeq_xmm(env, s, modrm, vece) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), (vece), gen_gvec_cmpeq, 0123)
+#define gen_vpcmpeq_ymm(env, s, modrm, vece) gen_gvec_ld_modrm_vymm((env), (s), (modrm), (vece), gen_gvec_cmpeq, 0123)
+
+static inline void gen_gvec_cmpgt(unsigned vece, uint32_t dofs,
+                                  uint32_t aofs, uint32_t bofs,
+                                  uint32_t oprsz, uint32_t maxsz)
+{
+    tcg_gen_gvec_cmp(TCG_COND_GT, vece, dofs, aofs, bofs, oprsz, maxsz);
+}
+
+#define gen_pcmpgt_mm(env, s, modrm, vece)   gen_gvec_ld_modrm_mm  ((env), (s), (modrm), (vece), gen_gvec_cmpgt, 0112)
+#define gen_pcmpgt_xmm(env, s, modrm, vece)  gen_gvec_ld_modrm_xmm ((env), (s), (modrm), (vece), gen_gvec_cmpgt, 0112)
+#define gen_vpcmpgt_xmm(env, s, modrm, vece) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), (vece), gen_gvec_cmpgt, 0123)
+#define gen_vpcmpgt_ymm(env, s, modrm, vece) gen_gvec_ld_modrm_vymm((env), (s), (modrm), (vece), gen_gvec_cmpgt, 0123)
+
 #define gen_pand_mm(env, s, modrm)   gen_gvec_ld_modrm_mm  ((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0112)
 #define gen_pand_xmm(env, s, modrm)  gen_gvec_ld_modrm_xmm ((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0112)
 #define gen_vpand_xmm(env, s, modrm) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0123)
@@ -3451,6 +3475,36 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
     case 0xee | M_0F | P_66 | VEX_128: gen_vpmaxs_xmm(env, s, modrm, MO_16); return;
     case 0xee | M_0F | P_66 | VEX_256: gen_vpmaxs_ymm(env, s, modrm, MO_16); return;
 
+    case 0x64 | M_0F:                  gen_pcmpgt_mm(env, s, modrm, MO_8); return;
+    case 0x64 | M_0F | P_66:           gen_pcmpgt_xmm(env, s, modrm, MO_8); return;
+    case 0x64 | M_0F | P_66 | VEX_128: gen_vpcmpgt_xmm(env, s, modrm, MO_8); return;
+    case 0x64 | M_0F | P_66 | VEX_256: gen_vpcmpgt_ymm(env, s, modrm, MO_8); return;
+
+    case 0x65 | M_0F:                  gen_pcmpgt_mm(env, s, modrm, MO_16); return;
+    case 0x65 | M_0F | P_66:           gen_pcmpgt_xmm(env, s, modrm, MO_16); return;
+    case 0x65 | M_0F | P_66 | VEX_128: gen_vpcmpgt_xmm(env, s, modrm, MO_16); return;
+    case 0x65 | M_0F | P_66 | VEX_256: gen_vpcmpgt_ymm(env, s, modrm, MO_16); return;
+
+    case 0x66 | M_0F:                  gen_pcmpgt_mm(env, s, modrm, MO_32); return;
+    case 0x66 | M_0F | P_66:           gen_pcmpgt_xmm(env, s, modrm, MO_32); return;
+    case 0x66 | M_0F | P_66 | VEX_128: gen_vpcmpgt_xmm(env, s, modrm, MO_32); return;
+    case 0x66 | M_0F | P_66 | VEX_256: gen_vpcmpgt_ymm(env, s, modrm, MO_32); return;
+
+    case 0x74 | M_0F:                  gen_pcmpeq_mm(env, s, modrm, MO_8); return;
+    case 0x74 | M_0F | P_66:           gen_pcmpeq_xmm(env, s, modrm, MO_8); return;
+    case 0x74 | M_0F | P_66 | VEX_128: gen_vpcmpeq_xmm(env, s, modrm, MO_8); return;
+    case 0x74 | M_0F | P_66 | VEX_256: gen_vpcmpeq_ymm(env, s, modrm, MO_8); return;
+
+    case 0x75 | M_0F:                  gen_pcmpeq_mm(env, s, modrm, MO_16); return;
+    case 0x75 | M_0F | P_66:           gen_pcmpeq_xmm(env, s, modrm, MO_16); return;
+    case 0x75 | M_0F | P_66 | VEX_128: gen_vpcmpeq_xmm(env, s, modrm, MO_16); return;
+    case 0x75 | M_0F | P_66 | VEX_256: gen_vpcmpeq_ymm(env, s, modrm, MO_16); return;
+
+    case 0x76 | M_0F:                  gen_pcmpeq_mm(env, s, modrm, MO_32); return;
+    case 0x76 | M_0F | P_66:           gen_pcmpeq_xmm(env, s, modrm, MO_32); return;
+    case 0x76 | M_0F | P_66 | VEX_128: gen_vpcmpeq_xmm(env, s, modrm, MO_32); return;
+    case 0x76 | M_0F | P_66 | VEX_256: gen_vpcmpeq_ymm(env, s, modrm, MO_32); return;
+
     case 0xdb | M_0F:                  gen_pand_mm(env, s, modrm); return;
     case 0xdb | M_0F | P_66:           gen_pand_xmm(env, s, modrm); return;
     case 0xdb | M_0F | P_66 | VEX_128: gen_vpand_xmm(env, s, modrm); return;
-- 
2.20.1


