Received: from eggs.gnu.org ([2001:4830:134:3::10]:34559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gZXZ9-0008Qk-Oq
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 03:50:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gZXZ8-0004D8-Bn
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 03:50:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gZXZ8-0004CY-3b
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 03:50:54 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0C47DCD191
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 08:50:53 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 19 Dec 2018 16:50:36 +0800
Message-Id: <20181219085038.7729-3-peterx@redhat.com>
In-Reply-To: <20181219085038.7729-1-peterx@redhat.com>
References: <20181219085038.7729-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] q35: set split kernel irqchip as default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

Starting from QEMU 4.0, let's specify "split" as the default value for
kernel-irqchip.

So for QEMU>=4.0 we'll have: allowed=Y,required=N,split=Y
   for QEMU<=3.1 we'll have: allowed=Y,required=N,split=N
   (omitting all the "kernel_irqchip_" prefix)

Note that this "split" is optional - we'll first try to enable split
kernel irqchip, and we'll fall back to complete kernel irqchip if we
found that the kernel capability is missing.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/core/machine.c   | 2 ++
 hw/i386/pc_q35.c    | 2 ++
 include/hw/boards.h | 1 +
 3 files changed, 5 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index c51423b647..4439ea663f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -653,8 +653,10 @@ static void machine_class_base_init(ObjectClass *oc, void *data)
 static void machine_initfn(Object *obj)
 {
     MachineState *ms = MACHINE(obj);
+    MachineClass *mc = MACHINE_GET_CLASS(obj);
 
     ms->kernel_irqchip_allowed = true;
+    ms->kernel_irqchip_split = mc->default_kernel_irqchip_split;
     ms->kvm_shadow_mem = -1;
     ms->dump_guest_core = true;
     ms->mem_merge = true;
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 58459bdab5..d2fb0fa49f 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -304,6 +304,7 @@ static void pc_q35_machine_options(MachineClass *m)
     m->units_per_default_bus = 1;
     m->default_machine_opts = "firmware=bios-256k.bin";
     m->default_display = "std";
+    m->default_kernel_irqchip_split = true;
     m->no_floppy = 1;
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
@@ -323,6 +324,7 @@ DEFINE_Q35_MACHINE(v4_0, "pc-q35-4.0", NULL,
 static void pc_q35_3_1_machine_options(MachineClass *m)
 {
     pc_q35_4_0_machine_options(m);
+    m->default_kernel_irqchip_split = false;
     m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_3_1);
 }
diff --git a/include/hw/boards.h b/include/hw/boards.h
index f82f28468b..362384815e 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -195,6 +195,7 @@ struct MachineClass {
     const char *hw_version;
     ram_addr_t default_ram_size;
     const char *default_cpu_type;
+    bool default_kernel_irqchip_split;
     bool option_rom_has_mr;
     bool rom_file_has_mr;
     int minimum_page_bits;
-- 
2.17.1
