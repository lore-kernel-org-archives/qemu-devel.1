Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F8DC0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 18:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 753AA2189E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 18:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753AA2189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj67L-0002eO-NQ
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 14:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58867)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <julio.montes@intel.com>) id 1hj65V-00029D-T9
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 14:04:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <julio.montes@intel.com>) id 1hj65U-0003SL-Qi
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 14:04:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:59779)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <julio.montes@intel.com>)
 id 1hj65U-0003OE-Hv
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 14:04:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Jul 2019 11:03:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,451,1557212400"; d="scan'208";a="315909630"
Received: from unknown (HELO fedora.zpn.intel.com.) ([10.219.4.39])
 by orsmga004.jf.intel.com with ESMTP; 04 Jul 2019 11:03:55 -0700
From: Julio Montes <julio.montes@intel.com>
To: pbonzini@redhat.com,
	qemu-devel@nongnu.org
Date: Thu,  4 Jul 2019 18:03:50 +0000
Message-Id: <20190704180350.2086-1-julio.montes@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <be6aa304-a8e4-d64a-432f-24d52e42c097@redhat.com>
References: <be6aa304-a8e4-d64a-432f-24d52e42c097@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
Subject: [Qemu-devel] [PATCH] hw/i386: Fix linker error when ISAPC is
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

How about a new header file with all devices? (see below patch)

---
 Makefile.target       |  5 +++++
 hw/i386/pc_piix.c     | 11 ++++++++---
 include/qemu/osdep.h  |  1 +
 scripts/create_config |  2 ++
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index a6919e0caf..65eda0994d 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -45,6 +45,9 @@ include $(SRC_PATH)/tests/tcg/Makefile.include
 config-target.h: config-target.h-timestamp
 config-target.h-timestamp: config-target.mak

+config-devices.h: config-devices.h-timestamp
+config-devices.h-timestamp: config-devices.mak
+
 ifdef CONFIG_TRACE_SYSTEMTAP
 stap: $(QEMU_PROG).stp-installed $(QEMU_PROG).stp $(QEMU_PROG)-simpletrace.stp $(QEMU_PROG)-log.stp

@@ -170,6 +173,8 @@ generated-files-y += hmp-commands.h hmp-commands-info.h

 endif # CONFIG_SOFTMMU

+generated-files-y += config-devices.h
+
 dummy := $(call unnest-vars,,obj-y)
 all-obj-y := $(obj-y)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c07c4a5b38..b93f9327be 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -61,9 +61,11 @@

 #define MAX_IDE_BUS 2

+#ifdef CONFIG_IDE_ISA
 static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
 static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
 static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
+#endif

 /* PC hardware initialisation */
 static void pc_init1(MachineState *machine,
@@ -254,7 +256,10 @@ static void pc_init1(MachineState *machine,
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
@@ -268,9 +273,9 @@ static void pc_init1(MachineState *machine,
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
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index af2b91f0b8..83b49a1e63 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -30,6 +30,7 @@
 #include "config-host.h"
 #ifdef NEED_CPU_H
 #include "config-target.h"
+#include "config-devices.h"
 #else
 #include "exec/poison.h"
 #endif
diff --git a/scripts/create_config b/scripts/create_config
index d727e5e36e..00e86c82b0 100755
--- a/scripts/create_config
+++ b/scripts/create_config
@@ -58,6 +58,8 @@ case $line in
     name=${line%=*}
     echo "#define $name 1"
     ;;
+ CONFIG_*=n) # configuration
+    ;;
  CONFIG_*=*) # configuration
     name=${line%=*}
     value=${line#*=}
--
2.17.2

