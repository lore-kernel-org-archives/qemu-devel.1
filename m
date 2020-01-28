Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB68AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 873DD2467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHzyAfmw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873DD2467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVzm-0006vr-Oz
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:53:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6L-0001ed-U0
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6K-0004m5-FV
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:37 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:39007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV6K-0004kD-6F
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:36 -0500
Received: by mail-wr1-x434.google.com with SMTP id y11so17090012wrt.6
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Hg/3yo5twaEsNTU2uJXGbIo5hUz72j4nbvEVGvGacGw=;
 b=UHzyAfmwGODENgptXqIC74/sQsRJW2jamgxjBP3OwGhJG/Vc4sjIMXVCx+i499D5aT
 TwbBdaJk1Q87NE5cq9u2wGPHparLZG1oZMDbDpAIAlsiOFwmFcd3NaIplwBg3C9AjGF3
 GZlyHsNSDDD7MB0AXbsNrKDMh/ZSRVj1F0M38ZyUpVq4k4m2UzT60gz9rd9z2/Gs23ZY
 rtXUNDc0tjbAj2AWE6C4PgWP/i8PL0JVfCloJ40cGydCbuorhvWwXOqdwjPDjTKv+0cX
 dOFqt++cz9d0zbzvUrlltrXAIuD2vh3hiEMKmgU7wgFML39YNlzXy0IB40dVFtlbwg6O
 m2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Hg/3yo5twaEsNTU2uJXGbIo5hUz72j4nbvEVGvGacGw=;
 b=H1N/Xah/sPFhYfs4iQUaeQr/jHQ1PqB9nXCzgH+mgN8Wo29PERbuyVqTDf4TPI4VIJ
 +TSHza6JuIssPgOHGerZk8FNGUVXLB+wlEP/GGRFsv3kdeWWiiOuGWvRIx/hVC7hH91Q
 mhUnNwNw8xEJsKkux05HjCq4TaxMqXUb7n2b6SxiGwwj9EImz6ZR5iupJ4keioX2LDhV
 Be6RgxGxyiSFEkWE+/KJRQLppl1gyHS361pcuZwXN0/fbiPjj3PwoCoWV54GGpBnVlRh
 68ll9YdBiGDFXCokBtDKdBgveYiE8KGW0GLhMnp4hnjAbI5hUdkt3cadhMSF2Aj3WLMI
 L9oQ==
X-Gm-Message-State: APjAAAW8M8NzIXAaoJhuXl8MZa7D6kXsF5zZXbiW8nYGYn1+f3P/Eth7
 XmOyIFqhGPNZKOxO2EEsy529E0En
X-Google-Smtp-Source: APXvYqxf6j+crG22rD7XsalW3wxqShD8wPm2id2c3ExbO7ueYbex4coi0BBz3qW5/nr0h1lmUppJwg==
X-Received: by 2002:adf:ea51:: with SMTP id j17mr30134285wrn.83.1580234194963; 
 Tue, 28 Jan 2020 09:56:34 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:56:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 070/142] meson: convert hw/core
Date: Tue, 28 Jan 2020 18:52:30 +0100
Message-Id: <20200128175342.9066-71-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
 hw/Makefile.objs      |  1 -
 hw/core/Makefile.objs | 30 ------------------------------
 hw/core/meson.build   | 39 +++++++++++++++++++++++++++++++++++++++
 hw/meson.build        |  1 +
 4 files changed, 40 insertions(+), 31 deletions(-)
 delete mode 100644 hw/core/Makefile.objs
 create mode 100644 hw/core/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index f0ca15595a..3e3ac7fe79 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -1,4 +1,3 @@
-devices-dirs-y = core/
 ifeq ($(CONFIG_SOFTMMU), y)
 devices-dirs-$(call lor,$(CONFIG_VIRTIO_9P),$(call land,$(CONFIG_VIRTFS),$(CONFIG_XEN))) += 9pfs/
 devices-dirs-y += acpi/
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
deleted file mode 100644
index fd0550d1d9..0000000000
--- a/hw/core/Makefile.objs
+++ /dev/null
@@ -1,30 +0,0 @@
-# core qdev-related obj files, also used by *-user:
-common-obj-y += qdev.o qdev-properties.o
-common-obj-y += bus.o reset.o
-common-obj-$(CONFIG_SOFTMMU) += qdev-fw.o
-common-obj-$(CONFIG_SOFTMMU) += fw-path-provider.o
-# irq.o needed for qdev GPIO handling:
-common-obj-y += irq.o
-common-obj-y += hotplug.o
-common-obj-$(CONFIG_SOFTMMU) += nmi.o
-common-obj-$(CONFIG_SOFTMMU) += vm-change-state-handler.o
-common-obj-y += cpu.o
-
-common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
-common-obj-$(CONFIG_XILINX_AXI) += stream.o
-common-obj-$(CONFIG_PTIMER) += ptimer.o
-common-obj-$(CONFIG_SOFTMMU) += sysbus.o
-common-obj-$(CONFIG_SOFTMMU) += machine.o
-common-obj-$(CONFIG_SOFTMMU) += loader.o
-common-obj-$(CONFIG_FITLOADER) += loader-fit.o
-common-obj-$(CONFIG_SOFTMMU) += qdev-properties-system.o
-common-obj-$(CONFIG_REGISTER) += register.o
-common-obj-$(CONFIG_OR_IRQ) += or-irq.o
-common-obj-$(CONFIG_SPLIT_IRQ) += split-irq.o
-common-obj-$(CONFIG_PLATFORM_BUS) += platform-bus.o
-common-obj-$(CONFIG_GENERIC_LOADER) += generic-loader.o
-common-obj-$(CONFIG_SOFTMMU) += null-machine.o
-
-obj-$(CONFIG_SOFTMMU) += machine-qmp-cmds.o
-obj-$(CONFIG_SOFTMMU) += numa.o
-common-obj-$(CONFIG_SOFTMMU) += machine-hmp-cmds.o
diff --git a/hw/core/meson.build b/hw/core/meson.build
new file mode 100644
index 0000000000..3b0d2af593
--- /dev/null
+++ b/hw/core/meson.build
@@ -0,0 +1,39 @@
+common_ss.add(files(
+  # core qdev-related obj files, also used by *-user:
+  'bus.c',
+  'cpu.c',
+  'fw-path-provider.c',
+  'hotplug.c',
+  'qdev-properties.c',
+  'qdev.c',
+  'reset.c',
+  # irq.c needed for qdev GPIO handling:
+  'irq.c',
+))
+
+common_ss.add(when: 'CONFIG_EMPTY_SLOT', if_true: files('empty_slot.c'))
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
-- 
2.21.0



