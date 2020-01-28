Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61541C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:59:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C8A2467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rbtgsg2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C8A2467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwW5I-00078o-A2
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:59:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7f-0003Pz-Ej
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7e-0007rO-0u
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:59 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:50764)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV7d-0007o2-L2
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:57 -0500
Received: by mail-wm1-x335.google.com with SMTP id a5so3534188wmb.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9DgqWnWCxy8tt44ULg7kNP/pB4huP4GqDZOAtPow0Ac=;
 b=Rbtgsg2FzjQXgveR04huu+tq4Lr3WAEiDY/o2pErwCGhFvt18N+xOHfDF1l5bC0mqG
 gV7OemwenrSqIycIIDdB2TT9+4jnr9A5/Iaj2NXOh2im3R93xeA9GypY69fOqaUiaCOl
 TEm75wPiqJeqV7Zc7UnPEjJ1kO4C2pZvvi0y9U5dHoOrxAqiOtJcmqSriV70nxG5ZeT0
 6Y8Km3XOq3J8HN2TmdknGYVshT8og3kPkbrHnASBno64PJzi7u02e7/20AUpRiIQwGey
 wQ7flGpTDxp4nwQG9UVnOQXnA4s1IVsdA6KRptLy14Qstu40uoae2+KO6elBpK1h47ZD
 3tiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9DgqWnWCxy8tt44ULg7kNP/pB4huP4GqDZOAtPow0Ac=;
 b=IAqOTAuPmQ6x1BqD+qtgeCqdfUAWVcfNa/CeCagtgnl0jWmoaG3Kw+gEe/s7bUHNLY
 VtqvTd2LYak7GOx7oHgbXCtYEq1INkBj7mqqKi64O/ISWnS9rFtKQ+L1a3AeKw/nU6J0
 ROdspYBNhWF8sN/lkA8+3btWvt5OFO4kPGLThrYMhO3H21gP+XUzte2f6npWErd23xxu
 lcO5O8roMlnPDa5WJogH2uDqsBIhbNaZiQLgBlPbP5bpyrMETWgOYyRqNCcmB08H7gDt
 yYZNBV+kcJ9zUejra1Vq/qWMGSISqeVP5iMfhtXjbPHwNdzXuySZ8GkOn/wU6BI4/Kbu
 8iRg==
X-Gm-Message-State: APjAAAV3l0A/PIR32liGShY/W6P47OwwJHouPyPOAdYoPs34tdJDfCwc
 jtW8lBITseKlRn7NIKYyUL8Mf1v1
X-Google-Smtp-Source: APXvYqxXbAKwULMxOc+M94HoFbrwiFblxQ2zzlKE8fslFtqmLClxQiI+wzG+HQj2fTYF4+BG9YPyBA==
X-Received: by 2002:a7b:c109:: with SMTP id w9mr6190469wmi.14.1580234275255;
 Tue, 28 Jan 2020 09:57:55 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:57:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 105/142] meson: convert hw/char
Date: Tue, 28 Jan 2020 18:53:05 +0100
Message-Id: <20200128175342.9066-106-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
 hw/char/Makefile.objs | 36 ------------------------------------
 hw/char/meson.build   | 34 ++++++++++++++++++++++++++++++++++
 hw/meson.build        |  1 +
 4 files changed, 35 insertions(+), 37 deletions(-)
 delete mode 100644 hw/char/Makefile.objs
 create mode 100644 hw/char/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 0b9879456f..6ddffced72 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -4,7 +4,6 @@ devices-dirs-y += acpi/
 devices-dirs-y += adc/
 devices-dirs-y += audio/
 devices-dirs-y += block/
-devices-dirs-y += char/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
deleted file mode 100644
index 02d8a66925..0000000000
--- a/hw/char/Makefile.objs
+++ /dev/null
@@ -1,36 +0,0 @@
-common-obj-$(CONFIG_IPACK) += ipoctal232.o
-common-obj-$(CONFIG_ESCC) += escc.o
-common-obj-$(CONFIG_NRF51_SOC) += nrf51_uart.o
-common-obj-$(CONFIG_PARALLEL) += parallel.o
-common-obj-$(CONFIG_ISA_BUS) += parallel-isa.o
-common-obj-$(CONFIG_PL011) += pl011.o
-common-obj-$(CONFIG_SERIAL) += serial.o
-common-obj-$(CONFIG_SERIAL_ISA) += serial-isa.o
-common-obj-$(CONFIG_SERIAL_PCI) += serial-pci.o
-common-obj-$(CONFIG_SERIAL_PCI_MULTI) += serial-pci-multi.o
-common-obj-$(CONFIG_VIRTIO_SERIAL) += virtio-console.o
-common-obj-$(CONFIG_XILINX) += xilinx_uartlite.o
-common-obj-$(CONFIG_XEN) += xen_console.o
-common-obj-$(CONFIG_CADENCE) += cadence_uart.o
-
-obj-$(CONFIG_EXYNOS4) += exynos4210_uart.o
-obj-$(CONFIG_COLDFIRE) += mcf_uart.o
-obj-$(CONFIG_OMAP) += omap_uart.o
-obj-$(CONFIG_SH4) += sh_serial.o
-obj-$(CONFIG_PSERIES) += spapr_vty.o
-obj-$(CONFIG_DIGIC) += digic-uart.o
-obj-$(CONFIG_STM32F2XX_USART) += stm32f2xx_usart.o
-obj-$(CONFIG_RASPI) += bcm2835_aux.o
-
-common-obj-$(CONFIG_CMSDK_APB_UART) += cmsdk-apb-uart.o
-common-obj-$(CONFIG_ETRAXFS) += etraxfs_ser.o
-common-obj-$(CONFIG_ISA_DEBUG) += debugcon.o
-common-obj-$(CONFIG_GRLIB) += grlib_apbuart.o
-common-obj-$(CONFIG_IMX) += imx_serial.o
-common-obj-$(CONFIG_LM32) += lm32_juart.o
-common-obj-$(CONFIG_LM32) += lm32_uart.o
-common-obj-$(CONFIG_MILKYMIST) += milkymist-uart.o
-common-obj-$(CONFIG_SCLPCONSOLE) += sclpconsole.o sclpconsole-lm.o
-
-obj-$(CONFIG_VIRTIO) += virtio-serial-bus.o
-obj-$(CONFIG_TERMINAL3270) += terminal3270.o
diff --git a/hw/char/meson.build b/hw/char/meson.build
new file mode 100644
index 0000000000..002e5d01d3
--- /dev/null
+++ b/hw/char/meson.build
@@ -0,0 +1,34 @@
+softmmu_ss.add(when: 'CONFIG_CADENCE', if_true: files('cadence_uart.c'))
+softmmu_ss.add(when: 'CONFIG_CMSDK_APB_UART', if_true: files('cmsdk-apb-uart.c'))
+softmmu_ss.add(when: 'CONFIG_ESCC', if_true: files('escc.c'))
+softmmu_ss.add(when: 'CONFIG_ETRAXFS', if_true: files('etraxfs_ser.c'))
+softmmu_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_apbuart.c'))
+softmmu_ss.add(when: 'CONFIG_IMX', if_true: files('imx_serial.c'))
+softmmu_ss.add(when: 'CONFIG_IPACK', if_true: files('ipoctal232.c'))
+softmmu_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('parallel-isa.c'))
+softmmu_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugcon.c'))
+softmmu_ss.add(when: 'CONFIG_LM32', if_true: files('lm32_juart.c'))
+softmmu_ss.add(when: 'CONFIG_LM32', if_true: files('lm32_uart.c'))
+softmmu_ss.add(when: 'CONFIG_MILKYMIST', if_true: files('milkymist-uart.c'))
+softmmu_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_uart.c'))
+softmmu_ss.add(when: 'CONFIG_PARALLEL', if_true: files('parallel.c'))
+softmmu_ss.add(when: 'CONFIG_PL011', if_true: files('pl011.c'))
+softmmu_ss.add(when: 'CONFIG_SCLPCONSOLE', if_true: files('sclpconsole.c', 'sclpconsole-lm.c'))
+softmmu_ss.add(when: 'CONFIG_SERIAL', if_true: files('serial.c'))
+softmmu_ss.add(when: 'CONFIG_SERIAL_ISA', if_true: files('serial-isa.c'))
+softmmu_ss.add(when: 'CONFIG_SERIAL_PCI', if_true: files('serial-pci.c'))
+softmmu_ss.add(when: 'CONFIG_SERIAL_PCI_MULTI', if_true: files('serial-pci-multi.c'))
+softmmu_ss.add(when: 'CONFIG_VIRTIO_SERIAL', if_true: files('virtio-console.c'))
+softmmu_ss.add(when: 'CONFIG_XEN', if_true: files('xen_console.c'))
+softmmu_ss.add(when: 'CONFIG_XILINX', if_true: files('xilinx_uartlite.c'))
+
+specific_ss.add(when: 'CONFIG_COLDFIRE', if_true: files('mcf_uart.c'))
+specific_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic-uart.c'))
+specific_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_uart.c'))
+specific_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_uart.c'))
+specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_vty.c'))
+specific_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_aux.c'))
+specific_ss.add(when: 'CONFIG_SH4', if_true: files('sh_serial.c'))
+specific_ss.add(when: 'CONFIG_STM32F2XX_USART', if_true: files('stm32f2xx_usart.c'))
+specific_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('terminal3270.c'))
+specific_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-serial-bus.c'))
diff --git a/hw/meson.build b/hw/meson.build
index 103da4840b..dd0c77ec2b 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,3 +1,4 @@
+subdir('char')
 subdir('core')
 subdir('cpu')
 subdir('display')
-- 
2.21.0



