Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52CDC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:30:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B40A32084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YPFJ+F4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40A32084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50962 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwOo-0002jD-1H
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58842)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwBR-0005bh-Hx
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwBO-00022W-Ky
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57348)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcwBN-0001vU-Nv
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI8krm065843;
 Mon, 17 Jun 2019 18:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=LnCxHUpKKe53qjka/nW/IVl2C48b5NGyGGM3Oe5vEt4=;
 b=YPFJ+F4D1bgBa5kb34ZvfznjtbPEE0hfJUDU1OUy7slKVnkydJgZ0DqtMsgP5e6oJXfm
 nX8yUOi5Y/rSlMgE7X0iP/ivsq9vcWCdnzbMO7EIgtSTiImNTcXwQUDo3w3gIq2cHKVG
 WSWVOHfwQzmwyjS+8kQIsuxW19JwliahcLyv361btNcok6eO/GGJqQwFmKCdbI+p9tfn
 Uh2ON5+COazYuO16sVaZgrCqQQMLrZRTohNYdTvOlegSqVmdBl7+n62w4jW++D7mIYiB
 vCRYaYUqU5F17erKSk71q2WG+e9z82KOiXSo3NsbzBYkvhFe2gEQRMmIwbEYO3LP6NPU nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2t4rmp00np-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIGPtX181181;
 Mon, 17 Jun 2019 18:16:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2t5mgbgayk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:25 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5HIGNsr025209;
 Mon, 17 Jun 2019 18:16:23 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 11:16:22 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:16:20 -0700
Message-Id: <20190617181620.30047-1-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170162
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [RFC PATCH v2 20/35] multi-process: Add QMP & extend
 HMP commands to list remote info
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
 konrad.wilk@oracle.com, dgilbert@redhat.com, armbru@redhat.com,
 ross.lagerwall@citrix.com, liran.alon@oracle.com, stefanha@redhat.com,
 kanth.ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jagannathan Raman <jag.raman@oracle.com>

Add query-remote QMP command and extend "info" HMP command, to list
the remote objects used by QEMU.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 hmp-commands-info.hx          | 16 +++++++
 hmp.h                         |  1 +
 hw/proxy/Makefile.objs        |  1 +
 hw/proxy/monitor.c            | 88 +++++++++++++++++++++++++++++++++++
 include/hw/proxy/qemu-proxy.h |  1 +
 qapi/block-core.json          | 29 ++++++++++++
 6 files changed, 136 insertions(+)
 create mode 100644 hw/proxy/monitor.c

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index c59444c461..b145e755eb 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -932,6 +932,22 @@ STEXI
 Show SEV information.
 ETEXI
 
+#if defined(CONFIG_MPQEMU)
+    {
+        .name       = "remote",
+        .args_type  = "",
+        .params     = "",
+        .help       = "list remote objects",
+        .cmd        = hmp_info_remote,
+    },
+
+STEXI
+@item remote
+@findex remote
+list remote objects.
+ETEXI
+#endif
+
 STEXI
 @end table
 ETEXI
diff --git a/hmp.h b/hmp.h
index 43617f2646..6919f99218 100644
--- a/hmp.h
+++ b/hmp.h
@@ -150,5 +150,6 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
 void hmp_info_sev(Monitor *mon, const QDict *qdict);
+void hmp_info_remote(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/hw/proxy/Makefile.objs b/hw/proxy/Makefile.objs
index f562f5a0e9..e6420602b8 100644
--- a/hw/proxy/Makefile.objs
+++ b/hw/proxy/Makefile.objs
@@ -1,2 +1,3 @@
 common-obj-$(CONFIG_MPQEMU) += qemu-proxy.o
 common-obj-$(CONFIG_MPQEMU) += proxy-lsi53c895a.o
+common-obj-$(CONFIG_MPQEMU) += monitor.o
diff --git a/hw/proxy/monitor.c b/hw/proxy/monitor.c
new file mode 100644
index 0000000000..694f34a446
--- /dev/null
+++ b/hw/proxy/monitor.c
@@ -0,0 +1,88 @@
+/*
+ * QEMU monitor command handler for multi-process QEMU
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
+#include <sys/types.h>
+
+#include "qemu/osdep.h"
+#include "qapi/qapi-types-block-core.h"
+#include "qapi/qapi-commands-block-core.h"
+#include "monitor/monitor.h"
+#include "qemu/option.h"
+#include "hmp.h"
+#include "hw/boards.h"
+#include "hw/proxy/qemu-proxy.h"
+
+/*
+ * TODO: Is there a callback where the allocated memory for QMP could be free'd
+ */
+RemoteProcList *qmp_query_remote(Error **errp)
+{
+    MachineState *ms = MACHINE(current_machine);
+    RemoteProcList *proclist, *proc;
+    GHashTableIter itr;
+    PCIProxyDev *pdev;
+    PCIProxyDevClass *k;
+    DeviceState *d;
+    char *id;
+
+    proclist = NULL;
+
+    g_hash_table_iter_init(&itr, ms->remote_devs);
+
+    while (g_hash_table_iter_next(&itr, (gpointer *)&id, (gpointer *)&pdev)) {
+        k = PCI_PROXY_DEV_GET_CLASS(pdev);
+        d = DEVICE(pdev);
+
+        proc = g_malloc0(sizeof(RemoteProcList));
+        proc->next = proclist;
+        proclist = proc;
+        proc->value = g_malloc0(sizeof(RemoteProc));
+        proc->value->pid = pdev->remote_pid;
+        proc->value->id = g_strdup(d->id);
+        proc->value->proc = g_strdup(k->command);
+    }
+
+    return proclist;
+}
+
+void hmp_info_remote(Monitor *mon, const QDict *qdict)
+{
+    MachineState *ms = MACHINE(current_machine);
+    GHashTableIter itr;
+    PCIProxyDev *pdev;
+    PCIProxyDevClass *k;
+    char *id;
+
+    g_hash_table_iter_init(&itr, ms->remote_devs);
+
+    monitor_printf(mon, "%8.8s\t%16.16s\t%16.16s\t%16.16s\n\n", "PID", "RID",
+                   "QEMU ID", "PROCESS NAME");
+
+    while (g_hash_table_iter_next(&itr, (gpointer *)&id, (gpointer *)&pdev)) {
+        k = PCI_PROXY_DEV_GET_CLASS(pdev);
+
+        monitor_printf(mon, "%8.8d\t%16.16s\t%16.16s\t%16.16s\n",
+                       pdev->remote_pid, pdev->rid, id, k->command);
+    }
+}
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index c27817f780..b73077940c 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -27,6 +27,7 @@
 
 #include "io/proxy-link.h"
 #include "hw/proxy/memory-sync.h"
+#include "hw/pci/pci.h"
 #include "qemu/event_notifier.h"
 
 #define TYPE_PCI_PROXY_DEV "pci-proxy-dev"
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7ccbfff9d0..6a0bfe26a2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -673,6 +673,23 @@
            '*tray_open': 'bool', '*io-status': 'BlockDeviceIoStatus',
            '*dirty-bitmaps': ['BlockDirtyInfo'] } }
 
+##
+# @RemoteProc:
+#
+# Remote process information.
+#
+# @id: Device ID
+#
+# @pid: Linux Process ID
+#
+# @proc: Process name
+#
+# Since:  3.0.93
+##
+{ 'struct': 'RemoteProc',
+  'data': {'id': 'str', 'pid': 'int32', 'proc': 'str' },
+  'if': 'defined(CONFIG_MPQEMU)' }
+
 ##
 # @BlockMeasureInfo:
 #
@@ -795,6 +812,18 @@
 ##
 { 'command': 'query-block', 'returns': ['BlockInfo'] }
 
+##
+# @query-remote:
+#
+# Get a list of all the remote processes spawned by QEMU.
+#
+# Returns: a list of @RemoteProc describing each remote process.
+#
+# Since: 3.0.93
+#
+##
+{ 'command': 'query-remote', 'returns': ['RemoteProc'],
+  'if': 'defined(CONFIG_MPQEMU)' }
 
 ##
 # @BlockDeviceTimedStats:
-- 
2.17.1


