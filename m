Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38424C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:10:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E883A2074D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXeCrQoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E883A2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Wfb-0004Wz-0C
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 06:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vnd-0007eV-Aj
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30286
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vna-00038f-U8
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ODJdNdWjjNTd8b4kfugM0UtLCKBeocnqITNVNdo3kn8=;
 b=LXeCrQoyYHgdxiZQPsUQ9tAuJ437GnQY/WC9OfWildtVnuwF4fPhB8NecD2q39JDUaXr2i
 T6z06TBUiiILdcTQJDRz6QmyOc/zMczwaouBSuruP0zGedmNu/sF4/h2eEZNhg+lXV8Tzu
 nUTFM98j5mJ8w6/OHc4NNK3X6basKh0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-SLxUOJ2xMEGw51_WmoubTg-1; Fri, 14 Aug 2020 05:14:51 -0400
X-MC-Unique: SLxUOJ2xMEGw51_WmoubTg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B41959
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:14:50 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2773269C9D;
 Fri, 14 Aug 2020 09:14:50 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 117/150] meson: convert hw/gpio
Date: Fri, 14 Aug 2020 05:12:53 -0400
Message-Id: <20200814091326.16173-118-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 05:13:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 hw/gpio/Makefile.objs | 12 ------------
 hw/gpio/meson.build   | 12 ++++++++++++
 hw/meson.build        |  1 +
 4 files changed, 13 insertions(+), 13 deletions(-)
 delete mode 100644 hw/gpio/Makefile.objs
 create mode 100644 hw/gpio/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index a2c2f6d1de..c04dfe589c 100644
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
index 3cfc261f9b..0000000000
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
-common-obj-$(CONFIG_OMAP) += omap_gpio.o
-common-obj-$(CONFIG_IMX) += imx_gpio.o
-common-obj-$(CONFIG_RASPI) += bcm2835_gpio.o
-common-obj-$(CONFIG_NRF51_SOC) += nrf51_gpio.o
-common-obj-$(CONFIG_ASPEED_SOC) += aspeed_gpio.o
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
new file mode 100644
index 0000000000..6bcdfa6b1d
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
+softmmu_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpio.c'))
+softmmu_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_gpio.c'))
+softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_gpio.c'))
+softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_gpio.c'))
+softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
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
2.26.2



