Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB514C55191
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A65692075A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iS1BRaJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65692075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRTN8-0003ZO-Pp
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 00:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTGQ-0000RB-OH
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:15:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTGP-0007EI-PR
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:15:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38900)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jRTGP-0007BJ-3x
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:15:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4DR95052417;
 Thu, 23 Apr 2020 04:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=nIk13E4+qeubC8FEj4ST8gA+voZ5HEM1QjFAcIh6j3g=;
 b=iS1BRaJZGZq5Vm1rx3svsw7rVHh0yhqil64UWnVxnDmpY0gSClFvblbkdDlpv22jFjy+
 O0EBeb5WdHJyz4JOcmB9CK4kXyTL60sH1s5DEET7lwL/eSDnX0eq5L47T5Wskfa7DAYR
 FFltYAxW2ib9VvAMxHEdu4s+wFb/XJv1dIS2ChlrTc15wzc6Tnt2M1b5gSANNiPJZeHV
 dMhGQZuhB4WHhionuVlqdUbnsqe7hWMXDHSV/ohawFZ2NKUER5qACgAsviMyTX5lrGu4
 0nA1hH5OG+0RFS+H5/dSuOTNTWAmy51XwpDiduVjeljzDYrymDQ6zHwsoVqpa9FK1D/R JQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 30jhyc542j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:14:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4BepD093655;
 Thu, 23 Apr 2020 04:14:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 30gb3ux0h8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:14:53 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03N4EqJG017757;
 Thu, 23 Apr 2020 04:14:52 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 22 Apr 2020 21:14:52 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v6 15/36] multi-process: setup memory manager for
 remote device
Date: Wed, 22 Apr 2020 21:13:50 -0700
Message-Id: <c16682b1ac3a660d8b5b751b6d5f904a25d17dc4.1587614626.git.elena.ufimtseva@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 mlxscore=0
 clxscore=1015 suspectscore=4 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 00:14:40
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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

sync_sysmem_msg_t message format is defined. It is used to send
file descriptors of the RAM regions to remote device.
RAM on the remote device is configured with a set of file descriptors.
Old RAM regions are deleted and new regions, each with an fd, is
added to the RAM.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 MAINTAINERS              |  2 ++
 Makefile.target          |  2 ++
 exec.c                   | 17 +++++++++++
 include/exec/ram_addr.h  |  2 ++
 include/io/mpqemu-link.h | 12 ++++++++
 include/remote/memory.h  | 20 +++++++++++++
 io/mpqemu-link.c         | 13 +++++++++
 remote/memory.c          | 63 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 131 insertions(+)
 create mode 100644 include/remote/memory.h
 create mode 100644 remote/memory.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 09764e461c..98237fff62 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2863,6 +2863,8 @@ F: include/remote/pcihost.h
 F: remote/pcihost.c
 F: include/remote/machine.h
 F: remote/machine.c
+F: include/remote/memory.h
+F: remote/memory.c
 
 Build and test automation
 -------------------------
diff --git a/Makefile.target b/Makefile.target
index 70fa1eeca5..500fa07fda 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -143,6 +143,8 @@ remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/replay.o
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/xen-mapcache.o
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/audio.o
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/monitor.o
+
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += remote/memory.o
 endif
 
 #########################################################
diff --git a/exec.c b/exec.c
index 5b1e414099..1e02e00f00 100644
--- a/exec.c
+++ b/exec.c
@@ -2371,6 +2371,23 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
 
     return block;
 }
+
+void qemu_ram_init_from_fd(MemoryRegion *mr, int fd, uint64_t size,
+                           ram_addr_t offset, Error **errp)
+{
+    char *name = g_strdup_printf("%d", fd);
+
+    memory_region_init(mr, NULL, name, size);
+    mr->ram = true;
+    mr->terminates = true;
+    mr->destructor = NULL;
+    mr->align = 0;
+    mr->ram_block = qemu_ram_alloc_from_fd(size, mr, RAM_SHARED, fd, offset,
+                                           errp);
+    mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
+
+    g_free(name);
+}
 #endif
 
 static
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 1b9f489ff0..d9d7314f51 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -122,6 +122,8 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
 RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
                                  uint32_t ram_flags, int fd,
                                  off_t offset, Error **errp);
+void qemu_ram_init_from_fd(MemoryRegion *mr, int fd, uint64_t size,
+                           ram_addr_t offset, Error **errp);
 
 RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
                                   MemoryRegion *mr, Error **errp);
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index ef95599bca..d46cb81058 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -16,6 +16,8 @@
 
 #include "qom/object.h"
 #include "qemu/thread.h"
+#include "exec/cpu-common.h"
+#include "exec/hwaddr.h"
 
 #define TYPE_MPQEMU_LINK "mpqemu-link"
 #define MPQEMU_LINK(obj) \
@@ -27,15 +29,23 @@
 
 /**
  * mpqemu_cmd_t:
+ * SYNC_SYSMEM      Shares QEMU's RAM with remote device's RAM
  *
  * proc_cmd_t enum type to specify the command to be executed on the remote
  * device.
  */
 typedef enum {
     INIT = 0,
+    SYNC_SYSMEM,
     MAX,
 } mpqemu_cmd_t;
 
+typedef struct {
+    hwaddr gpas[REMOTE_MAX_FDS];
+    uint64_t sizes[REMOTE_MAX_FDS];
+    ram_addr_t offsets[REMOTE_MAX_FDS];
+} sync_sysmem_msg_t;
+
 /**
  * MPQemuMsg:
  * @cmd: The remote command
@@ -49,6 +59,7 @@ typedef enum {
  * MPQemuMsg Format of the message sent to the remote device from QEMU.
  *
  */
+
 typedef struct {
     mpqemu_cmd_t cmd;
     int bytestream;
@@ -56,6 +67,7 @@ typedef struct {
 
     union {
         uint64_t u64;
+        sync_sysmem_msg_t sync_sysmem;
     } data1;
 
     int fds[REMOTE_MAX_FDS];
diff --git a/include/remote/memory.h b/include/remote/memory.h
new file mode 100644
index 0000000000..e2e479bb6f
--- /dev/null
+++ b/include/remote/memory.h
@@ -0,0 +1,20 @@
+/*
+ * Memory manager for remote device
+ *
+ * Copyright © 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef REMOTE_MEMORY_H
+#define REMOTE_MEMORY_H
+
+#include "qemu/osdep.h"
+#include "exec/hwaddr.h"
+#include "io/mpqemu-link.h"
+
+void remote_sysmem_reconfig(MPQemuMsg *msg, Error **errp);
+
+#endif
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index cc0a7aecd4..3f81cef96e 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -368,6 +368,19 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
             }
         }
     }
+     /* Verify message specific fields. */
+    switch (msg->cmd) {
+    case SYNC_SYSMEM:
+        if (msg->num_fds == 0 || msg->bytestream != 0) {
+            return false;
+        }
+        if (msg->size != sizeof(msg->data1)) {
+            return false;
+        }
+        break;
+    default:
+        break;
+    }
 
     return true;
 }
diff --git a/remote/memory.c b/remote/memory.c
new file mode 100644
index 0000000000..2c8b7bb42f
--- /dev/null
+++ b/remote/memory.c
@@ -0,0 +1,63 @@
+/*
+ * Memory manager for remote device
+ *
+ * Copyright © 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
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
+#include "io/mpqemu-link.h"
+#include "qemu/main-loop.h"
+#include "qapi/error.h"
+
+void remote_sysmem_reconfig(MPQemuMsg *msg, Error **errp)
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
+            qemu_ram_free(subregion->ram_block);
+        }
+    }
+
+    for (region = 0; region < msg->num_fds; region++) {
+        subregion = g_new(MemoryRegion, 1);
+        qemu_ram_init_from_fd(subregion, msg->fds[region],
+                              sysmem_info->sizes[region],
+                              sysmem_info->offsets[region], &local_err);
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
2.25.GIT


