Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34053C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2B1E2084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wegP1t44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B1E2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48324 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hctGL-0000zN-I0
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 11:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46579)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiF-0003RW-Ms
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiE-0007zt-9R
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:23 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33072)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcsiD-0007xa-UH
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:22 -0400
Received: by mail-wm1-x344.google.com with SMTP id h19so117900wme.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=OwEVsvj6AmcZtJrR0oDBzLmj1hc9aGGjVH7CWfs5T2E=;
 b=wegP1t44P2f0nUSY72d/uE57QLjqjC37ewmdo3sooKaNpoK8SLdF3qf6xqGtYIHie8
 SpRfUgYlqvQ5pJC/5K0Up6Dy0UaOSSr/JLYwjoagiNC7m+sdTVnHJC3dyD2PIUpM2J4V
 vYTRs974RysUekh/crvCRYKuf1phnSqYQ959ZXXUEj9RHYAs1yOEL6BWkyqjX3e+KNUv
 8Ccwrqe3tPfeKPuBM7YsYhTMEKtPS36/ZJBjrP1kfj2sLn4wJd3UB5OOqXqqVqHnwiHB
 AjT6T4AArSH99Gf3ltwRNBPYMicBqlIenD21KdKINhmGrHwn1/44CBy1WJp1aNhEMSY8
 6OzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OwEVsvj6AmcZtJrR0oDBzLmj1hc9aGGjVH7CWfs5T2E=;
 b=eucoFsnKLqUugIn/uNS4hkqOqpAc+exzo/eBvoGyisP9Eb/Sk7glbS62yqNgwuwJXf
 S/Y6ZnIGFb+uhfRnT/ea01PPi0lEVYcIvcjQfDzKCYPPRpUUL3rlLjwDtVc+haWdEdoo
 L4jVTAZ5G7UX9FzKzQC1f0AtrN0yzNRNX6N/gOUNIOOetSJTmq0tkDqpOfdZZWQDZiGV
 JkNYZ/CmDBiORe/ySgTluY8K1T+CBmo2NH6jyB3b5n2/47YvGn3S4pTni6F87JAvvueK
 YD0rg/U5w7dsddECrQwJNjYHXOLok4d/tkQkP96xUK9r+Fy8UKz824WaV/B324q7eD3w
 aG9w==
X-Gm-Message-State: APjAAAVthE94w9V91eZGvb/iBOYQ4lw2spMgz64i6T/UkEW/d2JQuq+a
 /VbsdAPoT7jLXzoguudZQnCU1hHQN8NeCg==
X-Google-Smtp-Source: APXvYqyBHeK3y+ZffJoIj3AQmnFI9/femIaDF7I7SArTLOMJCQcGZIEhi8L8CLPWFNmEpiff0x+m8w==
X-Received: by 2002:a1c:9d86:: with SMTP id g128mr20844483wme.51.1560782058298; 
 Mon, 17 Jun 2019 07:34:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a67sm13819985wmh.40.2019.06.17.07.34.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:34:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:33:51 +0100
Message-Id: <20190617143412.5734-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617143412.5734-1-peter.maydell@linaro.org>
References: <20190617143412.5734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PULL 03/24] hw/arm/boot: Avoid placing the initrd on
 top of the kernel
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

We currently put the initrd at the smaller of:
 * 128MB into RAM
 * halfway into the RAM
(with the dtb following it).

However for large kernels this might mean that the kernel
overlaps the initrd. For some kinds of kernel (self-decompressing
32-bit kernels, and ELF images with a BSS section at the end)
we don't know the exact size, but even there we have a
minimum size. Put the initrd at least further into RAM than
that. For image formats that can give us an exact kernel size, this
will mean that we definitely avoid overlaying kernel and initrd.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Message-id: 20190516144733.32399-4-peter.maydell@linaro.org
---
 hw/arm/boot.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 5ddba727d45..a0e1110719e 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -1000,20 +1000,6 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
     if (info->nb_cpus == 0)
         info->nb_cpus = 1;
 
-    /*
-     * We want to put the initrd far enough into RAM that when the
-     * kernel is uncompressed it will not clobber the initrd. However
-     * on boards without much RAM we must ensure that we still leave
-     * enough room for a decent sized initrd, and on boards with large
-     * amounts of RAM we must avoid the initrd being so far up in RAM
-     * that it is outside lowmem and inaccessible to the kernel.
-     * So for boards with less  than 256MB of RAM we put the initrd
-     * halfway into RAM, and for boards with 256MB of RAM or more we put
-     * the initrd at 128MB.
-     */
-    info->initrd_start = info->loader_start +
-        MIN(info->ram_size / 2, 128 * 1024 * 1024);
-
     /* Assume that raw images are linux kernels, and ELF images are not.  */
     kernel_size = arm_load_elf(info, &elf_entry, &elf_low_addr,
                                &elf_high_addr, elf_machine, as);
@@ -1065,6 +1051,26 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
     }
 
     info->entry = entry;
+
+    /*
+     * We want to put the initrd far enough into RAM that when the
+     * kernel is uncompressed it will not clobber the initrd. However
+     * on boards without much RAM we must ensure that we still leave
+     * enough room for a decent sized initrd, and on boards with large
+     * amounts of RAM we must avoid the initrd being so far up in RAM
+     * that it is outside lowmem and inaccessible to the kernel.
+     * So for boards with less  than 256MB of RAM we put the initrd
+     * halfway into RAM, and for boards with 256MB of RAM or more we put
+     * the initrd at 128MB.
+     * We also refuse to put the initrd somewhere that will definitely
+     * overlay the kernel we just loaded, though for kernel formats which
+     * don't tell us their exact size (eg self-decompressing 32-bit kernels)
+     * we might still make a bad choice here.
+     */
+    info->initrd_start = info->loader_start +
+        MAX(MIN(info->ram_size / 2, 128 * 1024 * 1024), kernel_size);
+    info->initrd_start = TARGET_PAGE_ALIGN(info->initrd_start);
+
     if (is_linux) {
         uint32_t fixupcontext[FIXUP_MAX];
 
-- 
2.20.1


