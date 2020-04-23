Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F60C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:22:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FDB2075A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z1scR/QP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FDB2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRTND-0003mO-CK
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 00:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTGV-0000Yj-Mb
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:15:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTGU-0007MP-SB
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:15:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41470)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jRTGU-0007LQ-CY
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:15:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4CZbW131587;
 Thu, 23 Apr 2020 04:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=kvRaYlFgij7Zx+G0zUyfR0xz+W7+KI0hBo9ejXKifas=;
 b=Z1scR/QPJSJA1SFg2jFT1buIUL8hIfz6Rm18Xl4rkOHBpCigcqbxxUtDAnTWH5kkcDH0
 zow/Hdh5T80+a4ipqmp2B7+ty3S9GqqacPil8Zf+5GuIl5mzDaESmLSf3Ah2A5UpAuxI
 HzoR8JKJaCTQcP1KvUfKeVpvDI9h2sYX0sKGsubblAJFi55UfMYlMgjGcXAQRgfTvsd3
 Ivm4roLZC9+fXV/0t0xNjSFxlO0F0yvcZ1mrpGLPJdjnFNxvBDqjq81/0MnvcRVfwcSX
 WytG78BjCLS7AfqdA9sp6LMtmYiObaEPLB6EhgTo/e5jUZKPAZps9JEwNjZ/Ff0ctkbn LQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 30jvq4s8yw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:14:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4Bev4093656;
 Thu, 23 Apr 2020 04:14:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 30gb3ux0jm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:14:57 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03N4EsbX020226;
 Thu, 23 Apr 2020 04:14:54 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 22 Apr 2020 21:14:54 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v6 16/36] multi-process: remote process initialization
Date: Wed, 22 Apr 2020 21:13:51 -0700
Message-Id: <f80b49bb051b277c163b64551e92d5d9e8f6cb5a.1587614626.git.elena.ufimtseva@oracle.com>
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
 mlxlogscore=999 phishscore=0 suspectscore=3 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=3
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

Adds the handler to process message from QEMU,
Initialize remote process main loop, handles SYNC_SYSMEM
message by updating its "system_memory" container using
shared file descriptors received from QEMU.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 MAINTAINERS            |   1 +
 remote/remote-common.h |  21 +++++++++
 remote/remote-main.c   | 104 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+)
 create mode 100644 remote/remote-common.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 98237fff62..96f8d7ff19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2857,6 +2857,7 @@ M: John G Johnson <john.g.johnson@oracle.com>
 S: Maintained
 F: remote/Makefile.objs
 F: remote/remote-main.c
+F: remote/remote-common.h
 F: include/io/mpqemu-link.h
 F: io/mpqemu-link.c
 F: include/remote/pcihost.h
diff --git a/remote/remote-common.h b/remote/remote-common.h
new file mode 100644
index 0000000000..12c8d066cf
--- /dev/null
+++ b/remote/remote-common.h
@@ -0,0 +1,21 @@
+/*
+ * Remote device initialization
+ *
+ * Copyright © 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+#ifndef REMOTE_COMMON_H
+#define REMOTE_COMMON_H
+
+extern const char *__progname;
+
+#define PROC_INFO_LENGTH 1024
+gchar *print_pid_exec(gchar *str);
+
+#endif /* REMOTE_COMMON_H */
+
+
+
diff --git a/remote/remote-main.c b/remote/remote-main.c
index ecf30e0cba..dbd6ad2529 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -12,6 +12,7 @@
 #include "qemu-common.h"
 
 #include <stdio.h>
+#include <unistd.h>
 
 #include "qemu/module.h"
 #include "remote/pcihost.h"
@@ -19,12 +20,115 @@
 #include "hw/boards.h"
 #include "hw/qdev-core.h"
 #include "qemu/main-loop.h"
+#include "remote/memory.h"
+#include "io/mpqemu-link.h"
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
+#include "exec/ramlist.h"
+#include "remote/remote-common.h"
+
+static MPQemuLinkState *mpqemu_link;
+
+gchar *print_pid_exec(gchar *str)
+{
+    if (!str) {
+        return NULL;
+    }
+    memset(str, 0, PROC_INFO_LENGTH);
+    g_snprintf(str, PROC_INFO_LENGTH, "pid %d, exec name %s ",
+                                       getpid(), __progname);
+    return str;
+}
+
+static void process_msg(GIOCondition cond, MPQemuLinkState *link,
+                        MPQemuChannel *chan)
+{
+    MPQemuMsg *msg = NULL;
+    Error *err = NULL;
+    g_autofree gchar *pid_exec = NULL;
+
+    pid_exec = g_malloc(PROC_INFO_LENGTH);
+
+    if ((cond & G_IO_HUP) || (cond & G_IO_ERR)) {
+        goto finalize_loop;
+    }
+
+    msg = g_malloc0(sizeof(MPQemuMsg));
+
+    if (mpqemu_msg_recv(msg, chan) < 0) {
+        error_setg(&err, "Failed to receive message in remote process %s",
+                   print_pid_exec(pid_exec));
+        goto finalize_loop;
+    }
+
+    switch (msg->cmd) {
+    case INIT:
+        break;
+    default:
+        error_setg(&err, "Unknown command in %s", print_pid_exec(pid_exec));
+        goto finalize_loop;
+    }
+
+    g_free(msg->data2);
+    g_free(msg);
+
+    return;
+
+finalize_loop:
+    if (err) {
+        error_report_err(err);
+    }
+    g_free(msg);
+    mpqemu_link_finalize(mpqemu_link);
+    mpqemu_link = NULL;
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
+    qemu_mutex_init(&ram_list.mutex);
+
     current_machine = MACHINE(REMOTE_MACHINE(object_new(TYPE_REMOTE_MACHINE)));
 
+    mpqemu_link = mpqemu_link_create();
+    if (!mpqemu_link) {
+        printf("Could not create MPQemu link pid %d, exec_name %s",
+               getpid(), __progname);
+        return -1;
+    }
+
+    mpqemu_init_channel(mpqemu_link, &mpqemu_link->com, STDIN_FILENO);
+
+    mpqemu_link_set_callback(mpqemu_link, process_msg);
+
+    qdev_machine_creation_done();
+    qemu_mutex_lock_iothread();
+    qemu_run_machine_init_done_notifiers();
+    qemu_mutex_unlock_iothread();
+
+    mpqemu_start_coms(mpqemu_link, mpqemu_link->com);
+
     return 0;
 }
-- 
2.25.GIT


