Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2499C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:42:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40DD207DA
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bD4euwHo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40DD207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Bou-0006W6-Rp
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BKP-0000pZ-P0
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:11:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60138
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BKM-00038D-NI
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bOZeBdFKXxkfGBtUpffyRHoXer0+Gb7pIrYCNxlaYXQ=;
 b=bD4euwHoq7KcRzwxda1JbF9WHAxSiGbjdg4c0TUzxRy0QlksWwzR9J2ercHLRCSwLlOCiQ
 J0n/r8/ffkRemsNdwHSPwxI6FHOa3i3C0jw89/H6skWLLSIbB5zZnPl82GAkms0poeqB63
 Yq0r7uWkN+3/dPqnUorVqtK+S2nFMzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-8A0oRTWNM-yHhFOwBGPdXA-1; Mon, 10 Aug 2020 13:11:12 -0400
X-MC-Unique: 8A0oRTWNM-yHhFOwBGPdXA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 280B41005504
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:11:11 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30BF15F1E9;
 Mon, 10 Aug 2020 17:11:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 073/147] meson: convert common QMP bits for qemu and
 qemu-storage-daemon
Date: Mon, 10 Aug 2020 19:07:51 +0200
Message-Id: <1597079345-42801-74-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 04:13:00
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
 Makefile.objs         |  8 +++++---
 Makefile.target       |  1 -
 meson.build           | 10 ++++++++++
 monitor/Makefile.objs |  6 ------
 monitor/meson.build   |  9 +++++++++
 qom/Makefile.objs     |  2 --
 qom/meson.build       |  3 +++
 7 files changed, 27 insertions(+), 12 deletions(-)
 delete mode 100644 monitor/Makefile.objs
 create mode 100644 monitor/meson.build
 delete mode 100644 qom/Makefile.objs

diff --git a/Makefile.objs b/Makefile.objs
index 6657a6c..d7826c1 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -37,10 +37,11 @@ endif # CONFIG_SOFTMMU or CONFIG_TOOLS
 # storage-daemon-obj-y is code used by qemu-storage-daemon (these objects are
 # used for system emulation, too, but specified separately there)
 
-storage-daemon-obj-y = block/ monitor/ qapi/ qom/ storage-daemon/
+storage-daemon-obj-y = block/ qapi/ qom/ storage-daemon/
 storage-daemon-obj-y += blockdev.o blockdev-nbd.o iothread.o job-qmp.o
 storage-daemon-obj-$(CONFIG_WIN32) += os-win32.o
 storage-daemon-obj-$(CONFIG_POSIX) += os-posix.o
+storage-daemon-obj-y += libqmp.fa
 
 ######################################################################
 # Target independent part of system emulation. The long term path is to
@@ -48,8 +49,7 @@ storage-daemon-obj-$(CONFIG_POSIX) += os-posix.o
 # single QEMU executable should support all CPUs and machines.
 
 ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-y = monitor/
-common-obj-y += net/
+common-obj-y = net/
 common-obj-$(CONFIG_LINUX) += fsdev/
 
 common-obj-y += accel/
@@ -83,6 +83,8 @@ common-obj-y += backends/
 
 common-obj-y += qapi/
 
+common-obj-y += libqmp.fa
+
 endif # CONFIG_SOFTMMU
 
 #######################################################################
diff --git a/Makefile.target b/Makefile.target
index c8f7a6c..54a9ef1 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -157,7 +157,6 @@ ifdef CONFIG_SOFTMMU
 obj-y += softmmu/
 obj-y += gdbstub.o
 obj-y += hw/
-obj-y += monitor/
 obj-y += qapi/
 obj-y += migration/ram.o
 LIBS := $(libs_softmmu) $(LIBS)
diff --git a/meson.build b/meson.build
index dc14a80..a44a172 100644
--- a/meson.build
+++ b/meson.build
@@ -463,6 +463,7 @@ stub_ss = ss.source_set()
 trace_ss = ss.source_set()
 block_ss = ss.source_set()
 blockdev_ss = ss.source_set()
+qmp_ss = ss.source_set()
 common_ss = ss.source_set()
 softmmu_ss = ss.source_set()
 user_ss = ss.source_set()
@@ -643,6 +644,7 @@ softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
 common_ss.add(files('cpus-common.c'))
 
 subdir('softmmu')
+subdir('monitor')
 
 # needed for fuzzing binaries
 subdir('tests/qtest/libqos')
@@ -692,6 +694,14 @@ block = declare_dependency(link_whole: [libblock],
                            link_args: '@block.syms',
                            dependencies: [crypto, io])
 
+qmp_ss = qmp_ss.apply(config_host, strict: false)
+libqmp = static_library('qmp', qmp_ss.sources(),
+                        dependencies: qmp_ss.dependencies(),
+                        name_suffix: 'fa',
+                        build_by_default: false)
+
+qmp = declare_dependency(link_whole: [libqmp])
+
 foreach m : mods
   shared_module(m['dir'] + '-' + m['name'],
                 name_prefix: '',
diff --git a/monitor/Makefile.objs b/monitor/Makefile.objs
deleted file mode 100644
index a8533c9..0000000
--- a/monitor/Makefile.objs
+++ /dev/null
@@ -1,6 +0,0 @@
-obj-y += misc.o
-common-obj-y += monitor.o qmp.o hmp.o
-common-obj-y += qmp-cmds.o qmp-cmds-control.o
-common-obj-y += hmp-cmds.o
-
-storage-daemon-obj-y += monitor.o qmp.o qmp-cmds-control.o
diff --git a/monitor/meson.build b/monitor/meson.build
new file mode 100644
index 0000000..0484a64
--- /dev/null
+++ b/monitor/meson.build
@@ -0,0 +1,9 @@
+qmp_ss.add(files('monitor.c', 'qmp.c', 'qmp-cmds-control.c'))
+
+softmmu_ss.add(files(
+  'hmp-cmds.c',
+  'hmp.c',
+  'qmp-cmds.c',
+))
+
+specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files('misc.c'))
diff --git a/qom/Makefile.objs b/qom/Makefile.objs
deleted file mode 100644
index b962904..0000000
--- a/qom/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-common-obj-$(CONFIG_SOFTMMU) += qom-hmp-cmds.o qom-qmp-cmds.o
-storage-daemon-obj-y += qom-qmp-cmds.o
diff --git a/qom/meson.build b/qom/meson.build
index 4af044d..35815f6 100644
--- a/qom/meson.build
+++ b/qom/meson.build
@@ -7,6 +7,9 @@ qom_ss.add(files(
   'qom-qobject.c',
 ))
 
+qmp_ss.add(files('qom-qmp-cmds.c'))
+softmmu_ss.add(files('qom-hmp-cmds.c'))
+
 qom_ss = qom_ss.apply(config_host, strict: false)
 libqom = static_library('qom', qom_ss.sources(),
                         dependencies: [qom_ss.dependencies()],
-- 
1.8.3.1



