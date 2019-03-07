Received: from eggs.gnu.org ([209.51.188.92]:59615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLS-0001pG-Nq
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLR-0004tH-Cr
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:34 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nLR-0004sw-2x
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:33 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:21:26 -0800
Message-Id: <20190307072126.8520-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 10/37] multi-process: setup a
 machine object for remote device process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org, pbonzini@redhat.com, rth@twiddle.net

From: Jagannathan Raman <jag.raman@oracle.com>

remote-machine object sets up various subsystems of the remote device
process. Instantiate PCI host bridge object and initialize RAM, IO &
PCI memory regions.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 exec.c                        |   3 +-
 include/exec/address-spaces.h |   2 +
 include/remote/machine.h      |  46 ++++++++++++++++
 remote/Makefile.objs          |   1 +
 remote/machine.c              | 118 ++++++++++++++++++++++++++++++++++++++++++
 remote/remote-main.c          |   7 +++
 6 files changed, 175 insertions(+), 2 deletions(-)
 create mode 100644 include/remote/machine.h
 create mode 100644 remote/machine.c

diff --git a/exec.c b/exec.c
index dcef041..4b7b3bc 100644
--- a/exec.c
+++ b/exec.c
@@ -193,7 +193,6 @@ typedef struct subpage_t {
 #define PHYS_SECTION_WATCH 3
 
 static void io_mem_init(void);
-static void memory_map_init(void);
 static void tcg_commit(MemoryListener *listener);
 
 static MemoryRegion io_mem_watch;
@@ -3090,7 +3089,7 @@ static void tcg_commit(MemoryListener *listener)
     tlb_flush(cpuas->cpu);
 }
 
-static void memory_map_init(void)
+void memory_map_init(void)
 {
     system_memory = g_malloc(sizeof(*system_memory));
 
diff --git a/include/exec/address-spaces.h b/include/exec/address-spaces.h
index db8bfa9..56a877b 100644
--- a/include/exec/address-spaces.h
+++ b/include/exec/address-spaces.h
@@ -33,6 +33,8 @@ MemoryRegion *get_system_memory(void);
  */
 MemoryRegion *get_system_io(void);
 
+void memory_map_init(void);
+
 extern AddressSpace address_space_memory;
 extern AddressSpace address_space_io;
 
diff --git a/include/remote/machine.h b/include/remote/machine.h
new file mode 100644
index 0000000..fe1e11b
--- /dev/null
+++ b/include/remote/machine.h
@@ -0,0 +1,46 @@
+/*
+ * Remote machine configuration
+ *
+ * Copyright 2019, Oracle and/or its affiliates. All rights reserved.
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
+#ifndef REMOTE_MACHINE_H
+#define REMOTE_MACHINE_H
+
+#include "qemu/osdep.h"
+#include "qom/object.h"
+#include "hw/boards.h"
+#include "remote/pcihost.h"
+#include "qemu/notify.h"
+
+typedef struct RemMachineState {
+    MachineState parent_obj;
+
+    RemPCIHost *host;
+} RemMachineState;
+
+#define TYPE_REMOTE_MACHINE "remote-machine"
+#define REMOTE_MACHINE(obj) \
+    OBJECT_CHECK(RemMachineState, (obj), TYPE_REMOTE_MACHINE)
+
+void qemu_run_machine_init_done_notifiers(void);
+
+#endif
diff --git a/remote/Makefile.objs b/remote/Makefile.objs
index 2757f5a..13d4c48 100644
--- a/remote/Makefile.objs
+++ b/remote/Makefile.objs
@@ -1,2 +1,3 @@
 remote-pci-obj-$(CONFIG_MPQEMU) += remote-main.o
 remote-pci-obj-$(CONFIG_MPQEMU) += pcihost.o
+remote-pci-obj-$(CONFIG_MPQEMU) += machine.o
diff --git a/remote/machine.c b/remote/machine.c
new file mode 100644
index 0000000..7001789
--- /dev/null
+++ b/remote/machine.c
@@ -0,0 +1,118 @@
+/*
+ * Machine for remote device
+ *
+ * Copyright 2019, Oracle and/or its affiliates. All rights reserved.
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
+#include <stdint.h>
+#include <sys/types.h>
+
+#include "qemu/osdep.h"
+#include "remote/pcihost.h"
+#include "remote/machine.h"
+#include "exec/address-spaces.h"
+#include "exec/memory.h"
+#include "exec/ioport.h"
+#include "exec/ramlist.h"
+#include "qemu/thread.h"
+#include "qom/object.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "qemu/main-loop.h"
+#include "qemu-common.h"
+#include "sysemu/sysemu.h"
+#include "qemu/notify.h"
+
+static NotifierList machine_init_done_notifiers =
+    NOTIFIER_LIST_INITIALIZER(machine_init_done_notifiers);
+
+bool machine_init_done;
+
+void qemu_add_machine_init_done_notifier(Notifier *notify)
+{
+    notifier_list_add(&machine_init_done_notifiers, notify);
+    if (machine_init_done) {
+        notify->notify(notify, NULL);
+    }
+}
+
+void qemu_remove_machine_init_done_notifier(Notifier *notify)
+{
+    notifier_remove(notify);
+}
+
+void qemu_run_machine_init_done_notifiers(void)
+{
+    machine_init_done = true;
+    notifier_list_notify(&machine_init_done_notifiers, NULL);
+}
+
+static void remote_machine_init(Object *obj)
+{
+    RemMachineState *s = REMOTE_MACHINE(obj);
+    RemPCIHost *rem_host;
+    MemoryRegion *system_memory, *system_io, *pci_memory;
+
+    Error *error_abort = NULL;
+
+    qemu_mutex_init(&ram_list.mutex);
+
+    object_property_add_child(object_get_root(), "machine", obj, &error_abort);
+    if (error_abort) {
+        error_report_err(error_abort);
+    }
+
+    memory_map_init();
+
+    system_memory = get_system_memory();
+    system_io = get_system_io();
+
+    pci_memory = g_new(MemoryRegion, 1);
+    memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
+
+    rem_host = REMOTE_HOST_DEVICE(qdev_create(NULL, TYPE_REMOTE_HOST_DEVICE));
+
+    rem_host->mr_pci_mem = pci_memory;
+    rem_host->mr_sys_mem = system_memory;
+    rem_host->mr_sys_io = system_io;
+
+    s->host = rem_host;
+
+    qemu_mutex_lock_iothread();
+    memory_region_add_subregion_overlap(system_memory, 0x0, pci_memory, -1);
+    qemu_mutex_unlock_iothread();
+
+    qdev_init_nofail(DEVICE(rem_host));
+}
+
+static const TypeInfo remote_machine = {
+    .name = TYPE_REMOTE_MACHINE,
+    .parent = TYPE_MACHINE,
+    .instance_size = sizeof(RemMachineState),
+    .instance_init = remote_machine_init,
+};
+
+static void remote_machine_register_types(void)
+{
+    type_register_static(&remote_machine);
+}
+
+type_init(remote_machine_register_types);
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 53c2aa5..d5304fb 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -26,10 +26,17 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
+#include "remote/pcihost.h"
+#include "remote/machine.h"
+#include "hw/boards.h"
+#include "hw/qdev-core.h"
+#include "qemu/main-loop.h"
 
 int main(int argc, char *argv[])
 {
     module_call_init(MODULE_INIT_QOM);
 
+    current_machine = MACHINE(REMOTE_MACHINE(object_new(TYPE_REMOTE_MACHINE)));
+
     return 0;
 }
-- 
1.8.3.1
