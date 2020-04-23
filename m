Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11235C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:06:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D97882075A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97882075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRXoD-0006aF-1z
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 05:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>) id 1jRXjh-0000qD-46
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>) id 1jRXjb-0001E1-HM
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:01:32 -0400
Received: from andre.telenet-ops.be ([2a02:1800:120:4::f00:15]:34528)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <geert@linux-m68k.org>)
 id 1jRXja-0001Bd-5S
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:01:26 -0400
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:89cc:efc7:85ce:4669])
 by andre.telenet-ops.be with bizsmtp
 id W91L2200k1RvcFS0191LLq; Thu, 23 Apr 2020 11:01:21 +0200
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jRXjU-0006kJ-Cn; Thu, 23 Apr 2020 11:01:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jRXjU-0002vg-BT; Thu, 23 Apr 2020 11:01:20 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bartekgola@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH QEMU v2 5/5] hw/arm/virt: Add dynamic PL061 GPIO support
Date: Thu, 23 Apr 2020 11:01:18 +0200
Message-Id: <20200423090118.11199-6-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200423090118.11199-1-geert+renesas@glider.be>
References: <20200423090118.11199-1-geert+renesas@glider.be>
Received-SPF: none client-ip=2a02:1800:120:4::f00:15;
 envelope-from=geert@linux-m68k.org; helo=andre.telenet-ops.be
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a02:1800:120:4::f00:15
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
Cc: linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add support for dynamically instantiating PL061 GPIO controller
instances in ARM virt.  Device tree nodes are created dynamically.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 hw/arm/sysbus-fdt.c | 18 ++++++++++++++++++
 hw/arm/virt.c       |  1 +
 2 files changed, 19 insertions(+)

diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index 6b6906f4cfc36198..493583218d176d0a 100644
--- a/hw/arm/sysbus-fdt.c
+++ b/hw/arm/sysbus-fdt.c
@@ -32,6 +32,7 @@
 #include "sysemu/device_tree.h"
 #include "sysemu/tpm.h"
 #include "hw/platform-bus.h"
+#include "hw/gpio/pl061.h"
 #include "hw/vfio/vfio-platform.h"
 #include "hw/vfio/vfio-calxeda-xgmac.h"
 #include "hw/vfio/vfio-amd-xgbe.h"
@@ -468,6 +469,22 @@ static int add_tpm_tis_fdt_node(SysBusDevice *sbdev, void *opaque)
     return 0;
 }
 
+/*
+ * add_pl061_node: Create a DT node for a PL061 GPIO controller
+ */
+static int add_pl061_node(SysBusDevice *sbdev, void *opaque)
+{
+    PlatformBusFDTData *data = opaque;
+    PlatformBusDevice *pbus = data->pbus;
+    void *fdt = data->fdt;
+
+    pl061_create_fdt(fdt, data->pbus_node_name, 1,
+                     platform_bus_get_mmio_addr(pbus, sbdev, 0), 0x1000,
+                     platform_bus_get_irqn(pbus, sbdev, 0) + data->irq_start,
+                     qemu_fdt_get_phandle(fdt, "/apb-pclk"));
+    return 0;
+}
+
 static int no_fdt_node(SysBusDevice *sbdev, void *opaque)
 {
     return 0;
@@ -489,6 +506,7 @@ static const BindingEntry bindings[] = {
     VFIO_PLATFORM_BINDING("amd,xgbe-seattle-v1a", add_amd_xgbe_fdt_node),
 #endif
     TYPE_BINDING(TYPE_TPM_TIS_SYSBUS, add_tpm_tis_fdt_node),
+    TYPE_BINDING(TYPE_PL061, add_pl061_node),
     TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
     TYPE_BINDING("", NULL), /* last element */
 };
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c88c8850fbe00bdb..191594db09422d54 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2178,6 +2178,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PL061);
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
     mc->pci_allow_0_address = true;
-- 
2.17.1


