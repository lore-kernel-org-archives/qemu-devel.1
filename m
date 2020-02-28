Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5D2C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 21:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9847B246A2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 21:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSsU0j1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9847B246A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7mr7-0005G3-RI
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 16:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1j7moH-00013M-Vu
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:04:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1j7moG-0005GM-Qo
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:04:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31436
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1j7moG-0005Fy-Mo
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582923876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TXxfExf+lVdC2qgbicTIvqg48J4ev5XvT/7Wk+sWAAI=;
 b=RSsU0j1sDBPVuvijJkusqB4q6ZDWU3T7rXauFMQ4v/ZHT8380LUKUtLuPR0pfRJb98Vnw0
 cQHIjhz2xTfx7yJxTqKgsexOrhkbmCNMysbBtXlmRaJrrC2/QxUMqv5O/ofYD88q+1pqOs
 dhH5s/ok5zW4I3+9Vq+Do1DNaNvnY/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-TG4uwSiJNAqsJ-47NRqKLg-1; Fri, 28 Feb 2020 16:04:32 -0500
X-MC-Unique: TG4uwSiJNAqsJ-47NRqKLg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94E88800D50;
 Fri, 28 Feb 2020 21:04:30 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A8C35C57E;
 Fri, 28 Feb 2020 21:04:30 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 2/4] hw: Do not initialize MachineClass::is_default to 0
Date: Fri, 28 Feb 2020 16:04:25 -0500
Message-Id: <20200228210427.474606-3-ehabkost@redhat.com>
In-Reply-To: <20200228210427.474606-1-ehabkost@redhat.com>
References: <20200228210427.474606-1-ehabkost@redhat.com>
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The MachineClass is already zeroed on creation.

Note: The code setting is_default=3D0 in hw/i386/pc_piix.c is
      different (related to compat options). When adding a
      new versioned machine, we want it to be the new default,
      so we have to mark the previous one as not default.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200207161948.15972-2-philmd@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/lm32/lm32_boards.c               | 1 -
 hw/lm32/milkymist.c                 | 1 -
 hw/m68k/q800.c                      | 1 -
 hw/microblaze/petalogix_ml605_mmu.c | 1 -
 hw/tricore/tricore_testboard.c      | 1 -
 5 files changed, 5 deletions(-)

diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
index 4e0a98c117..747a175b55 100644
--- a/hw/lm32/lm32_boards.c
+++ b/hw/lm32/lm32_boards.c
@@ -313,7 +313,6 @@ static void lm32_uclinux_class_init(ObjectClass *oc, vo=
id *data)
=20
     mc->desc =3D "lm32 platform for uClinux and u-boot by Theobroma System=
s";
     mc->init =3D lm32_uclinux_init;
-    mc->is_default =3D 0;
     mc->default_cpu_type =3D LM32_CPU_TYPE_NAME("lm32-full");
     mc->default_ram_size =3D 64 * MiB;
     mc->default_ram_id =3D "lm32_uclinux.sdram";
diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 5c72266e58..85913bb68b 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -219,7 +219,6 @@ static void milkymist_machine_init(MachineClass *mc)
 {
     mc->desc =3D "Milkymist One";
     mc->init =3D milkymist_init;
-    mc->is_default =3D 0;
     mc->default_cpu_type =3D LM32_CPU_TYPE_NAME("lm32-full");
     mc->default_ram_size =3D 128 * MiB;
     mc->default_ram_id =3D "milkymist.sdram";
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index a4c4bc14cb..c5699f6f3e 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -438,7 +438,6 @@ static void q800_machine_class_init(ObjectClass *oc, vo=
id *data)
     mc->init =3D q800_init;
     mc->default_cpu_type =3D M68K_CPU_TYPE_NAME("m68040");
     mc->max_cpus =3D 1;
-    mc->is_default =3D 0;
     mc->block_default_type =3D IF_SCSI;
     mc->default_ram_id =3D "m68k_mac.ram";
 }
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_=
ml605_mmu.c
index 09486bc8bf..0a2640c40b 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -216,7 +216,6 @@ static void petalogix_ml605_machine_init(MachineClass *=
mc)
 {
     mc->desc =3D "PetaLogix linux refdesign for xilinx ml605 little endian=
";
     mc->init =3D petalogix_ml605_init;
-    mc->is_default =3D 0;
 }
=20
 DEFINE_MACHINE("petalogix-ml605", petalogix_ml605_machine_init)
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.=
c
index 20c9ccb3ce..8ec2b5bddd 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -105,7 +105,6 @@ static void ttb_machine_init(MachineClass *mc)
 {
     mc->desc =3D "a minimal TriCore board";
     mc->init =3D tricoreboard_init;
-    mc->is_default =3D 0;
     mc->default_cpu_type =3D TRICORE_CPU_TYPE_NAME("tc1796");
 }
=20
--=20
2.24.1


