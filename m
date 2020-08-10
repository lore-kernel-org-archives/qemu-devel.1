Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612E1C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E559207DA
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P06Xqb7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E559207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5BoC-00050t-8k
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BKz-0001vz-44
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:11:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41961
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BKx-0003Cy-3t
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yb4SZnldMsHJs48ssbsPr5n2+3G0FQv6iEnjmcqKyLY=;
 b=P06Xqb7MSCgWuWmPYtunNgHSGxHj85YUtOnAMroyxxNhuBROaogI+CL3A/yCLVbGzTZYxW
 m5mj6aXWcumwzJGo5X5c5rwcV9Lt0Wo8CpMUbHn8M6A3/JJBSB0OKj7yyWh+wkOTqs3jmW
 QV+FtUdEe9mtiejDYeT+rZFBpmohD9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-h1ysMm6kPcWvK4mk8a7jFg-1; Mon, 10 Aug 2020 13:11:48 -0400
X-MC-Unique: h1ysMm6kPcWvK4mk8a7jFg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1C1A107ACCA
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:11:47 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0AF285F1E9;
 Mon, 10 Aug 2020 17:11:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 095/147] meson: convert hw/ssi
Date: Mon, 10 Aug 2020 19:08:13 +0200
Message-Id: <1597079345-42801-96-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:29:25
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
 hw/Makefile.objs     |  1 -
 hw/meson.build       |  1 +
 hw/ssi/Makefile.objs | 10 ----------
 hw/ssi/meson.build   |  9 +++++++++
 4 files changed, 10 insertions(+), 11 deletions(-)
 delete mode 100644 hw/ssi/Makefile.objs
 create mode 100644 hw/ssi/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index f60fd01..e50eb04 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -26,7 +26,6 @@ devices-dirs-$(CONFIG_PCI) += pci-bridge/ pci-host/
 devices-dirs-y += pcmcia/
 devices-dirs-$(CONFIG_SCSI) += scsi/
 devices-dirs-y += sd/
-devices-dirs-y += ssi/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 1fb1687..7564426 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -4,6 +4,7 @@ subdir('nubus')
 subdir('rtc')
 subdir('semihosting')
 subdir('smbios')
+subdir('ssi')
 subdir('timer')
 subdir('tpm')
 subdir('usb')
diff --git a/hw/ssi/Makefile.objs b/hw/ssi/Makefile.objs
deleted file mode 100644
index 07a85f1..0000000
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
-common-obj-$(CONFIG_OMAP) += omap_spi.o
-common-obj-$(CONFIG_IMX) += imx_spi.o
diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
new file mode 100644
index 0000000..f1f5c28
--- /dev/null
+++ b/hw/ssi/meson.build
@@ -0,0 +1,9 @@
+softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_smc.c'))
+softmmu_ss.add(when: 'CONFIG_MSF2', if_true: files('mss-spi.c'))
+softmmu_ss.add(when: 'CONFIG_PL022', if_true: files('pl022.c'))
+softmmu_ss.add(when: 'CONFIG_SSI', if_true: files('ssi.c'))
+softmmu_ss.add(when: 'CONFIG_STM32F2XX_SPI', if_true: files('stm32f2xx_spi.c'))
+softmmu_ss.add(when: 'CONFIG_XILINX_SPI', if_true: files('xilinx_spi.c'))
+softmmu_ss.add(when: 'CONFIG_XILINX_SPIPS', if_true: files('xilinx_spips.c'))
+softmmu_ss.add(when: 'CONFIG_IMX', if_true: files('imx_spi.c'))
+softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_spi.c'))
-- 
1.8.3.1



