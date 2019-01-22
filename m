Received: from eggs.gnu.org ([209.51.188.92]:45726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gm14Q-0004Aj-55
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:46:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gm14O-000507-3p
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:46:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gm14N-0004a4-Mz
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:46:43 -0500
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 22 Jan 2019 13:10:48 +0100
Message-Id: <20190122121048.76469-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] hw/i386/pc: enable PVH only for machine type
 >= 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Liam Merwick <liam.merwick@oracle.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

In order to avoid migration issues, we enable PVH only for
machine type >=3D 4.0

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
Based-on: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>

 hw/i386/pc.c         | 4 +++-
 hw/i386/pc_piix.c    | 3 +++
 hw/i386/pc_q35.c     | 3 +++
 include/hw/i386/pc.h | 3 +++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2833b130ba..3be4a06c4f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1211,7 +1211,8 @@ static void load_linux(PCMachineState *pcms,
          * saving the PVH entry point used by the x86/HVM direct boot AB=
I.
          * If load_elfboot() is successful, populate the fw_cfg info.
          */
-        if (load_elfboot(kernel_filename, kernel_size,
+        if (pcmc->pvh_enabled &&
+            load_elfboot(kernel_filename, kernel_size,
                          header, pvh_start_addr, fw_cfg)) {
             fclose(f);
=20
@@ -2774,6 +2775,7 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
     pcmc->acpi_data_size =3D 0x20000 + 0x8000;
     pcmc->save_tsc_khz =3D true;
     pcmc->linuxboot_dma_enabled =3D true;
+    pcmc->pvh_enabled =3D true;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler =3D pc_get_hotpug_handler;
     mc->cpu_index_to_instance_props =3D pc_cpu_index_to_props;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 5088e2f492..a51b83e50e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -440,9 +440,12 @@ DEFINE_I440FX_MACHINE(v4_0, "pc-i440fx-4.0", NULL,
=20
 static void pc_i440fx_3_1_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
+
     pc_i440fx_4_0_machine_options(m);
     m->is_default =3D 0;
     m->alias =3D NULL;
+    pcmc->pvh_enabled =3D false;
     compat_props_add(m->compat_props, hw_compat_3_1, hw_compat_3_1_len);
     compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index b7b7959934..4a175ea50e 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -376,9 +376,12 @@ DEFINE_Q35_MACHINE(v4_0, "pc-q35-4.0", NULL,
=20
 static void pc_q35_3_1_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
+
     pc_q35_4_0_machine_options(m);
     m->default_kernel_irqchip_split =3D false;
     m->alias =3D NULL;
+    pcmc->pvh_enabled =3D false;
     compat_props_add(m->compat_props, hw_compat_3_1, hw_compat_3_1_len);
     compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
 }
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 0abbe45637..e4e2c1352d 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -133,6 +133,9 @@ struct PCMachineClass {
=20
     /* use DMA capable linuxboot option rom */
     bool linuxboot_dma_enabled;
+
+    /* use PVH to load kernels that support this feature */
+    bool pvh_enabled;
 };
=20
 #define TYPE_PC_MACHINE "generic-pc-machine"
--=20
2.20.1
