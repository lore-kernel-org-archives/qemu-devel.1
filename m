Received: from eggs.gnu.org ([2001:4830:134:3::10]:58335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiN-00061E-C6
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiM-0003oj-Cd
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:15 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:45855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsiM-0003nW-66
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:14 -0400
Received: by mail-wr0-x241.google.com with SMTP id h2so2480283wre.12
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:14 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:51 +0100
Message-Id: <20180313224719.4954-42-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 41/69] hw/mips/malta: Code movement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Move the SouthBridge peripherals first, and keep the Super I/O
peripherals last.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180308223946.26784-16-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/mips/mips_malta.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index cd7bd0eef6..9e0724ca5a 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1062,10 +1062,6 @@ void mips_malta_init(MachineState *machine)
         memory_region_add_subregion(system_memory, 512 << 20, ram_low_postio);
     }
 
-    /* generate SPD EEPROM data */
-    generate_eeprom_spd(&smbus_eeprom_buf[0 * 256], ram_size);
-    generate_eeprom_serial(&smbus_eeprom_buf[6 * 256]);
-
 #ifdef TARGET_WORDS_BIGENDIAN
     be = 1;
 #else
@@ -1208,15 +1204,19 @@ void mips_malta_init(MachineState *machine)
     pci_create_simple(pci_bus, piix4_devfn + 2, "piix4-usb-uhci");
     smbus = piix4_pm_init(pci_bus, piix4_devfn + 3, 0x1100,
                           isa_get_irq(NULL, 9), NULL, 0, NULL);
-    smbus_eeprom_init(smbus, 8, smbus_eeprom_buf, smbus_eeprom_size);
-    g_free(smbus_eeprom_buf);
     pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
     i8257_dma_init(isa_bus, 0);
+    mc146818_rtc_init(isa_bus, 2000, NULL);
+
+    /* generate SPD EEPROM data */
+    generate_eeprom_spd(&smbus_eeprom_buf[0 * 256], ram_size);
+    generate_eeprom_serial(&smbus_eeprom_buf[6 * 256]);
+    smbus_eeprom_init(smbus, 8, smbus_eeprom_buf, smbus_eeprom_size);
+    g_free(smbus_eeprom_buf);
 
     /* Super I/O */
     isa_create_simple(isa_bus, TYPE_I8042);
 
-    mc146818_rtc_init(isa_bus, 2000, NULL);
     serial_hds_isa_init(isa_bus, 0, 2);
     parallel_hds_isa_init(isa_bus, 1);
 
-- 
2.14.3
