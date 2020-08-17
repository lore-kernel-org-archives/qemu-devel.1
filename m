Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4838C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD25A23108
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlCJl+AF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD25A23108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7h7Y-0003LR-LG
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gKg-0003AD-Ed
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:41:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56116
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gKe-0006rn-3c
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597675311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TSsMqdmMCMfkXupUFs34oZSkfx6BbapuB0jvch6famI=;
 b=NlCJl+AF1Qu+ZgarWk2jKFfWdXf5y7dAfBTyyY+o0xzqDuKv7tNqTkmBzZ9PT+KHz6kP/W
 0IIognwtJGpg22DShMTiM4we9+0+HzMWFPt/7uMz9ALP2cII5NzOBbTDueatv5ZFPiW6FI
 k67ordDpMdpXuRsL7VQUjgKXzxGiB/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-a8ieGbOiMaaHcdPqmBboHg-1; Mon, 17 Aug 2020 10:41:48 -0400
X-MC-Unique: a8ieGbOiMaaHcdPqmBboHg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C8E8801AD9
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 14:41:47 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35721756AB;
 Mon, 17 Aug 2020 14:41:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 118/150] meson: convert hw/display
Date: Mon, 17 Aug 2020 16:40:21 +0200
Message-Id: <20200817144053.345107-23-pbonzini@redhat.com>
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 03:34:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 hw/display/Makefile.objs | 65 -------------------------------
 hw/display/meson.build   | 84 ++++++++++++++++++++++++++++++++++++++++
 hw/meson.build           |  1 +
 5 files changed, 86 insertions(+), 66 deletions(-)
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
index 0000000000..78adaf9db4
--- /dev/null
+++ b/hw/display/meson.build
@@ -0,0 +1,84 @@
+hw_display_modules = {}
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
+  qxl_ss = ss.source_set()
+  qxl_ss.add(when: 'CONFIG_QXL', if_true: files('qxl.c', 'qxl-logger.c', 'qxl-render.c'))
+  hw_display_modules += {'qxl': qxl_ss}
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
+  virtio_gpu_ss.add(when: 'CONFIG_VIRTIO_GPU',
+                    if_true: [files('virtio-gpu-base.c', 'virtio-gpu.c', 'virtio-gpu-3d.c'), pixman, virgl])
+  virtio_gpu_ss.add(when: 'CONFIG_VHOST_USER_GPU', if_true: files('vhost-user-gpu.c'))
+  virtio_gpu_ss.add(when: ['CONFIG_VIRTIO_GPU', 'CONFIG_VIRTIO_PCI'], if_true: files('virtio-gpu-pci.c'))
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
+  #hw_display_modules += {'virtio-gpu': virtio_gpu_ss}
+  softmmu_ss.add_all(virtio_gpu_ss)
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



