Received: from eggs.gnu.org ([2001:4830:134:3::10]:51341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNST-0006pV-Rt
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNST-0002RQ-4e
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:41 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:47093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSS-0002R2-WB
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:41 -0500
Received: by mail-qt0-x241.google.com with SMTP id r39so12053430qtr.13
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:46:40 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  7 Jan 2018 23:45:38 -0300
Message-Id: <20180108024558.17983-10-f4bug@amsat.org>
In-Reply-To: <20180108024558.17983-1-f4bug@amsat.org>
References: <20180108024558.17983-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 09/29] hw/mips/malta: code movement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/mips_malta.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 28cc37ee08..195d7dd59e 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1063,10 +1063,6 @@ void mips_malta_init(MachineState *machine)
         memory_region_add_subregion(system_memory, 512 << 20, ram_low_postio);
     }
 
-    /* generate SPD EEPROM data */
-    generate_eeprom_spd(&smbus_eeprom_buf[0 * 256], ram_size);
-    generate_eeprom_serial(&smbus_eeprom_buf[6 * 256]);
-
 #ifdef TARGET_WORDS_BIGENDIAN
     be = 1;
 #else
@@ -1209,15 +1205,19 @@ void mips_malta_init(MachineState *machine)
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
2.15.1
