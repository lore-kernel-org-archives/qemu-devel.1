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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB42C433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:11:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C92DD2067D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmlfkw+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92DD2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5F5-0007zq-TB
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DJ-0005zV-7N
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DI-0008IF-5y
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:05 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:46813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5DI-0008I3-1z
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:04 -0400
Received: by mail-yb1-xb42.google.com with SMTP id x10so387950ybs.13
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UnCpLXb0Tm7zqYonWzBKX7Cm2ohAULA3NbEvcZesBtY=;
 b=cmlfkw+UxmYB1eg4pqaJTwt1AQnN36XCNcOlyEaACq/B0RtErY0DXwfT1W8rcwgtAF
 TrsCzp25aZNj6nuMChk71L9uyETY6mH8lNNzujcJv8MBwTz6TanxYX2QVXSFIpepexl5
 FHrPbInMPu4SK25Ola+znUBiTxgq+HBFNB+vLZQJhdIxdvtnfYUsGatHKj6F7Xdcphvk
 Pi8WYh2f893nHs3+YvcTSxS99lA8FfkbAZEnMe4iTvZl26GPr5+BBWfO/ZokBRGvH22H
 pHdp+XXUzGsbCaXQ1jqeBFy+HaM0fvZRQ++l7vLG74OIchZlGT+5+5HHVV9ipEwuG3xr
 CIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UnCpLXb0Tm7zqYonWzBKX7Cm2ohAULA3NbEvcZesBtY=;
 b=dmcxPGu5GOPPdDyhjzLKYj8KlAvt2YJiFPpwJ7unu7gUTnLcRtRHWvHFfY/JpGZ5Hd
 APJY6Fl3l+cGXmlthH8ZvK9ib09yIkthdVbvdmbaG43kqORgXvhIZeCGLjv+/6/eXE4s
 Gv9lIfUdNjL0jZVnOdtSJki09zs28o/lWdgu+jnyNqlurkOkUWUAeon9G/Rb5zros/9+
 x5mQGOPG6kbj2rja0lIxUIRHWnu8yVihZrUNW4pkHwRBWQKfWeLSbbmQyaBcpksYwvH4
 4YXoAbGxbD59CUFJ3xRzcRo7oUAcd66sU+foj1sjPTkpzU0J581H9X8ujNt4OU1mSCH+
 /plQ==
X-Gm-Message-State: APjAAAXS5DdE1R5Jf8MQ5ZaUMWWKmfZ2WMjBEYl3Voh+U+zLgiLO62IN
 iJh4JhxMK2nrPSyLICTGQtsmUsc+
X-Google-Smtp-Source: APXvYqw1nJML7gWX3bDJQiG/VM9+Xd81sza3z6nUwPvGjRpiW5OXuN0j9+xSPvSna1S2a8yCBZAnZg==
X-Received: by 2002:a25:24e:: with SMTP id 75mr1832900ybc.357.1565835003408;
 Wed, 14 Aug 2019 19:10:03 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:02 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:08:52 -0400
Message-Id: <20190815020928.9679-11-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [RFC PATCH v3 10/46] target/i386: add vector register
 file alignment constraints
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

gvec operations require that all vectors be aligned on 16-byte
boundary; make sure the MM/XMM/YMM/ZMM register file is aligned as
neccessary.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/cpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8b3dc5533e..cb407b86ba 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1199,9 +1199,9 @@ typedef struct CPUX86State {
     float_status mmx_status; /* for 3DNow! float ops */
     float_status sse_status;
     uint32_t mxcsr;
-    ZMMReg xmm_regs[CPU_NB_REGS == 8 ? 8 : 32];
-    ZMMReg xmm_t0;
-    MMXReg mmx_t0;
+    ZMMReg xmm_regs[CPU_NB_REGS == 8 ? 8 : 32] QEMU_ALIGNED(16);
+    ZMMReg xmm_t0 QEMU_ALIGNED(16);
+    MMXReg mmx_t0 QEMU_ALIGNED(8);
 
     XMMReg ymmh_regs[CPU_NB_REGS];
 
-- 
2.20.1


