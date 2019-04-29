Received: from eggs.gnu.org ([209.51.188.92]:52505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hKyuO-0006OL-Va
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:32:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hKyuN-0005C7-29
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:32:56 -0400
Received: from mail-oln040092254067.outbound.protection.outlook.com
	([40.92.254.67]:65345
	helo=APC01-PU1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistair@alistair23.me>)
	id 1hKyuL-00059w-Lw
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:32:54 -0400
From: Alistair Francis <alistair@alistair23.me>
Date: Mon, 29 Apr 2019 05:32:45 +0000
Message-ID: <PSXP216MB0277192E4A6C255E30EFE627DD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
References: <cover.1556515687.git.alistair@alistair23.me>
In-Reply-To: <cover.1556515687.git.alistair@alistair23.me>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 1/5] armv7m: Allow entry information to be
 returned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>

Allow the kernel's entry point information to be returned when loading a
kernel.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 hw/arm/armv7m.c      | 6 +++---
 hw/arm/microbit.c    | 2 +-
 hw/arm/mps2-tz.c     | 3 ++-
 hw/arm/mps2.c        | 2 +-
 hw/arm/msf2-som.c    | 2 +-
 hw/arm/musca.c       | 3 ++-
 hw/arm/netduino2.c   | 2 +-
 hw/arm/stellaris.c   | 3 ++-
 include/hw/arm/arm.h | 4 +++-
 9 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index c4b2a9a1f5..a52328f188 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -286,10 +286,10 @@ static void armv7m_reset(void *opaque)
     cpu_reset(CPU(cpu));
 }
=20
-void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_=
size)
+void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_=
size,
+                        uint64_t *entry)
 {
     int image_size;
-    uint64_t entry;
     uint64_t lowaddr;
     int big_endian;
     AddressSpace *as;
@@ -311,7 +311,7 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kernel=
_filename, int mem_size)
=20
     if (kernel_filename) {
         image_size =3D load_elf_as(kernel_filename, NULL, NULL, NULL,
-                                 &entry, &lowaddr,
+                                 entry, &lowaddr,
                                  NULL, big_endian, EM_ARM, 1, 0, as);
         if (image_size < 0) {
             image_size =3D load_image_targphys_as(kernel_filename, 0,
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index da67bf6d9d..03147750f1 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -58,7 +58,7 @@ static void microbit_init(MachineState *machine)
                                         mr, -1);
=20
     armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
-                       NRF51_SOC(soc)->flash_size);
+                       NRF51_SOC(soc)->flash_size, NULL);
 }
=20
 static void microbit_machine_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index f79f090a4a..f6dc7dce2a 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -613,7 +613,8 @@ static void mps2tz_common_init(MachineState *machine)
=20
     create_unimplemented_device("FPGA NS PC", 0x48007000, 0x1000);
=20
-    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename, 0x400=
000);
+    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename, 0x400=
000,
+                       NULL);
 }
=20
 static void mps2_tz_idau_check(IDAUInterface *ii, uint32_t address,
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index e3d698ba6c..55d2273a54 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -328,7 +328,7 @@ static void mps2_common_init(MachineState *machine)
     system_clock_scale =3D NANOSECONDS_PER_SECOND / SYSCLK_FRQ;
=20
     armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
-                       0x400000);
+                       0x400000, NULL);
 }
=20
 static void mps2_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 2432b5e935..f81be74716 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -92,7 +92,7 @@ static void emcraft_sf2_s2s010_init(MachineState *machine=
)
     sysbus_connect_irq(SYS_BUS_DEVICE(&soc->spi[0]), 1, cs_line);
=20
     armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
-                       soc->envm_size);
+                       soc->envm_size, NULL);
 }
=20
 static void emcraft_sf2_machine_init(MachineClass *mc)
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 23aff43f4b..59460ba090 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -589,7 +589,8 @@ static void musca_init(MachineState *machine)
                                                      "cfg_sec_resp", 0));
     }
=20
-    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename, 0x200=
0000);
+    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename, 0x200=
0000,
+                       NULL);
 }
=20
 static void musca_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index f936017d4a..38a6d8fdd1 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -38,7 +38,7 @@ static void netduino2_init(MachineState *machine)
     object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
=20
     armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
-                       FLASH_SIZE);
+                       FLASH_SIZE, NULL);
 }
=20
 static void netduino2_machine_init(MachineClass *mc)
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 05f86749f4..276b1acc46 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1459,7 +1459,8 @@ static void stellaris_init(MachineState *ms, stellari=
s_board_info *board)
     create_unimplemented_device("hibernation", 0x400fc000, 0x1000);
     create_unimplemented_device("flash-control", 0x400fd000, 0x1000);
=20
-    armv7m_load_kernel(ARM_CPU(first_cpu), ms->kernel_filename, flash_size=
);
+    armv7m_load_kernel(ARM_CPU(first_cpu), ms->kernel_filename, flash_size=
,
+                       NULL);
 }
=20
 /* FIXME: Figure out how to generate these from stellaris_boards.  */
diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
index ffed39252d..10f7e10d95 100644
--- a/include/hw/arm/arm.h
+++ b/include/hw/arm/arm.h
@@ -28,12 +28,14 @@ typedef enum {
  * @cpu: CPU
  * @kernel_filename: file to load
  * @mem_size: mem_size: maximum image size to load
+ * @entry: location of the kernel's entry point
  *
  * Load the guest image for an ARMv7M system. This must be called by
  * any ARMv7M board. (This is necessary to ensure that the CPU resets
  * correctly on system reset, as well as for kernel loading.)
  */
-void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_=
size);
+void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_=
size,
+                        uint64_t *entry);
=20
 /* arm_boot.c */
 struct arm_boot_info {
--=20
2.21.0
