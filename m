Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40BBC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:57:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B86D2133F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpVZj5Qk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B86D2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjVH9-0000wM-I4
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 16:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34223)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUkJ-0004Pp-UO
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:23:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUkC-0002sG-4v
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:23:46 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:44354)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hjUk5-0002mO-VC
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:23:39 -0400
Received: by mail-wr1-x434.google.com with SMTP id b2so9796769wrx.11
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 13:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UHc1AWBOadewTEukk6xNWZCM4+ZLGS/wJxEaP2onOLs=;
 b=XpVZj5QkjsUZUHqI1s+Tr5NLFxI50bXFE7Ep5ymr7yJoELSGbmAeaU26wsI2Axw/fb
 8ECfvIzLtdfk/QftzjFyauFl/SK12TrUV1nmmB+/TMYfYLvDsHJqWZVlmrDFhXUWFzde
 xtscf8f0l/zkUnQDpkdPknUAs09Y3ubipmZqC2FPqKjiajP4cR4Yn2DXhxKYFCmLVqHt
 NGIRw0OvvuiOjPEuTFj3VF1PRS7aBnQlrwLIE3T0wMWH2Q5eLwVwPjzx8Wg41AL4cXTE
 S13Yff2etYirFdvFYI+Ak4NAloKxM0DCARWmuKODnPCKxla1CFFX1eVhRsJfjtyGjIY5
 Ne0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=UHc1AWBOadewTEukk6xNWZCM4+ZLGS/wJxEaP2onOLs=;
 b=DlwY5pbxUOjlTyCV8qFcaUBss/+vftUdSbdKiewLTkqxNE58ImgBT8tx/NLd1OT3X+
 BcRsBQ42jWi4CtqwRuwnDkiOIoE3zZcAs4+PJLV8DAZIVc9eEtpAFhkNk02Q2+jTSYGD
 iPBR3tb5dDgcvEm8PLqG9dRCZg5tbQTFNZudPUFS+/Lirqnv9Q8oHoPXwxNqFCq7xrGU
 XRGdf4vDsnko5yrkeJSI4u5EhLNPuBrEdrTVLSaP/vL7wec61wpHEoNRhn55fA8IR2aS
 ufhvjNLscL/XXk0uZsSl2oyFpRPvXW+ixtAxBCPg537ExvwrLIHG/ZEfuNctcNXqn1rD
 OvUQ==
X-Gm-Message-State: APjAAAUctTfPmC44ehzwkOzaCyy5Q3NZKloX+IabeDLWSnFZxguZhJ2i
 UR4fEfjPJSHsnZ3tvf8iOuErjtIr/T4=
X-Google-Smtp-Source: APXvYqwX7n8FYJLojGJ4Ij3rteAMhoEV3vEGRSe0Da8Hg/PZdHSPShNUOiUXW/QbMbLORODBTao8Xg==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr5026623wrm.68.1562358214000;
 Fri, 05 Jul 2019 13:23:34 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id v23sm3035875wmj.32.2019.07.05.13.23.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 13:23:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 22:23:21 +0200
Message-Id: <1562358202-28008-12-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562358202-28008-1-git-send-email-pbonzini@redhat.com>
References: <1562358202-28008-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
Subject: [Qemu-devel] [PULL 11/12] hw/i386: Fix linker error when ISAPC is
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



