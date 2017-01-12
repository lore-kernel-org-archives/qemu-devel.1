Received: from eggs.gnu.org ([2001:4830:134:3::10]:46852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUkB-0003D8-Vs
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk8-0006iK-DK
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:59 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:03:10 +1100
Message-Id: <20170112020327.24882-51-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 50/67] prep: add IBM RS/6000 7020 (40p) machine
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

Machine supports both Open Hack'Ware and OpenBIOS.
Open Hack'Ware is the default because OpenBIOS is currently unable to boo=
t
PReP boot partitions or PReP kernels.

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
[dwg: Correct compile failure with KVM located by Thomas Huth]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 default-configs/ppc-softmmu.mak |   1 +
 hw/ppc/prep.c                   | 230 ++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 231 insertions(+)

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmm=
u.mak
index e567658..7dd004e 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -18,6 +18,7 @@ CONFIG_I82378=3Dy
 CONFIG_PC87312=3Dy
 CONFIG_MACIO=3Dy
 CONFIG_PCSPK=3Dy
+CONFIG_CS4231A=3Dy
 CONFIG_CUDA=3Dy
 CONFIG_ADB=3Dy
 CONFIG_MAC_NVRAM=3Dy
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 9fb89d3..ca7959c 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -2,6 +2,7 @@
  * QEMU PPC PREP hardware System Emulator
  *
  * Copyright (c) 2003-2007 Jocelyn Mayer
+ * Copyright (c) 2017 Herv=C3=A9 Poussineau
  *
  * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
  * of this software and associated documentation files (the "Software"),=
 to deal
@@ -43,17 +44,21 @@
 #include "hw/isa/pc87312.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/arch_init.h"
+#include "sysemu/kvm.h"
 #include "sysemu/qtest.h"
 #include "exec/address-spaces.h"
 #include "trace.h"
 #include "elf.h"
 #include "qemu/cutils.h"
+#include "kvm_ppc.h"
=20
 /* SMP is not enabled, for now */
 #define MAX_CPUS 1
=20
 #define MAX_IDE_BUS 2
=20
+#define CFG_ADDR 0xf0000510
+
 #define BIOS_SIZE (1024 * 1024)
 #define BIOS_FILENAME "ppc_rom.bin"
 #define KERNEL_LOAD_ADDR 0x01000000
@@ -316,6 +321,12 @@ static uint32_t PREP_io_800_readb (void *opaque, uin=
t32_t addr)
=20
 #define NVRAM_SIZE        0x2000
=20
+static void fw_cfg_boot_set(void *opaque, const char *boot_device,
+                            Error **errp)
+{
+    fw_cfg_modify_i16(opaque, FW_CFG_BOOT_DEVICE, boot_device[0]);
+}
+
 static void ppc_prep_reset(void *opaque)
 {
     PowerPCCPU *cpu =3D opaque;
@@ -677,4 +688,223 @@ static void prep_machine_init(MachineClass *mc)
     mc->default_boot_order =3D "cad";
 }
=20
+static int prep_set_cmos_checksum(DeviceState *dev, void *opaque)
+{
+    uint16_t checksum =3D *(uint16_t *)opaque;
+    ISADevice *rtc;
+
+    if (object_dynamic_cast(OBJECT(dev), "mc146818rtc")) {
+        rtc =3D ISA_DEVICE(dev);
+        rtc_set_memory(rtc, 0x2e, checksum & 0xff);
+        rtc_set_memory(rtc, 0x3e, checksum & 0xff);
+        rtc_set_memory(rtc, 0x2f, checksum >> 8);
+        rtc_set_memory(rtc, 0x3f, checksum >> 8);
+    }
+    return 0;
+}
+
+static void ibm_40p_init(MachineState *machine)
+{
+    CPUPPCState *env =3D NULL;
+    uint16_t cmos_checksum;
+    PowerPCCPU *cpu;
+    DeviceState *dev;
+    SysBusDevice *pcihost;
+    Nvram *m48t59 =3D NULL;
+    PCIBus *pci_bus;
+    ISABus *isa_bus;
+    void *fw_cfg;
+    int i;
+    uint32_t kernel_base =3D 0, initrd_base =3D 0;
+    long kernel_size =3D 0, initrd_size =3D 0;
+    char boot_device;
+
+    /* init CPU */
+    if (!machine->cpu_model) {
+        machine->cpu_model =3D "604";
+    }
+    cpu =3D cpu_ppc_init(machine->cpu_model);
+    if (!cpu) {
+        error_report("could not initialize CPU '%s'",
+                     machine->cpu_model);
+        exit(1);
+    }
+    env =3D &cpu->env;
+    if (PPC_INPUT(env) !=3D PPC_FLAGS_INPUT_6xx) {
+        error_report("only 6xx bus is supported on this machine");
+        exit(1);
+    }
+
+    if (env->flags & POWERPC_FLAG_RTC_CLK) {
+        /* POWER / PowerPC 601 RTC clock frequency is 7.8125 MHz */
+        cpu_ppc_tb_init(env, 7812500UL);
+    } else {
+        /* Set time-base frequency to 100 Mhz */
+        cpu_ppc_tb_init(env, 100UL * 1000UL * 1000UL);
+    }
+    qemu_register_reset(ppc_prep_reset, cpu);
+
+    /* PCI host */
+    dev =3D qdev_create(NULL, "raven-pcihost");
+    if (!bios_name) {
+        bios_name =3D BIOS_FILENAME;
+    }
+    qdev_prop_set_string(dev, "bios-name", bios_name);
+    qdev_prop_set_uint32(dev, "elf-machine", PPC_ELF_MACHINE);
+    pcihost =3D SYS_BUS_DEVICE(dev);
+    object_property_add_child(qdev_get_machine(), "raven", OBJECT(dev), =
NULL);
+    qdev_init_nofail(dev);
+    pci_bus =3D PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
+    if (!pci_bus) {
+        error_report("could not create PCI host controller");
+        exit(1);
+    }
+
+    /* PCI -> ISA bridge */
+    dev =3D DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(11, 0), "i82378"=
));
+    qdev_connect_gpio_out(dev, 0,
+                          cpu->env.irq_inputs[PPC6xx_INPUT_INT]);
+    sysbus_connect_irq(pcihost, 0, qdev_get_gpio_in(dev, 15));
+    sysbus_connect_irq(pcihost, 1, qdev_get_gpio_in(dev, 13));
+    sysbus_connect_irq(pcihost, 2, qdev_get_gpio_in(dev, 15));
+    sysbus_connect_irq(pcihost, 3, qdev_get_gpio_in(dev, 13));
+    isa_bus =3D ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
+
+    /* Memory controller */
+    dev =3D DEVICE(isa_create(isa_bus, "rs6000-mc"));
+    qdev_prop_set_uint32(dev, "ram-size", machine->ram_size);
+    qdev_init_nofail(dev);
+
+    /* initialize CMOS checksums */
+    cmos_checksum =3D 0x6aa9;
+    qbus_walk_children(BUS(isa_bus), prep_set_cmos_checksum, NULL, NULL,=
 NULL,
+                       &cmos_checksum);
+
+    /* initialize audio subsystem */
+    audio_init();
+
+    /* add some more devices */
+    if (defaults_enabled()) {
+        isa_create_simple(isa_bus, "i8042");
+        m48t59 =3D NVRAM(isa_create_simple(isa_bus, "isa-m48t59"));
+
+        dev =3D DEVICE(isa_create(isa_bus, "cs4231a"));
+        qdev_prop_set_uint32(dev, "iobase", 0x830);
+        qdev_prop_set_uint32(dev, "irq", 10);
+        qdev_init_nofail(dev);
+
+        dev =3D DEVICE(isa_create(isa_bus, "pc87312"));
+        qdev_prop_set_uint32(dev, "config", 12);
+        qdev_init_nofail(dev);
+
+        dev =3D DEVICE(isa_create(isa_bus, "prep-systemio"));
+        qdev_prop_set_uint32(dev, "ibm-planar-id", 0xfc);
+        qdev_prop_set_uint32(dev, "equipment", 0xc0);
+        qdev_init_nofail(dev);
+
+        pci_create_simple(pci_bus, PCI_DEVFN(1, 0), "lsi53c810");
+
+        /* XXX: s3-trio at PCI_DEVFN(2, 0) */
+        pci_vga_init(pci_bus);
+
+        for (i =3D 0; i < nb_nics; i++) {
+            pci_nic_init_nofail(&nd_table[i], pci_bus, "pcnet",
+                                i =3D=3D 0 ? "3" : NULL);
+        }
+    }
+
+    /* Prepare firmware configuration for OpenBIOS */
+    fw_cfg =3D fw_cfg_init_mem(CFG_ADDR, CFG_ADDR + 2);
+
+    if (machine->kernel_filename) {
+        /* load kernel */
+        kernel_base =3D KERNEL_LOAD_ADDR;
+        kernel_size =3D load_image_targphys(machine->kernel_filename,
+                                          kernel_base,
+                                          machine->ram_size - kernel_bas=
e);
+        if (kernel_size < 0) {
+            error_report("could not load kernel '%s'",
+                         machine->kernel_filename);
+            exit(1);
+        }
+        fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, kernel_base);
+        fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, kernel_size);
+        /* load initrd */
+        if (machine->initrd_filename) {
+            initrd_base =3D INITRD_LOAD_ADDR;
+            initrd_size =3D load_image_targphys(machine->initrd_filename=
,
+                                              initrd_base,
+                                              machine->ram_size - initrd=
_base);
+            if (initrd_size < 0) {
+                error_report("could not load initial ram disk '%s'",
+                             machine->initrd_filename);
+                exit(1);
+            }
+            fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_base);
+            fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
+        }
+        if (machine->kernel_cmdline && *machine->kernel_cmdline) {
+            fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_CMDLINE, CMDLINE_ADDR);
+            pstrcpy_targphys("cmdline", CMDLINE_ADDR, TARGET_PAGE_SIZE,
+                             machine->kernel_cmdline);
+            fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA,
+                              machine->kernel_cmdline);
+            fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE,
+                           strlen(machine->kernel_cmdline) + 1);
+        }
+        boot_device =3D 'm';
+    } else {
+        boot_device =3D machine->boot_order[0];
+    }
+
+    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)max_cpus);
+    fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)machine->ram_size)=
;
+    fw_cfg_add_i16(fw_cfg, FW_CFG_MACHINE_ID, ARCH_PREP);
+
+    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_WIDTH, graphic_width);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, graphic_height);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, graphic_depth);
+
+    fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_IS_KVM, kvm_enabled());
+    if (kvm_enabled()) {
+#ifdef CONFIG_KVM
+        uint8_t *hypercall;
+
+        fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_TBFREQ, kvmppc_get_tbfreq());
+        hypercall =3D g_malloc(16);
+        kvmppc_get_hypercall(env, hypercall, 16);
+        fw_cfg_add_bytes(fw_cfg, FW_CFG_PPC_KVM_HC, hypercall, 16);
+        fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_KVM_PID, getpid());
+#endif
+    } else {
+        fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_TBFREQ, NANOSECONDS_PER_SECOND=
);
+    }
+    fw_cfg_add_i16(fw_cfg, FW_CFG_BOOT_DEVICE, boot_device);
+    qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
+
+    /* Prepare firmware configuration for Open Hack'Ware */
+    if (m48t59) {
+        PPC_NVRAM_set_params(m48t59, NVRAM_SIZE, "PREP", ram_size,
+                             boot_device,
+                             kernel_base, kernel_size,
+                             machine->kernel_cmdline,
+                             initrd_base, initrd_size,
+                             /* XXX: need an option to load a NVRAM imag=
e */
+                             0,
+                             graphic_width, graphic_height, graphic_dept=
h);
+    }
+}
+
+static void ibm_40p_machine_init(MachineClass *mc)
+{
+    mc->desc =3D "IBM RS/6000 7020 (40p)",
+    mc->init =3D ibm_40p_init;
+    mc->max_cpus =3D 1;
+    mc->pci_allow_0_address =3D true;
+    mc->default_ram_size =3D 128 * M_BYTE;
+    mc->block_default_type =3D IF_SCSI;
+    mc->default_boot_order =3D "c";
+}
+
+DEFINE_MACHINE("40p", ibm_40p_machine_init)
 DEFINE_MACHINE("prep", prep_machine_init)
--=20
2.9.3
