Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091EDC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:54:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFB78207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGotRxRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB78207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3kb1-0004p2-W4
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 12:54:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j3kJK-0002OX-LC
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j3kJJ-0002F5-Jg
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46723
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j3kJJ-0002Dx-Fk
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581960954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7bQjPmjmI5t2J7a74b5lv7Yb0EzYa4QU01TXt8HTXa4=;
 b=IGotRxRf5LKdVhw5Y1+T+HefAtDt9btgFvzAW/7fvPnRKhn6Jn9un9omdBRMPi+IhawXBf
 5g6aDaePYpRjFIkOwB4SDNjo5fxgEFJojRdCjZhyMMlNg/q6/Lki3qirtHxwUfM1GGtWlZ
 gHXi/4FEHKAbgCwQKpFRbM165dYdQig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-h9yHfIJCNU61Ie971WvHgQ-1; Mon, 17 Feb 2020 12:35:50 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A4EA801E70;
 Mon, 17 Feb 2020 17:35:49 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E79590508;
 Mon, 17 Feb 2020 17:35:48 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 41/79] hppa: use memdev for RAM
Date: Mon, 17 Feb 2020 12:34:14 -0500
Message-Id: <20200217173452.15243-42-imammedo@redhat.com>
In-Reply-To: <20200217173452.15243-1-imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: h9yHfIJCNU61Ie971WvHgQ-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, deller@gmx.de, rth@twiddle.net
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
---
CC: rth@twiddle.net
CC: deller@gmx.de
---
 hw/hppa/machine.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index d8755ec422..67181e75ba 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -71,14 +71,11 @@ static void machine_hppa_init(MachineState *machine)
     uint64_t kernel_entry =3D 0, kernel_low, kernel_high;
     MemoryRegion *addr_space =3D get_system_memory();
     MemoryRegion *rom_region;
-    MemoryRegion *ram_region;
     MemoryRegion *cpu_region;
     long i;
     unsigned int smp_cpus =3D machine->smp.cpus;
     SysBusDevice *s;
=20
-    ram_size =3D machine->ram_size;
-
     /* Create CPUs.  */
     for (i =3D 0; i < smp_cpus; i++) {
         char *name =3D g_strdup_printf("cpu%ld-io-eir", i);
@@ -97,10 +94,8 @@ static void machine_hppa_init(MachineState *machine)
         error_report("RAM size is currently restricted to 3GB");
         exit(EXIT_FAILURE);
     }
-    ram_region =3D g_new(MemoryRegion, 1);
-    memory_region_allocate_system_memory(ram_region, OBJECT(machine),
-                                         "ram", ram_size);
-    memory_region_add_subregion_overlap(addr_space, 0, ram_region, -1);
+    memory_region_add_subregion_overlap(addr_space, 0, machine->ram, -1);
+
=20
     /* Init Lasi chip */
     lasi_init(addr_space);
@@ -298,6 +293,7 @@ static void machine_hppa_machine_init(MachineClass *mc)
     mc->is_default =3D 1;
     mc->default_ram_size =3D 512 * MiB;
     mc->default_boot_order =3D "cd";
+    mc->default_ram_id =3D "ram";
 }
=20
 DEFINE_MACHINE("hppa", machine_hppa_machine_init)
--=20
2.18.1


