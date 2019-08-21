Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6310BC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D7AE22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsGg9oiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7AE22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0V56-0005cV-VG
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URP-0001KH-Cc
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URO-0007iB-6S
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:35 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:39004)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URO-0007hu-2S
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:34 -0400
Received: by mail-yw1-xc43.google.com with SMTP id x74so1237464ywx.6
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hWoTu4BSOFujsEiCBxEz0mfSRHs6zhG1mcUNUpMJ3nY=;
 b=PsGg9oiKcgt05G3r4tjKehbmiOw+iSekxmf8r+N33Ng4Nc+kyx7pdcK6AvZFbhLK2k
 mvAEAeyFUZO2F6mOtnCSqT/7MJnND+/hYD+GtndS0mZOPTJilq1o3es380HZ/GMJwufS
 mOuVjXgS9s9Xc4WE9FeVohgUniAOeJm1VeqAqn1pGdNGZUpbtZZFlplBy+slC6xwtZ3R
 ekS2JWJlq2d40xDjl0wBBPT2uQB13CDPSiS84fEE5pXIBqQoTDOXf+C/vk2jXYuCcq39
 2mPgVEdGOOq5m8NXiey1qJEHAXO/hPuHO29NGEj3kY3RLxuq/Gyrg1BffJSiR1tmrezX
 gLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hWoTu4BSOFujsEiCBxEz0mfSRHs6zhG1mcUNUpMJ3nY=;
 b=qJPbYv9PmZschSo+shMpCk+Cv0uLHR9BWcxsrsQ1CRWfoFpfwCB0O62Z858x+Tm7qC
 QG7Hhn+4pgAWkgLJJtJccoQO9OuJ5cracPRZ1jxNmdLBEkfNc8pgyT+v9QWoKyJrtLwQ
 zakMs0xTsE0D9QDJGs6LHl53SIr/RC7NNnNnRSGcGjUjOEK8miK0AgJY9OImA4/KHVS3
 MJKjrwZxHgWVUu8pw14Ig+Z6gO5YT0YnjB6Z+4PytezhnLv33oxau65HOueihOVPhT+T
 XbmAz8CE/YybIjZQAtC0iFLh1QFxUFtSXXSadoppYAXMcHrqBj11P2pZ5Vs2Vyyk6Zu+
 RWvw==
X-Gm-Message-State: APjAAAX76bDLyTbLRvzqlv8aDZNgWhPtPwx6PKMXloS/19r3tAnWrWiY
 nZ/IVfMrzMyIEbRd85EY0n8rzqQe
X-Google-Smtp-Source: APXvYqxo5pXuO2yeU4Leuxsdt8n+SOo97kYafdE+A6d97+HCUIO99qI1g8A3pVRdklouwtmBpWokgw==
X-Received: by 2002:a0d:dd51:: with SMTP id g78mr24039298ywe.102.1566408633436; 
 Wed, 21 Aug 2019 10:30:33 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:32 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:09 -0400
Message-Id: <20190821172951.15333-34-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: [Qemu-devel] [RFC PATCH v4 33/75] target/i386: introduce gvec-based
 code generator macros
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Code generators defined using these macros rely on a gvec operation
(i.e. tcg_gen_gvec_*).

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 046914578b..eab36963c3 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -24,6 +24,7 @@
 #include "exec/exec-all.h"
 #include "tcg-gvec-desc.h"
 #include "tcg-op.h"
+#include "tcg-op-gvec.h"
 #include "exec/cpu_ldst.h"
 #include "exec/translator.h"
 
@@ -5537,6 +5538,30 @@ INSNOP_LDST(xmm, Mhq)
         tcg_temp_free_i32(arg4_r32);                                    \
     }
 
+#define MM_OPRSZ sizeof(MMXReg)
+#define MM_MAXSZ sizeof(MMXReg)
+#define XMM_OPRSZ (!(s->prefix & PREFIX_VEX) ? sizeof(XMMReg) : \
+                   s->vex_l ? sizeof(XMMReg) :                  \
+                   sizeof(XMMReg))
+#define XMM_MAXSZ (!(s->prefix & PREFIX_VEX) ? sizeof(XMMReg) : \
+                   sizeof(YMMReg))
+
+#define DEF_GEN_INSN2_GVEC(mnem, opT1, opT2, gvec, ...) \
+    GEN_INSN2(mnem, opT1, opT2)                         \
+    {                                                   \
+        gen_gvec_ ## gvec(arg1, arg2, ## __VA_ARGS__);  \
+    }
+#define DEF_GEN_INSN3_GVEC(mnem, opT1, opT2, opT3, gvec, ...)   \
+    GEN_INSN3(mnem, opT1, opT2, opT3)                           \
+    {                                                           \
+        gen_gvec_ ## gvec(arg1, arg2, arg3, ## __VA_ARGS__);    \
+    }
+#define DEF_GEN_INSN4_GVEC(mnem, opT1, opT2, opT3, opT4, gvec, ...)     \
+    GEN_INSN4(mnem, opT1, opT2, opT3, opT4)                             \
+    {                                                                   \
+        gen_gvec_ ## gvec(arg1, arg2, arg3, arg4, ## __VA_ARGS__);      \
+    }
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


