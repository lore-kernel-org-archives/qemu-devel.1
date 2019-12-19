Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD69DC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:35:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94C25218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aga2F9dU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C25218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihv1U-0004Y8-1X
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:35:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihuqm-0007MR-Mg
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihuql-000669-0k
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:16 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33034
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihuqk-00062j-OA
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CqV/6Dei8VWL9nSm69LPJTUO2Sf2TZXXU7e/2BX6ZfI=;
 b=aga2F9dU4WVLzvqDwXR9TXyohX0eYb57gfCsUodRqNyz5SZYpPGl/ZBLQs34yx3oVDW5gJ
 3EA5Bntpnjc8nU/lPWJJdEFuWfApJEl4xU1rabsRj38qyenf8/n1LQmMtpptW3Hs5v/HUk
 /xjSG3vlEsGZQEU/y7hwMTwQfGfckqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-Yt5cnHP6P-Sj6wQWb7hPBA-1; Thu, 19 Dec 2019 07:24:13 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24668801E6C
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:24:12 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 51F7B60C18;
 Thu, 19 Dec 2019 12:24:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 097/132] meson: convert hw/char
Date: Thu, 19 Dec 2019 13:23:17 +0100
Message-Id: <1576758232-12439-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Yt5cnHP6P-Sj6wQWb7hPBA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/Makefile.objs      |  1 -
 hw/char/Makefile.objs | 36 ------------------------------------
 hw/char/meson.build   | 34 ++++++++++++++++++++++++++++++++++
 hw/meson.build        |  1 +
 4 files changed, 35 insertions(+), 37 deletions(-)
 delete mode 100644 hw/char/Makefile.objs
 create mode 100644 hw/char/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 67a2bb5..6752297 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -5,7 +5,6 @@ devices-dirs-y +=3D adc/
 devices-dirs-y +=3D audio/
 devices-dirs-y +=3D block/
 devices-dirs-y +=3D bt/
-devices-dirs-y +=3D char/
 endif
=20
 common-obj-y +=3D $(devices-dirs-y)
diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
deleted file mode 100644
index 02d8a66..0000000
--- a/hw/char/Makefile.objs
+++ /dev/null
@@ -1,36 +0,0 @@
-common-obj-$(CONFIG_IPACK) +=3D ipoctal232.o
-common-obj-$(CONFIG_ESCC) +=3D escc.o
-common-obj-$(CONFIG_NRF51_SOC) +=3D nrf51_uart.o
-common-obj-$(CONFIG_PARALLEL) +=3D parallel.o
-common-obj-$(CONFIG_ISA_BUS) +=3D parallel-isa.o
-common-obj-$(CONFIG_PL011) +=3D pl011.o
-common-obj-$(CONFIG_SERIAL) +=3D serial.o
-common-obj-$(CONFIG_SERIAL_ISA) +=3D serial-isa.o
-common-obj-$(CONFIG_SERIAL_PCI) +=3D serial-pci.o
-common-obj-$(CONFIG_SERIAL_PCI_MULTI) +=3D serial-pci-multi.o
-common-obj-$(CONFIG_VIRTIO_SERIAL) +=3D virtio-console.o
-common-obj-$(CONFIG_XILINX) +=3D xilinx_uartlite.o
-common-obj-$(CONFIG_XEN) +=3D xen_console.o
-common-obj-$(CONFIG_CADENCE) +=3D cadence_uart.o
-
-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_uart.o
-obj-$(CONFIG_COLDFIRE) +=3D mcf_uart.o
-obj-$(CONFIG_OMAP) +=3D omap_uart.o
-obj-$(CONFIG_SH4) +=3D sh_serial.o
-obj-$(CONFIG_PSERIES) +=3D spapr_vty.o
-obj-$(CONFIG_DIGIC) +=3D digic-uart.o
-obj-$(CONFIG_STM32F2XX_USART) +=3D stm32f2xx_usart.o
-obj-$(CONFIG_RASPI) +=3D bcm2835_aux.o
-
-common-obj-$(CONFIG_CMSDK_APB_UART) +=3D cmsdk-apb-uart.o
-common-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_ser.o
-common-obj-$(CONFIG_ISA_DEBUG) +=3D debugcon.o
-common-obj-$(CONFIG_GRLIB) +=3D grlib_apbuart.o
-common-obj-$(CONFIG_IMX) +=3D imx_serial.o
-common-obj-$(CONFIG_LM32) +=3D lm32_juart.o
-common-obj-$(CONFIG_LM32) +=3D lm32_uart.o
-common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-uart.o
-common-obj-$(CONFIG_SCLPCONSOLE) +=3D sclpconsole.o sclpconsole-lm.o
-
-obj-$(CONFIG_VIRTIO) +=3D virtio-serial-bus.o
-obj-$(CONFIG_TERMINAL3270) +=3D terminal3270.o
diff --git a/hw/char/meson.build b/hw/char/meson.build
new file mode 100644
index 0000000..002e5d0
--- /dev/null
+++ b/hw/char/meson.build
@@ -0,0 +1,34 @@
+softmmu_ss.add(when: 'CONFIG_CADENCE', if_true: files('cadence_uart.c'))
+softmmu_ss.add(when: 'CONFIG_CMSDK_APB_UART', if_true: files('cmsdk-apb-ua=
rt.c'))
+softmmu_ss.add(when: 'CONFIG_ESCC', if_true: files('escc.c'))
+softmmu_ss.add(when: 'CONFIG_ETRAXFS', if_true: files('etraxfs_ser.c'))
+softmmu_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_apbuart.c'))
+softmmu_ss.add(when: 'CONFIG_IMX', if_true: files('imx_serial.c'))
+softmmu_ss.add(when: 'CONFIG_IPACK', if_true: files('ipoctal232.c'))
+softmmu_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('parallel-isa.c'))
+softmmu_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugcon.c'))
+softmmu_ss.add(when: 'CONFIG_LM32', if_true: files('lm32_juart.c'))
+softmmu_ss.add(when: 'CONFIG_LM32', if_true: files('lm32_uart.c'))
+softmmu_ss.add(when: 'CONFIG_MILKYMIST', if_true: files('milkymist-uart.c'=
))
+softmmu_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_uart.c'))
+softmmu_ss.add(when: 'CONFIG_PARALLEL', if_true: files('parallel.c'))
+softmmu_ss.add(when: 'CONFIG_PL011', if_true: files('pl011.c'))
+softmmu_ss.add(when: 'CONFIG_SCLPCONSOLE', if_true: files('sclpconsole.c',=
 'sclpconsole-lm.c'))
+softmmu_ss.add(when: 'CONFIG_SERIAL', if_true: files('serial.c'))
+softmmu_ss.add(when: 'CONFIG_SERIAL_ISA', if_true: files('serial-isa.c'))
+softmmu_ss.add(when: 'CONFIG_SERIAL_PCI', if_true: files('serial-pci.c'))
+softmmu_ss.add(when: 'CONFIG_SERIAL_PCI_MULTI', if_true: files('serial-pci=
-multi.c'))
+softmmu_ss.add(when: 'CONFIG_VIRTIO_SERIAL', if_true: files('virtio-consol=
e.c'))
+softmmu_ss.add(when: 'CONFIG_XEN', if_true: files('xen_console.c'))
+softmmu_ss.add(when: 'CONFIG_XILINX', if_true: files('xilinx_uartlite.c'))
+
+specific_ss.add(when: 'CONFIG_COLDFIRE', if_true: files('mcf_uart.c'))
+specific_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic-uart.c'))
+specific_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_uart.c'=
))
+specific_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_uart.c'))
+specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_vty.c'))
+specific_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_aux.c'))
+specific_ss.add(when: 'CONFIG_SH4', if_true: files('sh_serial.c'))
+specific_ss.add(when: 'CONFIG_STM32F2XX_USART', if_true: files('stm32f2xx_=
usart.c'))
+specific_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('terminal3270.=
c'))
+specific_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-serial-bus.c=
'))
diff --git a/hw/meson.build b/hw/meson.build
index 5850b07..d8a7493 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,3 +1,4 @@
+subdir('char')
 subdir('core')
 subdir('cpu')
 subdir('display')
--=20
1.8.3.1



