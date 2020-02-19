Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0057C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:30:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA8392067D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J69K1Uag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA8392067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4SF7-0008TE-SI
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:30:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j4RwN-0004OF-NJ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:11:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j4RwM-0001Da-0I
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:11:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53959
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j4RwL-0001C3-SA
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582128668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PkPGFHEce1ZRJc5nVolHlu9FXgzxIW10fMjlM661tLQ=;
 b=J69K1UagTw5wdlx08AkcUeBXJlcSRPIKqR0jQxlsYOHxGg9BDsDYlThQbOAQbCJxwjsl7p
 oOggJktjSw9bDJs7f3BiBW56/VsL0TIjwI2GrQBHpm97ZALuPtlQ5rSYlkIUByzu1+qvWF
 7H1VALbvx8Hwz7g7PkYeqM177F3+Mbo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-I7MfYYSsP8KGzl2JNaydAA-1; Wed, 19 Feb 2020 11:11:06 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 652068024CC
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 16:11:05 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5B0E48;
 Wed, 19 Feb 2020 16:11:04 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 59/79] ppc/e500: use memdev for RAM
Date: Wed, 19 Feb 2020 11:09:33 -0500
Message-Id: <20200219160953.13771-60-imammedo@redhat.com>
In-Reply-To: <20200219160953.13771-1-imammedo@redhat.com>
References: <20200219160953.13771-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: I7MfYYSsP8KGzl2JNaydAA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/ppc/e500.c      | 5 +----
 hw/ppc/e500plat.c  | 1 +
 hw/ppc/mpc8544ds.c | 1 +
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 960024b611..d5dfe9fb84 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -831,7 +831,6 @@ static void ppce500_power_off(void *opaque, int line, i=
nt on)
 void ppce500_init(MachineState *machine)
 {
     MemoryRegion *address_space_mem =3D get_system_memory();
-    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
     PPCE500MachineState *pms =3D PPCE500_MACHINE(machine);
     const PPCE500MachineClass *pmc =3D PPCE500_MACHINE_GET_CLASS(machine);
     PCIBus *pci_bus;
@@ -912,9 +911,7 @@ void ppce500_init(MachineState *machine)
     }
=20
     /* Register Memory */
-    memory_region_allocate_system_memory(ram, NULL, "mpc8544ds.ram",
-                                         machine->ram_size);
-    memory_region_add_subregion(address_space_mem, 0, ram);
+    memory_region_add_subregion(address_space_mem, 0, machine->ram);
=20
     dev =3D qdev_create(NULL, "e500-ccsr");
     object_property_add_child(qdev_get_machine(), "e500-ccsr",
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index 7078386300..bddd5e7c48 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -97,6 +97,7 @@ static void e500plat_machine_class_init(ObjectClass *oc, =
void *data)
     mc->init =3D e500plat_init;
     mc->max_cpus =3D 32;
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("e500v2_v30");
+    mc->default_ram_id =3D "mpc8544ds.ram";
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ETSEC_COMMON);
  }
=20
diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
index c2c5e11fa1..81177505f0 100644
--- a/hw/ppc/mpc8544ds.c
+++ b/hw/ppc/mpc8544ds.c
@@ -55,6 +55,7 @@ static void e500plat_machine_class_init(ObjectClass *oc, =
void *data)
     mc->init =3D mpc8544ds_init;
     mc->max_cpus =3D 15;
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("e500v2_v30");
+    mc->default_ram_id =3D "mpc8544ds.ram";
 }
=20
 #define TYPE_MPC8544DS_MACHINE  MACHINE_TYPE_NAME("mpc8544ds")
--=20
2.18.1


