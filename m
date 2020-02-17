Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AF6C34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B38102070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRFPVeGQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38102070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3kYL-0007Pk-Pc
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 12:51:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j3kJB-00027M-MU
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j3kJA-00028M-KJ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58939
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j3kJ9-00026x-SC
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581960947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fHXhcDK6QFU/yQ/obfXxjyjr9uOty0fUBu33SlNMk0o=;
 b=DRFPVeGQQUHt7dhV+WJH4IY2J2+fW5jZhr4fdxE+dhlvmwGv+/OI2Pnz8D6nqZwV4HZLFN
 /SpfUqk8qTv0XEQmQJGagWBerSN3u2fyYO30UIP2Jd3cDtqYC0fi0CJsnqsGCxxrcYXRnt
 17BWGvy5Q57U536Sd1RKF7xojvZlvQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-JWb0x1xXO1K1D4qWszJqXw-1; Mon, 17 Feb 2020 12:35:44 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26FFA107ACC9
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 17:35:44 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 751729052B;
 Mon, 17 Feb 2020 17:35:43 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 36/79] arm/xlnx-versal-virt: use memdev for RAM
Date: Mon, 17 Feb 2020 12:34:09 -0500
Message-Id: <20200217173452.15243-37-imammedo@redhat.com>
In-Reply-To: <20200217173452.15243-1-imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: JWb0x1xXO1K1D4qWszJqXw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

memory_region_allocate_system_memory() API is going away, so
replace it with memdev allocated MemoryRegion. The later is
initialized by generic code, so board only needs to opt in
to memdev scheme by providing
  MachineClass::default_ram_id
and using MachineState::ram instead of manually initializing
RAM memory region.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/xlnx-versal-virt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 462493c467..c137ff4def 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -30,7 +30,6 @@ typedef struct VersalVirt {
     MachineState parent_obj;
=20
     Versal soc;
-    MemoryRegion mr_ddr;
=20
     void *fdt;
     int fdt_size;
@@ -414,12 +413,9 @@ static void versal_virt_init(MachineState *machine)
         psci_conduit =3D QEMU_PSCI_CONDUIT_SMC;
     }
=20
-    memory_region_allocate_system_memory(&s->mr_ddr, NULL, "ddr",
-                                         machine->ram_size);
-
     sysbus_init_child_obj(OBJECT(machine), "xlnx-ve", &s->soc,
                           sizeof(s->soc), TYPE_XLNX_VERSAL);
-    object_property_set_link(OBJECT(&s->soc), OBJECT(&s->mr_ddr),
+    object_property_set_link(OBJECT(&s->soc), OBJECT(machine->ram),
                              "ddr", &error_abort);
     object_property_set_int(OBJECT(&s->soc), psci_conduit,
                             "psci-conduit", &error_abort);
@@ -473,6 +469,7 @@ static void versal_virt_machine_class_init(ObjectClass =
*oc, void *data)
     mc->max_cpus =3D XLNX_VERSAL_NR_ACPUS;
     mc->default_cpus =3D XLNX_VERSAL_NR_ACPUS;
     mc->no_cdrom =3D true;
+    mc->default_ram_id =3D "ddr";
 }
=20
 static const TypeInfo versal_virt_machine_init_typeinfo =3D {
--=20
2.18.1


