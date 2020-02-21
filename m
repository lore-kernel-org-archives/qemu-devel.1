Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4798C35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F9B8206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kcE0vzAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9B8206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58Hy-00087f-PS
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582v-00007J-8l
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582t-00042w-TA
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:45 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46943)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582t-00041B-MV
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:43 -0500
Received: by mail-wr1-x444.google.com with SMTP id z7so1970138wrl.13
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=O5FrGw//Kf20i1r0SXQ2jfWdoET0BPsu80ZZ6EIsSSg=;
 b=kcE0vzAagzRnaipCDzWZc44m78pxWviB+VPBzHHLept3XhAsWpdidQC9jScO0SeYw5
 m/g5/H4GmmrTqyoVSSc6/D5yodn+8VLOYgZ6nOCzGcjWpQdzAKSGT/2N8mAa/HJkTgY4
 N0+9SdBG4El4OcqKzvI8cNw/oZp9ah0k9ARh6Cmy0UChnHga3wMFn+upgJikswD0enPr
 hPLJIhuSB0clNPb/MTWwYqFzl1pzQq+/pBT3DVzm6G2BWoPRV/bkHIOVqHuEp8/ms37w
 93pktYqh61Be1E6mC2grTtZxqVhl7aox9n7ElVhEvRgLUPNuZFNpEVWA8qeTwYkEZXHQ
 cUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O5FrGw//Kf20i1r0SXQ2jfWdoET0BPsu80ZZ6EIsSSg=;
 b=jmZXNDWt2eXZ7lqBn2/O/WwIGrG1rLAlaVUepkWRpbidOVuYZcQ7/qHWG4eLXjkIy8
 h/roZcy08+JmwbaQeWGqd/3Bm8XqgNsI8Ms3gO4HqGhTW9xKz22R3WiyOAl3KfLaj4Sh
 2eXmr211XtCjOqs5DdG3UeVGsY54330wCUybHxaeOz3aD2PAaUnHfo5boyKCj5lWbEvk
 2r3jxyZh6IJO6Tk4npP3aztKendc7BNKEyvKWAwVAbpnms0TNN97cGbRnXViIMWTKJFK
 otlYGB4oQLj+L2o39Sx6/pyU/odBOo60vZt70lCDgslKq7E8X5Md0KWWdQfNWhIvxyjN
 bLmQ==
X-Gm-Message-State: APjAAAVmCeBLT1DjWt6nTIr0XdvLZfMLJnZwCvToBDtTOCn4uV/rktJt
 fi+qWpOrEZsAZ3u6XBJdv5VROChZ0MIWVA==
X-Google-Smtp-Source: APXvYqxp377UelAni/CcZYK8NQmbYfq7yaWa+qNzk8f6U8yyqvUoySkyklzB40dt6r0rQ/0LthZfsw==
X-Received: by 2002:adf:f744:: with SMTP id z4mr43958210wrp.318.1582290515175; 
 Fri, 21 Feb 2020 05:08:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/52] sh4: Fix PCI ISA IO memory subregion
Date: Fri, 21 Feb 2020 13:07:31 +0000
Message-Id: <20200221130740.7583-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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

From: Guenter Roeck <linux@roeck-us.net>

Booting the r2d machine from flash fails because flash is not discovered.
Looking at the flattened memory tree, we see the following.

FlatView #1
 AS "memory", root: system
 AS "cpu-memory-0", root: system
 AS "sh_pci_host", root: bus master container
 Root memory region: system
  0000000000000000-000000000000ffff (prio 0, i/o): io
  0000000000010000-0000000000ffffff (prio 0, i/o): r2d.flash @0000000000010000

The overlapping memory region is sh_pci.isa, ie the ISA I/O region bridge.
This region is initially assigned to address 0xfe240000, but overwritten
with a write into the PCIIOBR register. This write is expected to adjust
the PCI memory window, but not to change the region's base adddress.

Peter Maydell provided the following detailed explanation.

"Section 22.3.7 and in particular figure 22.3 (of "SSH7751R user's manual:
hardware") are clear about how this is supposed to work: there is a window
at 0xfe240000 in the system register space for PCI I/O space. When the CPU
makes an access into that area, the PCI controller calculates the PCI
address to use by combining bits 0..17 of the system address with the
bits 31..18 value that the guest has put into the PCIIOBR. That is, writing
to the PCIIOBR changes which section of the IO address space is visible in
the 0xfe240000 window. Instead what QEMU's implementation does is move the
window to whatever value the guest writes to the PCIIOBR register -- so if
the guest writes 0 we put the window at 0 in system address space."

Fix the problem by calling memory_region_set_alias_offset() instead of
removing and re-adding the PCI ISA subregion on writes into PCIIOBR.
At the same time, in sh_pci_device_realize(), don't set iobr since
it is overwritten later anyway. Instead, pass the base address to
memory_region_add_subregion() directly.

Many thanks to Peter Maydell for the detailed problem analysis, and for
providing suggestions on how to fix the problem.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20200218201050.15273-1-linux@roeck-us.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sh4/sh_pci.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
index 71afd23b679..08f2fc1ddee 100644
--- a/hw/sh4/sh_pci.c
+++ b/hw/sh4/sh_pci.c
@@ -67,12 +67,8 @@ static void sh_pci_reg_write (void *p, hwaddr addr, uint64_t val,
         pcic->mbr = val & 0xff000001;
         break;
     case 0x1c8:
-        if ((val & 0xfffc0000) != (pcic->iobr & 0xfffc0000)) {
-            memory_region_del_subregion(get_system_memory(), &pcic->isa);
-            pcic->iobr = val & 0xfffc0001;
-            memory_region_add_subregion(get_system_memory(),
-                                        pcic->iobr & 0xfffc0000, &pcic->isa);
-        }
+        pcic->iobr = val & 0xfffc0001;
+        memory_region_set_alias_offset(&pcic->isa, val & 0xfffc0000);
         break;
     case 0x220:
         pci_data_write(phb->bus, pcic->par, val, 4);
@@ -147,8 +143,7 @@ static void sh_pci_device_realize(DeviceState *dev, Error **errp)
                              get_system_io(), 0, 0x40000);
     sysbus_init_mmio(sbd, &s->memconfig_p4);
     sysbus_init_mmio(sbd, &s->memconfig_a7);
-    s->iobr = 0xfe240000;
-    memory_region_add_subregion(get_system_memory(), s->iobr, &s->isa);
+    memory_region_add_subregion(get_system_memory(), 0xfe240000, &s->isa);
 
     s->dev = pci_create_simple(phb->bus, PCI_DEVFN(0, 0), "sh_pci_host");
 }
-- 
2.20.1


