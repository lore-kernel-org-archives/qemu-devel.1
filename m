Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC79C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3726523442
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAcJidLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3726523442
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gzw-0005dg-4T
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gJu-0001qT-5D
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:41:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gJs-0006nd-7W
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597675262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0H/PbuCy1aEOaKCgJR+ud8u9tQH9sGL3dOMQQTQs3A=;
 b=SAcJidLyVSnwWm3MaeYiPntbnV04XLv2CfqI07J8a+yMUbmPiupc+Mm+oDNaP8hSHMlGq4
 MmcVNJRs8oor4LUNZOSV5K9f+KzDpEsCDyOakWOzKXI0gaAjZYyQQibuhsA5xGTPWj8FD1
 SUBCBchQ0tNRMDEbVv/J4u5UZzD06YQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-BJ8Z-wcAN82cmYGD1N-nnA-1; Mon, 17 Aug 2020 10:41:00 -0400
X-MC-Unique: BJ8Z-wcAN82cmYGD1N-nnA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01C8A100CEC1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 14:41:00 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 498DD756AB;
 Mon, 17 Aug 2020 14:40:59 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 098/150] meson: convert hw/sd
Date: Mon, 17 Aug 2020 16:40:01 +0200
Message-Id: <20200817144053.345107-3-pbonzini@redhat.com>
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 01:24:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 hw/Makefile.objs    |  1 -
 hw/meson.build      |  1 +
 hw/sd/Makefile.objs | 12 ------------
 hw/sd/meson.build   | 12 ++++++++++++
 4 files changed, 13 insertions(+), 13 deletions(-)
 delete mode 100644 hw/sd/Makefile.objs
 create mode 100644 hw/sd/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index e50eb04635..6f9c0b7983 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -25,7 +25,6 @@ devices-dirs-y += pci/
 devices-dirs-$(CONFIG_PCI) += pci-bridge/ pci-host/
 devices-dirs-y += pcmcia/
 devices-dirs-$(CONFIG_SCSI) += scsi/
-devices-dirs-y += sd/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 75644266f2..a73f4aebde 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -2,6 +2,7 @@ subdir('core')
 subdir('mem')
 subdir('nubus')
 subdir('rtc')
+subdir('sd')
 subdir('semihosting')
 subdir('smbios')
 subdir('ssi')
diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
deleted file mode 100644
index 0d1df1721c..0000000000
--- a/hw/sd/Makefile.objs
+++ /dev/null
@@ -1,12 +0,0 @@
-common-obj-$(CONFIG_PL181) += pl181.o
-common-obj-$(CONFIG_SSI_SD) += ssi-sd.o
-common-obj-$(CONFIG_SD) += sd.o core.o sdmmc-internal.o
-common-obj-$(CONFIG_SDHCI) += sdhci.o
-common-obj-$(CONFIG_SDHCI_PCI) += sdhci-pci.o
-
-common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-sdhost.o
-common-obj-$(CONFIG_MILKYMIST) += milkymist-memcard.o
-common-obj-$(CONFIG_OMAP) += omap_mmc.o
-common-obj-$(CONFIG_PXA2XX) += pxa2xx_mmci.o
-common-obj-$(CONFIG_RASPI) += bcm2835_sdhost.o
-common-obj-$(CONFIG_ASPEED_SOC) += aspeed_sdhci.o
diff --git a/hw/sd/meson.build b/hw/sd/meson.build
new file mode 100644
index 0000000000..b43e59bd00
--- /dev/null
+++ b/hw/sd/meson.build
@@ -0,0 +1,12 @@
+softmmu_ss.add(when: 'CONFIG_PL181', if_true: files('pl181.c'))
+softmmu_ss.add(when: 'CONFIG_SD', if_true: files('sd.c', 'core.c', 'sdmmc-internal.c'))
+softmmu_ss.add(when: 'CONFIG_SDHCI', if_true: files('sdhci.c'))
+softmmu_ss.add(when: 'CONFIG_SDHCI_PCI', if_true: files('sdhci-pci.c'))
+softmmu_ss.add(when: 'CONFIG_SSI_SD', if_true: files('ssi-sd.c'))
+
+softmmu_ss.add(when: 'CONFIG_MILKYMIST', if_true: files('milkymist-memcard.c'))
+softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_mmc.c'))
+softmmu_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx_mmci.c'))
+softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_sdhost.c'))
+softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sdhci.c'))
+softmmu_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-sdhost.c'))
-- 
2.26.2



