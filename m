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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3DAC433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D891217F4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEz8ZQHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D891217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwIvi-00079f-VD
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34846)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIl0-000638-IW
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIkz-0004Pl-JF
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:30 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40796)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIkz-0004OS-F6
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:29 -0400
Received: by mail-ot1-x341.google.com with SMTP id c34so481495otb.7
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N+dtPNIK3VoSsjKgKbGhkBhajKi+jxRCrJYpAZtiaR8=;
 b=UEz8ZQHJxZToygOlIqeBcI8w+wKgEi5UUshjl0YJpOuEr1yrYa6ZDGPpgyGfDfLTZH
 7d8zFaKqJs226N4R1niBy1hfaLZ3ZZmA3aPeXG4AO5ttiDzvwaj7q1gi3CWVijK7lrDh
 NaCD3/YRU3D6+/URArrGhQhDuhVyv5svGcJjD2Cl6XtzjU69nhelxDZBjEoLOV4ths8B
 9la5g2QPIOf8cVZTnsDV68PXT4adc1Ey+G4dAOTpBilv+6Gkgl28IYU+/aFuIKkgSfFK
 CfaO2Xb5zftxYTUJAhGJ3FpYYe9+JEiiZ5SaeH4YlI/ie8d/seFzZKMmYNuRdgM21DYt
 VKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N+dtPNIK3VoSsjKgKbGhkBhajKi+jxRCrJYpAZtiaR8=;
 b=W+40yM9iiNzMr4uyIhqk5CDxO/MngD6HqNKNRwULmkAFxP1d4XM2x8MBMAm7MUeCXh
 BTIzNbb6g0kOnQE4SkaQpeOfCsqdtzWAWdE+/xQ2cM6QaHvzNd3QKH06u32UT88cGTii
 mOhKZBLccvTp9ncvVGKsGuQdQSM9jieeNWm8DnmPtPfu5UKoSHj7tyduiKzjAxbPjLSx
 0/aVftIoMAx2zFKTMvo4H92OW0r+7mZqieKUjW51y/F66qzYVj4sSUsaru2mZgHY88iC
 QB3eUUL6njBscneJufmfB71PoIGuXWw823kD5uXi4v3zlR+SBTa5nft/XbJJsGHH3WZv
 f8Jg==
X-Gm-Message-State: APjAAAWMtN2PJwCBzISwDy/KxkeaTaoYICxZx00Qex3C9X7JZ1u/59kq
 IChBB+aj177NFZk//jCnp7eioeFA
X-Google-Smtp-Source: APXvYqz0HHESLuDiG3PXy3OWFVlFrU04AspNx7/rRrJ3Acmz8CLBI4VXX9BBKfYI/H0Buntw2fZDgA==
X-Received: by 2002:a9d:5911:: with SMTP id t17mr19533422oth.159.1565410408794; 
 Fri, 09 Aug 2019 21:13:28 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:28 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:38 -0400
Message-Id: <20190810041255.6820-23-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: [Qemu-devel] [RFC PATCH v2 22/39] target/i386: introduce code
 generators
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

In this context, "code generators" are functions that receive decoded
instruction operands and emit TCG ops implementing the correct
instruction functionality. Introduce the naming macros first, actual
generator macros will be added later.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index ebb68fef0b..30180d1c25 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4697,6 +4697,24 @@ static int ck_cpuid(CPUX86State *env, DisasContext *s, int ck_cpuid_feat)
             insnop_finalize(opTrm)(env, s, modrm, &rm);                 \
         } while (0))
 
+/*
+ * Code generators
+ */
+#define gen_insn(mnem)                          \
+    gen_ ## mnem
+#define gen_insn_r(mnem, opR1)                  \
+    gen_ ## mnem ## _ ## opR1
+#define gen_insn_rr(mnem, opR1, opR2)           \
+    gen_ ## mnem ## _ ## opR1 ## opR2
+#define gen_insn_w(mnem, opW1)                  \
+    gen_ ## mnem ## _ ## opW1
+#define gen_insn_wr(mnem, opW1, opR1)           \
+    gen_ ## mnem ## _ ## opW1 ## opR1
+#define gen_insn_wrr(mnem, opW1, opR1, opR2)    \
+    gen_ ## mnem ## _ ## opW1 ## opR1 ## opR2
+#define gen_insn_wrrr(mnem, opW1, opR1, opR2, opR3)     \
+    gen_ ## mnem ## _ ## opW1 ## opR1 ## opR2 ## opR3
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


