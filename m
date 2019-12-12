Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3C1C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 694FF2077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLIx+6/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694FF2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOp3-000350-EJ
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyx-0004RS-ON
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyw-0007vW-Iu
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:15 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:42367)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyw-0007u8-Bp
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:14 -0500
Received: by mail-wr1-x42c.google.com with SMTP id q6so2584853wro.9
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=STEo9GpQKwUedfVo2QZeziTyW5VyS+cRQws0nwVdfdo=;
 b=rLIx+6/7wQtQbIIsVCFhNKlfjct2/7ZL9Kv1Jd4zSnlyQ103skp5mj565ZGwEyt16M
 5hDBQNzVoZaLgbTOwmuvyqcvbL06B6VtKlahqPTO1FI8U99qVlJntJIlj7SYw0x4htWl
 mqDYMxaxdvD229mq/+cmAEsEUFO0jNc20QkXKYmwGRH2DJPBfGGgcfXdVUWNFgNFZbk2
 1b/zsvt+K5baD0xmHXWnKNGgYuWDh1Q4tdjNw/X0CCkwFgi+EqonmQZtC0lkU90MVIbt
 UxDorWqOCs1H9UMmHu9fgFGsT494D2xfAq5qPco7ipRwWzfKL1J/R39Xbx51IIW9J7ef
 zhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=STEo9GpQKwUedfVo2QZeziTyW5VyS+cRQws0nwVdfdo=;
 b=tNBKxWudYC4PgiKK1Ze9xGzhMVJpcq5raOCiE4oMCbE2xUIkhJLoGgAZD4vPKhA9VW
 xXK1NKEnqsiKbxBnjVV5GxpDwagBlHPLz6/QbYyDzGwTt7A/1cF2tg6HYpVxr5TbI9E2
 k4reO2excjJwruBpEZDIjBPopi61UPlX/WRtnluvW3vZ1SdiU5RJS8c5mdKLZ1/BKxgU
 bd3ny6M+6Ys7RF4p0FT4q+9Pji3OHI6ox2Pd3uEXtbO8DDfA3VMNdVTLgUFRx4BaYG/P
 Y6k7EfghX3185OL2AcBSyDzbSgtXyfbFZyat8+6VBzE0EHjmE4IToYNqI/KctdoDIPU/
 U+XQ==
X-Gm-Message-State: APjAAAVCUAj58/tGct+urm6sb2dyryb1QLpjGYIOA8cxnbftbFjW/CNt
 WPCzmJ40AJ+/xtNrtkAFyowCWJtx
X-Google-Smtp-Source: APXvYqypoulI1wFnNv3bk9KDqQ7Vvb/Udh1ebsxSiJKTickJckhOwEpM4T0lxSwFsv73oJuoMQyj7g==
X-Received: by 2002:adf:a141:: with SMTP id r1mr6259963wrr.285.1576155253143; 
 Thu, 12 Dec 2019 04:54:13 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 075/132] meson: convert hw/sd
Date: Thu, 12 Dec 2019 13:51:59 +0100
Message-Id: <1576155176-2464-76-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
 hw/Makefile.objs    |  1 -
 hw/meson.build      |  1 +
 hw/sd/Makefile.objs | 10 ----------
 hw/sd/meson.build   | 10 ++++++++++
 4 files changed, 11 insertions(+), 11 deletions(-)
 delete mode 100644 hw/sd/Makefile.objs
 create mode 100644 hw/sd/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 201d614..22ea14a 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -26,7 +26,6 @@ devices-dirs-y += pci/
 devices-dirs-$(CONFIG_PCI) += pci-bridge/ pci-host/
 devices-dirs-y += pcmcia/
 devices-dirs-$(CONFIG_SCSI) += scsi/
-devices-dirs-y += sd/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index a867f82..0d29fa7 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,5 +1,6 @@
 subdir('core')
 subdir('mem')
+subdir('sd')
 subdir('semihosting')
 subdir('smbios')
 subdir('ssi')
diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
deleted file mode 100644
index 0665727..0000000
--- a/hw/sd/Makefile.objs
+++ /dev/null
@@ -1,10 +0,0 @@
-common-obj-$(CONFIG_PL181) += pl181.o
-common-obj-$(CONFIG_SSI_SD) += ssi-sd.o
-common-obj-$(CONFIG_SD) += sd.o core.o sdmmc-internal.o
-common-obj-$(CONFIG_SDHCI) += sdhci.o
-common-obj-$(CONFIG_SDHCI_PCI) += sdhci-pci.o
-
-obj-$(CONFIG_MILKYMIST) += milkymist-memcard.o
-obj-$(CONFIG_OMAP) += omap_mmc.o
-obj-$(CONFIG_PXA2XX) += pxa2xx_mmci.o
-obj-$(CONFIG_RASPI) += bcm2835_sdhost.o
diff --git a/hw/sd/meson.build b/hw/sd/meson.build
new file mode 100644
index 0000000..65a5b04
--- /dev/null
+++ b/hw/sd/meson.build
@@ -0,0 +1,10 @@
+softmmu_ss.add(when: 'CONFIG_PL181', if_true: files('pl181.c'))
+softmmu_ss.add(when: 'CONFIG_SD', if_true: files('sd.c', 'core.c', 'sdmmc-internal.c'))
+softmmu_ss.add(when: 'CONFIG_SDHCI', if_true: files('sdhci.c'))
+softmmu_ss.add(when: 'CONFIG_SDHCI_PCI', if_true: files('sdhci-pci.c'))
+softmmu_ss.add(when: 'CONFIG_SSI_SD', if_true: files('ssi-sd.c'))
+
+specific_ss.add(when: 'CONFIG_MILKYMIST', if_true: files('milkymist-memcard.c'))
+specific_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_mmc.c'))
+specific_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx_mmci.c'))
+specific_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_sdhost.c'))
-- 
1.8.3.1



