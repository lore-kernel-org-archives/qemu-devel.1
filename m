Received: from eggs.gnu.org ([2001:4830:134:3::10]:56597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4D4-0007AQ-CL
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:40:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4D0-0004As-Uh
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:40:26 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4D0-00049Z-ED
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:40:22 -0500
Received: by mail-wr0-x242.google.com with SMTP id o8so7270341wra.1
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 14:40:22 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  8 Mar 2018 23:39:36 +0100
Message-Id: <20180308223946.26784-16-f4bug@amsat.org>
In-Reply-To: <20180308223946.26784-1-f4bug@amsat.org>
References: <20180308223946.26784-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 15/25] hw/mips/malta: Code movement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexey Kardashevskiy <aik@ozlabs.ru>, Yongbok Kim <yongbok.kim@mips.com>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>

Move the SouthBridge peripherals first, and keep the Super I/O
peripherals last.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
2.16.2
