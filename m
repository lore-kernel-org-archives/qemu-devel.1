Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95A5C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 21:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94BF6246A2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 21:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTQPcmXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BF6246A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7msA-0006D4-RR
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 16:08:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1j7moQ-0001ED-Di
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:04:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1j7moO-0005Lo-GU
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:04:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27105
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1j7moO-0005Li-C0
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582923884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=St3cayQAW0bdVqNKb6bs8G0hhiz08VTckDguPtXPnrQ=;
 b=PTQPcmXenZT2ELQ+rpVTzmTzYUE0LTHwMyqOICPbH8xEB7LGzwX1o2NMuk4NnEWXVJmw/V
 /+6JUN4YoitA1Mp+hULQSnamNL7PtfeWZPRFtfJidNGLoh2PFD7mZ3aiGA2lhNC5CuN4V4
 4tk3pSBJnHbxsNsHGpRNWM2vfWi+aXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-suGCtmTWP76rjFx-5OCJkg-1; Fri, 28 Feb 2020 16:04:38 -0500
X-MC-Unique: suGCtmTWP76rjFx-5OCJkg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A0EFDB65;
 Fri, 28 Feb 2020 21:04:37 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4399F1036D01;
 Fri, 28 Feb 2020 21:04:31 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 3/4] hw: Make MachineClass::is_default a boolean type
Date: Fri, 28 Feb 2020 16:04:26 -0500
Message-Id: <20200228210427.474606-4-ehabkost@redhat.com>
In-Reply-To: <20200228210427.474606-1-ehabkost@redhat.com>
References: <20200228210427.474606-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

There's no good reason for it to be type int, change it to bool.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200207161948.15972-3-philmd@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/alpha/dp264.c                         |  2 +-
 hw/cris/axis_dev88.c                     |  2 +-
 hw/hppa/machine.c                        |  2 +-
 hw/i386/pc_piix.c                        | 10 +++++-----
 hw/lm32/lm32_boards.c                    |  2 +-
 hw/m68k/mcf5208.c                        |  2 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  2 +-
 hw/mips/mips_malta.c                     |  2 +-
 hw/moxie/moxiesim.c                      |  2 +-
 hw/nios2/10m50_devboard.c                |  2 +-
 hw/openrisc/openrisc_sim.c               |  2 +-
 hw/ppc/mac_oldworld.c                    |  2 +-
 hw/ppc/spapr.c                           |  2 +-
 hw/riscv/spike.c                         |  2 +-
 hw/s390x/s390-virtio-ccw.c               |  2 +-
 hw/sh4/shix.c                            |  2 +-
 hw/sparc/sun4m.c                         |  2 +-
 hw/sparc64/sun4u.c                       |  2 +-
 hw/unicore32/puv3.c                      |  2 +-
 include/hw/boards.h                      |  4 +++-
 20 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 8d71a30617..d28f57199f 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -181,7 +181,7 @@ static void clipper_machine_init(MachineClass *mc)
     mc->init =3D clipper_init;
     mc->block_default_type =3D IF_IDE;
     mc->max_cpus =3D 4;
-    mc->is_default =3D 1;
+    mc->is_default =3D true;
     mc->default_cpu_type =3D ALPHA_CPU_TYPE_NAME("ev67");
     mc->default_ram_id =3D "ram";
 }
diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
index cf6790fd6f..75e5c993b5 100644
--- a/hw/cris/axis_dev88.c
+++ b/hw/cris/axis_dev88.c
@@ -344,7 +344,7 @@ static void axisdev88_machine_init(MachineClass *mc)
 {
     mc->desc =3D "AXIS devboard 88";
     mc->init =3D axisdev88_init;
-    mc->is_default =3D 1;
+    mc->is_default =3D true;
     mc->default_cpu_type =3D CRIS_CPU_TYPE_NAME("crisv32");
     mc->default_ram_id =3D "axisdev88.ram";
 }
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 67181e75ba..bf18767e24 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -290,7 +290,7 @@ static void machine_hppa_machine_init(MachineClass *mc)
     mc->block_default_type =3D IF_SCSI;
     mc->max_cpus =3D HPPA_MAX_CPUS;
     mc->default_cpus =3D 1;
-    mc->is_default =3D 1;
+    mc->is_default =3D true;
     mc->default_ram_size =3D 512 * MiB;
     mc->default_boot_order =3D "cd";
     mc->default_ram_id =3D "ram";
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index fa12203079..9088db8fb6 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -423,7 +423,7 @@ static void pc_i440fx_5_0_machine_options(MachineClass =
*m)
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
     pc_i440fx_machine_options(m);
     m->alias =3D "pc";
-    m->is_default =3D 1;
+    m->is_default =3D true;
     pcmc->default_cpu_version =3D 1;
 }
=20
@@ -434,7 +434,7 @@ static void pc_i440fx_4_2_machine_options(MachineClass =
*m)
 {
     pc_i440fx_5_0_machine_options(m);
     m->alias =3D NULL;
-    m->is_default =3D 0;
+    m->is_default =3D false;
     compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
     compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
 }
@@ -446,7 +446,7 @@ static void pc_i440fx_4_1_machine_options(MachineClass =
*m)
 {
     pc_i440fx_4_2_machine_options(m);
     m->alias =3D NULL;
-    m->is_default =3D 0;
+    m->is_default =3D false;
     compat_props_add(m->compat_props, hw_compat_4_1, hw_compat_4_1_len);
     compat_props_add(m->compat_props, pc_compat_4_1, pc_compat_4_1_len);
 }
@@ -459,7 +459,7 @@ static void pc_i440fx_4_0_machine_options(MachineClass =
*m)
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
     pc_i440fx_4_1_machine_options(m);
     m->alias =3D NULL;
-    m->is_default =3D 0;
+    m->is_default =3D false;
     pcmc->default_cpu_version =3D CPU_VERSION_LEGACY;
     compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
     compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
@@ -473,7 +473,7 @@ static void pc_i440fx_3_1_machine_options(MachineClass =
*m)
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
=20
     pc_i440fx_4_0_machine_options(m);
-    m->is_default =3D 0;
+    m->is_default =3D false;
     pcmc->do_not_add_smb_acpi =3D true;
     m->smbus_no_migration_support =3D true;
     m->alias =3D NULL;
diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
index 747a175b55..b842f74344 100644
--- a/hw/lm32/lm32_boards.c
+++ b/hw/lm32/lm32_boards.c
@@ -295,7 +295,7 @@ static void lm32_evr_class_init(ObjectClass *oc, void *=
data)
=20
     mc->desc =3D "LatticeMico32 EVR32 eval system";
     mc->init =3D lm32_evr_init;
-    mc->is_default =3D 1;
+    mc->is_default =3D true;
     mc->default_cpu_type =3D LM32_CPU_TYPE_NAME("lm32-full");
     mc->default_ram_size =3D 64 * MiB;
     mc->default_ram_id =3D "lm32_evr.sdram";
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 31622c71cb..b84c152ce3 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -350,7 +350,7 @@ static void mcf5208evb_machine_init(MachineClass *mc)
 {
     mc->desc =3D "MCF5208EVB";
     mc->init =3D mcf5208evb_init;
-    mc->is_default =3D 1;
+    mc->is_default =3D true;
     mc->default_cpu_type =3D M68K_CPU_TYPE_NAME("m5208");
     mc->default_ram_id =3D "mcf5208.ram";
 }
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petal=
ogix_s3adsp1800_mmu.c
index 849bafc186..0bb6cdea8d 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -132,7 +132,7 @@ static void petalogix_s3adsp1800_machine_init(MachineCl=
ass *mc)
 {
     mc->desc =3D "PetaLogix linux refdesign for xilinx Spartan 3ADSP1800";
     mc->init =3D petalogix_s3adsp1800_init;
-    mc->is_default =3D 1;
+    mc->is_default =3D true;
 }
=20
 DEFINE_MACHINE("petalogix-s3adsp1800", petalogix_s3adsp1800_machine_init)
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 6e7ba9235d..d380f73d7b 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1439,7 +1439,7 @@ static void mips_malta_machine_init(MachineClass *mc)
     mc->init =3D mips_malta_init;
     mc->block_default_type =3D IF_IDE;
     mc->max_cpus =3D 16;
-    mc->is_default =3D 1;
+    mc->is_default =3D true;
 #ifdef TARGET_MIPS64
     mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("20Kc");
 #else
diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
index 1d06e39fcb..51a98287b5 100644
--- a/hw/moxie/moxiesim.c
+++ b/hw/moxie/moxiesim.c
@@ -150,7 +150,7 @@ static void moxiesim_machine_init(MachineClass *mc)
 {
     mc->desc =3D "Moxie simulator platform";
     mc->init =3D moxiesim_init;
-    mc->is_default =3D 1;
+    mc->is_default =3D true;
     mc->default_cpu_type =3D MOXIE_CPU_TYPE_NAME("MoxieLite");
 }
=20
diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
index ad8b2fc670..33dc2bf511 100644
--- a/hw/nios2/10m50_devboard.c
+++ b/hw/nios2/10m50_devboard.c
@@ -120,7 +120,7 @@ static void nios2_10m50_ghrd_machine_init(struct Machin=
eClass *mc)
 {
     mc->desc =3D "Altera 10M50 GHRD Nios II design";
     mc->init =3D nios2_10m50_ghrd_init;
-    mc->is_default =3D 1;
+    mc->is_default =3D true;
 }
=20
 DEFINE_MACHINE("10m50-ghrd", nios2_10m50_ghrd_machine_init);
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index ad5371250f..d08ce61811 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -176,7 +176,7 @@ static void openrisc_sim_machine_init(MachineClass *mc)
     mc->desc =3D "or1k simulation";
     mc->init =3D openrisc_sim_init;
     mc->max_cpus =3D 2;
-    mc->is_default =3D 1;
+    mc->is_default =3D true;
     mc->default_cpu_type =3D OPENRISC_CPU_TYPE_NAME("or1200");
 }
=20
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 66e434bba3..440c406eb4 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -435,7 +435,7 @@ static void heathrow_class_init(ObjectClass *oc, void *=
data)
     mc->block_default_type =3D IF_IDE;
     mc->max_cpus =3D MAX_CPUS;
 #ifndef TARGET_PPC64
-    mc->is_default =3D 1;
+    mc->is_default =3D true;
 #endif
     /* TOFIX "cad" when Mac floppy is implemented */
     mc->default_boot_order =3D "cd";
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c03ce6afb9..cc10798be4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4560,7 +4560,7 @@ static const TypeInfo spapr_machine_info =3D {
 static void spapr_machine_latest_class_options(MachineClass *mc)
 {
     mc->alias =3D "pseries";
-    mc->is_default =3D 1;
+    mc->is_default =3D true;
 }
=20
 #define DEFINE_SPAPR_MACHINE(suffix, verstr, latest)                 \
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 8823681783..6f03857660 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -448,7 +448,7 @@ static void spike_machine_init(MachineClass *mc)
     mc->desc =3D "RISC-V Spike Board";
     mc->init =3D spike_board_init;
     mc->max_cpus =3D 1;
-    mc->is_default =3D 1;
+    mc->is_default =3D true;
     mc->default_cpu_type =3D SPIKE_V1_10_0_CPU;
 }
=20
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index a89cf4c129..895498cca6 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -630,7 +630,7 @@ bool css_migration_enabled(void)
         mc->desc =3D "VirtIO-ccw based S390 machine v" verstr;            =
      \
         if (latest) {                                                     =
    \
             mc->alias =3D "s390-ccw-virtio";                              =
      \
-            mc->is_default =3D 1;                                         =
      \
+            mc->is_default =3D true;                                      =
      \
         }                                                                 =
    \
     }                                                                     =
    \
     static void ccw_machine_##suffix##_instance_init(Object *obj)         =
    \
diff --git a/hw/sh4/shix.c b/hw/sh4/shix.c
index 2fc2915428..68b14ee5e7 100644
--- a/hw/sh4/shix.c
+++ b/hw/sh4/shix.c
@@ -82,7 +82,7 @@ static void shix_machine_init(MachineClass *mc)
 {
     mc->desc =3D "shix card";
     mc->init =3D shix_init;
-    mc->is_default =3D 1;
+    mc->is_default =3D true;
     mc->default_cpu_type =3D TYPE_SH7750R_CPU;
 }
=20
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index f5bf95fc9f..36ee1a0a3d 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -1402,7 +1402,7 @@ static void ss5_class_init(ObjectClass *oc, void *dat=
a)
     mc->desc =3D "Sun4m platform, SPARCstation 5";
     mc->init =3D ss5_init;
     mc->block_default_type =3D IF_SCSI;
-    mc->is_default =3D 1;
+    mc->is_default =3D true;
     mc->default_boot_order =3D "c";
     mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("Fujitsu-MB86904");
     mc->default_display =3D "tcx";
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index b7ac42f7a5..d33e84f831 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -816,7 +816,7 @@ static void sun4u_class_init(ObjectClass *oc, void *dat=
a)
     mc->init =3D sun4u_init;
     mc->block_default_type =3D IF_IDE;
     mc->max_cpus =3D 1; /* XXX for now */
-    mc->is_default =3D 1;
+    mc->is_default =3D true;
     mc->default_boot_order =3D "c";
     mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("TI-UltraSparc-IIi");
     mc->ignore_boot_device_suffixes =3D true;
diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
index 7e933de228..7f9c0238fe 100644
--- a/hw/unicore32/puv3.c
+++ b/hw/unicore32/puv3.c
@@ -140,7 +140,7 @@ static void puv3_machine_init(MachineClass *mc)
 {
     mc->desc =3D "PKUnity Version-3 based on UniCore32";
     mc->init =3D puv3_init;
-    mc->is_default =3D 1;
+    mc->is_default =3D true;
     mc->default_cpu_type =3D UNICORE32_CPU_TYPE_NAME("UniCore-II");
 }
=20
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 142b86d0ae..9bc42dfb22 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -81,6 +81,8 @@ typedef struct {
  * @max_cpus: maximum number of CPUs supported. Default: 1
  * @min_cpus: minimum number of CPUs supported. Default: 1
  * @default_cpus: number of CPUs instantiated if none are specified. Defau=
lt: 1
+ * @is_default:
+ *    If true QEMU will use this machine by default if no '-M' option is g=
iven.
  * @get_hotplug_handler: this function is called during bus-less
  *    device hotplug. If defined it returns pointer to an instance
  *    of HotplugHandler object, which handles hotplug operation
@@ -181,7 +183,7 @@ struct MachineClass {
         no_sdcard:1,
         pci_allow_0_address:1,
         legacy_fw_cfg_order:1;
-    int is_default;
+    bool is_default;
     const char *default_machine_opts;
     const char *default_boot_order;
     const char *default_display;
--=20
2.24.1


