Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D430AC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:05:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C31821655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geY7uFeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C31821655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifP5R-0007lB-Bf
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 09:05:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNzD-0004r6-ED
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNzC-0008LT-6N
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:31 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:45876)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNzB-0008KP-Vl
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:30 -0500
Received: by mail-wr1-x42b.google.com with SMTP id j42so2575921wrj.12
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B1cIguF+o7g6L/Tvyh0nFkUMyH+9grlYA2KZIF+cBA4=;
 b=geY7uFeIqPwdnWVJB4L9Dv4jZTkjjclNvjhd69o7QsMqYgQSf7ENTefo708s3/vq2W
 XCDN5t6kJKETK+Rism0kpDW5/686u1t6KtFORxztskvs2qsZ6mtWV8nV6HNT82KZAiyX
 mO8rMY9CsH+j+ig73CpkgW5AGZgjPwcR0iazGUKNkgVmzkYJEa9c2aEMDpR9oFBWDYsQ
 bwfAFp69D/GF0+nucrw/XOPjd3nl1R62PLeF4M3xURfZkAiynTiSV5n5boIwhSZ9U6ss
 JLpeHoGGQ4FUdroFTfZ2fiusszDb2xv5KnxjtOx+6/AYDWRDxfKgKeOZmwU6TTKJSMCW
 dodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=B1cIguF+o7g6L/Tvyh0nFkUMyH+9grlYA2KZIF+cBA4=;
 b=Qk//csYL3hxzB0dc+4EgcbOFo4BGyDVSJyKWHWNRKh+WjiP/2sTQFpiG7qZ7bBraNK
 6jFDVO4MsjyeXdB3+09NpLS4V2YMKf3Uq3AuFYs4fAXmHB6lWj11uSJd0vVbajsbypZI
 uHokQwaAwn1aeDC93z42vKuQJG5zzhr3xhArGHTOmLlMLztnVoDkfz2h545Gc7faAJJF
 MMyYGUwZN0vLKStwwbEukDFLWDAQ1Ie8JDctozMkdGuo94nOtZ2YwlSnyn5BwWLNK66P
 uojE5obOaCYNmqLO1kB44HQXh/EKsg5aBQf3heaTem9wedglv8/L81y2feoS930f40+k
 84cw==
X-Gm-Message-State: APjAAAWTgDqwbcqOtqm4yEq7rR8b7Pxx4gp5b/6NSYXXwdhknLS0lZIg
 XMCLefHYCFScowNh3dsm30/WD2Ms
X-Google-Smtp-Source: APXvYqxfAP5NZHismulfhdGxUh2PJqm6OJch9DL64yNbwVND6yiZFiEY7jswLG2qOiHRPuUyDAkZ/A==
X-Received: by 2002:a5d:494b:: with SMTP id r11mr6275554wrs.184.1576155268658; 
 Thu, 12 Dec 2019 04:54:28 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 091/132] meson: convert hw/i2c
Date: Thu, 12 Dec 2019 13:52:15 +0100
Message-Id: <1576155176-2464-92-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
 hw/i2c/Makefile.objs | 13 -------------
 hw/i2c/meson.build   | 18 ++++++++++++++++++
 hw/meson.build       |  1 +
 4 files changed, 19 insertions(+), 14 deletions(-)
 delete mode 100644 hw/i2c/Makefile.objs
 create mode 100644 hw/i2c/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index b75e027..0213b1b 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -11,7 +11,6 @@ devices-dirs-y += display/
 devices-dirs-y += dma/
 devices-dirs-y += gpio/
 devices-dirs-$(CONFIG_HYPERV) += hyperv/
-devices-dirs-$(CONFIG_I2C) += i2c/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
deleted file mode 100644
index d7073a4..0000000
--- a/hw/i2c/Makefile.objs
+++ /dev/null
@@ -1,13 +0,0 @@
-common-obj-$(CONFIG_I2C) += core.o smbus_slave.o smbus_master.o
-common-obj-$(CONFIG_SMBUS_EEPROM) += smbus_eeprom.o
-common-obj-$(CONFIG_VERSATILE_I2C) += versatile_i2c.o
-common-obj-$(CONFIG_ACPI_X86_ICH) += smbus_ich9.o
-common-obj-$(CONFIG_ACPI_SMBUS) += pm_smbus.o
-common-obj-$(CONFIG_BITBANG_I2C) += bitbang_i2c.o
-common-obj-$(CONFIG_EXYNOS4) += exynos4210_i2c.o
-common-obj-$(CONFIG_IMX_I2C) += imx_i2c.o
-common-obj-$(CONFIG_ASPEED_SOC) += aspeed_i2c.o
-common-obj-$(CONFIG_NRF51_SOC) += microbit_i2c.o
-common-obj-$(CONFIG_MPC_I2C) += mpc_i2c.o
-obj-$(CONFIG_OMAP) += omap_i2c.o
-obj-$(CONFIG_PPC4XX) += ppc4xx_i2c.o
diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
new file mode 100644
index 0000000..43901e6
--- /dev/null
+++ b/hw/i2c/meson.build
@@ -0,0 +1,18 @@
+i2c_ss = ss.source_set()
+i2c_ss.add(when: 'CONFIG_ACPI_SMBUS', if_true: files('pm_smbus.c'))
+i2c_ss.add(when: 'CONFIG_ACPI_X86_ICH', if_true: files('smbus_ich9.c'))
+i2c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i2c.c'))
+i2c_ss.add(when: 'CONFIG_BITBANG_I2C', if_true: files('bitbang_i2c.c'))
+i2c_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_i2c.c'))
+i2c_ss.add(when: 'CONFIG_I2C', if_true: files('core.c', 'smbus_slave.c', 'smbus_master.c'))
+i2c_ss.add(when: 'CONFIG_IMX_I2C', if_true: files('imx_i2c.c'))
+i2c_ss.add(when: 'CONFIG_MPC_I2C', if_true: files('mpc_i2c.c'))
+i2c_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('microbit_i2c.c'))
+i2c_ss.add(when: 'CONFIG_SMBUS_EEPROM', if_true: files('smbus_eeprom.c'))
+i2c_ss.add(when: 'CONFIG_VERSATILE_I2C', if_true: files('versatile_i2c.c'))
+softmmu_ss.add_all(when: 'CONFIG_I2C', if_true: i2c_ss)
+
+specific_i2c_ss = ss.source_set()
+specific_i2c_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_i2c.c'))
+specific_i2c_ss.add(when: 'CONFIG_PPC4XX', if_true: files('ppc4xx_i2c.c'))
+specific_ss.add_all(when: 'CONFIG_I2C', if_true: specific_i2c_ss)
diff --git a/hw/meson.build b/hw/meson.build
index 848736d..e59ed44 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('i2c')
 subdir('ide')
 subdir('input')
 subdir('intc')
-- 
1.8.3.1



