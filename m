Received: from eggs.gnu.org ([2001:4830:134:3::10]:36594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emOPG-0006Ka-My
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emOPF-0004LM-B6
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:18 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1emOPE-0004Jp-S1
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:17 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1emOPD-00028z-JP
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 18:37:15 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 18:37:00 +0000
Message-Id: <20180215183700.26101-21-peter.maydell@linaro.org>
In-Reply-To: <20180215183700.26101-1-peter.maydell@linaro.org>
References: <20180215183700.26101-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/20] raspi: Raspberry Pi 3 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Pekka Enberg <penberg@iki.fi>

This patch adds Raspberry Pi 3 support to hw/arm/raspi.c. The
differences to Pi 2 are:

 - Firmware address
 - Board ID
 - Board revision

The CPU is different too, but that's going to be configured as part of
the machine default CPU when we introduce a new machine type.

The patch was written from scratch by me but the logic is similar to
Zoltán Baldaszti's previous work, which I used as a reference (with
permission from the author):

  https://github.com/bztsrc/qemu-raspi3

Signed-off-by: Pekka Enberg <penberg@iki.fi>
[PMM: fixed trailing whitespace on one line]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index c24a4a1b14..93121c56bf 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -5,6 +5,9 @@
  * Rasperry Pi 2 emulation Copyright (c) 2015, Microsoft
  * Written by Andrew Baumann
  *
+ * Raspberry Pi 3 emulation Copyright (c) 2018 Zoltán Baldaszti
+ * Upstream code cleanup (c) 2018 Pekka Enberg
+ *
  * This code is licensed under the GNU GPLv2 and later.
  */
 
@@ -22,10 +25,11 @@
 #define SMPBOOT_ADDR    0x300 /* this should leave enough space for ATAGS */
 #define MVBAR_ADDR      0x400 /* secure vectors */
 #define BOARDSETUP_ADDR (MVBAR_ADDR + 0x20) /* board setup code */
-#define FIRMWARE_ADDR   0x8000 /* Pi loads kernel.img here by default */
+#define FIRMWARE_ADDR_2 0x8000 /* Pi 2 loads kernel.img here by default */
+#define FIRMWARE_ADDR_3 0x80000 /* Pi 3 loads kernel.img here by default */
 
 /* Table of Linux board IDs for different Pi versions */
-static const int raspi_boardid[] = {[1] = 0xc42, [2] = 0xc43};
+static const int raspi_boardid[] = {[1] = 0xc42, [2] = 0xc43, [3] = 0xc44};
 
 typedef struct RasPiState {
     BCM2836State soc;
@@ -83,8 +87,8 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
     binfo.secure_board_setup = true;
     binfo.secure_boot = true;
 
-    /* Pi2 requires SMP setup */
-    if (version == 2) {
+    /* Pi2 and Pi3 requires SMP setup */
+    if (version >= 2) {
         binfo.smp_loader_start = SMPBOOT_ADDR;
         binfo.write_secondary_boot = write_smpboot;
         binfo.secondary_cpu_reset_hook = reset_secondary;
@@ -94,15 +98,16 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
      * the normal Linux boot process
      */
     if (machine->firmware) {
+        hwaddr firmware_addr = version == 3 ? FIRMWARE_ADDR_3 : FIRMWARE_ADDR_2;
         /* load the firmware image (typically kernel.img) */
-        r = load_image_targphys(machine->firmware, FIRMWARE_ADDR,
-                                ram_size - FIRMWARE_ADDR);
+        r = load_image_targphys(machine->firmware, firmware_addr,
+                                ram_size - firmware_addr);
         if (r < 0) {
             error_report("Failed to load firmware from %s", machine->firmware);
             exit(1);
         }
 
-        binfo.entry = FIRMWARE_ADDR;
+        binfo.entry = firmware_addr;
         binfo.firmware_loaded = true;
     } else {
         binfo.kernel_filename = machine->kernel_filename;
@@ -113,7 +118,7 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
     arm_load_kernel(ARM_CPU(first_cpu), &binfo);
 }
 
-static void raspi2_init(MachineState *machine)
+static void raspi_init(MachineState *machine, int version)
 {
     RasPiState *s = g_new0(RasPiState, 1);
     uint32_t vcram_size;
@@ -139,7 +144,8 @@ static void raspi2_init(MachineState *machine)
                             &error_abort);
     object_property_set_int(OBJECT(&s->soc), smp_cpus, "enabled-cpus",
                             &error_abort);
-    object_property_set_int(OBJECT(&s->soc), 0xa21041, "board-rev",
+    int board_rev = version == 3 ? 0xa02082 : 0xa21041;
+    object_property_set_int(OBJECT(&s->soc), board_rev, "board-rev",
                             &error_abort);
     object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_abort);
 
@@ -157,7 +163,12 @@ static void raspi2_init(MachineState *machine)
 
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
-- 
2.16.1
