Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE23C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:42:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F7A207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzGjW5i7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F7A207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVoL-0004qm-Ox
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:42:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5n-0000ea-Ag
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV5l-0003GD-Tg
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:03 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:54798)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV5l-0003C1-0Z
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:01 -0500
Received: by mail-wm1-x329.google.com with SMTP id g1so3497778wmh.4
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GrqVC0GmtE8PjSTP9IWsy3LUJg30ftzj2nWQf9PlXxs=;
 b=GzGjW5i72xp9VnXtbz57ll1IFHcEvpQ+QVtOG6IGh+OD1u+5IGq9skZJh1Cqob+WBo
 XHcVMQHrb5zLoZCy/GbmxkEHlQKQdbKMnGJabxSPVnKHnFfAt8HnKwvLDRU5WAmULwAv
 onTTJp8O1ee+tphiEtl8tyQopOsaf56BD3GNOMlZ12d6s3tq6kq75eRxSNDusSlpX91k
 X8Uj3DOkpTDfBgfWgA28GqwrzlEYIPkPNKDStwK1H39QFHOiTVzqEXjAcpe4JMiQAszu
 ZkjfgZMlzLmLk00DSMklfh2pTvr3hCA1whCzX/OPzVaWcuJij/A3+KO0wkLOkX1igKbU
 5QlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=GrqVC0GmtE8PjSTP9IWsy3LUJg30ftzj2nWQf9PlXxs=;
 b=cuLQSWBczN38Ah2J6oXZwcSdGCUpcCqQ9QFyrH6QDkQvEZj9IajYjaDGjWiFI4/yJi
 0qX8GaFoKTtK2VHRwAj+8B0SA0dP9yDhVgGN4tcL0tpH8JzArq1xvY5xkQPYn5sevvq5
 +lIrXVgbgPINmhWsxuvsCxAckOglwTGApSh/X2o62gya5u14Kb4AFOJitD+vFa36TjUC
 M9pohUE42KnLOyw/yXdEgGlMM3dZNA6pBUebwZLIg5EjisxE1FX/cTD/38gqANpu5eTe
 fXtARvpbhRuKIGNwXNj8/A3NSflVJ5Uor5xSUQZr43piK8koYHZtruOUR3RhadEpHno/
 kOxA==
X-Gm-Message-State: APjAAAUZa0v3oEu5ZKPsSCdUw1M6PqOR9fLXEKqwVm29thYE1kX3NraM
 b3e9uKBvyZ4l/BD2l3B6AStY6/Hh
X-Google-Smtp-Source: APXvYqyuI6sHLJY4RhDNXtiHJfVR7sJ8Sjz7TngxScS3r4Ei4H0WZZTtHFTh36QcYbuV26YOww3Mhw==
X-Received: by 2002:a05:600c:230d:: with SMTP id
 13mr6616599wmo.12.1580234159019; 
 Tue, 28 Jan 2020 09:55:59 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:55:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 055/142] meson: convert root directory to Meson
Date: Tue, 28 Jan 2020 18:52:15 +0100
Message-Id: <20200128175342.9066-56-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
 Makefile.objs   | 25 ++-----------------------
 Makefile.target |  2 +-
 configure       |  2 ++
 meson.build     | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 5081994123..bdfb6410de 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -35,17 +35,10 @@ qom-obj-y = qom/libqom.fa
 # single QEMU executable should support all CPUs and machines.
 
 ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-y = blockdev.o blockdev-nbd.o block/
-
-common-obj-y += bootdevice.o iothread.o
+common-obj-y = block/
 common-obj-y += dump/
-common-obj-y += job-qmp.o
 common-obj-y += monitor/
 common-obj-y += net/
-common-obj-y += qdev-monitor.o device-hotplug.o
-common-obj-$(CONFIG_WIN32) += os-win32.o
-common-obj-$(CONFIG_POSIX) += os-posix.o
-
 common-obj-$(CONFIG_LINUX) += fsdev/
 
 common-obj-y += accel/
@@ -72,27 +65,13 @@ common-obj-$(if $(CONFIG_LZFSE),m) += block-dmg-lzfse$(DSOSUF)
 common-obj-$(if $(and $(CONFIG_BZIP2),$(CONFIG_DMG)),m) += block-dmg-bz2$(DSOSUF)
 
 common-obj-y += hw/
-
 common-obj-y += replay/
-
-common-obj-y += dma-helpers.o
-common-obj-y += vl.o
-vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS)
-common-obj-$(CONFIG_TPM) += tpm.o
-
 common-obj-y += backends/
-
-common-obj-$(CONFIG_SECCOMP) += qemu-seccomp.o
-qemu-seccomp.o-cflags := $(SECCOMP_CFLAGS)
-qemu-seccomp.o-libs := $(SECCOMP_LIBS)
-
-common-obj-$(CONFIG_FDT) += device_tree.o
-
 endif
 
 #######################################################################
 # Target-independent parts used in system and user emulation
-common-obj-y += cpus-common.o
+
 common-obj-y += hw/
 common-obj-y += qom/
 common-obj-y += disas/
diff --git a/Makefile.target b/Makefile.target
index ae4e494ec6..638e550530 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -170,7 +170,7 @@ ifneq ($(CONFIG_MODULES),y)
 LIBS := $(LIBS) $(ALSA_LIBS) $(OSS_LIBS) $(PULSE_LIBS) $(SDL_LIBS)
 LIBS := $(LIBS) $(GTK_LIBS) $(VTE_LIBS) $(X11_LIBS) $(CURSES_LIBS) $(ICONV_LIBS) $(GIO_LIBS)
 endif
-LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS) $(OPENGL_LIBS)
+LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS) $(OPENGL_LIBS) $(SECCOMP_LIBS)
 LIBS := $(LIBS) $(COREAUDIO_LIBS) $(DSOUND_LIBS)
 
 # Hardware support
diff --git a/configure b/configure
index 80a7c0f069..1af0a73e39 100755
--- a/configure
+++ b/configure
@@ -7066,6 +7066,8 @@ if test "$preadv" = "yes" ; then
 fi
 if test "$fdt" != "no" ; then
   echo "CONFIG_FDT=y" >> $config_host_mak
+  echo "FDT_CFLAGS=$fdt_cflags" >> $config_host_mak
+  echo "FDT_LIBS=$fdt_ldflags $fdt_libs" >> $config_host_mak
 fi
 if test "$membarrier" = "yes" ; then
   echo "CONFIG_MEMBARRIER=y" >> $config_host_mak
diff --git a/meson.build b/meson.build
index 6fb86e4bd3..cac9c894f4 100644
--- a/meson.build
+++ b/meson.build
@@ -37,6 +37,7 @@ configure_file(input: files('scripts/ninjatool.py'),
 
 m = cc.find_library('m', required: false)
 util = cc.find_library('util', required: false)
+winmm = []
 socket = []
 version_res = []
 coref = []
@@ -45,6 +46,7 @@ cocoa = []
 hvf = []
 if host_machine.system() == 'windows'
   socket = cc.find_library('ws2_32')
+  winmm = cc.find_library('winmm')
 
   win = import('windows')
   version_res = win.compile_resources('version.rc',
@@ -252,6 +254,16 @@ if 'CONFIG_VNC_SASL' in config_host
   sasl = declare_dependency(compile_args: config_host['SASL_CFLAGS'].split(),
                             link_args: config_host['SASL_LIBS'].split())
 endif
+seccomp = declare_dependency()
+if 'CONFIG_SECCOMP' in config_host
+  seccomp = declare_dependency(compile_args: config_host['SECCOMP_CFLAGS'].split(),
+                               link_args: config_host['SECCOMP_LIBS'].split())
+endif
+fdt = declare_dependency()
+if 'CONFIG_FDT' in config_host
+  fdt = declare_dependency(compile_args: config_host['FDT_CFLAGS'].split(),
+                           link_args: config_host['FDT_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
@@ -559,6 +571,26 @@ subdir('nbd')
 subdir('scsi')
 subdir('block')
 
+softmmu_ss.add(files(
+  'blockdev-nbd.c',
+  'blockdev.c',
+  'bootdevice.c',
+  'device-hotplug.c',
+  'dma-helpers.c',
+  'iothread.c',
+  'job-qmp.c',
+  'qdev-monitor.c',
+  'vl.c',
+), sdl)
+
+softmmu_ss.add(when: 'CONFIG_WIN32', if_true: [files('os-win32.c'), winmm])
+softmmu_ss.add(when: 'CONFIG_POSIX', if_true: files('os-posix.c'))
+softmmu_ss.add(when: 'CONFIG_TPM', if_true: files('tpm.c'))
+softmmu_ss.add(when: 'CONFIG_SECCOMP', if_true: [files('qemu-seccomp.c'), seccomp])
+softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
+
+common_ss.add(files('cpus-common.c'))
+
 mods = []
 block_mods = []
 softmmu_mods = []
-- 
2.21.0



