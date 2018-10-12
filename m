Received: from eggs.gnu.org ([2001:4830:134:3::10]:60828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1gB7Ax-0008C3-P2
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 19:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1gB7Aq-0006UD-70
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 19:48:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jag.raman@oracle.com>)
	id 1gB7Ao-0006Rw-2Z
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 19:48:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	w9CNjM0p088839
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:47 GMT
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by userp2120.oracle.com with ESMTP id 2mxnprndsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:47 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9CNmlrK031014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:47 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9CNmk4Y012021
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:46 GMT
From: Jagannathan Raman <jag.raman@oracle.com>
Date: Fri, 12 Oct 2018 19:48:32 -0400
Message-Id: <25dd2b74a8ddc16da84a89adcfbeabf21aa89d2e.1539387238.git.jag.raman@oracle.com>
In-Reply-To: <cover.1539387238.git.jag.raman@oracle.com>
References: <cover.1539387238.git.jag.raman@oracle.com>
In-Reply-To: <cover.1539387238.git.jag.raman@oracle.com>
References: <cover.1539387238.git.jag.raman@oracle.com>
Subject: [Qemu-devel] [RFC PATCH v1 5/8] multi-process QEMU: setup memory
 manager for remote device
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

- sync_sysmem_msg_t message format is defined. It is used to send
  file descriptors of the RAM regions to remote device
- RAM on the remote device is configured with a set of file descriptors.
  Old RAM regions are deleted and new regions, each with an fd, is
  added to the RAM.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 include/io/proxy-link.h |  9 +++++
 include/remote/memory.h | 34 ++++++++++++++++++
 remote/Makefile.objs    |  1 +
 remote/memory.c         | 93 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 137 insertions(+)
 create mode 100644 include/remote/memory.h
 create mode 100644 remote/memory.c

diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index 6ce6c10..1eeabae 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -39,6 +39,8 @@ typedef struct ProxyLinkState ProxyLinkState;
 #define PROXY_LINK(obj) \
     OBJECT_CHECK(ProxyLinkState, (obj), TYPE_PROXY_LINK)
 
+#include "exec/hwaddr.h"
+
 #define MAX_FDS 8
 
 #define PROC_HDR_SIZE offsetof(ProcMsg, data1.u64)
@@ -47,16 +49,23 @@ typedef enum {
     INIT = 0,
     CONF_READ,
     CONF_WRITE,
+    SYNC_SYSMEM,
     MAX,
 } proc_cmd_t;
 
 typedef struct {
+    hwaddr gpas[MAX_FDS];
+    uint64_t sizes[MAX_FDS];
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
 
     int fds[MAX_FDS];
diff --git a/include/remote/memory.h b/include/remote/memory.h
new file mode 100644
index 0000000..4500192
--- /dev/null
+++ b/include/remote/memory.h
@@ -0,0 +1,34 @@
+/*
+ * Memory manager for remote device
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
diff --git a/remote/Makefile.objs b/remote/Makefile.objs
index e90ae20..c52d500 100644
--- a/remote/Makefile.objs
+++ b/remote/Makefile.objs
@@ -1,2 +1,3 @@
 remote-obj-y += pcihost.o
 remote-obj-y += machine.o
+remote-obj-y += memory.o
diff --git a/remote/memory.c b/remote/memory.c
new file mode 100644
index 0000000..f4cf2d2
--- /dev/null
+++ b/remote/memory.c
@@ -0,0 +1,93 @@
+/*
+ * Memory manager for remote device
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
+#include "qemu/queue.h"
+#include "qemu-common.h"
+#include "remote/memory.h"
+#include "exec/memory.h"
+#include "exec/address-spaces.h"
+#include "cpu.h"
+#include "exec/ram_addr.h"
+#include "io/proxy-link.h"
+#include "qemu/main-loop.h"
+
+static void remote_ram_destructor(MemoryRegion *mr)
+{
+    qemu_ram_free(mr->ram_block);
+}
+
+static void remote_ram_init_from_fd(MemoryRegion *mr, int fd, uint64_t size,
+                                    Error **errp)
+{
+    char *name;
+
+    name = g_malloc(sizeof(int) + 1);
+    snprintf(name, sizeof(int) + 1, "%x", fd);
+
+    memory_region_init(mr, NULL, name, size);
+    mr->ram = true;
+    mr->terminates = true;
+    mr->destructor = remote_ram_destructor;
+    mr->align = 0;
+    mr->ram_block = qemu_ram_alloc_from_fd(size, mr, false, fd, errp);
+    mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
+
+    g_free(name);
+}
+
+void remote_sysmem_reconfig(ProcMsg *msg, Error **errp)
+{
+    MemoryRegion *sysmem, *subregion, *next;
+    int region;
+    sync_sysmem_msg_t *sysmem_info = &msg->data1.sync_sysmem;
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
+                                sysmem_info->sizes[region], errp);
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
