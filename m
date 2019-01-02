Received: from eggs.gnu.org ([208.118.235.92]:35936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1geWgV-0004Pc-L9
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 21:55:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1geWgT-0005Sb-2d
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 21:55:07 -0500
Message-Id: <2403f70ea0cda1ba4e6345eb89a5aa5f3fe6e264.1546394798.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1546394798.git.balaton@eik.bme.hu>
References: <cover.1546394798.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Wed, 02 Jan 2019 03:06:38 +0100
Subject: [Qemu-devel] [PATCH 2/8] sam460ex: Clean up SPD EEPROM creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>

Get rid of code from MIPS Malta board used to create SPD EEPROM data
(parts of which was not even needed for sam460ex) and use the generic
spd_data_generate() function to simplify this.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/sam460ex.c | 169 ++++++------------------------------------------------
 1 file changed, 16 insertions(+), 153 deletions(-)

diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 4b051c0950..2bb91ed21b 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -2,7 +2,7 @@
  * QEMU aCube Sam460ex board emulation
  *
  * Copyright (c) 2012 François Revol
- * Copyright (c) 2016-2018 BALATON Zoltan
+ * Copyright (c) 2016-2019 BALATON Zoltan
  *
  * This file is derived from hw/ppc440_bamboo.c,
  * the copyright for that material belongs to the original owners.
@@ -87,135 +87,6 @@ struct boot_info {
     uint32_t entry;
 };
 
-/*****************************************************************************/
-/* SPD eeprom content from mips_malta.c */
-
-struct _eeprom24c0x_t {
-  uint8_t tick;
-  uint8_t address;
-  uint8_t command;
-  uint8_t ack;
-  uint8_t scl;
-  uint8_t sda;
-  uint8_t data;
-  uint8_t contents[256];
-};
-
-typedef struct _eeprom24c0x_t eeprom24c0x_t;
-
-static eeprom24c0x_t spd_eeprom = {
-    .contents = {
-        /* 00000000: */ 0x80, 0x08, 0xFF, 0x0D, 0x0A, 0xFF, 0x40, 0x00,
-        /* 00000008: */ 0x04, 0x75, 0x54, 0x00, 0x82, 0x08, 0x00, 0x01,
-        /* 00000010: */ 0x8F, 0x04, 0x02, 0x01, 0x01, 0x00, 0x00, 0x00,
-        /* 00000018: */ 0x00, 0x00, 0x00, 0x14, 0x0F, 0x14, 0x2D, 0xFF,
-        /* 00000020: */ 0x15, 0x08, 0x15, 0x08, 0x00, 0x00, 0x00, 0x00,
-        /* 00000028: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-        /* 00000030: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-        /* 00000038: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x12, 0xD0,
-        /* 00000040: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-        /* 00000048: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-        /* 00000050: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-        /* 00000058: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-        /* 00000060: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-        /* 00000068: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-        /* 00000070: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-        /* 00000078: */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x64, 0xF4,
-    },
-};
-
-static void generate_eeprom_spd(uint8_t *eeprom, ram_addr_t ram_size)
-{
-    enum { SDR = 0x4, DDR1 = 0x7, DDR2 = 0x8 } type;
-    uint8_t *spd = spd_eeprom.contents;
-    uint8_t nbanks = 0;
-    uint16_t density = 0;
-    int i;
-
-    /* work in terms of MB */
-    ram_size /= MiB;
-
-    while ((ram_size >= 4) && (nbanks <= 2)) {
-        int sz_log2 = MIN(31 - clz32(ram_size), 14);
-        nbanks++;
-        density |= 1 << (sz_log2 - 2);
-        ram_size -= 1 << sz_log2;
-    }
-
-    /* split to 2 banks if possible */
-    if ((nbanks == 1) && (density > 1)) {
-        nbanks++;
-        density >>= 1;
-    }
-
-    if (density & 0xff00) {
-        density = (density & 0xe0) | ((density >> 8) & 0x1f);
-        type = DDR2;
-    } else if (!(density & 0x1f)) {
-        type = DDR2;
-    } else {
-        type = SDR;
-    }
-
-    if (ram_size) {
-        warn_report("SPD cannot represent final " RAM_ADDR_FMT "MB"
-                    " of SDRAM", ram_size);
-    }
-
-    /* fill in SPD memory information */
-    spd[2] = type;
-    spd[5] = nbanks;
-    spd[31] = density;
-
-    /* XXX: this is totally random */
-    spd[9] = 0x10; /* CAS tcyc */
-    spd[18] = 0x20; /* CAS bit */
-    spd[23] = 0x10; /* CAS tcyc */
-    spd[25] = 0x10; /* CAS tcyc */
-
-    /* checksum */
-    spd[63] = 0;
-    for (i = 0; i < 63; i++) {
-        spd[63] += spd[i];
-    }
-
-    /* copy for SMBUS */
-    memcpy(eeprom, spd, sizeof(spd_eeprom.contents));
-}
-
-static void generate_eeprom_serial(uint8_t *eeprom)
-{
-    int i, pos = 0;
-    uint8_t mac[6] = { 0x00 };
-    uint8_t sn[5] = { 0x01, 0x23, 0x45, 0x67, 0x89 };
-
-    /* version */
-    eeprom[pos++] = 0x01;
-
-    /* count */
-    eeprom[pos++] = 0x02;
-
-    /* MAC address */
-    eeprom[pos++] = 0x01; /* MAC */
-    eeprom[pos++] = 0x06; /* length */
-    memcpy(&eeprom[pos], mac, sizeof(mac));
-    pos += sizeof(mac);
-
-    /* serial number */
-    eeprom[pos++] = 0x02; /* serial */
-    eeprom[pos++] = 0x05; /* length */
-    memcpy(&eeprom[pos], sn, sizeof(sn));
-    pos += sizeof(sn);
-
-    /* checksum */
-    eeprom[pos] = 0;
-    for (i = 0; i < pos; i++) {
-        eeprom[pos] += eeprom[i];
-    }
-}
-
-/*****************************************************************************/
-
 static int sam460ex_load_uboot(void)
 {
     DriveInfo *dinfo;
@@ -393,24 +264,22 @@ static void sam460ex_init(MachineState *machine)
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *isa = g_new(MemoryRegion, 1);
     MemoryRegion *ram_memories = g_new(MemoryRegion, SDRAM_NR_BANKS);
-    hwaddr ram_bases[SDRAM_NR_BANKS];
-    hwaddr ram_sizes[SDRAM_NR_BANKS];
+    hwaddr ram_bases[SDRAM_NR_BANKS] = {0};
+    hwaddr ram_sizes[SDRAM_NR_BANKS] = {0};
     MemoryRegion *l2cache_ram = g_new(MemoryRegion, 1);
     qemu_irq *irqs, *uic[4];
     PCIBus *pci_bus;
     PowerPCCPU *cpu;
     CPUPPCState *env;
-    PPC4xxI2CState *i2c[2];
+    I2CBus *i2c;
     hwaddr entry = UBOOT_ENTRY;
     hwaddr loadaddr = 0;
     target_long initrd_size = 0;
     DeviceState *dev;
     SysBusDevice *sbdev;
-    int success;
-    int i;
     struct boot_info *boot_info;
-    const size_t smbus_eeprom_size = 8 * 256;
-    uint8_t *smbus_eeprom_buf = g_malloc0(smbus_eeprom_size);
+    uint8_t *spd_data;
+    int success;
 
     cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
     env = &cpu->env;
@@ -439,8 +308,6 @@ static void sam460ex_init(MachineState *machine)
     uic[3] = ppcuic_init(env, &uic[0][16], 0xf0, 0, 1);
 
     /* SDRAM controller */
-    memset(ram_bases, 0, sizeof(ram_bases));
-    memset(ram_sizes, 0, sizeof(ram_sizes));
     /* put all RAM on first bank because board has one slot
      * and firmware only checks that */
     machine->ram_size = ppc4xx_sdram_adjust(machine->ram_size, 1,
@@ -451,23 +318,19 @@ static void sam460ex_init(MachineState *machine)
     ppc440_sdram_init(env, SDRAM_NR_BANKS, ram_memories,
                       ram_bases, ram_sizes, 1);
 
-    /* generate SPD EEPROM data */
-    for (i = 0; i < SDRAM_NR_BANKS; i++) {
-        generate_eeprom_spd(&smbus_eeprom_buf[i * 256], ram_sizes[i]);
-    }
-    generate_eeprom_serial(&smbus_eeprom_buf[4 * 256]);
-    generate_eeprom_serial(&smbus_eeprom_buf[6 * 256]);
-
-    /* IIC controllers */
+    /* IIC controllers and devices */
     dev = sysbus_create_simple(TYPE_PPC4xx_I2C, 0x4ef600700, uic[0][2]);
-    i2c[0] = PPC4xx_I2C(dev);
-    object_property_set_bool(OBJECT(dev), true, "realized", NULL);
-    smbus_eeprom_init(i2c[0]->bus, 8, smbus_eeprom_buf, smbus_eeprom_size);
-    g_free(smbus_eeprom_buf);
-    i2c_create_slave(i2c[0]->bus, "m41t80", 0x68);
+    i2c = PPC4xx_I2C(dev)->bus;
+    /* SPD EEPROM on RAM module */
+    spd_data = spd_data_generate(DDR2, ram_sizes[0]);
+    if (spd_data) {
+        spd_data[20] = 4; /* SO-DIMM module */
+        smbus_eeprom_init_one(i2c, 0x50, spd_data);
+    }
+    /* RTC */
+    i2c_create_slave(i2c, "m41t80", 0x68);
 
     dev = sysbus_create_simple(TYPE_PPC4xx_I2C, 0x4ef600800, uic[0][3]);
-    i2c[1] = PPC4xx_I2C(dev);
 
     /* External bus controller */
     ppc405_ebc_init(env);
-- 
2.13.7
