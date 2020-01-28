Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0588AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C84BF207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyH0VlA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84BF207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVuv-0007Vr-Ty
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:48:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33855)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6H-0001Wh-2J
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6B-0004R1-Tk
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:32 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:40184)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV6B-0004O7-4T
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:27 -0500
Received: by mail-wm1-x32b.google.com with SMTP id t14so3546120wmi.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UHb/Mcs6Z7m1KUajTQkHLwnYid7R1JKme9HPwSSvlZU=;
 b=VyH0VlA9x+xJwvZpAY7BXDyiOmMs7KjmTSG/D/wW6+wuA1cy04Gn50Saagc/nKiHco
 B5S4oAI5+W7IL52ZPvGS85Hf427gHhj6QYXTLrctv3xqRicnuaQBkJ55Z22ZHV97Sjsr
 yrcNhGWY2qhK0csQHBbQTtNlOOzKO12k1e41DljrgrKuYKy8ZDUcom0Xg64MtKbO4OnU
 D1edXcID4t2i3IcxH+YtyA53fFyW/54wG+w6Fhocm5ej5dkEdTFGRnOy9CHbepYtpI2+
 mRSI7UVhsNm9ecrYs6v5rFA/Y1fLIC/5uH5wfEw7/luzOTWZVMZ1fXatARJPs6eYcY54
 YSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=UHb/Mcs6Z7m1KUajTQkHLwnYid7R1JKme9HPwSSvlZU=;
 b=ZP6SqAbrolORxllU6wU4ZH8/paX8GtvY1AzawiVa0g5sJ4hqXC7K35IVpgA8FuLVBm
 FI+symcSOJa2RbEFfo89YVREHqRbtWGhNrlKkM5V/9xp1Km2ctC2z218JdeCEX/HO+0D
 d9X2sDALtv/RgADgSk++Y2BUWdbobOks5AebdPMgmbV1g8BW+/LwysWKjLUqHb/fE1op
 p8EP2b2hMZiHnXaHOEj55xLoycngK7sED6uE/YgGUKqQft7ngN9PNQiZgFeZCjdkw1GD
 SIxtx+zgLHVnSD5qcMKiluUH1ZCIqP7sndxIGBiGBOTJPN9eF/FyTW47ruFYiE5JFPVe
 EHUw==
X-Gm-Message-State: APjAAAXAmtrkVyjKyciqB/8+nDtVJNDGHD/URX7IOKgc051/nahhxqX2
 s6TPrRwXVUDeyRFN0UQl18UxvP8P
X-Google-Smtp-Source: APXvYqw25K2VcI2o9tmRkAksJw0KCr/OWNEvmfYTEi+N1OErYXujC5CU1tgtmcDNbTruIOsGWrvwCQ==
X-Received: by 2002:a05:600c:108a:: with SMTP id
 e10mr6262462wmd.10.1580234185721; 
 Tue, 28 Jan 2020 09:56:25 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:56:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 066/142] meson: convert fsdev/
Date: Tue, 28 Jan 2020 18:52:26 +0100
Message-Id: <20200128175342.9066-67-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
 Makefile.objs       |  6 +-----
 fsdev/Makefile.objs | 12 ------------
 fsdev/meson.build   | 10 ++++++++++
 3 files changed, 11 insertions(+), 17 deletions(-)
 delete mode 100644 fsdev/Makefile.objs

diff --git a/Makefile.objs b/Makefile.objs
index e56106400c..63796fe8bc 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -35,8 +35,6 @@ qom-obj-y = qom/libqom.fa
 # single QEMU executable should support all CPUs and machines.
 
 ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-$(CONFIG_LINUX) = fsdev/
-
 common-obj-y += accel/
 
 common-obj-$(CONFIG_AUDIO_ALSA) += audio-alsa$(DSOSUF)
@@ -58,14 +56,12 @@ common-obj-$(if $(CONFIG_RBD),m) += block-rbd$(DSOSUF)
 
 common-obj-$(if $(CONFIG_LZFSE),m) += block-dmg-lzfse$(DSOSUF)
 common-obj-$(if $(and $(CONFIG_BZIP2),$(CONFIG_DMG)),m) += block-dmg-bz2$(DSOSUF)
-
-common-obj-y += hw/
 endif
 
 #######################################################################
 # Target-independent parts used in system and user emulation
 
-common-obj-y += hw/
+common-obj-y = hw/
 common-obj-y += disas/
 
 ######################################################################
diff --git a/fsdev/Makefile.objs b/fsdev/Makefile.objs
deleted file mode 100644
index 42cd70c367..0000000000
--- a/fsdev/Makefile.objs
+++ /dev/null
@@ -1,12 +0,0 @@
-# Lots of the fsdev/9pcode is pulled in by vl.c via qemu_fsdev_add.
-# only pull in the actual 9p backend if we also enabled virtio or xen.
-ifeq ($(CONFIG_FSDEV_9P),y)
-common-obj-y = qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
-else
-common-obj-y = qemu-fsdev-dummy.o
-endif
-common-obj-y += qemu-fsdev-opts.o qemu-fsdev-throttle.o
-
-# Toplevel always builds this; targets without virtio will put it in
-# common-obj-y
-common-obj-$(CONFIG_ALL) += qemu-fsdev-dummy.o
diff --git a/fsdev/meson.build b/fsdev/meson.build
index eee8507033..ae84c13069 100644
--- a/fsdev/meson.build
+++ b/fsdev/meson.build
@@ -1,3 +1,13 @@
+fsdev_ss = ss.source_set()
+fsdev_ss.add(files('qemu-fsdev-opts.c', 'qemu-fsdev-throttle.c'))
+fsdev_ss.add(when: 'CONFIG_ALL', if_true: files('qemu-fsdev-dummy.c'))
+fsdev_ss.add(when: ['CONFIG_FSDEV_9P'], if_true: files(
+  '9p-iov-marshal.c',
+  '9p-marshal.c',
+  'qemu-fsdev.c',
+), if_false: files('qemu-fsdev-dummy.c'))
+softmmu_ss.add_all(when: 'CONFIG_LINUX', if_true: fsdev_ss)
+
 if have_tools and libattr.found() and libcap_ng.found() and 'CONFIG_VIRTFS' in config_host
   executable('virtfs-proxy-helper', files('virtfs-proxy-helper.c', '9p-marshal.c', '9p-iov-marshal.c'),
              dependencies: [qemuutil, libattr, libcap_ng])
-- 
2.21.0



