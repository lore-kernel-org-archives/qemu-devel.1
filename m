Received: from eggs.gnu.org ([2001:4830:134:3::10]:60854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ga3G4-0006Vp-D6
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:41:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ga3Fv-00033k-Iv
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:41:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ga3Fn-0001yc-5n
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:41:05 -0500
Date: Thu, 20 Dec 2018 13:40:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181220183059.20726-43-mst@redhat.com>
References: <20181220183059.20726-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220183059.20726-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v3 42/44] q35: set split kernel irqchip as
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>

From: Peter Xu <peterx@redhat.com>

Starting from QEMU 4.0, let's specify "split" as the default value for
kernel-irqchip.

So for QEMU>=4.0 we'll have: allowed=Y,required=N,split=Y
   for QEMU<=3.1 we'll have: allowed=Y,required=N,split=N
   (omitting all the "kernel_irqchip_" prefix)

Note that this will let the default q35 machine type to depend on
Linux version 4.4 or newer because that's where split irqchip is
introduced in kernel.  But it's fine since we're boosting supported
Linux version for QEMU 4.0 to around Linux 4.5.  For more information
please refer to the discussion on AMD's RDTSCP:

  https://lore.kernel.org/lkml/20181210181328.GA762@zn.tnic/

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/boards.h | 1 +
 hw/core/machine.c   | 2 ++
 hw/i386/pc_q35.c    | 2 ++
 3 files changed, 5 insertions(+)

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
index 8836d21485..0a3f3f18e4 100644
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
-- 
MST
