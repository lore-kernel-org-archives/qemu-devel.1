Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540FBC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:30:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5872084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pHAs9uce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5872084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50960 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwOd-0002UX-C0
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58753)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwB5-0005Yu-Bv
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwB1-0001ps-72
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55746)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcwAy-0001lC-VM
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI9xFw159764;
 Mon, 17 Jun 2019 18:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=KM7t1jnu/GE3MIwd7uWHaGuh95c2hTbDnVcnU4+bpKw=;
 b=pHAs9uceKgmjE8mL46W4SWZ7Ey2kv/FoXP4CIKGSpm/O/hpjk1PKaBO6dYyET3kqTirJ
 DOaF4NaFtGMQV0i1vi21Ge1Wo0p9a6jLFQmeKVI8eCKUQLN9Q0UjFwzxblk5SfKPLmzk
 QyED7yFnHmx9EivL3igtdy+Xb31PmcESF3ydGiN/nQA/pmZC+lJ0pUHvmgNNFF5OawMd
 EZ8B7e+x3ptCuQaUlYtk616QuhFh7z/YaFkdaD/nGOUDpO7zAR9PwuOOc+yuGRANXZZc
 bHtlVjez1/vsu6rTXVbDvRMrnQbzvpQxWxF4Sb4eyhh+Oa5CRKlSw9LsQJldWJE6pMld nQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2t4saq7yf4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIEO0F175390;
 Mon, 17 Jun 2019 18:16:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2t5mgbgat6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:09 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5HIFtSp032037;
 Mon, 17 Jun 2019 18:15:55 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 11:15:55 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:15:53 -0700
Message-Id: <20190617181553.29677-1-elena.ufimtseva@oracle.com>
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
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170162
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [RFC PATCH v2 12/35] multi-process: remote process
 initialization
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
 konrad.wilk@oracle.com, ross.lagerwall@citrix.com, liran.alon@oracle.com,
 stefanha@redhat.com, kanth.ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jagannathan Raman <jag.raman@oracle.com>

Adds the handler to process message from QEMU,
Initialize remote process main loop, handles SYNC_SYSMEM
message by updating its "system_memory" container using
shared file descriptors received from QEMU.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 Changes in v2:
 - Separate thread for message processing is removed.
---
 remote/remote-main.c | 81 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/remote/remote-main.c b/remote/remote-main.c
index 97dd8327a2..f36483b3ae 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -23,6 +23,8 @@
  */
 
 #include <stdio.h>
+#include <glib.h>
+#include <unistd.h>
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
@@ -31,12 +33,91 @@
 #include "hw/boards.h"
 #include "hw/qdev-core.h"
 #include "qemu/main-loop.h"
+#include "remote/memory.h"
+#include "io/proxy-link.h"
+#include "qapi/error.h"
+#include "qemu/main-loop.h"
+#include "sysemu/cpus.h"
+#include "qemu-common.h"
+#include "hw/pci/pci.h"
+#include "qemu/thread.h"
+#include "qemu/main-loop.h"
+#include "qemu/config-file.h"
+#include "sysemu/sysemu.h"
+#include "block/block.h"
+
+static ProxyLinkState *proxy_link;
+PCIDevice *remote_pci_dev;
+
+static void process_msg(GIOCondition cond)
+{
+    ProcMsg *msg = NULL;
+    Error *err = NULL;
+
+    if ((cond & G_IO_HUP) || (cond & G_IO_ERR)) {
+        error_setg(&err, "socket closed, cond is %d", cond);
+        goto finalize_loop;
+    }
+
+    msg = g_malloc0(sizeof(ProcMsg));
+
+    if (proxy_proc_recv(proxy_link, msg) < 0) {
+        error_setg(&err, "Failed to receive message");
+        goto finalize_loop;
+    }
+
+    switch (msg->cmd) {
+    case INIT:
+        break;
+    case CONF_WRITE:
+        break;
+    case CONF_READ:
+        break;
+    default:
+        error_setg(&err, "Unknown command");
+        goto finalize_loop;
+    }
+
+    g_free(msg);
+
+    return;
+
+finalize_loop:
+    error_report_err(err);
+    g_free(msg);
+    proxy_link_finalize(proxy_link);
+    proxy_link = NULL;
+}
 
 int main(int argc, char *argv[])
 {
+    Error *err = NULL;
+
     module_call_init(MODULE_INIT_QOM);
 
+    bdrv_init_with_whitelist();
+
+    if (qemu_init_main_loop(&err)) {
+        error_report_err(err);
+        return -EBUSY;
+    }
+
+    qemu_init_cpu_loop();
+
+    page_size_init();
+
     current_machine = MACHINE(REMOTE_MACHINE(object_new(TYPE_REMOTE_MACHINE)));
 
+    proxy_link = proxy_link_create();
+    if (!proxy_link) {
+        printf("Could not create proxy link\n");
+        return -1;
+    }
+
+    proxy_link_set_sock(proxy_link, STDIN_FILENO);
+    proxy_link_set_callback(proxy_link, process_msg);
+
+    start_handler(proxy_link);
+
     return 0;
 }
-- 
2.17.1


