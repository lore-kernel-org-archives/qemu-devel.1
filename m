Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14F2C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB5B8206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+cHaJII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5B8206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHjQ-0007JN-Ey
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:38:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHCX-0005rd-2y
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHCS-0004HL-12
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49010
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHCQ-0004F1-Ma
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wLuo5naVQqI5MzQmvnq/Z/TlQR0qIfPl9fITLLXC2GQ=;
 b=H+cHaJII6TSR4Ow1UtgXfQOL8qX6aVOgdunmO7kNPrC6rpZjoGoLLFqtSYhtvcsSmQSI6N
 UslfFnOXM2IlbWW6k6H0W6OHcdSxZ/bMED5j6NRuqIMucC5Z88PNe4aRWiWQnNVTAX4laX
 zj/GwjzIepAMZ4YKcgPymfHRmeyGQcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-_Lbi_ZlrO0CLtSn0Ma6-og-1; Tue, 31 Dec 2019 08:04:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB84718031DA
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:34 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72D94620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:34 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 56/86] mips:mips_malta: use memdev for RAM
Date: Tue, 31 Dec 2019 14:03:40 +0100
Message-Id: <1577797450-88458-57-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: _Lbi_ZlrO0CLtSn0Ma6-og-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
 hw/mips/mips_malta.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 783cd99..adffa3a 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1223,7 +1223,6 @@ void mips_malta_init(MachineState *machine)
     char *filename;
     PFlashCFI01 *fl;
     MemoryRegion *system_memory =3D get_system_memory();
-    MemoryRegion *ram_high =3D g_new(MemoryRegion, 1);
     MemoryRegion *ram_low_preio =3D g_new(MemoryRegion, 1);
     MemoryRegion *ram_low_postio;
     MemoryRegion *bios, *bios_copy =3D g_new(MemoryRegion, 1);
@@ -1261,13 +1260,11 @@ void mips_malta_init(MachineState *machine)
     }
=20
     /* register RAM at high address where it is undisturbed by IO */
-    memory_region_allocate_system_memory(ram_high, NULL, "mips_malta.ram",
-                                         ram_size);
-    memory_region_add_subregion(system_memory, 0x80000000, ram_high);
+    memory_region_add_subregion(system_memory, 0x80000000, machine->ram);
=20
     /* alias for pre IO hole access */
     memory_region_init_alias(ram_low_preio, NULL, "mips_malta_low_preio.ra=
m",
-                             ram_high, 0, MIN(ram_size, 256 * MiB));
+                             machine->ram, 0, MIN(ram_size, 256 * MiB));
     memory_region_add_subregion(system_memory, 0, ram_low_preio);
=20
     /* alias for post IO hole access, if there is enough RAM */
@@ -1275,7 +1272,7 @@ void mips_malta_init(MachineState *machine)
         ram_low_postio =3D g_new(MemoryRegion, 1);
         memory_region_init_alias(ram_low_postio, NULL,
                                  "mips_malta_low_postio.ram",
-                                 ram_high, 512 * MiB,
+                                 machine->ram, 512 * MiB,
                                  ram_size - 512 * MiB);
         memory_region_add_subregion(system_memory, 512 * MiB,
                                     ram_low_postio);
@@ -1447,6 +1444,7 @@ static void mips_malta_machine_init(MachineClass *mc)
 #else
     mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("24Kf");
 #endif
+    mc->default_ram_id =3D "mips_malta.ram";
 }
=20
 DEFINE_MACHINE("malta", mips_malta_machine_init)
--=20
2.7.4


