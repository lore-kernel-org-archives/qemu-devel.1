Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31394C32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F340D2084F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im6dYTWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F340D2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5HR-00033b-Ik
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DL-00062b-DL
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DK-0008Jk-2F
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:07 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:45766)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5DJ-0008JZ-UK
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:06 -0400
Received: by mail-yw1-xc44.google.com with SMTP id n69so283280ywd.12
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CUdq+ci8qtMI41tslb9dsvKvnSE5fapv8uANUHJ6jPI=;
 b=Im6dYTWZEpyaRqYVMjOVZgY2wklNfEWqdNCUgAbJuImjXq881Fpp/z6cp2X4zMtbGQ
 U5C5/kMl1o7w5nUhVjnhyfQNf/SoZ5lWS4FERKAu5IlmHph0ZJGNVNn/42l4bxuS8LKe
 Kd/K0bL2g890Wy7Mq1msHDobTKwiScI+QeRcvm9S+spM9J7vN7bW9CVXyM3085/OmxDI
 4ZCKscJHpvw6jh54oWEdWmVjnq0Y54MWmp4dfNSV0V+PXzutL4uauEEjg0gxGI0tlten
 KQCxshx0COtyjVxvCR29+PANC7jgxkHUydLABTNO/Ab8pUIcQ8/N8JCz5gzbhwVPBqPP
 bvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CUdq+ci8qtMI41tslb9dsvKvnSE5fapv8uANUHJ6jPI=;
 b=BWRmXCY4phg1vN8+O3LquvXoMC2T0A5O07pVHBp7+w2f0HkFrQDdxUoTUCDmMKl6ro
 /V+EsWdOTLq777tLlGKR3gUdWEG/yLLqakcfUBMeH3IPj8mvV5ZlbC8P3mzW2zmXzzVy
 E8xQ6kMcjBO6eHy98c9fb3TistUefO4i3fDVWg7flgGqI7bl0G/bkp8ECWXa8v4SVkii
 dYVMoZzdwDgDedpqyCRoYL1hRJWgj8SoOl2jeCBiSdbSe2vvqhy10fqu+sxUyiAsG3TB
 xSF7wKJdXrCkUywvffziqU81zSMCtS1OzFENO118dhU01TWi4fbYdCtdVj0YeXgpbwxp
 xcgA==
X-Gm-Message-State: APjAAAXVyZ6+p4orVARcR2d72A64jkVaRHQKOVYUOKPKAOTrSaVy4Gdw
 h7rrZQSQlpiJ0d6BvIxJDMZMl82e
X-Google-Smtp-Source: APXvYqyAR8xWLv59dwwUaO9m1luSWIkeIuZNLHMqOS+jhpGprrwscXxTqITkcvE+tt4+k3cSP5mCuQ==
X-Received: by 2002:a81:79d2:: with SMTP id u201mr1466682ywc.457.1565835005347; 
 Wed, 14 Aug 2019 19:10:05 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:04 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:08:54 -0400
Message-Id: <20190815020928.9679-13-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [RFC PATCH v3 12/46] target/i386: introduce gen_sse_ng
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 258351fce3..fdc7cb0054 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4489,6 +4489,33 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
     }
 }
 
+static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
+{
+    enum {
+        P_NP = 0,
+        P_66 = 1 << (0 + 8),
+        P_F3 = 1 << (1 + 8),
+        P_F2 = 1 << (2 + 8),
+        W_0  = 0 << (3 + 8),
+        W_1  = 1 << (3 + 8),
+        M_NA = 0,
+        M_0F = 1 << (4 + 8),
+    };
+
+    switch ((b & 0xff) | M_0F
+            | (s->prefix & PREFIX_DATA ? P_66 : 0)
+            | (s->prefix & PREFIX_REPZ ? P_F3 : 0)
+            | (s->prefix & PREFIX_REPNZ ? P_F2 : 0)
+            | (REX_W(s) > 0 ? W_1 : W_0)) {
+
+    default:
+        gen_sse(env, s, b);
+        return;
+    }
+
+    g_assert_not_reached();
+}
+
 /* convert one instruction. s->base.is_jmp is set if the translation must
    be stopped. Return the next pc value */
 static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
@@ -8379,7 +8406,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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


