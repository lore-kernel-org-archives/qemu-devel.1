Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD5AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D332221E2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XE/xhsmB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D332221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3m9r-00040l-K8
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 16:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lQq-0002C7-4n
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:20:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42919
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lQn-0006qJ-Mi
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zO4e7K01MHJ7AGB+vRclaGY++76QE/unXSxoCHpUo6s=;
 b=XE/xhsmBZBdBNzzbTNKz5jHFXsC2oUplBIktJ0AvZuIoolG0k/SY1GLlP4EVXZr8WPxvMF
 4sXaPOH/n/AXinPCCqsxcjJDYgT/+ns/qUew9Baufvdmk2TT+fsQEZMidJVi+inDSvyShz
 Rn8gmFnK3rqZXdHMHGciYAwL80QO7Ag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-M8sd7BP_NTGWG61CItNd_w-1; Thu, 06 Aug 2020 15:19:58 -0400
X-MC-Unique: M8sd7BP_NTGWG61CItNd_w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41FA08014C1
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:19:57 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A28D25FC3B;
 Thu,  6 Aug 2020 19:19:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 117/143] meson: convert hw/char
Date: Thu,  6 Aug 2020 21:15:53 +0200
Message-Id: <1596741379-12902-118-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 05:03:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Makefile.objs      |  1 -
 hw/char/Makefile.objs | 39 ---------------------------------------
 hw/char/meson.build   | 38 ++++++++++++++++++++++++++++++++++++++
 hw/meson.build        |  1 +
 4 files changed, 39 insertions(+), 40 deletions(-)
 delete mode 100644 hw/char/Makefile.objs
 create mode 100644 hw/char/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 97ad302..04cfb6c 100644
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
index bf177ac..0000000
--- a/hw/char/Makefile.objs
+++ /dev/null
@@ -1,39 +0,0 @@
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
-common-obj-$(CONFIG_IBEX) += ibex_uart.o
-
-common-obj-$(CONFIG_EXYNOS4) += exynos4210_uart.o
-common-obj-$(CONFIG_COLDFIRE) += mcf_uart.o
-common-obj-$(CONFIG_OMAP) += omap_uart.o
-common-obj-$(CONFIG_SH4) += sh_serial.o
-common-obj-$(CONFIG_DIGIC) += digic-uart.o
-common-obj-$(CONFIG_STM32F2XX_USART) += stm32f2xx_usart.o
-common-obj-$(CONFIG_RASPI) += bcm2835_aux.o
-common-obj-$(CONFIG_RENESAS_SCI) += renesas_sci.o
-common-obj-$(CONFIG_AVR_USART) += avr_usart.o
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
-obj-$(CONFIG_PSERIES) += spapr_vty.o
-obj-$(CONFIG_TERMINAL3270) += terminal3270.o
diff --git a/hw/char/meson.build b/hw/char/meson.build
new file mode 100644
index 0000000..e888215
--- /dev/null
+++ b/hw/char/meson.build
@@ -0,0 +1,38 @@
+softmmu_ss.add(when: 'CONFIG_CADENCE', if_true: files('cadence_uart.c'))
+softmmu_ss.add(when: 'CONFIG_CMSDK_APB_UART', if_true: files('cmsdk-apb-uart.c'))
+softmmu_ss.add(when: 'CONFIG_ESCC', if_true: files('escc.c'))
+softmmu_ss.add(when: 'CONFIG_ETRAXFS', if_true: files('etraxfs_ser.c'))
+softmmu_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_apbuart.c'))
+softmmu_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_uart.c'))
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
+softmmu_ss.add(when: 'CONFIG_AVR_USART', if_true: files('avr_usart.c'))
+softmmu_ss.add(when: 'CONFIG_COLDFIRE', if_true: files('mcf_uart.c'))
+softmmu_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic-uart.c'))
+softmmu_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_uart.c'))
+softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_uart.c'))
+softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_aux.c'))
+softmmu_ss.add(when: 'CONFIG_RENESAS_SCI', if_true: files('renesas_sci.c'))
+softmmu_ss.add(when: 'CONFIG_SH4', if_true: files('sh_serial.c'))
+softmmu_ss.add(when: 'CONFIG_STM32F2XX_USART', if_true: files('stm32f2xx_usart.c'))
+
+specific_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('terminal3270.c'))
+specific_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-serial-bus.c'))
+specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_vty.c'))
diff --git a/hw/meson.build b/hw/meson.build
index 103da48..dd0c77e 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,3 +1,4 @@
+subdir('char')
 subdir('core')
 subdir('cpu')
 subdir('display')
-- 
1.8.3.1



