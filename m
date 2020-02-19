Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5F7C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F1A924654
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aHAbsXNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1A924654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4SKg-000339-Fp
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:36:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j4RwG-0004D4-Kk
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:11:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j4RwE-00014l-8v
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:11:04 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47271
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j4RwE-00014U-4z
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582128661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zJoF9bjb/rYr/5dHOfhWXVu17dCwj5n+YUorzMMtRNo=;
 b=aHAbsXNsSR7gmyq1V7gWOGCgyCPj7at2DkuRwE9BaZc8XX1x2fjtWdnzQ6oybP0WFikROe
 3swtIiUYVNNsROS65cvVV9mly76dhqxQJ9+2th/94qpfVrqum1GPtxIS93U9wGpdp70zFJ
 twYpNFh5lKadFJvBJFcImijNbWnguoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-h2bPrD0sPV-zPWZzn1Y14g-1; Wed, 19 Feb 2020 11:10:58 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A25E68EDE42;
 Wed, 19 Feb 2020 16:10:56 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 991D58ECF3;
 Wed, 19 Feb 2020 16:10:54 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 51/79] mips/mips_fulong2e: drop RAM size fixup
Date: Wed, 19 Feb 2020 11:09:25 -0500
Message-Id: <20200219160953.13771-52-imammedo@redhat.com>
In-Reply-To: <20200219160953.13771-1-imammedo@redhat.com>
References: <20200219160953.13771-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: h2bPrD0sPV-zPWZzn1Y14g-1
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
Cc: amarkovic@wavecomp.com, Paolo Bonzini <pbonzini@redhat.com>,
 aleksandar.rikalo@rt-rk.com, philmd@redhat.com, aurelien@aurel32.net
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2:
 * fix format string cousing build failure on 32-bit host
   (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)
v3:
 * since size is ifxed, just hardcode 256Mb value as text
   in error message
   (BALATON Zoltan <balaton@eik.bme.hu>)

CC: philmd@redhat.com
CC: amarkovic@wavecomp.com
CC: aurelien@aurel32.net
CC: aleksandar.rikalo@rt-rk.com
CC: balaton@eik.bme.hu
---
 hw/mips/mips_fulong2e.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 2e043cbb98..cf00211bd2 100644
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
+        error_report("Invalid RAM size, should be 256MB");
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
2.18.1


