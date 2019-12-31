Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894C9C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 18:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61380206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 18:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SI1zYusl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61380206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imMVW-0006bA-Ik
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 13:44:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imMLu-0001nF-4J
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:34:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imMLs-00053H-To
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:34:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37133
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imMLs-00052F-BA
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577817283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BCWFO4N6aSA6lg4FzqFWDScvfpnAbsxaIOBUJCAtlAY=;
 b=SI1zYusl/Y3QkVxPfZnWAXlWywhA5QxiYKllfTR2+j7d/Gu+dSHNGirUVaHo0RPZXNutdb
 mstjs+/t+gl7QQTPWvuVr+KE2lv+86Y7stApLSkhwH32feJyPaGrANz+XTCxEXVoUlH3GI
 YK+7MfMhAtLzAf1qTbh9iXkH2r0dEQw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-zHxZCLBtNXqDgrW_y4K8QA-1; Tue, 31 Dec 2019 13:34:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A49E8017DF;
 Tue, 31 Dec 2019 18:34:40 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-30.ams2.redhat.com [10.36.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 243F967673;
 Tue, 31 Dec 2019 18:34:28 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 13/14] hw/nvram/Kconfig: Restrict CHRP NVRAM to machines using
 OpenBIOS or SLOF
Date: Tue, 31 Dec 2019 19:32:15 +0100
Message-Id: <20191231183216.6781-14-philmd@redhat.com>
In-Reply-To: <20191231183216.6781-1-philmd@redhat.com>
References: <20191231183216.6781-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: zHxZCLBtNXqDgrW_y4K8QA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only the OpenBIOS and SLOF firmwares use the CHRP NVRAM layout.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/nvram/Kconfig       | 4 ++++
 hw/nvram/Makefile.objs | 2 +-
 hw/ppc/Kconfig         | 1 +
 hw/sparc/Kconfig       | 1 +
 hw/sparc64/Kconfig     | 1 +
 5 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/nvram/Kconfig b/hw/nvram/Kconfig
index e082a5610c..0d2ba531ac 100644
--- a/hw/nvram/Kconfig
+++ b/hw/nvram/Kconfig
@@ -7,7 +7,11 @@ config AT24C
=20
 config MAC_NVRAM
     bool
+    select CHRP_NVRAM
=20
 # NMC93XX uses the NS =CE=BCWire interface (similar to SPI but less config=
urable)
 config NMC93XX_EEPROM
     bool
+
+config CHRP_NVRAM
+    bool
diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
index a4bdfbf187..090df63fcd 100644
--- a/hw/nvram/Makefile.objs
+++ b/hw/nvram/Makefile.objs
@@ -2,7 +2,7 @@ common-obj-$(CONFIG_DS1225Y) +=3D ds1225y.o
 common-obj-$(CONFIG_NMC93XX_EEPROM) +=3D eeprom93xx.o
 common-obj-$(CONFIG_AT24C) +=3D eeprom_at24c.o
 common-obj-y +=3D fw_cfg.o
-common-obj-y +=3D chrp_nvram.o
+common-obj-$(CONFIG_CHRP_NVRAM) +=3D chrp_nvram.o
 common-obj-$(CONFIG_MAC_NVRAM) +=3D mac_nvram.o
 obj-$(CONFIG_PSERIES) +=3D spapr_nvram.o
 obj-$(CONFIG_NRF51_SOC) +=3D nrf51_nvm.o
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 8e62d8f470..e27efe9a24 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -11,6 +11,7 @@ config PSERIES
     select XIVE_SPAPR
     select MSI_NONBROKEN
     select FDT_PPC
+    select CHRP_NVRAM
=20
 config SPAPR_RNG
     bool
diff --git a/hw/sparc/Kconfig b/hw/sparc/Kconfig
index 2a83a8010e..22aff2f5b7 100644
--- a/hw/sparc/Kconfig
+++ b/hw/sparc/Kconfig
@@ -12,6 +12,7 @@ config SUN4M
     select LANCE
     select M48T59
     select STP2000
+    select CHRP_NVRAM
=20
 config LEON3
     bool
diff --git a/hw/sparc64/Kconfig b/hw/sparc64/Kconfig
index f9f8b0f73a..980a201bb7 100644
--- a/hw/sparc64/Kconfig
+++ b/hw/sparc64/Kconfig
@@ -12,6 +12,7 @@ config SUN4U
     select IDE_CMD646
     select PCKBD
     select SIMBA
+    select CHRP_NVRAM
=20
 config NIAGARA
     bool
--=20
2.21.0


