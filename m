Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1480C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2CCD2084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B3QrbzRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CCD2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50942 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwLl-00085A-UY
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58601)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwAf-0005RG-Ue
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwAe-0001Wf-Am
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:15:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42840)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcwAd-0001VZ-V8
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:15:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI8n18149250;
 Mon, 17 Jun 2019 18:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=QsrM+NGtd26oRHAt0LAUHOmtyzzuZEKIkpyw1SF0fu0=;
 b=B3QrbzRRe5NYSPm30Lq26LPec0FkfJThinDssHrQcs6omlqpJWhRCrTANXSM8I/SL/ka
 Q3RATlnZwEfGPpbDI4His/nfPcMLAa2GzyKtuJKxOR/Rj54eSiOPGpTUdVccYMADUYbf
 ZXTO19RsQ3/xJlbBbnaF/KxJWnkldXQgtF3Xl8vqhQttBW63gmNZvawT3Zbun1Ql0IXX
 mZv1BAvRykP9BgbxKcdP9bUAIVpwVsEMLFUOs6vWrSpC666lxKYm7f0+YHzYtEAMIV2K
 uEhZeJ2kixyGM887t574Ctj21KkbkWIen/7IyBC4NFaKavrLPpZzVxjVudR7q3/NFfcd 6Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2t4r3tg2v8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:15:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIF5ud050139;
 Mon, 17 Jun 2019 18:15:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2t5h5t9ff7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:15:53 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5HIFqtF014697;
 Mon, 17 Jun 2019 18:15:52 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 11:15:52 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:15:49 -0700
Message-Id: <20190617181549.29631-1-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170162
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [RFC PATCH v2 11/35] multi-process: setup memory
 manager for remote device
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
Cc: elena.ufimtseva@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com,
 konrad.wilk@oracle.com, berrange@redhat.com, ross.lagerwall@citrix.com,
 liran.alon@oracle.com, stefanha@redhat.com, kanth.ghatraju@oracle.com
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
 Makefile.target         |  2 +
 include/io/proxy-link.h | 11 +++++
 include/remote/memory.h | 34 ++++++++++++++
 remote/memory.c         | 98 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 145 insertions(+)
 create mode 100644 include/remote/memory.h
 create mode 100644 remote/memory.c

diff --git a/Makefile.target b/Makefile.target
index f45af2b851..30e81ddb5a 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -133,6 +133,8 @@ remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/monitor.o
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/replay.o
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/xen-mapcache.o
 
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += remote/memory.o
+
 #########################################################
 # Linux user emulator target
 
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index 2f1584e87d..e9efe531ad 100644
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
 
@@ -74,6 +78,12 @@ typedef enum {
  * data2       Unstructured data
  *
  */
+typedef struct {
+    hwaddr gpas[REMOTE_MAX_FDS];
+    uint64_t sizes[REMOTE_MAX_FDS];
+    ram_addr_t offsets[REMOTE_MAX_FDS];
+} sync_sysmem_msg_t;
+
 typedef struct {
     proc_cmd_t cmd;
     int bytestream;
@@ -81,6 +91,7 @@ typedef struct {
 
     union {
         uint64_t u64;
+        sync_sysmem_msg_t sync_sysmem;
     } data1;
 
     int fds[REMOTE_MAX_FDS];
diff --git a/include/remote/memory.h b/include/remote/memory.h
new file mode 100644
index 0000000000..0ffbca0145
--- /dev/null
+++ b/include/remote/memory.h
@@ -0,0 +1,34 @@
+/*
+ * Memory manager for remote device
+ *
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
index 0000000000..69a0ee8c6a
--- /dev/null
+++ b/remote/memory.c
@@ -0,0 +1,98 @@
+/*
+ * Memory manager for remote device
+ *
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
2.17.1


