Received: from eggs.gnu.org ([2001:4830:134:3::10]:60732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1eXvP6-00078Z-Gj
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 15:49:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1eXvP1-0008SS-Ik
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 15:49:20 -0500
Received: from smtp8.web4u.cz ([81.91.87.88]:58284 helo=mx-8.mail.web4u.cz)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pisa@cmp.felk.cvut.cz>)
	id 1eXvP1-0008RV-7z
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 15:49:15 -0500
From: pisa@cmp.felk.cvut.cz
Date: Sat,  6 Jan 2018 21:47:31 +0100
Message-Id: <241f9905aea63555d18fb54fa033dec96a7a13f8.1515260163.git.pisa@cmp.felk.cvut.cz>
In-Reply-To: <cover.1515260163.git.pisa@cmp.felk.cvut.cz>
References: <cover.1515260163.git.pisa@cmp.felk.cvut.cz>
In-Reply-To: <cover.1515260163.git.pisa@cmp.felk.cvut.cz>
References: <cover.1515260163.git.pisa@cmp.felk.cvut.cz>
Subject: [Qemu-devel] [PATCH 2/7] CAN bus support to connect bust to Linux
 host SocketCAN interface.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Konrad Frederic <frederic.konrad@adacore.com>, Deniz Eren <deniz.eren@icloud.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marek Vasut <marex@denx.de>, Jan Kiszka <jan.kiszka@siemens.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Pavel Pisa <pisa@cmp.felk.cvut.cz>

From: Pavel Pisa <pisa@cmp.felk.cvut.cz>

Connection to the real host CAN bus network through
SocketCAN network interface is available only for Linux
host system. Mechanism is generic, support for another
CAN API and operating systems can be implemented in future.

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
---
 hw/can/Makefile.objs   |   4 +
 hw/can/can_socketcan.c | 294 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 298 insertions(+)
 create mode 100644 hw/can/can_socketcan.c

diff --git a/hw/can/Makefile.objs b/hw/can/Makefile.objs
index 1028d7c455..f999085f7a 100644
--- a/hw/can/Makefile.objs
+++ b/hw/can/Makefile.objs
@@ -2,5 +2,9 @@
 
 ifeq ($(CONFIG_CAN_CORE),y)
 common-obj-y += can_core.o
+ifeq ($(CONFIG_LINUX),y)
+common-obj-y += can_socketcan.o
+else
 common-obj-y += can_host_stub.o
 endif
+endif
diff --git a/hw/can/can_socketcan.c b/hw/can/can_socketcan.c
new file mode 100644
index 0000000000..130c80ba27
--- /dev/null
+++ b/hw/can/can_socketcan.c
@@ -0,0 +1,294 @@
+/*
+ * CAN socketcan support to connect to the Linux host SocketCAN interfaces
+ *
+ * Copyright (c) 2013-2014 Jin Yang
+ * Copyright (c) 2014-2018 Pavel Pisa
+ *
+ * Initial development supported by Google GSoC 2013 from RTEMS project slot
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
+#include "qemu/osdep.h"
+#include "chardev/char.h"
+#include "qemu/sockets.h"
+#include "qemu/error-report.h"
+#include "hw/hw.h"
+#include "can/can_emu.h"
+
+#include <sys/ioctl.h>
+#include <net/if.h>
+#include <linux/can.h>
+#include <linux/can/raw.h>
+
+#ifndef DEBUG_CAN
+#define DEBUG_CAN 0
+#endif /*DEBUG_CAN*/
+
+#define CAN_READ_BUF_LEN  5
+typedef struct {
+    CanBusClientState  bus_client;
+    qemu_can_filter    *rfilter;
+    int                rfilter_num;
+    can_err_mask_t     err_mask;
+
+    qemu_can_frame     buf[CAN_READ_BUF_LEN];
+    int                bufcnt;
+    int                bufptr;
+
+    int                fd;
+} CanBusSocketcanConnectState;
+
+static void can_display_msg(struct qemu_can_frame *msg)
+{
+    int i;
+
+    /* Check that QEMU and Linux kernel flags encoding matches */
+    assert(QEMU_CAN_EFF_FLAG == CAN_EFF_FLAG);
+    assert(QEMU_CAN_RTR_FLAG == CAN_RTR_FLAG);
+    assert(QEMU_CAN_ERR_FLAG == CAN_ERR_FLAG);
+
+    assert(QEMU_CAN_INV_FILTER == CAN_INV_FILTER);
+
+    fprintf(stderr, "%03X [%01d]:", (msg->can_id & 0x1fffffff), msg->can_dlc);
+    for (i = 0; i < msg->can_dlc; i++) {
+        fprintf(stderr, "  %02X", msg->data[i]);
+    }
+    fprintf(stderr, "\n");
+}
+
+static void can_bus_socketcan_read(void *opaque)
+{
+    CanBusSocketcanConnectState *c;
+    c = (CanBusSocketcanConnectState *)opaque;
+
+
+
+    /* CAN_READ_BUF_LEN for multiple messages syscall is possible for future */
+    c->bufcnt = read(c->fd, c->buf, sizeof(qemu_can_frame));
+    if (c->bufcnt < 0) {
+        perror("CAN bus host read");
+        return;
+    }
+
+    can_bus_client_send(&c->bus_client, c->buf, 1);
+
+    if (DEBUG_CAN) {
+        can_display_msg(c->buf); /* Just display the first one. */
+    }
+}
+
+static int can_bus_socketcan_can_receive(CanBusClientState *client)
+{
+    CanBusSocketcanConnectState *c;
+    c = container_of(client, CanBusSocketcanConnectState, bus_client);
+
+    if (c->fd < 0) {
+        return -1;
+    }
+
+    return 1;
+}
+
+static ssize_t can_bus_socketcan_receive(CanBusClientState *client,
+                            const qemu_can_frame *frames, size_t frames_cnt)
+{
+    CanBusSocketcanConnectState *c;
+    c = container_of(client, CanBusSocketcanConnectState, bus_client);
+    size_t len = sizeof(qemu_can_frame);
+    int res;
+
+    if (c->fd < 0) {
+        return -1;
+    }
+
+    res = write(c->fd, frames, len);
+
+    if (!res) {
+        fprintf(stderr, "CAN bus write to host device zero length\n");
+        return -1;
+    }
+
+    /* send frame */
+    if (res != len) {
+        perror("CAN bus write to host device error");
+        return -1;
+    }
+
+    return 1;
+}
+
+static void can_bus_socketcan_cleanup(CanBusClientState *client)
+{
+    CanBusSocketcanConnectState *c;
+    c = container_of(client, CanBusSocketcanConnectState, bus_client);
+
+    if (c->fd >= 0) {
+        qemu_set_fd_handler(c->fd, NULL, NULL, c);
+        close(c->fd);
+        c->fd = -1;
+    }
+
+    c->rfilter_num = 0;
+    if (c->rfilter != NULL) {
+        g_free(c->rfilter);
+    }
+}
+
+static int can_bus_socketcan_set_filters(CanBusClientState *client,
+                   const struct qemu_can_filter *filters, size_t filters_cnt)
+{
+    CanBusSocketcanConnectState *c;
+    c = container_of(client, CanBusSocketcanConnectState, bus_client);
+
+    int i;
+
+    if (filters_cnt > 4) {
+        return -1;
+    }
+
+    if (DEBUG_CAN) {
+        for (i = 0; i < filters_cnt; i++) {
+            fprintf(stderr, "[%i]  id=0x%08x maks=0x%08x\n",
+                   i, filters[i].can_id, filters[i].can_mask);
+        }
+    }
+
+    setsockopt(c->fd, SOL_CAN_RAW, CAN_RAW_FILTER,
+               filters, filters_cnt * sizeof(qemu_can_filter));
+
+    return 0;
+}
+
+static
+void can_bus_socketcan_update_read_handler(CanBusSocketcanConnectState *c)
+{
+    if (c->fd >= 0) {
+        qemu_set_fd_handler(c->fd, can_bus_socketcan_read, NULL, c);
+    }
+}
+
+static CanBusClientInfo can_bus_socketcan_bus_client_info = {
+    .can_receive = can_bus_socketcan_can_receive,
+    .receive = can_bus_socketcan_receive,
+    .cleanup = can_bus_socketcan_cleanup,
+    .poll = NULL
+};
+
+static
+CanBusSocketcanConnectState *can_bus_socketcan_connect_new(const char *host_dev_name)
+{
+    int s; /* can raw socket */
+    CanBusSocketcanConnectState    *c;
+    struct sockaddr_can addr;
+    struct ifreq ifr;
+
+    c = g_malloc0(sizeof(CanBusSocketcanConnectState));
+    if (c == NULL) {
+        goto fail1;
+    }
+
+    c->fd = -1;
+
+    /* open socket */
+    s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
+    if (s < 0) {
+        perror("socket");
+        goto fail;
+    }
+
+    addr.can_family = AF_CAN;
+    memset(&ifr.ifr_name, 0, sizeof(ifr.ifr_name));
+    strcpy(ifr.ifr_name, host_dev_name);
+    if (ioctl(s, SIOCGIFINDEX, &ifr) < 0) {
+        perror("SIOCGIFINDEX");
+        goto fail;
+    }
+    addr.can_ifindex = ifr.ifr_ifindex;
+
+    c->err_mask = 0xffffffff; /* Receive error frame. */
+    setsockopt(s, SOL_CAN_RAW, CAN_RAW_ERR_FILTER,
+                   &c->err_mask, sizeof(c->err_mask));
+
+    c->rfilter_num = 1;
+    c->rfilter = g_malloc0(c->rfilter_num * sizeof(struct qemu_can_filter));
+    if (c->rfilter == NULL) {
+        goto fail;
+    }
+
+    /* Receive all data frame. If |= CAN_INV_FILTER no data. */
+    c->rfilter[0].can_id = 0;
+    c->rfilter[0].can_mask = 0;
+    c->rfilter[0].can_mask &= ~CAN_ERR_FLAG;
+
+    setsockopt(s, SOL_CAN_RAW, CAN_RAW_FILTER, c->rfilter,
+               c->rfilter_num * sizeof(struct qemu_can_filter));
+
+    if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
+        perror("bind");
+        goto fail;
+    }
+
+    c->fd = s;
+
+    c->bus_client.info = &can_bus_socketcan_bus_client_info;
+
+    can_bus_socketcan_update_read_handler(c);
+
+    return c;
+
+fail:
+    can_bus_socketcan_cleanup(&c->bus_client);
+    g_free(c);
+fail1:
+
+    return NULL;
+}
+
+static
+int can_bus_connect_to_host_socketcan(CanBusState *bus, const char *host_dev_name)
+{
+    CanBusSocketcanConnectState *c;
+
+    c = can_bus_socketcan_connect_new(host_dev_name);
+    if (c == NULL) {
+        error_report("CAN bus setup of host connect to \"%s\" failed",
+                      host_dev_name);
+        exit(1);
+    }
+
+    if (can_bus_insert_client(bus, &c->bus_client) < 0) {
+        error_report("CAN host device \"%s\" connect to bus \"%s\" failed",
+                      host_dev_name, bus->name);
+        exit(1);
+    }
+
+    if (0) {
+        /*
+         * Not used there or as a CanBusSocketcanConnectState method
+         * for now but included there for documentation purposes
+         * and to suppress warning.
+         */
+        can_bus_socketcan_set_filters(&c->bus_client, NULL, 0);
+    }
+
+    return 0;
+}
+
+int (*can_bus_connect_to_host_variant)(CanBusState *bus, const char *name) =
+        can_bus_connect_to_host_socketcan;
-- 
2.11.0
