Received: from eggs.gnu.org ([2001:4830:134:3::10]:41403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmML-0005a9-TP
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmMD-0004uG-Tm
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWmMD-0004tb-Gt
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:09 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 11 Dec 2018 16:01:15 -0200
Message-Id: <20181211180129.7661-11-ehabkost@redhat.com>
In-Reply-To: <20181211180129.7661-1-ehabkost@redhat.com>
References: <20181211180129.7661-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/24] i386: Rename bools in PCMachineState to
 end in _enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Corey Minyard <cminyard@mvista.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

From: Corey Minyard <cminyard@mvista.com>

This makes their function more clear and prevents conflicts when adding
the actual devices to the machine state, if necessary.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20181107152434.22219-1-minyard@acm.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/i386/pc.h |  6 +++---
 hw/i386/pc.c         | 18 +++++++++---------
 hw/i386/pc_piix.c    |  3 ++-
 hw/i386/pc_q35.c     |  6 +++---
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 136fe497b6..7bb52b4762 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -49,9 +49,9 @@ struct PCMachineState {
     AcpiNVDIMMState acpi_nvdimm_state;
=20
     bool acpi_build_enabled;
-    bool smbus;
-    bool sata;
-    bool pit;
+    bool smbus_enabled;
+    bool sata_enabled;
+    bool pit_enabled;
=20
     /* RAM information (sizes, addresses, configuration): */
     ram_addr_t below_4g_mem_size, above_4g_mem_size;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f095725dba..4cd2fbca4d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2222,42 +2222,42 @@ static bool pc_machine_get_smbus(Object *obj, Err=
or **errp)
 {
     PCMachineState *pcms =3D PC_MACHINE(obj);
=20
-    return pcms->smbus;
+    return pcms->smbus_enabled;
 }
=20
 static void pc_machine_set_smbus(Object *obj, bool value, Error **errp)
 {
     PCMachineState *pcms =3D PC_MACHINE(obj);
=20
-    pcms->smbus =3D value;
+    pcms->smbus_enabled =3D value;
 }
=20
 static bool pc_machine_get_sata(Object *obj, Error **errp)
 {
     PCMachineState *pcms =3D PC_MACHINE(obj);
=20
-    return pcms->sata;
+    return pcms->sata_enabled;
 }
=20
 static void pc_machine_set_sata(Object *obj, bool value, Error **errp)
 {
     PCMachineState *pcms =3D PC_MACHINE(obj);
=20
-    pcms->sata =3D value;
+    pcms->sata_enabled =3D value;
 }
=20
 static bool pc_machine_get_pit(Object *obj, Error **errp)
 {
     PCMachineState *pcms =3D PC_MACHINE(obj);
=20
-    return pcms->pit;
+    return pcms->pit_enabled;
 }
=20
 static void pc_machine_set_pit(Object *obj, bool value, Error **errp)
 {
     PCMachineState *pcms =3D PC_MACHINE(obj);
=20
-    pcms->pit =3D value;
+    pcms->pit_enabled =3D value;
 }
=20
 static void pc_machine_initfn(Object *obj)
@@ -2271,9 +2271,9 @@ static void pc_machine_initfn(Object *obj)
     pcms->acpi_nvdimm_state.is_enabled =3D false;
     /* acpi build is enabled by default if machine supports it */
     pcms->acpi_build_enabled =3D PC_MACHINE_GET_CLASS(pcms)->has_acpi_bu=
ild;
-    pcms->smbus =3D true;
-    pcms->sata =3D true;
-    pcms->pit =3D true;
+    pcms->smbus_enabled =3D true;
+    pcms->sata_enabled =3D true;
+    pcms->pit_enabled =3D true;
 }
=20
 static void pc_machine_reset(void)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 7092d6d13f..2d996162f1 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -239,7 +239,8 @@ static void pc_init1(MachineState *machine,
=20
     /* init basic PC hardware */
     pc_basic_device_init(isa_bus, pcms->gsi, &rtc_state, true,
-                         (pcms->vmport !=3D ON_OFF_AUTO_ON), pcms->pit, =
0x4);
+                         (pcms->vmport !=3D ON_OFF_AUTO_ON), pcms->pit_e=
nabled,
+                         0x4);
=20
     pc_nic_init(pcmc, isa_bus, pci_bus);
=20
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 4702bb13c4..6e3d81f5be 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -236,13 +236,13 @@ static void pc_q35_init(MachineState *machine)
=20
     /* init basic PC hardware */
     pc_basic_device_init(isa_bus, pcms->gsi, &rtc_state, !mc->no_floppy,
-                         (pcms->vmport !=3D ON_OFF_AUTO_ON), pcms->pit,
+                         (pcms->vmport !=3D ON_OFF_AUTO_ON), pcms->pit_e=
nabled,
                          0xff0104);
=20
     /* connect pm stuff to lpc */
     ich9_lpc_pm_init(lpc, pc_machine_is_smm_enabled(pcms));
=20
-    if (pcms->sata) {
+    if (pcms->sata_enabled) {
         /* ahci and SATA device, for q35 1 ahci controller is built-in *=
/
         ahci =3D pci_create_simple_multifunction(host_bus,
                                                PCI_DEVFN(ICH9_SATA1_DEV,
@@ -262,7 +262,7 @@ static void pc_q35_init(MachineState *machine)
         ehci_create_ich9_with_companions(host_bus, 0x1d);
     }
=20
-    if (pcms->smbus) {
+    if (pcms->smbus_enabled) {
         /* TODO: Populate SPD eeprom data.  */
         smbus_eeprom_init(ich9_smb_init(host_bus,
                                         PCI_DEVFN(ICH9_SMB_DEV, ICH9_SMB=
_FUNC),
--=20
2.18.0.rc1.1.g3f1ff2140
