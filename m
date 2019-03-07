Received: from eggs.gnu.org ([209.51.188.92]:59861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLy-0002Ep-4h
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLw-0005DB-C9
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:06 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nLw-0005BP-0a
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:22:04 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:21:55 -0800
Message-Id: <20190307072155.8886-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 17/37] multi-process:
 Synchronize remote memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org, marcandre.lureau@redhat.com, berrange@redhat.com, armbru@redhat.com

From: Jagannathan Raman <jag.raman@oracle.com>

Add memory-listener object which is used to keep the view of the RAM
in sync between QEMU and remote process.
A MemoryListener is registered for system-memory AddressSpace. The
listener sends SYNC_SYSMEM message to the remote process when memory
listener commits the changes to memory, the remote process receives
the message and processes it in the handler for SYNC_SYSMEM message.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 Makefile.target                |   1 +
 hw/proxy/memory-sync.c         | 214 +++++++++++++++++++++++++++++++++++++++++
 hw/proxy/qemu-proxy.c          |   6 ++
 include/hw/proxy/memory-sync.h |  51 ++++++++++
 include/hw/proxy/qemu-proxy.h  |   2 +
 remote/remote-main.c           |  11 +++
 6 files changed, 285 insertions(+)
 create mode 100644 hw/proxy/memory-sync.c
 create mode 100644 include/hw/proxy/memory-sync.h

diff --git a/Makefile.target b/Makefile.target
index fc0c579..470c153 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -119,6 +119,7 @@ obj-$(CONFIG_TCG) += fpu/softfloat.o
 obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
+obj-$(CONFIG_MPQEMU) += hw/proxy/memory-sync.o
 
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) += accel/stubs/kvm-stub.o
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) += accel/stubs/tcg-stub.o
diff --git a/hw/proxy/memory-sync.c b/hw/proxy/memory-sync.c
new file mode 100644
index 0000000..2f5e229
--- /dev/null
+++ b/hw/proxy/memory-sync.c
@@ -0,0 +1,214 @@
+/*
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
+#include <sys/types.h>
+#include <stdio.h>
+#include <string.h>
+
+#include "qemu/osdep.h"
+#include "qemu/compiler.h"
+#include "qemu/int128.h"
+#include "qemu/range.h"
+#include "exec/memory.h"
+#include "exec/cpu-common.h"
+#include "cpu.h"
+#include "exec/ram_addr.h"
+#include "exec/address-spaces.h"
+#include "io/proxy-link.h"
+#include "hw/proxy/memory-sync.h"
+
+static const TypeInfo remote_mem_sync_type_info = {
+    .name          = TYPE_MEMORY_LISTENER,
+    .parent        = TYPE_OBJECT,
+    .instance_size = sizeof(RemoteMemSync),
+};
+
+static void remote_mem_sync_register_types(void)
+{
+    type_register_static(&remote_mem_sync_type_info);
+}
+
+type_init(remote_mem_sync_register_types)
+
+static void proxy_ml_begin(MemoryListener *listener)
+{
+    RemoteMemSync *sync = container_of(listener, RemoteMemSync, listener);
+    int mrs;
+
+    for (mrs = 0; mrs < sync->n_mr_sections; mrs++) {
+        memory_region_unref(sync->mr_sections[mrs].mr);
+    }
+
+    g_free(sync->mr_sections);
+    sync->mr_sections = NULL;
+    sync->n_mr_sections = 0;
+}
+
+static bool proxy_mrs_can_merge(uint64_t host, uint64_t prev_host, size_t size)
+{
+    bool merge;
+    ram_addr_t offset;
+    int fd1, fd2;
+    MemoryRegion *mr;
+
+    mr = memory_region_from_host((void *)(uintptr_t)host, &offset);
+    fd1 = memory_region_get_fd(mr);
+
+    mr = memory_region_from_host((void *)(uintptr_t)prev_host, &offset);
+    fd2 = memory_region_get_fd(mr);
+
+    merge = (fd1 == fd2);
+
+    merge &= ((prev_host + size) == host);
+
+    return merge;
+}
+
+static void proxy_ml_region_addnop(MemoryListener *listener,
+                                   MemoryRegionSection *section)
+{
+    RemoteMemSync *sync = container_of(listener, RemoteMemSync, listener);
+    bool need_add = true;
+    uint64_t mrs_size, mrs_gpa, mrs_page;
+    uintptr_t mrs_host;
+    RAMBlock *mrs_rb;
+    MemoryRegionSection *prev_sec;
+
+    if (!(memory_region_is_ram(section->mr) &&
+          !memory_region_is_rom(section->mr))) {
+        return;
+    }
+
+    mrs_rb = section->mr->ram_block;
+    mrs_page = (uint64_t)qemu_ram_pagesize(mrs_rb);
+    mrs_size = int128_get64(section->size);
+    mrs_gpa = section->offset_within_address_space;
+    mrs_host = (uintptr_t)memory_region_get_ram_ptr(section->mr) +
+               section->offset_within_region;
+
+    mrs_host = mrs_host & ~(mrs_page - 1);
+    mrs_gpa = mrs_gpa & ~(mrs_page - 1);
+    mrs_size = ROUND_UP(mrs_size, mrs_page);
+
+    if (sync->n_mr_sections) {
+        prev_sec = sync->mr_sections + (sync->n_mr_sections - 1);
+        uint64_t prev_gpa_start = prev_sec->offset_within_address_space;
+        uint64_t prev_size = int128_get64(prev_sec->size);
+        uint64_t prev_gpa_end   = range_get_last(prev_gpa_start, prev_size);
+        uint64_t prev_host_start =
+            (uintptr_t)memory_region_get_ram_ptr(prev_sec->mr) +
+            prev_sec->offset_within_region;
+        uint64_t prev_host_end = range_get_last(prev_host_start, prev_size);
+
+        if (mrs_gpa <= (prev_gpa_end + 1)) {
+            if (mrs_gpa < prev_gpa_start) {
+                assert(0);
+            }
+
+            if ((section->mr == prev_sec->mr) &&
+                proxy_mrs_can_merge(mrs_host, prev_host_start,
+                                    (mrs_gpa - prev_gpa_start))) {
+                uint64_t max_end = MAX(prev_host_end, mrs_host + mrs_size);
+                need_add = false;
+                prev_sec->offset_within_address_space =
+                    MIN(prev_gpa_start, mrs_gpa);
+                prev_sec->offset_within_region =
+                    MIN(prev_host_start, mrs_host) -
+                    (uintptr_t)memory_region_get_ram_ptr(prev_sec->mr);
+                prev_sec->size = int128_make64(max_end - MIN(prev_host_start,
+                                                             mrs_host));
+            }
+        }
+    }
+
+    if (need_add) {
+        ++sync->n_mr_sections;
+        sync->mr_sections = g_renew(MemoryRegionSection, sync->mr_sections,
+                                    sync->n_mr_sections);
+        sync->mr_sections[sync->n_mr_sections - 1] = *section;
+        sync->mr_sections[sync->n_mr_sections - 1].fv = NULL;
+        memory_region_ref(section->mr);
+    }
+}
+
+static void proxy_ml_commit(MemoryListener *listener)
+{
+    RemoteMemSync *sync = container_of(listener, RemoteMemSync, listener);
+    ProcMsg msg;
+    ram_addr_t offset;
+    MemoryRegion *mr;
+    MemoryRegionSection section;
+    uintptr_t host_addr;
+    int region;
+
+    memset(&msg, 0, sizeof(ProcMsg));
+
+    msg.cmd = SYNC_SYSMEM;
+    msg.bytestream = 0;
+    msg.num_fds = sync->n_mr_sections;
+    msg.size = sizeof(msg.data1);
+    assert(msg.num_fds <= REMOTE_MAX_FDS);
+
+    for (region = 0; region < sync->n_mr_sections; region++) {
+        section = sync->mr_sections[region];
+        msg.data1.sync_sysmem.gpas[region] =
+            section.offset_within_address_space;
+        msg.data1.sync_sysmem.sizes[region] = int128_get64(section.size);
+        host_addr = (uintptr_t)memory_region_get_ram_ptr(section.mr) +
+                    section.offset_within_region;
+        mr = memory_region_from_host((void *)host_addr, &offset);
+        msg.fds[region] = memory_region_get_fd(mr);
+        msg.data1.sync_sysmem.offsets[region] = offset;
+    }
+    proxy_proc_send(sync->proxy_link, &msg);
+}
+
+void deconfigure_memory_sync(RemoteMemSync *sync)
+{
+    memory_listener_unregister(&sync->listener);
+}
+
+/*
+ * TODO: Memory Sync need not be instantianted once per every proxy device.
+ *       All remote devices are going to get the exact same updates at the
+ *       same time. It therefore makes sense to have a broadcast model.
+ *
+ *       Broadcast model would involve running the MemorySync object in a
+ *       thread. MemorySync would contain a list of proxy_link objects
+ *       that need notification. proxy_ml_commit() could send the same
+ *       message to all the links at the same time.
+ */
+void configure_memory_sync(RemoteMemSync *sync, ProxyLinkState *proxy_link)
+{
+    sync->n_mr_sections = 0;
+    sync->mr_sections = NULL;
+
+    sync->proxy_link = proxy_link;
+
+    sync->listener.begin = proxy_ml_begin;
+    sync->listener.commit = proxy_ml_commit;
+    sync->listener.region_add = proxy_ml_region_addnop;
+    sync->listener.region_nop = proxy_ml_region_addnop;
+    sync->listener.priority = 10;
+
+    memory_listener_register(&sync->listener, &address_space_memory);
+}
diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 08e549e..d3a9001 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -42,6 +42,8 @@
 #include "qapi/qmp/qstring.h"
 #include "sysemu/sysemu.h"
 #include "hw/proxy/qemu-proxy.h"
+#include "hw/proxy/memory-sync.h"
+#include "qom/object.h"
 
 static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
 
@@ -200,6 +202,10 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
             error_propagate(errp, local_err);
         }
     }
+
+    dev->sync = REMOTE_MEM_SYNC(object_new(TYPE_MEMORY_LISTENER));
+
+    configure_memory_sync(dev->sync, dev->proxy_link);
 }
 
 static void send_bar_access_msg(ProxyLinkState *proxy_link, MemoryRegion *mr,
diff --git a/include/hw/proxy/memory-sync.h b/include/hw/proxy/memory-sync.h
new file mode 100644
index 0000000..99ca35e
--- /dev/null
+++ b/include/hw/proxy/memory-sync.h
@@ -0,0 +1,51 @@
+/*
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
+#ifndef MEMORY_SYNC_H
+#define MEMORY_SYNC_H
+
+#include <sys/types.h>
+
+#include "qemu/osdep.h"
+#include "qom/object.h"
+#include "exec/memory.h"
+#include "io/proxy-link.h"
+
+#define TYPE_MEMORY_LISTENER "memory-listener"
+#define REMOTE_MEM_SYNC(obj) \
+            OBJECT_CHECK(RemoteMemSync, (obj), TYPE_MEMORY_LISTENER)
+
+typedef struct RemoteMemSync {
+    Object obj;
+
+    MemoryListener listener;
+
+    int n_mr_sections;
+    MemoryRegionSection *mr_sections;
+
+    ProxyLinkState *proxy_link;
+} RemoteMemSync;
+
+void configure_memory_sync(RemoteMemSync *sync, ProxyLinkState *proxy_link);
+void deconfigure_memory_sync(RemoteMemSync *sync);
+
+#endif
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index e8d3a9c..03be8f9 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -24,6 +24,7 @@
 #define QEMU_PROXY_H
 
 #include "io/proxy-link.h"
+#include "hw/proxy/memory-sync.h"
 
 #define TYPE_PCI_PROXY_DEV "pci-proxy-dev"
 
@@ -44,6 +45,7 @@ typedef struct PCIProxyDev {
 
     ProxyLinkState *proxy_link;
 
+    RemoteMemSync *sync;
     EventNotifier intr;
     EventNotifier resample;
 
diff --git a/remote/remote-main.c b/remote/remote-main.c
index f0390cc..c67b957 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -46,6 +46,7 @@
 #include "sysemu/sysemu.h"
 #include "block/block.h"
 #include "exec/memattrs.h"
+#include "exec/address-spaces.h"
 
 static ProxyLinkState *proxy_link;
 PCIDevice *remote_pci_dev;
@@ -174,6 +175,16 @@ static void process_msg(GIOCondition cond)
             goto finalize_loop;
         }
         break;
+    case SYNC_SYSMEM:
+        /*
+         * TODO: ensure no active DMA is happening when
+         * sysmem is being updated
+         */
+        remote_sysmem_reconfig(msg, &err);
+        if (err) {
+            goto finalize_loop;
+        }
+        break;
     default:
         error_setg(&err, "Unknown command");
         goto finalize_loop;
-- 
1.8.3.1
