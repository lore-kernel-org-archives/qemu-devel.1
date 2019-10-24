Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD29CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:33:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87164205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o+RzDBN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87164205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgyw-0003av-T9
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfyT-0000AO-Pz
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfyR-00017o-Je
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:33 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfyR-00017d-D0
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:31 -0400
Received: by mail-wr1-x444.google.com with SMTP id r1so17002372wrs.9
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=1dJwftnWoG2W4EHlFbqacOwE41DkQDlktBfsa5t+Z30=;
 b=o+RzDBN+eeMVcg5RR90hEIrRAWIavD1cz2s96JG6cLAUEZroHYqUkNIHm+WV53OGFc
 OT2nWEy1GGrwfwLEeAlZcS334lKZhM4KwlOe4DildIcibRcYlOvY3S6fYZNXFr8OXEb0
 dr+M4asTEO0JqTyFqcNOwpIma0Dc2FQDeF6FvCemHTQWSC9haL6hZGuKfiIW+Jsi0Yb8
 O5UTI9JeyaylfO+TJn0Z7MCtpvKxzVhgH6+Ub9jfZ4nRrZRP3bR6EQAD6+GnU8/m1KPU
 MnZcLBWFIwD/TNNpYmwL2iS/xXwlF28ErXJv8/7NDX8ChTe7lEwBKv3fCZQPc552UAV9
 wLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1dJwftnWoG2W4EHlFbqacOwE41DkQDlktBfsa5t+Z30=;
 b=o4zRgeB6q/NvLk5Rpa0/xLgeUeDnxub5X/ihcdhyhczqlPd0v078Jf/Jl7FzPXZ2qY
 f06ZK14RozlJ4dy2WouUVirDA6FMpmNJMy3nIKCiWUKajdMQY3eA4Z5rY0KEG53Aapd/
 WbWTY0kiGWtJgdNtU8++d9g+k8Uq4x2fNTHyVUm/GPAXK8SZwFUg82WjvTdOi1/EnUza
 BbcDnn0X23x7BXyjP36zGuNoe8/WGQf0p8IvlYzXPw9BJaYwhDqedwH2QS0Fw+U0CQjj
 fzl7USPvHCKrxZ6aXmcarv91Exf3Ge7zX3FoL6m2fZjvMwC6Ro7fJzX4ZBLRJBychkQR
 xEdg==
X-Gm-Message-State: APjAAAXxU45QzZEIi01rFFzjVzGTk3GxzjOq2FXZH6UHWP48p2FeGPGb
 ihD/2/Ska89v+tobbhLmEiz5u/F8nyI=
X-Google-Smtp-Source: APXvYqykSAcFI9C59gKswgeyeg6Pa9ib3QUOlXAy/dAIFZ16lq8LKhPCUH5oXcZ1C6AOtMErftZFwA==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr4585736wrn.307.1571934510211; 
 Thu, 24 Oct 2019 09:28:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.28.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:28:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 50/51] hw/arm/raspi: Use AddressSpace when using
 arm_boot::write_secondary_boot
Date: Thu, 24 Oct 2019 17:27:23 +0100
Message-Id: <20191024162724.31675-51-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

write_secondary_boot() is used in SMP configurations where the
CPU address space might not be the main System Bus.
The rom_add_blob_fixed_as() function allow us to specify an
address space. Use it to write each boot blob in the corresponding
CPU address space.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20191019234715.25750-11-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 615d7558790..6a510aafc19 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -60,12 +60,14 @@ static void write_smpboot(ARMCPU *cpu, const struct arm_boot_info *info)
     QEMU_BUILD_BUG_ON((BOARDSETUP_ADDR & 0xf) != 0
                       || (BOARDSETUP_ADDR >> 4) >= 0x100);
 
-    rom_add_blob_fixed("raspi_smpboot", smpboot, sizeof(smpboot),
-                       info->smp_loader_start);
+    rom_add_blob_fixed_as("raspi_smpboot", smpboot, sizeof(smpboot),
+                          info->smp_loader_start,
+                          arm_boot_address_space(cpu, info));
 }
 
 static void write_smpboot64(ARMCPU *cpu, const struct arm_boot_info *info)
 {
+    AddressSpace *as = arm_boot_address_space(cpu, info);
     /* Unlike the AArch32 version we don't need to call the board setup hook.
      * The mechanism for doing the spin-table is also entirely different.
      * We must have four 64-bit fields at absolute addresses
@@ -92,10 +94,10 @@ static void write_smpboot64(ARMCPU *cpu, const struct arm_boot_info *info)
         0, 0, 0, 0
     };
 
-    rom_add_blob_fixed("raspi_smpboot", smpboot, sizeof(smpboot),
-                       info->smp_loader_start);
-    rom_add_blob_fixed("raspi_spintables", spintables, sizeof(spintables),
-                       SPINTABLE_ADDR);
+    rom_add_blob_fixed_as("raspi_smpboot", smpboot, sizeof(smpboot),
+                          info->smp_loader_start, as);
+    rom_add_blob_fixed_as("raspi_spintables", spintables, sizeof(spintables),
+                          SPINTABLE_ADDR, as);
 }
 
 static void write_board_setup(ARMCPU *cpu, const struct arm_boot_info *info)
-- 
2.20.1


