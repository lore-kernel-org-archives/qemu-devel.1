Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83ABC38BFA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 956A721556
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSBCnjIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956A721556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6LPT-0001JX-LG
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:37:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6KpR-00049a-Pt
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:59:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6KpP-0006Dm-Vs
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:59:49 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29162
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6KpP-0006D1-S6
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582577987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lSVtvfrX1T1hW1+GelbNbTHoIYbtGWi72bTWri8Gs/8=;
 b=XSBCnjIyEIp9IlPSCn6Sz8L+ECXAxZfbt0LRLc5Uf9Ir8uQatXufNndjF1T48QGSaNbiYv
 19VmFHV/s+lNxRQjbM74rL3dm7y3YbADYdeZ3FfJxIGmwQacHg5TEUc56XrUNAJKwSCiua
 pU5POEzX6FddBS/K18+yVToJUeoBAFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-21bPmpMIOFiU2zTeKeBseA-1; Mon, 24 Feb 2020 15:59:45 -0500
X-MC-Unique: 21bPmpMIOFiU2zTeKeBseA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FD12107ACC4;
 Mon, 24 Feb 2020 20:59:41 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-162.brq.redhat.com [10.40.205.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 84E005C21B;
 Mon, 24 Feb 2020 20:59:32 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH RESEND v2 16/32] hw/arm/stm32: Use memory_region_init_rom()
 with read-only regions
Date: Mon, 24 Feb 2020 21:55:17 +0100
Message-Id: <20200224205533.23798-17-philmd@redhat.com>
In-Reply-To: <20200224205533.23798-1-philmd@redhat.com>
References: <20200224205533.23798-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The scripts/coccinelle/memory-region-housekeeping.cocci reported:
* TODO [[view:./hw/arm/stm32f205_soc.c::face=3Dovl-face1::linb=3D96::colb=
=3D4::cole=3D26][potential use of memory_region_init_rom*() in  ./hw/arm/st=
m32f205_soc.c::96]]
* TODO [[view:./hw/arm/stm32f405_soc.c::face=3Dovl-face1::linb=3D98::colb=
=3D4::cole=3D26][potential use of memory_region_init_rom*() in  ./hw/arm/st=
m32f405_soc.c::98]]

We can indeed replace the memory_region_init_ram() and
memory_region_set_readonly() calls by memory_region_init_rom().

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/stm32f205_soc.c | 4 +---
 hw/arm/stm32f405_soc.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 627fd446f5..2de56275b7 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -93,12 +93,10 @@ static void stm32f205_soc_realize(DeviceState *dev_soc,=
 Error **errp)
     MemoryRegion *flash =3D g_new(MemoryRegion, 1);
     MemoryRegion *flash_alias =3D g_new(MemoryRegion, 1);
=20
-    memory_region_init_ram(flash, NULL, "STM32F205.flash", FLASH_SIZE,
+    memory_region_init_rom(flash, NULL, "STM32F205.flash", FLASH_SIZE,
                            &error_fatal);
     memory_region_init_alias(flash_alias, NULL, "STM32F205.flash.alias",
                              flash, 0, FLASH_SIZE);
-
-    memory_region_set_readonly(flash, true);
     memory_region_set_readonly(flash_alias, true);
=20
     memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, flash);
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index 9bcad97853..b8fca13f95 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -95,7 +95,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, E=
rror **errp)
     Error *err =3D NULL;
     int i;
=20
-    memory_region_init_ram(&s->flash, NULL, "STM32F405.flash", FLASH_SIZE,
+    memory_region_init_rom(&s->flash, NULL, "STM32F405.flash", FLASH_SIZE,
                            &err);
     if (err !=3D NULL) {
         error_propagate(errp, err);
@@ -103,8 +103,6 @@ static void stm32f405_soc_realize(DeviceState *dev_soc,=
 Error **errp)
     }
     memory_region_init_alias(&s->flash_alias, NULL, "STM32F405.flash.alias=
",
                              &s->flash, 0, FLASH_SIZE);
-
-    memory_region_set_readonly(&s->flash, true);
     memory_region_set_readonly(&s->flash_alias, true);
=20
     memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->fla=
sh);
--=20
2.21.1


