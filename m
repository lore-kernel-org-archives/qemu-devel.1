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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD70C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:03:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B67D2082F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCR8Uniw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B67D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0UxO-0002DX-9L
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UR9-0000tC-GY
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UR8-0007Er-9t
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:19 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:40494)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0UR8-0007EZ-5M
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:18 -0400
Received: by mail-yb1-xb43.google.com with SMTP id g7so1338169ybd.7
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m7m1DBEvl4+jXT++i64MbAF5g/HBmU0aL7h5oTNL2Gk=;
 b=fCR8UniwwETVrmgG27bXzUGg2drdEa9RK9bKRdOLv86k2YBAT4ETfcuRvxo0bDjA1I
 D/FX/V6pNkaykt00EgSll14XUd6S7up/h8jdlg197P2geIFDWJlMDMXlnCC25UFRa2i5
 VTUhj64r+ZLyK5nhMIIo4QAUf/lEzxh+vnh3H+G/Bb002oRq1jAums7IsQWGLU9FeVDA
 /k9E/3dg/ULQfuvmCR5zrujPRsEocq16t+EYQapiet/TOU7AFd2b5kRMJlH3+i2KbpjM
 TE960ccKnF0mp6j2qleGQL/FpXC/+uhjfFA1v43WgA/uvPK/J0c0PaiyUyrDPJGmChb/
 lY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m7m1DBEvl4+jXT++i64MbAF5g/HBmU0aL7h5oTNL2Gk=;
 b=cDFKZCcg6sQxQWUs/ml7UxDCjVy6BoNyDCP06Q/LYAk5RoehIhQB3xFVnnqJWRi5Ls
 BwoNaM1Lcsk5x43+JjqE4vEIn/27I6Zic2C0z13HALY1GiwzANU/UvRenpBDTdt8dDsP
 bRZ+U0j7rglB7K6ApT8wSRoreUXXk07/+iIBbA5btJWC2w/Ctok0ObMQHtpOoWawlU1P
 7F40apMnM98b4D00sCcjaXFKVi7yoZDvXaOGfGEdpmZlUL0enDs1o/6Y6wdtFP/oEoXh
 sEbmOGN85myxJ5s3dzCC5D+7MnYxNafgMHPX1L5T/JFIOSgqy+RcDtyyRQ4qCxBGzSvX
 rTGQ==
X-Gm-Message-State: APjAAAVkRw7PFWVcShqvHX1yAO2Wx1QDjnOINr3eQFF4PDGCfBJCDCCK
 Q92huIrESTZxJV8cxlMZIaP1xXLf
X-Google-Smtp-Source: APXvYqxoMY7RxTikxPHgeu0Z8VtojPUHRc7MVklEvQQAU52Gz2+pPxQQ7MqvI4IJt+5SjYPHEs65Wg==
X-Received: by 2002:a25:c2c4:: with SMTP id s187mr25659291ybf.21.1566408617497; 
 Wed, 21 Aug 2019 10:30:17 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:16 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:28:52 -0400
Message-Id: <20190821172951.15333-17-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: [Qemu-devel] [RFC PATCH v4 16/75] target/i386: disable AVX/AVX2
 cpuid bitchecks
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

Ignore the AVX/AVX2 cpuid bits when checking for availability of the
relevant instructions. This is clearly incorrect, but it preserves the
old behavior, which is useful during development.

Note: This changeset is intended for development only and shall not be
included in the final patch series.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 3e54443d99..e7c2ad41bf 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4564,15 +4564,15 @@ static bool check_cpuid(CPUX86State *env, DisasContext *s, CheckCpuidFeat feat)
     case CHECK_CPUID_PCLMULQDQ:
         return s->cpuid_ext_features & CPUID_EXT_PCLMULQDQ;
     case CHECK_CPUID_AVX:
-        return s->cpuid_ext_features & CPUID_EXT_AVX;
+        return true /* s->cpuid_ext_features & CPUID_EXT_AVX */;
     case CHECK_CPUID_AES_AVX:
-        return (s->cpuid_ext_features & CPUID_EXT_AES)
-            && (s->cpuid_ext_features & CPUID_EXT_AVX);
+        return s->cpuid_ext_features & CPUID_EXT_AES
+            /* && (s->cpuid_ext_features & CPUID_EXT_AVX) */;
     case CHECK_CPUID_PCLMULQDQ_AVX:
-        return (s->cpuid_ext_features & CPUID_EXT_PCLMULQDQ)
-            && (s->cpuid_ext_features & CPUID_EXT_AVX);
+        return s->cpuid_ext_features & CPUID_EXT_PCLMULQDQ
+            /* && (s->cpuid_ext_features & CPUID_EXT_AVX) */;
     case CHECK_CPUID_AVX2:
-        return s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_AVX2;
+        return true /* s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_AVX2 */;
     default:
         g_assert_not_reached();
     }
-- 
2.20.1


