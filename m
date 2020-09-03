Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F08C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F018206C0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pw6ju/X3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F018206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDvlk-0001O6-BO
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 16:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDvj7-0006EF-Tx
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 16:20:57 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41033)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDvj6-00085J-4x
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 16:20:57 -0400
Received: by mail-wr1-x444.google.com with SMTP id w5so4549786wrp.8
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 13:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cAXCKGC6VbvlDmQ7gtrKURJrxX8tvf9unlVaP2aE39c=;
 b=pw6ju/X3lBFbTFamqIZYwJnw6UGjyzawXYbBlpmmrV8aNUHdz9LHdf5N0cvyHIAvOw
 MwTtdkO42RuTV51u0RH3IeCPiMU8ijrOUIpjKXG0LXcf4uHZjpGwvoHgZcf3sQBlX4Jj
 /lUvTm2+lw4OJXeEdO2itLDNLjyQ7dalndm4e4+q5PmqjrIk2BS0kudPm4di/qmxRJEg
 9kcJpZV68k1sWzX0GFvUK3zT8w5RN+H56R+C1KYORnOtOSmGyRf+N95F6ZXyP7KVJLku
 E4J8F/bk9t235GZcJMwRjx1q88oiTfsj8tY3yH9xm9YJzxrUeNEFb9HktSfU1/S8RzsS
 Ri6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cAXCKGC6VbvlDmQ7gtrKURJrxX8tvf9unlVaP2aE39c=;
 b=iL+HzkKGPs/lA51abvBpMJJirlgNzlDGbTEiBqEUrFESj/b/dEZ5dxR7H45oFq0xJT
 NePKNTw/95TXE/LZiY9YFZx9wrp37YKU1ittFUxEK101MX/dsJSxPcqidiiMXNYilcEk
 Euf14FjpWUi0sDxyh9L5SXNLy1YbrWQ5XuZSgJ7qe2Yy3FOBDpcT5ad4XMlYalyu7Fl9
 +glucbucoWIP5TUB0HoF1MlYjmHEgSVOWslbCsEbe+riFxAVGZzdo4eNj2TrQtRSpFbp
 HWrn+GbTYT2r5mHgODM+s9N2qpbfCrSBiLVrllKNq4ETIRoXkq3hlZJok+0+3yZGIO5e
 ze8w==
X-Gm-Message-State: AOAM531m1/ZyFWkyMaKN2UY613cbL1KC749v7tjt8yhULvXJhPVJsVq2
 vhoUHkrna7y9VezMyuhp1+nOAQ==
X-Google-Smtp-Source: ABdhPJxIGAN3pAeVfdbR20vNKGZLdfN9gKVwURb5u3+enOhEq5cahbjBJKQ1ZzPfmAPp6UdIWErlpQ==
X-Received: by 2002:adf:8187:: with SMTP id 7mr4243412wra.266.1599164454877;
 Thu, 03 Sep 2020 13:20:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p14sm7285023wrg.96.2020.09.03.13.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 13:20:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] docs/system/arm/mps2.rst: Make board list consistent
Date: Thu,  3 Sep 2020 21:20:48 +0100
Message-Id: <20200903202048.15370-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200903202048.15370-1-peter.maydell@linaro.org>
References: <20200903202048.15370-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kumar Gala <kumar.gala@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the list of MPS2 boards consistent in the phrasing of each
entry, use the correct casing of "Arm", and move the mps2-an511
entry so the list is in numeric order.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/mps2.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/docs/system/arm/mps2.rst b/docs/system/arm/mps2.rst
index 7f2e9c8d52e..8c5b5f1fe07 100644
--- a/docs/system/arm/mps2.rst
+++ b/docs/system/arm/mps2.rst
@@ -11,17 +11,17 @@ as seen by the guest depend significantly on the FPGA image.
 QEMU models the following FPGA images:
 
 ``mps2-an385``
-  Cortex-M3 as documented in ARM Application Note AN385
+  Cortex-M3 as documented in Arm Application Note AN385
 ``mps2-an386``
-  Cortex-M4 as documented in ARM Application Note AN386
+  Cortex-M4 as documented in Arm Application Note AN386
 ``mps2-an500``
-  Cortex-M7 as documented in ARM Application Note AN500
-``mps2-an511``
-  Cortex-M3 'DesignStart' as documented in AN511
+  Cortex-M7 as documented in Arm Application Note AN500
 ``mps2-an505``
-  Cortex-M33 as documented in ARM Application Note AN505
+  Cortex-M33 as documented in Arm Application Note AN505
+``mps2-an511``
+  Cortex-M3 'DesignStart' as documented in Arm Application Note AN511
 ``mps2-an521``
-  Dual Cortex-M33 as documented in Application Note AN521
+  Dual Cortex-M33 as documented in Arm Application Note AN521
 
 Differences between QEMU and real hardware:
 
-- 
2.20.1


