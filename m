Received: from eggs.gnu.org ([2001:4830:134:3::10]:60830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1gB7Ax-0008C5-P5
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 19:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1gB7Aq-0006Ue-7c
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 19:48:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jag.raman@oracle.com>)
	id 1gB7Ao-0006Rg-2Z
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 19:48:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	w9CNj5JO088748
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:47 GMT
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by userp2120.oracle.com with ESMTP id 2mxnprndsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:47 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9CNmkWt009571
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:46 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9CNmk6Q008253
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:46 GMT
From: Jagannathan Raman <jag.raman@oracle.com>
Date: Fri, 12 Oct 2018 19:48:31 -0400
Message-Id: <eff441b81a414e9aa567e2cda574345125f25cca.1539387238.git.jag.raman@oracle.com>
In-Reply-To: <cover.1539387238.git.jag.raman@oracle.com>
References: <cover.1539387238.git.jag.raman@oracle.com>
In-Reply-To: <cover.1539387238.git.jag.raman@oracle.com>
References: <cover.1539387238.git.jag.raman@oracle.com>
Subject: [Qemu-devel] [RFC PATCH v1 4/8] multi-process QEMU: setup a machine
 for remote device process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: john.g.johnson@oracle.com, Kanth.Ghatraju@oracle.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com

- remote-machine object sets up various subsystems of the remote device
  process.
- PCI host bridge is instantiated
- RAM, IO & PCI memory regions are initialized

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 exec.c                        |  3 +-
 hw/scsi/qemu-scsi-dev.c       |  9 +++++
 include/exec/address-spaces.h |  2 ++
 include/remote/machine.h      | 43 ++++++++++++++++++++++++
 remote/Makefile.objs          |  1 +
 remote/machine.c              | 78 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 134 insertions(+), 2 deletions(-)
 create mode 100644 include/remote/machine.h
 create mode 100644 remote/machine.c

diff --git a/exec.c b/exec.c
index d0821e6..7dafc0b 100644
--- a/exec.c
+++ b/exec.c
@@ -192,7 +192,6 @@ typedef struct subpage_t {
 #define PHYS_SECTION_WATCH 3
 
 static void io_mem_init(void);
-static void memory_map_init(void);
 static void tcg_commit(MemoryListener *listener);
 
 static MemoryRegion io_mem_watch;
@@ -3070,7 +3069,7 @@ static void tcg_commit(MemoryListener *listener)
     tlb_flush(cpuas->cpu);
 }
 
-static void memory_map_init(void)
+void memory_map_init(void)
 {
     system_memory = g_malloc(sizeof(*system_memory));
 
diff --git a/hw/scsi/qemu-scsi-dev.c b/hw/scsi/qemu-scsi-dev.c
index 3cb8698..21aba91 100644
--- a/hw/scsi/qemu-scsi-dev.c
+++ b/hw/scsi/qemu-scsi-dev.c
@@ -26,10 +26,19 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
+#include "remote/pcihost.h"
+#include "remote/machine.h"
+#include "hw/boards.h"
+
+static RemMachineState *machine;
 
 int main(int argc, char *argv[])
 {
     module_call_init(MODULE_INIT_QOM);
 
+    machine = REMOTE_MACHINE(object_new(TYPE_REMOTE_MACHINE));
+
+    current_machine = MACHINE(machine);
+
     return 0;
 }
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
index 0000000..92f9793
--- /dev/null
+++ b/include/remote/machine.h
@@ -0,0 +1,43 @@
+/*
+ * Remote machine configuration
+ *
+ * Copyright 2018, Oracle and/or its affiliates. All rights reserved.
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
+#endif
diff --git a/remote/Makefile.objs b/remote/Makefile.objs
index 3072f95..e90ae20 100644
--- a/remote/Makefile.objs
+++ b/remote/Makefile.objs
@@ -1 +1,2 @@
 remote-obj-y += pcihost.o
+remote-obj-y += machine.o
diff --git a/remote/machine.c b/remote/machine.c
new file mode 100644
index 0000000..9aea0ba
--- /dev/null
+++ b/remote/machine.c
@@ -0,0 +1,78 @@
+/*
+ * Machine for remote device
+ *
+ * Copyright 2018, Oracle and/or its affiliates. All rights reserved.
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
+
+static void remote_machine_init(Object *obj)
+{
+    RemMachineState *s = REMOTE_MACHINE(obj);
+    RemPCIHost *rem_host;
+    MemoryRegion *system_memory, *system_io, *pci_memory;
+
+    qemu_mutex_init(&ram_list.mutex);
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
-- 
1.8.3.1
