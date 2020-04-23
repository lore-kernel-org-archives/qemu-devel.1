Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D398C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132802075A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QBD98kQf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132802075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRTN4-0003Mx-8Y
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 00:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTGe-0000ei-5M
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTGc-0007eQ-Ri
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:15:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41582)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jRTGc-0007Zs-6M
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:15:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4CbR5131595;
 Thu, 23 Apr 2020 04:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=nhkHpRM/UNOwZoGwKC3D9sq/t1//gtXGMsD7JHD0aRw=;
 b=QBD98kQfchvj0fDET03C+ogyqA8tXksIJzgusBR5QH5j9Ic8zG9Z0ADy5TUGq8pyKeLi
 A7LXRSgkUeG+2JdFMSrqUrNsVW6pycGKRMPMfQmcemXbi46OxrWrEXMd7i3T24T6sV4k
 EdXTTj2edwPu+QodZDvGVB56G01MyxdQ/YAS9YBcqX9/ad+trLoqbK4QybdMYEVmuifb
 3hepdbQmSNYHPU8Q3JoO0zurdSQPPs4FzVmffD7XgLcYrgCSmrMvi2cln3hm+xOzdW/d
 YL03F+70YmZAgynO+1AyF7NVqdfkXdemOW1IzgT2vjnvby2szwrf9a4rIQaz2gaelfNu Zg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 30jvq4s90c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:15:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4BfVY093696;
 Thu, 23 Apr 2020 04:15:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 30gb3ux0s5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:15:07 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03N4F5C7020386;
 Thu, 23 Apr 2020 04:15:05 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 22 Apr 2020 21:15:05 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v6 22/36] multi-process: Synchronize remote memory
Date: Wed, 22 Apr 2020 21:13:57 -0700
Message-Id: <63a7f84be8c1c86d1bdea5f538239d0d9c3cdb06.1587614626.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1587614626.git.elena.ufimtseva@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=4 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=4
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=elena.ufimtseva@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 00:14:28
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
 MAINTAINERS                    |   2 +
 Makefile.target                |   3 +
 hw/proxy/memory-sync.c         | 217 +++++++++++++++++++++++++++++++++
 hw/proxy/qemu-proxy.c          |   6 +
 include/hw/proxy/memory-sync.h |  37 ++++++
 include/hw/proxy/qemu-proxy.h  |   6 +
 remote/remote-main.c           |  11 ++
 7 files changed, 282 insertions(+)
 create mode 100644 hw/proxy/memory-sync.c
 create mode 100644 include/hw/proxy/memory-sync.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3da3dcd311..9ebb46722a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2869,6 +2869,8 @@ F: remote/memory.c
 F: hw/proxy/Makefile.objs
 F: hw/proxy/qemu-proxy.c
 F: include/hw/proxy/qemu-proxy.h
+F: include/hw/proxy/memory-sync.h
+F: hw/proxy/memory-sync.c
 
 Build and test automation
 -------------------------
diff --git a/Makefile.target b/Makefile.target
index 500fa07fda..c64d860895 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -127,6 +127,9 @@ obj-$(CONFIG_TCG) += fpu/softfloat.o
 obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
+ifeq ($(TARGET_NAME)-$(CONFIG_MPQEMU)-$(CONFIG_USER_ONLY), x86_64-y-)
+obj-$(CONFIG_MPQEMU) += hw/proxy/memory-sync.o
+endif
 LIBS := $(libs_cpu) $(LIBS)
 
 obj-$(CONFIG_PLUGIN) += plugins/
diff --git a/hw/proxy/memory-sync.c b/hw/proxy/memory-sync.c
new file mode 100644
index 0000000000..b3f57747f3
--- /dev/null
+++ b/hw/proxy/memory-sync.c
@@ -0,0 +1,217 @@
+/*
+ * Copyright © 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
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
+    /**
+     * Assumes that the host address is a valid address as it's
+     * coming from the MemoryListener system. In the case host
+     * address is not valid, the following call would return
+     * the default subregion of "system_memory" region, and
+     * not NULL. So it's not possible to check for NULL here.
+     */
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
+            g_assert(mrs_gpa > prev_gpa_start);
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
+    mpqemu_msg_send(&msg, sync->mpqemu_link->com);
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
index 7fd0a312a5..2ac4c1528a 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -13,6 +13,8 @@
 #include "io/mpqemu-link.h"
 #include "hw/proxy/qemu-proxy.h"
 #include "hw/pci/pci.h"
+#include "hw/proxy/memory-sync.h"
+#include "qom/object.h"
 
 static int config_op_send(PCIProxyDev *dev, uint32_t addr, uint32_t *val, int l,
                           unsigned int op)
@@ -138,6 +140,10 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
             error_propagate(errp, local_err);
         }
     }
+
+    dev->sync = REMOTE_MEM_SYNC(object_new(TYPE_MEMORY_LISTENER));
+
+    configure_memory_sync(dev->sync, dev->mpqemu_link);
 }
 
 static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/proxy/memory-sync.h b/include/hw/proxy/memory-sync.h
new file mode 100644
index 0000000000..d8329c9b52
--- /dev/null
+++ b/include/hw/proxy/memory-sync.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright © 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
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
index 9e4127eccb..6d14876ba9 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -14,6 +14,7 @@
 
 #include "io/mpqemu-link.h"
 #include "hw/pci/pci.h"
+#include "hw/proxy/memory-sync.h"
 
 #define TYPE_PCI_PROXY_DEV "pci-proxy-dev"
 
@@ -39,8 +40,13 @@ typedef struct ProxyMemoryRegion {
 struct PCIProxyDev {
     PCIDevice parent_dev;
 
+    int n_mr_sections;
+    MemoryRegionSection *mr_sections;
+
     MPQemuLinkState *mpqemu_link;
 
+    RemoteMemSync *sync;
+
     int socket;
 
     ProxyMemoryRegion region[PCI_NUM_REGIONS];
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 0990509f7a..90f241064f 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -35,6 +35,7 @@
 #include "exec/ramlist.h"
 #include "remote/remote-common.h"
 #include "exec/memattrs.h"
+#include "exec/address-spaces.h"
 
 static void process_msg(GIOCondition cond, MPQemuLinkState *link,
                         MPQemuChannel *chan);
@@ -231,6 +232,16 @@ static void process_msg(GIOCondition cond, MPQemuLinkState *link,
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
         error_setg(&err, "Unknown command in %s", print_pid_exec(pid_exec));
         goto finalize_loop;
-- 
2.25.GIT


