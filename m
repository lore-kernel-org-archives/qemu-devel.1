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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEC2C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:09:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39FB522D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eu4tlEZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FB522D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0V2t-0001sy-TP
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URM-0001Gj-Ok
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URL-0007eN-LE
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:32 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:41465)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URL-0007e5-Gc
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:31 -0400
Received: by mail-yb1-xb42.google.com with SMTP id 1so900424ybj.8
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qHjUE6hQeSyTtFW1oZQXiyVdSrjm8yWd2Nh58FvFQ8w=;
 b=Eu4tlEZ5OKFmSRfWZfzFzEAwife8C9VegTazhgbcXXfzhGaRgG9IFLmlOae7Jn0w2H
 NHvHYX8Z0BiP0ERQrDnyKQBpRxSeN8eNiAi/d3gxwCVB8IoMOs+kJMLSFqNLJrZhu7WO
 +7umkdgLSBKJiVB3YQ6EKilJCN2Jj5BYTsGTEMNqjKpfQkfNOdBxUQ8I2Oj8CiyaEzAm
 6GFxDk0P0Jzt4EKUje+aoDDy8yh8O/LDXoE/jXSrw/ImWIPwmNZ0GgIMGTPBnmrzoc7f
 9Nuvolg8aOfi7ctpxGBZ9gqW4YvUhMStQeFfqGjfCUYHFyz6gizEfVTyo0csIovxU2Rq
 E98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qHjUE6hQeSyTtFW1oZQXiyVdSrjm8yWd2Nh58FvFQ8w=;
 b=FweTbg3fNBW4PPhH/uD7lo1RKDcJaC08RkqBGWlVsTQzUj3RTCrbpRkay6hjvb819a
 wh1bW7GhBCnk9Af1ryNb1WLPP3hc4qURMgVFuWz8+Kc3J9gns57BpNbKrZbnahjJ2ucI
 bnzvBhD3XCiVsomOaJVWoiUpTq39rjCgtAjk2DNeQkPvWewbasNmp9C0HWHZMP6vRkqv
 ltHW1wltS+RzVr+v7TdkgC0ecvM53d/fiGyXfmxtUjywXW/cye3BkTaVVk9lYP7KKH3f
 GaTCL/UEuT+nBZouex2VaiI6SkTi2LzdukyR0m/dlvWCb8fv7pLgWODXkdx/d4L4UTxN
 JFiw==
X-Gm-Message-State: APjAAAWUsGxKvYB0wcMIp1H1Yl7zyktXix0C7FYciIusol+Z6ziytCHH
 ruihKDk//OHf3tC905W+b41ht+54
X-Google-Smtp-Source: APXvYqxV1OpztZHwK//vcd4rFUr1TgpKMc6SekcT1tz1hVXxf1nWntMlzcMdyZVQfqazlcux9JfnXA==
X-Received: by 2002:a25:bd4e:: with SMTP id p14mr24099030ybm.148.1566408630872; 
 Wed, 21 Aug 2019 10:30:30 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:30 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:06 -0400
Message-Id: <20190821172951.15333-31-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [RFC PATCH v4 30/75] target/i386: alias H* operands
 with the V* operands
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

This effectively means that all thee-operand VEX-encoded instructions
using the VEX.V field will be decoded as their non-VEX-encoded
two-operand equivalents. While this is incorrect, it is the old
behavior, which is useful during development.

Note: This changeset is intended for development only and shall not be
included in the final patch series.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 23ba1d5edd..2e78bed78f 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5215,11 +5215,10 @@ DEF_INSNOP_ALIAS(Uq, U)
 DEF_INSNOP_ALIAS(Udq, U)
 DEF_INSNOP_ALIAS(Uqq, U)
 
-DEF_INSNOP_XMM(H, vex_v)
-DEF_INSNOP_ALIAS(Hd, H)
-DEF_INSNOP_ALIAS(Hq, H)
-DEF_INSNOP_ALIAS(Hdq, H)
-DEF_INSNOP_ALIAS(Hqq, H)
+DEF_INSNOP_ALIAS(Hd, Vd)
+DEF_INSNOP_ALIAS(Hq, Vq)
+DEF_INSNOP_ALIAS(Hdq, Vdq)
+DEF_INSNOP_ALIAS(Hqq, Vqq)
 
 DEF_INSNOP_XMM(L, is4)
 DEF_INSNOP_ALIAS(Ldq, L)
-- 
2.20.1


