Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FA6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6592520885
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTYXxMos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6592520885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Bwj-0004y4-5K
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BKg-0001M9-UL
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:11:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21740
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BKd-0003A2-TK
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gpaefOQh5qevOM5HxbRK0gwyo6nToVWeTpSBc9OtOCg=;
 b=LTYXxMosfYCGHBw2iTTqazm2oDR7/zi4OiXgRW2fbkPIGh2Rw44XFFwj8OIT5fjpWmG28t
 J+EsqFsQyx0Mx2Alwz3yeqQdhinL9R3IR8vHBWigLILgYh8iDqFU/zFejCmTa2/R4eoRjL
 CVb+D2mhZXLO9WMnmqDxy24mFj5Vwnk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-96g9N_vGPb6DzZnClToXGA-1; Mon, 10 Aug 2020 13:11:28 -0400
X-MC-Unique: 96g9N_vGPb6DzZnClToXGA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A36FA100CCC0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:11:27 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B17B35F1EA;
 Mon, 10 Aug 2020 17:11:26 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 083/147] meson: convert hw/core
Date: Mon, 10 Aug 2020 19:08:01 +0200
Message-Id: <1597079345-42801-84-git-send-email-pbonzini@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 11:00:11
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
 hw/Makefile.objs       |  1 -
 hw/core/Makefile.objs  | 34 ----------------------------------
 hw/core/meson.build    | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 hw/meson.build         |  1 +
 tests/Makefile.include | 10 +---------
 5 files changed, 51 insertions(+), 44 deletions(-)
 delete mode 100644 hw/core/Makefile.objs
 create mode 100644 hw/core/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index d204a90..bdf8bdf 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -1,4 +1,3 @@
-devices-dirs-y = core/
 ifeq ($(CONFIG_SOFTMMU), y)
 devices-dirs-$(call lor,$(CONFIG_VIRTIO_9P),$(call land,$(CONFIG_VIRTFS),$(CONFIG_XEN))) += 9pfs/
 devices-dirs-y += acpi/
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
deleted file mode 100644
index d8fee8e..0000000
--- a/hw/core/Makefile.objs
+++ /dev/null
@@ -1,34 +0,0 @@
-# core qdev-related obj files, also used by *-user:
-common-obj-y += qdev.o qdev-properties.o
-common-obj-y += bus.o
-common-obj-y += cpu.o
-common-obj-y += resettable.o
-common-obj-y += hotplug.o
-common-obj-y += vmstate-if.o
-# irq.o needed for qdev GPIO handling:
-common-obj-y += irq.o
-common-obj-y += clock.o qdev-clock.o
-
-common-obj-$(CONFIG_SOFTMMU) += reset.o
-common-obj-$(CONFIG_SOFTMMU) += qdev-fw.o
-common-obj-$(CONFIG_SOFTMMU) += fw-path-provider.o
-common-obj-$(CONFIG_SOFTMMU) += nmi.o
-common-obj-$(CONFIG_SOFTMMU) += vm-change-state-handler.o
-common-obj-$(CONFIG_SOFTMMU) += qdev-properties-system.o
-common-obj-$(CONFIG_SOFTMMU) += sysbus.o
-common-obj-$(CONFIG_SOFTMMU) += machine.o
-common-obj-$(CONFIG_SOFTMMU) += null-machine.o
-common-obj-$(CONFIG_SOFTMMU) += loader.o
-common-obj-$(CONFIG_SOFTMMU) += machine-hmp-cmds.o
-common-obj-$(CONFIG_SOFTMMU) += numa.o
-common-obj-$(CONFIG_SOFTMMU) += clock-vmstate.o
-obj-$(CONFIG_SOFTMMU) += machine-qmp-cmds.o
-
-common-obj-$(CONFIG_XILINX_AXI) += stream.o
-common-obj-$(CONFIG_PTIMER) += ptimer.o
-common-obj-$(CONFIG_FITLOADER) += loader-fit.o
-common-obj-$(CONFIG_REGISTER) += register.o
-common-obj-$(CONFIG_OR_IRQ) += or-irq.o
-common-obj-$(CONFIG_SPLIT_IRQ) += split-irq.o
-common-obj-$(CONFIG_PLATFORM_BUS) += platform-bus.o
-common-obj-$(CONFIG_GENERIC_LOADER) += generic-loader.o
diff --git a/hw/core/meson.build b/hw/core/meson.build
new file mode 100644
index 0000000..fc91f98
--- /dev/null
+++ b/hw/core/meson.build
@@ -0,0 +1,49 @@
+# core qdev-related obj files, also used by *-user and unit tests
+hwcore_files = files(
+  'bus.c',
+  'fw-path-provider.c',
+  'hotplug.c',
+  'qdev-properties.c',
+  'qdev.c',
+  'reset.c',
+  'resettable.c',
+  'vmstate-if.c',
+  # irq.c needed for qdev GPIO handling:
+  'irq.c',
+  'clock.c',
+  'qdev-clock.c',
+)
+
+libhwcore = static_library('hwcore', sources: hwcore_files + genh,
+                           name_suffix: 'fa',
+                           build_by_default: false)
+hwcore = declare_dependency(link_whole: libhwcore)
+common_ss.add(hwcore)
+
+common_ss.add(files('cpu.c'))
+common_ss.add(when: 'CONFIG_FITLOADER', if_true: files('loader-fit.c'))
+common_ss.add(when: 'CONFIG_GENERIC_LOADER', if_true: files('generic-loader.c'))
+common_ss.add(when: 'CONFIG_OR_IRQ', if_true: files('or-irq.c'))
+common_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('platform-bus.c'))
+common_ss.add(when: 'CONFIG_PTIMER', if_true: files('ptimer.c'))
+common_ss.add(when: 'CONFIG_REGISTER', if_true: files('register.c'))
+common_ss.add(when: 'CONFIG_SPLIT_IRQ', if_true: files('split-irq.c'))
+common_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c'))
+
+softmmu_ss.add(files(
+  'loader.c',
+  'machine-hmp-cmds.c',
+  'machine.c',
+  'nmi.c',
+  'null-machine.c',
+  'qdev-fw.c',
+  'qdev-properties-system.c',
+  'sysbus.c',
+  'vm-change-state-handler.c',
+  'clock-vmstate.c',
+))
+
+specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files(
+  'machine-qmp-cmds.c',
+  'numa.c',
+))
diff --git a/hw/meson.build b/hw/meson.build
index 08112a5..fe7c466 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1 +1,2 @@
+subdir('core')
 subdir('xen')
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 425c8ce..b6d9661 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -244,15 +244,7 @@ tests/test-bufferiszero$(EXESUF): tests/test-bufferiszero.o $(test-util-obj-y)
 tests/atomic_add-bench$(EXESUF): tests/atomic_add-bench.o $(test-util-obj-y)
 tests/atomic64-bench$(EXESUF): tests/atomic64-bench.o $(test-util-obj-y)
 
-tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o \
-	hw/core/qdev.o hw/core/qdev-properties.o hw/core/hotplug.o\
-	hw/core/bus.o \
-	hw/core/resettable.o \
-	hw/core/irq.o \
-	hw/core/fw-path-provider.o \
-	hw/core/reset.o \
-	hw/core/vmstate-if.o \
-	hw/core/clock.o hw/core/qdev-clock.o \
+tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o hw/core/libhwcore.fa \
 	$(test-qapi-obj-y)
 tests/test-vmstate$(EXESUF): tests/test-vmstate.o migration/libmigration.fa \
 	$(test-io-obj-y)
-- 
1.8.3.1



