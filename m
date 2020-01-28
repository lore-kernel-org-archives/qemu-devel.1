Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C77FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D19172173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0pZXWFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19172173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVxG-0002zG-0Z
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:51:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6K-0001b4-9Y
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6I-0004iL-Ue
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:36 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:46939)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV6I-0004fQ-Ne
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:34 -0500
Received: by mail-wr1-x432.google.com with SMTP id z7so17066804wrl.13
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eP2TeH3k4aghmGxxgRo9140T1AoNaykBBCsOV4MtnLA=;
 b=f0pZXWFnppHhh16/xBuYKmOEDJ9gzUf1qxegkpmFGqYKn/JpAI1f/qCThXW6Rffo/R
 SRAx+mmahW+rY2EeCBJW1bbNhMY1l9NVHoOIasNIVi4ylEpXs9E/la+dAkK9sM0xE34r
 qpITC/ASUfoRhloJQ8RIOLCJyrStJitc6AhWhhbC6id0Y9Hl3/c5qwJLKdfsivbiDDwu
 4BDl27Vb6rQsVrS2JAbzHWL3KLSo/mJSkUEd9yjy41BUGBvdYEryjBq16OI8YRjbHIAd
 IRr+ZUZEnrmMXSHQsq9IffqwObUTpKi15g3or5bl2/etFCiC3W3VwAdPysJt5QYWxQ9T
 4KFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=eP2TeH3k4aghmGxxgRo9140T1AoNaykBBCsOV4MtnLA=;
 b=BZhC5Pdhs9KJ3L73aTZ4QZde0TJdvpz8V1edJ1t7vXSHPFN/ZlnoWt0Y6uOgkN7DhN
 /ja72DmpuegIXGyTuxngk93oHd1dY4y+jQqEqcps/3Flkw9HwllNCotDXchVPAhw4buG
 5dBSYDSjzN03fGUdZKzKKeocq/EsTnv9AS0Or4SHnBjCNoxdGVqOmtz2JuLV+Sgpp2af
 9m8g6wZKiexgQ40q0bALodfFooaX//qmIyN9izav6PsLFNsZJDnQDPV14NO+ANZh9qgm
 LEK1gXEuEXL9ym0/jealduQPg3I2+K5pXDRtinEimJV/Wx0YF0ppe8GjqlCVH8e6wOQn
 ZRkg==
X-Gm-Message-State: APjAAAW1vllAFIJmqR/EWYw3yRiYjomU5Wxnrfo865w0vxiUJEpPrqaT
 Vg/ewOH5RMn9Na2yw/vhNpqTAKCg
X-Google-Smtp-Source: APXvYqx14u/RepPQU3rPJiK630UeBt4ureTNvhDewFLWMuS+5doj14DDydVUNTuudV/jm6gb2dVQtQ==
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr28089244wrn.50.1580234193220; 
 Tue, 28 Jan 2020 09:56:33 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:56:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 069/142] meson: convert hw/xen
Date: Tue, 28 Jan 2020 18:52:29 +0100
Message-Id: <20200128175342.9066-70-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
 configure            |  4 ++++
 hw/Makefile.objs     |  1 -
 hw/meson.build       |  1 +
 hw/xen/Makefile.objs |  6 ------
 hw/xen/meson.build   | 18 ++++++++++++++++++
 meson.build          |  6 ++++++
 6 files changed, 29 insertions(+), 7 deletions(-)
 create mode 100644 hw/meson.build
 delete mode 100644 hw/xen/Makefile.objs
 create mode 100644 hw/xen/meson.build

diff --git a/configure b/configure
index cfc7a5352c..aa51bb783c 100755
--- a/configure
+++ b/configure
@@ -2494,6 +2494,8 @@ if test "$xen" != "no" ; then
     fi
     QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
     libs_softmmu="$($pkg_config --libs $xen_pc) $libs_softmmu"
+    xen_cflags="$($pkg_config --cflags $xen_pc)"
+    xen_libs="$($pkg_config --libs $xen_pc)"
   else
 
     xen_libs="-lxenstore -lxenctrl -lxenguest"
@@ -7014,6 +7016,8 @@ fi
 if test "$xen" = "yes" ; then
   echo "CONFIG_XEN_BACKEND=y" >> $config_host_mak
   echo "CONFIG_XEN_CTRL_INTERFACE_VERSION=$xen_ctrl_version" >> $config_host_mak
+  echo "XEN_CFLAGS=$xen_cflags" >> $config_host_mak
+  echo "XEN_LIBS=$xen_libs" >> $config_host_mak
 fi
 if test "$linux_aio" = "yes" ; then
   echo "CONFIG_LINUX_AIO=y" >> $config_host_mak
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 660e2b4373..f0ca15595a 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -35,7 +35,6 @@ devices-dirs-y += usb/
 devices-dirs-$(CONFIG_VFIO) += vfio/
 devices-dirs-y += virtio/
 devices-dirs-y += watchdog/
-devices-dirs-y += xen/
 devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
 devices-dirs-$(CONFIG_NUBUS) += nubus/
 devices-dirs-y += semihosting/
diff --git a/hw/meson.build b/hw/meson.build
new file mode 100644
index 0000000000..08112a5e4b
--- /dev/null
+++ b/hw/meson.build
@@ -0,0 +1 @@
+subdir('xen')
diff --git a/hw/xen/Makefile.objs b/hw/xen/Makefile.objs
deleted file mode 100644
index 84df60a928..0000000000
--- a/hw/xen/Makefile.objs
+++ /dev/null
@@ -1,6 +0,0 @@
-# xen backend driver support
-common-obj-$(CONFIG_XEN) += xen-legacy-backend.o xen_devconfig.o xen_pvdev.o xen-common.o xen-bus.o xen-bus-helper.o xen-backend.o
-
-obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen-host-pci-device.o
-obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt.o xen_pt_config_init.o xen_pt_graphics.o xen_pt_msi.o
-obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt_load_rom.o
diff --git a/hw/xen/meson.build b/hw/xen/meson.build
new file mode 100644
index 0000000000..e9587b61ce
--- /dev/null
+++ b/hw/xen/meson.build
@@ -0,0 +1,18 @@
+softmmu_ss.add(when: ['CONFIG_XEN', xen], if_true: files(
+  'xen-backend.c',
+  'xen-bus-helper.c',
+  'xen-bus.c',
+  'xen-common.c',
+  'xen-legacy-backend.c',
+  'xen_devconfig.c',
+  'xen_pvdev.c',
+))
+
+specific_ss.add(when: 'CONFIG_XEN_PCI_PASSTHROUGH', if_true: files(
+  'xen-host-pci-device.c',
+  'xen_pt.c',
+  'xen_pt_config_init.c',
+  'xen_pt_graphics.c',
+  'xen_pt_load_rom.c',
+  'xen_pt_msi.c',
+))
diff --git a/meson.build b/meson.build
index 701f079345..583c42ccf5 100644
--- a/meson.build
+++ b/meson.build
@@ -294,6 +294,11 @@ numa = declare_dependency()
 if 'CONFIG_NUMA' in config_host
   numa = declare_dependency(link_args: config_host['NUMA_LIBS'].split())
 endif
+xen = declare_dependency()
+if 'CONFIG_XEN_BACKEND' in config_host
+  xen = declare_dependency(compile_args: config_host['XEN_CFLAGS'].split(),
+                           link_args: config_host['XEN_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
@@ -628,6 +633,7 @@ subdir('migration')
 subdir('monitor')
 subdir('net')
 subdir('replay')
+subdir('hw')
 
 mods = []
 block_mods = []
-- 
2.21.0



