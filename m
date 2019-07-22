Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B683BC76190
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 15:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83170204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 15:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BYAkNYV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83170204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpa5K-0003ty-9R
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 11:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46765)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hpa4o-0002hv-FY
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hpa4n-00023G-AT
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:18:10 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35935)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hpa4n-00022A-1L
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:18:09 -0400
Received: by mail-wr1-x442.google.com with SMTP id n4so39913882wrs.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 08:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OYBMZusYqESde0qHUOjc4d/ttVAW59Cu3YSqerf0Vp0=;
 b=BYAkNYV/IKOanaijq53MZGBHOwjZxQ+QrPknvcXKF1JZrvOoF3xLjGRjSv+AOSGWWr
 3wLEJvLq83zDi3Tr8DYh0kP6legijgYfAJ5pic8mCSgAodAS6hbCPfYrbOLQihe6mUf6
 MIShX/Qg7GRlEYWKZt+LLOugBAxF25tAVs5nrVUg8VOFth7YlXqYduETHvOREtxDPe0P
 n4lqU/hFR4Y/kp6XQDjnOjjegGATmq7/Hokrx9zDtu8zkY6/zaSbsTU9O7BHi+omt/gU
 9ntK94Dc+SyGsCmyvxiGABsFDTE5cD8LNcWcqXUGiUH06LI2jlKf6BetGmbtRTqIWNXZ
 7ToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OYBMZusYqESde0qHUOjc4d/ttVAW59Cu3YSqerf0Vp0=;
 b=iBTuvid7wHSfczpIKFQbsYUJhHTftDllbkFBQUECRPDD3g/nv0p62+EJUKbQzQTwav
 qW1a5ixFiSw2+H/CoMkeWVnWEqMlh0szbx1r3SFFbCBtg39ZFvMtB1GPKXJB4aKjmf/3
 UP7ifk9Imos0jkzp0k64T/SMnNSWiI1ck594yiJX8cJ1jIAQ+WDLYUWiiQ93W9sLVKHB
 Hg0Fns4eahZmtTrutq/5kgEDJMfEtW13BGwRw2QXk5pDUR/Gecf3Cs22hWGQDJP2SjxY
 ncEuARFCiHqbE0RJtg/uxerX/GHuUnTPhxkXbTB6fQTVzyR5FsUR96tRAcIRghQPo8DZ
 SIMw==
X-Gm-Message-State: APjAAAVbuSW/ZpObmhNQaaxSwZ5pqyxW5/JdOMB3Ut9Qa++lfqb5yh9l
 Rw5AglC/Js6oP5B5RqVFvBR3SA==
X-Google-Smtp-Source: APXvYqzI7GuB3dzapSKMxvcq6p07C0pinijWXYUGOuzarnssPvIEHv05EXyBFkdFeu/hct0qtVoP6Q==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr72073092wrm.218.1563808687889; 
 Mon, 22 Jul 2019 08:18:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s15sm23163990wrw.21.2019.07.22.08.18.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 22 Jul 2019 08:18:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 22 Jul 2019 16:18:03 +0100
Message-Id: <20190722151804.25467-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722151804.25467-1-peter.maydell@linaro.org>
References: <20190722151804.25467-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH for-4.1? 1/2] hw/arm/boot: Rename elf_{low,
 high}_addr to image_{low, high}_addr
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename the elf_low_addr and elf_high_addr variables to image_low_addr
and image_high_addr -- in the next commit we will extend them to
be set for other kinds of image file and not just ELF files.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 1fb24fbef27..b7b31753aca 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -986,7 +986,9 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
     int kernel_size;
     int initrd_size;
     int is_linux = 0;
-    uint64_t elf_entry, elf_low_addr, elf_high_addr;
+    uint64_t elf_entry;
+    /* Addresses of first byte used and first byte not used by the image */
+    uint64_t image_low_addr, image_high_addr;
     int elf_machine;
     hwaddr entry;
     static const ARMInsnFixup *primary_loader;
@@ -1014,24 +1016,24 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
         info->nb_cpus = 1;
 
     /* Assume that raw images are linux kernels, and ELF images are not.  */
-    kernel_size = arm_load_elf(info, &elf_entry, &elf_low_addr,
-                               &elf_high_addr, elf_machine, as);
+    kernel_size = arm_load_elf(info, &elf_entry, &image_low_addr,
+                               &image_high_addr, elf_machine, as);
     if (kernel_size > 0 && have_dtb(info)) {
         /*
          * If there is still some room left at the base of RAM, try and put
          * the DTB there like we do for images loaded with -bios or -pflash.
          */
-        if (elf_low_addr > info->loader_start
-            || elf_high_addr < info->loader_start) {
+        if (image_low_addr > info->loader_start
+            || image_high_addr < info->loader_start) {
             /*
-             * Set elf_low_addr as address limit for arm_load_dtb if it may be
+             * Set image_low_addr as address limit for arm_load_dtb if it may be
              * pointing into RAM, otherwise pass '0' (no limit)
              */
-            if (elf_low_addr < info->loader_start) {
-                elf_low_addr = 0;
+            if (image_low_addr < info->loader_start) {
+                image_low_addr = 0;
             }
             info->dtb_start = info->loader_start;
-            info->dtb_limit = elf_low_addr;
+            info->dtb_limit = image_low_addr;
         }
     }
     entry = elf_entry;
-- 
2.20.1


