Received: from eggs.gnu.org ([2001:4830:134:3::10]:52482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fDU6P-0005as-EW
	for qemu-devel@nongnu.org; Tue, 01 May 2018 08:09:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fDU6O-0003Sl-Fu
	for qemu-devel@nongnu.org; Tue, 01 May 2018 08:09:49 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue,  1 May 2018 14:08:38 +0200
Message-Id: <1525176522-200354-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1525176522-200354-1-git-send-email-imammedo@redhat.com>
References: <1525176522-200354-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/5] pc: simplify
 MachineClass::get_hotplug_handler handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, eric.auger@redhat.com

By default MachineClass::get_hotplug_handler is NULL and concrete board
should set it to it's own handler.
Considering there isn't any default handler, drop saving empty
MachineClass::get_hotplug_handler in child class and make PC code
consistent with spapr/s390x boards.

We can bring this back when actual usecase surfaces and do it
consistently across boards that use get_hotplug_handler().

Suggested-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/i386/pc.h | 8 --------
 hw/i386/pc.c         | 6 +-----
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ffee841..fac6689 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -84,10 +84,6 @@ struct PCMachineState {
 /**
  * PCMachineClass:
  *
- * Methods:
- *
- * @get_hotplug_handler: pointer to parent class callback @get_hotplug_h=
andler
- *
  * Compat fields:
  *
  * @enforce_aligned_dimm: check that DIMM's address/size is aligned by
@@ -107,10 +103,6 @@ struct PCMachineClass {
=20
     /*< public >*/
=20
-    /* Methods: */
-    HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
-                                           DeviceState *dev);
-
     /* Device configuration: */
     bool pci_enabled;
     bool kvmclock_enabled;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b297a5d..018fd8d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2056,15 +2056,12 @@ static void pc_machine_device_unplug_cb(HotplugHa=
ndler *hotplug_dev,
 static HotplugHandler *pc_get_hotpug_handler(MachineState *machine,
                                              DeviceState *dev)
 {
-    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(machine);
-
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
         object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         return HOTPLUG_HANDLER(machine);
     }
=20
-    return pcmc->get_hotplug_handler ?
-        pcmc->get_hotplug_handler(machine, dev) : NULL;
+    return NULL;
 }
=20
 static void
@@ -2344,7 +2341,6 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
     HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
     NMIClass *nc =3D NMI_CLASS(oc);
=20
-    pcmc->get_hotplug_handler =3D mc->get_hotplug_handler;
     pcmc->pci_enabled =3D true;
     pcmc->has_acpi_build =3D true;
     pcmc->rsdp_in_ram =3D true;
--=20
2.7.4
