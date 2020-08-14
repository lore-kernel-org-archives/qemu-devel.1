Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A1DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:50:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 116ED206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqlH75rL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116ED206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6WLy-0006KH-8p
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 05:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VnP-00070k-5c
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26026
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VnM-000353-53
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vRBGX59Qf2gJ3eqsuHM2ijqt1DxEbOxspSGyqeH4U7M=;
 b=WqlH75rLcVxLIRFzjAC9ls6vT+WsYoE6fk/qyDjowWYUycTeQHQG/Yy0iCaW412qHeAPHw
 Wq7XhNc36Hy7XZ3+8E6NnP3z0MuT6Gg3Ou2AnXmDsYnSrpQMGqkm7jInX/Ej7U2rQbyJna
 YLMrbSB/ev/eeZWulebSr4nZ75LMW/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-rFHBGMDwMY-e4XZ_wcfyGQ-1; Fri, 14 Aug 2020 05:14:35 -0400
X-MC-Unique: rFHBGMDwMY-e4XZ_wcfyGQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84C738015C5
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:14:34 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43AF4600E4;
 Fri, 14 Aug 2020 09:14:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 094/150] meson: convert hw/usb
Date: Fri, 14 Aug 2020 05:12:30 -0400
Message-Id: <20200814091326.16173-95-pbonzini@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 05:13:35
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.target      |  1 +
 hw/Makefile.objs     |  1 -
 hw/meson.build       |  1 +
 hw/usb/Makefile.objs | 71 --------------------------------------------
 hw/usb/meson.build   | 69 ++++++++++++++++++++++++++++++++++++++++++
 meson.build          | 15 ++++++++++
 6 files changed, 86 insertions(+), 72 deletions(-)
 delete mode 100644 hw/usb/Makefile.objs
 create mode 100644 hw/usb/meson.build

diff --git a/Makefile.target b/Makefile.target
index 386378b9c8..3d5a2af4af 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -168,6 +168,7 @@ endif
 LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS) $(OPENGL_LIBS) $(SECCOMP_LIBS)
 LIBS := $(LIBS) $(COREAUDIO_LIBS) $(DSOUND_LIBS)
 LIBS := $(LIBS) $(VDE_LIBS) $(SLIRP_LIBS)
+LIBS := $(LIBS) $(LIBUSB_LIBS) $(SMARTCARD_LIBS) $(USB_REDIR_LIBS)
 
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index f6e08f6660..c2619bbb50 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -30,7 +30,6 @@ devices-dirs-y += sd/
 devices-dirs-y += ssi/
 devices-dirs-y += timer/
 devices-dirs-$(CONFIG_TPM) += tpm/
-devices-dirs-y += usb/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 4dafc8a08e..89bd6adb70 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -3,6 +3,7 @@ subdir('mem')
 subdir('nubus')
 subdir('semihosting')
 subdir('smbios')
+subdir('usb')
 subdir('vfio')
 subdir('virtio')
 subdir('watchdog')
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
deleted file mode 100644
index e342ff59fa..0000000000
--- a/hw/usb/Makefile.objs
+++ /dev/null
@@ -1,71 +0,0 @@
-# usb subsystem core
-common-obj-y += core.o combined-packet.o bus.o libhw.o
-common-obj-$(CONFIG_USB) += desc.o desc-msos.o
-
-# usb host adapters
-common-obj-$(CONFIG_USB_UHCI) += hcd-uhci.o
-common-obj-$(CONFIG_USB_OHCI) += hcd-ohci.o
-common-obj-$(CONFIG_USB_OHCI_PCI) += hcd-ohci-pci.o
-common-obj-$(CONFIG_USB_EHCI) += hcd-ehci.o
-common-obj-$(CONFIG_USB_EHCI_PCI) += hcd-ehci-pci.o
-common-obj-$(CONFIG_USB_EHCI_SYSBUS) += hcd-ehci-sysbus.o
-common-obj-$(CONFIG_USB_XHCI) += hcd-xhci.o
-common-obj-$(CONFIG_USB_XHCI_NEC) += hcd-xhci-nec.o
-common-obj-$(CONFIG_USB_MUSB) += hcd-musb.o
-common-obj-$(CONFIG_USB_DWC2) += hcd-dwc2.o
-
-common-obj-$(CONFIG_TUSB6010) += tusb6010.o
-common-obj-$(CONFIG_IMX)      += chipidea.o
-
-# emulated usb devices
-common-obj-$(CONFIG_USB) += dev-hub.o
-common-obj-$(CONFIG_USB) += dev-hid.o
-common-obj-$(CONFIG_USB_TABLET_WACOM) += dev-wacom.o
-common-obj-$(CONFIG_USB_STORAGE_BOT)  += dev-storage.o
-common-obj-$(CONFIG_USB_STORAGE_UAS)  += dev-uas.o
-common-obj-$(CONFIG_USB_AUDIO)        += dev-audio.o
-common-obj-$(CONFIG_USB_SERIAL)       += dev-serial.o
-common-obj-$(CONFIG_USB_NETWORK)      += dev-network.o
-
-ifeq ($(CONFIG_USB_SMARTCARD),y)
-common-obj-y                          += dev-smartcard-reader.o
-ifeq ($(CONFIG_SMARTCARD),y)
-common-obj-m                          += smartcard.mo
-smartcard.mo-objs := ccid-card-passthru.o ccid-card-emulated.o
-smartcard.mo-cflags := $(SMARTCARD_CFLAGS)
-smartcard.mo-libs := $(SMARTCARD_LIBS)
-endif
-endif
-
-ifeq ($(CONFIG_POSIX),y)
-common-obj-$(CONFIG_USB_STORAGE_MTP)  += dev-mtp.o
-endif
-
-# usb redirection
-ifeq ($(CONFIG_USB),y)
-ifeq ($(CONFIG_USB_REDIR),y)
-common-obj-m += redirect.mo
-redirect.mo-objs = redirect.o quirks.o
-redirect.mo-cflags = $(USB_REDIR_CFLAGS)
-redirect.mo-libs = $(USB_REDIR_LIBS)
-endif
-endif
-
-# usb pass-through
-ifeq ($(CONFIG_USB_LIBUSB)$(CONFIG_USB),yy)
-common-obj-y += host-libusb.o
-else
-common-obj-y += host-stub.o
-endif
-common-obj-$(CONFIG_ALL) += host-stub.o
-
-host-libusb.o-cflags := $(LIBUSB_CFLAGS)
-host-libusb.o-libs := $(LIBUSB_LIBS)
-
-ifeq ($(CONFIG_USB_LIBUSB),y)
-common-obj-$(CONFIG_XEN) += xen-usb.o
-xen-usb.o-cflags := $(LIBUSB_CFLAGS)
-xen-usb.o-libs := $(LIBUSB_LIBS)
-endif
-
-common-obj-$(CONFIG_IMX_USBPHY) += imx-usb-phy.o
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
new file mode 100644
index 0000000000..f40d158ab5
--- /dev/null
+++ b/hw/usb/meson.build
@@ -0,0 +1,69 @@
+hw_usb_modules = []
+
+# usb subsystem core
+softmmu_ss.add(files(
+  'bus.c',
+  'combined-packet.c',
+  'core.c',
+  'libhw.c'
+))
+
+softmmu_ss.add(when: 'CONFIG_USB', if_true: files(
+  'desc.c',
+  'desc-msos.c',
+))
+
+# usb host adapters
+softmmu_ss.add(when: 'CONFIG_USB_UHCI', if_true: files('hcd-uhci.c'))
+softmmu_ss.add(when: 'CONFIG_USB_OHCI', if_true: files('hcd-ohci.c'))
+softmmu_ss.add(when: 'CONFIG_USB_OHCI_PCI', if_true: files('hcd-ohci-pci.c'))
+softmmu_ss.add(when: 'CONFIG_USB_EHCI', if_true: files('hcd-ehci.c'))
+softmmu_ss.add(when: 'CONFIG_USB_EHCI_PCI', if_true: files('hcd-ehci-pci.c'))
+softmmu_ss.add(when: 'CONFIG_USB_EHCI_SYSBUS', if_true: files('hcd-ehci.c', 'hcd-ehci-sysbus.c'))
+softmmu_ss.add(when: 'CONFIG_USB_XHCI', if_true: files('hcd-xhci.c'))
+softmmu_ss.add(when: 'CONFIG_USB_XHCI_NEC', if_true: files('hcd-xhci-nec.c'))
+softmmu_ss.add(when: 'CONFIG_USB_MUSB', if_true: files('hcd-musb.c'))
+softmmu_ss.add(when: 'CONFIG_USB_DWC2', if_true: files('hcd-dwc2.c'))
+
+softmmu_ss.add(when: 'CONFIG_TUSB6010', if_true: files('tusb6010.c'))
+softmmu_ss.add(when: 'CONFIG_IMX', if_true: files('chipidea.c'))
+softmmu_ss.add(when: 'CONFIG_IMX_USBPHY', if_true: files('imx-usb-phy.c'))
+
+# emulated usb devices
+softmmu_ss.add(when: 'CONFIG_USB', if_true: files('dev-hub.c'))
+softmmu_ss.add(when: 'CONFIG_USB', if_true: files('dev-hid.c'))
+softmmu_ss.add(when: 'CONFIG_USB_TABLET_WACOM', if_true: files('dev-wacom.c'))
+softmmu_ss.add(when: 'CONFIG_USB_STORAGE_BOT', if_true: files('dev-storage.c'))
+softmmu_ss.add(when: 'CONFIG_USB_STORAGE_UAS', if_true: files('dev-uas.c'))
+softmmu_ss.add(when: 'CONFIG_USB_AUDIO', if_true: files('dev-audio.c'))
+softmmu_ss.add(when: 'CONFIG_USB_SERIAL', if_true: files('dev-serial.c'))
+softmmu_ss.add(when: 'CONFIG_USB_NETWORK', if_true: files('dev-network.c'))
+softmmu_ss.add(when: ['CONFIG_POSIX', 'CONFIG_USB_STORAGE_MTP'], if_true: files('dev-mtp.c'))
+
+# smartcard
+softmmu_ss.add(when: 'CONFIG_USB_SMARTCARD', if_true: files('dev-smartcard-reader.c'))
+
+if config_host.has_key('CONFIG_SMARTCARD')
+  hw_usb_modules += [['smartcard', files(
+      'ccid-card-emulated.c',
+      'ccid-card-passthru.c',
+    ), [cacard], ['CONFIG_USB_SMARTCARD']]]
+endif
+
+# usb redirect
+if config_host.has_key('CONFIG_USB_REDIR')
+  hw_usb_modules += [['redirect', files(
+      'redirect.c',
+      'quirks.c',
+    ), [usbredir], ['CONFIG_USB']]]
+endif
+
+# usb pass-through
+softmmu_ss.add(when: ['CONFIG_USB', 'CONFIG_USB_LIBUSB', libusb],
+               if_true: files('host-libusb.c'),
+               if_false: files('host-stub.c'))
+softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('host-stub.c'))
+
+softmmu_ss.add(when: ['CONFIG_USB', 'CONFIG_XEN', libusb], if_true: files('xen-usb.c'))
+
+modules += { 'hw-usb': hw_usb_modules }
diff --git a/meson.build b/meson.build
index b4e54a6aca..0366703e0c 100644
--- a/meson.build
+++ b/meson.build
@@ -326,6 +326,21 @@ if 'CONFIG_XEN_BACKEND' in config_host
   xen = declare_dependency(compile_args: config_host['XEN_CFLAGS'].split(),
                            link_args: config_host['XEN_LIBS'].split())
 endif
+cacard = not_found
+if 'CONFIG_SMARTCARD' in config_host
+  cacard = declare_dependency(compile_args: config_host['SMARTCARD_CFLAGS'].split(),
+                              link_args: config_host['SMARTCARD_LIBS'].split())
+endif
+usbredir = not_found
+if 'CONFIG_USB_REDIR' in config_host
+  usbredir = declare_dependency(compile_args: config_host['USB_REDIR_CFLAGS'].split(),
+                                link_args: config_host['USB_REDIR_LIBS'].split())
+endif
+libusb = not_found
+if 'CONFIG_USB_LIBUSB' in config_host
+  libusb = declare_dependency(compile_args: config_host['LIBUSB_CFLAGS'].split(),
+                              link_args: config_host['LIBUSB_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
-- 
2.26.2



