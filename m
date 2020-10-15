Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCECC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:17:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D27CE20760
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qlc3aQWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27CE20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT7p6-0003qJ-LV
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 14:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1kT7dV-0000B4-Vy
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:05:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1kT7dR-0002Q2-1a
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:05:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FI3rKe104172;
 Thu, 15 Oct 2020 18:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding;
 s=corp-2020-01-29; bh=7xOZ+toq7sOGxr2McHqeiCgw1GcAgBkZvXxxE8lVL2k=;
 b=qlc3aQWuko6bFACy5vA5EMqOCWJbySWs27KL4/VqknOkXGKcTIWnXSlGNraK9TMfT1uh
 x2otEhOG8ViTO7AuJPPExUBNJ14Rbeo43QdUr1rhqfzjXc0mEdB17RP0+VpWSZJONfIH
 nHhX9fI39/d7kRPwZyTioHi+u30xXgvKd9wjtgkxdY0efsSxMTUStl8hugNP6xVQerVm
 8gEJP740q1HgQ2jsFKYqL2pD80t25x6bo4ganZdHm2zLP+U2OqFEzn/hz/RcvoYJ3gfl
 n9GAG6bdSc6SQInWUYGCVVDduv6R0HWjQSUZNgL9avmImTXumbYujIzfhH4QuHAKj2cL GA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 343vaemhn7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 Oct 2020 18:05:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FI5NPh133387;
 Thu, 15 Oct 2020 18:05:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 343pv262ct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Oct 2020 18:05:44 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09FI5gup002158;
 Thu, 15 Oct 2020 18:05:42 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 15 Oct 2020 11:05:42 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 14/19] multi-process: Synchronize remote memory
Date: Thu, 15 Oct 2020 14:05:07 -0400
Message-Id: <1b24ce9dee6084e03895c3bded230745071b7f39.1602784930.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1602784930.git.jag.raman@oracle.com>
References: <cover.1602784930.git.jag.raman@oracle.com>
In-Reply-To: <cover.1602784930.git.jag.raman@oracle.com>
References: <cover.1602784930.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=4 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=4 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150121
Received-SPF: pass client-ip=156.151.31.85; envelope-from=jag.raman@oracle.com;
 helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 14:05:35
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 alex.williamson@redhat.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS                  |   2 +
 hw/i386/remote-msg.c         |   5 ++
 hw/pci/memory-sync.c         | 210 +++++++++++++++++++++++++++++++++++++++++++
 hw/pci/meson.build           |   2 +
 hw/pci/proxy.c               |   6 ++
 include/hw/pci/memory-sync.h |  27 ++++++
 include/hw/pci/proxy.h       |   2 +
 7 files changed, 254 insertions(+)
 create mode 100644 hw/pci/memory-sync.c
 create mode 100644 include/hw/pci/memory-sync.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 202db86..8ee717c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3113,6 +3113,8 @@ F: include/hw/i386/remote-memory.h
 F: hw/i386/remote-memory.c
 F: hw/pci/proxy.c
 F: include/hw/pci/proxy.h
+F: hw/pci/memory-sync.c
+F: include/hw/pci/memory-sync.h
 
 Build and test automation
 -------------------------
diff --git a/hw/i386/remote-msg.c b/hw/i386/remote-msg.c
index 9b9ca7e..3465a9d 100644
--- a/hw/i386/remote-msg.c
+++ b/hw/i386/remote-msg.c
@@ -17,6 +17,7 @@
 #include "sysemu/runstate.h"
 #include "hw/pci/pci.h"
 #include "exec/memattrs.h"
+#include "hw/i386/remote-memory.h"
 
 static void process_config_write(QIOChannel *ioc, PCIDevice *dev,
                                  MPQemuMsg *msg);
@@ -64,6 +65,10 @@ void coroutine_fn mpqemu_remote_msg_loop_co(void *data)
         case BAR_READ:
             process_bar_read(com->ioc, &msg, &local_err);
             break;
+        case SYNC_SYSMEM:
+            remote_sysmem_reconfig(&msg, &local_err);
+            break;
+
         default:
             error_setg(&local_err,
                        "Unknown command (%d) received for device %s (pid=%d)",
diff --git a/hw/pci/memory-sync.c b/hw/pci/memory-sync.c
new file mode 100644
index 0000000..26a8784
--- /dev/null
+++ b/hw/pci/memory-sync.c
@@ -0,0 +1,210 @@
+/*
+ * Copyright © 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+#include "qemu/compiler.h"
+#include "qemu/int128.h"
+#include "qemu/range.h"
+#include "exec/memory.h"
+#include "exec/cpu-common.h"
+#include "cpu.h"
+#include "exec/ram_addr.h"
+#include "exec/address-spaces.h"
+#include "io/mpqemu-link.h"
+#include "hw/pci/memory-sync.h"
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
+static bool try_merge(RemoteMemSync *sync, MemoryRegionSection *section)
+{
+    uint64_t mrs_size, mrs_gpa, mrs_page;
+    MemoryRegionSection *prev_sec;
+    bool merged = false;
+    uintptr_t mrs_host;
+    RAMBlock *mrs_rb;
+
+    if (!sync->n_mr_sections) {
+        return false;
+    }
+
+    mrs_rb = section->mr->ram_block;
+    mrs_page = (uint64_t)qemu_ram_pagesize(mrs_rb);
+    mrs_size = int128_get64(section->size);
+    mrs_gpa = section->offset_within_address_space;
+    mrs_host = (uintptr_t)memory_region_get_ram_ptr(section->mr) +
+               section->offset_within_region;
+
+    if (get_fd_from_hostaddr(mrs_host, NULL) < 0) {
+        return true;
+    }
+
+    mrs_host = mrs_host & ~(mrs_page - 1);
+    mrs_gpa = mrs_gpa & ~(mrs_page - 1);
+    mrs_size = ROUND_UP(mrs_size, mrs_page);
+
+    prev_sec = sync->mr_sections + (sync->n_mr_sections - 1);
+    uint64_t prev_gpa_start = prev_sec->offset_within_address_space;
+    uint64_t prev_size = int128_get64(prev_sec->size);
+    uint64_t prev_gpa_end   = range_get_last(prev_gpa_start, prev_size);
+    uint64_t prev_host_start =
+        (uintptr_t)memory_region_get_ram_ptr(prev_sec->mr) +
+        prev_sec->offset_within_region;
+    uint64_t prev_host_end = range_get_last(prev_host_start, prev_size);
+
+    if (mrs_gpa <= (prev_gpa_end + 1)) {
+        g_assert(mrs_gpa > prev_gpa_start);
+
+        if ((section->mr == prev_sec->mr) &&
+            proxy_mrs_can_merge(mrs_host, prev_host_start,
+                                (mrs_gpa - prev_gpa_start))) {
+            uint64_t max_end = MAX(prev_host_end, mrs_host + mrs_size);
+            merged = true;
+            prev_sec->offset_within_address_space =
+                MIN(prev_gpa_start, mrs_gpa);
+            prev_sec->offset_within_region =
+                MIN(prev_host_start, mrs_host) -
+                (uintptr_t)memory_region_get_ram_ptr(prev_sec->mr);
+            prev_sec->size = int128_make64(max_end - MIN(prev_host_start,
+                                                         mrs_host));
+        }
+    }
+
+    return merged;
+}
+
+static void proxy_ml_region_addnop(MemoryListener *listener,
+                                   MemoryRegionSection *section)
+{
+    RemoteMemSync *sync = container_of(listener, RemoteMemSync, listener);
+
+    if (!(memory_region_is_ram(section->mr) &&
+          !memory_region_is_rom(section->mr))) {
+        return;
+    }
+
+    if (try_merge(sync, section)) {
+        return;
+    }
+
+    ++sync->n_mr_sections;
+    sync->mr_sections = g_renew(MemoryRegionSection, sync->mr_sections,
+                                sync->n_mr_sections);
+    sync->mr_sections[sync->n_mr_sections - 1] = *section;
+    sync->mr_sections[sync->n_mr_sections - 1].fv = NULL;
+    memory_region_ref(section->mr);
+}
+
+static void proxy_ml_commit(MemoryListener *listener)
+{
+    RemoteMemSync *sync = container_of(listener, RemoteMemSync, listener);
+    MPQemuMsg msg;
+    MemoryRegionSection *section;
+    ram_addr_t offset;
+    uintptr_t host_addr;
+    int region;
+    Error *local_err = NULL;
+
+    memset(&msg, 0, sizeof(MPQemuMsg));
+
+    msg.cmd = SYNC_SYSMEM;
+    msg.num_fds = sync->n_mr_sections;
+    msg.size = sizeof(SyncSysmemMsg);
+    if (msg.num_fds > REMOTE_MAX_FDS) {
+        error_report("Number of fds is more than %d", REMOTE_MAX_FDS);
+        return;
+    }
+
+    for (region = 0; region < sync->n_mr_sections; region++) {
+        section = &sync->mr_sections[region];
+        msg.data.sync_sysmem.gpas[region] =
+            section->offset_within_address_space;
+        msg.data.sync_sysmem.sizes[region] = int128_get64(section->size);
+        host_addr = (uintptr_t)memory_region_get_ram_ptr(section->mr) +
+                    section->offset_within_region;
+        msg.fds[region] = get_fd_from_hostaddr(host_addr, &offset);
+        msg.data.sync_sysmem.offsets[region] = offset;
+    }
+    mpqemu_msg_send(&msg, sync->ioc, &local_err);
+    if (local_err) {
+        error_report("Error in sending command %d", msg.cmd);
+    }
+}
+
+void deconfigure_memory_sync(RemoteMemSync *sync)
+{
+    memory_listener_unregister(&sync->listener);
+
+    proxy_ml_begin(&sync->listener);
+}
+
+void configure_memory_sync(RemoteMemSync *sync, QIOChannel *ioc)
+{
+    sync->n_mr_sections = 0;
+    sync->mr_sections = NULL;
+
+    sync->ioc = ioc;
+
+    sync->listener.begin = proxy_ml_begin;
+    sync->listener.commit = proxy_ml_commit;
+    sync->listener.region_add = proxy_ml_region_addnop;
+    sync->listener.region_nop = proxy_ml_region_addnop;
+    sync->listener.priority = 10;
+
+    memory_listener_register(&sync->listener, &address_space_memory);
+}
diff --git a/hw/pci/meson.build b/hw/pci/meson.build
index 0df3017..7947a62 100644
--- a/hw/pci/meson.build
+++ b/hw/pci/meson.build
@@ -18,3 +18,5 @@ softmmu_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
 
 softmmu_ss.add(when: 'CONFIG_PCI', if_false: files('pci-stub.c'))
 softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('pci-stub.c'))
+
+specific_ss.add(when: 'CONFIG_MPQEMU', if_true: files('memory-sync.c'))
diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
index 4ae4919..908c82e 100644
--- a/hw/pci/proxy.c
+++ b/hw/pci/proxy.c
@@ -18,6 +18,8 @@
 #include "migration/blocker.h"
 #include "io/mpqemu-link.h"
 #include "qemu/error-report.h"
+#include "hw/pci/memory-sync.h"
+#include "qom/object.h"
 
 static void proxy_set_socket(PCIProxyDev *pdev, int fd, Error **errp)
 {
@@ -58,6 +60,8 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
 
     qemu_mutex_init(&dev->io_mutex);
     qio_channel_set_blocking(dev->ioc, true, NULL);
+
+    configure_memory_sync(&dev->sync, dev->ioc);
 }
 
 static void pci_proxy_dev_exit(PCIDevice *pdev)
@@ -69,6 +73,8 @@ static void pci_proxy_dev_exit(PCIDevice *pdev)
     migrate_del_blocker(dev->migration_blocker);
 
     error_free(dev->migration_blocker);
+
+    deconfigure_memory_sync(&dev->sync);
 }
 
 static int config_op_send(PCIProxyDev *pdev, uint32_t addr, uint32_t *val,
diff --git a/include/hw/pci/memory-sync.h b/include/hw/pci/memory-sync.h
new file mode 100644
index 0000000..785f76a
--- /dev/null
+++ b/include/hw/pci/memory-sync.h
@@ -0,0 +1,27 @@
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
+#include "exec/memory.h"
+#include "io/channel.h"
+
+typedef struct RemoteMemSync {
+    MemoryListener listener;
+
+    int n_mr_sections;
+    MemoryRegionSection *mr_sections;
+
+    QIOChannel *ioc;
+} RemoteMemSync;
+
+void configure_memory_sync(RemoteMemSync *sync, QIOChannel *ioc);
+void deconfigure_memory_sync(RemoteMemSync *sync);
+
+#endif
diff --git a/include/hw/pci/proxy.h b/include/hw/pci/proxy.h
index e29c61b..52f3c43 100644
--- a/include/hw/pci/proxy.h
+++ b/include/hw/pci/proxy.h
@@ -11,6 +11,7 @@
 
 #include "hw/pci/pci.h"
 #include "io/channel.h"
+#include "hw/pci/memory-sync.h"
 
 #define TYPE_PCI_PROXY_DEV "x-pci-proxy-dev"
 
@@ -40,6 +41,7 @@ struct PCIProxyDev {
     QemuMutex io_mutex;
     QIOChannel *ioc;
     Error *migration_blocker;
+    RemoteMemSync sync;
     ProxyMemoryRegion region[PCI_NUM_REGIONS];
 };
 
-- 
1.8.3.1


