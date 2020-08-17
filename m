Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90AEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6931E23A1D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRVTEzXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6931E23A1D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7h3Z-0004ax-Hj
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gKR-0002sC-Tu
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:41:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36572
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gKN-0006qX-G1
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597675294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2uZT/s+uo12wT2bnnDViCCQzfljp43iiPWFYn7ZUdE0=;
 b=fRVTEzXZTDEkDOYloa60gGZTzVkpW7Z22RG55oUohzqPApkQtYd+a47WNB2KV7+SVY0KS6
 WB/h3CDdOS030YPs3yHQWQyMGp6zwfT5EV0/12xOsiL0vQ1mITJNMP9CWNXsJ+X+IjWXUw
 +dJKcNzpXfyri7PdaksFmCzi3xGbvps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-tyh3QHmONhaDZFUFaTE9Mw-1; Mon, 17 Aug 2020 10:41:32 -0400
X-MC-Unique: tyh3QHmONhaDZFUFaTE9Mw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B438381F001;
 Mon, 17 Aug 2020 14:41:31 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F795756AB;
 Mon, 17 Aug 2020 14:41:30 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 114/150] meson: convert hw/i2c
Date: Mon, 17 Aug 2020 16:40:17 +0200
Message-Id: <20200817144053.345107-19-pbonzini@redhat.com>
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:13:21
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Corey Minyard <cminyard@mvista.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Makefile.objs     |  1 -
 hw/i2c/Makefile.objs | 14 --------------
 hw/i2c/meson.build   | 16 ++++++++++++++++
 hw/meson.build       |  1 +
 4 files changed, 17 insertions(+), 15 deletions(-)
 delete mode 100644 hw/i2c/Makefile.objs
 create mode 100644 hw/i2c/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 02c5c0d94e..22eb804730 100644
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
index f2c61eaa8b..0000000000
--- a/hw/i2c/Makefile.objs
+++ /dev/null
@@ -1,14 +0,0 @@
-common-obj-$(CONFIG_I2C) += core.o
-common-obj-$(CONFIG_SMBUS) += smbus_slave.o smbus_master.o
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
-common-obj-$(CONFIG_OMAP) += omap_i2c.o
-common-obj-$(CONFIG_PPC4XX) += ppc4xx_i2c.o
diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
new file mode 100644
index 0000000000..3a511539ad
--- /dev/null
+++ b/hw/i2c/meson.build
@@ -0,0 +1,16 @@
+i2c_ss = ss.source_set()
+i2c_ss.add(when: 'CONFIG_I2C', if_true: files('core.c'))
+i2c_ss.add(when: 'CONFIG_SMBUS', if_true: files('smbus_slave.c', 'smbus_master.c'))
+i2c_ss.add(when: 'CONFIG_ACPI_SMBUS', if_true: files('pm_smbus.c'))
+i2c_ss.add(when: 'CONFIG_ACPI_X86_ICH', if_true: files('smbus_ich9.c'))
+i2c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i2c.c'))
+i2c_ss.add(when: 'CONFIG_BITBANG_I2C', if_true: files('bitbang_i2c.c'))
+i2c_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_i2c.c'))
+i2c_ss.add(when: 'CONFIG_IMX_I2C', if_true: files('imx_i2c.c'))
+i2c_ss.add(when: 'CONFIG_MPC_I2C', if_true: files('mpc_i2c.c'))
+i2c_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('microbit_i2c.c'))
+i2c_ss.add(when: 'CONFIG_SMBUS_EEPROM', if_true: files('smbus_eeprom.c'))
+i2c_ss.add(when: 'CONFIG_VERSATILE_I2C', if_true: files('versatile_i2c.c'))
+i2c_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_i2c.c'))
+i2c_ss.add(when: 'CONFIG_PPC4XX', if_true: files('ppc4xx_i2c.c'))
+softmmu_ss.add_all(when: 'CONFIG_I2C', if_true: i2c_ss)
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
2.26.2



