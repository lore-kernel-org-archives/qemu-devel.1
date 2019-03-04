Received: from eggs.gnu.org ([209.51.188.92]:43045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0tap-0001wi-Cw
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 14:49:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0tao-0000mX-Fr
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 14:49:43 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  4 Mar 2019 20:48:56 +0100
Message-Id: <20190304194857.9780-4-philmd@redhat.com>
In-Reply-To: <20190304194857.9780-1-philmd@redhat.com>
References: <20190304194857.9780-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/4] hw/i386/pc_sysfw: Let
 pc_system_firmware_init() access PCMachineState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

PCMachineState will be used in the next patch.
Since We can access PCMachineClass from it, directly use it.
We can also access pcmc->pci_enabled, remove the isapc_ram_fw
argument.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
[PMD: Extracted from bigger patch]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/pc.c         | 2 +-
 hw/i386/pc_sysfw.c   | 8 +++++---
 include/hw/i386/pc.h | 3 +--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3889eccdc3..3cd8ed1794 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1830,7 +1830,7 @@ void pc_memory_init(PCMachineState *pcms,
     }
=20
     /* Initialize PC system firmware */
-    pc_system_firmware_init(rom_memory, !pcmc->pci_enabled);
+    pc_system_firmware_init(pcms, rom_memory);
=20
     option_rom_mr =3D g_malloc(sizeof(*option_rom_mr));
     memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 46b87afe23..55a3c563df 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -231,15 +231,17 @@ static void old_pc_system_rom_init(MemoryRegion *ro=
m_memory, bool isapc_ram_fw)
                                 bios);
 }
=20
-void pc_system_firmware_init(MemoryRegion *rom_memory, bool isapc_ram_fw=
)
+void pc_system_firmware_init(PCMachineState *pcms,
+                             MemoryRegion *rom_memory)
 {
+    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
     DriveInfo *pflash_drv;
=20
     pflash_drv =3D drive_get(IF_PFLASH, 0, 0);
=20
-    if (isapc_ram_fw || pflash_drv =3D=3D NULL) {
+    if (!pcmc->pci_enabled || pflash_drv =3D=3D NULL) {
         /* When a pflash drive is not found, use rom-mode */
-        old_pc_system_rom_init(rom_memory, isapc_ram_fw);
+        old_pc_system_rom_init(rom_memory, true);
         return;
     }
=20
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 3ff127ebd0..eb7360feac 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -278,8 +278,7 @@ extern PCIDevice *piix4_dev;
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
2.20.1
