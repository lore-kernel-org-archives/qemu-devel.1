Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901A5C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:16:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 524C9205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMdJqU1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524C9205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHNR-00041A-TF
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHBu-0005GN-Nq
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHBt-0002gU-9l
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53450
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHBt-0002eG-3s
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nJwVSDzMFDGag/uCE0jxRsayf/4QIe4mdAv846SG7ds=;
 b=iMdJqU1tSqutb1wykYyN60yTtTC7a/1UP24bheNbrJzwlCrRz0cJAu2kFjWPl2Y2qM6BeJ
 GD1pdi6B/EUY8sGnj1jsCTpmoPZs+4LJKT52NN1qoxc3/crzWZMPn7zvuh2M8VTgqqDOH+
 I8WRnb60g3SJYby5I3+Tf7InhBO/nFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-WZtTUDvEO3uPfymoQN9Jdw-1; Tue, 31 Dec 2019 08:04:03 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F30A10054E3
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:02 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8AF1620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:01 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/86] arm:digic_boards: use memdev for RAM
Date: Tue, 31 Dec 2019 14:02:59 +0100
Message-Id: <1577797450-88458-16-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: WZtTUDvEO3uPfymoQN9Jdw-1
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

PS:
 remove no longer needed DigicBoardState

PS2:
 while at it add check for user supplied RAM size and error
 out if it mismatches board expected value.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/arm/digic_boards.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index ef3fc2b..c3bc5cb 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -35,39 +35,38 @@
 #include "hw/loader.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
+#include "qemu/units.h"
=20
 #define DIGIC4_ROM0_BASE      0xf0000000
 #define DIGIC4_ROM1_BASE      0xf8000000
 #define DIGIC4_ROM_MAX_SIZE   0x08000000
=20
-typedef struct DigicBoardState {
-    DigicState *digic;
-    MemoryRegion ram;
-} DigicBoardState;
-
 typedef struct DigicBoard {
-    hwaddr ram_size;
-    void (*add_rom0)(DigicBoardState *, hwaddr, const char *);
+    void (*add_rom0)(DigicState *, hwaddr, const char *);
     const char *rom0_def_filename;
-    void (*add_rom1)(DigicBoardState *, hwaddr, const char *);
+    void (*add_rom1)(DigicState *, hwaddr, const char *);
     const char *rom1_def_filename;
 } DigicBoard;
=20
-static void digic4_board_init(DigicBoard *board)
+static void digic4_board_init(MachineState *machine, DigicBoard *board)
 {
     Error *err =3D NULL;
+    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
=20
-    DigicBoardState *s =3D g_new(DigicBoardState, 1);
+    if (machine->ram_size !=3D mc->default_ram_size) {
+        error_report("Invalid RAM size, should be %" PRIi64 " Bytes",
+                      mc->default_ram_size);
+        exit(EXIT_FAILURE);
+    }
=20
-    s->digic =3D DIGIC(object_new(TYPE_DIGIC));
-    object_property_set_bool(OBJECT(s->digic), true, "realized", &err);
+    DigicState *s =3D DIGIC(object_new(TYPE_DIGIC));
+    object_property_set_bool(OBJECT(s), true, "realized", &err);
     if (err !=3D NULL) {
         error_reportf_err(err, "Couldn't realize DIGIC SoC: ");
         exit(1);
     }
=20
-    memory_region_allocate_system_memory(&s->ram, NULL, "ram", board->ram_=
size);
-    memory_region_add_subregion(get_system_memory(), 0, &s->ram);
+    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
=20
     if (board->add_rom0) {
         board->add_rom0(s, DIGIC4_ROM0_BASE, board->rom0_def_filename);
@@ -78,7 +77,7 @@ static void digic4_board_init(DigicBoard *board)
     }
 }
=20
-static void digic_load_rom(DigicBoardState *s, hwaddr addr,
+static void digic_load_rom(DigicState *s, hwaddr addr,
                            hwaddr max_size, const char *def_filename)
 {
     target_long rom_size;
@@ -118,7 +117,7 @@ static void digic_load_rom(DigicBoardState *s, hwaddr a=
ddr,
  * Samsung K8P3215UQB
  * 64M Bit (4Mx16) Page Mode / Multi-Bank NOR Flash Memory
  */
-static void digic4_add_k8p3215uqb_rom(DigicBoardState *s, hwaddr addr,
+static void digic4_add_k8p3215uqb_rom(DigicState *s, hwaddr addr,
                                       const char *def_filename)
 {
 #define FLASH_K8P3215UQB_SIZE (4 * 1024 * 1024)
@@ -135,14 +134,13 @@ static void digic4_add_k8p3215uqb_rom(DigicBoardState=
 *s, hwaddr addr,
 }
=20
 static DigicBoard digic4_board_canon_a1100 =3D {
-    .ram_size =3D 64 * 1024 * 1024,
     .add_rom1 =3D digic4_add_k8p3215uqb_rom,
     .rom1_def_filename =3D "canon-a1100-rom1.bin",
 };
=20
 static void canon_a1100_init(MachineState *machine)
 {
-    digic4_board_init(&digic4_board_canon_a1100);
+    digic4_board_init(machine, &digic4_board_canon_a1100);
 }
=20
 static void canon_a1100_machine_init(MachineClass *mc)
@@ -150,6 +148,8 @@ static void canon_a1100_machine_init(MachineClass *mc)
     mc->desc =3D "Canon PowerShot A1100 IS";
     mc->init =3D &canon_a1100_init;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_ram_size =3D 64 * MiB;
+    mc->default_ram_id =3D "ram";
 }
=20
 DEFINE_MACHINE("canon-a1100", canon_a1100_machine_init)
--=20
2.7.4


