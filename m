Received: from eggs.gnu.org ([2001:4830:134:3::10]:45297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXV72-0004Jx-Cd
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXV6z-0001sl-DH
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:12:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dXV6z-0001sG-4Q
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:12:37 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 18 Jul 2017 12:12:27 -0400
Message-Id: <20170718161230.21917-2-jsnow@redhat.com>
In-Reply-To: <20170718161230.21917-1-jsnow@redhat.com>
References: <20170718161230.21917-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/4] ahci: add ahci_get_num_ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com

Instead of reaching into the PCI state, allow the AHCIDevice to
respond with how many ports it has.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20170623220926.11479-2-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/i386/pc_q35.c      | 4 ++--
 hw/ide/ahci.c         | 8 ++++++++
 hw/mips/boston.c      | 4 ++--
 include/hw/ide/ahci.h | 1 +
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 1653a47..169a214 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -242,8 +242,8 @@ static void pc_q35_init(MachineState *machine)
                                                true, "ich9-ahci");
         idebus[0] =3D qdev_get_child_bus(&ahci->qdev, "ide.0");
         idebus[1] =3D qdev_get_child_bus(&ahci->qdev, "ide.1");
-        g_assert(MAX_SATA_PORTS =3D=3D ICH_AHCI(ahci)->ahci.ports);
-        ide_drive_get(hd, ICH_AHCI(ahci)->ahci.ports);
+        g_assert(MAX_SATA_PORTS =3D=3D ahci_get_num_ports(ahci));
+        ide_drive_get(hd, ahci_get_num_ports(ahci));
         ahci_ide_create_devs(ahci, hd);
     } else {
         idebus[0] =3D idebus[1] =3D NULL;
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 874d3fe..e3cdbc8 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1833,6 +1833,14 @@ static void sysbus_ahci_register_types(void)
=20
 type_init(sysbus_ahci_register_types)
=20
+int32_t ahci_get_num_ports(PCIDevice *dev)
+{
+    AHCIPCIState *d =3D ICH_AHCI(dev);
+    AHCIState *ahci =3D &d->ahci;
+
+    return ahci->ports;
+}
+
 void ahci_ide_create_devs(PCIDevice *dev, DriveInfo **hd)
 {
     AHCIPCIState *d =3D ICH_AHCI(dev);
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 7985c60..776ee28 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -538,8 +538,8 @@ static void boston_mach_init(MachineState *machine)
     ahci =3D pci_create_simple_multifunction(&PCI_BRIDGE(&pcie2->root)->=
sec_bus,
                                            PCI_DEVFN(0, 0),
                                            true, TYPE_ICH9_AHCI);
-    g_assert(ARRAY_SIZE(hd) =3D=3D ICH_AHCI(ahci)->ahci.ports);
-    ide_drive_get(hd, ICH_AHCI(ahci)->ahci.ports);
+    g_assert(ARRAY_SIZE(hd) =3D=3D ahci_get_num_ports(ahci));
+    ide_drive_get(hd, ahci_get_num_ports(ahci));
     ahci_ide_create_devs(ahci, hd);
=20
     if (machine->firmware) {
diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index 0ca7c65..f866bbf 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -372,6 +372,7 @@ void ahci_uninit(AHCIState *s);
=20
 void ahci_reset(AHCIState *s);
=20
+int32_t ahci_get_num_ports(PCIDevice *dev);
 void ahci_ide_create_devs(PCIDevice *dev, DriveInfo **hd);
=20
 #define TYPE_SYSBUS_AHCI "sysbus-ahci"
--=20
2.9.4
