Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9252CC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:46:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6298E216E3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjsCK22p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6298E216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjV6Z-0000cj-J3
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 16:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33816)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUiI-0002Sv-KT
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUiH-0001dh-Mn
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:21:46 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:35567)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hjUiH-0001cx-Gb
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:21:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id l2so3528396wmg.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 13:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UHc1AWBOadewTEukk6xNWZCM4+ZLGS/wJxEaP2onOLs=;
 b=LjsCK22pv1uN8WBKKJS6KgnvSnHCbMUyPFro9GaDWH02FTncOGU7xExugoOqd6Fwx1
 sPQ1Vtqgc9tTpmuQyHzWKw6LfAa289EYaAm4f3jLkr2GWguK7Uvm1gA5ZQWVg9mBllNz
 m5xscpZzrmTxytxFZ6q2sJa9SsINM//GYrDrEI6o2hGT93yYno+iAIeS8OmWdM0yV6a8
 neTe7j1WK74fu2OQjOJliXeYZtlrrysfXL64k+Xzmc0bxv9g5c5ilpqfy0v5Br1B8pii
 nNYbsBi0pRzQ5VKJFLuAT8q37iv4afHFgpvB9yoyqQKo/hTw4AM57e0z7SUIKBXVLAKX
 MFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=UHc1AWBOadewTEukk6xNWZCM4+ZLGS/wJxEaP2onOLs=;
 b=RBdlraDCSzGJjiW4zkydcGv+uHK8H7AlxLEQJgsm7LpmNYa51ZBb9vmAmwoiQCrJPD
 Sm11U9pEUFd80xuj/EjQ9QrVnuEDAJ2FpwQyTawuMkpfTwDonOL21SmqvM12XTApNBhc
 kUQdvyzsf870lTh92qfrwGE11dkzXCMRjaqKnW1qY0VvcZH9AHcSzVVoZu83ewHCuEVL
 qo66TiMkDrBeYHVjK/B6IF6Vg5r5OB/2J49gccQtWEioRjySvmOVhTvyyckqPrRwZ8Hq
 MszFrXiaFVRUwgIxqrm4g6JsbTZwTBDTZKV4DylEYTTe/YNbD5+a7q29bsWrfNpH7Z35
 Bnlg==
X-Gm-Message-State: APjAAAUh68uWQKWMjI0vTmZfILnpu1kl12E9Pu4D2l0bmx52L+GkqxX/
 fu+KKFKY1iUzOsudxWu2R/M+2sXcLOY=
X-Google-Smtp-Source: APXvYqyGGrqnfPd3w8Ws2E50Y53uMNgFZGfw9O3Afeg6yhbXkSGoe9xHl298x7EnftUciR3Q3tHLRQ==
X-Received: by 2002:a1c:f918:: with SMTP id x24mr4373665wmh.132.1562358104236; 
 Fri, 05 Jul 2019 13:21:44 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id l9sm5582926wmh.36.2019.07.05.13.21.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 13:21:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 22:21:40 +0200
Message-Id: <1562358100-27171-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562358100-27171-1-git-send-email-pbonzini@redhat.com>
References: <1562358100-27171-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
Subject: [Qemu-devel] [PATCH v3 2/2] hw/i386: Fix linker error when ISAPC is
 disabled
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
Cc: Julio Montes <julio.montes@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Julio Montes <julio.montes@intel.com>

v2: include config-devices.h to use CONFIG_IDE_ISA

Message-Id: <20190705143554.10295-2-julio.montes@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Julio Montes <julio.montes@intel.com>
---
 hw/i386/pc_piix.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c07c4a5..cc04c01 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "config-devices.h"
 
 #include "qemu/units.h"
 #include "hw/hw.h"
@@ -61,9 +62,11 @@
 
 #define MAX_IDE_BUS 2
 
+#ifdef CONFIG_IDE_ISA
 static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
 static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
 static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
+#endif
 
 /* PC hardware initialisation */
 static void pc_init1(MachineState *machine,
@@ -254,7 +257,10 @@ static void pc_init1(MachineState *machine,
         }
         idebus[0] = qdev_get_child_bus(&dev->qdev, "ide.0");
         idebus[1] = qdev_get_child_bus(&dev->qdev, "ide.1");
-    } else {
+        pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
+    }
+#ifdef CONFIG_IDE_ISA
+else {
         for(i = 0; i < MAX_IDE_BUS; i++) {
             ISADevice *dev;
             char busname[] = "ide.0";
@@ -268,9 +274,9 @@ static void pc_init1(MachineState *machine,
             busname[4] = '0' + i;
             idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
         }
+        pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
     }
-
-    pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
+#endif
 
     if (pcmc->pci_enabled && machine_usb(machine)) {
         pci_create_simple(pci_bus, piix3_devfn + 2, "piix3-usb-uhci");
-- 
1.8.3.1


