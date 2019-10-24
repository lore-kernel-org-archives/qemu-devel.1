Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045C7CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:03:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C56C52166E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QyFxe7Ky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56C52166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZxn-0002ND-6C
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZBD-0004ij-L0
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:13:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZBB-0005ka-Jk
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:13:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47760)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZBB-0005k2-9D
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:13:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94TXq116427;
 Thu, 24 Oct 2019 09:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=+IofknBIwPgPORHY2P8DEFy8k8iedsHT13hsizFpthU=;
 b=QyFxe7KyNNRUOU+NmwAiF0WjCwtVDYquUWYmHkMHpijeCk0hbqtmZv9JCirtCrP6t6iA
 idnERzimuiuU11eNPOc7fKnSaORH91YApszhQp0c4wXWf6XGMqUjDMOhFjRFC6gllrf2
 M9fCdOGcuQaZMrCFp256kndGP6NoYaLU6si0S0B0cktnKSyf3wI1TweDwUtJ8OWZ3WCg
 QqtXapgtuDzJLnFBn/ogv9bE2tgoN0DH/2CMEudwNB5PLAnLijDxzBgNQFgdWAPpd5Iy
 I8ka0VlzFJEdd8K1qu+lZC9SV0Q4k/QTdyXwfJhkumwz6qYBMA+XsZO4mnziA4a5P5YH 3A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2vqswttebd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:13:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O991ZB077488;
 Thu, 24 Oct 2019 09:11:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2vtjkj2yaa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:11:06 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9O9B4CX009509;
 Thu, 24 Oct 2019 09:11:04 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:11:04 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 29/49] multi-process: add parse_cmdline in remote
 process
Date: Thu, 24 Oct 2019 05:09:10 -0400
Message-Id: <57a23f03088dd5036cf432737ee11229a6ea9644.1571905346.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
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

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 New patch in v3

 remote/Makefile.objs |   1 +
 remote/remote-main.c |  11 +++++
 remote/remote-opts.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++
 remote/remote-opts.h |  31 ++++++++++++++
 4 files changed, 158 insertions(+)
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
index 80d8c02..729f7e9 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -65,6 +65,7 @@
 #include "qapi/qmp/qlist.h"
 #include "qemu/log.h"
 #include "qemu/cutils.h"
+#include "remote-opts.h"
 
 static MPQemuLinkState *mpqemu_link;
 PCIDevice *remote_pci_dev;
@@ -469,6 +470,13 @@ int main(int argc, char *argv[])
 
     current_machine = MACHINE(REMOTE_MACHINE(object_new(TYPE_REMOTE_MACHINE)));
 
+    qemu_add_opts(&qemu_device_opts);
+    qemu_add_opts(&qemu_drive_opts);
+    qemu_add_drive_opts(&qemu_legacy_drive_opts);
+    qemu_add_drive_opts(&qemu_common_drive_opts);
+    qemu_add_drive_opts(&qemu_drive_opts);
+    qemu_add_drive_opts(&bdrv_runtime_opts);
+
     mpqemu_link = mpqemu_link_create();
     if (!mpqemu_link) {
         printf("Could not create MPQemu link\n");
@@ -482,6 +490,9 @@ int main(int argc, char *argv[])
     }
 
     mpqemu_init_channel(mpqemu_link, &mpqemu_link->com, fd);
+
+    parse_cmdline(argc - 2, argv + 2, NULL);
+
     mpqemu_link_set_callback(mpqemu_link, process_msg);
 
     mpqemu_start_coms(mpqemu_link);
diff --git a/remote/remote-opts.c b/remote/remote-opts.c
new file mode 100644
index 0000000..0ebe6b1
--- /dev/null
+++ b/remote/remote-opts.c
@@ -0,0 +1,115 @@
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
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+#include <stdio.h>
+#include <unistd.h>
+
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
+#include "io/mpqemu-link.h"
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


