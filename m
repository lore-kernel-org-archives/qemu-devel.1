Received: from eggs.gnu.org ([209.51.188.92]:59646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLV-0001s7-SU
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLU-0004ux-ME
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:37 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nLU-0004ug-ED
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:36 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:21:29 -0800
Message-Id: <20190307072129.8567-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 11/37] multi-process: setup
 memory manager for remote device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org, berrange@redhat.com

From: Jagannathan Raman <jag.raman@oracle.com>

sync_sysmem_msg_t message format is defined. It is used to send
file descriptors of the RAM regions to remote device.
RAM on the remote device is configured with a set of file descriptors.
Old RAM regions are deleted and new regions, each with an fd, is
added to the RAM.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 Makefile.target         |  2 +
 include/io/proxy-link.h | 11 ++++++
 include/remote/memory.h | 34 +++++++++++++++++
 remote/memory.c         | 98 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 145 insertions(+)
 create mode 100644 include/remote/memory.h
 create mode 100644 remote/memory.c

diff --git a/Makefile.target b/Makefile.target
index 81335c6..fc0c579 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -130,6 +130,8 @@ remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/monitor.o
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/replay.o
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/xen-mapcache.o
 
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += remote/memory.o
+
 #########################################################
 # Linux user emulator target
 
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index a12c565..521df4f 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -35,6 +35,8 @@
 #include "qemu/osdep.h"
 #include "qom/object.h"
 #include "qemu/thread.h"
+#include "exec/cpu-common.h"
+#include "exec/hwaddr.h"
 
 typedef struct ProxyLinkState ProxyLinkState;
 
@@ -53,12 +55,14 @@ typedef struct ProxyLinkState ProxyLinkState;
  * Following commands are supported:
  * CONF_READ        PCI config. space read
  * CONF_WRITE       PCI config. space write
+ * SYNC_SYSMEM      Shares QEMU's RAM with remote device's RAM
  *
  */
 typedef enum {
     INIT = 0,
     CONF_READ,
     CONF_WRITE,
+    SYNC_SYSMEM,
     MAX,
 } proc_cmd_t;
 
@@ -75,12 +79,19 @@ typedef enum {
  *
  */
 typedef struct {
+    hwaddr gpas[REMOTE_MAX_FDS];
+    uint64_t sizes[REMOTE_MAX_FDS];
+    ram_addr_t offsets[REMOTE_MAX_FDS];
+} sync_sysmem_msg_t;
+
+typedef struct {
     proc_cmd_t cmd;
     int bytestream;
     size_t size;
 
     union {
         uint64_t u64;
+        sync_sysmem_msg_t sync_sysmem;
     } data1;
 
     int fds[REMOTE_MAX_FDS];
diff --git a/include/remote/memory.h b/include/remote/memory.h
new file mode 100644
index 0000000..6a32669
--- /dev/null
+++ b/include/remote/memory.h
@@ -0,0 +1,34 @@
+/*
+ * Memory manager for remote device
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
+#ifndef REMOTE_MEMORY_H
+#define REMOTE_MEMORY_H
+
+#include "qemu/osdep.h"
+#include "exec/hwaddr.h"
+#include "io/proxy-link.h"
+
+void remote_sysmem_reconfig(ProcMsg *msg, Error **errp);
+
+#endif
diff --git a/remote/memory.c b/remote/memory.c
new file mode 100644
index 0000000..aa76199
--- /dev/null
+++ b/remote/memory.c
@@ -0,0 +1,98 @@
+/*
+ * Memory manager for remote device
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
+#include "qemu/queue.h"
+#include "qemu-common.h"
+#include "remote/memory.h"
+#include "exec/memory.h"
+#include "exec/address-spaces.h"
+#include "cpu.h"
+#include "exec/ram_addr.h"
+#include "io/proxy-link.h"
+#include "qemu/main-loop.h"
+#include "qapi/error.h"
+
+static void remote_ram_destructor(MemoryRegion *mr)
+{
+    qemu_ram_free(mr->ram_block);
+}
+
+static void remote_ram_init_from_fd(MemoryRegion *mr, int fd, uint64_t size,
+                                    ram_addr_t offset, Error **errp)
+{
+    char *name = g_strdup_printf("%d", fd);
+
+    memory_region_init(mr, NULL, name, size);
+    mr->ram = true;
+    mr->terminates = true;
+    mr->destructor = remote_ram_destructor;
+    mr->align = 0;
+    mr->ram_block = qemu_ram_alloc_from_fd(size, mr, RAM_SHARED, fd, offset, errp);
+    mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
+
+    g_free(name);
+}
+
+void remote_sysmem_reconfig(ProcMsg *msg, Error **errp)
+{
+    sync_sysmem_msg_t *sysmem_info = &msg->data1.sync_sysmem;
+    MemoryRegion *sysmem, *subregion, *next;
+    Error *local_err = NULL;
+    int region;
+
+    sysmem = get_system_memory();
+
+    qemu_mutex_lock_iothread();
+
+    memory_region_transaction_begin();
+
+    QTAILQ_FOREACH_SAFE(subregion, &sysmem->subregions, subregions_link, next) {
+        if (subregion->ram) {
+            memory_region_del_subregion(sysmem, subregion);
+            /* TODO: should subregion be finalized separately? */
+        }
+    }
+
+    for (region = 0; region < msg->num_fds; region++) {
+        subregion = g_new(MemoryRegion, 1);
+        remote_ram_init_from_fd(subregion, msg->fds[region],
+                                sysmem_info->sizes[region],
+                                sysmem_info->offsets[region], &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            break;
+        }
+
+        memory_region_add_subregion(sysmem, sysmem_info->gpas[region],
+                                    subregion);
+    }
+
+    memory_region_transaction_commit();
+
+    qemu_mutex_unlock_iothread();
+}
-- 
1.8.3.1
