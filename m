Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69141C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B0B420CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJ3gtYng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0B420CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVx4-0002hm-Al
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7R-0002zy-8x
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7P-0007Fd-Tw
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:45 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:38272)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV7P-0007Bk-EY
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:43 -0500
Received: by mail-wr1-x42e.google.com with SMTP id y17so17113534wrh.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=V7HQM6ZWCaBttTOQek/jXmWm+z3vGBaU4dKSv+ffCGg=;
 b=tJ3gtYngsrvJwfx0Sk0sabugYaQInlk8AUdNSLOVkF+h1OnJWcLss7ZejXMl8AVKd3
 x9UIHz2feTdWs1SlXlT2tntgiJsiohVuXvdqCBkLXoklOmxGA6BN7KYS3JOJPKmEuV4z
 bFBRmulM9fq0JRuHlcpuom0nuZu6OILLvsVmm5Zy2zPEKOObPmkd/Zw8f+I+gHMi4xDM
 OaH8etwLNkAHvwCVQIi8os2skL0z7yWzVTM/r2bE7e9eNnwe0UpmdC86EqPvOaWab1IW
 w4sVSkLD2z7IN3dK3KE6k6WKZ9MKOHiImyDP/W5l9YAifaNH/lSezZwuubfu/NeX4q+3
 d/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=V7HQM6ZWCaBttTOQek/jXmWm+z3vGBaU4dKSv+ffCGg=;
 b=mpsYZUz6SO+R6M0WS37NLDVGvAdJ5F/a76698kF/LK6gR8rjaTnGge84YhF9SQNgQC
 2UkihW7qxkYuXe9rA0mWg/7uHONZy39v9r9S90h9D7afkPMehdhHIOctOcOHtm1qngtm
 i8WjFquXwEQ7FakdjwPttmo6m2kXGAJ+iCi2S33ctT1IeqVffqYjlFURXHzSDFPT/5HR
 yqJ7IlyynwqR2deiPoDNbvUqaJEgybDCMoPiNmdBRR65byCfApRuPvQqbwQ1LuN7mMdl
 Ga+wmKwvOXADlbeLI1PK1ita7K2gucyKUwmM3+hFJ70e1mYtVwz3gyoIYvDCZspOozx9
 pbog==
X-Gm-Message-State: APjAAAX1XsHdsZ3mVD87TEjPEjnccjcXRudk8wMFcMZransjSQNJaIR/
 JFVZCGcxq5docwJ96YlOkzDggDCZ
X-Google-Smtp-Source: APXvYqzaqL2+n2+zkD6VSO9o0pmZ+t1zzRsNFYN122jVs1B8MwGDJgi5nQz3FCs94cFfWi8PNI69Aw==
X-Received: by 2002:adf:e40f:: with SMTP id g15mr29409067wrm.223.1580234261044; 
 Tue, 28 Jan 2020 09:57:41 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:57:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 099/142] meson: convert hw/i2c
Date: Tue, 28 Jan 2020 18:52:59 +0100
Message-Id: <20200128175342.9066-100-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
 hw/i2c/Makefile.objs | 13 -------------
 hw/i2c/meson.build   | 18 ++++++++++++++++++
 hw/meson.build       |  1 +
 4 files changed, 19 insertions(+), 14 deletions(-)
 delete mode 100644 hw/i2c/Makefile.objs
 create mode 100644 hw/i2c/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 545d7440b5..95c065d18f 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -10,7 +10,6 @@ devices-dirs-y += display/
 devices-dirs-y += dma/
 devices-dirs-y += gpio/
 devices-dirs-$(CONFIG_HYPERV) += hyperv/
-devices-dirs-$(CONFIG_I2C) += i2c/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
deleted file mode 100644
index d7073a401f..0000000000
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
index 0000000000..43901e6f24
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
index 4d7c31c652..983edc1d47 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('i2c')
 subdir('ide')
 subdir('input')
 subdir('intc')
-- 
2.21.0



