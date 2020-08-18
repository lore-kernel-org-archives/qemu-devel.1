Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39365C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E29D4207DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XIjp6W+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E29D4207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k82pd-0007XM-2q
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 10:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82L4-0004fX-NW
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:11:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39514
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82Kt-0007TX-RA
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597759895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTteD+GbqUi9VD6KqSYTcdsBgwUyjUGQUoBhhyZvZDU=;
 b=XIjp6W+DGOyqsiBY8nOqySwto+2L6bV55m5vCmL5VzoSBYrMAlOa8yjOG9kIY2wmgsUgu1
 O//aFfP4a4v8L6FvY+6Oq7+zSmN/7nlzS3rl+ILE8zWeqYJl7EPMeSTrqBi4HTwKNy9WLD
 XsqfiZI5ek9geie2UZrc119s6PHYarY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-19GN5w0COB631Sg9HUcZnA-1; Tue, 18 Aug 2020 10:11:33 -0400
X-MC-Unique: 19GN5w0COB631Sg9HUcZnA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45A7F100746A
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:11:32 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00D7C5D757;
 Tue, 18 Aug 2020 14:11:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 072/150] meson: convert root directory to Meson
Date: Tue, 18 Aug 2020 10:09:07 -0400
Message-Id: <20200818141025.21608-73-pbonzini@redhat.com>
In-Reply-To: <20200818141025.21608-1-pbonzini@redhat.com>
References: <20200818141025.21608-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:16:14
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
index 198e876e02..a4396d7027 100755
--- a/configure
+++ b/configure
@@ -7331,6 +7331,8 @@ if test "$preadv" = "yes" ; then
 fi
 if test "$fdt" != "no" ; then
   echo "CONFIG_FDT=y" >> $config_host_mak
+  echo "FDT_CFLAGS=$fdt_cflags" >> $config_host_mak
+  echo "FDT_LIBS=$fdt_ldflags $fdt_libs" >> $config_host_mak
 fi
 if test "$membarrier" = "yes" ; then
   echo "CONFIG_MEMBARRIER=y" >> $config_host_mak
diff --git a/meson.build b/meson.build
index a39c87a2ff..4e2f7759e4 100644
--- a/meson.build
+++ b/meson.build
@@ -48,6 +48,7 @@ targetos = host_machine.system()
 
 m = cc.find_library('m', required: false)
 util = cc.find_library('util', required: false)
+winmm = []
 socket = []
 version_res = []
 coref = []
@@ -56,6 +57,7 @@ cocoa = []
 hvf = []
 if targetos == 'windows'
   socket = cc.find_library('ws2_32')
+  winmm = cc.find_library('winmm')
 
   win = import('windows')
   version_res = win.compile_resources('version.rc',
@@ -290,6 +292,11 @@ if 'CONFIG_VNC_SASL' in config_host
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
@@ -456,6 +463,7 @@ util_ss = ss.source_set()
 stub_ss = ss.source_set()
 trace_ss = ss.source_set()
 block_ss = ss.source_set()
+blockdev_ss = ss.source_set()
 common_ss = ss.source_set()
 softmmu_ss = ss.source_set()
 user_ss = ss.source_set()
@@ -609,6 +617,31 @@ subdir('nbd')
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



