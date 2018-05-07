Received: from eggs.gnu.org ([2001:4830:134:3::10]:59504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fFe4s-0002IR-NL
	for qemu-devel@nongnu.org; Mon, 07 May 2018 07:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fFe4r-0007Cv-NA
	for qemu-devel@nongnu.org; Mon, 07 May 2018 07:13:10 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  7 May 2018 13:12:04 +0200
Message-Id: <1525691524-32265-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1525691524-32265-1-git-send-email-imammedo@redhat.com>
References: <1525691524-32265-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 4/4] make sure that we aren't overwriting
 mc->get_hotplug_handler by accident
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/arm/virt.c              | 1 +
 hw/i386/pc.c               | 1 +
 hw/ppc/e500plat.c          | 1 +
 hw/ppc/spapr.c             | 1 +
 hw/s390x/s390-virtio-ccw.c | 1 +
 5 files changed, 5 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 71661c6..9b0a931 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1578,6 +1578,7 @@ static void virt_machine_class_init(ObjectClass *oc=
, void *data)
     mc->cpu_index_to_instance_props =3D virt_cpu_index_to_props;
     mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a15");
     mc->get_default_cpu_node_id =3D virt_get_default_cpu_node_id;
+    assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler =3D virt_machine_get_hotplug_handler;
     hc->plug =3D virt_machine_device_plug_cb;
 }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 018fd8d..019be25 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2355,6 +2355,7 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
     pcmc->acpi_data_size =3D 0x20000 + 0x8000;
     pcmc->save_tsc_khz =3D true;
     pcmc->linuxboot_dma_enabled =3D true;
+    assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler =3D pc_get_hotpug_handler;
     mc->cpu_index_to_instance_props =3D pc_cpu_index_to_props;
     mc->get_default_cpu_node_id =3D pc_get_default_cpu_node_id;
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index 1a469ba..d8e3f20 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -74,6 +74,7 @@ static void e500plat_machine_class_init(ObjectClass *oc=
, void *data)
     HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
     MachineClass *mc =3D MACHINE_CLASS(oc);
=20
+    assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler =3D e500plat_machine_get_hotpug_handler;
     hc->plug =3D e500plat_machine_device_plug_cb;
=20
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 32ab3c4..1a4cf42 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3977,6 +3977,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     mc->kvm_type =3D spapr_kvm_type;
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SPAPR_PCI_HOST_BRIDG=
E);
     mc->pci_allow_0_address =3D true;
+    assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler =3D spapr_get_hotplug_handler;
     hc->pre_plug =3D spapr_machine_device_pre_plug;
     hc->plug =3D spapr_machine_device_plug;
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 100dfdc..5796e24 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -491,6 +491,7 @@ static void ccw_machine_class_init(ObjectClass *oc, v=
oid *data)
     mc->no_sdcard =3D 1;
     mc->max_cpus =3D S390_MAX_CPUS;
     mc->has_hotpluggable_cpus =3D true;
+    assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler =3D s390_get_hotplug_handler;
     mc->cpu_index_to_instance_props =3D s390_cpu_index_to_props;
     mc->possible_cpu_arch_ids =3D s390_possible_cpu_arch_ids;
--=20
2.7.4
