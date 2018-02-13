Received: from eggs.gnu.org ([2001:4830:134:3::10]:41630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHG-00041l-W8
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHA-0007WR-UE
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:39 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:33441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZHA-0007Vw-J3
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:32 -0500
Received: by mail-wm0-x22f.google.com with SMTP id x4so12961957wmc.0
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:01:32 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:08 +0100
Message-Id: <1518523252-49106-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 04/48] net/can: simple messages transport
 implementation for QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>

From: Pavel Pisa <pisa@cmp.felk.cvut.cz>

The CanBusState state structure is created for each
emulated CAN channel. Individual clients/emulated
CAN interfaces or host interface connection registers
to the bus by CanBusClientState structure.

The CAN core is prepared to support connection to the
real host CAN bus network. The commit with such support
for Linux SocketCAN follows.

Implementation is as simple as possible.  There is no state to be
migrated, and messages prioritization and queuing are not considered
for now.  But it is intended to be extended when need arises.

Development repository and more documentation at

https://gitlab.fel.cvut.cz/canbus/qemu-canbus

The work is based on Jin Yang GSoC 2013 work funded
by Google and mentored in frame of RTEMS project GSoC
slot donated to QEMU.

Rewritten for QEMU-2.0+ versions and architecture cleanup
by Pavel Pisa (Czech Technical University in Prague).

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/pci.mak |   1 +
 hw/Makefile.objs        |   1 +
 include/net/can_emu.h   | 123 ++++++++++++++++++++++++++++++++++++++++++
 include/net/can_host.h  |  55 +++++++++++++++++++
 net/Makefile.objs       |   2 +
 net/can/Makefile.objs   |   1 +
 net/can/can_core.c      | 138 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/can/can_host.c      | 112 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 433 insertions(+)
 create mode 100644 include/net/can_emu.h
 create mode 100644 include/net/can_host.h
 create mode 100644 net/can/Makefile.objs
 create mode 100644 net/can/can_core.c
 create mode 100644 net/can/can_host.c

diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index 49a0f28..b87ae26 100644
--- a/default-configs/pci.mak
+++ b/default-configs/pci.mak
@@ -31,6 +31,7 @@ CONFIG_ESP_PCI=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
 CONFIG_SERIAL_PCI=y
+CONFIG_CAN_BUS=y
 CONFIG_IPACK=y
 CONFIG_WDT_IB6300ESB=y
 CONFIG_PCI_TESTDEV=y
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index cf4cb20..9d84b8f 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -6,6 +6,7 @@ devices-dirs-$(CONFIG_SOFTMMU) += block/
 devices-dirs-$(CONFIG_SOFTMMU) += bt/
 devices-dirs-$(CONFIG_SOFTMMU) += char/
 devices-dirs-$(CONFIG_SOFTMMU) += cpu/
+devices-dirs-$(CONFIG_SOFTMMU) += can/
 devices-dirs-$(CONFIG_SOFTMMU) += display/
 devices-dirs-$(CONFIG_SOFTMMU) += dma/
 devices-dirs-$(CONFIG_SOFTMMU) += gpio/
diff --git a/include/net/can_emu.h b/include/net/can_emu.h
new file mode 100644
index 0000000..1da4d01
--- /dev/null
+++ b/include/net/can_emu.h
@@ -0,0 +1,123 @@
+/*
+ * CAN common CAN bus emulation support
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
+
+#ifndef NET_CAN_EMU_H
+#define NET_CAN_EMU_H
+
+#include "qom/object.h"
+
+/* NOTE: the following two structures is copied from <linux/can.h>. */
+
+/*
+ * Controller Area Network Identifier structure
+ *
+ * bit 0-28    : CAN identifier (11/29 bit)
+ * bit 29      : error frame flag (0 = data frame, 1 = error frame)
+ * bit 30      : remote transmission request flag (1 = rtr frame)
+ * bit 31      : frame format flag (0 = standard 11 bit, 1 = extended 29 bit)
+ */
+typedef uint32_t qemu_canid_t;
+
+typedef struct qemu_can_frame {
+    qemu_canid_t    can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
+    uint8_t         can_dlc; /* data length code: 0 .. 8 */
+    uint8_t         data[8] QEMU_ALIGNED(8);
+} qemu_can_frame;
+
+/* Keep defines for QEMU separate from Linux ones for now */
+
+#define QEMU_CAN_EFF_FLAG 0x80000000U /* EFF/SFF is set in the MSB */
+#define QEMU_CAN_RTR_FLAG 0x40000000U /* remote transmission request */
+#define QEMU_CAN_ERR_FLAG 0x20000000U /* error message frame */
+
+#define QEMU_CAN_SFF_MASK 0x000007FFU /* standard frame format (SFF) */
+#define QEMU_CAN_EFF_MASK 0x1FFFFFFFU /* extended frame format (EFF) */
+
+/**
+ * struct qemu_can_filter - CAN ID based filter in can_register().
+ * @can_id:   relevant bits of CAN ID which are not masked out.
+ * @can_mask: CAN mask (see description)
+ *
+ * Description:
+ * A filter matches, when
+ *
+ *          <received_can_id> & mask == can_id & mask
+ *
+ * The filter can be inverted (QEMU_CAN_INV_FILTER bit set in can_id) or it can
+ * filter for error message frames (QEMU_CAN_ERR_FLAG bit set in mask).
+ */
+typedef struct qemu_can_filter {
+    qemu_canid_t    can_id;
+    qemu_canid_t    can_mask;
+} qemu_can_filter;
+
+/* QEMU_CAN_INV_FILTER can be set in qemu_can_filter.can_id */
+#define QEMU_CAN_INV_FILTER 0x20000000U
+
+typedef struct CanBusClientState CanBusClientState;
+typedef struct CanBusState CanBusState;
+
+typedef struct CanBusClientInfo {
+    int (*can_receive)(CanBusClientState *);
+    ssize_t (*receive)(CanBusClientState *,
+        const struct qemu_can_frame *frames, size_t frames_cnt);
+} CanBusClientInfo;
+
+struct CanBusClientState {
+    CanBusClientInfo *info;
+    CanBusState *bus;
+    int link_down;
+    QTAILQ_ENTRY(CanBusClientState) next;
+    CanBusClientState *peer;
+    char *model;
+    char *name;
+    void (*destructor)(CanBusClientState *);
+};
+
+#define TYPE_CAN_BUS "can-bus"
+#define CAN_BUS_CLASS(klass) \
+     OBJECT_CLASS_CHECK(CanBusClass, (klass), TYPE_CAN_BUS)
+#define CAN_BUS_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(CanBusClass, (obj), TYPE_CAN_BUS)
+#define CAN_BUS(obj) \
+     OBJECT_CHECK(CanBusState, (obj), TYPE_CAN_BUS)
+
+int can_bus_filter_match(struct qemu_can_filter *filter, qemu_canid_t can_id);
+
+int can_bus_insert_client(CanBusState *bus, CanBusClientState *client);
+
+int can_bus_remove_client(CanBusClientState *client);
+
+ssize_t can_bus_client_send(CanBusClientState *,
+                            const struct qemu_can_frame *frames,
+                            size_t frames_cnt);
+
+int can_bus_client_set_filters(CanBusClientState *,
+                               const struct qemu_can_filter *filters,
+                               size_t filters_cnt);
+
+#endif
diff --git a/include/net/can_host.h b/include/net/can_host.h
new file mode 100644
index 0000000..d796767
--- /dev/null
+++ b/include/net/can_host.h
@@ -0,0 +1,55 @@
+/*
+ * CAN common CAN bus emulation support
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
+
+#ifndef NET_CAN_HOST_H
+#define NET_CAN_HOST_H
+
+#include "net/can_emu.h"
+
+#define TYPE_CAN_HOST "can-host"
+#define CAN_HOST_CLASS(klass) \
+     OBJECT_CLASS_CHECK(CanHostClass, (klass), TYPE_CAN_HOST)
+#define CAN_HOST_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(CanHostClass, (obj), TYPE_CAN_HOST)
+#define CAN_HOST(obj) \
+     OBJECT_CHECK(CanHostState, (obj), TYPE_CAN_HOST)
+
+typedef struct CanHostState {
+    ObjectClass oc;
+
+    CanBusState *bus;
+    CanBusClientState bus_client;
+} CanHostState;
+
+typedef struct CanHostClass {
+    ObjectClass oc;
+
+    void (*connect)(CanHostState *ch, Error **errp);
+    void (*disconnect)(CanHostState *ch);
+} CanHostClass;
+
+#endif
diff --git a/net/Makefile.objs b/net/Makefile.objs
index 64adf32..b2bf88a 100644
--- a/net/Makefile.objs
+++ b/net/Makefile.objs
@@ -23,3 +23,5 @@ common-obj-$(CONFIG_POSIX) += tap.o $(tap-obj-y)
 common-obj-$(CONFIG_WIN32) += tap-win32.o
 
 vde.o-libs = $(VDE_LIBS)
+
+common-obj-$(CONFIG_CAN_BUS) += can/
diff --git a/net/can/Makefile.objs b/net/can/Makefile.objs
new file mode 100644
index 0000000..ef97fdb
--- /dev/null
+++ b/net/can/Makefile.objs
@@ -0,0 +1 @@
+common-obj-y += can_core.o can_host.o
diff --git a/net/can/can_core.c b/net/can/can_core.c
new file mode 100644
index 0000000..2a83cad
--- /dev/null
+++ b/net/can/can_core.c
@@ -0,0 +1,138 @@
+/*
+ * CAN common CAN bus emulation support
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
+#include "qapi/error.h"
+#include "net/can_emu.h"
+#include "qom/object_interfaces.h"
+
+struct CanBusState {
+    Object object;
+
+    QTAILQ_HEAD(, CanBusClientState) clients;
+};
+
+static void can_bus_instance_init(Object *object)
+{
+    CanBusState *bus = (CanBusState *)object;
+
+    QTAILQ_INIT(&bus->clients);
+}
+
+int can_bus_insert_client(CanBusState *bus, CanBusClientState *client)
+{
+    client->bus = bus;
+    QTAILQ_INSERT_TAIL(&bus->clients, client, next);
+    return 0;
+}
+
+int can_bus_remove_client(CanBusClientState *client)
+{
+    CanBusState *bus = client->bus;
+    if (bus == NULL) {
+        return 0;
+    }
+
+    QTAILQ_REMOVE(&bus->clients, client, next);
+    client->bus = NULL;
+    return 1;
+}
+
+ssize_t can_bus_client_send(CanBusClientState *client,
+             const struct qemu_can_frame *frames, size_t frames_cnt)
+{
+    int ret = 0;
+    CanBusState *bus = client->bus;
+    CanBusClientState *peer;
+    if (bus == NULL) {
+        return -1;
+    }
+
+    QTAILQ_FOREACH(peer, &bus->clients, next) {
+        if (peer->info->can_receive(peer)) {
+            if (peer == client) {
+                /* No loopback support for now */
+                continue;
+            }
+            if (peer->info->receive(peer, frames, frames_cnt) > 0) {
+                ret = 1;
+            }
+        }
+    }
+
+    return ret;
+}
+
+int can_bus_filter_match(struct qemu_can_filter *filter, qemu_canid_t can_id)
+{
+    int m;
+    if (((can_id | filter->can_mask) & QEMU_CAN_ERR_FLAG)) {
+        return (filter->can_mask & QEMU_CAN_ERR_FLAG) != 0;
+    }
+    m = (can_id & filter->can_mask) == (filter->can_id & filter->can_mask);
+    return filter->can_id & QEMU_CAN_INV_FILTER ? !m : m;
+}
+
+int can_bus_client_set_filters(CanBusClientState *client,
+             const struct qemu_can_filter *filters, size_t filters_cnt)
+{
+    return 0;
+}
+
+
+static bool can_bus_can_be_deleted(UserCreatable *uc)
+{
+    return false;
+}
+
+static void can_bus_class_init(ObjectClass *klass,
+                                void *class_data G_GNUC_UNUSED)
+{
+    UserCreatableClass *uc_klass = USER_CREATABLE_CLASS(klass);
+
+    uc_klass->can_be_deleted = can_bus_can_be_deleted;
+}
+
+static const TypeInfo can_bus_info = {
+    .parent = TYPE_OBJECT,
+    .name = TYPE_CAN_BUS,
+    .instance_size = sizeof(CanBusState),
+    .instance_init = can_bus_instance_init,
+    .class_init = can_bus_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+static void can_bus_register_types(void)
+{
+    type_register_static(&can_bus_info);
+}
+
+type_init(can_bus_register_types);
diff --git a/net/can/can_host.c b/net/can/can_host.c
new file mode 100644
index 0000000..c3d2652
--- /dev/null
+++ b/net/can/can_host.c
@@ -0,0 +1,112 @@
+/*
+ * CAN generic CAN host connection support
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
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+#include "net/can_emu.h"
+#include "net/can_host.h"
+
+struct CanBusState {
+    Object object;
+
+    QTAILQ_HEAD(, CanBusClientState) clients;
+};
+
+static void can_host_disconnect(CanHostState *ch)
+{
+    CanHostClass *chc = CAN_HOST_GET_CLASS(ch);
+
+    can_bus_remove_client(&ch->bus_client);
+    chc->disconnect(ch);
+}
+
+static void can_host_connect(CanHostState *ch, Error **errp)
+{
+    CanHostClass *chc = CAN_HOST_GET_CLASS(ch);
+    Error *local_err = NULL;
+
+    chc->connect(ch, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    can_bus_insert_client(ch->bus, &ch->bus_client);
+}
+
+static void can_host_unparent(Object *obj)
+{
+    can_host_disconnect(CAN_HOST(obj));
+}
+
+static void can_host_complete(UserCreatable *uc, Error **errp)
+{
+    can_host_connect(CAN_HOST(uc), errp);
+}
+
+static void can_host_instance_init(Object *obj)
+{
+    CanHostState *ch = CAN_HOST(obj);
+
+    object_property_add_link(obj, "canbus", TYPE_CAN_BUS,
+                             (Object **)&ch->bus,
+                             object_property_allow_set_link,
+                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
+                             &error_abort);
+}
+
+static void can_host_class_init(ObjectClass *klass,
+                                void *class_data G_GNUC_UNUSED)
+{
+    UserCreatableClass *uc_klass = USER_CREATABLE_CLASS(klass);
+
+    klass->unparent = can_host_unparent;
+    uc_klass->complete = can_host_complete;
+}
+
+static const TypeInfo can_host_info = {
+    .parent = TYPE_OBJECT,
+    .name = TYPE_CAN_HOST,
+    .instance_size = sizeof(CanHostState),
+    .class_size = sizeof(CanHostClass),
+    .abstract = true,
+    .instance_init = can_host_instance_init,
+    .class_init = can_host_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+static void can_host_register_types(void)
+{
+    type_register_static(&can_host_info);
+}
+
+type_init(can_host_register_types);
-- 
1.8.3.1
