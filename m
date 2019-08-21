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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE772C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0AB22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxkgLEEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0AB22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0UiL-0007OP-4g
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UR4-0000kv-E4
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UR2-00077Z-Tw
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:14 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:45506)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0UR2-000772-Os
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:12 -0400
Received: by mail-yb1-xb42.google.com with SMTP id u32so1326379ybi.12
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WEqQSkOn6tgWF8MsWRjc3VD3xb5ORz43vFOppSEWU84=;
 b=HxkgLEEqA6TL3H7Zwvae9d7MkzG/UZL+Txz+QRTzZWfUAw0eP4MRFXHGMf9aK39ZEv
 /YAIgzLgGcSw5dF0D0EVSaJMwDWz321bliNXF/yiLBRpdZg6WerLgtgPKmq7IX8A4YTe
 MIOSJGCVSpbEFxTr/mk2AShFD9qTmERmlWifUYTcTSGws2ZhvXqtRkGPmdlpbvaO60Yp
 54q21Z5wmWKPSlwfOAFRbCVwjZI3P0/3bgWQe5UR/xm+AxH/TDY6L88PyFMuFHr8PBNd
 W0IpsGF8WLT9laPwAZBSTpR/dNe7Klujg8Q2znbhn5qUsK9qlBcePdZ0LxtUJzLgKGMx
 OLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WEqQSkOn6tgWF8MsWRjc3VD3xb5ORz43vFOppSEWU84=;
 b=H+F11B0ZJT9WPYKE5BdZoPyUJDb+rrW5t9hCLU4kClByk4aeE6YwuXFuYgIqfMJ/au
 V82J6HpBeOrnQbw3cbgzrwKPDs0Qk32TOWgxg+htfMQjLrCB5jjLDmHfaYwriT5mOeZa
 UMz9q31tEw89QJgm+WjM1M5GPtB6/JHlL48g9/lxv0x+rAiQxJsoE8BIOXKYxKIoGnEM
 qfxxtJltf+2dtIbzcFZ09axM0yACf2e6S1UgUWXwMVQipidDVSLw1lZiT5HwPp188llQ
 FKtup6EVr4p9QJBB9VO+OfrdpyEU5RJqWN4Zq5ZbO952pNpq8I5+YqoI8UM2lnQHadLM
 /46w==
X-Gm-Message-State: APjAAAXhrZNtT3TZZ+GI7bkZA8rAH8DiSzgJc/9alFJkOnsR2yUeBdId
 TR4HAJjLMhZVql/oMcw+fpq3dgS7
X-Google-Smtp-Source: APXvYqxBKE+N+fOMgly2HFf1ieXZCAAAqtKm+g6/isBUNKIKzLmLbSgB7bpxVOHbeaD/cpkrOHjBcw==
X-Received: by 2002:a25:324b:: with SMTP id y72mr12446483yby.361.1566408612104; 
 Wed, 21 Aug 2019 10:30:12 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:11 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:28:47 -0400
Message-Id: <20190821172951.15333-12-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [RFC PATCH v4 11/75] target/i386: introduce gen_sse_ng
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

This function serves as the point-of-intercept for all newly
implemented instructions. If no new implementation exists, fall back
to gen_sse.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 46 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 44ad55f9ee..8045ce3ce0 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4477,6 +4477,50 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
     }
 }
 
+static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
+{
+    enum {
+        P_NP = 0,
+        P_66 = 1 << 8,
+        P_F3 = 1 << 9,
+        P_F2 = 1 << 10,
+
+        M_NA   = 0,
+        M_0F   = 1 << 11,
+        M_0F38 = 1 << 12,
+        M_0F3A = 1 << 13,
+
+        W_0 = 0,
+        W_1 = 1 << 14,
+
+        VEX_128 = 1 << 15,
+        VEX_256 = 1 << 16,
+    };
+
+    const int p =
+        (s->prefix & PREFIX_DATA ? P_66 : 0)
+        | (s->prefix & PREFIX_REPZ ? P_F3 : 0)
+        | (s->prefix & PREFIX_REPNZ ? P_F2 : 0)
+        | (!(s->prefix & PREFIX_VEX) ? 0 :
+           (s->vex_l ? VEX_256 : VEX_128));
+    int m =
+        M_0F;
+    const int w =
+        REX_W(s) > 0 ? W_1 : W_0;
+    int op =
+        b & 0xff;
+
+    while (1) {
+        switch (p | m | w | op) {
+
+        default: {
+            gen_sse(env, s, b);
+        } return;
+
+        }
+    }
+}
+
 static int disas_insn_prefix(DisasContext *s, CPUX86State *env)
 {
     int b, prefixes;
@@ -8372,7 +8416,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x1c2:
     case 0x1c4 ... 0x1c6:
     case 0x1d0 ... 0x1fe:
-        gen_sse(env, s, b);
+        gen_sse_ng(env, s, b);
         break;
     default:
         goto unknown_op;
-- 
2.20.1


