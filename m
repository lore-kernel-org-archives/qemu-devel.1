Received: from eggs.gnu.org ([209.51.188.92]:36489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2FLF-0004yK-UN
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:15:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2FLE-0007NX-2E
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:15:12 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  8 Mar 2019 14:14:43 +0100
Message-Id: <20190308131445.17502-11-armbru@redhat.com>
In-Reply-To: <20190308131445.17502-1-armbru@redhat.com>
References: <20190308131445.17502-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 10/12] pc_sysfw: Pass PCMachineState to
 pc_system_firmware_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, pkrempa@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, philmd@redhat.com

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

pc_system_firmware_init() parameter @isapc_ram_fw is PCMachineState
member pci_enabled negated.  The next commit will need more of
PCMachineState.  To prepare for that, pass a PCMachineState *, and
drop the now redundant parameter @isapc_ram_fw.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
---
 hw/i386/pc.c         | 2 +-
 hw/i386/pc_sysfw.c   | 5 ++++-
 include/hw/i386/pc.h | 3 +--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 42128183e9..b2947e433b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1803,7 +1803,7 @@ void pc_memory_init(PCMachineState *pcms,
     }
=20
     /* Initialize PC system firmware */
-    pc_system_firmware_init(rom_memory, !pcmc->pci_enabled);
+    pc_system_firmware_init(pcms, rom_memory);
=20
     option_rom_mr =3D g_malloc(sizeof(*option_rom_mr));
     memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 46b87afe23..785123252c 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -231,8 +231,11 @@ static void old_pc_system_rom_init(MemoryRegion *rom=
_memory, bool isapc_ram_fw)
                                 bios);
 }
=20
-void pc_system_firmware_init(MemoryRegion *rom_memory, bool isapc_ram_fw=
)
+void pc_system_firmware_init(PCMachineState *pcms,
+                             MemoryRegion *rom_memory)
 {
+    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
+    bool isapc_ram_fw =3D !pcmc->pci_enabled;
     DriveInfo *pflash_drv;
=20
     pflash_drv =3D drive_get(IF_PFLASH, 0, 0);
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 54222a202d..4f5ed7cefc 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -277,8 +277,7 @@ extern PCIDevice *piix4_dev;
 int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn);
=20
 /* pc_sysfw.c */
-void pc_system_firmware_init(MemoryRegion *rom_memory,
-                             bool isapc_ram_fw);
+void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_mem=
ory);
=20
 /* acpi-build.c */
 void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
--=20
2.17.2
