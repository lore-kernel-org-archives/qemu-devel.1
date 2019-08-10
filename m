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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43672C433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:24:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C192217F4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgA0JnN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C192217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwIvU-0006TU-3r
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34949)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIl9-0006WU-Kf
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIl8-0004XS-J2
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:39 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34829)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIl8-0004WM-Ep
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:38 -0400
Received: by mail-ot1-x343.google.com with SMTP id j19so63825350otq.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iIHl2d9RbZZyRpEtRAyrnFjn3106lJjZLwkGcmx2+h8=;
 b=EgA0JnN+y36yxuAXP4wTQUHcA3sfwYgQWLu2tyyb3+Ql5TkIfyTlwtsdtIfTMsDqQe
 sFREPeiZ0a8PrcPJUQYQ8PpTSlaSHvVfQ1xrJQXTOispKT2NRpL6Hq2bErMTfw88BsvS
 eCj5itAvySvuQGxhFeIrko4H8mY/vw5r1eHKUauFZeIF+WiCDJad0g6HR/9oaaa9QrXJ
 dgk6ptYf9Y2ow0FO9zYW5PPPKO5Pgp9Z/dtAI1pnJ0pqJETzfhh+SD2xAlD5csJ1iwlT
 PqxRK/cl4/gEAQN2Wp4f4D9em+ISXuyrBkX+yp+pBdOiDL6m8mEHn1N2SfzBBKsxBjXh
 lw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iIHl2d9RbZZyRpEtRAyrnFjn3106lJjZLwkGcmx2+h8=;
 b=E541y4woo/Pc4Jg2BKwhNSG/LZJEdKk1V1SIct/BHN+eJUv+hLYEXv7uQO1EzFXfFW
 XHG+UQ4rNgUMf7gQGxXIAovGl5JwGunSMlsOJoLLR5Ww7A4dCq16i3DYspt/Q+JVIQo0
 27pmylIq7W6SkxmhvYSeGQ7OqLYnOHH9Lc8ATmrdVrcAbS8Dkuh25/FlB/mXw91RRCFa
 jHGbioRklRkuywoUBPObUtoiZC6eQ4hty038q3jhrq/4yZCpc4a5gCn71C3dm7sqozBl
 Z+mRDguyZgsqxOYzpaZCy+seJ0lAHmc9NpevF5r8ivc0ucYxEhGja1s2P7bBZHh0t/g/
 i+5Q==
X-Gm-Message-State: APjAAAXu7zXqlfR7hj/b68uMQNrb4sXgQRM4s/y6ED+a5QvR/TXlsrPh
 6xN5Bdf3xTvKMA2bYJcXW20hh2Md
X-Google-Smtp-Source: APXvYqw9yY6P7pZtQeheRJQBAsLT6fSbTLj6RYgpmShZGWATMwxweBzJgvCyVVCf/+8k05HwZ+pIBQ==
X-Received: by 2002:a05:6830:1146:: with SMTP id
 x6mr21261883otq.86.1565410417350; 
 Fri, 09 Aug 2019 21:13:37 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.36
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:36 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:47 -0400
Message-Id: <20190810041255.6820-32-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: [Qemu-devel] [RFC PATCH v2 31/39] target/i386: introduce MMX
 translators
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

Use the translator macros to define instruction translators required
by MMX instructions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 36f2579654..3475727380 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5005,6 +5005,15 @@ static void translate_insn(
         insnop_finalize(opW1)(env, s, modrm, &ret);                     \
     }
 
+TRANSLATE_INSN_WR(Pq, Ed)
+TRANSLATE_INSN_WR(Pq, Eq)
+TRANSLATE_INSN_WR(Ed, Pq)
+TRANSLATE_INSN_WR(Eq, Pq)
+TRANSLATE_INSN_WR(Pq, Qq)
+TRANSLATE_INSN_WR(Qq, Pq)
+TRANSLATE_INSN_WR(Gd, Nq)
+TRANSLATE_INSN_WR(Gq, Nq)
+
 #define TRANSLATE_INSN_WRR(opW1, opR1, opR2)                            \
     static void translate_insn_wrr(opW1, opR1, opR2)(                   \
         CPUX86State *env, DisasContext *s, int modrm, int ck_cpuid_feat, \
@@ -5029,6 +5038,13 @@ static void translate_insn(
         insnop_finalize(opW1)(env, s, modrm, &ret);                     \
     }
 
+TRANSLATE_INSN_WRR(Pq, Pq, Qd)
+TRANSLATE_INSN_WRR(Pq, Pq, Qq)
+TRANSLATE_INSN_WRR(Pq, Qq, Ib)
+TRANSLATE_INSN_WRR(Gd, Nq, Ib)
+TRANSLATE_INSN_WRR(Gq, Nq, Ib)
+TRANSLATE_INSN_WRR(Nq, Nq, Ib)
+
 #define TRANSLATE_INSN_WRRR(opW1, opR1, opR2, opR3)                     \
     static void translate_insn_wrrr(opW1, opR1, opR2, opR3)(            \
         CPUX86State *env, DisasContext *s, int modrm, int ck_cpuid_feat, \
-- 
2.20.1


