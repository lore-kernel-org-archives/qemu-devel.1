Received: from eggs.gnu.org ([2001:4830:134:3::10]:49140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bztemail@gmail.com>) id 1e726L-0005YD-9j
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 12:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bztemail@gmail.com>) id 1e726J-0002hc-AM
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 12:30:49 -0400
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1710241246330.82180@zero.eik.bme.hu>
References: <CADYoBw2dogvU6-3vChG4js0BNdyTPG8eDvMSRoU50eTX_9DdEQ@mail.gmail.com>
	<MWHPR21MB01590CD596A992C93E01B5079E460@MWHPR21MB0159.namprd21.prod.outlook.com>
	<CADYoBw1ksGDo26-PC4eMnyqxZQoZkXNLDeGoWfcRHs-SfTCJkw@mail.gmail.com>
	<alpine.BSF.2.21.1710241246330.82180@zero.eik.bme.hu>
From: bzt bzt <bztemail@gmail.com>
Date: Tue, 24 Oct 2017 18:30:40 +0200
Message-ID: <CADYoBw1kuPBJPR+f1ZJMWpCSg3ttGNh_bO_kww6u5x7LbiubVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] BCM2837 and machine raspi3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>, Peter Maydell <peter.maydell@linaro.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Tue, Oct 24, 2017 at 1:05 PM, BALATON Zoltan <balaton@eik.bme.hu> wrote:
[...]

> Summa summarum, which one is preferred? Think of the future or keep it at a
>> bare minimum?
>>
>
> I don't feel I have a deciding word in this but to share my opinion I
> think it's better to keep it in one file avoiding too much code duplication
> as long as those features that would make the implementations different
> aren't added now. Then when those features are added the files could be
> split or the best way can be decided at that point based on how those
> features will be implemented so no need to think that far ahead now. This
> would make patches easier to review now and maintaining the common code
> easier until they are different enough so a split needs to be done.
>
> Regrads,
> BALATON Zoltan
>

Okay, in this case here's a minimalistic version without the BCM2837 class
(just a flag added to BCM2836State). Feel free to choose which one to
apply. :-)

Cheers,
Zoli (bzt)

>From a4d5c240d3b872a7ff1068de83d2080cd00e4517 Mon Sep 17 00:00:00 2001
From: bzt <bztemail@gmail.com>
Date: Tue, 24 Oct 2017 18:07:28 +0200
Subject: [PATCH] machine raspi3

Signed-off-by: bzt <bztemail@gmail.com>
---
 hw/arm/bcm2836.c         |  2 +-
 hw/arm/raspi.c           | 54
++++++++++++++++++++++++++++++++++++++----------
 include/hw/arm/bcm2836.h |  1 +
 3 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 8c43291..768f3c2 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -30,7 +30,7 @@ static void bcm2836_init(Object *obj)

     for (n = 0; n < BCM2836_NCPUS; n++) {
         object_initialize(&s->cpus[n], sizeof(s->cpus[n]),
-                          "cortex-a15-" TYPE_ARM_CPU);
+            s->version == 2 ? "cortex-a15-" TYPE_ARM_CPU : "cortex-a53-"
TYPE_ARM_CPU);
         object_property_add_child(obj, "cpu[*]", OBJECT(&s->cpus[n]),
                                   &error_abort);
     }
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 5941c9f..a74d57d 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -5,6 +5,8 @@
  * Rasperry Pi 2 emulation Copyright (c) 2015, Microsoft
  * Written by Andrew Baumann
  *
+ * Raspberry Pi 3 emulation 2017 by bzt
+ *
  * This code is licensed under the GNU GPLv2 and later.
  */

@@ -22,10 +24,13 @@
 #define SMPBOOT_ADDR    0x300 /* this should leave enough space for ATAGS
*/
 #define MVBAR_ADDR      0x400 /* secure vectors */
 #define BOARDSETUP_ADDR (MVBAR_ADDR + 0x20) /* board setup code */
-#define FIRMWARE_ADDR   0x8000 /* Pi loads kernel.img here by default */
+#define FIRMWARE_ADDR_2    0x8000 /* Pi 2 loads kernel.img here by default
*/
+#define FIRMWARE_ADDR_3   0x80000 /* Pi 3 loads kernel8.img here by
default */

 /* Table of Linux board IDs for different Pi versions */
-static const int raspi_boardid[] = {[1] = 0xc42, [2] = 0xc43};
+static const int raspi_boardid[]  = {[1] = 0xc42, [2] = 0xc43, [3] =
0xc44};
+/* Board revision IDs */
+static const int raspi_boardrev[] = {[1] = 0, [2] = 0xa21041, [3] =
0xa02082};

 typedef struct RasPiState {
     BCM2836State soc;
@@ -73,6 +78,7 @@ static void reset_secondary(ARMCPU *cpu, const struct
arm_boot_info *info)
 static void setup_boot(MachineState *machine, int version, size_t ram_size)
 {
     static struct arm_boot_info binfo;
+    hwaddr entry = 0;
     int r;

     binfo.board_id = raspi_boardid[version];
@@ -83,11 +89,12 @@ static void setup_boot(MachineState *machine, int
version, size_t ram_size)
     binfo.secure_board_setup = true;
     binfo.secure_boot = true;

-    /* Pi2 requires SMP setup */
-    if (version == 2) {
+    /* Pi2 and Pi3 requires SMP setup */
+    if (version == 2 || version == 3) {
         binfo.smp_loader_start = SMPBOOT_ADDR;
         binfo.write_secondary_boot = write_smpboot;
         binfo.secondary_cpu_reset_hook = reset_secondary;
+        entry = version == 2 ? FIRMWARE_ADDR_2 : FIRMWARE_ADDR_3;
     }

     /* If the user specified a "firmware" image (e.g. UEFI), we bypass
@@ -95,14 +102,14 @@ static void setup_boot(MachineState *machine, int
version, size_t ram_size)
      */
     if (machine->firmware) {
         /* load the firmware image (typically kernel.img) */
-        r = load_image_targphys(machine->firmware, FIRMWARE_ADDR,
-                                ram_size - FIRMWARE_ADDR);
+        r = load_image_targphys(machine->firmware, entry,
+                                ram_size - entry);
         if (r < 0) {
             error_report("Failed to load firmware from %s",
machine->firmware);
             exit(1);
         }

-        binfo.entry = FIRMWARE_ADDR;
+        binfo.entry = entry;
         binfo.firmware_loaded = true;
     } else {
         binfo.kernel_filename = machine->kernel_filename;
@@ -113,7 +120,7 @@ static void setup_boot(MachineState *machine, int
version, size_t ram_size)
     arm_load_kernel(ARM_CPU(first_cpu), &binfo);
 }

-static void raspi2_init(MachineState *machine)
+static void raspi_init(MachineState *machine, int version)
 {
     RasPiState *s = g_new0(RasPiState, 1);
     uint32_t vcram_size;
@@ -122,6 +129,7 @@ static void raspi2_init(MachineState *machine)
     BusState *bus;
     DeviceState *carddev;

+    s->soc.version = version;
     object_initialize(&s->soc, sizeof(s->soc), TYPE_BCM2836);
     object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
                               &error_abort);
@@ -137,8 +145,8 @@ static void raspi2_init(MachineState *machine)
                                    &error_abort);
     object_property_set_int(OBJECT(&s->soc), smp_cpus, "enabled-cpus",
                             &error_abort);
-    object_property_set_int(OBJECT(&s->soc), 0xa21041, "board-rev",
-                            &error_abort);
+    object_property_set_int(OBJECT(&s->soc), raspi_boardrev[version],
+                            "board-rev", &error_abort);
     object_property_set_bool(OBJECT(&s->soc), true, "realized",
&error_abort);

     /* Create and plug in the SD cards */
@@ -155,7 +163,12 @@ static void raspi2_init(MachineState *machine)

     vcram_size = object_property_get_uint(OBJECT(&s->soc), "vcram-size",
                                           &error_abort);
-    setup_boot(machine, 2, machine->ram_size - vcram_size);
+    setup_boot(machine, version, machine->ram_size - vcram_size);
+}
+
+static void raspi2_init(MachineState *machine)
+{
+    raspi_init(machine, 2);
 }

 static void raspi2_machine_init(MachineClass *mc)
@@ -171,3 +184,22 @@ static void raspi2_machine_init(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
 };
 DEFINE_MACHINE("raspi2", raspi2_machine_init)
+
+static void raspi3_init(MachineState *machine)
+{
+    raspi_init(machine, 3);
+}
+
+static void raspi3_machine_init(MachineClass *mc)
+{
+    mc->desc = "Raspberry Pi 3";
+    mc->init = raspi3_init;
+    mc->block_default_type = IF_SD;
+    mc->no_parallel = 1;
+    mc->no_floppy = 1;
+    mc->no_cdrom = 1;
+    mc->max_cpus = BCM2836_NCPUS;
+    mc->default_ram_size = 1024 * 1024 * 1024;
+    mc->ignore_memory_transaction_failures = true;
+};
+DEFINE_MACHINE("raspi3", raspi3_machine_init)
diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index 76de199..3c538f6 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -26,6 +26,7 @@ typedef struct BCM2836State {
     /*< public >*/

     uint32_t enabled_cpus;
+    uint version;

     ARMCPU cpus[BCM2836_NCPUS];
     BCM2836ControlState control;
-- 
2.14.2
