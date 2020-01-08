Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7534C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:45:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 725312067D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/yW7GWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725312067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAi9-0004Xs-Ty
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:45:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWV-0003w9-2w
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWT-0004Ob-S0
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:18 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:36679)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWT-0004O1-Lj
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:17 -0500
Received: by mail-wm1-x32c.google.com with SMTP id p17so2323907wma.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CnOeB/Pwe7MijHlbGwtaQatM9vOSG1aqVBwm/NF6PNU=;
 b=n/yW7GWx3WnhjsAvC6EMfZJjQLwle+CoGy0/kUsagbFjraKgy8hkJel9MzLfhD8Zt4
 INKZb4VCl+EqORRJubSer4RStx4cpPjzo7fFNh9Qg/uwmyUT18RiQxmXCDN1jnQ08hsl
 N1IH5iVFNyaZJwyzRCiQsxOd8BO7DI5ZR6vUJ+Muc+8YaxeABicxjYROcJuqOflzkIxY
 WH1gZH607FXmczypHL+kB8vRe5bhCMnLyt8PhAmXBY228MrCxThltSNlLysFM3ULtRWU
 K3uyQbSP0XEhQud1t01N+epb3VBhyVrGFM5izH4CHZsiy+9qfeJ0j748UTDkMXkGlBWN
 uE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=CnOeB/Pwe7MijHlbGwtaQatM9vOSG1aqVBwm/NF6PNU=;
 b=X9HkxMxD3OQsHZXhO+Xumzx5XVVuvsqewg3aeOSZsOOlIhgRVAsxkfhcncKPYR0pWx
 Nt/Y3ngH3gWv91TLoC+lPS/Yka+O0bi6Rt4z8Q91gxOqGoGnE0R9RYWiscEmBDc8wbEF
 t/ka9vdWMNCO4H+QNeAF19BAbewhakGoNiDnGAmJl2lGw1B+i+r9uLMBAnEM1QQlDzOo
 8LumZ35cxPjDV7/EcA4bUQbDV+n02QrIY1OjimdOGuj2WQUqthchn4Cka8xs7DaYTZGv
 I4YFFIH5vaacvgFBe6tFKrTS5hr8BIGy7px2lvS8WaM5PE0OYiM7GNO6iC4zNvG3+AVJ
 LkMw==
X-Gm-Message-State: APjAAAUnZjfJFdhyYF+zeCWvcPghNvV1xw6Vu6DVKnJxmEmXdVttk19M
 D4fhf/LUZPhFiaWK7GJ0zlbLA2oC
X-Google-Smtp-Source: APXvYqzqI7jwgG5VCKOFfW0SfU6EyiFQ29sk6mWhvbdjlgjUdACDYLR/2be+3I7mWg3Ar4zl64RJ+Q==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr3760579wmk.68.1578486796516; 
 Wed, 08 Jan 2020 04:33:16 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/38] hw/nvram/Kconfig: Restrict CHRP NVRAM to machines using
 OpenBIOS or SLOF
Date: Wed,  8 Jan 2020 13:32:36 +0100
Message-Id: <1578486775-52247-20-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Only the OpenBIOS and SLOF firmwares use the CHRP NVRAM layout.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191231183216.6781-14-philmd@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/nvram/Kconfig       | 4 ++++
 hw/nvram/Makefile.objs | 2 +-
 hw/ppc/Kconfig         | 1 +
 hw/sparc/Kconfig       | 1 +
 hw/sparc64/Kconfig     | 1 +
 5 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/nvram/Kconfig b/hw/nvram/Kconfig
index 24b0ce6..e872fcb 100644
--- a/hw/nvram/Kconfig
+++ b/hw/nvram/Kconfig
@@ -7,7 +7,11 @@ config AT24C
 
 config MAC_NVRAM
     bool
+    select CHRP_NVRAM
 
 # NMC93XX uses the NS uWire interface (similar to SPI but less configurable)
 config NMC93XX_EEPROM
     bool
+
+config CHRP_NVRAM
+    bool
diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
index a4bdfbf..090df63 100644
--- a/hw/nvram/Makefile.objs
+++ b/hw/nvram/Makefile.objs
@@ -2,7 +2,7 @@ common-obj-$(CONFIG_DS1225Y) += ds1225y.o
 common-obj-$(CONFIG_NMC93XX_EEPROM) += eeprom93xx.o
 common-obj-$(CONFIG_AT24C) += eeprom_at24c.o
 common-obj-y += fw_cfg.o
-common-obj-y += chrp_nvram.o
+common-obj-$(CONFIG_CHRP_NVRAM) += chrp_nvram.o
 common-obj-$(CONFIG_MAC_NVRAM) += mac_nvram.o
 obj-$(CONFIG_PSERIES) += spapr_nvram.o
 obj-$(CONFIG_NRF51_SOC) += nrf51_nvm.o
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 8e62d8f..e27efe9 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -11,6 +11,7 @@ config PSERIES
     select XIVE_SPAPR
     select MSI_NONBROKEN
     select FDT_PPC
+    select CHRP_NVRAM
 
 config SPAPR_RNG
     bool
diff --git a/hw/sparc/Kconfig b/hw/sparc/Kconfig
index 2a83a80..22aff2f 100644
--- a/hw/sparc/Kconfig
+++ b/hw/sparc/Kconfig
@@ -12,6 +12,7 @@ config SUN4M
     select LANCE
     select M48T59
     select STP2000
+    select CHRP_NVRAM
 
 config LEON3
     bool
diff --git a/hw/sparc64/Kconfig b/hw/sparc64/Kconfig
index f9f8b0f..980a201 100644
--- a/hw/sparc64/Kconfig
+++ b/hw/sparc64/Kconfig
@@ -12,6 +12,7 @@ config SUN4U
     select IDE_CMD646
     select PCKBD
     select SIMBA
+    select CHRP_NVRAM
 
 config NIAGARA
     bool
-- 
1.8.3.1



