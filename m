Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2DCC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:57:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38BA220656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+XNJENs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38BA220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k94k0-0002q9-FD
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94Dw-0002RY-FT
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39565)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94Dr-0001fg-Sw
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XdOea1RoH5d4nhhixD494WEpFCwDWcplIBSQ3ZM7CFI=;
 b=T+XNJENsHs6HUS1nQAk3ChGTbzZNe9vlA+JV1ScrGGX+7Bjv8Xj4kLX5c1l96oCJ5DHrpe
 QCmyTGXECJYiMCAPzn+a+YuLf1l2GjP1rFv0coADKbViFw3Nzg+4yfw5OEgtZNSwwVTuw8
 hp2qXlXQz+MA3jEIoJ21TiKHyd9GIhI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-T3gzzReHM92DC29jhr8W6A-1; Fri, 21 Aug 2020 06:24:33 -0400
X-MC-Unique: T3gzzReHM92DC29jhr8W6A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78946191E2A2
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:24:32 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 292325C1D0;
 Fri, 21 Aug 2020 10:24:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v8 073/152] meson: convert root directory to Meson
Date: Fri, 21 Aug 2020 06:22:10 -0400
Message-Id: <20200821102329.29777-74-pbonzini@redhat.com>
In-Reply-To: <20200821102329.29777-1-pbonzini@redhat.com>
References: <20200821102329.29777-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:26:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
 Makefile.objs   | 21 ++-------------------
 Makefile.target |  2 +-
 configure       |  2 ++
 meson.build     | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 72e935023d..ec15ebc4b4 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -48,16 +48,9 @@ storage-daemon-obj-$(CONFIG_POSIX) += os-posix.o
 # single QEMU executable should support all CPUs and machines.
 
 ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-y = blockdev.o blockdev-nbd.o
-common-obj-y += bootdevice.o iothread.o
-common-obj-y += dump/
-common-obj-y += job-qmp.o
+common-obj-y = dump/
 common-obj-y += monitor/
 common-obj-y += net/
-common-obj-y += qdev-monitor.o
-common-obj-$(CONFIG_WIN32) += os-win32.o
-common-obj-$(CONFIG_POSIX) += os-posix.o
-
 common-obj-$(CONFIG_LINUX) += fsdev/
 
 common-obj-y += accel/
@@ -87,25 +80,15 @@ common-obj-y += hw/
 common-obj-m += hw/
 
 common-obj-y += replay/
-
-common-obj-y += dma-helpers.o
-common-obj-$(CONFIG_TPM) += tpm.o
-
 common-obj-y += backends/
 
-common-obj-$(CONFIG_SECCOMP) += qemu-seccomp.o
-qemu-seccomp.o-cflags := $(SECCOMP_CFLAGS)
-qemu-seccomp.o-libs := $(SECCOMP_LIBS)
-
-common-obj-$(CONFIG_FDT) += device_tree.o
-
 common-obj-y += qapi/
 
 endif # CONFIG_SOFTMMU
 
 #######################################################################
 # Target-independent parts used in system and user emulation
-common-obj-y += cpus-common.o
+
 common-obj-y += hw/
 common-obj-y += qom/
 common-obj-y += disas/
diff --git a/Makefile.target b/Makefile.target
index 16f1e781e9..5f926e5bfa 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -169,7 +169,7 @@ ifneq ($(CONFIG_MODULES),y)
 LIBS := $(LIBS) $(ALSA_LIBS) $(OSS_LIBS) $(PULSE_LIBS) $(SDL_LIBS)
 LIBS := $(LIBS) $(GTK_LIBS) $(VTE_LIBS) $(X11_LIBS) $(CURSES_LIBS) $(ICONV_LIBS) $(GIO_LIBS)
 endif
-LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS) $(OPENGL_LIBS)
+LIBS := $(LIBS) $(BRLAPI_LIBS) $(SDL_LIBS) $(SPICE_LIBS) $(OPENGL_LIBS) $(SECCOMP_LIBS)
 LIBS := $(LIBS) $(COREAUDIO_LIBS) $(DSOUND_LIBS)
 
 # Hardware support
diff --git a/configure b/configure
index 98252ca38a..a90dfc964b 100755
--- a/configure
+++ b/configure
@@ -7376,6 +7376,8 @@ if test "$preadv" = "yes" ; then
 fi
 if test "$fdt" != "no" ; then
   echo "CONFIG_FDT=y" >> $config_host_mak
+  echo "FDT_CFLAGS=$fdt_cflags" >> $config_host_mak
+  echo "FDT_LIBS=$fdt_ldflags $fdt_libs" >> $config_host_mak
 fi
 if test "$membarrier" = "yes" ; then
   echo "CONFIG_MEMBARRIER=y" >> $config_host_mak
diff --git a/meson.build b/meson.build
index ca1e6906b7..ff200900ed 100644
--- a/meson.build
+++ b/meson.build
@@ -51,6 +51,7 @@ targetos = host_machine.system()
 
 m = cc.find_library('m', required: false)
 util = cc.find_library('util', required: false)
+winmm = []
 socket = []
 version_res = []
 coref = []
@@ -59,6 +60,7 @@ cocoa = []
 hvf = []
 if targetos == 'windows'
   socket = cc.find_library('ws2_32')
+  winmm = cc.find_library('winmm')
 
   win = import('windows')
   version_res = win.compile_resources('version.rc',
@@ -293,6 +295,11 @@ if 'CONFIG_VNC_SASL' in config_host
   sasl = declare_dependency(compile_args: config_host['SASL_CFLAGS'].split(),
                             link_args: config_host['SASL_LIBS'].split())
 endif
+fdt = not_found
+if 'CONFIG_FDT' in config_host
+  fdt = declare_dependency(compile_args: config_host['FDT_CFLAGS'].split(),
+                           link_args: config_host['FDT_LIBS'].split())
+endif
 
 create_config = find_program('scripts/create_config')
 minikconf = find_program('scripts/minikconf.py')
@@ -459,6 +466,7 @@ util_ss = ss.source_set()
 stub_ss = ss.source_set()
 trace_ss = ss.source_set()
 block_ss = ss.source_set()
+blockdev_ss = ss.source_set()
 common_ss = ss.source_set()
 softmmu_ss = ss.source_set()
 user_ss = ss.source_set()
@@ -612,6 +620,31 @@ subdir('nbd')
 subdir('scsi')
 subdir('block')
 
+blockdev_ss.add(files(
+  'blockdev.c',
+  'blockdev-nbd.c',
+  'iothread.c',
+  'job-qmp.c',
+))
+
+# os-posix.c contains POSIX-specific functions used by qemu-storage-daemon,
+# os-win32.c does not
+blockdev_ss.add(when: 'CONFIG_POSIX', if_true: files('os-posix.c'))
+softmmu_ss.add(when: 'CONFIG_WIN32', if_true: [files('os-win32.c')])
+
+softmmu_ss.add_all(blockdev_ss)
+softmmu_ss.add(files(
+  'bootdevice.c',
+  'dma-helpers.c',
+  'qdev-monitor.c',
+), sdl)
+
+softmmu_ss.add(when: 'CONFIG_TPM', if_true: files('tpm.c'))
+softmmu_ss.add(when: 'CONFIG_SECCOMP', if_true: [files('qemu-seccomp.c'), seccomp])
+softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
+
+common_ss.add(files('cpus-common.c'))
+
 # needed for fuzzing binaries
 subdir('tests/qtest/libqos')
 
-- 
2.26.2



