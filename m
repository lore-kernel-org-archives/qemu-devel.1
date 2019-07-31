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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDF5C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6409A206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pK55u8k0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6409A206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43457 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsszq-00024G-JD
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 14:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42855)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrI-0002OZ-0D
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrG-0002tU-PL
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:51 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:40704)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hssrG-0002sD-LI
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:50 -0400
Received: by mail-yb1-xb43.google.com with SMTP id j6so2571469ybm.7
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 10:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hp/kv1iRAg1esL0wOHljF2nNjTxCw5xL8M8rejzPABE=;
 b=pK55u8k0yMLZmVtwXOCIwpLGmVcOywFIeMmHLKqzz4jLhY9KWqf7NhsWA8glSFS22H
 2VNiSFGQjOJv9VGagJpNsQLuoGiI+7gQHJK9Vxu9FHCfV6v5oqxTMbMFIWormk2nrsuf
 gO+ZYSLo0rehAVk44g1xuHh1Qvizf/oyabguO6sHFJxnJ0Un1DJBmkGh7nljuTZkWFl/
 NnwxTBgwLYE+CsB6+zYcjvh2bWdSyfMQ365NHTRR1SVasR1HkFhh1HdDFii+JE1fjw9Q
 DZ1WqsSfmEvJRJ1Koaa8C6wdObAcnY2sgEFdf57DxGQURbU7HF+VDYmR6+o4koRbsD12
 uyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hp/kv1iRAg1esL0wOHljF2nNjTxCw5xL8M8rejzPABE=;
 b=fW0ftayFElwllDiLPH7s89seY74O//cQ/FUPkRXbS2wa26+dcmcL3LNVO/i9bCdgvE
 AhCCFZ8Dpy77Pen4EK7hVRoRpw9emwhNcSLDw/RTNpshy2CHlZ9TlAlMBwNNlQ0SSgd/
 jGruCGjukI6C/qT7+E+Do8O41iy1/o04waamJRHyDbFQx2mZXT9ic1z6ujYdsy/B91F2
 PdMh+57QpFgLzp2Yg1HvCwVaRmM5o8SCOzqafR+eWq7EKf1ic0Lf+xpacjvD67apKQTq
 bZ36/LApJRpPzD8v+sKzfMMmAq4nuc9X7heTRt0eBdExdm2A8SaW5QmeNtjRqlmw/y+O
 feHg==
X-Gm-Message-State: APjAAAXFly0Pthh2Vmy0QViiDzY8mxHmtvHq0b6O78U6AjHqoKg6f/8m
 6y6RmUQixJNzsPae5TgYV96GPI8b
X-Google-Smtp-Source: APXvYqxx0Hr/5QxoWkmkQ7nOj81Wh3L3E0ZRcy1C5J6C9e5gpjN6oi6ev1mW7q1wCZm2oREoUBaDXw==
X-Received: by 2002:a25:81c6:: with SMTP id n6mr79461473ybm.403.1564595870026; 
 Wed, 31 Jul 2019 10:57:50 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id 206sm16077696ywk.44.2019.07.31.10.57.49
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 10:57:49 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:56:55 -0400
Message-Id: <20190731175702.4916-16-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731175702.4916-1-jan.bobek@gmail.com>
References: <20190731175702.4916-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: [Qemu-devel] [RFC PATCH v1 15/22] target/i386: reimplement
 (V)PADDUS(B, W)
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
 target/i386/ops_sse.h        |  5 -----
 target/i386/ops_sse_header.h |  2 --
 target/i386/translate.c      | 19 +++++++++++++++++--
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 8829dcb781..8c9b47fca4 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -337,9 +337,6 @@ static inline int satsw(int x)
     }
 }
 
-#define FADDUB(a, b) satub((a) + (b))
-#define FADDUW(a, b) satuw((a) + (b))
-
 #define FSUBUB(a, b) satub((a) - (b))
 #define FSUBUW(a, b) satuw((a) - (b))
 #define FSUBSB(a, b) satsb((int8_t)(a) - (int8_t)(b))
@@ -362,11 +359,9 @@ static inline int satsw(int x)
 #define FAVG(a, b) (((a) + (b) + 1) >> 1)
 #endif
 
-SSE_HELPER_B(helper_paddusb, FADDUB)
 SSE_HELPER_B(helper_psubusb, FSUBUB)
 SSE_HELPER_B(helper_psubsb, FSUBSB)
 
-SSE_HELPER_W(helper_paddusw, FADDUW)
 SSE_HELPER_W(helper_psubusw, FSUBUW)
 SSE_HELPER_W(helper_psubsw, FSUBSW)
 
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index 78203e80a5..8a31ade70c 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -60,11 +60,9 @@ DEF_HELPER_3(glue(pslldq, SUFFIX), void, env, Reg, Reg)
 #define SSE_HELPER_Q(name, F)\
     DEF_HELPER_3(glue(name, SUFFIX), void, env, Reg, Reg)
 
-SSE_HELPER_B(paddusb, FADDUB)
 SSE_HELPER_B(psubusb, FSUBUB)
 SSE_HELPER_B(psubsb, FSUBSB)
 
-SSE_HELPER_W(paddusw, FADDUW)
 SSE_HELPER_W(psubusw, FSUBUW)
 SSE_HELPER_W(psubsw, FSUBSW)
 
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 5ea5014d99..e2ed8c20b3 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2826,8 +2826,8 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0xd9] = MMX_OP2(psubusw),
     [0xda] = MMX_OP2(pminub),
     [0xdb] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
-    [0xdc] = MMX_OP2(paddusb),
-    [0xdd] = MMX_OP2(paddusw),
+    [0xdc] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
+    [0xdd] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0xde] = MMX_OP2(pmaxub),
     [0xdf] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0xe0] = MMX_OP2(pavgb),
@@ -3176,6 +3176,11 @@ static inline void gen_gvec_ld_modrm_3(CPUX86State *env, DisasContext *s,
 #define gen_vpadds_xmm(env, s, modrm, vece) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), (vece), tcg_gen_gvec_ssadd, 0123)
 #define gen_vpadds_ymm(env, s, modrm, vece) gen_gvec_ld_modrm_vymm((env), (s), (modrm), (vece), tcg_gen_gvec_ssadd, 0123)
 
+#define gen_paddus_mm(env, s, modrm, vece)   gen_gvec_ld_modrm_mm  ((env), (s), (modrm), (vece), tcg_gen_gvec_usadd, 0112)
+#define gen_paddus_xmm(env, s, modrm, vece)  gen_gvec_ld_modrm_xmm ((env), (s), (modrm), (vece), tcg_gen_gvec_usadd, 0112)
+#define gen_vpaddus_xmm(env, s, modrm, vece) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), (vece), tcg_gen_gvec_usadd, 0123)
+#define gen_vpaddus_ymm(env, s, modrm, vece) gen_gvec_ld_modrm_vymm((env), (s), (modrm), (vece), tcg_gen_gvec_usadd, 0123)
+
 #define gen_psub_mm(env, s, modrm, vece)   gen_gvec_ld_modrm_mm  ((env), (s), (modrm), (vece), tcg_gen_gvec_sub, 0112)
 #define gen_psub_xmm(env, s, modrm, vece)  gen_gvec_ld_modrm_xmm ((env), (s), (modrm), (vece), tcg_gen_gvec_sub, 0112)
 #define gen_vpsub_xmm(env, s, modrm, vece) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), (vece), tcg_gen_gvec_sub, 0123)
@@ -3336,6 +3341,16 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
     case 0xd4 | M_0F | P_66 | VEX_128: gen_vpadd_xmm(env, s, modrm, MO_64); return;
     case 0xd4 | M_0F | P_66 | VEX_256: gen_vpadd_ymm(env, s, modrm, MO_64); return;
 
+    case 0xdc | M_0F:                  gen_paddus_mm(env, s, modrm, MO_8); return;
+    case 0xdc | M_0F | P_66:           gen_paddus_xmm(env, s, modrm, MO_8); return;
+    case 0xdc | M_0F | P_66 | VEX_128: gen_vpaddus_xmm(env, s, modrm, MO_8); return;
+    case 0xdc | M_0F | P_66 | VEX_256: gen_vpaddus_ymm(env, s, modrm, MO_8); return;
+
+    case 0xdd | M_0F:                  gen_paddus_mm(env, s, modrm, MO_16); return;
+    case 0xdd | M_0F | P_66:           gen_paddus_xmm(env, s, modrm, MO_16); return;
+    case 0xdd | M_0F | P_66 | VEX_128: gen_vpaddus_xmm(env, s, modrm, MO_16); return;
+    case 0xdd | M_0F | P_66 | VEX_256: gen_vpaddus_ymm(env, s, modrm, MO_16); return;
+
     case 0xec | M_0F:                  gen_padds_mm(env, s, modrm, MO_8); return;
     case 0xec | M_0F | P_66:           gen_padds_xmm(env, s, modrm, MO_8); return;
     case 0xec | M_0F | P_66 | VEX_128: gen_vpadds_xmm(env, s, modrm, MO_8); return;
-- 
2.20.1


