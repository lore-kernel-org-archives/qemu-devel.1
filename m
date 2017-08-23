Received: from eggs.gnu.org ([2001:4830:134:3::10]:40864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1dkOg1-0004O2-Lw
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 01:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1dkOg0-0003X6-8e
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 01:58:05 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:34145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1dkOg0-0003Ww-0G
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 01:58:04 -0400
Received: by mail-pf0-x242.google.com with SMTP id m6so726508pfm.1
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 22:58:03 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Wed, 23 Aug 2017 14:57:12 +0900
Message-Id: <b12db1e3daefa777fe0025c71ac30a816a126653.1503467674.git.shorne@gmail.com>
In-Reply-To: <cover.1503467674.git.shorne@gmail.com>
References: <cover.1503467674.git.shorne@gmail.com>
In-Reply-To: <cover.1503467674.git.shorne@gmail.com>
References: <cover.1503467674.git.shorne@gmail.com>
Subject: [Qemu-devel] [PATCH 4/5] openrisc: Initial SMP support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, Openrisc <openrisc@lists.librecores.org>, Stafford Horne <shorne@gmail.com>

Wire in ompic and add basic support for SMP.  The OpenRISC is special in
that interrupts for devices are routed to each core's PIC.  This is
achieved using the qemu_irq_split utility, but this currently limits
OpenRISC to 2 cores.

This models the reference architecture described in the OpenRISC spec
1.2 proposal.

  https://github.com/stffrdhrn/doc/raw/arch-1.2-proposal/openrisc-arch-1.2-rev0.pdf

The changes to the intialization of the sim include:

CPU Reset
 o Reset each cpu to the bootstrap PC rather than only a single cpu as
   done before.
 o During Kernel loading the bootstrap PC is saved in a static global.

Network Initialization
 o Connect the interrupt to each CPU
 o Use more simple sysbus_mmio_map() rather than memory_region_add_subregion()

Sim Initialization
 o Initialize the pic and tick timer per cpu
 o Wire in the OMPIC if SMP is enabled
 o Wire the serial irq to each CPU using qemu_irq_split()

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 hw/openrisc/openrisc_sim.c | 84 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 23 deletions(-)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 44a657753d..f06a3e111b 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -35,36 +35,60 @@
 
 #define KERNEL_LOAD_ADDR 0x100
 
+static struct openrisc_boot_info {
+    uint32_t bootstrap_pc;
+} boot_info;
+
 static void main_cpu_reset(void *opaque)
 {
     OpenRISCCPU *cpu = opaque;
+    CPUState *cs = CPU(cpu);
 
     cpu_reset(CPU(cpu));
+
+    cpu_set_pc(cs, boot_info.bootstrap_pc);
 }
 
-static void openrisc_sim_net_init(MemoryRegion *address_space,
-                                  hwaddr base,
-                                  hwaddr descriptors,
-                                  qemu_irq irq, NICInfo *nd)
+static void openrisc_sim_net_init(hwaddr base, hwaddr descriptors,
+                                  int num_cpus, qemu_irq **cpu_irqs,
+                                  int irq_pin, NICInfo *nd)
 {
     DeviceState *dev;
     SysBusDevice *s;
+    int i;
 
     dev = qdev_create(NULL, "open_eth");
     qdev_set_nic_properties(dev, nd);
     qdev_init_nofail(dev);
 
     s = SYS_BUS_DEVICE(dev);
-    sysbus_connect_irq(s, 0, irq);
-    memory_region_add_subregion(address_space, base,
-                                sysbus_mmio_get_region(s, 0));
-    memory_region_add_subregion(address_space, descriptors,
-                                sysbus_mmio_get_region(s, 1));
+    for (i = 0; i < num_cpus; i++) {
+        sysbus_connect_irq(s, 0, cpu_irqs[i][irq_pin]);
+    }
+    sysbus_mmio_map(s, 0, base);
+    sysbus_mmio_map(s, 1, descriptors);
 }
 
-static void cpu_openrisc_load_kernel(ram_addr_t ram_size,
-                                     const char *kernel_filename,
-                                     OpenRISCCPU *cpu)
+static void openrisc_sim_ompic_init(hwaddr base, int num_cpus,
+                                    qemu_irq **cpu_irqs, int irq_pin)
+{
+    DeviceState *dev;
+    SysBusDevice *s;
+    int i;
+
+    dev = qdev_create(NULL, "or1k-ompic");
+    qdev_prop_set_uint32(dev, "num-cpus", num_cpus);
+    qdev_init_nofail(dev);
+
+    s = SYS_BUS_DEVICE(dev);
+    for (i = 0; i < num_cpus; i++) {
+        sysbus_connect_irq(s, i, cpu_irqs[i][irq_pin]);
+    }
+    sysbus_mmio_map(s, 0, base);
+}
+
+static void openrisc_load_kernel(ram_addr_t ram_size,
+                                 const char *kernel_filename)
 {
     long kernel_size;
     uint64_t elf_entry;
@@ -83,6 +107,9 @@ static void cpu_openrisc_load_kernel(ram_addr_t ram_size,
             kernel_size = load_image_targphys(kernel_filename,
                                               KERNEL_LOAD_ADDR,
                                               ram_size - KERNEL_LOAD_ADDR);
+        }
+
+        if (entry <= 0) {
             entry = KERNEL_LOAD_ADDR;
         }
 
@@ -91,7 +118,7 @@ static void cpu_openrisc_load_kernel(ram_addr_t ram_size,
                     kernel_filename);
             exit(1);
         }
-        cpu->env.pc = entry;
+        boot_info.bootstrap_pc = entry;
     }
 }
 
@@ -102,6 +129,8 @@ static void openrisc_sim_init(MachineState *machine)
     const char *kernel_filename = machine->kernel_filename;
     OpenRISCCPU *cpu = NULL;
     MemoryRegion *ram;
+    qemu_irq *cpu_irqs[2];
+    qemu_irq serial_irq;
     int n;
 
     if (!cpu_model) {
@@ -117,33 +146,42 @@ static void openrisc_sim_init(MachineState *machine)
             fprintf(stderr, "Unable to find CPU definition!\n");
             exit(1);
         }
+        cpu_openrisc_pic_init(cpu);
+        cpu_irqs[n] = (qemu_irq *) cpu->env.irq;
+
+        cpu_openrisc_clock_init(cpu);
+
         qemu_register_reset(main_cpu_reset, cpu);
-        main_cpu_reset(cpu);
     }
 
     ram = g_malloc(sizeof(*ram));
     memory_region_init_ram(ram, NULL, "openrisc.ram", ram_size, &error_fatal);
     memory_region_add_subregion(get_system_memory(), 0, ram);
 
-    cpu_openrisc_pic_init(cpu);
-    cpu_openrisc_clock_init(cpu);
+    if (nd_table[0].used) {
+        openrisc_sim_net_init(0x92000000, 0x92000400, smp_cpus,
+                              cpu_irqs, 4, nd_table);
+    }
 
-    serial_mm_init(get_system_memory(), 0x90000000, 0, cpu->env.irq[2],
-                   115200, serial_hds[0], DEVICE_NATIVE_ENDIAN);
+    if (smp_cpus > 1) {
+        openrisc_sim_ompic_init(0x98000000, smp_cpus, cpu_irqs, 1);
 
-    if (nd_table[0].used) {
-        openrisc_sim_net_init(get_system_memory(), 0x92000000,
-                              0x92000400, cpu->env.irq[4], nd_table);
+        serial_irq = qemu_irq_split(cpu_irqs[0][2], cpu_irqs[1][2]);
+    } else {
+        serial_irq = cpu_irqs[0][2];
     }
 
-    cpu_openrisc_load_kernel(ram_size, kernel_filename, cpu);
+    serial_mm_init(get_system_memory(), 0x90000000, 0, serial_irq,
+                   115200, serial_hds[0], DEVICE_NATIVE_ENDIAN);
+
+    openrisc_load_kernel(ram_size, kernel_filename);
 }
 
 static void openrisc_sim_machine_init(MachineClass *mc)
 {
     mc->desc = "or1k simulation";
     mc->init = openrisc_sim_init;
-    mc->max_cpus = 1;
+    mc->max_cpus = 2;
     mc->is_default = 1;
 }
 
-- 
2.13.5
