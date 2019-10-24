Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFB7C47E49
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A16B621872
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iMSO5ukn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16B621872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZqJ-0002v5-4d
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZAo-00038w-JZ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZAi-0005SR-57
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:12:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47214)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZAh-0005Ri-Os
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:12:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94Uro116446;
 Thu, 24 Oct 2019 09:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=Pe3VOKrCO7qxFYb92+AfeM/0F75bASCede7NAa4YGKY=;
 b=iMSO5uknUnzsxDsqnlU4k+xvxrtuIBo/x9r7vKeJi4lHpM9vlflWlvN7cbqbLvZFTTwv
 jPH2Go8x2FsuTubBD8gTta+xhvZZo13ejjvCBs87MLdMzX8VAahKwBpGv27BGp0xpAxa
 EpM2AwhcJK06gsvVkjoRhOGLmIWG+V1D19vilB49MoO/whrb1ZTtaonhHkztYdq9hKbI
 WZ7m6cOfcNqdLS3012Q8/Co25s7nXZtC53No0ZFF+z28hDhXOX/xVkNu1iUrYIB2yp8N
 /VusxGNj8srZqQinGMJM0zxGdF9ncJj68HJyONZOeZOIXsoXodOjpAvdr33pHAHfHtNz sA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2vqswtte7u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:12:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O97jdK170529;
 Thu, 24 Oct 2019 09:10:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2vtsk486dc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:10:34 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9O9AW83009276;
 Thu, 24 Oct 2019 09:10:32 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:10:32 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 17/49] multi-process: Synchronize remote memory
Date: Thu, 24 Oct 2019 05:08:58 -0400
Message-Id: <c05fcadf33e13791d28c5fd43241f2c6db30292a.1571905346.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240089
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 kraxel@redhat.com, jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
 v2 -> v3:
   - Refactored code to obtain fd from host address, added
     get_fd_from_hostaddr().
   - Discovered a bug which results in invalid FDs (-1) being
     sent over to the remote process. Fixed this by checking
     if the FD value is valid before sending over to remote.

 Makefile.target                |   1 +
 hw/proxy/memory-sync.c         | 226 +++++++++++++++++++++++++++++++++++++++++
 hw/proxy/qemu-proxy.c          |   5 +
 include/hw/proxy/memory-sync.h |  51 ++++++++++
 include/hw/proxy/qemu-proxy.h  |   2 +
 remote/remote-main.c           |  11 ++
 6 files changed, 296 insertions(+)
 create mode 100644 hw/proxy/memory-sync.c
 create mode 100644 include/hw/proxy/memory-sync.h

diff --git a/Makefile.target b/Makefile.target
index 547f10e..eb1ac34 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -122,6 +122,7 @@ obj-$(CONFIG_TCG) += fpu/softfloat.o
 obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
+obj-$(CONFIG_MPQEMU) += hw/proxy/memory-sync.o
 LIBS := $(libs_cpu) $(LIBS)
 
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) += accel/stubs/kvm-stub.o
diff --git a/hw/proxy/memory-sync.c b/hw/proxy/memory-sync.c
new file mode 100644
index 0000000..da24a25
--- /dev/null
+++ b/hw/proxy/memory-sync.c
@@ -0,0 +1,226 @@
+/*
+ * Copyright 2019, Oracle and/or its affiliates.
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
+#include "io/mpqemu-link.h"
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
+static int get_fd_from_hostaddr(uint64_t host, ram_addr_t *offset)
+{
+    MemoryRegion *mr;
+    ram_addr_t off;
+
+    mr = memory_region_from_host((void *)(uintptr_t)host, &off);
+
+    if (offset) {
+        *offset = off;
+    }
+
+    return memory_region_get_fd(mr);
+}
+
+static bool proxy_mrs_can_merge(uint64_t host, uint64_t prev_host, size_t size)
+{
+    bool merge;
+    int fd1, fd2;
+
+    fd1 = get_fd_from_hostaddr(host, NULL);
+
+    fd2 = get_fd_from_hostaddr(prev_host, NULL);
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
+    if (get_fd_from_hostaddr(mrs_host, NULL) <= 0) {
+        return;
+    }
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
+    MPQemuMsg msg;
+    MemoryRegionSection section;
+    ram_addr_t offset;
+    uintptr_t host_addr;
+    int region;
+
+    memset(&msg, 0, sizeof(MPQemuMsg));
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
+        msg.fds[region] = get_fd_from_hostaddr(host_addr, &offset);
+        msg.data1.sync_sysmem.offsets[region] = offset;
+    }
+    mpqemu_msg_send(sync->mpqemu_link, &msg, sync->mpqemu_link->com);
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
+ *       thread. MemorySync would contain a list of mpqemu-link objects
+ *       that need notification. proxy_ml_commit() could send the same
+ *       message to all the links at the same time.
+ */
+void configure_memory_sync(RemoteMemSync *sync, MPQemuLinkState *mpqemu_link)
+{
+    sync->n_mr_sections = 0;
+    sync->mr_sections = NULL;
+
+    sync->mpqemu_link = mpqemu_link;
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
index e1f62d7..71770ca 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -42,6 +42,8 @@
 #include "qapi/qmp/qstring.h"
 #include "sysemu/sysemu.h"
 #include "hw/proxy/qemu-proxy.h"
+#include "hw/proxy/memory-sync.h"
+#include "qom/object.h"
 
 static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
 
@@ -268,6 +270,8 @@ static void init_proxy(PCIDevice *dev, char *command, bool need_spawn, Error **e
 
     mpqemu_init_channel(pdev->mpqemu_link, &pdev->mpqemu_link->com,
                         pdev->socket);
+
+    configure_memory_sync(pdev->sync, pdev->mpqemu_link);
 }
 
 static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
@@ -298,6 +302,7 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
     dev->set_proxy_sock = set_proxy_sock;
     dev->get_proxy_sock = get_proxy_sock;
     dev->init_proxy = init_proxy;
+    dev->sync = REMOTE_MEM_SYNC(object_new(TYPE_MEMORY_LISTENER));
 }
 
 static void send_bar_access_msg(PCIProxyDev *dev, MemoryRegion *mr,
diff --git a/include/hw/proxy/memory-sync.h b/include/hw/proxy/memory-sync.h
new file mode 100644
index 0000000..cb94995
--- /dev/null
+++ b/include/hw/proxy/memory-sync.h
@@ -0,0 +1,51 @@
+/*
+ * Copyright 2019, Oracle and/or its affiliates.
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
+#include "io/mpqemu-link.h"
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
+    MPQemuLinkState *mpqemu_link;
+} RemoteMemSync;
+
+void configure_memory_sync(RemoteMemSync *sync, MPQemuLinkState *mpqemu_link);
+void deconfigure_memory_sync(RemoteMemSync *sync);
+
+#endif
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index 5f57822..7475bba 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -24,6 +24,7 @@
 #define QEMU_PROXY_H
 
 #include "io/mpqemu-link.h"
+#include "hw/proxy/memory-sync.h"
 
 #define TYPE_PCI_PROXY_DEV "pci-proxy-dev"
 
@@ -56,6 +57,7 @@ struct PCIProxyDev {
 
     MPQemuLinkState *mpqemu_link;
 
+    RemoteMemSync *sync;
     EventNotifier intr;
     EventNotifier resample;
 
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 49b27d5..9fe4b87 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -47,6 +47,7 @@
 #include "sysemu/sysemu.h"
 #include "block/block.h"
 #include "exec/memattrs.h"
+#include "exec/address-spaces.h"
 
 static MPQemuLinkState *mpqemu_link;
 PCIDevice *remote_pci_dev;
@@ -175,6 +176,16 @@ static void process_msg(GIOCondition cond, MPQemuChannel *chan)
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


