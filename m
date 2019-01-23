Received: from eggs.gnu.org ([209.51.188.92]:50726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gm6vk-0007Bt-14
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 20:02:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gm6vh-0002Tg-Sp
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 20:02:11 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:45209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gm6vh-0002P5-JV
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 20:02:09 -0500
Received: by mail-wr1-x42c.google.com with SMTP id t6so434392wrr.12
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 17:02:07 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 23 Jan 2019 02:02:02 +0100
Message-Id: <1548205322-36101-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548205322-36101-1-git-send-email-pbonzini@redhat.com>
References: <1548205322-36101-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 33/51] hw/i386/pc: enable PVH only for machine
 type >= 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>

From: Stefano Garzarella <sgarzare@redhat.com>

In order to avoid migration issues, we enable PVH only for
machine type >= 4.0

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c         | 4 +++-
 hw/i386/pc_piix.c    | 3 +++
 hw/i386/pc_q35.c     | 3 +++
 include/hw/i386/pc.h | 3 +++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2833b13..3be4a06 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1211,7 +1211,8 @@ static void load_linux(PCMachineState *pcms,
          * saving the PVH entry point used by the x86/HVM direct boot ABI.
          * If load_elfboot() is successful, populate the fw_cfg info.
          */
-        if (load_elfboot(kernel_filename, kernel_size,
+        if (pcmc->pvh_enabled &&
+            load_elfboot(kernel_filename, kernel_size,
                          header, pvh_start_addr, fw_cfg)) {
             fclose(f);
 
@@ -2774,6 +2775,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->acpi_data_size = 0x20000 + 0x8000;
     pcmc->save_tsc_khz = true;
     pcmc->linuxboot_dma_enabled = true;
+    pcmc->pvh_enabled = true;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = pc_get_hotpug_handler;
     mc->cpu_index_to_instance_props = pc_cpu_index_to_props;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 63c84e3..fd0f2c2 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -440,9 +440,12 @@ DEFINE_I440FX_MACHINE(v4_0, "pc-i440fx-4.0", NULL,
 
 static void pc_i440fx_3_1_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_i440fx_4_0_machine_options(m);
     m->is_default = 0;
     m->alias = NULL;
+    pcmc->pvh_enabled = false;
     compat_props_add(m->compat_props, hw_compat_3_1, hw_compat_3_1_len);
     compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index b7b7959..4a175ea 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -376,9 +376,12 @@ DEFINE_Q35_MACHINE(v4_0, "pc-q35-4.0", NULL,
 
 static void pc_q35_3_1_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_q35_4_0_machine_options(m);
     m->default_kernel_irqchip_split = false;
     m->alias = NULL;
+    pcmc->pvh_enabled = false;
     compat_props_add(m->compat_props, hw_compat_3_1, hw_compat_3_1_len);
     compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
 }
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 0abbe45..e4e2c13 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -133,6 +133,9 @@ struct PCMachineClass {
 
     /* use DMA capable linuxboot option rom */
     bool linuxboot_dma_enabled;
+
+    /* use PVH to load kernels that support this feature */
+    bool pvh_enabled;
 };
 
 #define TYPE_PC_MACHINE "generic-pc-machine"
-- 
1.8.3.1
