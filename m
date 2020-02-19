Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55064C34054
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:20:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 244FA2464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bBGWOszu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244FA2464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4S5k-00052v-6H
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:20:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j4RvX-0002LF-8B
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j4RvV-0000ZV-O1
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24310
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j4RvV-0000ZI-Jz
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582128617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5zbZSc0F00KT9TJ04qFC8LgJqv/4chjq8QbrGtQCWv0=;
 b=bBGWOszuTZI3jX4l5hGHTc/jldOzyNTUKdqc43X9QnNYEtpwozgzhKHYy2e5SJFtUxZsgb
 MRq7J64jZwng22RPrZ9l2x5Pvg+GxXgHDsfLAfBs+QbpCUmSSwbDS7LxHIgkiFVoEBietn
 NVIw9jPLGussYOAbKPpOvtbSriPQP2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-FIg50ADeP2mwukE-g0BMxw-1; Wed, 19 Feb 2020 11:10:13 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 728B3107B7FF;
 Wed, 19 Feb 2020 16:10:12 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9723348;
 Wed, 19 Feb 2020 16:10:11 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 13/79] arm/digic_boards: use memdev for RAM
Date: Wed, 19 Feb 2020 11:08:47 -0500
Message-Id: <20200219160953.13771-14-imammedo@redhat.com>
In-Reply-To: <20200219160953.13771-1-imammedo@redhat.com>
References: <20200219160953.13771-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: FIg50ADeP2mwukE-g0BMxw-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, antonynpavlov@gmail.com
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
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v3:
  * move 'DigicState *s' declaration to the top of digic4_board_init()
v2:
  * fix format string causing build failure on 32-bit host
    (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)

CC: antonynpavlov@gmail.com
---
 hw/arm/digic_boards.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index ef3fc2b6a5..518a63e61d 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -35,39 +35,40 @@
 #include "hw/loader.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
+#include "qemu/units.h"
+#include "qemu/cutils.h"
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
+    DigicState *s =3D DIGIC(object_new(TYPE_DIGIC));
+    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
+
+    if (machine->ram_size !=3D mc->default_ram_size) {
+        char *sz =3D size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
+    }
=20
-    DigicBoardState *s =3D g_new(DigicBoardState, 1);
-
-    s->digic =3D DIGIC(object_new(TYPE_DIGIC));
-    object_property_set_bool(OBJECT(s->digic), true, "realized", &err);
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
@@ -78,7 +79,7 @@ static void digic4_board_init(DigicBoard *board)
     }
 }
=20
-static void digic_load_rom(DigicBoardState *s, hwaddr addr,
+static void digic_load_rom(DigicState *s, hwaddr addr,
                            hwaddr max_size, const char *def_filename)
 {
     target_long rom_size;
@@ -118,7 +119,7 @@ static void digic_load_rom(DigicBoardState *s, hwaddr a=
ddr,
  * Samsung K8P3215UQB
  * 64M Bit (4Mx16) Page Mode / Multi-Bank NOR Flash Memory
  */
-static void digic4_add_k8p3215uqb_rom(DigicBoardState *s, hwaddr addr,
+static void digic4_add_k8p3215uqb_rom(DigicState *s, hwaddr addr,
                                       const char *def_filename)
 {
 #define FLASH_K8P3215UQB_SIZE (4 * 1024 * 1024)
@@ -135,14 +136,13 @@ static void digic4_add_k8p3215uqb_rom(DigicBoardState=
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
@@ -150,6 +150,8 @@ static void canon_a1100_machine_init(MachineClass *mc)
     mc->desc =3D "Canon PowerShot A1100 IS";
     mc->init =3D &canon_a1100_init;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_ram_size =3D 64 * MiB;
+    mc->default_ram_id =3D "ram";
 }
=20
 DEFINE_MACHINE("canon-a1100", canon_a1100_machine_init)
--=20
2.18.1


