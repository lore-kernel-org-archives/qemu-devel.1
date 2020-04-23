Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C396C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:35:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D79E72071C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C53Y/ARd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79E72071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRTaN-0006iz-WE
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 00:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTIn-0004Dv-2a
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:17:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTIh-0003TN-70
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:17:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56328)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jRTIg-0003PA-M3
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:17:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4DllR064853;
 Thu, 23 Apr 2020 04:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=BucCYww44p6SLurPbL7Kdwbt/1HzLKuWIEXFLyLo7TM=;
 b=C53Y/ARd2pbGznCbPjh/kl79sgLaJD68WrZVzR5AiSB3Jv5ezpeq7t4OF4vLIwaiO7yL
 +wRPOgBfw2H3iSecn72ZuJpHqmtEBlFSsck3B5yM3SI5+Qx/wXTquawvM81sgUMHRW0R
 3Cv8FPWsQnpLqZPoc6OyvqIw7VlljotY5Q/xAN0CtNUj9WNGqOKes3Y6tbqUetBkov1H
 jAjXoeV/5lSW7MDuvSeCFVg3OxNS0Ulxb5jR1AX3YSlv/ZVq5p/S9tzfaFrB3ZzZSKTd
 ipo4jeg92m4IQKXOFis8kvHoN1KoPYjpYsOGQB40JKWf9f6t56x8Ulzf+Em8i9tAxW/u OQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 30grpgtry7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:17:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4CJOq089474;
 Thu, 23 Apr 2020 04:15:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 30gb1ku8bw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:15:13 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03N4FC3L020399;
 Thu, 23 Apr 2020 04:15:12 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 22 Apr 2020 21:15:12 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v6 26/36] multi-process: add parse_cmdline in remote
 process
Date: Wed, 22 Apr 2020 21:14:01 -0700
Message-Id: <b756b466c52405f12b24443adb8765946858cda2.1587614626.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1587614626.git.elena.ufimtseva@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=1 spamscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=1 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 00:14:28
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 MAINTAINERS          |  2 ++
 remote/Makefile.objs |  1 +
 remote/remote-main.c | 21 ++++++++++++-
 remote/remote-opts.c | 75 ++++++++++++++++++++++++++++++++++++++++++++
 remote/remote-opts.h | 15 +++++++++
 5 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 remote/remote-opts.c
 create mode 100644 remote/remote-opts.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 198c9f69bc..6a4b5e16be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2873,6 +2873,8 @@ F: include/hw/proxy/memory-sync.h
 F: hw/proxy/memory-sync.c
 F: include/remote/iohub.h
 F: remote/iohub.c
+F: remote/remote-opts.h
+F: remote/remote-opts.c
 
 Build and test automation
 -------------------------
diff --git a/remote/Makefile.objs b/remote/Makefile.objs
index ed3e5bd8c4..74c3396786 100644
--- a/remote/Makefile.objs
+++ b/remote/Makefile.objs
@@ -1,4 +1,5 @@
 remote-pci-obj-$(CONFIG_MPQEMU) += remote-main.o
+remote-pci-obj-$(CONFIG_MPQEMU) += remote-opts.o
 remote-pci-obj-$(CONFIG_MPQEMU) += pcihost.o
 remote-pci-obj-$(CONFIG_MPQEMU) += machine.o
 remote-pci-obj-$(CONFIG_MPQEMU) += ../util/machine-notify.o
diff --git a/remote/remote-main.c b/remote/remote-main.c
index f5a479e9b2..b37802151a 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -24,6 +24,7 @@
 #include "io/mpqemu-link.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
+#include "qemu/cutils.h"
 #include "sysemu/cpus.h"
 #include "qemu-common.h"
 #include "hw/pci/pci.h"
@@ -37,6 +38,7 @@
 #include "exec/memattrs.h"
 #include "exec/address-spaces.h"
 #include "remote/iohub.h"
+#include "remote-opts.h"
 
 static void process_msg(GIOCondition cond, MPQemuLinkState *link,
                         MPQemuChannel *chan);
@@ -289,6 +291,7 @@ finalize_loop:
 int main(int argc, char *argv[])
 {
     Error *err = NULL;
+    int fd = -1;
 
     module_call_init(MODULE_INIT_QOM);
 
@@ -307,6 +310,13 @@ int main(int argc, char *argv[])
 
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
         printf("Could not create MPQemu link pid %d, exec_name %s",
@@ -314,7 +324,16 @@ int main(int argc, char *argv[])
         return -1;
     }
 
-    mpqemu_init_channel(mpqemu_link, &mpqemu_link->com, STDIN_FILENO);
+    fd = qemu_parse_fd(argv[1]);
+    if (fd == -1) {
+        printf("Failed to parse fd for remote process pid %d, exec_name %s\n",
+               getpid(), __progname);
+        return -EINVAL;
+    }
+
+    parse_cmdline(argc - 2, argv + 2, NULL);
+
+    mpqemu_init_channel(mpqemu_link, &mpqemu_link->com, fd);
 
     mpqemu_link_set_callback(mpqemu_link, process_msg);
 
diff --git a/remote/remote-opts.c b/remote/remote-opts.c
new file mode 100644
index 0000000000..cb7837bf13
--- /dev/null
+++ b/remote/remote-opts.c
@@ -0,0 +1,75 @@
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
+#include "hw/boards.h"
+#include "sysemu/blockdev.h"
+#include "qapi/error.h"
+#include "qemu-options.h"
+#include "qemu-parse.h"
+#include "remote-opts.h"
+
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
+                error_report("Option not supported for this target,"
+                             " %x arch_mask, %x arch_type",
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
index 0000000000..263d428060
--- /dev/null
+++ b/remote/remote-opts.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright © 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
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
2.25.GIT


