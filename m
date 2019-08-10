Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D0CC32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D1F2085A
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hG1G+Zzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D1F2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwIp2-0007Uk-7G
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34731)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIkq-0005Vl-Ve
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIkq-0004J9-1l
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:20 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36306)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIkp-0004J0-Tq
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:19 -0400
Received: by mail-ot1-x344.google.com with SMTP id k18so8367625otr.3
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7KP+U6MpoVPbGr0lDO3rePNLzDgSsxV/T5vodj8pKVs=;
 b=hG1G+ZzdU5JOeuKiPAfnfR6qrufrlRgFqZ3gHPGgDsGlojX1nelB07yaXJJXEq3WfQ
 QYmj4tYHzDDu6nk4WAnNyL3aGDxePvFkQbXUvWG8vXJ7o0+SZzzYJ+9FRjq9gEThsXlx
 JUNI2gsNUof0cW2BvUl8HqPz0zNZrbg+918PvHJ0LnW2NeT53Q4thCper267PQzidf3n
 nHIE1WptfCPCeH0FxoCNCVbTEzTVIIHO8JCLASjNS3aJnbZ1c0qmhIa/cJoPAZ27Qokg
 CtEr0vqtoLYZAzsz3N5kN8v2Ygy5rmmXh7r98pKpxL6uvX0fwSiJWMWZDXFPaYbK/9lX
 s70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7KP+U6MpoVPbGr0lDO3rePNLzDgSsxV/T5vodj8pKVs=;
 b=hUbiXazEp+u5+VJCxD8RP3f1HjFaOdf7JUj7SQQahKbdpIA3RPt91YnEHimbX4PUYy
 26ZO7DvkkYcukrsxEQbNzYebmaKiOnxAr/LpqTIg/aVgXva0U9WtA4PNPk9nqfbnIyTt
 kSafz7MZAJZ8xpqbJGPki3V5ViV/FLlvF99ZdIFeSaK1nXNjYmx83LqM818xxvbwaokk
 Gpwyb9r3NG2RA0qqGLKGi2Zx0lw1trA5Ko0fbcKfkRPSrbK//4tUsZ5kNgQDvulvcWI+
 ti85TEBk6zLMmlBciRaovCi4MoVacJfjvfCcPDsyg++Ds7Lohxo7f4ROoCmVzKrG3V5S
 sMLw==
X-Gm-Message-State: APjAAAVjtCkZCTCqY6KQScfyRkMxRS2HbJHJx08SmH4W7x7t5Fqf3kuh
 dSUyiQyUETdxjAXIQAoENSYIFl0/
X-Google-Smtp-Source: APXvYqxS5EDZRsd7t779oAGRBel2Hp694oiadWDBPAMaTcrkAwheXxL0z6J3OOh91+Lw9JkXAkdj8A==
X-Received: by 2002:aca:df08:: with SMTP id w8mr8216049oig.84.1565410399174;
 Fri, 09 Aug 2019 21:13:19 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:18 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:28 -0400
Message-Id: <20190810041255.6820-13-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: [Qemu-devel] [RFC PATCH v2 12/39] target/i386: introduce gen_sse_ng
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

Note: This changeset is intended for development only and shall not be
included in the final patch series.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 258351fce3..fbf10b57a2 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4489,6 +4489,31 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
     }
 }
 
+static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
+{
+    enum {
+        P_66 = 1 << (0 + 8),
+        P_F3 = 1 << (1 + 8),
+        P_F2 = 1 << (2 + 8),
+        W_0  = 0 << (3 + 8),
+        W_1  = 1 << (3 + 8),
+        M_0F = 1 << (4 + 8),
+    };
+
+    switch (b | M_0F
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
@@ -8379,7 +8404,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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


