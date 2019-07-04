Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16547C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 14:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF7082083B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 14:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jotr24d/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF7082083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj2c9-0004ii-OL
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 10:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57571)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hj2an-00037m-2f
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 10:20:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hj2al-0006kx-WC
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 10:20:09 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38044)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hj2al-0006kL-OZ
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 10:20:07 -0400
Received: by mail-wm1-x343.google.com with SMTP id s15so6366400wmj.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 07:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=y2vuXrmq/JT4NCIyF08AXa1zIQrKXhKE3HksSwRif84=;
 b=jotr24d/ZHImENcxd5LAOPtbpUgTnqn5wNT8asuaodhkC54AjrSl+/Nu5cN9FDMaGt
 2YD6zvlf9yrEXFOTTZ/Hb0QTCeWd+n/+PN7OpSBMRiBEB7t0n8b1G78jwoemJVN0ZGTV
 xy5pn1YPTEXirxcM49g23aT7AGUgKmaGuwpMxFEV7p+wzjKzLIWl0cMXDhv2xRPUekRB
 XHPzPWYhvBeCxeCVvNzbMhaZ1v3c+uiMLlT2Ci3TW4ogVVBGiDZpCcEbEso69/495aqB
 MSUact+9SZXzRHgJPulmwUDdfT7dMHVql+zKDawlER10LxdU3z+GoaaVOo9235aCc5XI
 BfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=y2vuXrmq/JT4NCIyF08AXa1zIQrKXhKE3HksSwRif84=;
 b=m0N/mJ7cN+E7TH26XLBg0ewAG91wn7L8EO1xxkFDgHQLS2gknM5H5SaH/UIUkt+pNr
 f1ErV1o2DFXdQJ2PdM1hOdWpzcETZdMNrlF5Rel/odYOuvdHv9F0sC0GP10cLq4nCR9y
 hA2uBBCOtQzOd2MNzhV/+ACggFhZKdP8H/oCLwJ82nwZTa1HI2YdLshAx3nSba4SIZE1
 qnXi/9lttiEupNAA3cnJxFqIQLda/ygHv7qHbDbwnnn/nfKUw3PuA2a+UFzdVAbMxoTX
 CzJH6skrEMv6OL9EPRK4EUM3Jw92tkyTN75bnW44zFXN/Db0mBlT68zN4JrygNYJSRA0
 8vbQ==
X-Gm-Message-State: APjAAAWbIkcAtI0rcQGqs/YvwWYuG6Sq5kAyLk3eaBGxB6LPAEvAOUsC
 NQbo2fHWR9GnjClnuTfTC/6ixg==
X-Google-Smtp-Source: APXvYqzig1qpi682TS9kUXdyu+tg14JbSDK38zsqiWLjlvQY6V0PWpAAr0sxvWo1P2YurDdS1jeedw==
X-Received: by 2002:a1c:9696:: with SMTP id y144mr12844133wmd.73.1562250006394; 
 Thu, 04 Jul 2019 07:20:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c1sm8917572wrh.1.2019.07.04.07.20.05
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 04 Jul 2019 07:20:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  4 Jul 2019 15:20:04 +0100
Message-Id: <20190704142004.7150-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH for-4.1] hw/arm/sbsa-ref: Remove unnecessary
 check for secure_sysmem == NULL
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
Cc: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Leif Lindholm <leif.lindholm@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the virt machine, we support TrustZone being either present or
absent, and so the code must deal with the secure_sysmem pointer
possibly being NULL. In the sbsa-ref machine, TrustZone is always
present, but some code and comments copied from virt still treat
it as possibly not being present.

This causes Coverity to complain (CID 1407287) that we check
secure_sysmem for being NULL after an unconditional dereference.
Simplify the code so that instead of initializing the variable
to NULL, unconditionally assigning it, and then testing it for NULL,
we just initialize it correctly in the variable declaration and
then assume it to be non-NULL. We also delete a comment which
only applied to the non-TrustZone config.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Not a bug as such, but we should put it in for 4.1 to
keep Coverity happy.
---
 hw/arm/sbsa-ref.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index ee53f0ff60d..6f315b79445 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -254,8 +254,6 @@ static void sbsa_flash_map(SBSAMachineState *sms,
      * sysmem is the system memory space. secure_sysmem is the secure view
      * of the system, and the first flash device should be made visible only
      * there. The second flash device is visible to both secure and nonsecure.
-     * If sysmem == secure_sysmem this means there is no separate Secure
-     * address space and both flash devices are generally visible.
      */
     hwaddr flashsize = sbsa_ref_memmap[SBSA_FLASH].size / 2;
     hwaddr flashbase = sbsa_ref_memmap[SBSA_FLASH].base;
@@ -588,7 +586,7 @@ static void sbsa_ref_init(MachineState *machine)
     SBSAMachineState *sms = SBSA_MACHINE(machine);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     MemoryRegion *sysmem = get_system_memory();
-    MemoryRegion *secure_sysmem = NULL;
+    MemoryRegion *secure_sysmem = g_new(MemoryRegion, 1);
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     bool firmware_loaded;
     const CPUArchIdList *possible_cpus;
@@ -612,13 +610,11 @@ static void sbsa_ref_init(MachineState *machine)
      * containing the system memory at low priority; any secure-only
      * devices go in at higher priority and take precedence.
      */
-    secure_sysmem = g_new(MemoryRegion, 1);
     memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory",
                        UINT64_MAX);
     memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
 
-    firmware_loaded = sbsa_firmware_init(sms, sysmem,
-                                         secure_sysmem ?: sysmem);
+    firmware_loaded = sbsa_firmware_init(sms, sysmem, secure_sysmem);
 
     if (machine->kernel_filename && firmware_loaded) {
         error_report("sbsa-ref: No fw_cfg device on this machine, "
-- 
2.20.1


