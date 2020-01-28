Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77CEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:48:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F1D1207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbEFGWGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1D1207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVuD-00077D-OR
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:48:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7L-0002ul-9P
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7J-000722-7t
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:39 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:37774)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV7I-0006ya-Uo
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:37 -0500
Received: by mail-wm1-x330.google.com with SMTP id f129so3584822wmf.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d6l4tZ9pfhRBA9Czb1QwHQR1aHPqNcmnt0bAAwSfWBM=;
 b=rbEFGWGVu7HIM6A3qDFBA+ZFva4kwMezhr/N0idbJREmahdpjqVF5pM3u3bJwDJ/er
 B2pl6mtkjcZtg8ycYBFHO9b8YMd2gH+qzEFBqrYjERLyGhOCDyayQ4uNtvevi9tM8qXH
 T4I+euraVGIxcRiHfeko0ZiqRjB1VWlsUKx8yVOFandxdR8PVsEwPygnI97XUr+4kdqG
 cpUubYrM+xgDN6R/keVn41PQomNeUFHNrbSTyVBHVAqlmPvufx1Qy/J3uKhfg88XxEbA
 4X6Zw7S8J62YqpoWqaeEwQV76cVjOqM2zvqkwtzw1woAJ3Y9v5oB7p99qIWRigPNrv+I
 qz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=d6l4tZ9pfhRBA9Czb1QwHQR1aHPqNcmnt0bAAwSfWBM=;
 b=k3tdkjjw/nuiiIHOiWS2CQey5jdYx0cx+oy1q8bWb+11p4tT5Gif1Pk7OOhib9cNAa
 8aoUEPZL+/FR04seGLtiX21liQ+IyCuT844KrmGBENGy165mpgB0QIumqTBRtRmalIVq
 sBfrNsX7VoF0A07/VynyEl33TxGJTDm816EnMso+vV9y6sC+OiHH2g6AFnSR4i0eD7nf
 ujV4LWJoY0ixHElyg72DAy0dNye83qGzHzDRkuJqy8K2RpWPly/rTvctBxjPAaa7PYgq
 OLUfUfFHBRAn/QFMGRNJzBVevYsRtK85KqByykpO2hFI5s+iwSyFK3nYAEY3Lx26nFbs
 bmqQ==
X-Gm-Message-State: APjAAAXir5qNEPnrmF2xC4QF7dYqdH3Jrv3mDN8xMBPvjotaJlao1eZ6
 bHGJevjaxRU60F5DfWy80IcJmSHX
X-Google-Smtp-Source: APXvYqz3RvjxQ5S23twztyV9bwbB4OvMj/TRCpyMXEC11IKKMU19o7S6MBKzQY2Gg97bYMd3PFye0A==
X-Received: by 2002:a1c:1f56:: with SMTP id f83mr6233998wmf.93.1580234255351; 
 Tue, 28 Jan 2020 09:57:35 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:57:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 097/142] meson: convert hw/input
Date: Tue, 28 Jan 2020 18:52:57 +0100
Message-Id: <20200128175342.9066-98-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
 hw/Makefile.objs       |  1 -
 hw/input/Makefile.objs | 17 -----------------
 hw/input/meson.build   | 17 +++++++++++++++++
 hw/meson.build         |  1 +
 4 files changed, 18 insertions(+), 18 deletions(-)
 delete mode 100644 hw/input/Makefile.objs
 create mode 100644 hw/input/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 1e52bc3b1a..52a99a8760 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -12,7 +12,6 @@ devices-dirs-y += gpio/
 devices-dirs-$(CONFIG_HYPERV) += hyperv/
 devices-dirs-$(CONFIG_I2C) += i2c/
 devices-dirs-y += ide/
-devices-dirs-y += input/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
deleted file mode 100644
index a1bc502ed0..0000000000
--- a/hw/input/Makefile.objs
+++ /dev/null
@@ -1,17 +0,0 @@
-common-obj-$(CONFIG_ADB) += adb.o adb-mouse.o adb-kbd.o
-common-obj-y += hid.o
-common-obj-$(CONFIG_LM832X) += lm832x.o
-common-obj-$(CONFIG_PCKBD) += pckbd.o
-common-obj-$(CONFIG_PL050) += pl050.o
-common-obj-$(CONFIG_PS2) += ps2.o
-common-obj-$(CONFIG_STELLARIS_INPUT) += stellaris_input.o
-common-obj-$(CONFIG_TSC2005) += tsc2005.o
-
-common-obj-$(CONFIG_VIRTIO_INPUT) += virtio-input.o
-common-obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-hid.o
-common-obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host.o
-common-obj-$(CONFIG_VHOST_USER_INPUT) += vhost-user-input.o
-
-obj-$(CONFIG_MILKYMIST) += milkymist-softusb.o
-obj-$(CONFIG_PXA2XX) += pxa2xx_keypad.o
-obj-$(CONFIG_TSC210X) += tsc210x.o
diff --git a/hw/input/meson.build b/hw/input/meson.build
new file mode 100644
index 0000000000..6cc59e6037
--- /dev/null
+++ b/hw/input/meson.build
@@ -0,0 +1,17 @@
+softmmu_ss.add(files('hid.c'))
+softmmu_ss.add(when: 'CONFIG_ADB', if_true: files('adb.c', 'adb-mouse.c', 'adb-kbd.c'))
+softmmu_ss.add(when: 'CONFIG_LM832X', if_true: files('lm832x.c'))
+softmmu_ss.add(when: 'CONFIG_PCKBD', if_true: files('pckbd.c'))
+softmmu_ss.add(when: 'CONFIG_PL050', if_true: files('pl050.c'))
+softmmu_ss.add(when: 'CONFIG_PS2', if_true: files('ps2.c'))
+softmmu_ss.add(when: 'CONFIG_STELLARIS_INPUT', if_true: files('stellaris_input.c'))
+softmmu_ss.add(when: 'CONFIG_TSC2005', if_true: files('tsc2005.c'))
+
+softmmu_ss.add(when: 'CONFIG_VIRTIO_INPUT', if_true: files('virtio-input.c'))
+softmmu_ss.add(when: 'CONFIG_VIRTIO_INPUT', if_true: files('virtio-input-hid.c'))
+softmmu_ss.add(when: 'CONFIG_VIRTIO_INPUT_HOST', if_true: files('virtio-input-host.c'))
+softmmu_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files('vhost-user-input.c'))
+
+specific_ss.add(when: 'CONFIG_MILKYMIST', if_true: files('milkymist-softusb.c'))
+specific_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx_keypad.c'))
+specific_ss.add(when: 'CONFIG_TSC210X', if_true: files('tsc210x.c'))
diff --git a/hw/meson.build b/hw/meson.build
index 986e710287..b15c8d0970 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('input')
 subdir('intc')
 subdir('ipack')
 subdir('ipmi')
-- 
2.21.0



