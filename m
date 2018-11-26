Received: from eggs.gnu.org ([2001:4830:134:3::10]:53796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gRN83-0001n8-5k
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gRN7y-0001LT-QU
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:05:11 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gRN7y-0001GR-Az
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:05:06 -0500
Received: by mail-ot1-x343.google.com with SMTP id v23so12442983otk.9
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 12:04:51 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 26 Nov 2018 14:04:20 -0600
Message-Id: <20181126200435.23408-2-minyard@acm.org>
In-Reply-To: <20181126200435.23408-1-minyard@acm.org>
References: <20181126200435.23408-1-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v3 01/16] i2c: Split smbus into parts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

smbus.c and smbus.h had device side code, master side code, and
smbus.h has some smbus_eeprom.c definitions.  Split them into
separate files.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 MAINTAINERS                               |  12 ++
 hw/arm/aspeed.c                           |   2 +-
 hw/i2c/Makefile.objs                      |   2 +-
 hw/i2c/pm_smbus.c                         |   2 +-
 hw/i2c/smbus_eeprom.c                     |   3 +-
 hw/i2c/smbus_ich9.c                       |   2 -
 hw/i2c/smbus_master.c                     | 165 ++++++++++++++++++++++
 hw/i2c/{smbus.c => smbus_slave.c}         | 153 +-------------------
 hw/i386/pc_piix.c                         |   2 +-
 hw/i386/pc_q35.c                          |   2 +-
 hw/isa/vt82c686.c                         |   1 -
 hw/mips/mips_fulong2e.c                   |   2 +-
 hw/mips/mips_malta.c                      |   2 +-
 hw/ppc/sam460ex.c                         |   2 +-
 include/hw/i2c/pm_smbus.h                 |   2 +
 include/hw/i2c/smbus_eeprom.h             |  32 +++++
 include/hw/i2c/smbus_master.h             |  55 ++++++++
 include/hw/i2c/{smbus.h => smbus_slave.h} |  37 +----
 18 files changed, 285 insertions(+), 193 deletions(-)
 create mode 100644 hw/i2c/smbus_master.c
 rename hw/i2c/{smbus.c => smbus_slave.c} (64%)
 create mode 100644 include/hw/i2c/smbus_eeprom.h
 create mode 100644 include/hw/i2c/smbus_master.h
 rename include/hw/i2c/{smbus.h => smbus_slave.h} (65%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0499e11593..62340d32b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1935,6 +1935,18 @@ M: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
 S: Maintained
 F: contrib/elf2dmp/
 
+I2C
+M: Corey Minyard <cminyard@mvista.com>
+S: Maintained
+F: hw/i2c/core.c
+F: hw/i2c/smbus_slave.c
+F: hw/i2c/smbus_master.c
+F: hw/i2c/smbus_eeprom.c
+F: include/hw/i2c/i2c.h
+F: include/hw/i2c/smbus_master.h
+F: include/hw/i2c/smbus_slave.h
+F: include/hw/i2c/smbus_eeprom.h
+
 Usermode Emulation
 ------------------
 Overall
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 6b33ecd5aa..69a19df00d 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -18,7 +18,7 @@
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/boards.h"
-#include "hw/i2c/smbus.h"
+#include "hw/i2c/smbus_eeprom.h"
 #include "qemu/log.h"
 #include "sysemu/block-backend.h"
 #include "hw/loader.h"
diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
index 37cacde978..8973edfa22 100644
--- a/hw/i2c/Makefile.objs
+++ b/hw/i2c/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-$(CONFIG_I2C) += core.o smbus.o smbus_eeprom.o
+common-obj-$(CONFIG_I2C) += core.o smbus_slave.o smbus_master.o smbus_eeprom.o
 common-obj-$(CONFIG_DDC) += i2c-ddc.o
 common-obj-$(CONFIG_VERSATILE_I2C) += versatile_i2c.o
 common-obj-$(CONFIG_ACPI_X86) += smbus_ich9.o
diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 685a2378ed..f3c6cc46f9 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/i2c/pm_smbus.h"
-#include "hw/i2c/smbus.h"
+#include "hw/i2c/smbus_master.h"
 
 #define SMBHSTSTS       0x00
 #define SMBHSTCNT       0x02
diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index f18aa3de35..d82423aa7e 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -25,7 +25,8 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/i2c/i2c.h"
-#include "hw/i2c/smbus.h"
+#include "hw/i2c/smbus_slave.h"
+#include "hw/i2c/smbus_eeprom.h"
 
 //#define DEBUG
 
diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
index 2a8b49e02f..e6d8d28194 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/smbus_ich9.c
@@ -29,8 +29,6 @@
 #include "hw/i2c/pm_smbus.h"
 #include "hw/pci/pci.h"
 #include "sysemu/sysemu.h"
-#include "hw/i2c/i2c.h"
-#include "hw/i2c/smbus.h"
 
 #include "hw/i386/ich9.h"
 
diff --git a/hw/i2c/smbus_master.c b/hw/i2c/smbus_master.c
new file mode 100644
index 0000000000..0a6223744c
--- /dev/null
+++ b/hw/i2c/smbus_master.c
@@ -0,0 +1,165 @@
+/*
+ * QEMU SMBus host (master) emulation.
+ *
+ * This code emulates SMBus transactions from the master point of view,
+ * it runs the individual I2C transaction to do the SMBus protocol
+ * over I2C.
+ *
+ * Copyright (c) 2007 CodeSourcery.
+ * Written by Paul Brook
+ *
+ * This code is licensed under the LGPL.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "hw/i2c/i2c.h"
+#include "hw/i2c/smbus_master.h"
+
+/* Master device commands.  */
+int smbus_quick_command(I2CBus *bus, uint8_t addr, int read)
+{
+    if (i2c_start_transfer(bus, addr, read)) {
+        return -1;
+    }
+    i2c_end_transfer(bus);
+    return 0;
+}
+
+int smbus_receive_byte(I2CBus *bus, uint8_t addr)
+{
+    uint8_t data;
+
+    if (i2c_start_transfer(bus, addr, 1)) {
+        return -1;
+    }
+    data = i2c_recv(bus);
+    i2c_nack(bus);
+    i2c_end_transfer(bus);
+    return data;
+}
+
+int smbus_send_byte(I2CBus *bus, uint8_t addr, uint8_t data)
+{
+    if (i2c_start_transfer(bus, addr, 0)) {
+        return -1;
+    }
+    i2c_send(bus, data);
+    i2c_end_transfer(bus);
+    return 0;
+}
+
+int smbus_read_byte(I2CBus *bus, uint8_t addr, uint8_t command)
+{
+    uint8_t data;
+    if (i2c_start_transfer(bus, addr, 0)) {
+        return -1;
+    }
+    i2c_send(bus, command);
+    if (i2c_start_transfer(bus, addr, 1)) {
+        i2c_end_transfer(bus);
+        return -1;
+    }
+    data = i2c_recv(bus);
+    i2c_nack(bus);
+    i2c_end_transfer(bus);
+    return data;
+}
+
+int smbus_write_byte(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t data)
+{
+    if (i2c_start_transfer(bus, addr, 0)) {
+        return -1;
+    }
+    i2c_send(bus, command);
+    i2c_send(bus, data);
+    i2c_end_transfer(bus);
+    return 0;
+}
+
+int smbus_read_word(I2CBus *bus, uint8_t addr, uint8_t command)
+{
+    uint16_t data;
+    if (i2c_start_transfer(bus, addr, 0)) {
+        return -1;
+    }
+    i2c_send(bus, command);
+    if (i2c_start_transfer(bus, addr, 1)) {
+        i2c_end_transfer(bus);
+        return -1;
+    }
+    data = i2c_recv(bus);
+    data |= i2c_recv(bus) << 8;
+    i2c_nack(bus);
+    i2c_end_transfer(bus);
+    return data;
+}
+
+int smbus_write_word(I2CBus *bus, uint8_t addr, uint8_t command, uint16_t data)
+{
+    if (i2c_start_transfer(bus, addr, 0)) {
+        return -1;
+    }
+    i2c_send(bus, command);
+    i2c_send(bus, data & 0xff);
+    i2c_send(bus, data >> 8);
+    i2c_end_transfer(bus);
+    return 0;
+}
+
+int smbus_read_block(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t *data,
+                     int len, bool recv_len, bool send_cmd)
+{
+    int rlen;
+    int i;
+
+    if (send_cmd) {
+        if (i2c_start_transfer(bus, addr, 0)) {
+            return -1;
+        }
+        i2c_send(bus, command);
+    }
+    if (i2c_start_transfer(bus, addr, 1)) {
+        if (send_cmd) {
+            i2c_end_transfer(bus);
+        }
+        return -1;
+    }
+    if (recv_len) {
+        rlen = i2c_recv(bus);
+    } else {
+        rlen = len;
+    }
+    if (rlen > len) {
+        rlen = 0;
+    }
+    for (i = 0; i < rlen; i++) {
+        data[i] = i2c_recv(bus);
+    }
+    i2c_nack(bus);
+    i2c_end_transfer(bus);
+    return rlen;
+}
+
+int smbus_write_block(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t *data,
+                      int len, bool send_len)
+{
+    int i;
+
+    if (len > 32) {
+        len = 32;
+    }
+
+    if (i2c_start_transfer(bus, addr, 0)) {
+        return -1;
+    }
+    i2c_send(bus, command);
+    if (send_len) {
+        i2c_send(bus, len);
+    }
+    for (i = 0; i < len; i++) {
+        i2c_send(bus, data[i]);
+    }
+    i2c_end_transfer(bus);
+    return 0;
+}
diff --git a/hw/i2c/smbus.c b/hw/i2c/smbus_slave.c
similarity index 64%
rename from hw/i2c/smbus.c
rename to hw/i2c/smbus_slave.c
index 6ff77c582f..1e734752d7 100644
--- a/hw/i2c/smbus.c
+++ b/hw/i2c/smbus_slave.c
@@ -1,6 +1,10 @@
 /*
  * QEMU SMBus device emulation.
  *
+ * This code is a helper for SMBus device emulation.  It implements an
+ * I2C device inteface and runs the SMBus protocol from the device
+ * point of view and maps those to simple calls to emulate.
+ *
  * Copyright (c) 2007 CodeSourcery.
  * Written by Paul Brook
  *
@@ -12,7 +16,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/i2c/i2c.h"
-#include "hw/i2c/smbus.h"
+#include "hw/i2c/smbus_slave.h"
 
 //#define DEBUG_SMBUS 1
 
@@ -202,153 +206,6 @@ static int smbus_i2c_send(I2CSlave *s, uint8_t data)
     return 0;
 }
 
-/* Master device commands.  */
-int smbus_quick_command(I2CBus *bus, uint8_t addr, int read)
-{
-    if (i2c_start_transfer(bus, addr, read)) {
-        return -1;
-    }
-    i2c_end_transfer(bus);
-    return 0;
-}
-
-int smbus_receive_byte(I2CBus *bus, uint8_t addr)
-{
-    uint8_t data;
-
-    if (i2c_start_transfer(bus, addr, 1)) {
-        return -1;
-    }
-    data = i2c_recv(bus);
-    i2c_nack(bus);
-    i2c_end_transfer(bus);
-    return data;
-}
-
-int smbus_send_byte(I2CBus *bus, uint8_t addr, uint8_t data)
-{
-    if (i2c_start_transfer(bus, addr, 0)) {
-        return -1;
-    }
-    i2c_send(bus, data);
-    i2c_end_transfer(bus);
-    return 0;
-}
-
-int smbus_read_byte(I2CBus *bus, uint8_t addr, uint8_t command)
-{
-    uint8_t data;
-    if (i2c_start_transfer(bus, addr, 0)) {
-        return -1;
-    }
-    i2c_send(bus, command);
-    if (i2c_start_transfer(bus, addr, 1)) {
-        i2c_end_transfer(bus);
-        return -1;
-    }
-    data = i2c_recv(bus);
-    i2c_nack(bus);
-    i2c_end_transfer(bus);
-    return data;
-}
-
-int smbus_write_byte(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t data)
-{
-    if (i2c_start_transfer(bus, addr, 0)) {
-        return -1;
-    }
-    i2c_send(bus, command);
-    i2c_send(bus, data);
-    i2c_end_transfer(bus);
-    return 0;
-}
-
-int smbus_read_word(I2CBus *bus, uint8_t addr, uint8_t command)
-{
-    uint16_t data;
-    if (i2c_start_transfer(bus, addr, 0)) {
-        return -1;
-    }
-    i2c_send(bus, command);
-    if (i2c_start_transfer(bus, addr, 1)) {
-        i2c_end_transfer(bus);
-        return -1;
-    }
-    data = i2c_recv(bus);
-    data |= i2c_recv(bus) << 8;
-    i2c_nack(bus);
-    i2c_end_transfer(bus);
-    return data;
-}
-
-int smbus_write_word(I2CBus *bus, uint8_t addr, uint8_t command, uint16_t data)
-{
-    if (i2c_start_transfer(bus, addr, 0)) {
-        return -1;
-    }
-    i2c_send(bus, command);
-    i2c_send(bus, data & 0xff);
-    i2c_send(bus, data >> 8);
-    i2c_end_transfer(bus);
-    return 0;
-}
-
-int smbus_read_block(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t *data,
-                     int len, bool recv_len, bool send_cmd)
-{
-    int rlen;
-    int i;
-
-    if (send_cmd) {
-        if (i2c_start_transfer(bus, addr, 0)) {
-            return -1;
-        }
-        i2c_send(bus, command);
-    }
-    if (i2c_start_transfer(bus, addr, 1)) {
-        if (send_cmd) {
-            i2c_end_transfer(bus);
-        }
-        return -1;
-    }
-    if (recv_len) {
-        rlen = i2c_recv(bus);
-    } else {
-        rlen = len;
-    }
-    if (rlen > len) {
-        rlen = 0;
-    }
-    for (i = 0; i < rlen; i++) {
-        data[i] = i2c_recv(bus);
-    }
-    i2c_nack(bus);
-    i2c_end_transfer(bus);
-    return rlen;
-}
-
-int smbus_write_block(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t *data,
-                      int len, bool send_len)
-{
-    int i;
-
-    if (len > 32)
-        len = 32;
-
-    if (i2c_start_transfer(bus, addr, 0)) {
-        return -1;
-    }
-    i2c_send(bus, command);
-    if (send_len) {
-        i2c_send(bus, len);
-    }
-    for (i = 0; i < len; i++) {
-        i2c_send(bus, data[i]);
-    }
-    i2c_end_transfer(bus);
-    return 0;
-}
-
 static void smbus_device_class_init(ObjectClass *klass, void *data)
 {
     I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index dc09466b3e..cb28227cc3 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -42,7 +42,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
 #include "sysemu/arch_init.h"
-#include "hw/i2c/smbus.h"
+#include "hw/i2c/smbus_eeprom.h"
 #include "hw/xen/xen.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 532241e3f8..90e88c9b28 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -33,7 +33,7 @@
 #include "hw/hw.h"
 #include "hw/loader.h"
 #include "sysemu/arch_init.h"
-#include "hw/i2c/smbus.h"
+#include "hw/i2c/smbus_eeprom.h"
 #include "hw/boards.h"
 #include "hw/timer/mc146818rtc.h"
 #include "hw/xen/xen.h"
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 7302f6d74b..85d0532dd5 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -14,7 +14,6 @@
 #include "hw/hw.h"
 #include "hw/isa/vt82c686.h"
 #include "hw/i2c/i2c.h"
-#include "hw/i2c/smbus.h"
 #include "hw/pci/pci.h"
 #include "hw/isa/isa.h"
 #include "hw/isa/superio.h"
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 2fbba32c48..dae8acc108 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -27,7 +27,7 @@
 #include "hw/isa/superio.h"
 #include "net/net.h"
 #include "hw/boards.h"
-#include "hw/i2c/smbus.h"
+#include "hw/i2c/smbus_eeprom.h"
 #include "hw/block/flash.h"
 #include "hw/mips/mips.h"
 #include "hw/mips/cpudevs.h"
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index c1cf0fe12e..1fb7170f5e 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -33,7 +33,7 @@
 #include "hw/char/serial.h"
 #include "net/net.h"
 #include "hw/boards.h"
-#include "hw/i2c/smbus.h"
+#include "hw/i2c/smbus_eeprom.h"
 #include "hw/block/flash.h"
 #include "hw/mips/mips.h"
 #include "hw/mips/cpudevs.h"
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 5aac58f36e..7136b23f91 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -34,7 +34,7 @@
 #include "hw/sysbus.h"
 #include "hw/char/serial.h"
 #include "hw/i2c/ppc4xx_i2c.h"
-#include "hw/i2c/smbus.h"
+#include "hw/i2c/smbus_eeprom.h"
 #include "hw/usb/hcd-ehci.h"
 #include "hw/ppc/fdt.h"
 
diff --git a/include/hw/i2c/pm_smbus.h b/include/hw/i2c/pm_smbus.h
index 060d3c6ac0..6dd5b7040b 100644
--- a/include/hw/i2c/pm_smbus.h
+++ b/include/hw/i2c/pm_smbus.h
@@ -1,6 +1,8 @@
 #ifndef PM_SMBUS_H
 #define PM_SMBUS_H
 
+#include "hw/i2c/smbus_master.h"
+
 #define PM_SMBUS_MAX_MSG_SIZE 32
 
 typedef struct PMSMBus {
diff --git a/include/hw/i2c/smbus_eeprom.h b/include/hw/i2c/smbus_eeprom.h
new file mode 100644
index 0000000000..46fb1a37d6
--- /dev/null
+++ b/include/hw/i2c/smbus_eeprom.h
@@ -0,0 +1,32 @@
+/*
+ * QEMU SMBus EEPROM API
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef HW_SMBUS_EEPROM_H
+#define HW_SMBUS_EEPROM_H
+
+#include "hw/i2c/i2c.h"
+
+void smbus_eeprom_init_one(I2CBus *bus, uint8_t address, uint8_t *eeprom_buf);
+void smbus_eeprom_init(I2CBus *bus, int nb_eeprom,
+                       const uint8_t *eeprom_spd, int size);
+
+#endif
diff --git a/include/hw/i2c/smbus_master.h b/include/hw/i2c/smbus_master.h
new file mode 100644
index 0000000000..bb13bc423c
--- /dev/null
+++ b/include/hw/i2c/smbus_master.h
@@ -0,0 +1,55 @@
+/*
+ * QEMU SMBus host (master) API
+ *
+ * Copyright (c) 2007 Arastra, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef HW_SMBUS_MASTER_H
+#define HW_SMBUS_MASTER_H
+
+#include "hw/i2c/i2c.h"
+
+/* Master device commands.  */
+int smbus_quick_command(I2CBus *bus, uint8_t addr, int read);
+int smbus_receive_byte(I2CBus *bus, uint8_t addr);
+int smbus_send_byte(I2CBus *bus, uint8_t addr, uint8_t data);
+int smbus_read_byte(I2CBus *bus, uint8_t addr, uint8_t command);
+int smbus_write_byte(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t data);
+int smbus_read_word(I2CBus *bus, uint8_t addr, uint8_t command);
+int smbus_write_word(I2CBus *bus, uint8_t addr, uint8_t command, uint16_t data);
+
+/*
+ * Do a block transfer from an I2C device.  If recv_len is set, then the
+ * first received byte is a length field and is used to know how much data
+ * to receive.  Otherwise receive "len" bytes.  If send_cmd is set, send
+ * the command byte first before receiving the data.
+ */
+int smbus_read_block(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t *data,
+                     int len, bool recv_len, bool send_cmd);
+
+/*
+ * Do a block transfer to an I2C device.  If send_len is set, send the
+ * "len" value before the data.
+ */
+int smbus_write_block(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t *data,
+                      int len, bool send_len);
+
+#endif
diff --git a/include/hw/i2c/smbus.h b/include/hw/i2c/smbus_slave.h
similarity index 65%
rename from include/hw/i2c/smbus.h
rename to include/hw/i2c/smbus_slave.h
index d8b1b9ee81..ff07ee005d 100644
--- a/include/hw/i2c/smbus.h
+++ b/include/hw/i2c/smbus_slave.h
@@ -1,8 +1,5 @@
-#ifndef QEMU_SMBUS_H
-#define QEMU_SMBUS_H
-
 /*
- * QEMU SMBus API
+ * QEMU SMBus device (slave) API
  *
  * Copyright (c) 2007 Arastra, Inc.
  *
@@ -25,6 +22,9 @@
  * THE SOFTWARE.
  */
 
+#ifndef HW_SMBUS_SLAVE_H
+#define HW_SMBUS_SLAVE_H
+
 #include "hw/i2c/i2c.h"
 
 #define TYPE_SMBUS_DEVICE "smbus-device"
@@ -64,33 +64,4 @@ struct SMBusDevice {
     uint8_t command;
 };
 
-/* Master device commands.  */
-int smbus_quick_command(I2CBus *bus, uint8_t addr, int read);
-int smbus_receive_byte(I2CBus *bus, uint8_t addr);
-int smbus_send_byte(I2CBus *bus, uint8_t addr, uint8_t data);
-int smbus_read_byte(I2CBus *bus, uint8_t addr, uint8_t command);
-int smbus_write_byte(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t data);
-int smbus_read_word(I2CBus *bus, uint8_t addr, uint8_t command);
-int smbus_write_word(I2CBus *bus, uint8_t addr, uint8_t command, uint16_t data);
-
-/*
- * Do a block transfer from an I2C device.  If recv_len is set, then the
- * first received byte is a length field and is used to know how much data
- * to receive.  Otherwise receive "len" bytes.  If send_cmd is set, send
- * the command byte first before receiving the data.
- */
-int smbus_read_block(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t *data,
-                     int len, bool recv_len, bool send_cmd);
-
-/*
- * Do a block transfer to an I2C device.  If send_len is set, send the
- * "len" value before the data.
- */
-int smbus_write_block(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t *data,
-                      int len, bool send_len);
-
-void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf);
-void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
-                       const uint8_t *eeprom_spd, int size);
-
 #endif
-- 
2.17.1
