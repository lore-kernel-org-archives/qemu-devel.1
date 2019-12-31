Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F7CC2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:30:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2610E206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNn1crcv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2610E206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHbX-0004x1-4D
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:30:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHCQ-0005oO-Po
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHCO-0004CC-Qv
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23849
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHCO-0004Ab-IY
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PkR54bRF0Y4P5S77rtDXG4SvH1PMud2iwLmYVb8C1hw=;
 b=MNn1crcvIFV/7Px45zDilO+Y8JumV8Pk/SJAmvYcqXyBFqHskwu9iMjs1fWLtGu2FB0xal
 zzzSDVFIKCnj6cgD2J8T0+0r6ymQHwrarLVbry07t1mJ06eDWpvcJDWRzQkZNTvoXlQLXR
 wD+6A2fg8vHALx2auC29zAxZCM/kQOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-CzxTF7ENPS69lc_Hxat9Ew-1; Tue, 31 Dec 2019 08:04:33 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FDC118031CD
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:32 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16BEE620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:31 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 53/86] mips:mips_fulong2e: drop RAM size fixup
Date: Tue, 31 Dec 2019 14:03:37 +0100
Message-Id: <1577797450-88458-54-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: CzxTF7ENPS69lc_Hxat9Ew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If user provided non-sense RAM size, board will complain and
continue running with max RAM size supported.
Also RAM is going to be allocated by generic code, so it won't be
possible for board to fix things up for user.

Make it error message and exit to force user fix CLI,
instead of accepting non-sense CLI values.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/mips/mips_fulong2e.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 9eaa6e2..4a5e5b4 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -296,7 +296,6 @@ static void mips_fulong2e_init(MachineState *machine)
     MemoryRegion *address_space_mem =3D get_system_memory();
     MemoryRegion *ram =3D g_new(MemoryRegion, 1);
     MemoryRegion *bios =3D g_new(MemoryRegion, 1);
-    ram_addr_t ram_size =3D machine->ram_size;
     long bios_size;
     uint8_t *spd_data;
     Error *err =3D NULL;
@@ -315,10 +314,14 @@ static void mips_fulong2e_init(MachineState *machine)
     qemu_register_reset(main_cpu_reset, cpu);
=20
     /* TODO: support more than 256M RAM as highmem */
-    ram_size =3D 256 * MiB;
+    if (machine->ram_size !=3D 256 * MiB) {
+        error_report("Invalid RAM size, should be %ld", 256 * MiB);
+        exit(EXIT_FAILURE);
+    }
=20
     /* allocate RAM */
-    memory_region_allocate_system_memory(ram, NULL, "fulong2e.ram", ram_si=
ze);
+    memory_region_allocate_system_memory(ram, NULL, "fulong2e.ram",
+                                         machine->ram_size);
     memory_region_init_ram(bios, NULL, "fulong2e.bios", BIOS_SIZE,
                            &error_fatal);
     memory_region_set_readonly(bios, true);
@@ -332,7 +335,7 @@ static void mips_fulong2e_init(MachineState *machine)
      */
=20
     if (kernel_filename) {
-        loaderparams.ram_size =3D ram_size;
+        loaderparams.ram_size =3D machine->ram_size;
         loaderparams.kernel_filename =3D kernel_filename;
         loaderparams.kernel_cmdline =3D kernel_cmdline;
         loaderparams.initrd_filename =3D initrd_filename;
@@ -378,7 +381,7 @@ static void mips_fulong2e_init(MachineState *machine)
     }
=20
     /* Populate SPD eeprom data */
-    spd_data =3D spd_data_generate(DDR, ram_size, &err);
+    spd_data =3D spd_data_generate(DDR, machine->ram_size, &err);
     if (err) {
         warn_report_err(err);
     }
--=20
2.7.4


