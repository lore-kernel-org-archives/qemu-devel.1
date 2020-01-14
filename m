Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52786C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:38:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A8924672
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A8924672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJao-0000Ku-0c
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 05:38:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1irJXq-0005F2-K8
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:35:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1irJXm-0003lx-47
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:35:34 -0500
Received: from 10.mo1.mail-out.ovh.net ([178.32.96.102]:54670)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1irJXg-0003jS-Dc
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:35:25 -0500
Received: from player798.ha.ovh.net (unknown [10.108.57.14])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 6EE651A964F
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 11:35:21 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player798.ha.ovh.net (Postfix) with ESMTPSA id D107FE4D0003;
 Tue, 14 Jan 2020 10:35:12 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 4/5] hw/arm/aspeed: add a 'execute-in-place' property to
 boot directly from CE0
Date: Tue, 14 Jan 2020 11:34:32 +0100
Message-Id: <20200114103433.30534-5-clg@kaod.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200114103433.30534-1-clg@kaod.org>
References: <20200114103433.30534-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 11054366761784544017
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrtddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.32.96.102
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The overhead for the OpenBMC firmware images using the a custom U-Boot
is around 2 seconds, which is fine, but with a U-Boot from mainline,
it takes an extra 50 seconds or so to reach Linux. A quick survey on
the number of reads performed on the flash memory region gives the
following figures :

  OpenBMC U-Boot      922478 (~ 3.5 MBytes)
  Mainline U-Boot   20569977 (~ 80  MBytes)

QEMU must be trashing the TCG TBs and reloading text very often. Some
addresses are read more than 250.000 times. Until we find a solution
to improve boot time, execution from MMIO is not activated by default.

Setting this option also breaks migration compatibility.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/arm/aspeed.h |  2 ++
 hw/arm/aspeed.c         | 44 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 4423cd0cda71..18521484b90e 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -19,6 +19,8 @@ typedef struct AspeedBoardState AspeedBoardState;
=20
 typedef struct AspeedMachine {
     MachineState parent_obj;
+
+    bool mmio_exec;
 } AspeedMachine;
=20
 #define ASPEED_MACHINE_CLASS(klass) \
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 8702256af1b2..a17843f0d3bf 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -261,11 +261,18 @@ static void aspeed_machine_init(MachineState *machi=
ne)
          * SoC and 128MB for the AST2500 SoC, which is twice as big as
          * needed by the flash modules of the Aspeed machines.
          */
-        memory_region_init_rom(boot_rom, OBJECT(bmc), "aspeed.boot_rom",
-                               fl->size, &error_abort);
-        memory_region_add_subregion(get_system_memory(), FIRMWARE_ADDR,
-                                    boot_rom);
-        write_boot_rom(drive0, FIRMWARE_ADDR, fl->size, &error_abort);
+        if (ASPEED_MACHINE(machine)->mmio_exec) {
+            memory_region_init_alias(boot_rom, OBJECT(bmc), "aspeed.boot=
_rom",
+                                     &fl->mmio, 0, fl->size);
+            memory_region_add_subregion(get_system_memory(), FIRMWARE_AD=
DR,
+                                        boot_rom);
+        } else {
+            memory_region_init_rom(boot_rom, OBJECT(bmc), "aspeed.boot_r=
om",
+                                   fl->size, &error_abort);
+            memory_region_add_subregion(get_system_memory(), FIRMWARE_AD=
DR,
+                                        boot_rom);
+            write_boot_rom(drive0, FIRMWARE_ADDR, fl->size, &error_abort=
);
+        }
     }
=20
     aspeed_board_binfo.ram_size =3D ram_size;
@@ -399,6 +406,30 @@ static void witherspoon_bmc_i2c_init(AspeedBoardStat=
e *bmc)
     /* Bus 11: TODO ucd90160@64 */
 }
=20
+static bool aspeed_get_mmio_exec(Object *obj, Error **errp)
+{
+    return ASPEED_MACHINE(obj)->mmio_exec;
+}
+
+static void aspeed_set_mmio_exec(Object *obj, bool value, Error **errp)
+{
+    ASPEED_MACHINE(obj)->mmio_exec =3D value;
+}
+
+static void aspeed_machine_instance_init(Object *obj)
+{
+    ASPEED_MACHINE(obj)->mmio_exec =3D false;
+}
+
+static void aspeed_machine_class_props_init(ObjectClass *oc)
+{
+    object_class_property_add_bool(oc, "execute-in-place",
+                                   aspeed_get_mmio_exec,
+                                   aspeed_set_mmio_exec, &error_abort);
+    object_class_property_set_description(oc, "execute-in-place",
+                           "boot directly from CE0 flash device", &error=
_abort);
+}
+
 static void aspeed_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
@@ -408,6 +439,8 @@ static void aspeed_machine_class_init(ObjectClass *oc=
, void *data)
     mc->no_floppy =3D 1;
     mc->no_cdrom =3D 1;
     mc->no_parallel =3D 1;
+
+    aspeed_machine_class_props_init(oc);
 }
=20
 static void aspeed_machine_palmetto_class_init(ObjectClass *oc, void *da=
ta)
@@ -550,6 +583,7 @@ static const TypeInfo aspeed_machine_types[] =3D {
         .name          =3D TYPE_ASPEED_MACHINE,
         .parent        =3D TYPE_MACHINE,
         .instance_size =3D sizeof(AspeedMachine),
+        .instance_init =3D aspeed_machine_instance_init,
         .class_size    =3D sizeof(AspeedMachineClass),
         .class_init    =3D aspeed_machine_class_init,
         .abstract      =3D true,
--=20
2.21.1


