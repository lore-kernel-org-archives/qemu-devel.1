Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5085EC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16E912173E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNE2+tez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E912173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOpz-0003lu-3s
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyw-0004Pv-TK
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyv-0007tg-J0
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:14 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:34228)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyv-0007s3-9e
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:13 -0500
Received: by mail-wr1-x435.google.com with SMTP id t2so2646587wrr.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tSMwvOVlmljJ/d7pUHQjqPiE5EBDb5gSPZ7yrnNNJfk=;
 b=SNE2+tezie7kPxeQwQ1zKJ31REZIRUiH5F49tNoYAyrmeVoDq3nbxUaaz06z0nFi+z
 qr81l8U288WjjM9wnhoYADBu+9zY4WMMPtgIiGEerfoqzfWfej6Nj8TXnVhEEj+esGDc
 Hv4giCv5EKwFr7QsinMQv2/4A1tFmAo17DVXcimmnsPIzJgMOKZaHoyzO0vW4uvNREmv
 3++QaqBtH5aWHUH2FVCy9ovDsP5xdo2ryQjxJSyZR7cQjzWHwEEXcgHQ4B9rDDmIKOtY
 I1gKqkXxNRbznj3E2/UUnlk5b43jURzrlA+N+IzwqSGNGsw5yyuZds4TsqG7O3Y0PC0Q
 Pj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=tSMwvOVlmljJ/d7pUHQjqPiE5EBDb5gSPZ7yrnNNJfk=;
 b=c8tyXWOutf2Uq0zt9fROB+T93LqDsUIM4TvonkKcXoQI1MxXLoH/ZZN6b8ZJv+AOie
 Bbit/aRm91+XPpWq52mXiIHyb2diF5k4xlLFgZzc4b1t1tsAnPLnNYaJGAlRw3SY1uP5
 +bBboMYFl0QFZ+nVNZhHqb3dBEzqV3mUHj7/6f4V1SF+6bSbCNeg3Lflep8rEPVqV/Eg
 tpCPGN1ajCEb8wkXF83x/b9MIUiQK7N5SyHZJk8uBf0OAUJtP/TOD54HFVEDjxnse7Zs
 ZqWZ7bH/GB+GzrL46XRFf9J45J1MRR8SVIb7OWTy6VJxyUAG3/uFXgvQ/a7J299U6khV
 dQ2Q==
X-Gm-Message-State: APjAAAUjJH9Bcw/IquIYFvHXDBvuO+Y51Fniz08dJ7NWmYPDCUiJSKc8
 wZOeWM5orEA38pFfTyUOtaTnhBSI
X-Google-Smtp-Source: APXvYqy5pey0D27+QQgofM/UsmmeEhimhJqgLZRBha717I8MkKwGaPoseAHiJ+a3u8OuhuivZjIMrQ==
X-Received: by 2002:adf:ffc7:: with SMTP id x7mr6133054wrs.159.1576155252105; 
 Thu, 12 Dec 2019 04:54:12 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 074/132] meson: convert hw/ssi
Date: Thu, 12 Dec 2019 13:51:58 +0100
Message-Id: <1576155176-2464-75-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
 hw/Makefile.objs     |  1 -
 hw/meson.build       |  1 +
 hw/ssi/Makefile.objs | 10 ----------
 hw/ssi/meson.build   | 10 ++++++++++
 4 files changed, 11 insertions(+), 11 deletions(-)
 delete mode 100644 hw/ssi/Makefile.objs
 create mode 100644 hw/ssi/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 1d47113..201d614 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -27,7 +27,6 @@ devices-dirs-$(CONFIG_PCI) += pci-bridge/ pci-host/
 devices-dirs-y += pcmcia/
 devices-dirs-$(CONFIG_SCSI) += scsi/
 devices-dirs-y += sd/
-devices-dirs-y += ssi/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 960fd14..a867f82 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -2,6 +2,7 @@ subdir('core')
 subdir('mem')
 subdir('semihosting')
 subdir('smbios')
+subdir('ssi')
 subdir('timer')
 subdir('tpm')
 subdir('usb')
diff --git a/hw/ssi/Makefile.objs b/hw/ssi/Makefile.objs
deleted file mode 100644
index f5bcc65..0000000
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
index 0000000..612c109
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
1.8.3.1



