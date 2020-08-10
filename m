Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40AAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 958F020866
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHAa0ys9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958F020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5C1i-0005D2-Ol
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BL0-0001z7-GY
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:11:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20990
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BKy-0003DF-H5
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2GnJE8/7S2X2Uk5TiW2ODDJsajZPMmPTCwYS7sDXl8o=;
 b=BHAa0ys9a3MXbu+pdKJnD5qyCvQlZ7pVA8t4WM7Gg8XFkYXCfv6lDK3RJkUWnCFP2ZVRYZ
 PlsTscQCGhkb7JKSUU6rn02hdWmPwWLxoXIb54SFitLwMwXtOoYHK1SuokO8zgj+aaCzLk
 I23kqAL+5wKQdKa1FLrM2n8apA/oxO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-9kY5HhFqMXm2Yz-OSI232Q-1; Mon, 10 Aug 2020 13:11:50 -0400
X-MC-Unique: 9kY5HhFqMXm2Yz-OSI232Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D1EB19067E0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:11:49 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 697D25F1EA;
 Mon, 10 Aug 2020 17:11:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 096/147] meson: convert hw/sd
Date: Mon, 10 Aug 2020 19:08:14 +0200
Message-Id: <1597079345-42801-97-git-send-email-pbonzini@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 04:13:00
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
 hw/Makefile.objs    |  1 -
 hw/meson.build      |  1 +
 hw/sd/Makefile.objs | 12 ------------
 hw/sd/meson.build   | 12 ++++++++++++
 4 files changed, 13 insertions(+), 13 deletions(-)
 delete mode 100644 hw/sd/Makefile.objs
 create mode 100644 hw/sd/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index e50eb04..6f9c0b7 100644
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
index 7564426..a73f4ae 100644
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
index 0d1df17..0000000
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
index 0000000..b43e59b
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
1.8.3.1



