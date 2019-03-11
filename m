Received: from eggs.gnu.org ([209.51.188.92]:35972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6d-0000Qs-MN
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6b-0004mD-PK
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h3T6X-0004gE-MO
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D1BC30820E4
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:09:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 11 Mar 2019 23:08:41 +0100
Message-Id: <20190311220843.4026-26-armbru@redhat.com>
In-Reply-To: <20190311220843.4026-1-armbru@redhat.com>
References: <20190311220843.4026-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 25/27] pc_sysfw: Pass PCMachineState to
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

pc_system_firmware_init() parameter @isapc_ram_fw is PCMachineState
member pci_enabled negated.  The next commit will need more of
PCMachineState.  To prepare for that, pass a PCMachineState *, and
drop the now redundant parameter @isapc_ram_fw.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <20190308131445.17502-11-armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc.c         | 2 +-
 hw/i386/pc_sysfw.c   | 5 ++++-
 include/hw/i386/pc.h | 3 +--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c6d047b42b..d8572d3c00 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1809,7 +1809,7 @@ void pc_memory_init(PCMachineState *pcms,
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
