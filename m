Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4718CC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 135BB206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btDYmDDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135BB206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOQe-0005ky-Op
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:22:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyc-0003uP-7c
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNya-0007Gw-VT
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:54 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:35172)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNya-0007FM-OB
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:52 -0500
Received: by mail-wm1-x32f.google.com with SMTP id p17so2392346wmb.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BhjIZSbzDXjcTJIBhziqsn15p3DsoLde/mMNVXxEiZ4=;
 b=btDYmDDOk46C3BY24FAccxqqZxOt4YNYLUMQ661E17dEPA9you8jM5n7SlMTfZxczY
 jXkSYOLrG+Bbjdq7v6t0H3sHvkcD5jfW7LaeQVD9rwjUjvdOSTOSXCEyhc0oAYX6G7tW
 7vUX9snuEKOBDKovYGZUMI/RPO8aBQS0KBhN636nL+Cd5ior5h6QWgVuiYfpc9Q3QnyI
 lS5necW50Dq4urWX1ohSKjLerC1/lSMKxH6coP1P6CM3oVbT2UMMI/hmHfLrDVzkIwl8
 yDJyGbp8jslY9/v7lyPpkUQkKT9mbPgaZPfHh8+p4LQerolYTxLiOaBPXJ7O2fULKoEC
 kvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=BhjIZSbzDXjcTJIBhziqsn15p3DsoLde/mMNVXxEiZ4=;
 b=IWt6g0e5cZF7rsz5uCwKcIRkbVkL28MB37F1oyddXZstF11VQVDnLdsAfXSYkOKF9j
 eMDGO55XfiRAv98nCwbRVYSX62eftBxHFL3KX9deUbLQrNIiPt+scj132KwtY3OA6czQ
 hAoUATAac9eeGu354WqQVwB3DmDAxxDDitcMxrL0vOo7b2odV4UQ6sBKcEjZQoNh49y1
 BWDHWHZ8yH71hb59r5lvdArd6oxVfmleUwyQA1nQQv8uJXOft/q4nMZTH1vsnYZRfCmF
 wOs6FFXQIWZ+kItFXGUa29kqX1xTzqRcB68yVF94vCzpW9R/8c9HQ+OTsFLqjr+u8Gml
 G9EQ==
X-Gm-Message-State: APjAAAW3L2M1gKEBGm9JN9Ik5OVyeWLgjzMCeSoFwymObNs0RR4TIUHP
 40CZBIkEAJ/v/USDGYEuvfpPDMhI
X-Google-Smtp-Source: APXvYqwjjEv1BDRXhrYBEdftOfSVdQnj3K0ircHYWXYEObwbYYLazohzGuk4ljp5l2qNIweW5RiQew==
X-Received: by 2002:a7b:c0d8:: with SMTP id s24mr6830421wmh.30.1576155231503; 
 Thu, 12 Dec 2019 04:53:51 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 054/132] meson: convert monitor directory to Meson
Date: Thu, 12 Dec 2019 13:51:38 +0100
Message-Id: <1576155176-2464-55-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs         | 3 +--
 Makefile.target       | 1 -
 meson.build           | 2 ++
 monitor/Makefile.objs | 3 ---
 monitor/meson.build   | 9 +++++++++
 5 files changed, 12 insertions(+), 6 deletions(-)
 delete mode 100644 monitor/Makefile.objs
 create mode 100644 monitor/meson.build

diff --git a/Makefile.objs b/Makefile.objs
index 1b1eff5..98c16c5 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -35,8 +35,7 @@ qom-obj-y = qom/libqom.fa
 # single QEMU executable should support all CPUs and machines.
 
 ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-y = monitor/
-common-obj-y += net/
+common-obj-y = net/
 common-obj-$(CONFIG_LINUX) += fsdev/
 common-obj-y += migration/
 
diff --git a/Makefile.target b/Makefile.target
index 569f2d9..8628e25 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -154,7 +154,6 @@ ifdef CONFIG_SOFTMMU
 obj-y += arch_init.o cpus.o gdbstub.o balloon.o ioport.o
 obj-y += qtest.o
 obj-y += hw/
-obj-y += monitor/
 obj-y += qapi/
 obj-y += memory.o
 obj-y += memory_mapping.o
diff --git a/meson.build b/meson.build
index 804a9bc..2355a99 100644
--- a/meson.build
+++ b/meson.build
@@ -590,6 +590,8 @@ softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
 
 common_ss.add(files('cpus-common.c'))
 
+subdir('monitor')
+
 mods = []
 block_mods = []
 softmmu_mods = []
diff --git a/monitor/Makefile.objs b/monitor/Makefile.objs
deleted file mode 100644
index e91a858..0000000
--- a/monitor/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-obj-y += misc.o
-common-obj-y += monitor.o qmp.o hmp.o
-common-obj-y += qmp-cmds.o hmp-cmds.o
diff --git a/monitor/meson.build b/monitor/meson.build
new file mode 100644
index 0000000..1eabfd5
--- /dev/null
+++ b/monitor/meson.build
@@ -0,0 +1,9 @@
+softmmu_ss.add(files(
+  'hmp-cmds.c',
+  'hmp.c',
+  'monitor.c',
+  'qmp-cmds.c',
+  'qmp.c',
+))
+
+specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files('misc.c'))
-- 
1.8.3.1



