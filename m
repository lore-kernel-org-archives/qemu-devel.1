Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF99C432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 07:33:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 072E42068E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 07:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFnYN3hg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072E42068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic2g8-0005oI-5c
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 02:33:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ic2d2-0004Jg-Hz
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:29:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ic2cp-0002OF-Bz
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:29:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47910
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ic2co-0002LY-V0
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:29:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575358174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gzJdxsxRGpsc/L+fz3tT5hM0tzqaGuJzp8MQUsL14CM=;
 b=fFnYN3hgjtmcs3lzRL1V4Jk0fqYUAqWd1Rz9HedokqprqvAu10TRmS6seA1ZFqTlQKEmOT
 oMPblc8FMnOc9WgGRB/RaWF7pKo/6Y9/qK8A2oTSu/hVpK2D7qaDVzdkTZmwpV5heOKus5
 +Vkck5kU8oVpEjPo+F0v6iqSjLD3VDo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-JitVfEX3NpK7DJ6u-GQ1DA-1; Tue, 03 Dec 2019 02:29:31 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 103861B18BC5;
 Tue,  3 Dec 2019 07:29:30 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-113.ams2.redhat.com
 [10.36.116.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 806F55D6A7;
 Tue,  3 Dec 2019 07:29:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Subject: [PATCH] hw/ppc/prep: Remove the deprecated "prep" machine and the
 OpenHackware BIOS
Date: Tue,  3 Dec 2019 08:29:22 +0100
Message-Id: <20191203072922.14981-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: JitVfEX3NpK7DJ6u-GQ1DA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's been deprecated since QEMU v3.1. The 40p machine should be
used nowadays instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitmodules                |   3 -
 MAINTAINERS                |   1 -
 Makefile                   |   2 +-
 docs/interop/firmware.json |   3 +-
 hw/ppc/ppc.c               |  18 --
 hw/ppc/prep.c              | 384 +------------------------------------
 include/hw/ppc/ppc.h       |   1 -
 pc-bios/README             |   3 -
 pc-bios/ppc_rom.bin        | Bin 1048576 -> 0 bytes
 qemu-deprecated.texi       |   6 -
 qemu-doc.texi              |  15 +-
 roms/openhackware          |   1 -
 tests/boot-order-test.c    |  25 ---
 tests/cdrom-test.c         |   2 +-
 tests/endianness-test.c    |   2 +-
 15 files changed, 10 insertions(+), 456 deletions(-)
 delete mode 100644 pc-bios/ppc_rom.bin
 delete mode 160000 roms/openhackware

diff --git a/.gitmodules b/.gitmodules
index 19792c9a11..9c0501a4d4 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -10,9 +10,6 @@
 [submodule "roms/openbios"]
 =09path =3D roms/openbios
 =09url =3D https://git.qemu.org/git/openbios.git
-[submodule "roms/openhackware"]
-=09path =3D roms/openhackware
-=09url =3D https://git.qemu.org/git/openhackware.git
 [submodule "roms/qemu-palcode"]
 =09path =3D roms/qemu-palcode
 =09url =3D https://git.qemu.org/git/qemu-palcode.git
diff --git a/MAINTAINERS b/MAINTAINERS
index 5e5e3e52d6..9a9dee0fa4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1081,7 +1081,6 @@ F: hw/dma/i82374.c
 F: hw/rtc/m48t59-isa.c
 F: include/hw/isa/pc87312.h
 F: include/hw/rtc/m48t59.h
-F: pc-bios/ppc_rom.bin
 F: tests/acceptance/ppc_prep_40p.py
=20
 sPAPR
diff --git a/Makefile b/Makefile
index b437a346d7..86476d1d9e 100644
--- a/Makefile
+++ b/Makefile
@@ -776,7 +776,7 @@ ifdef INSTALL_BLOBS
 BLOBS=3Dbios.bin bios-256k.bin bios-microvm.bin sgabios.bin vgabios.bin vg=
abios-cirrus.bin \
 vgabios-stdvga.bin vgabios-vmware.bin vgabios-qxl.bin vgabios-virtio.bin \
 vgabios-ramfb.bin vgabios-bochs-display.bin vgabios-ati.bin \
-ppc_rom.bin openbios-sparc32 openbios-sparc64 openbios-ppc QEMU,tcx.bin QE=
MU,cgthree.bin \
+openbios-sparc32 openbios-sparc64 openbios-ppc QEMU,tcx.bin QEMU,cgthree.b=
in \
 pxe-e1000.rom pxe-eepro100.rom pxe-ne2k_pci.rom \
 pxe-pcnet.rom pxe-rtl8139.rom pxe-virtio.rom \
 efi-e1000.rom efi-eepro100.rom efi-ne2k_pci.rom \
diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 8ffb7856d2..240f565397 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -27,8 +27,7 @@
 #
 # @openfirmware: The interface is defined by the (historical) IEEE
 #                1275-1994 standard. Examples for firmware projects that
-#                provide this interface are: OpenBIOS, OpenHackWare,
-#                SLOF.
+#                provide this interface are: OpenBIOS and SLOF.
 #
 # @uboot: Firmware interface defined by the U-Boot project.
 #
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 52a18eb7d7..13b6cf85c0 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -1476,24 +1476,6 @@ int ppc_dcr_init (CPUPPCState *env, int (*read_error=
)(int dcrn),
 }
=20
 /*************************************************************************=
****/
-/* Debug port */
-void PPC_debug_write (void *opaque, uint32_t addr, uint32_t val)
-{
-    addr &=3D 0xF;
-    switch (addr) {
-    case 0:
-        printf("%c", val);
-        break;
-    case 1:
-        printf("\n");
-        fflush(stdout);
-        break;
-    case 2:
-        printf("Set loglevel to %04" PRIx32 "\n", val);
-        qemu_set_log(val | 0x100);
-        break;
-    }
-}
=20
 PowerPCCPU *ppc_get_vcpu_by_pir(int pir)
 {
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 862345c2ac..111cc80867 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -42,7 +42,7 @@
 #include "hw/loader.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/isa/pc87312.h"
-#include "hw/net/ne2000-isa.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/kvm.h"
 #include "sysemu/qtest.h"
@@ -60,178 +60,9 @@
=20
 #define CFG_ADDR 0xf0000510
=20
-#define BIOS_SIZE (1 * MiB)
-#define BIOS_FILENAME "ppc_rom.bin"
 #define KERNEL_LOAD_ADDR 0x01000000
 #define INITRD_LOAD_ADDR 0x01800000
=20
-/* Constants for devices init */
-static const int ide_iobase[2] =3D { 0x1f0, 0x170 };
-static const int ide_iobase2[2] =3D { 0x3f6, 0x376 };
-static const int ide_irq[2] =3D { 13, 13 };
-
-#define NE2000_NB_MAX 6
-
-static uint32_t ne2000_io[NE2000_NB_MAX] =3D { 0x300, 0x320, 0x340, 0x360,=
 0x280, 0x380 };
-static int ne2000_irq[NE2000_NB_MAX] =3D { 9, 10, 11, 3, 4, 5 };
-
-/* ISA IO ports bridge */
-#define PPC_IO_BASE 0x80000000
-
-/* Fake super-io ports for PREP platform (Intel 82378ZB) */
-typedef struct sysctrl_t {
-    qemu_irq reset_irq;
-    Nvram *nvram;
-    uint8_t state;
-    uint8_t syscontrol;
-    int contiguous_map;
-    qemu_irq contiguous_map_irq;
-    int endian;
-} sysctrl_t;
-
-enum {
-    STATE_HARDFILE =3D 0x01,
-};
-
-static sysctrl_t *sysctrl;
-
-static void PREP_io_800_writeb (void *opaque, uint32_t addr, uint32_t val)
-{
-    sysctrl_t *sysctrl =3D opaque;
-
-    trace_prep_io_800_writeb(addr - PPC_IO_BASE, val);
-    switch (addr) {
-    case 0x0092:
-        /* Special port 92 */
-        /* Check soft reset asked */
-        if (val & 0x01) {
-            qemu_irq_raise(sysctrl->reset_irq);
-        } else {
-            qemu_irq_lower(sysctrl->reset_irq);
-        }
-        /* Check LE mode */
-        if (val & 0x02) {
-            sysctrl->endian =3D 1;
-        } else {
-            sysctrl->endian =3D 0;
-        }
-        break;
-    case 0x0800:
-        /* Motorola CPU configuration register : read-only */
-        break;
-    case 0x0802:
-        /* Motorola base module feature register : read-only */
-        break;
-    case 0x0803:
-        /* Motorola base module status register : read-only */
-        break;
-    case 0x0808:
-        /* Hardfile light register */
-        if (val & 1)
-            sysctrl->state |=3D STATE_HARDFILE;
-        else
-            sysctrl->state &=3D ~STATE_HARDFILE;
-        break;
-    case 0x0810:
-        /* Password protect 1 register */
-        if (sysctrl->nvram !=3D NULL) {
-            NvramClass *k =3D NVRAM_GET_CLASS(sysctrl->nvram);
-            (k->toggle_lock)(sysctrl->nvram, 1);
-        }
-        break;
-    case 0x0812:
-        /* Password protect 2 register */
-        if (sysctrl->nvram !=3D NULL) {
-            NvramClass *k =3D NVRAM_GET_CLASS(sysctrl->nvram);
-            (k->toggle_lock)(sysctrl->nvram, 2);
-        }
-        break;
-    case 0x0814:
-        /* L2 invalidate register */
-        //        tlb_flush(first_cpu, 1);
-        break;
-    case 0x081C:
-        /* system control register */
-        sysctrl->syscontrol =3D val & 0x0F;
-        break;
-    case 0x0850:
-        /* I/O map type register */
-        sysctrl->contiguous_map =3D val & 0x01;
-        qemu_set_irq(sysctrl->contiguous_map_irq, sysctrl->contiguous_map)=
;
-        break;
-    default:
-        printf("ERROR: unaffected IO port write: %04" PRIx32
-               " =3D> %02" PRIx32"\n", addr, val);
-        break;
-    }
-}
-
-static uint32_t PREP_io_800_readb (void *opaque, uint32_t addr)
-{
-    sysctrl_t *sysctrl =3D opaque;
-    uint32_t retval =3D 0xFF;
-
-    switch (addr) {
-    case 0x0092:
-        /* Special port 92 */
-        retval =3D sysctrl->endian << 1;
-        break;
-    case 0x0800:
-        /* Motorola CPU configuration register */
-        retval =3D 0xEF; /* MPC750 */
-        break;
-    case 0x0802:
-        /* Motorola Base module feature register */
-        retval =3D 0xAD; /* No ESCC, PMC slot neither ethernet */
-        break;
-    case 0x0803:
-        /* Motorola base module status register */
-        retval =3D 0xE0; /* Standard MPC750 */
-        break;
-    case 0x080C:
-        /* Equipment present register:
-         *  no L2 cache
-         *  no upgrade processor
-         *  no cards in PCI slots
-         *  SCSI fuse is bad
-         */
-        retval =3D 0x3C;
-        break;
-    case 0x0810:
-        /* Motorola base module extended feature register */
-        retval =3D 0x39; /* No USB, CF and PCI bridge. NVRAM present */
-        break;
-    case 0x0814:
-        /* L2 invalidate: don't care */
-        break;
-    case 0x0818:
-        /* Keylock */
-        retval =3D 0x00;
-        break;
-    case 0x081C:
-        /* system control register
-         * 7 - 6 / 1 - 0: L2 cache enable
-         */
-        retval =3D sysctrl->syscontrol;
-        break;
-    case 0x0823:
-        /* */
-        retval =3D 0x03; /* no L2 cache */
-        break;
-    case 0x0850:
-        /* I/O map type register */
-        retval =3D sysctrl->contiguous_map;
-        break;
-    default:
-        printf("ERROR: unaffected IO port: %04" PRIx32 " read\n", addr);
-        break;
-    }
-    trace_prep_io_800_readb(addr - PPC_IO_BASE, retval);
-
-    return retval;
-}
-
-
 #define NVRAM_SIZE        0x2000
=20
 static void fw_cfg_boot_set(void *opaque, const char *boot_device,
@@ -247,17 +78,6 @@ static void ppc_prep_reset(void *opaque)
     cpu_reset(CPU(cpu));
 }
=20
-static const MemoryRegionPortio prep_portio_list[] =3D {
-    /* System control ports */
-    { 0x0092, 1, 1, .read =3D PREP_io_800_readb, .write =3D PREP_io_800_wr=
iteb, },
-    { 0x0800, 0x52, 1,
-      .read =3D PREP_io_800_readb, .write =3D PREP_io_800_writeb, },
-    /* Special port to get debug messages from Open-Firmware */
-    { 0x0F00, 4, 1, .write =3D PPC_debug_write, },
-    PORTIO_END_OF_LIST(),
-};
-
-static PortioList prep_port_list;
=20
 /*************************************************************************=
****/
 /* NVRAM helpers */
@@ -397,207 +217,6 @@ static int PPC_NVRAM_set_params (Nvram *nvram, uint16=
_t NVRAM_size,
     return 0;
 }
=20
-/* PowerPC PREP hardware initialisation */
-static void ppc_prep_init(MachineState *machine)
-{
-    ram_addr_t ram_size =3D machine->ram_size;
-    const char *kernel_filename =3D machine->kernel_filename;
-    const char *kernel_cmdline =3D machine->kernel_cmdline;
-    const char *initrd_filename =3D machine->initrd_filename;
-    const char *boot_device =3D machine->boot_order;
-    MemoryRegion *sysmem =3D get_system_memory();
-    PowerPCCPU *cpu =3D NULL;
-    CPUPPCState *env =3D NULL;
-    Nvram *m48t59;
-#if 0
-    MemoryRegion *xcsr =3D g_new(MemoryRegion, 1);
-#endif
-    int linux_boot, i, nb_nics1;
-    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
-    uint32_t kernel_base, initrd_base;
-    long kernel_size, initrd_size;
-    DeviceState *dev;
-    PCIHostState *pcihost;
-    PCIBus *pci_bus;
-    PCIDevice *pci;
-    ISABus *isa_bus;
-    ISADevice *isa;
-    int ppc_boot_device;
-    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-
-    sysctrl =3D g_malloc0(sizeof(sysctrl_t));
-
-    linux_boot =3D (kernel_filename !=3D NULL);
-
-    /* init CPUs */
-    for (i =3D 0; i < machine->smp.cpus; i++) {
-        cpu =3D POWERPC_CPU(cpu_create(machine->cpu_type));
-        env =3D &cpu->env;
-
-        if (env->flags & POWERPC_FLAG_RTC_CLK) {
-            /* POWER / PowerPC 601 RTC clock frequency is 7.8125 MHz */
-            cpu_ppc_tb_init(env, 7812500UL);
-        } else {
-            /* Set time-base frequency to 100 Mhz */
-            cpu_ppc_tb_init(env, 100UL * 1000UL * 1000UL);
-        }
-        qemu_register_reset(ppc_prep_reset, cpu);
-    }
-
-    /* allocate RAM */
-    memory_region_allocate_system_memory(ram, NULL, "ppc_prep.ram", ram_si=
ze);
-    memory_region_add_subregion(sysmem, 0, ram);
-
-    if (linux_boot) {
-        kernel_base =3D KERNEL_LOAD_ADDR;
-        /* now we can load the kernel */
-        kernel_size =3D load_image_targphys(kernel_filename, kernel_base,
-                                          ram_size - kernel_base);
-        if (kernel_size < 0) {
-            error_report("could not load kernel '%s'", kernel_filename);
-            exit(1);
-        }
-        /* load initrd */
-        if (initrd_filename) {
-            initrd_base =3D INITRD_LOAD_ADDR;
-            initrd_size =3D load_image_targphys(initrd_filename, initrd_ba=
se,
-                                              ram_size - initrd_base);
-            if (initrd_size < 0) {
-                error_report("could not load initial ram disk '%s'",
-                             initrd_filename);
-                exit(1);
-            }
-        } else {
-            initrd_base =3D 0;
-            initrd_size =3D 0;
-        }
-        ppc_boot_device =3D 'm';
-    } else {
-        kernel_base =3D 0;
-        kernel_size =3D 0;
-        initrd_base =3D 0;
-        initrd_size =3D 0;
-        ppc_boot_device =3D '\0';
-        /* For now, OHW cannot boot from the network. */
-        for (i =3D 0; boot_device[i] !=3D '\0'; i++) {
-            if (boot_device[i] >=3D 'a' && boot_device[i] <=3D 'f') {
-                ppc_boot_device =3D boot_device[i];
-                break;
-            }
-        }
-        if (ppc_boot_device =3D=3D '\0') {
-            error_report("No valid boot device for Mac99 machine");
-            exit(1);
-        }
-    }
-
-    if (PPC_INPUT(env) !=3D PPC_FLAGS_INPUT_6xx) {
-        error_report("Only 6xx bus is supported on PREP machine");
-        exit(1);
-    }
-
-    dev =3D qdev_create(NULL, "raven-pcihost");
-    if (bios_name =3D=3D NULL) {
-        bios_name =3D BIOS_FILENAME;
-    }
-    qdev_prop_set_string(dev, "bios-name", bios_name);
-    qdev_prop_set_uint32(dev, "elf-machine", PPC_ELF_MACHINE);
-    qdev_prop_set_bit(dev, "is-legacy-prep", true);
-    pcihost =3D PCI_HOST_BRIDGE(dev);
-    object_property_add_child(qdev_get_machine(), "raven", OBJECT(dev), NU=
LL);
-    qdev_init_nofail(dev);
-    pci_bus =3D (PCIBus *)qdev_get_child_bus(dev, "pci.0");
-    if (pci_bus =3D=3D NULL) {
-        error_report("Couldn't create PCI host controller");
-        exit(1);
-    }
-    sysctrl->contiguous_map_irq =3D qdev_get_gpio_in(dev, 0);
-
-    /* PCI -> ISA bridge */
-    pci =3D pci_create_simple(pci_bus, PCI_DEVFN(1, 0), "i82378");
-    cpu =3D POWERPC_CPU(first_cpu);
-    qdev_connect_gpio_out(&pci->qdev, 0,
-                          cpu->env.irq_inputs[PPC6xx_INPUT_INT]);
-    sysbus_connect_irq(&pcihost->busdev, 0, qdev_get_gpio_in(&pci->qdev, 9=
));
-    sysbus_connect_irq(&pcihost->busdev, 1, qdev_get_gpio_in(&pci->qdev, 1=
1));
-    sysbus_connect_irq(&pcihost->busdev, 2, qdev_get_gpio_in(&pci->qdev, 9=
));
-    sysbus_connect_irq(&pcihost->busdev, 3, qdev_get_gpio_in(&pci->qdev, 1=
1));
-    isa_bus =3D ISA_BUS(qdev_get_child_bus(DEVICE(pci), "isa.0"));
-
-    /* Super I/O (parallel + serial ports) */
-    isa =3D isa_create(isa_bus, TYPE_PC87312_SUPERIO);
-    dev =3D DEVICE(isa);
-    qdev_prop_set_uint8(dev, "config", 13); /* fdc, ser0, ser1, par0 */
-    qdev_init_nofail(dev);
-
-    /* init basic PC hardware */
-    pci_vga_init(pci_bus);
-
-    nb_nics1 =3D nb_nics;
-    if (nb_nics1 > NE2000_NB_MAX)
-        nb_nics1 =3D NE2000_NB_MAX;
-    for(i =3D 0; i < nb_nics1; i++) {
-        if (nd_table[i].model =3D=3D NULL) {
-            nd_table[i].model =3D g_strdup("ne2k_isa");
-        }
-        if (strcmp(nd_table[i].model, "ne2k_isa") =3D=3D 0) {
-            isa_ne2000_init(isa_bus, ne2000_io[i], ne2000_irq[i],
-                            &nd_table[i]);
-        } else {
-            pci_nic_init_nofail(&nd_table[i], pci_bus, "ne2k_pci", NULL);
-        }
-    }
-
-    ide_drive_get(hd, ARRAY_SIZE(hd));
-    for(i =3D 0; i < MAX_IDE_BUS; i++) {
-        isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i], ide_irq[i],
-                     hd[2 * i],
-                     hd[2 * i + 1]);
-    }
-
-    cpu =3D POWERPC_CPU(first_cpu);
-    sysctrl->reset_irq =3D cpu->env.irq_inputs[PPC6xx_INPUT_HRESET];
-
-    portio_list_init(&prep_port_list, NULL, prep_portio_list, sysctrl, "pr=
ep");
-    portio_list_add(&prep_port_list, isa_address_space_io(isa), 0x0);
-
-    /*
-     * PowerPC control and status register group: unimplemented,
-     * would be at address 0xFEFF0000.
-     */
-
-    if (machine_usb(machine)) {
-        pci_create_simple(pci_bus, -1, "pci-ohci");
-    }
-
-    m48t59 =3D m48t59_init_isa(isa_bus, 0x0074, NVRAM_SIZE, 2000, 59);
-    if (m48t59 =3D=3D NULL)
-        return;
-    sysctrl->nvram =3D m48t59;
-
-    /* Initialise NVRAM */
-    PPC_NVRAM_set_params(m48t59, NVRAM_SIZE, "PREP", ram_size,
-                         ppc_boot_device,
-                         kernel_base, kernel_size,
-                         kernel_cmdline,
-                         initrd_base, initrd_size,
-                         /* XXX: need an option to load a NVRAM image */
-                         0,
-                         graphic_width, graphic_height, graphic_depth);
-}
-
-static void prep_machine_init(MachineClass *mc)
-{
-    mc->deprecation_reason =3D "use 40p machine type instead";
-    mc->desc =3D "PowerPC PREP platform";
-    mc->init =3D ppc_prep_init;
-    mc->block_default_type =3D IF_IDE;
-    mc->max_cpus =3D MAX_CPUS;
-    mc->default_boot_order =3D "cad";
-    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("602");
-    mc->default_display =3D "std";
-}
-
 static int prep_set_cmos_checksum(DeviceState *dev, void *opaque)
 {
     uint16_t checksum =3D *(uint16_t *)opaque;
@@ -821,4 +440,3 @@ static void ibm_40p_machine_init(MachineClass *mc)
 }
=20
 DEFINE_MACHINE("40p", ibm_40p_machine_init)
-DEFINE_MACHINE("prep", prep_machine_init)
diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 4bdcb8bacd..94b28f77f6 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -67,7 +67,6 @@ clk_setup_cb ppc_40x_timers_init (CPUPPCState *env, uint3=
2_t freq,
 void ppc40x_core_reset(PowerPCCPU *cpu);
 void ppc40x_chip_reset(PowerPCCPU *cpu);
 void ppc40x_system_reset(PowerPCCPU *cpu);
-void PPC_debug_write (void *opaque, uint32_t addr, uint32_t val);
=20
 #if defined(CONFIG_USER_ONLY)
 static inline void ppc40x_irq_init(PowerPCCPU *cpu) {}
diff --git a/pc-bios/README b/pc-bios/README
index 830645c51f..062c11a9eb 100644
--- a/pc-bios/README
+++ b/pc-bios/README
@@ -4,9 +4,6 @@
 - The VGA BIOS and the Cirrus VGA BIOS come from the LGPL VGA bios
   project (http://www.nongnu.org/vgabios/).
=20
-- The PowerPC Open Hack'Ware Open Firmware Compatible BIOS is
-  available at https://repo.or.cz/openhackware.git.
-
 - OpenBIOS (http://www.openbios.org/) is a free (GPL v2) portable
   firmware implementation. The goal is to implement a 100% IEEE
   1275-1994 (referred to as Open Firmware) compliant firmware.
diff --git a/pc-bios/ppc_rom.bin b/pc-bios/ppc_rom.bin
deleted file mode 100644
index 174a24744b73fb2824f9b1e7c0078f4499e1e724..000000000000000000000000000=
0000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 1048576
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
(
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
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CTF#2nYcoAOwVf5D)@FKnMr{As_^VfDjM@LO=3D)z0U;m+gn$qb0zyCt2mv7=3D1cZPP
z5CZ>iJ9LQCKo~_~^ui1phsU#kPC^kV5(th3Oh7cD23Ir57zCjS3Ihi92Qxc?wO|oV
zhnjAn*yG>(a&rg}AV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs
z0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZ
zfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&U
zAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C7
z2oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N
z0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+
z009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBly
zK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF
z5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk
z1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs
z0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZ
zfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&U
zAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C7
z2oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N
z0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+
z009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBly
zK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF
z5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk
z1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs
z0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZ
zfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&U
zAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C7
z2oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N
z0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+
z009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBly
zK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF
z5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk
z1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs
z0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZ
zfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&U
zAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C7
z2oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N
z0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+
z009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBly
zK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF
z5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk
z1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs
z0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZ
zfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&U
zAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C7
z2oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N
z0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+
z009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBly
zK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF
z5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk
z1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs
z0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZ
zfB*pk1PBlyK!5-N0t5)`DlkdX&Gt)kzfSX<lkTl5U7s@jNZk%U58cab(Y;sYD!H5X
zNxMAkyQiw$%yV=3D)PbRl#X_n(^bDwtDv_7lS4CCtYEA{Jl>hp}ho9<%U-L|g#9A9Lw
O-*vaY{|j7>>w`a^<P%E(

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 4b4b7425ac..66d2b22a94 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -271,12 +271,6 @@ The 'scsi-disk' device is deprecated. Users should use=
 'scsi-hd' or
 These machine types are very old and likely can not be used for live migra=
tion
 from old QEMU versions anymore. A newer machine type should be used instea=
d.
=20
-@subsection prep (PowerPC) (since 3.1)
-
-This machine type uses an unmaintained firmware, broken in lots of ways,
-and unable to start post-2004 operating systems. 40p machine type should b=
e
-used instead.
-
 @subsection spike_v1.9.1 and spike_v1.10 (since 4.1)
=20
 The version specific Spike machines have been deprecated in favour of the
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 3ddf5c0a68..f8037f12ef 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -1763,7 +1763,7 @@ differences are mentioned in the following sections.
 @section PowerPC System emulator
 @cindex system emulation (PowerPC)
=20
-Use the executable @file{qemu-system-ppc} to simulate a complete PREP
+Use the executable @file{qemu-system-ppc} to simulate a complete 40P (PREP=
)
 or PowerMac PowerPC system.
=20
 QEMU emulates the following PowerMac peripherals:
@@ -1783,7 +1783,7 @@ Non Volatile RAM
 VIA-CUDA with ADB keyboard and mouse.
 @end itemize
=20
-QEMU emulates the following PREP peripherals:
+QEMU emulates the following 40P (PREP) peripherals:
=20
 @itemize @minus
 @item
@@ -1795,7 +1795,7 @@ PCI VGA compatible card with VESA Bochs Extensions
 @item
 Floppy disk
 @item
-NE2000 network adapters
+PCnet network adapters
 @item
 Serial port
 @item
@@ -1804,12 +1804,9 @@ PREP Non Volatile RAM
 PC compatible keyboard and mouse.
 @end itemize
=20
-QEMU uses the Open Hack'Ware Open Firmware Compatible BIOS available at
-@url{http://perso.magic.fr/l_indien/OpenHackWare/index.htm}.
-
 Since version 0.9.1, QEMU uses OpenBIOS @url{https://www.openbios.org/}
-for the g3beige and mac99 PowerMac machines. OpenBIOS is a free (GPL
-v2) portable firmware implementation. The goal is to implement a 100%
+for the g3beige and mac99 PowerMac and the 40p machines. OpenBIOS is a fre=
e
+(GPL v2) portable firmware implementation. The goal is to implement a 100%
 IEEE 1275-1994 (referred to as Open Firmware) compliant firmware.
=20
 @c man begin OPTIONS
@@ -1832,8 +1829,6 @@ qemu-system-ppc -prom-env 'auto-boot?=3Dfalse' \
  -prom-env 'boot-args=3Dconf=3Dhd:2,\yaboot.conf'
 @end example
=20
-These variables are not used by Open Hack'Ware.
-
 @end table
=20
 @c man end
diff --git a/roms/openhackware b/roms/openhackware
deleted file mode 160000
index c559da7c8e..0000000000
--- a/roms/openhackware
+++ /dev/null
@@ -1 +0,0 @@
-Subproject commit c559da7c8eec5e45ef1f67978827af6f0b9546f5
diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
index a725bce729..4a6218a516 100644
--- a/tests/boot-order-test.c
+++ b/tests/boot-order-test.c
@@ -108,30 +108,6 @@ static void test_pc_boot_order(void)
     test_boot_orders(NULL, read_boot_order_pc, test_cases_pc);
 }
=20
-static uint8_t read_m48t59(QTestState *qts, uint64_t addr, uint16_t reg)
-{
-    qtest_writeb(qts, addr, reg & 0xff);
-    qtest_writeb(qts, addr + 1, reg >> 8);
-    return qtest_readb(qts, addr + 3);
-}
-
-static uint64_t read_boot_order_prep(QTestState *qts)
-{
-    return read_m48t59(qts, 0x80000000 + 0x74, 0x34);
-}
-
-static const boot_order_test test_cases_prep[] =3D {
-    { "", 'c', 'c' },
-    { "-boot c", 'c', 'c' },
-    { "-boot d", 'd', 'd' },
-    {}
-};
-
-static void test_prep_boot_order(void)
-{
-    test_boot_orders("prep", read_boot_order_prep, test_cases_prep);
-}
-
 static uint64_t read_boot_order_pmac(QTestState *qts)
 {
     QFWCFG *fw_cfg =3D mm_fw_cfg_init(qts, 0xf0000510);
@@ -190,7 +166,6 @@ int main(int argc, char *argv[])
     if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, "x86_64") =3D=3D 0) =
{
         qtest_add_func("boot-order/pc", test_pc_boot_order);
     } else if (strcmp(arch, "ppc") =3D=3D 0 || strcmp(arch, "ppc64") =3D=
=3D 0) {
-        qtest_add_func("boot-order/prep", test_prep_boot_order);
         qtest_add_func("boot-order/pmac_oldworld",
                        test_pmac_oldworld_boot_order);
         qtest_add_func("boot-order/pmac_newworld",
diff --git a/tests/cdrom-test.c b/tests/cdrom-test.c
index 34e9974634..006044f48a 100644
--- a/tests/cdrom-test.c
+++ b/tests/cdrom-test.c
@@ -189,7 +189,7 @@ int main(int argc, char **argv)
         add_s390x_tests();
     } else if (g_str_equal(arch, "ppc64")) {
         const char *ppcmachines[] =3D {
-            "pseries", "mac99", "g3beige", "40p", "prep", NULL
+            "pseries", "mac99", "g3beige", "40p", NULL
         };
         add_cdrom_param_tests(ppcmachines);
     } else if (g_str_equal(arch, "sparc")) {
diff --git a/tests/endianness-test.c b/tests/endianness-test.c
index 58527952a5..2798802c63 100644
--- a/tests/endianness-test.c
+++ b/tests/endianness-test.c
@@ -35,7 +35,7 @@ static const TestCase test_cases[] =3D {
     { "mips64", "malta", 0x10000000, .bswap =3D true },
     { "mips64el", "fulong2e", 0x1fd00000 },
     { "ppc", "g3beige", 0xfe000000, .bswap =3D true, .superio =3D "i82378"=
 },
-    { "ppc", "prep", 0x80000000, .bswap =3D true },
+    { "ppc", "40p", 0x80000000, .bswap =3D true },
     { "ppc", "bamboo", 0xe8000000, .bswap =3D true, .superio =3D "i82378" =
},
     { "ppc64", "mac99", 0xf2000000, .bswap =3D true, .superio =3D "i82378"=
 },
     { "ppc64", "pseries", (1ULL << 45), .bswap =3D true, .superio =3D "i82=
378" },
--=20
2.23.0


