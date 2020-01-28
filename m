Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1B4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:57:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19AF42467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Al0fLKeo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AF42467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwW32-0003Rh-9A
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:57:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7V-00035y-0h
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7S-0007NM-RA
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:47 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38564)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV7S-0007LT-Ih
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:46 -0500
Received: by mail-wr1-x442.google.com with SMTP id y17so17113755wrh.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gDbjRY+sXEXuT2kbj6ue9gfCsmUR/yWoWCjqG6jN4gk=;
 b=Al0fLKeoxZO4apkLBy4ThiVlUth/eeVyOcrZNCYvpj0oxhD2EwVXzkqLpIgpzcgkHz
 PMNQiA42k9caGHUgDRWJ4iS/7p7Amplb5wBepWdGLSZOpvvMcJpx4xoIwPSOeRIyiGsM
 xnYJy6PoU0r3YJut2p/owI7oL64pYhiMEAPlI+XM38o0RIUcWyEUeRm/gc9nWfcSi6/r
 EszU6r7u14p7iI/u0NH/aHk1YtvhBNqRDgJkd9SQgtQqeqJsrt/R3LKyAMoh5Eg2ooJg
 kF4Q/k+4orwjmo+XlBp+Izvr/0QMSuRe3kP6Ar/36/qlPxxnwHALpNIXA7bgYIO7mIlZ
 Uk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=gDbjRY+sXEXuT2kbj6ue9gfCsmUR/yWoWCjqG6jN4gk=;
 b=TEdT3UBpEE1egUvZtV1CuYsZ4KF7DzOvEMyLoZvsTvZCe2lq0OS6WGQZfueslQshqJ
 pop4VFY/2Cg6jILV1Ez15U5vE2OPaOZx3c/YW+NHFzp5+Z4u05NHhNLI/+7IGdKIUIhv
 aN7JG8dMxc9ZdyQ8blKlkIKLgNZp7sB2qA3bqdkS5mTkxVUT++PsU8euBrOnroUjiuzo
 mmG6fMZzQu01DfXla9zCk5txef6fQOGswa9Gqp1kR9zcHePL6eshDeGYIxB6o+SSS/gj
 xk0sR5zk06BJDt2+VSN27X4uhDOP/tUjbwdpW7adOtj6PcOBRbf97MfwnPFNxdInDUFY
 QOzA==
X-Gm-Message-State: APjAAAV2MY8hfCiXFXk1z5mTfNPzs7fT6cvMj1DslESnLGqVVNGrsF2N
 O9RLJMPQJIg+oFxwKAB+d9O20NTl
X-Google-Smtp-Source: APXvYqxmF6NPPtRx9H+yBRmQpWC5DkdAjjA6r/au6CdU0qfj4q0CGqySoL7EDgjkhpJpBOqKw96bvA==
X-Received: by 2002:adf:c746:: with SMTP id b6mr29684771wrh.298.1580234265285; 
 Tue, 28 Jan 2020 09:57:45 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:57:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 101/142] meson: convert hw/gpio
Date: Tue, 28 Jan 2020 18:53:01 +0100
Message-Id: <20200128175342.9066-102-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
 hw/gpio/Makefile.objs | 12 ------------
 hw/gpio/meson.build   | 12 ++++++++++++
 hw/meson.build        |  1 +
 4 files changed, 13 insertions(+), 13 deletions(-)
 delete mode 100644 hw/gpio/Makefile.objs
 create mode 100644 hw/gpio/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index c9999a846b..d9b7d6b912 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -8,7 +8,6 @@ devices-dirs-y += char/
 devices-dirs-y += cpu/
 devices-dirs-y += display/
 devices-dirs-y += dma/
-devices-dirs-y += gpio/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/gpio/Makefile.objs b/hw/gpio/Makefile.objs
deleted file mode 100644
index d305b3b24b..0000000000
--- a/hw/gpio/Makefile.objs
+++ /dev/null
@@ -1,12 +0,0 @@
-common-obj-$(CONFIG_MAX7310) += max7310.o
-common-obj-$(CONFIG_PL061) += pl061.o
-common-obj-$(CONFIG_PUV3) += puv3_gpio.o
-common-obj-$(CONFIG_ZAURUS) += zaurus.o
-common-obj-$(CONFIG_E500) += mpc8xxx.o
-common-obj-$(CONFIG_GPIO_KEY) += gpio_key.o
-
-obj-$(CONFIG_OMAP) += omap_gpio.o
-obj-$(CONFIG_IMX) += imx_gpio.o
-obj-$(CONFIG_RASPI) += bcm2835_gpio.o
-obj-$(CONFIG_NRF51_SOC) += nrf51_gpio.o
-obj-$(CONFIG_ASPEED_SOC) += aspeed_gpio.o
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
new file mode 100644
index 0000000000..5fc34b970c
--- /dev/null
+++ b/hw/gpio/meson.build
@@ -0,0 +1,12 @@
+softmmu_ss.add(when: 'CONFIG_E500', if_true: files('mpc8xxx.c'))
+softmmu_ss.add(when: 'CONFIG_GPIO_KEY', if_true: files('gpio_key.c'))
+softmmu_ss.add(when: 'CONFIG_MAX7310', if_true: files('max7310.c'))
+softmmu_ss.add(when: 'CONFIG_PL061', if_true: files('pl061.c'))
+softmmu_ss.add(when: 'CONFIG_PUV3', if_true: files('puv3_gpio.c'))
+softmmu_ss.add(when: 'CONFIG_ZAURUS', if_true: files('zaurus.c'))
+
+specific_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpio.c'))
+specific_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_gpio.c'))
+specific_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_gpio.c'))
+specific_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_gpio.c'))
+specific_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
diff --git a/hw/meson.build b/hw/meson.build
index f9e5adfb48..52577c3205 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('gpio')
 subdir('hyperv')
 subdir('i2c')
 subdir('ide')
-- 
2.21.0



