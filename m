Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BEBC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:05:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D3A82076D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGSsxW/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3A82076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaLID-0005lP-8t
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:05:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFF-0002PE-Kk
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:02:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLF7-0005b7-Ef
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604505756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o3F4G5jOhdmINIYp9Rd95Gy4+0RwaQ/S7Hqq6ZmVXDE=;
 b=JGSsxW/CKhUTf5EjC0dilYoQQ4o7XC0FD5jKGk+A6RystgPRMmWx+3JR3HSEHaNbMGDQXu
 Iyk7R9B6RoHsfPmIsIlrh8qdOjc5XKj6v8ukaMRQaKt+H8N9TDTwo70xFxXn+sfgxCBTTV
 ZZ4s2257m3ZT638IzYMC0p1t9GN69Hc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-EO-6Rr_aO8KOoYWM1fD9bQ-1; Wed, 04 Nov 2020 11:02:34 -0500
X-MC-Unique: EO-6Rr_aO8KOoYWM1fD9bQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAAA4101F02D;
 Wed,  4 Nov 2020 16:01:32 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E7E71A268;
 Wed,  4 Nov 2020 16:01:32 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/44] qdev: Move softmmu properties to
 qdev-properties-system.h
Date: Wed,  4 Nov 2020 10:59:51 -0500
Message-Id: <20201104160021.2342108-15-ehabkost@redhat.com>
In-Reply-To: <20201104160021.2342108-1-ehabkost@redhat.com>
References: <20201104160021.2342108-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the property types and property macros implemented in
qdev-properties-system.c to a new qdev-properties-system.h
header.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Move UUID property type too, as it was moved to
  qdev-properties-system.c in the previous patch
---
 audio/audio.h                       |  1 +
 include/hw/block/block.h            |  1 +
 include/hw/qdev-properties-system.h | 84 +++++++++++++++++++++++++++++
 include/hw/qdev-properties.h        | 75 --------------------------
 include/net/net.h                   |  1 +
 hw/acpi/vmgenid.c                   |  1 +
 hw/arm/pxa2xx.c                     |  1 +
 hw/arm/strongarm.c                  |  1 +
 hw/block/fdc.c                      |  1 +
 hw/block/m25p80.c                   |  1 +
 hw/block/nand.c                     |  1 +
 hw/block/onenand.c                  |  1 +
 hw/block/pflash_cfi01.c             |  1 +
 hw/block/pflash_cfi02.c             |  1 +
 hw/block/vhost-user-blk.c           |  1 +
 hw/char/avr_usart.c                 |  1 +
 hw/char/bcm2835_aux.c               |  1 +
 hw/char/cadence_uart.c              |  1 +
 hw/char/cmsdk-apb-uart.c            |  1 +
 hw/char/debugcon.c                  |  1 +
 hw/char/digic-uart.c                |  1 +
 hw/char/escc.c                      |  1 +
 hw/char/etraxfs_ser.c               |  1 +
 hw/char/exynos4210_uart.c           |  1 +
 hw/char/grlib_apbuart.c             |  1 +
 hw/char/ibex_uart.c                 |  1 +
 hw/char/imx_serial.c                |  1 +
 hw/char/ipoctal232.c                |  1 +
 hw/char/lm32_juart.c                |  1 +
 hw/char/lm32_uart.c                 |  1 +
 hw/char/mcf_uart.c                  |  1 +
 hw/char/milkymist-uart.c            |  1 +
 hw/char/nrf51_uart.c                |  1 +
 hw/char/parallel.c                  |  1 +
 hw/char/pl011.c                     |  1 +
 hw/char/renesas_sci.c               |  1 +
 hw/char/sclpconsole-lm.c            |  1 +
 hw/char/sclpconsole.c               |  1 +
 hw/char/serial-pci-multi.c          |  1 +
 hw/char/serial.c                    |  1 +
 hw/char/spapr_vty.c                 |  1 +
 hw/char/stm32f2xx_usart.c           |  1 +
 hw/char/terminal3270.c              |  1 +
 hw/char/virtio-console.c            |  1 +
 hw/char/xilinx_uartlite.c           |  1 +
 hw/core/qdev-properties-system.c    |  1 +
 hw/hyperv/vmbus.c                   |  1 +
 hw/i386/kvm/i8254.c                 |  1 +
 hw/ide/qdev.c                       |  1 +
 hw/ipmi/ipmi_bmc_extern.c           |  1 +
 hw/ipmi/ipmi_bmc_sim.c              |  1 +
 hw/misc/allwinner-sid.c             |  1 +
 hw/misc/ivshmem.c                   |  1 +
 hw/misc/mac_via.c                   |  1 +
 hw/misc/sifive_u_otp.c              |  1 +
 hw/net/rocker/rocker.c              |  1 +
 hw/nvram/eeprom_at24c.c             |  1 +
 hw/nvram/spapr_nvram.c              |  1 +
 hw/pci-bridge/gen_pcie_root_port.c  |  1 +
 hw/pci/pci.c                        |  1 +
 hw/ppc/pnv_pnor.c                   |  1 +
 hw/rdma/vmw/pvrdma_main.c           |  1 +
 hw/rtc/mc146818rtc.c                |  1 +
 hw/scsi/scsi-disk.c                 |  1 +
 hw/scsi/scsi-generic.c              |  1 +
 hw/scsi/vhost-user-scsi.c           |  1 +
 hw/sd/sd.c                          |  1 +
 hw/usb/ccid-card-passthru.c         |  1 +
 hw/usb/dev-serial.c                 |  1 +
 hw/usb/redirect.c                   |  1 +
 hw/vfio/pci.c                       |  1 +
 hw/virtio/vhost-user-fs.c           |  1 +
 hw/virtio/vhost-user-vsock.c        |  1 +
 hw/virtio/virtio-iommu-pci.c        |  1 +
 hw/xen/xen_pt.c                     |  1 +
 migration/migration.c               |  1 +
 76 files changed, 158 insertions(+), 75 deletions(-)
 create mode 100644 include/hw/qdev-properties-system.h

diff --git a/audio/audio.h b/audio/audio.h
index b883ebfb1f..21fe3226ae 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -28,6 +28,7 @@
 #include "qemu/queue.h"
 #include "qapi/qapi-types-audio.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 
 typedef void (*audio_callback_fn) (void *opaque, int avail);
 
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index 1e8b6253dd..c172cbe65f 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -13,6 +13,7 @@
 
 #include "exec/hwaddr.h"
 #include "qapi/qapi-types-block-core.h"
+#include "hw/qdev-properties-system.h"
 
 /* Configuration */
 
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
new file mode 100644
index 0000000000..29529dc999
--- /dev/null
+++ b/include/hw/qdev-properties-system.h
@@ -0,0 +1,84 @@
+#ifndef HW_QDEV_PROPERTIES_SYSTEM_H
+#define HW_QDEV_PROPERTIES_SYSTEM_H
+
+#include "hw/qdev-properties.h"
+
+extern const PropertyInfo qdev_prop_chr;
+extern const PropertyInfo qdev_prop_macaddr;
+extern const PropertyInfo qdev_prop_reserved_region;
+extern const PropertyInfo qdev_prop_multifd_compression;
+extern const PropertyInfo qdev_prop_losttickpolicy;
+extern const PropertyInfo qdev_prop_blockdev_on_error;
+extern const PropertyInfo qdev_prop_bios_chs_trans;
+extern const PropertyInfo qdev_prop_fdc_drive_type;
+extern const PropertyInfo qdev_prop_drive;
+extern const PropertyInfo qdev_prop_drive_iothread;
+extern const PropertyInfo qdev_prop_netdev;
+extern const PropertyInfo qdev_prop_pci_devfn;
+extern const PropertyInfo qdev_prop_blocksize;
+extern const PropertyInfo qdev_prop_pci_host_devaddr;
+extern const PropertyInfo qdev_prop_uuid;
+extern const PropertyInfo qdev_prop_audiodev;
+extern const PropertyInfo qdev_prop_off_auto_pcibar;
+extern const PropertyInfo qdev_prop_pcie_link_speed;
+extern const PropertyInfo qdev_prop_pcie_link_width;
+
+#define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
+
+#define DEFINE_PROP_CHR(_n, _s, _f)             \
+    DEFINE_PROP(_n, _s, _f, qdev_prop_chr, CharBackend)
+#define DEFINE_PROP_NETDEV(_n, _s, _f)             \
+    DEFINE_PROP(_n, _s, _f, qdev_prop_netdev, NICPeers)
+#define DEFINE_PROP_DRIVE(_n, _s, _f) \
+    DEFINE_PROP(_n, _s, _f, qdev_prop_drive, BlockBackend *)
+#define DEFINE_PROP_DRIVE_IOTHREAD(_n, _s, _f) \
+    DEFINE_PROP(_n, _s, _f, qdev_prop_drive_iothread, BlockBackend *)
+#define DEFINE_PROP_MACADDR(_n, _s, _f)         \
+    DEFINE_PROP(_n, _s, _f, qdev_prop_macaddr, MACAddr)
+#define DEFINE_PROP_RESERVED_REGION(_n, _s, _f)         \
+    DEFINE_PROP(_n, _s, _f, qdev_prop_reserved_region, ReservedRegion)
+#define DEFINE_PROP_MULTIFD_COMPRESSION(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_multifd_compression, \
+                       MultiFDCompression)
+#define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
+                        LostTickPolicy)
+#define DEFINE_PROP_BLOCKDEV_ON_ERROR(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_blockdev_on_error, \
+                        BlockdevOnError)
+#define DEFINE_PROP_BIOS_CHS_TRANS(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_bios_chs_trans, int)
+#define DEFINE_PROP_BLOCKSIZE(_n, _s, _f) \
+    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint32_t)
+#define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
+    DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceAddress)
+#define DEFINE_PROP_OFF_AUTO_PCIBAR(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_off_auto_pcibar, \
+                        OffAutoPCIBAR)
+#define DEFINE_PROP_PCIE_LINK_SPEED(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pcie_link_speed, \
+                        PCIExpLinkSpeed)
+#define DEFINE_PROP_PCIE_LINK_WIDTH(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pcie_link_width, \
+                        PCIExpLinkWidth)
+
+#define DEFINE_PROP_UUID(_name, _state, _field) {                  \
+        .name      = (_name),                                      \
+        .info      = &qdev_prop_uuid,                              \
+        .offset    = offsetof(_state, _field)                      \
+            + type_check(QemuUUID, typeof_field(_state, _field)),  \
+        .set_default = true,                                       \
+        }
+#define DEFINE_PROP_AUDIODEV(_n, _s, _f) \
+    DEFINE_PROP(_n, _s, _f, qdev_prop_audiodev, QEMUSoundCard)
+
+#define DEFINE_PROP_UUID_NODEFAULT(_name, _state, _field) {        \
+        .name      = (_name),                                      \
+        .info      = &qdev_prop_uuid,                              \
+        .offset    = offsetof(_state, _field)                      \
+            + type_check(QemuUUID, typeof_field(_state, _field)),  \
+        }
+
+
+#endif
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 530286e869..d35d4aae84 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -55,30 +55,11 @@ extern const PropertyInfo qdev_prop_uint64;
 extern const PropertyInfo qdev_prop_int64;
 extern const PropertyInfo qdev_prop_size;
 extern const PropertyInfo qdev_prop_string;
-extern const PropertyInfo qdev_prop_chr;
 extern const PropertyInfo qdev_prop_tpm;
-extern const PropertyInfo qdev_prop_macaddr;
-extern const PropertyInfo qdev_prop_reserved_region;
 extern const PropertyInfo qdev_prop_on_off_auto;
-extern const PropertyInfo qdev_prop_multifd_compression;
-extern const PropertyInfo qdev_prop_losttickpolicy;
-extern const PropertyInfo qdev_prop_blockdev_on_error;
-extern const PropertyInfo qdev_prop_bios_chs_trans;
-extern const PropertyInfo qdev_prop_fdc_drive_type;
-extern const PropertyInfo qdev_prop_drive;
-extern const PropertyInfo qdev_prop_drive_iothread;
-extern const PropertyInfo qdev_prop_netdev;
-extern const PropertyInfo qdev_prop_pci_devfn;
 extern const PropertyInfo qdev_prop_size32;
-extern const PropertyInfo qdev_prop_blocksize;
-extern const PropertyInfo qdev_prop_pci_host_devaddr;
-extern const PropertyInfo qdev_prop_uuid;
 extern const PropertyInfo qdev_prop_arraylen;
-extern const PropertyInfo qdev_prop_audiodev;
 extern const PropertyInfo qdev_prop_link;
-extern const PropertyInfo qdev_prop_off_auto_pcibar;
-extern const PropertyInfo qdev_prop_pcie_link_speed;
-extern const PropertyInfo qdev_prop_pcie_link_width;
 
 #define DEFINE_PROP(_name, _state, _field, _prop, _type) { \
         .name      = (_name),                                    \
@@ -209,68 +190,12 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int64, int64_t)
 #define DEFINE_PROP_SIZE(_n, _s, _f, _d)                       \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size, uint64_t)
-#define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
-    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
-
-#define DEFINE_PROP_CHR(_n, _s, _f)             \
-    DEFINE_PROP(_n, _s, _f, qdev_prop_chr, CharBackend)
 #define DEFINE_PROP_STRING(_n, _s, _f)             \
     DEFINE_PROP(_n, _s, _f, qdev_prop_string, char*)
-#define DEFINE_PROP_NETDEV(_n, _s, _f)             \
-    DEFINE_PROP(_n, _s, _f, qdev_prop_netdev, NICPeers)
-#define DEFINE_PROP_DRIVE(_n, _s, _f) \
-    DEFINE_PROP(_n, _s, _f, qdev_prop_drive, BlockBackend *)
-#define DEFINE_PROP_DRIVE_IOTHREAD(_n, _s, _f) \
-    DEFINE_PROP(_n, _s, _f, qdev_prop_drive_iothread, BlockBackend *)
-#define DEFINE_PROP_MACADDR(_n, _s, _f)         \
-    DEFINE_PROP(_n, _s, _f, qdev_prop_macaddr, MACAddr)
-#define DEFINE_PROP_RESERVED_REGION(_n, _s, _f)         \
-    DEFINE_PROP(_n, _s, _f, qdev_prop_reserved_region, ReservedRegion)
 #define DEFINE_PROP_ON_OFF_AUTO(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_on_off_auto, OnOffAuto)
-#define DEFINE_PROP_MULTIFD_COMPRESSION(_n, _s, _f, _d) \
-    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_multifd_compression, \
-                       MultiFDCompression)
-#define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
-    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
-                        LostTickPolicy)
-#define DEFINE_PROP_BLOCKDEV_ON_ERROR(_n, _s, _f, _d) \
-    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_blockdev_on_error, \
-                        BlockdevOnError)
-#define DEFINE_PROP_BIOS_CHS_TRANS(_n, _s, _f, _d) \
-    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_bios_chs_trans, int)
 #define DEFINE_PROP_SIZE32(_n, _s, _f, _d)                       \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size32, uint32_t)
-#define DEFINE_PROP_BLOCKSIZE(_n, _s, _f) \
-    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint32_t)
-#define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
-    DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceAddress)
-#define DEFINE_PROP_OFF_AUTO_PCIBAR(_n, _s, _f, _d) \
-    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_off_auto_pcibar, \
-                        OffAutoPCIBAR)
-#define DEFINE_PROP_PCIE_LINK_SPEED(_n, _s, _f, _d) \
-    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pcie_link_speed, \
-                        PCIExpLinkSpeed)
-#define DEFINE_PROP_PCIE_LINK_WIDTH(_n, _s, _f, _d) \
-    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pcie_link_width, \
-                        PCIExpLinkWidth)
-
-#define DEFINE_PROP_UUID(_name, _state, _field) {                  \
-        .name      = (_name),                                      \
-        .info      = &qdev_prop_uuid,                              \
-        .offset    = offsetof(_state, _field)                      \
-            + type_check(QemuUUID, typeof_field(_state, _field)),  \
-        .set_default = true,                                       \
-        }
-#define DEFINE_PROP_AUDIODEV(_n, _s, _f) \
-    DEFINE_PROP(_n, _s, _f, qdev_prop_audiodev, QEMUSoundCard)
-
-#define DEFINE_PROP_UUID_NODEFAULT(_name, _state, _field) {        \
-        .name      = (_name),                                      \
-        .info      = &qdev_prop_uuid,                              \
-        .offset    = offsetof(_state, _field)                      \
-            + type_check(QemuUUID, typeof_field(_state, _field)),  \
-        }
 
 #define DEFINE_PROP_END_OF_LIST()               \
     {}
diff --git a/include/net/net.h b/include/net/net.h
index 897b2d7595..da48bc8254 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -4,6 +4,7 @@
 #include "qemu/queue.h"
 #include "qapi/qapi-types-net.h"
 #include "net/queue.h"
+#include "hw/qdev-properties-system.h"
 
 #define MAC_FMT "%02X:%02X:%02X:%02X:%02X:%02X"
 #define MAC_ARG(x) ((uint8_t *)(x))[0], ((uint8_t *)(x))[1], \
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index 2c8152d508..6c92fdae49 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -19,6 +19,7 @@
 #include "hw/acpi/vmgenid.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "sysemu/reset.h"
 
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 591776ba88..9c8030a271 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -21,6 +21,7 @@
 #include "hw/i2c/i2c.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/ssi/ssi.h"
 #include "hw/sd/sd.h"
 #include "chardev/char-fe.h"
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index ca7c385f31..c7ca54bcea 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -33,6 +33,7 @@
 #include "hw/boards.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "strongarm.h"
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 4c2c35e223..3636874432 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -36,6 +36,7 @@
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/block/block.h"
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 483925f57a..0ef7f00cb6 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -25,6 +25,7 @@
 #include "qemu/units.h"
 #include "sysemu/block-backend.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/ssi/ssi.h"
 #include "migration/vmstate.h"
 #include "qemu/bitops.h"
diff --git a/hw/block/nand.c b/hw/block/nand.c
index bcceb64ebb..5558f5d2fa 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/block/flash.h"
 #include "sysemu/block-backend.h"
 #include "migration/vmstate.h"
diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index 5ff7be86bb..579a73d7f7 100644
--- a/hw/block/onenand.c
+++ b/hw/block/onenand.c
@@ -24,6 +24,7 @@
 #include "hw/block/flash.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "sysemu/block-backend.h"
 #include "exec/memory.h"
 #include "hw/sysbus.h"
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index f0fcd63f84..90baa72f82 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -40,6 +40,7 @@
 #include "hw/block/block.h"
 #include "hw/block/flash.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index eb02fccfa5..e2d8a004fe 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -36,6 +36,7 @@
 #include "hw/block/block.h"
 #include "hw/block/flash.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/bitmap.h"
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index f67b29bbf3..d0d12e7f29 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -22,6 +22,7 @@
 #include "qemu/cutils.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-user-blk.h"
 #include "hw/virtio/virtio.h"
diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
index fbe2a112b7..5bcf9db0b7 100644
--- a/hw/char/avr_usart.c
+++ b/hw/char/avr_usart.c
@@ -24,6 +24,7 @@
 #include "qemu/log.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 
 static int avr_usart_can_receive(void *opaque)
 {
diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index dade2ab5fd..96410b1ff8 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -24,6 +24,7 @@
 #include "hw/char/bcm2835_aux.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index e196906c92..c603e14012 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -32,6 +32,7 @@
 #include "hw/char/cadence_uart.h"
 #include "hw/irq.h"
 #include "hw/qdev-clock.h"
+#include "hw/qdev-properties-system.h"
 #include "trace.h"
 
 #ifdef CADENCE_UART_ERR_DEBUG
diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
index 626b68f2ec..ba2cbbee3d 100644
--- a/hw/char/cmsdk-apb-uart.c
+++ b/hw/char/cmsdk-apb-uart.c
@@ -27,6 +27,7 @@
 #include "chardev/char-serial.h"
 #include "hw/char/cmsdk-apb-uart.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties-system.h"
 
 REG32(DATA, 0)
 REG32(STATE, 4)
diff --git a/hw/char/debugcon.c b/hw/char/debugcon.c
index 2a063ad72c..fdb04fee09 100644
--- a/hw/char/debugcon.c
+++ b/hw/char/debugcon.c
@@ -30,6 +30,7 @@
 #include "chardev/char-fe.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "qom/object.h"
 
 #define TYPE_ISA_DEBUGCON_DEVICE "isa-debugcon"
diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c
index e130cb4692..00e5df5517 100644
--- a/hw/char/digic-uart.c
+++ b/hw/char/digic-uart.c
@@ -35,6 +35,7 @@
 
 #include "hw/char/digic-uart.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 
 enum {
     ST_RX_RDY = (1 << 0),
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 7d16ee8688..52e7978287 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/char/etraxfs_ser.c b/hw/char/etraxfs_ser.c
index d9fba2ae6c..6bee3ee18e 100644
--- a/hw/char/etraxfs_ser.c
+++ b/hw/char/etraxfs_ser.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qemu/log.h"
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 96afe3580f..6361df2ad3 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -32,6 +32,7 @@
 #include "hw/arm/exynos4210.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 
 #include "trace.h"
 #include "qom/object.h"
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index 3f80f6824e..82ff40a530 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/sparc/grlib.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
index cc49a35013..89f1182c9b 100644
--- a/hw/char/ibex_uart.c
+++ b/hw/char/ibex_uart.c
@@ -30,6 +30,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 731b8fc64c..ee1375e26d 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -22,6 +22,7 @@
 #include "hw/char/imx_serial.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index ad000a39b9..3311e0872c 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -12,6 +12,7 @@
 #include "hw/ipack/ipack.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "qemu/bitops.h"
 #include "qemu/module.h"
diff --git a/hw/char/lm32_juart.c b/hw/char/lm32_juart.c
index b97aacba91..c5ead05e08 100644
--- a/hw/char/lm32_juart.c
+++ b/hw/char/lm32_juart.c
@@ -26,6 +26,7 @@
 
 #include "hw/char/lm32_juart.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "qom/object.h"
 
 enum {
diff --git a/hw/char/lm32_uart.c b/hw/char/lm32_uart.c
index 0e8b4e46a3..5cb87de548 100644
--- a/hw/char/lm32_uart.c
+++ b/hw/char/lm32_uart.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index e6814faffb..6fa4ac502c 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -13,6 +13,7 @@
 #include "qapi/error.h"
 #include "hw/m68k/mcf.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "chardev/char-fe.h"
 #include "qom/object.h"
 
diff --git a/hw/char/milkymist-uart.c b/hw/char/milkymist-uart.c
index 1e83dbcafa..09e2f6bd76 100644
--- a/hw/char/milkymist-uart.c
+++ b/hw/char/milkymist-uart.c
@@ -24,6 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
index d1fef77acd..045ca5fa40 100644
--- a/hw/char/nrf51_uart.c
+++ b/hw/char/nrf51_uart.c
@@ -18,6 +18,7 @@
 #include "hw/char/nrf51_uart.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 8b418abf71..b45e67bfbb 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -32,6 +32,7 @@
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "hw/char/parallel.h"
 #include "sysemu/reset.h"
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index ede16c781c..ea4a4e5235 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -23,6 +23,7 @@
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-clock.h"
+#include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "chardev/char-fe.h"
 #include "qemu/log.h"
diff --git a/hw/char/renesas_sci.c b/hw/char/renesas_sci.c
index 5d7c6e6523..1c63467290 100644
--- a/hw/char/renesas_sci.c
+++ b/hw/char/renesas_sci.c
@@ -26,6 +26,7 @@
 #include "hw/irq.h"
 #include "hw/registerfields.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/char/renesas_sci.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index 81f6d0ed4f..b9e9b2d453 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -23,6 +23,7 @@
 #include "migration/vmstate.h"
 #include "hw/s390x/event-facility.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/s390x/ebcdic.h"
 #include "qom/object.h"
 
diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index aa72ab40b9..c36b572222 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -20,6 +20,7 @@
 #include "hw/s390x/sclp.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/s390x/event-facility.h"
 #include "chardev/char-fe.h"
 #include "qom/object.h"
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 2cf3e44177..3a9f96c2d1 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -33,6 +33,7 @@
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 
 #define PCI_SERIAL_MAX_PORTS 4
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 97f71879ff..d99daa7695 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -35,6 +35,7 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 
 #define UART_LCR_DLAB	0x80	/* Divisor latch access bit */
 
diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index e726d4d915..79eaa2fa52 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -8,6 +8,7 @@
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "qom/object.h"
 
 #define VTERM_BUFSIZE   16
diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index 0d661be6d3..8df0832424 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -26,6 +26,7 @@
 #include "hw/char/stm32f2xx_usart.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 
diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index d77981bb6d..a9a46c8ed3 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -16,6 +16,7 @@
 #include "qemu/module.h"
 #include "chardev/char-fe.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/s390x/3270-ccw.h"
 #include "qom/object.h"
 
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index bc752cf90f..6b132caa29 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -16,6 +16,7 @@
 #include "qemu/module.h"
 #include "trace.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/virtio/virtio-serial.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-char.h"
diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index 2e773ec4c4..99b9a6f851 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -26,6 +26,7 @@
 #include "qemu/log.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "chardev/char-fe.h"
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 35515886a9..a05150bfd0 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qapi/qapi-types-block.h"
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 896e981f85..984caf898d 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -13,6 +13,7 @@
 #include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/hyperv/hyperv.h"
 #include "hw/hyperv/vmbus.h"
 #include "hw/hyperv/vmbus-bridge.h"
diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 40d84734e7..c73254e886 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -32,6 +32,7 @@
 #include "sysemu/runstate.h"
 #include "hw/timer/i8254.h"
 #include "hw/timer/i8254_internal.h"
+#include "hw/qdev-properties-system.h"
 #include "sysemu/kvm.h"
 #include "qom/object.h"
 
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 27ff1f7f66..73499a6235 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -26,6 +26,7 @@
 #include "qemu/module.h"
 #include "hw/ide/internal.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "hw/block/block.h"
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index c3f3306e66..e141a5cd45 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -35,6 +35,7 @@
 #include "chardev/char-fe.h"
 #include "hw/ipmi/ipmi.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
 
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index f78e92d3d5..55fb81fa5a 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -30,6 +30,7 @@
 #include "qemu/module.h"
 #include "hw/loader.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 
 #define IPMI_NETFN_CHASSIS            0x00
diff --git a/hw/misc/allwinner-sid.c b/hw/misc/allwinner-sid.c
index 196380c33a..6d61f55b1d 100644
--- a/hw/misc/allwinner-sid.c
+++ b/hw/misc/allwinner-sid.c
@@ -26,6 +26,7 @@
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/misc/allwinner-sid.h"
 #include "trace.h"
 
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index e321e5cb69..0505b52c98 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -23,6 +23,7 @@
 #include "qemu/cutils.h"
 #include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "sysemu/kvm.h"
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 6db62dab7d..488d086a17 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -28,6 +28,7 @@
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "sysemu/block-backend.h"
 #include "trace.h"
 #include "qemu/log.h"
diff --git a/hw/misc/sifive_u_otp.c b/hw/misc/sifive_u_otp.c
index 60066375ab..4401787a5c 100644
--- a/hw/misc/sifive_u_otp.c
+++ b/hw/misc/sifive_u_otp.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/sysbus.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 1af1e6fa2f..0fb8db1dee 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "hw/pci/msix.h"
 #include "net/net.h"
diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index 3e93dbbffb..af6f5dbb99 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -13,6 +13,7 @@
 #include "qemu/module.h"
 #include "hw/i2c/i2c.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "sysemu/block-backend.h"
 #include "qom/object.h"
 
diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index fc53a42572..9e51bc82ae 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -39,6 +39,7 @@
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "qom/object.h"
 
 struct SpaprNvram {
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index 8931afc049..ec9907917e 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -16,6 +16,7 @@
 #include "hw/pci/msix.h"
 #include "hw/pci/pcie_port.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 0131d9d02c..ad2fa1eea2 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -30,6 +30,7 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "monitor/monitor.h"
diff --git a/hw/ppc/pnv_pnor.c b/hw/ppc/pnv_pnor.c
index c365ee58b8..ef8dff03e0 100644
--- a/hw/ppc/pnv_pnor.c
+++ b/hw/ppc/pnv_pnor.c
@@ -17,6 +17,7 @@
 #include "hw/loader.h"
 #include "hw/ppc/pnv_pnor.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 
 static uint64_t pnv_pnor_read(void *opaque, hwaddr addr, unsigned size)
 {
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 77b1235a3f..8593570332 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -21,6 +21,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "cpu.h"
 #include "trace.h"
 #include "monitor/monitor.h"
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 7a38540cb9..5d0fcacd0c 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -30,6 +30,7 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/replay.h"
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index e859534eaf..f9a591cd17 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -34,6 +34,7 @@
 #include "sysemu/blockdev.h"
 #include "hw/block/block.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "sysemu/dma.h"
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 2cb23ca891..9740f7e36a 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -19,6 +19,7 @@
 #include "hw/scsi/scsi.h"
 #include "migration/qemu-file-types.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/scsi/emulation.h"
 #include "sysemu/block-backend.h"
 #include "trace.h"
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 7c0631656c..4666019442 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -21,6 +21,7 @@
 #include "hw/fw-path-provider.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-backend.h"
 #include "hw/virtio/vhost-user-scsi.h"
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 3091382614..fa07398c8c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -42,6 +42,7 @@
 #include "qapi/error.h"
 #include "qemu/bitmap.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index e8e9d37e88..c27c602697 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -14,6 +14,7 @@
 #include <libcacard.h>
 #include "chardev/char-fe.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index b1622b7c7f..504e1ef423 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -14,6 +14,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/usb.h"
 #include "migration/vmstate.h"
 #include "desc.h"
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 3238de6bb8..0b7e0e15f4 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -42,6 +42,7 @@
 #include <usbredirfilter.h>
 
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/usb.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 58c0ce8971..edfaed8c9a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -27,6 +27,7 @@
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 1bc5d03a00..ed036ad9c1 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -16,6 +16,7 @@
 #include "standard-headers/linux/virtio_fs.h"
 #include "qapi/error.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
 #include "qemu/error-report.h"
diff --git a/hw/virtio/vhost-user-vsock.c b/hw/virtio/vhost-user-vsock.c
index 3534a39d62..a6f08c26b9 100644
--- a/hw/virtio/vhost-user-vsock.c
+++ b/hw/virtio/vhost-user-vsock.c
@@ -13,6 +13,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/virtio/vhost-user-vsock.h"
 
 static const int user_feature_bits[] = {
diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
index 378f63b210..770c286be7 100644
--- a/hw/virtio/virtio-iommu-pci.c
+++ b/hw/virtio/virtio-iommu-pci.c
@@ -14,6 +14,7 @@
 #include "virtio-pci.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "qapi/error.h"
 #include "hw/boards.h"
 #include "qom/object.h"
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 6d359ee486..3cbd08b10e 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -58,6 +58,7 @@
 
 #include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/xen/xen.h"
 #include "hw/i386/pc.h"
 #include "hw/xen/xen-legacy-backend.h"
diff --git a/migration/migration.c b/migration/migration.c
index 3263aa55a9..68c8c715fa 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -52,6 +52,7 @@
 #include "migration/colo.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "monitor/monitor.h"
 #include "net/announce.h"
 #include "qemu/queue.h"
-- 
2.28.0


