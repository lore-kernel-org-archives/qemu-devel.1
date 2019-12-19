Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F25C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:29:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA33824650
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h789WNHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA33824650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihuvP-00054F-6w
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:29:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihuqc-00077p-Mo
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihuqb-0005E6-D3
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:06 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31556
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihuqb-0005AR-7W
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SCLzfuY+upU1CWhWiYD8qNOLtnlvgBqRQqzkbyxW7WU=;
 b=h789WNHTGXe/ceRCpI57CU15KuoiblCerlZID3bxfZw/VXsBqYSjVs5+StzdydIkzs9Gwf
 AkaIZf653kh2rgJnjz+RdTgNfbSHWYLdYraH/caPA8ggiaewVKJfaeu7j1lau7wFRENvaP
 QLf4Y5xEHqq4e2jpWXPzsizh923FVDA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-FPKeTtasO36BxOBRe83e7A-1; Thu, 19 Dec 2019 07:24:01 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D13F800D41
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:24:00 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD3B860C18;
 Thu, 19 Dec 2019 12:23:58 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 093/132] meson: convert hw/gpio
Date: Thu, 19 Dec 2019 13:23:13 +0100
Message-Id: <1576758232-12439-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: FPKeTtasO36BxOBRe83e7A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 hw/gpio/Makefile.objs | 11 -----------
 hw/gpio/meson.build   | 11 +++++++++++
 hw/meson.build        |  1 +
 4 files changed, 12 insertions(+), 12 deletions(-)
 delete mode 100644 hw/gpio/Makefile.objs
 create mode 100644 hw/gpio/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 2ca159e..084bfc6 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -9,7 +9,6 @@ devices-dirs-y +=3D char/
 devices-dirs-y +=3D cpu/
 devices-dirs-y +=3D display/
 devices-dirs-y +=3D dma/
-devices-dirs-y +=3D gpio/
 endif
=20
 common-obj-y +=3D $(devices-dirs-y)
diff --git a/hw/gpio/Makefile.objs b/hw/gpio/Makefile.objs
deleted file mode 100644
index e5da0cb..0000000
--- a/hw/gpio/Makefile.objs
+++ /dev/null
@@ -1,11 +0,0 @@
-common-obj-$(CONFIG_MAX7310) +=3D max7310.o
-common-obj-$(CONFIG_PL061) +=3D pl061.o
-common-obj-$(CONFIG_PUV3) +=3D puv3_gpio.o
-common-obj-$(CONFIG_ZAURUS) +=3D zaurus.o
-common-obj-$(CONFIG_E500) +=3D mpc8xxx.o
-common-obj-$(CONFIG_GPIO_KEY) +=3D gpio_key.o
-
-obj-$(CONFIG_OMAP) +=3D omap_gpio.o
-obj-$(CONFIG_IMX) +=3D imx_gpio.o
-obj-$(CONFIG_RASPI) +=3D bcm2835_gpio.o
-obj-$(CONFIG_NRF51_SOC) +=3D nrf51_gpio.o
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
new file mode 100644
index 0000000..1d24a2d
--- /dev/null
+++ b/hw/gpio/meson.build
@@ -0,0 +1,11 @@
+softmmu_ss.add(when: 'CONFIG_E500', if_true: files('mpc8xxx.c'))
+softmmu_ss.add(when: 'CONFIG_GPIO_KEY', if_true: files('gpio_key.c'))
+softmmu_ss.add(when: 'CONFIG_MAX7310', if_true: files('max7310.c'))
+softmmu_ss.add(when: 'CONFIG_PL061', if_true: files('pl061.c'))
+softmmu_ss.add(when: 'CONFIG_PUV3', if_true: files('puv3_gpio.c'))
+softmmu_ss.add(when: 'CONFIG_ZAURUS', if_true: files('zaurus.c'))
+
+specific_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpio.c'))
+specific_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_gpio.c'))
+specific_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_gpio.c'))
+specific_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_gpio.c'))
diff --git a/hw/meson.build b/hw/meson.build
index bfd4d59..a61aeaf 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('gpio')
 subdir('hyperv')
 subdir('i2c')
 subdir('ide')
--=20
1.8.3.1



