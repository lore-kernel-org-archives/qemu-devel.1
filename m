Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0AFC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:27:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0985B21D91
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TvTnE7Pw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0985B21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdbe-0005kS-KW
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:26:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLy-00016b-3D
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:46 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:56090)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLu-0006cN-Q3
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:45 -0500
Received: by mail-wm1-x342.google.com with SMTP id c9so8605713wml.5
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ed/BTbi7euqfL1hXrKVEmFWNJJJT/JBXDy33Yta9R7U=;
 b=TvTnE7PwnkqUuwn6H7RD13+NfZIpEdUkznHeUQeFVQXh39/CqsOxp2fhwC1SbNGTt1
 azfUfYe49rHZeaYdg2cA9XA2MyeaRN2Hfjg0bAYky7o1zlwT7kzHtf+uMEYssZQAD/jB
 D9hKTmHO8sv8ZSCnBqaKsum4fmhxUrnP3X+/ul0mBa6OVykRnRcQ7oT1q5GJ3lT8vgUZ
 1rF0mCfsWpVwVJ5f/bDrYsV90h48ru4alLEOqnQ1wOIa4lSBiOq5yPDMWLU6vs8NmcSq
 8hH7xb8zBjV/gQfuV+hIHLkidyTFEmTlH1w8jWijCXw1TecuraLh9UeqzCb53fTm592D
 O0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ed/BTbi7euqfL1hXrKVEmFWNJJJT/JBXDy33Yta9R7U=;
 b=DcrhwdIBwiLreKbf6Pg0Uo9piqDoDVTmo6GWkZ3cXPFug25JE2aqi89DnCbMTWJt1W
 SzDAIZlCCvSy0Ie4c9zN/PDstF0KOcCVIgke4NmCA9MUIX+Fd1fSL+3z0IMPgNQwE/bJ
 LxPAMapd0gunk2fSnwsNUbLpxj3Of6PcpECfIQMsv8rv9ayTl89B2T3ZjZUQlPAEjLM9
 G0REoAQM3jqwNfpFoV8TvrhOHW7KEclORyT+3/dgvHRtTWZTldo8fu1gNlsRT4ZtI1Dc
 bsjmUlqz44u850AwioZEaUFO9WtXQa5stMsljLEmYCyIFO6oVQYL4vR11sInkDff6t7n
 S3Bw==
X-Gm-Message-State: AOAM531wuBkxSr7OLmJ7Wmp+tsAlN12DBIQ6+tKHnGkVA8jb9sIdvzLM
 fmOqoEC+0L+m4bscGwmOIx1HHUmSY/ekKg==
X-Google-Smtp-Source: ABdhPJxNAaM7Rer+oJ5v+BdkOK1sKxhQLHn/lQa9rsJmRbTvMzSg9xxRtCjS+PI2DzGhweo6IOeCkg==
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr18197607wmh.72.1604337041221; 
 Mon, 02 Nov 2020 09:10:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c18sm22396540wrt.10.2020.11.02.09.10.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:10:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/26] hw/display/exynos4210_fimd: Fix potential NULL pointer
 dereference
Date: Mon,  2 Nov 2020 17:09:59 +0000
Message-Id: <20201102171005.30690-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201102171005.30690-1-peter.maydell@linaro.org>
References: <20201102171005.30690-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: AlexChen <alex.chen@huawei.com>

In exynos4210_fimd_update(), the pointer s is dereferinced before
being check if it is valid, which may lead to NULL pointer dereference.
So move the assignment to global_width after checking that the s is valid.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Alex Chen <alex.chen@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 5F9F8D88.9030102@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/exynos4210_fimd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 4c16e1f5a00..34a960a9765 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -1275,12 +1275,14 @@ static void exynos4210_fimd_update(void *opaque)
     bool blend = false;
     uint8_t *host_fb_addr;
     bool is_dirty = false;
-    const int global_width = (s->vidtcon[2] & FIMD_VIDTCON2_SIZE_MASK) + 1;
+    int global_width;
 
     if (!s || !s->console || !s->enabled ||
         surface_bits_per_pixel(qemu_console_surface(s->console)) == 0) {
         return;
     }
+
+    global_width = (s->vidtcon[2] & FIMD_VIDTCON2_SIZE_MASK) + 1;
     exynos4210_update_resolution(s);
     surface = qemu_console_surface(s->console);
 
-- 
2.20.1


