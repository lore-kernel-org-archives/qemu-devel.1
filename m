Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E758DC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C69206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OoxFesnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C69206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoTC-0008AE-8l
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:23:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFX-0007TA-B6
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFW-0007b4-6z
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:15 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39898)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFW-0007YI-0v
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:14 -0500
Received: by mail-wr1-x442.google.com with SMTP id y11so6713523wrt.6
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=0cxUjenX4Zcy7AbEng8uMiqxruOg2URtl6WiQlwztWY=;
 b=OoxFesnGk7aZGqX+4z+XcMIf2Zw6/yhJbnwffVqohS6sknLVmcjQa1qnyCk5tly0T8
 oKJ2AbXA1xbA3sA8iOH2LF1aiRlY/KjmFblEyPf8gCD62BOfkirRwtrBp9VzfudrWHh6
 2VowCLgf7xAFZNmrl8Zx+gGvWmJKRbeQILpGkBeqClAc4v2Hj+70XT5Y9Gd8LAaihqye
 BGAZC/FgLoO8uYRVOzaIy+sPCIKsmWgvzZBWfU8M5/i7WMeM1j9N98/Ulr3fdhSMkSDP
 eze2BK3wMnYpsYrtN1sC4KFPUCuZ4NS3EcfJj//IEn3kxIo44vYs0beGknqBMyKXxG3V
 EYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0cxUjenX4Zcy7AbEng8uMiqxruOg2URtl6WiQlwztWY=;
 b=qIb8lN+W865esFVA8gyzG+zV2hk9MhTWuIAwJbAJiHbLaKpLjDCkcqv8Qse3XEBNm6
 2T296U9aBtjG+eKSAMcckx1ixiLOz2uR7VvjJTW76CDHdEJI+Vg+bEsiEMJ7zWpkZ1n8
 j63IRlSh1bCFtow7DgMAdSBfyN1AqUnnZZjeH1dfEGYadnLPsbQPux0kLzpD1pVyZyDt
 U5nkrNTt1O79lJvINGaCpjBdAHWCb3+QLfbwOAEfPr+bJSPHUb1cPzjn+oE01Xra4D7a
 qrlHnMz7uBbyUrU8r1vsxCsjeuvTllMSof5Q3HAzXZ64ahz5puHKXguH/ldfe4/pDRep
 jtWg==
X-Gm-Message-State: APjAAAWyHYwAIw3o8D6ySDo39zLr3fubPyXTmPGBaV88ep1x/9Ke6yMO
 ELCNsEFdsjmZrLqHoWeSNmHMPYeMs71Ajw==
X-Google-Smtp-Source: APXvYqw1M1vy7qsausKz7j5BSxRAAK15Z8Veu16u8eDJITKC5JSbzcuNbkU07XXFHJrJ1bBI3jBZxQ==
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr30537669wrw.25.1576494549841; 
 Mon, 16 Dec 2019 03:09:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/34] exynos4210_gic: Suppress gcc9 format-truncation warnings
Date: Mon, 16 Dec 2019 11:08:32 +0000
Message-Id: <20191216110904.30815-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

From: David Gibson <david@gibson.dropbear.id.au>

exynos4210_gic_realize() prints the number of cpus into some temporary
buffers, but it only allows 3 bytes space for it.  That's plenty:
existing machines will only ever set this value to EXYNOS4210_NCPUS
(2).  But the compiler can't always figure that out, so some[*] gcc9
versions emit -Wformat-truncation warnings.

We can fix that by hinting the constraint to the compiler with a
suitably placed assert().

[*] The bizarre thing here, is that I've long gotten these warnings
    compiling in a 32-bit x86 container as host - Fedora 30 with
    gcc-9.2.1-1.fc30.i686 - but it compiles just fine on my normal
    x86_64 host - Fedora 30 with and gcc-9.2.1-1.fc30.x86_64.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[PMM: deleted stray blank line]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/exynos4210_gic.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
index a1b699b6bab..9a84d8522e9 100644
--- a/hw/intc/exynos4210_gic.c
+++ b/hw/intc/exynos4210_gic.c
@@ -293,6 +293,7 @@ static void exynos4210_gic_realize(DeviceState *dev, Error **errp)
     char cpu_alias_name[sizeof(cpu_prefix) + 3];
     char dist_alias_name[sizeof(cpu_prefix) + 3];
     SysBusDevice *gicbusdev;
+    uint32_t n = s->num_cpu;
     uint32_t i;
 
     s->gic = qdev_create(NULL, "arm_gic");
@@ -313,7 +314,13 @@ static void exynos4210_gic_realize(DeviceState *dev, Error **errp)
     memory_region_init(&s->dist_container, obj, "exynos4210-dist-container",
             EXYNOS4210_EXT_GIC_DIST_REGION_SIZE);
 
-    for (i = 0; i < s->num_cpu; i++) {
+    /*
+     * This clues in gcc that our on-stack buffers do, in fact have
+     * enough room for the cpu numbers.  gcc 9.2.1 on 32-bit x86
+     * doesn't figure this out, otherwise and gives spurious warnings.
+     */
+    assert(n <= EXYNOS4210_NCPUS);
+    for (i = 0; i < n; i++) {
         /* Map CPU interface per SMP Core */
         sprintf(cpu_alias_name, "%s%x", cpu_prefix, i);
         memory_region_init_alias(&s->cpu_alias[i], obj,
-- 
2.20.1


