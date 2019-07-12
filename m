Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB25C742CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 16:03:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33064206B8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 16:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33064206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hly11-00073f-5u
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 12:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42433)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <julio.montes@intel.com>) id 1hly0l-0006fA-Gz
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 12:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <julio.montes@intel.com>) id 1hly0k-0000M4-F0
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 12:03:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:18090)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <julio.montes@intel.com>)
 id 1hly0k-00009U-64
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 12:03:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Jul 2019 09:02:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,483,1557212400"; d="scan'208";a="186626293"
Received: from unknown (HELO fedora.zpn.intel.com.) ([10.219.4.39])
 by fmsmga001.fm.intel.com with ESMTP; 12 Jul 2019 09:02:57 -0700
From: Julio Montes <julio.montes@intel.com>
To: qemu-devel@nongnu.org
Date: Fri, 12 Jul 2019 16:02:57 +0000
Message-Id: <20190712160257.18270-1-julio.montes@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190712145017.17879-1-julio.montes@intel.com>
References: <20190712145017.17879-1-julio.montes@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
Subject: [Qemu-devel] [PATCH v2] hw/i386: turn off vmport if CONFIG_VMPORT
 is disabled
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
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vmport device is not included when CONFIG_VMPORT is disabled, hence
QEMU fails with the following error:

`Unknown device 'vmport' for bus 'ISA': unknown.`

v2: imply VMPORT (Paolo Bonzini )

Signed-off-by: Julio Montes <julio.montes@intel.com>
---
 hw/i386/Kconfig | 4 ++--
 hw/i386/pc.c    | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 4ddf2a9c55..b9c96ac361 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -51,6 +51,7 @@ config PC_ACPI
 config I440FX
     bool
     imply E1000_PCI
+    imply VMPORT
     select PC_PCI
     select PC_ACPI
     select ACPI_SMBUS
@@ -58,7 +59,6 @@ config I440FX
     select IDE_PIIX
     select DIMM
     select SMBIOS
-    select VMPORT
     select VMMOUSE
     select FW_CFG_DMA

@@ -77,6 +77,7 @@ config Q35
     imply VTD
     imply AMD_IOMMU
     imply E1000E_PCI_EXPRESS
+    imply VMPORT
     select PC_PCI
     select PC_ACPI
     select PCI_EXPRESS_Q35
@@ -84,7 +85,6 @@ config Q35
     select AHCI_ICH9
     select DIMM
     select SMBIOS
-    select VMPORT
     select VMMOUSE
     select FW_CFG_DMA

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c33ce47578..549c437050 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -83,6 +83,7 @@
 #include "hw/mem/memory-device.h"
 #include "sysemu/replay.h"
 #include "qapi/qmp/qerror.h"
+#include "config-devices.h"

 /* debug PC/ISA interrupts */
 //#define DEBUG_IRQ
@@ -2793,7 +2794,11 @@ static void pc_machine_initfn(Object *obj)

     pcms->max_ram_below_4g = 0; /* use default */
     pcms->smm = ON_OFF_AUTO_AUTO;
+#ifdef CONFIG_VMPORT
     pcms->vmport = ON_OFF_AUTO_AUTO;
+#else
+    pcms->vmport = ON_OFF_AUTO_OFF;
+#endif /* CONFIG_VMPORT */
     /* acpi build is enabled by default if machine supports it */
     pcms->acpi_build_enabled = PC_MACHINE_GET_CLASS(pcms)->has_acpi_build;
     pcms->smbus_enabled = true;
--
2.17.2

