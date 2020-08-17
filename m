Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231B1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:13:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4D8F205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwFCZUfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D8F205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gor-0007bi-4G
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHm-0005l2-4r
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:54 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:32796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHj-0006Hh-RJ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:53 -0400
Received: by mail-wm1-x32b.google.com with SMTP id f18so13347781wmc.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m1vdLqyZHYPVpKZYlNKe7l8hkA0P1BlGDeAlf+ZccV8=;
 b=TwFCZUfbcAbSQqFLDAquMRXayRE9J9oLiZniVjSp/9IiVBP1cfTJm2iakYPr1rIYH/
 HcpL1YNDMZ4l9/YTpf5kjnk1kxn+rYqh3I69ElbIh33PG+0aW27pY3HJGrJ2P4js+a4I
 pIA//j3SlKgunmlPqEQaifH8gG4TgDRSNybZJ0yUhW+2hm6/GJ0S5HJ+4hBnnUoNHWNb
 Y3/3JMDCMqOTe36ScTAZHLz5hbYPQF3UGFS7g2xTbWOPM/8+ZbBCPxeEbmXq54WDy1TA
 2pLlMNvEApq0KkF+nw/4MxrPm9apLVmfY2aBVWTI9BquBtPSeEIZmV8VghZ3jRyofOm+
 MgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=m1vdLqyZHYPVpKZYlNKe7l8hkA0P1BlGDeAlf+ZccV8=;
 b=JLCFaePO4CKq9ppM3WXGzcYsjvXMyAtMcmwpuYW5PRkGg/WxbKac/O/IGJFyBmf2Y2
 aZ/N9t8Zp6T+ge6X1nYf7YNXOFVUajjMiAU8xHm6lYt2r/epoch9EvowT//enZmmZVd/
 iJ7guE1WH16cP/kxQu1dOqs9tP8VvEbvmXKzYlTsTHrv4aEOZmIoSFAWJ2bOG6p6X09Q
 vD/gevyuyZDeJIQRzKEOy250Gc054P49HAbR7zPted/mkT1eVk/rgMkdcqwmHtDXWvbC
 vBIFnisxCWGN4HjW7mdFy+avFzDz0iMnBiCr6fZRnSY0+jjQ9kCp638qk+ZMhXjnQClU
 6IYw==
X-Gm-Message-State: AOAM533f/0IkG/OtHpcrRUdIk7LXWl5AjmFn6ZHAgEPUg6bqGIvOzORk
 U3IDupIpVKuOzOkSUwtZsovz2R6Z31w=
X-Google-Smtp-Source: ABdhPJzuaETWV/G0wtOayZ3IH4/EG5FASw+qiFW1nCEd6TJP5RiA8l8zGJ+6dnsYCZtZQPmJJJjpGQ==
X-Received: by 2002:a1c:de41:: with SMTP id v62mr15679638wmg.163.1597675130084; 
 Mon, 17 Aug 2020 07:38:50 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 085/150] meson: convert hw/core
Date: Mon, 17 Aug 2020 16:36:18 +0200
Message-Id: <20200817143723.343284-86-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
 hw/core/Makefile.objs  | 34 -----------------------------
 hw/core/meson.build    | 49 ++++++++++++++++++++++++++++++++++++++++++
 hw/meson.build         |  1 +
 tests/Makefile.include | 10 +--------
 5 files changed, 51 insertions(+), 44 deletions(-)
 delete mode 100644 hw/core/Makefile.objs
 create mode 100644 hw/core/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index d204a906af..bdf8bdf256 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -1,4 +1,3 @@
-devices-dirs-y = core/
 ifeq ($(CONFIG_SOFTMMU), y)
 devices-dirs-$(call lor,$(CONFIG_VIRTIO_9P),$(call land,$(CONFIG_VIRTFS),$(CONFIG_XEN))) += 9pfs/
 devices-dirs-y += acpi/
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
deleted file mode 100644
index d8fee8effe..0000000000
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
index 0000000000..fc91f98075
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
index 08112a5e4b..fe7c466460 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1 +1,2 @@
+subdir('core')
 subdir('xen')
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 425c8ce699..b6d96614cb 100644
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
2.26.2



