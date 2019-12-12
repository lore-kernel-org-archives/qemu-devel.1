Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA91C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:55:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B41A21655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/M4N4Dd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B41A21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOvo-0003cB-Vr
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:55:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNzB-0004nW-L6
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNzA-0008Hy-Ae
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:29 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:34220)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNzA-0008GN-49
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:28 -0500
Received: by mail-wr1-x42a.google.com with SMTP id t2so2647279wrr.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T8nlJuKHUFV6YDTgA0pf50k84pJ1aEuOI0caCAxP+sI=;
 b=U/M4N4DdnO7Xn28tAIEtwkjRZgcJjReHyw00UgJQoITPzs1AeeOvTAqaiRP2DXvpAb
 PC5Sc45wt+2qmzeMVPnldMVQdGD/vhrjHakT04YV2pa3yZLemjmcTRS49kOB8gpElWzh
 nQpNoJBGOnMy/JDuEq2y4D29mDi47e6Fi2Ls8fZrJn1bcFImXLGo9BERE+OIbo/FwRYQ
 v8iRqgFtrsTB7ObsWLBghSZu6c+j1iJWA6srKMjsFMa4dhmgWqAedxx3tydsoRRlC11O
 nFPhFhS0UVihJc7vJgYf1AhJP/h1esn/K4J/+hz6bkt57Ep2l+dmCCWKIiQGEuC6RFGj
 pyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=T8nlJuKHUFV6YDTgA0pf50k84pJ1aEuOI0caCAxP+sI=;
 b=KG7tW5nsUeiQ7ulkXI4VaR81zndydZ5GnAKMkBymuEjPXjt+vCT1KCMTmELsy3RNcV
 YLa2gdk752JkByqyyPCGp7NRO275O8FKAMX+T4vMJzlxARBOPyWGKdbTbsgTqvMGd+pR
 GICRDT769DUzGlK6utMfQ5/4aE7daqeqmJPuKGoP8V5rWOmxEKcLAJFnrhxgiSmogvZ7
 JQjYajLqlXqCWZqw/UvIICuOEMAmLwrXszfipjRsvfd1y+GfrhBgb7rxWjuL57StRZdk
 lXyFG3k6QpkyOyt+QTB1wPkx9RCzv1E9i4yrqabHDLVy7x0LiFXXQQnz/BYhuLBp6BaE
 LO2Q==
X-Gm-Message-State: APjAAAURT74yZrFR9BKA8+5rRZoQYalAkjIOB57z/VNs0E6kDowvl7sc
 3m9MESJSGItQxcV9xWLaNasXQjQf
X-Google-Smtp-Source: APXvYqzSdB9RsmIKQPuWTiPl8hUOUm6kgfOWyJEEsbqL+FmUvijdrf7zJW2XiDwQKwojHjIYegWEBA==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr6373042wrs.213.1576155266825; 
 Thu, 12 Dec 2019 04:54:26 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 089/132] meson: convert hw/input
Date: Thu, 12 Dec 2019 13:52:13 +0100
Message-Id: <1576155176-2464-90-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
---
 hw/Makefile.objs       |  1 -
 hw/input/Makefile.objs | 17 -----------------
 hw/input/meson.build   | 17 +++++++++++++++++
 hw/meson.build         |  1 +
 4 files changed, 18 insertions(+), 18 deletions(-)
 delete mode 100644 hw/input/Makefile.objs
 create mode 100644 hw/input/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index c89ca8d..c99f7e3 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -13,7 +13,6 @@ devices-dirs-y += gpio/
 devices-dirs-$(CONFIG_HYPERV) += hyperv/
 devices-dirs-$(CONFIG_I2C) += i2c/
 devices-dirs-y += ide/
-devices-dirs-y += input/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
deleted file mode 100644
index a1bc502..0000000
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
index 0000000..6cc59e6
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
index a5032d3..a85ec93 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('input')
 subdir('intc')
 subdir('ipack')
 subdir('ipmi')
-- 
1.8.3.1



