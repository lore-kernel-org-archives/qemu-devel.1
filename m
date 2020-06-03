Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C3AC433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33104204EF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33104204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgVtw-0001Y2-9y
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 12:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1jgVsr-0000DD-NB
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:04:53 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:6636)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1jgVsq-0001CS-Fy
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:04:53 -0400
Authentication-Results: esa6.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: iclSOewnqgMnEYbbuNZOrWgIki0MUWsRaG9w+d9ZEdBdU2pNLfDnytVvDhdvgBBZhAPGG+paFg
 AY+e3TVmPNe2G00vsJU9M4vl0KXn5UYtoq22C6YiYpWkBHTZjO0tmmDF9buWjcgViyifwacrd7
 vXBYSHhzT26BbNF9ZsWLVcg4u5G6bX+NTocDLVXAbOCsxcNgfILfw6v/zk91Z0+cVfDyNKfbBk
 k/dMcjig/zOJYrzqqyqaEJPJKnMWTCGVSgZ0AIcOoTPqHbBIElMFD9VmmHSHCeLbc08R9PZdqE
 FoQ=
X-SBRS: 2.7
X-MesageID: 19489761
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.73,468,1583211600"; d="scan'208";a="19489761"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v3] xen: fix build without pci passthrough
Date: Wed, 3 Jun 2020 17:04:42 +0100
Message-ID: <20200603160442.3151170-1-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.155.175;
 envelope-from=anthony.perard@citrix.com; helo=esa6.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 12:04:48
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 Anthony PERARD <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Roger Pau Monne <roger.pau@citrix.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Roger Pau Monne <roger.pau@citrix.com>

Xen PCI passthrough support may not be available and thus the global
variable "has_igd_gfx_passthru" might be compiled out. Common code
should not access it in that case.

Unfortunately, we can't use CONFIG_XEN_PCI_PASSTHROUGH directly in
xen-common.c so this patch instead move access to the
has_igd_gfx_passthru variable via function and those functions are
also implemented as stubs. The stubs will be used when QEMU is built
without passthrough support.

Now, when one will want to enable igd-passthru via the -machine
property, they will get an error message if QEMU is built without
passthrough support.

Fixes: 46472d82322d0 ('xen: convert "-machine igd-passthru" to an accelerator property')
Reported-by: Roger Pau Monné <roger.pau@citrix.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---

Notes:
    Changes in v3:
    - reworked to use stubs instead of #ifdef CONFIG_XEN_PCI_PASSTHROUGH
      CONFIG_XEN_PCI_PASSTHROUGH isn't available in xen-common.c
    
      moving CONFIG_XEN_PCI_PASSTHROUGH to be in config_host_mak isn't
      really possible, or at least I didn't managed to make that work.

 hw/i386/pc_piix.c   |  2 +-
 hw/xen/xen-common.c |  4 ++--
 hw/xen/xen_pt.c     | 12 +++++++++++-
 hw/xen/xen_pt.h     |  6 ++++--
 stubs/Makefile.objs |  1 +
 stubs/xen-pt.c      | 22 ++++++++++++++++++++++
 6 files changed, 41 insertions(+), 6 deletions(-)
 create mode 100644 stubs/xen-pt.c

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index f66e1d73ce0b..347fb8c6c807 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -375,7 +375,7 @@ static void pc_init_isa(MachineState *machine)
 #ifdef CONFIG_XEN
 static void pc_xen_hvm_init_pci(MachineState *machine)
 {
-    const char *pci_type = has_igd_gfx_passthru ?
+    const char *pci_type = xen_igd_gfx_pt_enabled() ?
                 TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE : TYPE_I440FX_PCI_DEVICE;
 
     pc_init1(machine,
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index 70564cc952d5..dd2c22cc4c0b 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -129,12 +129,12 @@ static void xen_change_state_handler(void *opaque, int running,
 
 static bool xen_get_igd_gfx_passthru(Object *obj, Error **errp)
 {
-    return has_igd_gfx_passthru;
+    return xen_igd_gfx_pt_enabled();
 }
 
 static void xen_set_igd_gfx_passthru(Object *obj, bool value, Error **errp)
 {
-    has_igd_gfx_passthru = value;
+    xen_igd_gfx_pt_set(value, errp);
 }
 
 static void xen_setup_post(MachineState *ms, AccelState *accel)
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 81d5ad8da7f0..ab84443d5ec8 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -65,7 +65,17 @@
 #include "qemu/range.h"
 #include "exec/address-spaces.h"
 
-bool has_igd_gfx_passthru;
+static bool has_igd_gfx_passthru;
+
+bool xen_igd_gfx_pt_enabled(void)
+{
+    return has_igd_gfx_passthru;
+}
+
+void xen_igd_gfx_pt_set(bool value, Error **errp)
+{
+    has_igd_gfx_passthru = value;
+}
 
 #define XEN_PT_NR_IRQS (256)
 static uint8_t xen_pt_mapped_machine_irq[XEN_PT_NR_IRQS] = {0};
diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
index 179775db7b22..6e9cec95f3b7 100644
--- a/hw/xen/xen_pt.h
+++ b/hw/xen/xen_pt.h
@@ -5,6 +5,9 @@
 #include "hw/pci/pci.h"
 #include "xen-host-pci-device.h"
 
+bool xen_igd_gfx_pt_enabled(void);
+void xen_igd_gfx_pt_set(bool value, Error **errp);
+
 void xen_pt_log(const PCIDevice *d, const char *f, ...) GCC_FMT_ATTR(2, 3);
 
 #define XEN_PT_ERR(d, _f, _a...) xen_pt_log(d, "%s: Error: "_f, __func__, ##_a)
@@ -322,10 +325,9 @@ extern void *pci_assign_dev_load_option_rom(PCIDevice *dev,
                                             unsigned int domain,
                                             unsigned int bus, unsigned int slot,
                                             unsigned int function);
-extern bool has_igd_gfx_passthru;
 static inline bool is_igd_vga_passthrough(XenHostPCIDevice *dev)
 {
-    return (has_igd_gfx_passthru
+    return (xen_igd_gfx_pt_enabled()
             && ((dev->class_code >> 0x8) == PCI_CLASS_DISPLAY_VGA));
 }
 int xen_pt_register_vga_regions(XenHostPCIDevice *dev);
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 6a9e3135e8f9..564527e00997 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -40,6 +40,7 @@ stub-obj-y += target-get-monitor-def.o
 stub-obj-y += vmgenid.o
 stub-obj-y += xen-common.o
 stub-obj-y += xen-hvm.o
+stub-obj-y += xen-pt.o
 stub-obj-y += pci-host-piix.o
 stub-obj-y += ram-block.o
 stub-obj-y += ramfb.o
diff --git a/stubs/xen-pt.c b/stubs/xen-pt.c
new file mode 100644
index 000000000000..2d8cac8d54b9
--- /dev/null
+++ b/stubs/xen-pt.c
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2020       Citrix Systems UK Ltd.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/xen/xen_pt.h"
+#include "qapi/error.h"
+
+bool xen_igd_gfx_pt_enabled(void)
+{
+    return false;
+}
+
+void xen_igd_gfx_pt_set(bool value, Error **errp)
+{
+    if (value) {
+        error_setg(errp, "Xen PCI passthrough support not built in");
+    }
+}
-- 
Anthony PERARD


