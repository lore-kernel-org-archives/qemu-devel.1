Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D272C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E97BB218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOY0gTT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97BB218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihuwp-0006hq-DN
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:30:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihuqe-0007AR-Cm
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihuqc-0005L0-Mr
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43639
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihuqc-0005HZ-Gw
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7gWYMTZampjPsNJm58M4yt8F4jJFZ6y7TePX+di3XQE=;
 b=NOY0gTT5rCVVR03qMGlCtnvgdsa034s8fl4OjuTUz5q35plGdVBTtV1Ku02UYlAMavsFVa
 p+lcjXocaD3nUcST9mYCFzELxKN6REzKsojLUs5fzOpW3AAT68ieEbQi+wFyvWj9PZFTjd
 Ng+vGdQdm41z6XekWOtFqlVpNG/b1Yg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-UMUlwgjkNh2b9K7LBiS0oA-1; Thu, 19 Dec 2019 07:24:04 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93165107ACC5
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:24:03 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66E6160C18;
 Thu, 19 Dec 2019 12:24:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 095/132] meson: convert hw/display
Date: Thu, 19 Dec 2019 13:23:15 +0100
Message-Id: <1576758232-12439-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: UMUlwgjkNh2b9K7LBiS0oA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile.target          |  1 +
 hw/Makefile.objs         |  1 -
 hw/display/Makefile.objs | 59 --------------------------------------------=
----
 hw/display/meson.build   | 54 ++++++++++++++++++++++++++++++++++++++++++++
 hw/meson.build           |  1 +
 5 files changed, 56 insertions(+), 60 deletions(-)
 delete mode 100644 hw/display/Makefile.objs
 create mode 100644 hw/display/meson.build

diff --git a/Makefile.target b/Makefile.target
index a41e4e5..82f384c 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -168,6 +168,7 @@ LIBS :=3D $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LI=
BS) $(OPENGL_LIBS) $(SECCOM
 LIBS :=3D $(LIBS) $(COREAUDIO_LIBS) $(DSOUND_LIBS)
 LIBS :=3D $(LIBS) $(VDE_LIBS) $(SLIRP_LIBS)
 LIBS :=3D $(LIBS) $(LIBUSB_LIBS) $(SMARTCARD_LIBS) $(USB_REDIR_LIBS)
+LIBS :=3D $(LIBS) $(VIRGL_LIBS)
=20
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index f5fd490..acc6bee 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -7,7 +7,6 @@ devices-dirs-y +=3D block/
 devices-dirs-y +=3D bt/
 devices-dirs-y +=3D char/
 devices-dirs-y +=3D cpu/
-devices-dirs-y +=3D display/
 endif
=20
 common-obj-y +=3D $(devices-dirs-y)
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
deleted file mode 100644
index 0f11d55..0000000
--- a/hw/display/Makefile.objs
+++ /dev/null
@@ -1,59 +0,0 @@
-common-obj-$(CONFIG_DDC) +=3D i2c-ddc.o
-common-obj-$(CONFIG_EDID) +=3D edid-generate.o edid-region.o
-
-common-obj-$(CONFIG_FW_CFG_DMA) +=3D ramfb.o
-common-obj-$(CONFIG_FW_CFG_DMA) +=3D ramfb-standalone.o
-
-common-obj-$(CONFIG_ADS7846) +=3D ads7846.o
-common-obj-$(CONFIG_VGA_CIRRUS) +=3D cirrus_vga.o
-common-obj-$(call land,$(CONFIG_VGA_CIRRUS),$(CONFIG_VGA_ISA))+=3Dcirrus_v=
ga_isa.o
-common-obj-$(CONFIG_G364FB) +=3D g364fb.o
-common-obj-$(CONFIG_JAZZ_LED) +=3D jazz_led.o
-common-obj-$(CONFIG_PL110) +=3D pl110.o
-common-obj-$(CONFIG_SII9022) +=3D sii9022.o
-common-obj-$(CONFIG_SSD0303) +=3D ssd0303.o
-common-obj-$(CONFIG_SSD0323) +=3D ssd0323.o
-common-obj-$(CONFIG_XEN) +=3D xenfb.o
-
-common-obj-$(CONFIG_VGA_PCI) +=3D vga-pci.o
-common-obj-$(CONFIG_VGA_ISA) +=3D vga-isa.o
-common-obj-$(CONFIG_VGA_ISA_MM) +=3D vga-isa-mm.o
-common-obj-$(CONFIG_VMWARE_VGA) +=3D vmware_vga.o
-common-obj-$(CONFIG_BOCHS_DISPLAY) +=3D bochs-display.o
-
-common-obj-$(CONFIG_BLIZZARD) +=3D blizzard.o
-common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_fimd.o
-common-obj-$(CONFIG_FRAMEBUFFER) +=3D framebuffer.o
-obj-$(CONFIG_MILKYMIST) +=3D milkymist-vgafb.o
-common-obj-$(CONFIG_ZAURUS) +=3D tc6393xb.o
-
-obj-$(CONFIG_MILKYMIST_TMU2) +=3D milkymist-tmu2.o
-milkymist-tmu2.o-cflags :=3D $(X11_CFLAGS) $(OPENGL_CFLAGS)
-milkymist-tmu2.o-libs :=3D $(X11_LIBS) $(OPENGL_LIBS)
-
-common-obj-$(CONFIG_OMAP) +=3D omap_dss.o
-obj-$(CONFIG_OMAP) +=3D omap_lcdc.o
-common-obj-$(CONFIG_PXA2XX) +=3D pxa2xx_lcd.o
-common-obj-$(CONFIG_RASPI) +=3D bcm2835_fb.o
-common-obj-$(CONFIG_SM501) +=3D sm501.o
-common-obj-$(CONFIG_TCX) +=3D tcx.o
-common-obj-$(CONFIG_CG3) +=3D cg3.o
-
-obj-$(CONFIG_VGA) +=3D vga.o
-
-common-obj-$(CONFIG_QXL) +=3D qxl.o qxl-logger.o qxl-render.o
-
-obj-$(CONFIG_VIRTIO_GPU) +=3D virtio-gpu-base.o virtio-gpu.o virtio-gpu-3d=
.o
-obj-$(CONFIG_VHOST_USER_GPU) +=3D vhost-user-gpu.o
-obj-$(call land,$(CONFIG_VIRTIO_GPU),$(CONFIG_VIRTIO_PCI)) +=3D virtio-gpu=
-pci.o
-obj-$(call land,$(CONFIG_VHOST_USER_GPU),$(CONFIG_VIRTIO_PCI)) +=3D vhost-=
user-gpu-pci.o
-obj-$(CONFIG_VIRTIO_VGA) +=3D virtio-vga.o
-obj-$(CONFIG_VHOST_USER_VGA) +=3D vhost-user-vga.o
-virtio-gpu.o-cflags :=3D $(VIRGL_CFLAGS)
-virtio-gpu.o-libs +=3D $(VIRGL_LIBS)
-virtio-gpu-3d.o-cflags :=3D $(VIRGL_CFLAGS)
-virtio-gpu-3d.o-libs +=3D $(VIRGL_LIBS)
-common-obj-$(CONFIG_DPCD) +=3D dpcd.o
-common-obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=3D xlnx_dp.o
-
-common-obj-$(CONFIG_ATI_VGA) +=3D ati.o ati_2d.o ati_dbg.o
diff --git a/hw/display/meson.build b/hw/display/meson.build
new file mode 100644
index 0000000..248510a
--- /dev/null
+++ b/hw/display/meson.build
@@ -0,0 +1,54 @@
+softmmu_ss.add(when: 'CONFIG_DDC', if_true: files('i2c-ddc.c'))
+softmmu_ss.add(when: 'CONFIG_EDID', if_true: files('edid-generate.c', 'edi=
d-region.c'))
+
+softmmu_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('ramfb.c'))
+softmmu_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('ramfb-standalone=
.c'))
+
+softmmu_ss.add(when: 'CONFIG_ADS7846', if_true: files('ads7846.c'))
+softmmu_ss.add(when: 'CONFIG_VGA_CIRRUS', if_true: files('cirrus_vga.c'))
+softmmu_ss.add(when: ['CONFIG_VGA_CIRRUS', 'CONFIG_VGA_ISA'], if_true: fil=
es('cirrus_vga_isa.c'))
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
+softmmu_ss.add(when: 'CONFIG_BOCHS_DISPLAY', if_true: files('bochs-display=
.c'))
+
+softmmu_ss.add(when: 'CONFIG_BLIZZARD', if_true: files('blizzard.c'))
+softmmu_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_fimd.c')=
)
+softmmu_ss.add(when: 'CONFIG_FRAMEBUFFER', if_true: files('framebuffer.c')=
)
+specific_ss.add(when: 'CONFIG_MILKYMIST', if_true: files('milkymist-vgafb.=
c'))
+softmmu_ss.add(when: 'CONFIG_ZAURUS', if_true: files('tc6393xb.c'))
+
+specific_ss.add(when: [x11, opengl, 'CONFIG_MILKYMIST_TMU2'], if_true: fil=
es('milkymist-tmu2.c'))
+
+softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_dss.c'))
+specific_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_lcdc.c'))
+softmmu_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx_lcd.c'))
+softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_fb.c'))
+softmmu_ss.add(when: 'CONFIG_SM501', if_true: files('sm501.c'))
+softmmu_ss.add(when: 'CONFIG_TCX', if_true: files('tcx.c'))
+softmmu_ss.add(when: 'CONFIG_CG3', if_true: files('cg3.c'))
+
+specific_ss.add(when: 'CONFIG_VGA', if_true: files('vga.c'))
+
+softmmu_ss.add(when: 'CONFIG_QXL', if_true: files('qxl.c', 'qxl-logger.c',=
 'qxl-render.c'))
+
+specific_ss.add(when: [pixman, 'CONFIG_VIRTIO_GPU'], if_true: [files('virt=
io-gpu-base.c', 'virtio-gpu.c', 'virtio-gpu-3d.c'), virgl])
+specific_ss.add(when: [pixman, 'CONFIG_VHOST_USER_GPU'], if_true: files('v=
host-user-gpu.c'))
+specific_ss.add(when: ['CONFIG_VIRTIO_GPU', 'CONFIG_VIRTIO_PCI'], if_true:=
 files('virtio-gpu-pci.c'))
+specific_ss.add(when: ['CONFIG_VHOST_USER_GPU', 'CONFIG_VIRTIO_PCI'], if_t=
rue: files('vhost-user-gpu-pci.c'))
+specific_ss.add(when: 'CONFIG_VIRTIO_VGA', if_true: files('virtio-vga.c'))
+specific_ss.add(when: 'CONFIG_VHOST_USER_VGA', if_true: files('vhost-user-=
vga.c'))
+
+softmmu_ss.add(when: 'CONFIG_DPCD', if_true: files('dpcd.c'))
+softmmu_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx_dp.c')=
)
+
+softmmu_ss.add(when: [pixman, 'CONFIG_ATI_VGA'], if_true: files('ati.c', '=
ati_2d.c', 'ati_dbg.c'))
diff --git a/hw/meson.build b/hw/meson.build
index 3263f33..3f40df2 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('display')
 subdir('dma')
 subdir('gpio')
 subdir('hyperv')
--=20
1.8.3.1



