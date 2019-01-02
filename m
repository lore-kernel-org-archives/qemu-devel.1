Received: from eggs.gnu.org ([208.118.235.92]:36604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1geWig-00073U-4f
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 21:57:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1geWic-0006zf-1I
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 21:57:22 -0500
Message-Id: <fc40f941cf84750609e1093eca98fd9248a0981e.1546394798.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1546394798.git.balaton@eik.bme.hu>
References: <cover.1546394798.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Wed, 02 Jan 2019 03:06:38 +0100
Subject: [Qemu-devel] [PATCH 1/8] smbus: Add a helper to generate SPD EEPROM
 data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>

There are several boards with SPD EEPROMs that are now using
duplicated or slightly different hard coded data. Add a helper to
generate SPD data for a memory module of given type and size that
could be used by these boards (either as is or with further changes if
needed) which should help cleaning this up and avoid further duplication.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/i2c/smbus_eeprom.c  | 128 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/i2c/smbus.h |   3 ++
 2 files changed, 131 insertions(+)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index f18aa3de35..a1f51eb921 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -23,6 +23,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/units.h"
 #include "hw/hw.h"
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/smbus.h"
@@ -162,3 +164,129 @@ void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
         smbus_eeprom_init_one(smbus, 0x50 + i, eeprom_buf + (i * 256));
     }
 }
+
+/* Generate SDRAM SPD EEPROM data describing a module of type and size */
+uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t ram_size)
+{
+    uint8_t *spd;
+    uint8_t nbanks;
+    uint16_t density;
+    uint32_t size;
+    int min_log2, max_log2, sz_log2;
+    int i;
+
+    switch (type) {
+    case SDR:
+        min_log2 = 2;
+        max_log2 = 9;
+        break;
+    case DDR:
+        min_log2 = 5;
+        max_log2 = 12;
+        break;
+    case DDR2:
+        min_log2 = 7;
+        max_log2 = 14;
+        break;
+    default:
+        error_report("Unknown SDRAM type");
+        abort();
+    }
+    size = ram_size >> 20; /* work in terms of megabytes */
+    if (size < 4) {
+        error_report("SDRAM size is too small");
+        return NULL;
+    }
+    sz_log2 = 31 - clz32(size);
+    size = 1U << sz_log2;
+    if (ram_size > size * MiB) {
+        warn_report("SDRAM size 0x"RAM_ADDR_FMT" is not a power of 2, "
+                    "truncating to %u MB", ram_size, size);
+    }
+    if (sz_log2 < min_log2) {
+        warn_report("Memory size is too small for SDRAM type, adjusting type");
+        if (size >= 32) {
+            type = DDR;
+            min_log2 = 5;
+            max_log2 = 12;
+        } else {
+            type = SDR;
+            min_log2 = 2;
+            max_log2 = 9;
+        }
+    }
+
+    nbanks = 1;
+    while (sz_log2 > max_log2 && nbanks < 8) {
+        sz_log2--;
+        nbanks++;
+    }
+
+    if (size > (1ULL << sz_log2) * nbanks) {
+        warn_report("Memory size is too big for SDRAM, truncating");
+    }
+
+    /* split to 2 banks if possible to avoid a bug in MIPS Malta firmware */
+    if (nbanks == 1 && sz_log2 > min_log2) {
+        sz_log2--;
+        nbanks++;
+    }
+
+    density = 1ULL << (sz_log2 - 2);
+    switch (type) {
+    case DDR2:
+        density = (density & 0xe0) | (density >> 8 & 0x1f);
+        break;
+    case DDR:
+        density = (density & 0xf8) | (density >> 8 & 0x07);
+        break;
+    case SDR:
+    default:
+        density &= 0xff;
+        break;
+    }
+
+    spd = g_malloc0(256);
+    spd[0] = 128;   /* data bytes in EEPROM */
+    spd[1] = 8;     /* log2 size of EEPROM */
+    spd[2] = type;
+    spd[3] = 13;    /* row address bits */
+    spd[4] = 10;    /* column address bits */
+    spd[5] = (type == DDR2 ? nbanks - 1 : nbanks);
+    spd[6] = 64;    /* module data width */
+                    /* reserved / data width high */
+    spd[8] = 4;     /* interface voltage level */
+    spd[9] = 0x25;  /* highest CAS latency */
+    spd[10] = 1;    /* access time */
+                    /* DIMM configuration 0 = non-ECC */
+    spd[12] = 0x82; /* refresh requirements */
+    spd[13] = 8;    /* primary SDRAM width */
+                    /* ECC SDRAM width */
+    spd[15] = (type == DDR2 ? 0 : 1); /* reserved / delay for random col rd */
+    spd[16] = 12;   /* burst lengths supported */
+    spd[17] = 4;    /* banks per SDRAM device */
+    spd[18] = 12;   /* ~CAS latencies supported */
+    spd[19] = (type == DDR2 ? 0 : 1); /* reserved / ~CS latencies supported */
+    spd[20] = 2;    /* DIMM type / ~WE latencies */
+                    /* module features */
+                    /* memory chip features */
+    spd[23] = 0x12; /* clock cycle time @ medium CAS latency */
+                    /* data access time */
+                    /* clock cycle time @ short CAS latency */
+                    /* data access time */
+    spd[27] = 20;   /* min. row precharge time */
+    spd[28] = 15;   /* min. row active row delay */
+    spd[29] = 20;   /* min. ~RAS to ~CAS delay */
+    spd[30] = 45;   /* min. active to precharge time */
+    spd[31] = density;
+    spd[32] = 20;   /* addr/cmd setup time */
+    spd[33] = 8;    /* addr/cmd hold time */
+    spd[34] = 20;   /* data input setup time */
+    spd[35] = 8;    /* data input hold time */
+
+    /* checksum */
+    for (i = 0; i < 63; i++) {
+        spd[63] += spd[i];
+    }
+    return spd;
+}
diff --git a/include/hw/i2c/smbus.h b/include/hw/i2c/smbus.h
index d8b1b9ee81..0adc2991b5 100644
--- a/include/hw/i2c/smbus.h
+++ b/include/hw/i2c/smbus.h
@@ -93,4 +93,7 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf);
 void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
                        const uint8_t *eeprom_spd, int size);
 
+enum sdram_type { SDR = 0x4, DDR = 0x7, DDR2 = 0x8 };
+uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t size);
+
 #endif
-- 
2.13.7
