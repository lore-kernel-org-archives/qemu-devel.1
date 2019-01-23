Received: from eggs.gnu.org ([209.51.188.92]:34620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmFZY-0001WX-7f
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:15:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmFZT-0007JI-VL
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:15:50 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 23 Jan 2019 11:14:45 +0100
Message-Id: <20190123101458.12478-6-eric.auger@redhat.com>
In-Reply-To: <20190123101458.12478-1-eric.auger@redhat.com>
References: <20190123101458.12478-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 05/18] hw/arm/virt: Move memory map
 initialization into machvirt_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com
Cc: dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com

This patch moves the memory map setup into machvirt_init().
The rationale is the memory map will be soon affected by the
kvm_type() call that happens after virt_instance_init().

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ba4088895a..ea1fb3ddfd 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1359,6 +1359,22 @@ static uint64_t virt_cpu_mp_affinity(VirtMachineSt=
ate *vms, int idx)
     return arm_cpu_mp_affinity(idx, clustersz);
 }
=20
+static void set_memory_map(VirtMachineState *vms)
+{
+    int i;
+
+    vms->memmap =3D extended_memmap;
+
+    for (i =3D 0; i < ARRAY_SIZE(a15memmap); i++) {
+        vms->memmap[i] =3D a15memmap[i];
+    }
+
+    for (i =3D VIRT_LOWMEMMAP_LAST; i < ARRAY_SIZE(extended_memmap); i++=
) {
+        vms->memmap[i].base =3D extended_memmap[i].base + vms->high_io_b=
ase;
+        vms->memmap[i].size =3D extended_memmap[i].size;
+    }
+}
+
 static void machvirt_init(MachineState *machine)
 {
     VirtMachineState *vms =3D VIRT_MACHINE(machine);
@@ -1373,6 +1389,8 @@ static void machvirt_init(MachineState *machine)
     bool firmware_loaded =3D bios_name || drive_get(IF_PFLASH, 0, 0);
     bool aarch64 =3D true;
=20
+    set_memory_map(vms);
+
     /* We can probe only here because during property set
      * KVM is not available yet
      */
@@ -1786,7 +1804,6 @@ static void virt_instance_init(Object *obj)
 {
     VirtMachineState *vms =3D VIRT_MACHINE(obj);
     VirtMachineClass *vmc =3D VIRT_MACHINE_GET_CLASS(vms);
-    int i;
=20
     /* EL3 is disabled by default on virt: this makes us consistent
      * between KVM and TCG for this board, and it also allows us to
@@ -1849,18 +1866,7 @@ static void virt_instance_init(Object *obj)
                                     "Valid values are none and smmuv3",
                                     NULL);
=20
-    vms->memmap =3D extended_memmap;
-
-    for (i =3D 0; i < ARRAY_SIZE(a15memmap); i++) {
-        vms->memmap[i] =3D a15memmap[i];
-    }
-
-    vms->high_io_base =3D S_256GiB; /* Top of the RAM */
-
-    for (i =3D VIRT_LOWMEMMAP_LAST; i < ARRAY_SIZE(extended_memmap); i++=
) {
-        vms->memmap[i].base =3D extended_memmap[i].base + vms->high_io_b=
ase;
-        vms->memmap[i].size =3D extended_memmap[i].size;
-    }
+    vms->high_io_base =3D S_256GiB; /* default RAM top */
     vms->irqmap =3D a15irqmap;
 }
=20
--=20
2.20.1
