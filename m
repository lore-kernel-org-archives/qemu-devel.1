Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89C1C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:20:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7343A204EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PO5eFU5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7343A204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Wp0-0006R9-Kx
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 06:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vnf-0007ju-Ch
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21201
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vnc-00038w-Ud
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ZLY61lPrmslZj9ndjJBXaJxDDWc4dKevRyPl8Grryw=;
 b=PO5eFU5xvwbJ3k8+hrSwkD9ELpH4JJldoOsaiZvsupRnS1E9YgTJR3EDCRTY8hxyzKmQ+D
 ztiif+0Q2b2yQ4cr7Z4NtpbtDAGPdifVq6a+lFkY01P3IzBy4fk51dOw7YgBaXj0jiuWb0
 s3rQuevKT01/zuyE4gEBzlSgBlmZuyI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-LcazlgbFNGq4orDBX9F9Sw-1; Fri, 14 Aug 2020 05:14:52 -0400
X-MC-Unique: LcazlgbFNGq4orDBX9F9Sw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35794801AC3
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:14:51 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E6271600E4;
 Fri, 14 Aug 2020 09:14:50 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 119/150] meson: convert hw/display
Date: Fri, 14 Aug 2020 05:12:55 -0400
Message-Id: <20200814091326.16173-120-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 03:37:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.target          |  1 +
 hw/Makefile.objs         |  1 -
 hw/display/Makefile.objs | 65 ------------------------------
 hw/display/meson.build   | 87 ++++++++++++++++++++++++++++++++++++++++
 hw/meson.build           |  1 +
 5 files changed, 89 insertions(+), 66 deletions(-)
 delete mode 100644 hw/display/Makefile.objs
 create mode 100644 hw/display/meson.build

diff --git a/Makefile.target b/Makefile.target
index 3d5a2af4af..3534ece38a 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -169,6 +169,7 @@ LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS) $(OPENGL_LIBS) $(SECCOM
 LIBS := $(LIBS) $(COREAUDIO_LIBS) $(DSOUND_LIBS)
 LIBS := $(LIBS) $(VDE_LIBS) $(SLIRP_LIBS)
 LIBS := $(LIBS) $(LIBUSB_LIBS) $(SMARTCARD_LIBS) $(USB_REDIR_LIBS)
+LIBS := $(LIBS) $(VIRGL_LIBS)
 
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 26917a4e1b..6fce6a1473 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -6,7 +6,6 @@ devices-dirs-y += audio/
 devices-dirs-y += block/
 devices-dirs-y += char/
 devices-dirs-y += cpu/
-devices-dirs-y += display/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
deleted file mode 100644
index d619594ad4..0000000000
--- a/hw/display/Makefile.objs
+++ /dev/null
@@ -1,65 +0,0 @@
-common-obj-$(CONFIG_DDC) += i2c-ddc.o
-common-obj-$(CONFIG_EDID) += edid-generate.o edid-region.o
-
-common-obj-$(CONFIG_FW_CFG_DMA) += ramfb.o
-common-obj-$(CONFIG_FW_CFG_DMA) += ramfb-standalone.o
-
-common-obj-$(CONFIG_ADS7846) += ads7846.o
-common-obj-$(CONFIG_VGA_CIRRUS) += cirrus_vga.o
-common-obj-$(call land,$(CONFIG_VGA_CIRRUS),$(CONFIG_VGA_ISA))+=cirrus_vga_isa.o
-common-obj-$(CONFIG_G364FB) += g364fb.o
-common-obj-$(CONFIG_JAZZ_LED) += jazz_led.o
-common-obj-$(CONFIG_PL110) += pl110.o
-common-obj-$(CONFIG_SII9022) += sii9022.o
-common-obj-$(CONFIG_SSD0303) += ssd0303.o
-common-obj-$(CONFIG_SSD0323) += ssd0323.o
-common-obj-$(CONFIG_XEN) += xenfb.o
-
-common-obj-$(CONFIG_VGA_PCI) += vga-pci.o
-common-obj-$(CONFIG_VGA_ISA) += vga-isa.o
-common-obj-$(CONFIG_VGA_ISA_MM) += vga-isa-mm.o
-common-obj-$(CONFIG_VMWARE_VGA) += vmware_vga.o
-common-obj-$(CONFIG_BOCHS_DISPLAY) += bochs-display.o
-
-common-obj-$(CONFIG_BLIZZARD) += blizzard.o
-common-obj-$(CONFIG_EXYNOS4) += exynos4210_fimd.o
-common-obj-$(CONFIG_FRAMEBUFFER) += framebuffer.o
-common-obj-$(CONFIG_MILKYMIST) += milkymist-vgafb.o
-common-obj-$(CONFIG_ZAURUS) += tc6393xb.o
-common-obj-$(CONFIG_MACFB) += macfb.o
-
-obj-$(CONFIG_MILKYMIST_TMU2) += milkymist-tmu2.o
-milkymist-tmu2.o-cflags := $(X11_CFLAGS) $(OPENGL_CFLAGS)
-milkymist-tmu2.o-libs := $(X11_LIBS) $(OPENGL_LIBS)
-
-common-obj-$(CONFIG_OMAP) += omap_dss.o
-obj-$(CONFIG_OMAP) += omap_lcdc.o
-common-obj-$(CONFIG_PXA2XX) += pxa2xx_lcd.o
-common-obj-$(CONFIG_RASPI) += bcm2835_fb.o
-common-obj-$(CONFIG_SM501) += sm501.o
-common-obj-$(CONFIG_TCX) += tcx.o
-common-obj-$(CONFIG_CG3) += cg3.o
-common-obj-$(CONFIG_NEXTCUBE) += next-fb.o
-common-obj-$(CONFIG_ARTIST) += artist.o
-
-obj-$(CONFIG_VGA) += vga.o
-
-ifeq ($(CONFIG_QXL),y)
-common-obj-m += qxl.mo
-qxl.mo-objs = qxl.o qxl-logger.o qxl-render.o
-endif
-
-common-obj-$(CONFIG_VIRTIO_GPU) += virtio-gpu-base.o virtio-gpu.o virtio-gpu-3d.o
-common-obj-$(CONFIG_VHOST_USER_GPU) += vhost-user-gpu.o
-common-obj-$(call land,$(CONFIG_VIRTIO_GPU),$(CONFIG_VIRTIO_PCI)) += virtio-gpu-pci.o
-common-obj-$(call land,$(CONFIG_VHOST_USER_GPU),$(CONFIG_VIRTIO_PCI)) += vhost-user-gpu-pci.o
-common-obj-$(CONFIG_VIRTIO_VGA) += virtio-vga.o
-common-obj-$(CONFIG_VHOST_USER_VGA) += vhost-user-vga.o
-virtio-gpu.o-cflags := $(VIRGL_CFLAGS)
-virtio-gpu.o-libs += $(VIRGL_LIBS)
-virtio-gpu-3d.o-cflags := $(VIRGL_CFLAGS)
-virtio-gpu-3d.o-libs += $(VIRGL_LIBS)
-common-obj-$(CONFIG_DPCD) += dpcd.o
-common-obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx_dp.o
-
-common-obj-$(CONFIG_ATI_VGA) += ati.o ati_2d.o ati_dbg.o
diff --git a/hw/display/meson.build b/hw/display/meson.build
new file mode 100644
index 0000000000..fa4f8060e2
--- /dev/null
+++ b/hw/display/meson.build
@@ -0,0 +1,87 @@
+hw_display_modules = []
+
+softmmu_ss.add(when: 'CONFIG_DDC', if_true: files('i2c-ddc.c'))
+softmmu_ss.add(when: 'CONFIG_EDID', if_true: files('edid-generate.c', 'edid-region.c'))
+
+softmmu_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('ramfb.c'))
+softmmu_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('ramfb-standalone.c'))
+
+softmmu_ss.add(when: 'CONFIG_ADS7846', if_true: files('ads7846.c'))
+softmmu_ss.add(when: 'CONFIG_VGA_CIRRUS', if_true: files('cirrus_vga.c'))
+softmmu_ss.add(when: ['CONFIG_VGA_CIRRUS', 'CONFIG_VGA_ISA'], if_true: files('cirrus_vga_isa.c'))
+softmmu_ss.add(when: 'CONFIG_G364FB', if_true: files('g364fb.c'))
+softmmu_ss.add(when: 'CONFIG_JAZZ_LED', if_true: files('jazz_led.c'))
+softmmu_ss.add(when: 'CONFIG_PL110', if_true: files('pl110.c'))
+softmmu_ss.add(when: 'CONFIG_SII9022', if_true: files('sii9022.c'))
+softmmu_ss.add(when: 'CONFIG_SSD0303', if_true: files('ssd0303.c'))
+softmmu_ss.add(when: 'CONFIG_SSD0323', if_true: files('ssd0323.c'))
+softmmu_ss.add(when: 'CONFIG_XEN', if_true: files('xenfb.c'))
+
+softmmu_ss.add(when: 'CONFIG_VGA_PCI', if_true: files('vga-pci.c'))
+softmmu_ss.add(when: 'CONFIG_VGA_ISA', if_true: files('vga-isa.c'))
+softmmu_ss.add(when: 'CONFIG_VGA_ISA_MM', if_true: files('vga-isa-mm.c'))
+softmmu_ss.add(when: 'CONFIG_VMWARE_VGA', if_true: files('vmware_vga.c'))
+softmmu_ss.add(when: 'CONFIG_BOCHS_DISPLAY', if_true: files('bochs-display.c'))
+
+softmmu_ss.add(when: 'CONFIG_BLIZZARD', if_true: files('blizzard.c'))
+softmmu_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_fimd.c'))
+softmmu_ss.add(when: 'CONFIG_FRAMEBUFFER', if_true: files('framebuffer.c'))
+softmmu_ss.add(when: 'CONFIG_ZAURUS', if_true: files('tc6393xb.c'))
+
+softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_dss.c'))
+softmmu_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx_lcd.c'))
+softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_fb.c'))
+softmmu_ss.add(when: 'CONFIG_SM501', if_true: files('sm501.c'))
+softmmu_ss.add(when: 'CONFIG_TCX', if_true: files('tcx.c'))
+softmmu_ss.add(when: 'CONFIG_CG3', if_true: files('cg3.c'))
+softmmu_ss.add(when: 'CONFIG_MACFB', if_true: files('macfb.c'))
+softmmu_ss.add(when: 'CONFIG_NEXTCUBE', if_true: files('next-fb.c'))
+
+specific_ss.add(when: 'CONFIG_VGA', if_true: files('vga.c'))
+
+if config_all_devices.has_key('CONFIG_QXL')
+  hw_display_modules += [[ 'qxl',
+    files('qxl.c', 'qxl-logger.c', 'qxl-render.c'), [],
+    ['CONFIG_QXL']]]
+endif
+
+softmmu_ss.add(when: 'CONFIG_QXL', if_true: files('qxl.c', 'qxl-logger.c', 'qxl-render.c'))
+
+softmmu_ss.add(when: 'CONFIG_DPCD', if_true: files('dpcd.c'))
+softmmu_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx_dp.c'))
+
+softmmu_ss.add(when: 'CONFIG_MILKYMIST', if_true: files('milkymist-vgafb.c'))
+softmmu_ss.add(when: 'CONFIG_ARTIST', if_true: files('artist.c'))
+
+softmmu_ss.add(when: [pixman, 'CONFIG_ATI_VGA'], if_true: files('ati.c', 'ati_2d.c', 'ati_dbg.c'))
+
+if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
+  virtio_gpu_ss = ss.source_set()
+  virtio_gpu_ss.add(files('virtio-gpu-base.c', 'virtio-gpu.c', 'virtio-gpu-3d.c'), virgl)
+  virtio_gpu_ss.add(when: 'CONFIG_VHOST_USER_GPU', if_true: files('vhost-user-gpu.c'))
+  virtio_gpu_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('virtio-gpu-pci.c'))
+  virtio_gpu_ss.add(when: ['CONFIG_VHOST_USER_GPU', 'CONFIG_VIRTIO_PCI'], if_true: files('vhost-user-gpu-pci.c'))
+  virtio_gpu_ss.add(when: 'CONFIG_VIRTIO_VGA', if_true: files('virtio-vga.c'))
+  virtio_gpu_ss.add(when: 'CONFIG_VHOST_USER_VGA', if_true: files('vhost-user-vga.c'))
+
+  # FIXME: this was attempted in the Makefile build system; it was then reverted
+  # as it would try to load all devices when the module is loaded, even if
+  # config_devices for this target only has some of them.  Since virtio-gpu-pci
+  # and virtio-vga both instantiate a virtio-gpu-device, fixing it probably does
+  # not even require a dependency system, just splitting the module in three
+  # for CONFIG_VIRTIO_GPU/CONFIG_VHOST_USER_GPU, CONFIG_VIRTIO_PCI and
+  # CONFIG_VIRTIO_VGA/CONFIG_VHOST_USER_VGA.
+  # Sourcesets are a dime a dozen, so keep it and just disable module builds.
+
+  #virtio_gpu = virtio_gpu_ss.apply(config_all_devices, strict: false)
+  #hw_display_modules += [[ 'virtio-gpu', virtio_gpu.sources(), [pixman, virgl],
+  #                         ['CONFIG_VIRTIO_GPU']]]
+
+  softmmu_ss.add_all(when: [pixman, 'CONFIG_VIRTIO_GPU'],
+                     if_true: virtio_gpu_ss)
+endif
+
+specific_ss.add(when: [x11, opengl, 'CONFIG_MILKYMIST_TMU2'], if_true: files('milkymist-tmu2.c'))
+specific_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_lcdc.c'))
+
+modules += { 'hw-display': hw_display_modules }
diff --git a/hw/meson.build b/hw/meson.build
index 96da0bba7e..dacd26c561 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('display')
 subdir('dma')
 subdir('gpio')
 subdir('hyperv')
-- 
2.26.2



