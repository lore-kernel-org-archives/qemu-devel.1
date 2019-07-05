Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E33C4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 14:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29CFF20645
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 14:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CFF20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjPLv-0002Z2-Eo
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 10:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51474)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <julio.montes@intel.com>) id 1hjPKA-0001O9-9X
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <julio.montes@intel.com>) id 1hjPK8-0000nb-6B
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:36:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:33643)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <julio.montes@intel.com>)
 id 1hjPK7-0000Ey-T5
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:36:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Jul 2019 07:36:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,455,1557212400"; d="scan'208";a="164878162"
Received: from unknown (HELO fedora.zpn.intel.com.) ([10.219.4.39])
 by fmsmga008.fm.intel.com with ESMTP; 05 Jul 2019 07:36:19 -0700
From: Julio Montes <julio.montes@intel.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 14:35:54 +0000
Message-Id: <20190705143554.10295-2-julio.montes@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190705143554.10295-1-julio.montes@intel.com>
References: <20190703154958.29004-1-julio.montes@intel.com>
 <20190705143554.10295-1-julio.montes@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.88
Subject: [Qemu-devel] [PATCH v2 2/2] hw/i386: Fix linker error when ISAPC is
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
Cc: Julio Montes <julio.montes@intel.com>, pbonzini@redhat.com,
 sgarzare@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2: include config-devices.h to use CONFIG_IDE_ISA

---
In pc_init1(), ISA IDE is initialized without checking if ISAPC or IDE_ISA
configs are enabled. This results in a link error when
CONFIG_ISAPC is set to 'n' in the file default-configs/i386-softmmu.mak:

hw/i386/pc_piix.o: In function `pc_init1':
hw/i386/pc_piix.c:261: undefined reference to `isa_ide_init'
hw/i386/pc_piix.c:261: undefined reference to `isa_ide_init'

Place ide_isa code under #ifdef CONFIG_IDE_ISA to fix linker errors

Signed-off-by: Julio Montes <julio.montes@intel.com>
---
 hw/i386/pc_piix.c    | 11 ++++++++---
 include/qemu/osdep.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index f29de58636..c7d4645a3f 100644
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
index af2b91f0b8..f1c682e52c 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -29,6 +29,7 @@

 #include "config-host.h"
 #ifdef NEED_CPU_H
+#include "config-devices.h"
 #include "config-target.h"
 #else
 #include "exec/poison.h"
--
2.17.2

