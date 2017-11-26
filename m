Received: from eggs.gnu.org ([2001:4830:134:3::10]:56788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eJ4xm-00072G-Rm
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 16:59:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eJ4xl-0002rs-Fc
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 16:59:46 -0500
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sun, 26 Nov 2017 15:59:02 -0600
Message-Id: <5525ca41a3ce3d5af7755d337b382fede3ef530e.1511731946.git.mdavidsaver@gmail.com>
In-Reply-To: <cover.1511731946.git.mdavidsaver@gmail.com>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
In-Reply-To: <cover.1511731946.git.mdavidsaver@gmail.com>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 04/17] qtest: add e500_i2c_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Add interface for testing i2c devices
with PPC e500.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 tests/Makefile.include  |  1 +
 tests/libqos/i2c-e500.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/libqos/i2c.h      |  3 +++
 3 files changed, 70 insertions(+)
 create mode 100644 tests/libqos/i2c-e500.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index c002352134..ad1c219423 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -721,6 +721,7 @@ libqos-pc-obj-y += tests/libqos/malloc-pc.o tests/libqos/libqos-pc.o
 libqos-pc-obj-y += tests/libqos/ahci.o
 libqos-omap-obj-y = $(libqos-obj-y) tests/libqos/i2c-omap.o
 libqos-imx-obj-y = $(libqos-obj-y) tests/libqos/i2c-imx.o
+libqos-e500-obj-y = $(libqos-obj-y) tests/libqos/i2c-e500.o
 libqos-usb-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/usb.o
 libqos-virtio-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/virtio.o tests/libqos/virtio-pci.o tests/libqos/virtio-mmio.o tests/libqos/malloc-generic.o
 
diff --git a/tests/libqos/i2c-e500.c b/tests/libqos/i2c-e500.c
new file mode 100644
index 0000000000..4272ada0a5
--- /dev/null
+++ b/tests/libqos/i2c-e500.c
@@ -0,0 +1,66 @@
+/*
+ * QTest I2C driver
+ *
+ * Copyright (c) 2016 Michael Davidsaver
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "libqos/i2c.h"
+
+
+#include "qemu/bswap.h"
+#include "libqtest.h"
+
+typedef struct E500I2C {
+    I2CAdapter parent;
+
+    uint64_t addr;
+} E500I2C;
+
+static void e500_i2c_send(I2CAdapter *i2c, uint8_t addr,
+                          const uint8_t *buf, uint16_t len)
+{
+    E500I2C *s = (E500I2C *)i2c;
+
+    writeb(s->addr + 0x8, 0xb0); /* Enable and START a write */
+    writeb(s->addr + 0x10, addr & 0xfe); /* Send address for write */
+
+    while (len--) {
+        writeb(s->addr + 0x10, *buf++);
+    }
+
+    writeb(s->addr + 0x8, 0x80); /* STOP but leave enabled */
+}
+
+static void e500_i2c_recv(I2CAdapter *i2c, uint8_t addr,
+                          uint8_t *buf, uint16_t len)
+{
+    E500I2C *s = (E500I2C *)i2c;
+
+    writeb(s->addr + 0x8, 0xa0); /* Enable and START a read */
+    writeb(s->addr + 0x10, addr | 1); /* Send address for read */
+
+    /* reads are "pipelined" so the initial value is junk */
+    readb(s->addr + 0x10);
+
+    while (len--) {
+        *buf++ = readb(s->addr + 0x10);
+    }
+
+    writeb(s->addr + 0x8, 0x80); /* STOP but leave enabled */
+}
+
+I2CAdapter *e500_i2c_create(uint64_t ccsr_base)
+{
+    E500I2C *s = g_malloc0(sizeof(*s));
+    I2CAdapter *i2c = (I2CAdapter *)s;
+
+    s->addr = ccsr_base + 0x3000;
+
+    i2c->send = e500_i2c_send;
+    i2c->recv = e500_i2c_recv;
+
+    return i2c;
+}
diff --git a/tests/libqos/i2c.h b/tests/libqos/i2c.h
index 6e648f922a..40c59a7997 100644
--- a/tests/libqos/i2c.h
+++ b/tests/libqos/i2c.h
@@ -29,4 +29,7 @@ I2CAdapter *omap_i2c_create(uint64_t addr);
 /* libi2c-imx.c */
 I2CAdapter *imx_i2c_create(uint64_t addr);
 
+/* i2c-e500.c */
+I2CAdapter *e500_i2c_create(uint64_t ccsr_base);
+
 #endif
-- 
2.11.0
