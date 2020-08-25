Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF766C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:03:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 834BE20665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AZrtnXIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834BE20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAg6c-0003hX-OK
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg2v-0006qM-Cy
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 16:59:57 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:33840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg2t-0001bg-Oo
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 16:59:57 -0400
Received: by mail-pj1-x1044.google.com with SMTP id n3so105269pjq.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 13:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2WmsQs1dYriEEFTKVUq6JHveLUFEQ0EEc9cZlXDrRq8=;
 b=AZrtnXIvt95MnL+SGFF2mFyi7y/3QiSRmo7M5RREpvC7eM1q+MnG96rBCssXY2ArTa
 9rMn/xKOe2em9aRbmtGIwoXM/62SqYqsGlvqeEVQzYBAd3q9iHU3mn27uFZNrN1ZW+mU
 /v+09EbKs/YrXdpQLHeLbvUWfC0U58Sv/zg9rt6Nq9bkIw/QMPGoLZ74yyGXHBlSHfqW
 pC2C/oIHomGidzl8iiGKFg72NiwZBnWlq+3I6nyH60cWQ25UFqgMspYcEWgEt1XUVXkz
 6zoGiQOiVDPjLlVQMSudp8R9lylP3zVbjZFmNEbVSYXa2IcSNSNyTkLYHPEQLtN+PkYP
 wtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2WmsQs1dYriEEFTKVUq6JHveLUFEQ0EEc9cZlXDrRq8=;
 b=r6S2oo6Z1FUUbd8RTePQ+4OdsuxlfhH4fcTn9bGTzej8V6vuczaKhuzfyIv/KIT3G3
 JQNxwbbLNI6cBj5x0Kqj/tPAcM/1H5m5fcpsORIoSa241PprvtvqCcRleqAKOmElHeWq
 DhXBu+0h50GBoxYkXcQt8nn4W9HFNg40+DHNserGjZvXSexJqqy6lbPnVAZf5EozlIDs
 0yczwjRXe/ZURIUL8VcVcyJatGOytog/okSmzE5CyMjjgXxVdcnS9n50EHbzE+Is6YS2
 w0YVwBf6YYn7qVfG7wzwleNcTUOEJoqXbx1FtBEn4gHVXYnu/hIDtoWrXtkhZg7pPg3I
 RJ5Q==
X-Gm-Message-State: AOAM532Fy703yzT9zdkzJMQsOfHKqbHlarxiLwI+PsJEfq+nu4/8sPqw
 qiy54iffbBo1BOXFnAvXirvqYge97MMFoA==
X-Google-Smtp-Source: ABdhPJxGs5OSlHnoKPCPMNrEFiw0lYhVJwxs3ZQEeAbqp7Q42/W41X9bmQsl8vM8zgM3118cD0vSeQ==
X-Received: by 2002:a17:90a:de10:: with SMTP id
 m16mr3095422pjv.34.1598389193949; 
 Tue, 25 Aug 2020 13:59:53 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.13.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 13:59:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/77] tests/tcg: Add microblaze to arches filter
Date: Tue, 25 Aug 2020 13:58:34 -0700
Message-Id: <20200825205950.730499-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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
Cc: edgar.iglesias@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Not attempting to use a single cross-compiler for both
big-endian and little-endian at this time.

Cc: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/configure.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index 7d714f902a..598a50cd4f 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -94,7 +94,7 @@ for target in $target_list; do
     xtensa|xtensaeb)
       arches=xtensa
       ;;
-    alpha|cris|hppa|i386|lm32|m68k|openrisc|riscv64|s390x|sh4|sparc64)
+    alpha|cris|hppa|i386|lm32|microblaze|microblazeel|m68k|openrisc|riscv64|s390x|sh4|sparc64)
       arches=$target
       ;;
     *)
-- 
2.25.1


