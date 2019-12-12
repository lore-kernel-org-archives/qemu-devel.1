Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7FAC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:47:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A70262077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eA4fCgYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70262077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOo0-0002C2-MU
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:47:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyw-0004Oq-5j
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyu-0007rt-LB
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:14 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:37696)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyu-0007qZ-DW
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:12 -0500
Received: by mail-wr1-x436.google.com with SMTP id w15so2627269wru.4
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yXQbJKsvQk7oYU4KlgfGRW1DYvBILSdETOHeXV/ZcBk=;
 b=eA4fCgYsbDn5WshczUK/HB7vxAdbF5kfSLKk29e3VQX8jEjcU+THyBWH8JSQKjdgZj
 3gk4w1KlIIwjrD90XOsoGpgnDNHAAiSp2IpK1L5OkZ8KH9KMgkDApYsmWsWYTuExt/j/
 xXiSCd9PDQb5UL5wsogcs6rykus553SwNNQc6kelzBDKiERo+t/ac2sDK2HkU5j7xS6T
 LuTG3g9jAmEjuj1UYrrpeWUIyD13XfQcg/iSFayJU9XhDousxN3CjGnTYWe4o+n8nWWX
 ExVzqA7/LS+8RjZRH9kVrfBgkd30JStLPUkDe3fP1VQ0KKR0puR3/Od1bwnl9EWKrDGF
 C3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=yXQbJKsvQk7oYU4KlgfGRW1DYvBILSdETOHeXV/ZcBk=;
 b=ClC1P9wIkgu9V31eCqkm3NLvOujAb0FrMDfVbprKymMxvQdmmg7po4wWLL8SbMrMLE
 i+41KvNuzbcY+LJZKgHYRt5OgCbnBQs5Vv3e1/v8y9Ca4GMvmkrDK/u2+9N5BcIyq/AA
 ivIL1jJHeC+Qhcsqr1TpOZ9olNAgCdC/f6zSaHtgITc3bd+HShQcnIjLowhADBHesR5T
 ao+Ma7hIB3eoAh+V5RIUaRwZ7CVL9yrAo1LgnrsE9b4DCvW3zH9JSDpEwrWIpZkJuZdK
 0w0YsPKsWPavbxEYSOfRsv34PQnARfyphCsrvtA3RglQBgtD5jfd3sEMUUtLjfQ67qUz
 Vk0A==
X-Gm-Message-State: APjAAAWxKJ1pH9CinfMEVMi7wLQxIsQpFtMrvoWKdRmvkbxaZvDF0gcu
 7BQ/3Tej2ex5vnMrn9izbDHtTRb1
X-Google-Smtp-Source: APXvYqzZFA2cbfILZ0V7dqEr89xknJm/YKmcImxw7iWsKLY/rjl07OrvuqjZy5oonJfpDFqNH//KIA==
X-Received: by 2002:adf:e3d0:: with SMTP id k16mr6303203wrm.241.1576155251115; 
 Thu, 12 Dec 2019 04:54:11 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 073/132] meson: convert hw/timer
Date: Thu, 12 Dec 2019 13:51:57 +0100
Message-Id: <1576155176-2464-74-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
 hw/meson.build         |  1 +
 hw/timer/Makefile.objs | 49 -------------------------------------------------
 hw/timer/meson.build   | 43 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 50 deletions(-)
 delete mode 100644 hw/timer/Makefile.objs
 create mode 100644 hw/timer/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 6529617..1d47113 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -28,7 +28,6 @@ devices-dirs-y += pcmcia/
 devices-dirs-$(CONFIG_SCSI) += scsi/
 devices-dirs-y += sd/
 devices-dirs-y += ssi/
-devices-dirs-y += timer/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 4e918d0..960fd14 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -2,6 +2,7 @@ subdir('core')
 subdir('mem')
 subdir('semihosting')
 subdir('smbios')
+subdir('timer')
 subdir('tpm')
 subdir('usb')
 subdir('vfio')
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
deleted file mode 100644
index 123d92c..0000000
--- a/hw/timer/Makefile.objs
+++ /dev/null
@@ -1,49 +0,0 @@
-common-obj-$(CONFIG_ARM_TIMER) += arm_timer.o
-common-obj-$(CONFIG_ARM_MPTIMER) += arm_mptimer.o
-common-obj-$(CONFIG_ARM_V7M) += armv7m_systick.o
-common-obj-$(CONFIG_A9_GTIMER) += a9gtimer.o
-common-obj-$(CONFIG_CADENCE) += cadence_ttc.o
-common-obj-$(CONFIG_DS1338) += ds1338.o
-common-obj-$(CONFIG_HPET) += hpet.o
-common-obj-$(CONFIG_I8254) += i8254_common.o i8254.o
-common-obj-$(CONFIG_M41T80) += m41t80.o
-common-obj-$(CONFIG_M48T59) += m48t59.o
-ifeq ($(CONFIG_ISA_BUS),y)
-common-obj-$(CONFIG_M48T59) += m48t59-isa.o
-endif
-common-obj-$(CONFIG_PL031) += pl031.o
-common-obj-$(CONFIG_PUV3) += puv3_ost.o
-common-obj-$(CONFIG_TWL92230) += twl92230.o
-common-obj-$(CONFIG_XILINX) += xilinx_timer.o
-common-obj-$(CONFIG_SLAVIO) += slavio_timer.o
-common-obj-$(CONFIG_ETRAXFS) += etraxfs_timer.o
-common-obj-$(CONFIG_GRLIB) += grlib_gptimer.o
-common-obj-$(CONFIG_IMX) += imx_epit.o
-common-obj-$(CONFIG_IMX) += imx_gpt.o
-common-obj-$(CONFIG_LM32) += lm32_timer.o
-common-obj-$(CONFIG_MILKYMIST) += milkymist-sysctl.o
-common-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp-rtc.o
-common-obj-$(CONFIG_NRF51_SOC) += nrf51_timer.o
-
-obj-$(CONFIG_ALTERA_TIMER) += altera_timer.o
-obj-$(CONFIG_EXYNOS4) += exynos4210_mct.o
-obj-$(CONFIG_EXYNOS4) += exynos4210_pwm.o
-obj-$(CONFIG_EXYNOS4) += exynos4210_rtc.o
-obj-$(CONFIG_OMAP) += omap_gptimer.o
-obj-$(CONFIG_OMAP) += omap_synctimer.o
-obj-$(CONFIG_PXA2XX) += pxa2xx_timer.o
-obj-$(CONFIG_SH4) += sh_timer.o
-obj-$(CONFIG_DIGIC) += digic-timer.o
-obj-$(CONFIG_MIPS_CPS) += mips_gictimer.o
-
-obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
-
-obj-$(CONFIG_ALLWINNER_A10_PIT) += allwinner-a10-pit.o
-
-common-obj-$(CONFIG_STM32F2XX_TIMER) += stm32f2xx_timer.o
-common-obj-$(CONFIG_ASPEED_SOC) += aspeed_timer.o aspeed_rtc.o
-
-common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
-common-obj-$(CONFIG_CMSDK_APB_TIMER) += cmsdk-apb-timer.o
-common-obj-$(CONFIG_CMSDK_APB_DUALTIMER) += cmsdk-apb-dualtimer.o
-common-obj-$(CONFIG_MSF2) += mss-timer.o
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
new file mode 100644
index 0000000..5162b9b
--- /dev/null
+++ b/hw/timer/meson.build
@@ -0,0 +1,43 @@
+softmmu_ss.add(when: 'CONFIG_A9_GTIMER', if_true: files('a9gtimer.c'))
+softmmu_ss.add(when: 'CONFIG_ARM_MPTIMER', if_true: files('arm_mptimer.c'))
+softmmu_ss.add(when: 'CONFIG_ARM_TIMER', if_true: files('arm_timer.c'))
+softmmu_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_systick.c'))
+softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_rtc.c', 'aspeed_timer.c'))
+softmmu_ss.add(when: 'CONFIG_CADENCE', if_true: files('cadence_ttc.c'))
+softmmu_ss.add(when: 'CONFIG_CMSDK_APB_DUALTIMER', if_true: files('cmsdk-apb-dualtimer.c'))
+softmmu_ss.add(when: 'CONFIG_CMSDK_APB_TIMER', if_true: files('cmsdk-apb-timer.c'))
+softmmu_ss.add(when: 'CONFIG_DS1338', if_true: files('ds1338.c'))
+softmmu_ss.add(when: 'CONFIG_ETRAXFS', if_true: files('etraxfs_timer.c'))
+softmmu_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_gptimer.c'))
+softmmu_ss.add(when: 'CONFIG_HPET', if_true: files('hpet.c'))
+softmmu_ss.add(when: 'CONFIG_I8254', if_true: files('i8254_common.c', 'i8254.c'))
+softmmu_ss.add(when: 'CONFIG_IMX', if_true: files('imx_epit.c'))
+softmmu_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpt.c'))
+softmmu_ss.add(when: 'CONFIG_LM32', if_true: files('lm32_timer.c'))
+softmmu_ss.add(when: 'CONFIG_M41T80', if_true: files('m41t80.c'))
+softmmu_ss.add(when: 'CONFIG_M48T59', if_true: files('m48t59.c'))
+softmmu_ss.add(when: 'CONFIG_MILKYMIST', if_true: files('milkymist-sysctl.c'))
+softmmu_ss.add(when: 'CONFIG_MSF2', if_true: files('mss-timer.c'))
+softmmu_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_timer.c'))
+softmmu_ss.add(when: 'CONFIG_PL031', if_true: files('pl031.c'))
+softmmu_ss.add(when: 'CONFIG_PUV3', if_true: files('puv3_ost.c'))
+softmmu_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_timer.c'))
+softmmu_ss.add(when: 'CONFIG_STM32F2XX_TIMER', if_true: files('stm32f2xx_timer.c'))
+softmmu_ss.add(when: 'CONFIG_SUN4V_RTC', if_true: files('sun4v-rtc.c'))
+softmmu_ss.add(when: 'CONFIG_TWL92230', if_true: files('twl92230.c'))
+softmmu_ss.add(when: 'CONFIG_XILINX', if_true: files('xilinx_timer.c'))
+softmmu_ss.add(when: 'CONFIG_XLNX_ZYNQMP', if_true: files('xlnx-zynqmp-rtc.c'))
+softmmu_ss.add(when: ['CONFIG_ISA_BUS', 'CONFIG_M48T59'], if_true: files('m48t59-isa.c'))
+
+specific_ss.add(when: 'CONFIG_ALLWINNER_A10_PIT', if_true: files('allwinner-a10-pit.c'))
+specific_ss.add(when: 'CONFIG_ALTERA_TIMER', if_true: files('altera_timer.c'))
+specific_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic-timer.c'))
+specific_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_mct.c'))
+specific_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pwm.c'))
+specific_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_rtc.c'))
+specific_ss.add(when: 'CONFIG_MC146818RTC', if_true: files('mc146818rtc.c'))
+specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_gictimer.c'))
+specific_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_gptimer.c'))
+specific_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_synctimer.c'))
+specific_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx_timer.c'))
+specific_ss.add(when: 'CONFIG_SH4', if_true: files('sh_timer.c'))
-- 
1.8.3.1



