Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAB3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:13:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCAA12173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYUcYUWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCAA12173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWIh-0000hq-4D
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:13:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6q-0002BY-Ka
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6p-0005jN-BL
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:08 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:42210)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV6p-0005dN-1B
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:07 -0500
Received: by mail-wr1-x430.google.com with SMTP id k11so2425364wrd.9
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WZKbaoxrikkmkfZ19e2DYUqNB63fEA4QJkbicYYhSHg=;
 b=MYUcYUWT0kDzWaoM3ItIIY5Wba7QnLzidu/SS10iIklRpGcFd8SSha+C+HOp3pORsF
 g0Uw9iuYuMJz57hloFKs1e8LBbbpgPbh1ZHYgzobYbilUAEXZIqBgRJGIFs+9RIdZcSK
 L/bzbJYp8fA6eMf2Apu9KL6BG5MBux883KdWP62m4hsii5LBHajxUnlcon6jc7e+ycjD
 axjAB5eC4jMc0K7ozPQKWK6vFiZgZRPa1USOkI9YNKpHvikC/sUGJZy/T7WgMndEGv5a
 r2EOeFnxvvneY7nZ9cgqia8ImVTAaIxpdJBS7LDTb/vxvRqfTmus/CMPNTs+i8IGdxoy
 WoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=WZKbaoxrikkmkfZ19e2DYUqNB63fEA4QJkbicYYhSHg=;
 b=fzmRCD04vzKq8KpRIeV0xDJH4dVD2o/rCrf75wbWD1a4mrJM69xNP8aGpztmSjgYuS
 5hNyzbI2m8LxwDraN44gBSvy6yPCTh1Pnh0v0FMRtlquMdtMPIMHubnGXQuIDPkhtfHD
 GnMKS6AknXhRt11GsuBJY2093vEBG234wSphH6bA7d2m2WD/54U+DInokXpfcBGkO8YH
 IIfIYWVZUUJiz9Wgp4Ej4A4+ojUxJ8VnAJsBPeU2BTAfxuEdw70sm3Fti5TTZ7VHDnE0
 RgSGYZuUeWkW6MlAUqE9i4CMno3GbFhphG3zGIWnRKgC+zU/ZKLGFoH3mdcKlys0V8MN
 7kEA==
X-Gm-Message-State: APjAAAWVVoxsTVZZJr9GOfcwJiOD/lpQGTyAxCIjCh1TAOgoYFLMKp7A
 QWYITQkjc/wqb7gpUZS0Q3NgJC//
X-Google-Smtp-Source: APXvYqwELkF4V6xOsJl7TuSMwcfPnbubOyq2cKq1bSWEmzNEwjSrY8QfqLvhfTSF8i0IzuaHViTxQg==
X-Received: by 2002:adf:b193:: with SMTP id q19mr29571687wra.78.1580234222710; 
 Tue, 28 Jan 2020 09:57:02 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:57:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 082/142] meson: convert hw/ssi
Date: Tue, 28 Jan 2020 18:52:42 +0100
Message-Id: <20200128175342.9066-83-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
 hw/Makefile.objs     |  1 -
 hw/meson.build       |  1 +
 hw/ssi/Makefile.objs | 10 ----------
 hw/ssi/meson.build   | 10 ++++++++++
 4 files changed, 11 insertions(+), 11 deletions(-)
 delete mode 100644 hw/ssi/Makefile.objs
 create mode 100644 hw/ssi/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 6152f8074b..55433f352e 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -26,7 +26,6 @@ devices-dirs-$(CONFIG_PCI) += pci-bridge/ pci-host/
 devices-dirs-y += pcmcia/
 devices-dirs-$(CONFIG_SCSI) += scsi/
 devices-dirs-y += sd/
-devices-dirs-y += ssi/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 1fb1687e1e..75644266f2 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -4,6 +4,7 @@ subdir('nubus')
 subdir('rtc')
 subdir('semihosting')
 subdir('smbios')
+subdir('ssi')
 subdir('timer')
 subdir('tpm')
 subdir('usb')
diff --git a/hw/ssi/Makefile.objs b/hw/ssi/Makefile.objs
deleted file mode 100644
index f5bcc65fe7..0000000000
--- a/hw/ssi/Makefile.objs
+++ /dev/null
@@ -1,10 +0,0 @@
-common-obj-$(CONFIG_PL022) += pl022.o
-common-obj-$(CONFIG_SSI) += ssi.o
-common-obj-$(CONFIG_XILINX_SPI) += xilinx_spi.o
-common-obj-$(CONFIG_XILINX_SPIPS) += xilinx_spips.o
-common-obj-$(CONFIG_ASPEED_SOC) += aspeed_smc.o
-common-obj-$(CONFIG_STM32F2XX_SPI) += stm32f2xx_spi.o
-common-obj-$(CONFIG_MSF2) += mss-spi.o
-
-obj-$(CONFIG_OMAP) += omap_spi.o
-obj-$(CONFIG_IMX) += imx_spi.o
diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
new file mode 100644
index 0000000000..612c109a34
--- /dev/null
+++ b/hw/ssi/meson.build
@@ -0,0 +1,10 @@
+softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_smc.c'))
+softmmu_ss.add(when: 'CONFIG_MSF2', if_true: files('mss-spi.c'))
+softmmu_ss.add(when: 'CONFIG_PL022', if_true: files('pl022.c'))
+softmmu_ss.add(when: 'CONFIG_SSI', if_true: files('ssi.c'))
+softmmu_ss.add(when: 'CONFIG_STM32F2XX_SPI', if_true: files('stm32f2xx_spi.c'))
+softmmu_ss.add(when: 'CONFIG_XILINX_SPI', if_true: files('xilinx_spi.c'))
+softmmu_ss.add(when: 'CONFIG_XILINX_SPIPS', if_true: files('xilinx_spips.c'))
+
+specific_ss.add(when: 'CONFIG_IMX', if_true: files('imx_spi.c'))
+specific_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_spi.c'))
-- 
2.21.0



