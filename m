Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA07FC31E5C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 998072086A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XCTIXWwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998072086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48278 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hctAO-0004nl-0h
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 11:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46568)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiF-0003R4-EU
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiE-0007zi-8i
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:23 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43875)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcsiE-0007wG-0L
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id p13so10198541wru.10
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=s25YCdPicJAtgC6ByMpACHrwGTStXvqFM1wqHAvS9fE=;
 b=XCTIXWwFCofzeErDP/aCakt2vmm0Nm/6r1EQm0FF5qMDyRU+yfQ9EF69LipCRhk7u2
 B8N8j0b8k2Cx50BEjiqdl3hlHEHVPFB1Gqked+jpX4WKFoAUB/6jyQWvZ6nT4bGD/wKq
 8wJWQ3CwhtPqHljI6dj+EmFGL9cK1hlKvwJUUEPBnTM43B6K4TSM5LLvOdJgI63J8O0M
 Po8g6eLthjS6Oja93nGPcASM9pgYlZlrUJomhcr5fn3XqyaALKuBj8OmTpjitZ0i8ct1
 tGQpTInzCl0Jm4qlLynHUfGQaCnTcjBI1UpChHsFDuMNlhx4Jsf5pr4hR1HEqeWI+H6D
 o8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s25YCdPicJAtgC6ByMpACHrwGTStXvqFM1wqHAvS9fE=;
 b=cSXOIRIl1s1IxqgmPjYjI42QGpVHWTevRZHhmm03zaRy01AqHHkOPUV+SnOA1rVCqI
 MpA2hVqg7R842sFLkDOpMugab7kM9Pcztj0y18FSBgUZ1zhYgrHV2PgDPgrohFls1te/
 b4J++kK6ZynQCJjI7OnTrnGhRl9LpbYb/gz6dce6CdBhi69EApiM6ElNS/lUoOgzsA5E
 FeKWKMM6011FS6sWAEWz01RZ3ztSjXrOz8z0c118lF3R1bKipsg6AEBpvqpWKvafLd6q
 cb+aMHJ/nGlpOUlFs8eLcu3RNdNEfwAjgjtkdHwC2QW/fKwofJtd23vy9DaQ1KG4pbDP
 ZvzA==
X-Gm-Message-State: APjAAAVLC8iHdyaTLkJo8wUPCF3/s85lXQkgLP1FfJBpCnSZcpKLKFYh
 5CTLdfdE5Hzv1N5bR12ZQRVItmM+Lpdbgw==
X-Google-Smtp-Source: APXvYqzqCBHfdrOW3toIIUri6HNQywZX52l2TvDNdj/UEjaQFCGWUSpdJawPqxbbyWB3oj0oBArx4g==
X-Received: by 2002:adf:eecf:: with SMTP id a15mr3091759wrp.354.1560782055545; 
 Mon, 17 Jun 2019 07:34:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a67sm13819985wmh.40.2019.06.17.07.34.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:34:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:33:49 +0100
Message-Id: <20190617143412.5734-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617143412.5734-1-peter.maydell@linaro.org>
References: <20190617143412.5734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PULL 01/24] hw/arm/boot: Don't assume RAM starts at
 address zero
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

In the Arm kernel/initrd loading code, in some places we make the
incorrect assumption that info->ram_size can be treated as the
address of the end of RAM, as for instance when we calculate the
available space for the initrd using "info->ram_size - info->initrd_start".
This is wrong, because many Arm boards (including "virt") specify
a non-zero info->loader_start to indicate that their RAM area
starts at a non-zero physical address.

Correct the places which make this incorrect assumption.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Message-id: 20190516144733.32399-2-peter.maydell@linaro.org
---
 hw/arm/boot.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 0261fdabab0..bb37a9383f3 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -977,6 +977,7 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
     int elf_machine;
     hwaddr entry;
     static const ARMInsnFixup *primary_loader;
+    uint64_t ram_end = info->loader_start + info->ram_size;
 
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         primary_loader = bootloader_aarch64;
@@ -1048,8 +1049,7 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
         /* 32-bit ARM */
         entry = info->loader_start + KERNEL_LOAD_ADDR;
         kernel_size = load_image_targphys_as(info->kernel_filename, entry,
-                                             info->ram_size - KERNEL_LOAD_ADDR,
-                                             as);
+                                             ram_end - KERNEL_LOAD_ADDR, as);
         is_linux = 1;
     }
     if (kernel_size < 0) {
@@ -1063,12 +1063,11 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
         if (info->initrd_filename) {
             initrd_size = load_ramdisk_as(info->initrd_filename,
                                           info->initrd_start,
-                                          info->ram_size - info->initrd_start,
-                                          as);
+                                          ram_end - info->initrd_start, as);
             if (initrd_size < 0) {
                 initrd_size = load_image_targphys_as(info->initrd_filename,
                                                      info->initrd_start,
-                                                     info->ram_size -
+                                                     ram_end -
                                                      info->initrd_start,
                                                      as);
             }
-- 
2.20.1


