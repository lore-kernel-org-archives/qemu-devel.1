Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F25C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CC0A206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7Hi3Qeq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC0A206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHZG-0001zp-Vz
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:28:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHC7-0005Wf-L1
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHC6-0003Nb-CR
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39802
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHC6-0003LS-7a
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=26+KW75Tite2RSmCVDD1qthDMDM37VCYU0I3PJV8Dvs=;
 b=Z7Hi3Qeq+c7YWqMLSTw4TUx1DSlU9ybO9zcZh1oOnGyarM7PG0PdjNyBMYudREfT2OIh+J
 0Qd/hDx/eAAGlA1B6HQv04d+WpXk/z07ek8DLeeUC7KXwRnDgRbC9dOMqzzzLZk6hXe8qW
 jpjQqElhG3qt5ZTn0EDtVgJn0agyPLY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-rMCV9W8nOAqXaXvVJ2BK6g-1; Tue, 31 Dec 2019 08:04:01 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B30C9801E66
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:00 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3948E620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:00 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/86] arm:collie: use memdev for RAM
Date: Tue, 31 Dec 2019 14:02:57 +0100
Message-Id: <1577797450-88458-14-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: rMCV9W8nOAqXaXvVJ2BK6g-1
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

memory_region_allocate_system_memory() API is going away, so
replace it with memdev allocated MemoryRegion. The later is
initialized by generic code, so board only needs to opt in
to memdev scheme by providing
  MachineClass::default_ram_id
and using MachineState::ram instead of manually initializing
RAM memory region.

PS:
 while at it add check for user supplied RAM size and error
 out if it mismatches board expected value.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/arm/collie.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 970a440..a67bb1f 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -20,20 +20,23 @@
=20
 static struct arm_boot_info collie_binfo =3D {
     .loader_start =3D SA_SDCS0,
-    .ram_size =3D 0x20000000,
 };
=20
 static void collie_init(MachineState *machine)
 {
     StrongARMState *s;
     DriveInfo *dinfo;
-    MemoryRegion *sdram =3D g_new(MemoryRegion, 1);
+    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
+
+    if (machine->ram_size !=3D mc->default_ram_size) {
+        error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
+                     mc->default_ram_size);
+        exit(EXIT_FAILURE);
+    }
=20
     s =3D sa1110_init(machine->cpu_type);
=20
-    memory_region_allocate_system_memory(sdram, NULL, "strongarm.sdram",
-                                         collie_binfo.ram_size);
-    memory_region_add_subregion(get_system_memory(), SA_SDCS0, sdram);
+    memory_region_add_subregion(get_system_memory(), SA_SDCS0, machine->ra=
m);
=20
     dinfo =3D drive_get(IF_PFLASH, 0, 0);
     pflash_cfi01_register(SA_CS0, "collie.fl1", 0x02000000,
@@ -57,6 +60,8 @@ static void collie_machine_init(MachineClass *mc)
     mc->init =3D collie_init;
     mc->ignore_memory_transaction_failures =3D true;
     mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("sa1110");
+    mc->default_ram_size =3D 0x20000000;
+    mc->default_ram_id =3D "strongarm.sdram";
 }
=20
 DEFINE_MACHINE("collie", collie_machine_init)
--=20
2.7.4


