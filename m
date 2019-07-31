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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07965C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:00:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C952067D
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uf9u6OrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C952067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsstP-0007Ix-3A
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 14:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42694)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrC-000268-41
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrA-0002ik-Ry
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:46 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:36011)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hssrA-0002iI-Mv
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:44 -0400
Received: by mail-yw1-xc44.google.com with SMTP id x67so23938893ywd.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 10:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XyOyXownzlqyzcHoDb3cC3+WYnqPG0lqyZKEQlHebr4=;
 b=Uf9u6OrJFgkrzD8njZj0IXUqvINLEIToyiMP+sh+UZHEEGaecqMmuMm5KaKRr9vX7U
 ZYJGyxF0BTOtQVdfViigzdqHwgmf4o4235b133qTG7qKfQw0HsSLHcph4ZhaFY2Hq8qT
 8VwjHbaBIoa3XrR4vgXbUMXFx3OuIV6tUVCDbYjHbZMhSRgzKqxne3SwDeRlV7RWgsVd
 IlhNcHrzBEvUwjM6nfYsaGd2oPsIFU1gTs6GN6x74WX2Dj7JIIOz7yRfHBF+JbW7LL+X
 O+V0hUBdqkDPAlBjK6vlsf+I9svIGgeZqQKJtP2aV/jH7nyWR76+e0cg/T5AZ7Qx98XQ
 o4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XyOyXownzlqyzcHoDb3cC3+WYnqPG0lqyZKEQlHebr4=;
 b=IqEOyGPdlx6ywgUySb1cCl9SHrmxh8OGp2iDAhf28PQkCKKZQVAuLYwtW4OQvxtjlj
 wOcwqSpmb3w0ZPPHNdGCnMjp2cg3rjGcPuBtx2ACUcVFwnE+FEt59njf3akkJwhe/CTh
 QRUsiSs1cH5W+0t4r8agp1SNpfxhUYh/H8DZQ5FSjtzFzO/I+39nKf2ydm3lKc9nwNI3
 eNuGs2RpidWotdtyaxrgAsDH8/eRN+iLz6P336oWHWyuXHOENKKSU3ZAlWW27jlEclr7
 hWuZE7vHpO2/plQV7hILCKqnJPM9FBrh+fB+B1Akv4GGDWcCFJ9c5AAEz66WQo49abb3
 EcVg==
X-Gm-Message-State: APjAAAWbEK05JDwqiIQ41L2ZVOxrjcbnl38TnxS5joHS237mq1zE5sE3
 5DPKAe3uDvUcebhBUu3imvxKjbaE
X-Google-Smtp-Source: APXvYqxt/KSjgdt6us31YrZXUOeE1kSS0qCVevXQR9MbFO2nReSWv/OqsYCBtNUFKHs2GbeI/57v/A==
X-Received: by 2002:a0d:eb8a:: with SMTP id
 u132mr74310850ywe.303.1564595863897; 
 Wed, 31 Jul 2019 10:57:43 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id 206sm16077696ywk.44.2019.07.31.10.57.43
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 10:57:43 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:56:46 -0400
Message-Id: <20190731175702.4916-7-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731175702.4916-1-jan.bobek@gmail.com>
References: <20190731175702.4916-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [RFC PATCH v1 06/22] target/i386: introduce
 gen_gvec_ld_modrm_* helpers
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

gen_gvec_ld_modrm_* helpers tie together a gen_ld_modrm_* helper and a
particular gvec operation, effectively handling a single instruction.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 77 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 7548677e1f..d576b3345c 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -3087,6 +3087,83 @@ static inline void gen_ld_modrm_VxHxWx(CPUX86State *env, DisasContext *s, int mo
     *aofs = offsetof(CPUX86State, xmm_regs[s->vex_v]);
 }
 
+typedef void (*gen_ld_modrm_2_fp_t)(CPUX86State *env, DisasContext *s, int modrm,
+                                    uint32_t *dofs, uint32_t *aofs);
+typedef void (*gen_ld_modrm_3_fp_t)(CPUX86State *env, DisasContext *s, int modrm,
+                                    uint32_t *dofs, uint32_t *aofs, uint32_t *bofs);
+typedef void (*gen_gvec_2_fp_t)(unsigned vece, uint32_t dofs, uint32_t aofs,
+                                uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+
+static inline void gen_gvec_ld_modrm_2(CPUX86State *env, DisasContext *s,
+                                       int modrm, unsigned vece,
+                                       uint32_t oprsz, uint32_t maxsz,
+                                       gen_ld_modrm_2_fp_t gen_ld_modrm_2_fp,
+                                       gen_gvec_2_fp_t gen_gvec_2_fp,
+                                       int opctl)
+{
+    uint32_t ofss[2];
+
+    const int opd = ((opctl >> 6) & 7) - 1;
+    const int opa = ((opctl >> 3) & 7) - 1;
+    const int opb = ((opctl >> 0) & 7) - 1;
+
+    assert(0 <= opd && opd < 2);
+    assert(0 <= opa && opa < 2);
+    assert(0 <= opb && opb < 2);
+
+    (*gen_ld_modrm_2_fp)(env, s, modrm, &ofss[0], &ofss[1]);
+    (*gen_gvec_2_fp)(vece, ofss[opd], ofss[opa], ofss[opb], oprsz, maxsz);
+}
+
+static inline void gen_gvec_ld_modrm_3(CPUX86State *env, DisasContext *s,
+                                       int modrm, unsigned vece,
+                                       uint32_t oprsz, uint32_t maxsz,
+                                       gen_ld_modrm_3_fp_t gen_ld_modrm_3_fp,
+                                       gen_gvec_2_fp_t gen_gvec_2_fp,
+                                       int opctl)
+{
+    uint32_t ofss[3];
+
+    const int opd = ((opctl >> 6) & 7) - 1;
+    const int opa = ((opctl >> 3) & 7) - 1;
+    const int opb = ((opctl >> 0) & 7) - 1;
+
+    assert(0 <= opd && opd < 3);
+    assert(0 <= opa && opa < 3);
+    assert(0 <= opb && opb < 3);
+
+    (*gen_ld_modrm_3_fp)(env, s, modrm, &ofss[0], &ofss[1], &ofss[2]);
+    (*gen_gvec_2_fp)(vece, ofss[opd], ofss[opa], ofss[opb], oprsz, maxsz);
+}
+
+#define gen_gvec_ld_modrm_mm(env, s, modrm, vece,                       \
+                             gen_gvec_2_fp, opctl)                      \
+    gen_gvec_ld_modrm_2((env), (s), (modrm), (vece),                    \
+                        sizeof(MMXReg), sizeof(MMXReg),                 \
+                        gen_ld_modrm_PqQq,                              \
+                        gen_gvec_2_fp, (opctl))
+
+#define gen_gvec_ld_modrm_xmm(env, s, modrm, vece,                      \
+                              gen_gvec_2_fp, opctl)                     \
+    gen_gvec_ld_modrm_2((env), (s), (modrm), (vece),                    \
+                        sizeof(XMMReg), sizeof(XMMReg),                 \
+                        gen_ld_modrm_VxWx,                              \
+                        gen_gvec_2_fp, (opctl))
+
+#define gen_gvec_ld_modrm_vxmm(env, s, modrm, vece,                     \
+                               gen_gvec_2_fp, opctl)                    \
+    gen_gvec_ld_modrm_3((env), (s), (modrm), (vece),                    \
+                        sizeof(XMMReg), sizeof(ZMMReg),                 \
+                        gen_ld_modrm_VxHxWx,                            \
+                        gen_gvec_2_fp, (opctl))
+
+#define gen_gvec_ld_modrm_vymm(env, s, modrm, vece,                     \
+                               gen_gvec_2_fp, opctl)                    \
+    gen_gvec_ld_modrm_3((env), (s), (modrm), (vece),                    \
+                        sizeof(YMMReg), sizeof(ZMMReg),                 \
+                        gen_ld_modrm_VxHxWx,                            \
+                        gen_gvec_2_fp, (opctl))
+
 static void gen_sse(CPUX86State *env, DisasContext *s, int b)
 {
     int b1, op1_offset, op2_offset, is_xmm, val;
-- 
2.20.1


