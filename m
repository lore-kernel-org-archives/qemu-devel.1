Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2528AC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:09:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6DAC207DD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5dcpcRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DAC207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWy4h-0001HK-3R
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 04:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWy33-00066s-PH
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:07:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45951
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWy32-0006xi-CG
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588925275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0D6ku1Fj3sv09Nz0FJZBwLmyqalpCYFmnTu7MzH1x8k=;
 b=T5dcpcRNiqRYoEZIvDelCiBGopEskZEqN0RRQdA/KNk7P0ntUIFljwqFS4BbxQajCE8lSo
 Wuo1g4meNNoTAP7luxS6HrWXhAv1npC/ERupu+TrtboASQWZ1RebPwnhZrq5rCbWOh/vpS
 4Gn1v7JFUi3f7qqddI3lSwQB5hURZzU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-TAEZwYxHNAOsAaUIlurj4Q-1; Fri, 08 May 2020 04:07:54 -0400
X-MC-Unique: TAEZwYxHNAOsAaUIlurj4Q-1
Received: by mail-wr1-f72.google.com with SMTP id z5so504706wrt.17
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 01:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=miY+K7Sb8ybAl2E/6rB5uwDxovdnaZE85VV9pE7PSqs=;
 b=KpoThhS7p2CUbRyBoBmwrsgb1DRmpAIwN16z/jLnGUNrOmu4RmRWA+CtxTKuJIQRTT
 3VaRaTx6ZVbYQiJ6aaRlWAS46z6Tn/BU1QR7VGzQDHDMES9+HHzl8WmGmp0MQBy+d8TI
 uYC8I7UwLJvWWgrNjwNhQncF2mP0Nq44eN8vVP6DkvM5Dy9ajZgty6v2C/MGIP9Zcv1c
 rRC6Z1fqQzY4hC5fwST99tm455kNzGNIIdnTagcAROZJBz2IDL2Cq28YrutqXr5oCDRn
 5xph+JK7ctST/vCHuueahxiZySHeKqonNrd8gHQ1hbxVklA48jSArd45Ngj1VxCcPrg/
 FJRQ==
X-Gm-Message-State: AGi0PuZS9fl4OveX2acbhyzgqqkfu50FmLIvc45sHwqLHsh+5sVbU65x
 LNlMIgLmytUTDR4z95dxe+ie3x2RKicHhr3kIsJBCB6c9W3wmbxwxXLWfUFjr1Ot46emrdeQ2Om
 NOXJKjEk/rGV1D+o=
X-Received: by 2002:a05:600c:22d3:: with SMTP id
 19mr15538267wmg.110.1588925270877; 
 Fri, 08 May 2020 01:07:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypLuTWxIPWO2+aSHv8dXWWjP5IWC2qSSybKxl2GopqOi2SIyKSxSrJh4rD/Z6g3NJEhB4P0UhA==
X-Received: by 2002:a05:600c:22d3:: with SMTP id
 19mr15538217wmg.110.1588925270387; 
 Fri, 08 May 2020 01:07:50 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id z1sm12125185wmf.15.2020.05.08.01.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 01:07:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] accel: Move Xen accelerator code under accel/xen/
Date: Fri,  8 May 2020 10:07:38 +0200
Message-Id: <20200508080738.2646-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200508080738.2646-1-philmd@redhat.com>
References: <20200508080738.2646-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:25:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This code is not related to hardware emulation.
Move it under accel/ with the other hypervisors.

Reviewed-by: Paul Durrant <paul@xen.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
We could also move the memory management functions from
hw/i386/xen/xen-hvm.c but it is not trivial.

v2: Use g_assert_not_reached() instead of abort()
---
 include/exec/ram_addr.h                    |  2 +-
 include/hw/xen/xen.h                       | 11 ------
 include/sysemu/xen.h                       | 40 ++++++++++++++++++++++
 hw/xen/xen-common.c =3D> accel/xen/xen-all.c |  3 ++
 hw/acpi/piix4.c                            |  2 +-
 hw/i386/pc.c                               |  1 +
 hw/i386/pc_piix.c                          |  1 +
 hw/i386/pc_q35.c                           |  1 +
 hw/i386/xen/xen-hvm.c                      |  1 +
 hw/i386/xen/xen_platform.c                 |  1 +
 hw/isa/piix3.c                             |  1 +
 hw/pci/msix.c                              |  1 +
 migration/savevm.c                         |  2 +-
 softmmu/vl.c                               |  2 +-
 stubs/xen-hvm.c                            |  9 -----
 target/i386/cpu.c                          |  2 +-
 MAINTAINERS                                |  2 ++
 accel/Makefile.objs                        |  1 +
 accel/xen/Makefile.objs                    |  1 +
 hw/xen/Makefile.objs                       |  2 +-
 20 files changed, 60 insertions(+), 26 deletions(-)
 create mode 100644 include/sysemu/xen.h
 rename hw/xen/xen-common.c =3D> accel/xen/xen-all.c (99%)
 create mode 100644 accel/xen/Makefile.objs

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index dd8713179e..a94809f89b 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -21,7 +21,7 @@
=20
 #ifndef CONFIG_USER_ONLY
 #include "cpu.h"
-#include "hw/xen/xen.h"
+#include "sysemu/xen.h"
 #include "sysemu/tcg.h"
 #include "exec/ramlist.h"
 #include "exec/ramblock.h"
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index 5ac1c6dc55..771dd447f2 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -20,13 +20,6 @@ extern uint32_t xen_domid;
 extern enum xen_mode xen_mode;
 extern bool xen_domid_restrict;
=20
-extern bool xen_allowed;
-
-static inline bool xen_enabled(void)
-{
-    return xen_allowed;
-}
-
 int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num);
 void xen_piix3_set_irq(void *opaque, int irq_num, int level);
 void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, int =
len);
@@ -39,10 +32,6 @@ void xenstore_store_pv_console_info(int i, struct Charde=
v *chr);
=20
 void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory);
=20
-void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
-                   struct MemoryRegion *mr, Error **errp);
-void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
-
 void xen_register_framebuffer(struct MemoryRegion *mr);
=20
 #endif /* QEMU_HW_XEN_H */
diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
new file mode 100644
index 0000000000..e3d30e327f
--- /dev/null
+++ b/include/sysemu/xen.h
@@ -0,0 +1,40 @@
+/*
+ * QEMU Xen support
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef SYSEMU_XEN_H
+#define SYSEMU_XEN_H
+
+#ifdef CONFIG_XEN
+
+extern bool xen_allowed;
+
+#define xen_enabled() (xen_allowed)
+
+#ifndef CONFIG_USER_ONLY
+void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
+void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
+                   struct MemoryRegion *mr, Error **errp);
+#endif
+
+#else /* !CONFIG_XEN */
+
+#define xen_enabled() 0
+#ifndef CONFIG_USER_ONLY
+static inline void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t le=
ngth)
+{
+    g_assert_not_reached();
+}
+static inline void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
+                                 MemoryRegion *mr, Error **errp)
+{
+    g_assert_not_reached();
+}
+#endif
+
+#endif /* CONFIG_XEN */
+
+#endif
diff --git a/hw/xen/xen-common.c b/accel/xen/xen-all.c
similarity index 99%
rename from hw/xen/xen-common.c
rename to accel/xen/xen-all.c
index a15070f7f6..5c64571cb8 100644
--- a/hw/xen/xen-common.c
+++ b/accel/xen/xen-all.c
@@ -16,6 +16,7 @@
 #include "hw/xen/xen_pt.h"
 #include "chardev/char.h"
 #include "sysemu/accel.h"
+#include "sysemu/xen.h"
 #include "sysemu/runstate.h"
 #include "migration/misc.h"
 #include "migration/global_state.h"
@@ -31,6 +32,8 @@
     do { } while (0)
 #endif
=20
+bool xen_allowed;
+
 xc_interface *xen_xc;
 xenforeignmemory_handle *xen_fmem;
 xendevicemodel_handle *xen_dmod;
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 964d6f5990..daed273687 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -30,6 +30,7 @@
 #include "hw/acpi/acpi.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/xen.h"
 #include "qapi/error.h"
 #include "qemu/range.h"
 #include "exec/address-spaces.h"
@@ -41,7 +42,6 @@
 #include "hw/mem/nvdimm.h"
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/acpi_dev_interface.h"
-#include "hw/xen/xen.h"
 #include "migration/vmstate.h"
 #include "hw/core/cpu.h"
 #include "trace.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 97e345faea..1a599e1de9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -56,6 +56,7 @@
 #include "sysemu/tcg.h"
 #include "sysemu/numa.h"
 #include "sysemu/kvm.h"
+#include "sysemu/xen.h"
 #include "sysemu/qtest.h"
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 3862e5120e..c00472b4c5 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -53,6 +53,7 @@
 #include "cpu.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "sysemu/xen.h"
 #ifdef CONFIG_XEN
 #include <xen/hvm/hvm_info_table.h>
 #include "hw/xen/xen_pt.h"
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 3349e38a4c..e929749d8e 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -36,6 +36,7 @@
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/xen/xen.h"
 #include "sysemu/kvm.h"
+#include "sysemu/xen.h"
 #include "hw/kvm/clock.h"
 #include "hw/pci-host/q35.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 82ece6b9e7..041303a2fa 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -28,6 +28,7 @@
 #include "qemu/range.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/xen.h"
 #include "sysemu/xen-mapcache.h"
 #include "trace.h"
 #include "exec/address-spaces.h"
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index 0f7b05e5e1..a1492fdecd 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -33,6 +33,7 @@
 #include "hw/xen/xen-legacy-backend.h"
 #include "trace.h"
 #include "exec/address-spaces.h"
+#include "sysemu/xen.h"
 #include "sysemu/block-backend.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
index fd1c78879f..1a5267e19f 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix3.c
@@ -28,6 +28,7 @@
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/xen/xen.h"
+#include "sysemu/xen.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 29187898f2..2c7ead7667 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -19,6 +19,7 @@
 #include "hw/pci/msix.h"
 #include "hw/pci/pci.h"
 #include "hw/xen/xen.h"
+#include "sysemu/xen.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "qemu/range.h"
diff --git a/migration/savevm.c b/migration/savevm.c
index c00a6807d9..b979ea6e7f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -28,7 +28,6 @@
=20
 #include "qemu/osdep.h"
 #include "hw/boards.h"
-#include "hw/xen/xen.h"
 #include "net/net.h"
 #include "migration.h"
 #include "migration/snapshot.h"
@@ -59,6 +58,7 @@
 #include "sysemu/replay.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/xen.h"
 #include "qjson.h"
 #include "migration/colo.h"
 #include "qemu/bitmap.h"
diff --git a/softmmu/vl.c b/softmmu/vl.c
index afd2615fb3..0344e5fd2e 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -36,6 +36,7 @@
 #include "sysemu/runstate.h"
 #include "sysemu/seccomp.h"
 #include "sysemu/tcg.h"
+#include "sysemu/xen.h"
=20
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
@@ -178,7 +179,6 @@ static NotifierList exit_notifiers =3D
 static NotifierList machine_init_done_notifiers =3D
     NOTIFIER_LIST_INITIALIZER(machine_init_done_notifiers);
=20
-bool xen_allowed;
 uint32_t xen_domid;
 enum xen_mode xen_mode =3D XEN_EMULATE;
 bool xen_domid_restrict;
diff --git a/stubs/xen-hvm.c b/stubs/xen-hvm.c
index b7d53b5e2f..6954a5b696 100644
--- a/stubs/xen-hvm.c
+++ b/stubs/xen-hvm.c
@@ -35,11 +35,6 @@ int xen_is_pirq_msi(uint32_t msi_data)
     return 0;
 }
=20
-void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
-                   Error **errp)
-{
-}
-
 qemu_irq *xen_interrupt_controller_init(void)
 {
     return NULL;
@@ -49,10 +44,6 @@ void xen_register_framebuffer(MemoryRegion *mr)
 {
 }
=20
-void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
-{
-}
-
 void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
 {
 }
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9c256ab159..f9b3ef1ef2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -29,6 +29,7 @@
 #include "sysemu/reset.h"
 #include "sysemu/hvf.h"
 #include "sysemu/cpus.h"
+#include "sysemu/xen.h"
 #include "kvm_i386.h"
 #include "sev_i386.h"
=20
@@ -54,7 +55,6 @@
 #include "hw/i386/topology.h"
 #ifndef CONFIG_USER_ONLY
 #include "exec/address-spaces.h"
-#include "hw/xen/xen.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/boards.h"
 #endif
diff --git a/MAINTAINERS b/MAINTAINERS
index 1f84e3ae2c..95ddddfb1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -438,6 +438,7 @@ M: Paul Durrant <paul@xen.org>
 L: xen-devel@lists.xenproject.org
 S: Supported
 F: */xen*
+F: accel/xen/*
 F: hw/9pfs/xen-9p*
 F: hw/char/xen_console.c
 F: hw/display/xenfb.c
@@ -451,6 +452,7 @@ F: hw/i386/xen/
 F: hw/pci-host/xen_igd_pt.c
 F: include/hw/block/dataplane/xen*
 F: include/hw/xen/
+F: include/sysemu/xen.h
 F: include/sysemu/xen-mapcache.h
=20
 Guest CPU Cores (HAXM)
diff --git a/accel/Makefile.objs b/accel/Makefile.objs
index 17e5ac6061..ff72f0d030 100644
--- a/accel/Makefile.objs
+++ b/accel/Makefile.objs
@@ -2,4 +2,5 @@ common-obj-$(CONFIG_SOFTMMU) +=3D accel.o
 obj-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_POSIX)) +=3D qtest.o
 obj-$(CONFIG_KVM) +=3D kvm/
 obj-$(CONFIG_TCG) +=3D tcg/
+obj-$(CONFIG_XEN) +=3D xen/
 obj-y +=3D stubs/
diff --git a/accel/xen/Makefile.objs b/accel/xen/Makefile.objs
new file mode 100644
index 0000000000..7482cfb436
--- /dev/null
+++ b/accel/xen/Makefile.objs
@@ -0,0 +1 @@
+obj-y +=3D xen-all.o
diff --git a/hw/xen/Makefile.objs b/hw/xen/Makefile.objs
index 84df60a928..340b2c5096 100644
--- a/hw/xen/Makefile.objs
+++ b/hw/xen/Makefile.objs
@@ -1,5 +1,5 @@
 # xen backend driver support
-common-obj-$(CONFIG_XEN) +=3D xen-legacy-backend.o xen_devconfig.o xen_pvd=
ev.o xen-common.o xen-bus.o xen-bus-helper.o xen-backend.o
+common-obj-$(CONFIG_XEN) +=3D xen-legacy-backend.o xen_devconfig.o xen_pvd=
ev.o xen-bus.o xen-bus-helper.o xen-backend.o
=20
 obj-$(CONFIG_XEN_PCI_PASSTHROUGH) +=3D xen-host-pci-device.o
 obj-$(CONFIG_XEN_PCI_PASSTHROUGH) +=3D xen_pt.o xen_pt_config_init.o xen_p=
t_graphics.o xen_pt_msi.o
--=20
2.21.3


