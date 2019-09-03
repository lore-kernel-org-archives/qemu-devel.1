Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC59C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:13:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9810F21897
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jkTo93Tv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9810F21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5G7N-0005Hk-8G
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5FaG-0007up-Bu
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FaD-0000g8-CJ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57360)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FaD-0000fV-5c
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KXg2r053293;
 Tue, 3 Sep 2019 20:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=CjgjKQc9jVi+jktzR6sSVT0CFuUT9GdnskHc4Tlo9ew=;
 b=jkTo93TvytrK/wKQCPN/mfEiKEuGRAVJ4Dicuw7+bYL0c+x68lTnGCrtsLbYTm8h+Xu+
 +f/ak5QOfBqqnAkwLJFN522Gld5Msts6YMgSSjxnSYI7zgqTfCBMNyIY1oo9ptu7qJC/
 nQwOi7/HH7tiLX+VNeH3p1V+yYc8xWQ5CVxify7QNmM2bpjTx1Xc2iOk6h4XtmzwTNCo
 +BLzZdj+aeedHRr9hj/k8VDGJQ0YYWbep+za8QO+9f2QGs7nEjx8P6ixJGr7vQfaKq/r
 cc8cptcEf2vNoIfe1QPcFraxV4uTbtABk0nvIIlDDKWCRhEasM/oPvphD4qCPZFo+hif Ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2usy6n021p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KcIq2094766;
 Tue, 3 Sep 2019 20:39:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2usu51u25q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:15 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x83KdECr028877;
 Tue, 3 Sep 2019 20:39:14 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:39:13 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:37:58 -0400
Message-Id: <0ea30ed1342457c717123a4e164dfd7e8582998a.1567534653.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030207
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030206
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [RFC v3 PATCH 32/45] multi-process: add parse_cmdline
 in remote process
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

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 New patch in v3

 remote/Makefile.objs |   1 +
 remote/remote-main.c |  11 +++++
 remote/remote-opts.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++++++
 remote/remote-opts.h |  31 ++++++++++++++
 4 files changed, 156 insertions(+)
 create mode 100644 remote/remote-opts.c
 create mode 100644 remote/remote-opts.h

diff --git a/remote/Makefile.objs b/remote/Makefile.objs
index c1349ad..a677fce 100644
--- a/remote/Makefile.objs
+++ b/remote/Makefile.objs
@@ -1,4 +1,5 @@
 remote-pci-obj-$(CONFIG_MPQEMU) += remote-main.o
+remote-pci-obj-$(CONFIG_MPQEMU) += remote-opts.o
 remote-pci-obj-$(CONFIG_MPQEMU) += pcihost.o
 remote-pci-obj-$(CONFIG_MPQEMU) += machine.o
 remote-pci-obj-$(CONFIG_MPQEMU) += iohub.o
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 0c0e085..416b8a1 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -64,6 +64,7 @@
 #include "qapi/qmp/qlist.h"
 #include "qemu/log.h"
 #include "qemu/cutils.h"
+#include "remote-opts.h"
 
 static ProxyLinkState *proxy_link;
 PCIDevice *remote_pci_dev;
@@ -468,6 +469,13 @@ int main(int argc, char *argv[])
 
     current_machine = MACHINE(REMOTE_MACHINE(object_new(TYPE_REMOTE_MACHINE)));
 
+    qemu_add_opts(&qemu_device_opts);
+    qemu_add_opts(&qemu_drive_opts);
+    qemu_add_drive_opts(&qemu_legacy_drive_opts);
+    qemu_add_drive_opts(&qemu_common_drive_opts);
+    qemu_add_drive_opts(&qemu_drive_opts);
+    qemu_add_drive_opts(&bdrv_runtime_opts);
+
     proxy_link = proxy_link_create();
     if (!proxy_link) {
         printf("Could not create proxy link\n");
@@ -481,6 +489,9 @@ int main(int argc, char *argv[])
     }
 
     proxy_link_init_channel(proxy_link, &proxy_link->com, fd);
+
+    parse_cmdline(argc - 2, argv + 2, NULL);
+
     proxy_link_set_callback(proxy_link, process_msg);
 
     start_handler(proxy_link);
diff --git a/remote/remote-opts.c b/remote/remote-opts.c
new file mode 100644
index 0000000..416ff59
--- /dev/null
+++ b/remote/remote-opts.c
@@ -0,0 +1,113 @@
+/*
+ * Remote device initialization
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
+#include <stdio.h>
+#include <glib.h>
+#include <unistd.h>
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu-common.h"
+
+#include "remote/pcihost.h"
+#include "remote/machine.h"
+#include "hw/boards.h"
+#include "hw/qdev-core.h"
+#include "qemu/main-loop.h"
+#include "remote/memory.h"
+#include "io/proxy-link.h"
+#include "qapi/error.h"
+#include "qemu-options.h"
+#include "sysemu/arch_init.h"
+
+#include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qobject.h"
+#include "qemu/option.h"
+#include "qemu/config-file.h"
+#include "monitor/qdev.h"
+#include "qapi/qmp/qdict.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/blockdev.h"
+#include "block/block.h"
+#include "remote/remote-opts.h"
+#include "include/qemu-common.h"
+
+#include "vl.h"
+/*
+ * In remote process, we parse only subset of options. The code
+ * taken from vl.c to re-use in remote command line parser.
+ */
+void parse_cmdline(int argc, char **argv, char **envp)
+{
+    int optind;
+    const char *optarg;
+    MachineClass *mc;
+
+    /* from vl.c */
+    optind = 0;
+
+    /* second pass of option parsing */
+
+    for (;;) {
+        if (optind >= argc) {
+            break;
+        }
+        if (argv[optind][0] != '-') {
+            loc_set_cmdline(argv, optind, 1);
+            drive_add(IF_DEFAULT, 0, argv[optind++], HD_OPTS);
+        } else {
+            const QEMUOption *popt;
+
+            popt = lookup_opt(argc, argv, &optarg, &optind);
+            #ifndef REMOTE_PROCESS
+            if (!(popt->arch_mask & arch_type)) {
+                error_report("Option not supported for this target, %x arch_mask, %x arch_type",
+                             popt->arch_mask, arch_type);
+                exit(1);
+            }
+            #endif
+            switch (popt->index) {
+            case QEMU_OPTION_drive:
+                if (drive_def(optarg) == NULL) {
+                    fprintf(stderr, "Could not init drive\n");
+                    exit(1);
+                }
+                break;
+            default:
+                break;
+            }
+        }
+    }
+    mc = MACHINE_GET_CLASS(current_machine);
+
+    mc->block_default_type = IF_IDE;
+    if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
+                          &mc->block_default_type, &error_fatal)) {
+        /* We printed help */
+        exit(0);
+    }
+
+    return;
+}
diff --git a/remote/remote-opts.h b/remote/remote-opts.h
new file mode 100644
index 0000000..e15c29b
--- /dev/null
+++ b/remote/remote-opts.h
@@ -0,0 +1,31 @@
+/*
+ * Remote device initialization
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
+#ifndef REMOTE_OPTS_H
+#define REMOTE_OPTS_H
+
+void parse_cmdline(int argc, char **argv, char **envp);
+
+#endif
+
-- 
1.8.3.1


