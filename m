Received: from eggs.gnu.org ([2001:4830:134:3::10]:46246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1evq8c-0007Nr-U9
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1evq8Z-0001lC-Kl
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:03:10 -0400
Received: from sauhun.de ([88.99.104.3]:57899 helo=pokefinder.org)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa+renesas@sang-engineering.com>)
	id 1evq8Z-0001kF-AQ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:03:07 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Tue, 13 Mar 2018 21:02:45 +0100
Message-Id: <20180313200245.2350-1-wsa+renesas@sang-engineering.com>
Subject: [Qemu-devel] [RFC PATCH] i2c: device passthrough HACK(!) &
 evaluation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

I was asked to investigate I2C device passthrough possibilities for QEMU
on Linux. The idea was to expose only a single device, not the whole
bus. There was no specific use case explained, so some decisions are
still to be made. E.g. I think the host-device should get its own
virtualized bus later, but I can't really tell yet.

This is my first contact with QEMU, so the patch is more like getting my
feet wet. I wouldn't even call it a proof-of-concept. However, while
working on this (which gets at least something done), I already gained
experiences which I would like to share here:

Full virtualization
-------------------

Would be nice to have because it would work with all virtual I2C
adapters instantly, however there come problems with it. For that to
work, we would need to be able to transmit the QEMU I2C primitives from
userspace to the kernel. There is currently no such interface for that.
As of today, there is only the i2c-dev interface which allows to send
a complete transfer (which may consist of multiple, combined messages)
or SMBus commands. There is no way to send more primitive commands like
"send {start|stop|acknowledge}-bit". Even if there was, most hardware I
know of wouldn't work well with this. We often need a-priori knowledge
like length of the message to program the controller. Such information
is not available when working with such primitives. On top of that, that
approach would cause quite some overhead, so performance regressions for
drivers which use other devices on the same bus are likely.

virtio?
-------

>From what I understood so far, virtio could help here. Yes, we would
need separate drivers, yet data transfer could be super simple. If we
had a simple virtio-PCI I2C master device, it could have a really simple
kernel driver. It basically takes the I2C transfer it gets, does some
sanity checking so no other devices are accessed, and then passes it
to the kernel. I have not fully understood yet, if the virtio
transportation mechanism is better/required here, or if we can/should
still use the existing i2c-dev character interface.

Other problems found
--------------------

Here is a list of other problems I discovered which need addressing in
one way or the other:

* exclusive access to I2C devices

We currently don't have a way to mark devices as being "in use, don't
touch" from userspace. This could be added but we need to decide on the
transportation layer first (i2c-dev vs. virtio).

* no generic I2C master (at least for x86)

Unless I overlooked something, we currently can't simply add a new I2C
bus on x86 because there is no virtual hardware encoded just doing that.
I found patches for a USB-to-I2C bridge floating around. USB is nicely
generic, so probably worth evaluating those again if this task is to be
continued.

* re-definition of I2C_SLAVE

QEMU defines I2C_SLAVE as well as <linux/i2c-dev.h>. So, if that
interface is going to be used, we need something to fix this.

* likely improvements to the QEMU I2C core

>From visual review, I am quite sure QEMU I2C core does not support
'repeated start' with the following message having a different I2C
destination address than the previous one. This is legal, but up to
now very rarely seen in practice. However, with devices becoming more
complex and those devices maybe being passed-through as well, more
improvements to the QEMU I2C core might be needed as well.

Conclusion
----------

These are my finding regarding I2C device passthrough with QEMU. The
below patch is a very first step in the "full virtualization" direction
because it transports every read byte access directly to the host
(totally missing proper I2C start/stop/ack generation). Write byte
access is discarded here for security reasons. As described above, I
would not recommend this approach any further. My staring point now
would be a simplified virtio or virtio-alike device where the transfer
is passed-through as such to the host, and not split up into primitives.
So the patch itself is somehow already obsolete, but it served well for
gaining experience.

For the record, the description of my test procedure is here:
    https://elinux.org/R-Car/I2C-Virtualization

I will still be around for further discussion. I can't really tell,
though, if there will be a follow-up task for me to continue this.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 hw/i2c/Makefile.objs |   2 +-
 hw/i2c/host-i2cdev.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100644 hw/i2c/host-i2cdev.c

diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
index 37cacde978..d0cc08dd10 100644
--- a/hw/i2c/Makefile.objs
+++ b/hw/i2c/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-$(CONFIG_I2C) += core.o smbus.o smbus_eeprom.o
+common-obj-$(CONFIG_I2C) += core.o smbus.o smbus_eeprom.o host-i2cdev.o
 common-obj-$(CONFIG_DDC) += i2c-ddc.o
 common-obj-$(CONFIG_VERSATILE_I2C) += versatile_i2c.o
 common-obj-$(CONFIG_ACPI_X86) += smbus_ich9.o
diff --git a/hw/i2c/host-i2cdev.c b/hw/i2c/host-i2cdev.c
new file mode 100644
index 0000000000..a7f2d549f1
--- /dev/null
+++ b/hw/i2c/host-i2cdev.c
@@ -0,0 +1,110 @@
+/*
+ * I2C device passthrough HACK
+ *
+ * Copyright (c) 2018 Wolfram Sang, Sang Engineering, Renesas Electronics
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the LICENSE file in the top-level directory.
+ *
+ * Example to use:
+ *     -device host-i2cdev,address=0x64,file=/dev/i2c-0,hostaddr=0x50
+ */
+
+#include <sys/ioctl.h>
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/hw.h"
+#include "hw/i2c/i2c.h"
+
+/* Ugh, problem! QEMU defines I2C_SLAVE, too */
+#undef I2C_SLAVE
+#include <linux/i2c.h>
+#include <linux/i2c-dev.h>
+
+#define ERR(FMT, ...) fprintf(stderr, TYPE_HOST_I2CDEV " : " FMT, \
+                            ## __VA_ARGS__)
+
+#define TYPE_HOST_I2CDEV "host-i2cdev"
+#define HOST_I2CDEV(obj) OBJECT_CHECK(HostI2CDevState, (obj), TYPE_HOST_I2CDEV)
+
+typedef struct HostI2CDevState {
+    I2CSlave parent_obj;
+    char *file;
+    int fd;
+    uint32_t hostaddr;
+} HostI2CDevState;
+
+static int host_i2cdev_recv(I2CSlave *s)
+{
+    HostI2CDevState *i2cdev = HOST_I2CDEV(s);
+    union i2c_smbus_data data;
+    struct i2c_smbus_ioctl_data args = {
+        .read_write = I2C_SMBUS_READ,
+        .size = I2C_SMBUS_BYTE,
+        .data = &data,
+    };
+    int err;
+
+    err = ioctl(i2cdev->fd, I2C_SMBUS, &args);
+
+    return err == 0 ? data.byte : 0;
+}
+
+static int host_i2cdev_send(I2CSlave *s, uint8_t data)
+{
+    /* We don't support writes */
+    return -1;
+}
+
+static int host_i2cdev_init(I2CSlave *i2c)
+{
+    HostI2CDevState *i2cdev = HOST_I2CDEV(i2c);
+
+    if (!i2cdev->file) {
+        ERR("file is required!\n");
+        exit(1);
+    }
+
+    i2cdev->fd = qemu_open(i2cdev->file, O_RDWR);
+
+    if (i2cdev->fd < 0) {
+        ERR("file can't be opened!\n");
+        exit(1);
+    }
+
+    return ioctl(i2cdev->fd, I2C_SLAVE, i2cdev->hostaddr ?: i2c->address);
+}
+
+static Property host_i2cdev_props[] = {
+    DEFINE_PROP_STRING("file", HostI2CDevState, file),
+    DEFINE_PROP_UINT32("hostaddr", HostI2CDevState, hostaddr, 0),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static void host_i2cdev_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+
+    k->init = &host_i2cdev_init;
+    k->recv = &host_i2cdev_recv;
+    k->send = &host_i2cdev_send;
+
+    dc->props = host_i2cdev_props;
+}
+
+static
+const TypeInfo host_i2cdev_type = {
+    .name = TYPE_HOST_I2CDEV,
+    .parent = TYPE_I2C_SLAVE,
+    .instance_size = sizeof(HostI2CDevState),
+    .class_size = sizeof(I2CSlaveClass),
+    .class_init = host_i2cdev_class_init,
+};
+
+static void host_i2cdev_register(void)
+{
+    type_register_static(&host_i2cdev_type);
+}
+
+type_init(host_i2cdev_register)
-- 
2.11.0
