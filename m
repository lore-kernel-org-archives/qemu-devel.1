Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D620CC33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:13:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17D22173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqdEFNvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17D22173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWII-0000GI-Nz
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:13:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7Z-0003Ht-Kw
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7X-0007ao-RC
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:53 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:35719)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV7X-0007Yc-IR
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:51 -0500
Received: by mail-wm1-x32d.google.com with SMTP id b2so3600346wma.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e+qtgCdpOeJOC4Rp1Gg+3P+sBCiPhjH5Ne8mCM5XsY8=;
 b=DqdEFNvArpQNsvhl+q7SuslFaLLJwrjnr0E0tJE+cS4xL0++JZdFexbMiIxNSuYWlv
 b1HLRwEJ180jb6fUKHBg+wzTj7Cd8vemuV528P6u3aM9uu7JbYSRXDivrwKqyf5QLWwn
 uvE7IiszGpOvLIiCZG4lDIfdLhxDSKXq9fRUmOBDJgadBVTIl00z7IWmkPAFMWxg5fdf
 pSRZB6rbL9DT0dBluSUf8DD/I5KKwb16K5GODidxDaMgjmJVsGqsRtSAr1+Tf0WOkC36
 xBP3d7Q7XizqD/q+y5wEG8a716WEwhIsWGTY5osq9fejNH+tTmYPOwp5m8I4E4uS8fdw
 PCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=e+qtgCdpOeJOC4Rp1Gg+3P+sBCiPhjH5Ne8mCM5XsY8=;
 b=Mb0KWwobrHXNN7RIzFHnMtPM0adf+fjf9eImstQXHWS9f4YHdwuJhJ/+EnhS1UFaF3
 Odul5nP4W1gCgdwUwey04e+kfSYmBImbmkQz0TwhFPxaI/3g8RhUOzi8L8+VSxiGhtbB
 C0LfZShVFJL4ZFS24tHp1gce974N3hRq8ZzInn6C4ERLmI0eP3K2StrSaj48i6ta/Pta
 Z0swx5EayCsc4Gr2hFeHEpY74E2+KwHotHcDdNPBkiOk+KhfAUpE8EX1E5/8pjVPEz/R
 0oYiS5ZXFeM9gt/tTp/LUgRoy1lHB3qSZ/9kaTALWNNvIIJ+oakZkev+dxeCiqE1tbwK
 MypA==
X-Gm-Message-State: APjAAAXcoixT93RiObMgrhTT27txvvUG18YnEmNf09SxH0bOxDbdjNak
 dnj+ykBHrx6vYvhkCxs8FuwH1oPO
X-Google-Smtp-Source: APXvYqyM2e8XUGXKZC2tSDbu9/HF4QK0iZFMhirApXercUdGZdU4ZewmtEifF/U6FuEg5VMovQejeg==
X-Received: by 2002:a1c:62c1:: with SMTP id w184mr6375704wmb.150.1580234270201; 
 Tue, 28 Jan 2020 09:57:50 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:57:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 103/142] meson: convert hw/display
Date: Tue, 28 Jan 2020 18:53:03 +0100
Message-Id: <20200128175342.9066-104-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
---
 Makefile.target          |  1 +
 hw/Makefile.objs         |  1 -
 hw/display/Makefile.objs | 61 ----------------------------------------
 hw/display/meson.build   | 56 ++++++++++++++++++++++++++++++++++++
 hw/meson.build           |  1 +
 5 files changed, 58 insertions(+), 62 deletions(-)
 delete mode 100644 hw/display/Makefile.objs
 create mode 100644 hw/display/meson.build

diff --git a/Makefile.target b/Makefile.target
index ea6f485675..1ce0c7f800 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -170,6 +170,7 @@ LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS) $(OPENGL_LIBS) $(SECCOM
 LIBS := $(LIBS) $(COREAUDIO_LIBS) $(DSOUND_LIBS)
 LIBS := $(LIBS) $(VDE_LIBS) $(SLIRP_LIBS)
 LIBS := $(LIBS) $(LIBUSB_LIBS) $(SMARTCARD_LIBS) $(USB_REDIR_LIBS)
+LIBS := $(LIBS) $(VIRGL_LIBS)
 
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 1f946ee6f3..53e4c16f78 100644
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
index f2182e3bef..0000000000
--- a/hw/display/Makefile.objs
+++ /dev/null
@@ -1,61 +0,0 @@
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
-obj-$(CONFIG_MILKYMIST) += milkymist-vgafb.o
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
-
-obj-$(CONFIG_VGA) += vga.o
-
-common-obj-$(CONFIG_QXL) += qxl.o qxl-logger.o qxl-render.o
-
-obj-$(CONFIG_VIRTIO_GPU) += virtio-gpu-base.o virtio-gpu.o virtio-gpu-3d.o
-obj-$(CONFIG_VHOST_USER_GPU) += vhost-user-gpu.o
-obj-$(call land,$(CONFIG_VIRTIO_GPU),$(CONFIG_VIRTIO_PCI)) += virtio-gpu-pci.o
-obj-$(call land,$(CONFIG_VHOST_USER_GPU),$(CONFIG_VIRTIO_PCI)) += vhost-user-gpu-pci.o
-obj-$(CONFIG_VIRTIO_VGA) += virtio-vga.o
-obj-$(CONFIG_VHOST_USER_VGA) += vhost-user-vga.o
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
index 0000000000..92863ccbba
--- /dev/null
+++ b/hw/display/meson.build
@@ -0,0 +1,56 @@
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
+softmmu_ss.add(when: 'CONFIG_QXL', if_true: files('qxl.c', 'qxl-logger.c', 'qxl-render.c'))
+
+softmmu_ss.add(when: 'CONFIG_DPCD', if_true: files('dpcd.c'))
+softmmu_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx_dp.c'))
+
+softmmu_ss.add(when: [pixman, 'CONFIG_ATI_VGA'], if_true: files('ati.c', 'ati_2d.c', 'ati_dbg.c'))
+
+specific_ss.add(when: [pixman, 'CONFIG_VIRTIO_GPU'], if_true: [files('virtio-gpu-base.c', 'virtio-gpu.c', 'virtio-gpu-3d.c'), virgl])
+specific_ss.add(when: [pixman, 'CONFIG_VHOST_USER_GPU'], if_true: files('vhost-user-gpu.c'))
+specific_ss.add(when: ['CONFIG_VIRTIO_GPU', 'CONFIG_VIRTIO_PCI'], if_true: files('virtio-gpu-pci.c'))
+specific_ss.add(when: ['CONFIG_VHOST_USER_GPU', 'CONFIG_VIRTIO_PCI'], if_true: files('vhost-user-gpu-pci.c'))
+specific_ss.add(when: 'CONFIG_VIRTIO_VGA', if_true: files('virtio-vga.c'))
+specific_ss.add(when: 'CONFIG_VHOST_USER_VGA', if_true: files('vhost-user-vga.c'))
+
+specific_ss.add(when: [x11, opengl, 'CONFIG_MILKYMIST_TMU2'], if_true: files('milkymist-tmu2.c'))
+specific_ss.add(when: 'CONFIG_MILKYMIST', if_true: files('milkymist-vgafb.c'))
+specific_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_lcdc.c'))
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
2.21.0



