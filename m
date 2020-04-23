Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AD5C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:15:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D312075A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H0Cwgw50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D312075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRTHE-0001Dt-Oj
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 00:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTFz-0007nZ-4a
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTFx-0006D7-S3
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:14:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54500)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jRTFx-00066W-9k
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:14:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4DMnN064457;
 Thu, 23 Apr 2020 04:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=/6mYLpwf8CYpGods0FWXdb0UNJU4VjY3qXDBuredIww=;
 b=H0Cwgw50Ed+irFGJPTaRpbswqv4qYcLH/TZucYAK/O4TnxVoTnRc1c42gpJqjjusIUXS
 MEKnLJnYIGYf/fUP3Fx6DoR+lI/qyFosdPHLCTTl9/1aTAgnRSn3QpAEq0ww5n66Hix9
 p8E6T30ypjdGG2OpO8XXjtP8Hm/CzIrCSamNaxKB1cv9twAo2lMOydwpD6LwLBkpNQSu
 OAHIZRJb8zavuDyXMGFXkyFLnL3Qexg60br+bHXHBsr/Ojrrt3hoziPJzvHphveWWctd
 zld2YX2TxQeWbb5OpUiQ+am2mJYBGuff+AgcoRQqYqqrs8NPbFHjuSU543qzt0u4h8m/ iQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 30grpgtrry-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:14:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4DWEf168888;
 Thu, 23 Apr 2020 04:14:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 30gb942gfr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:14:24 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03N4EMgo017627;
 Thu, 23 Apr 2020 04:14:22 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 22 Apr 2020 21:14:22 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v6 03/36] command-line: refractor parser code
Date: Wed, 22 Apr 2020 21:13:38 -0700
Message-Id: <d425a6164b01693940fb505002ccebbac7b54dbb.1587614626.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1587614626.git.elena.ufimtseva@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 bulkscore=0 suspectscore=1 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230027
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

Refactor command-line parser code so that it could be used by
other processes as well.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 MAINTAINERS          |  2 +
 Makefile.objs        |  2 +
 include/qemu-parse.h | 42 ++++++++++++++++++++
 qemu-parse.c         | 93 ++++++++++++++++++++++++++++++++++++++++++++
 softmmu/vl.c         | 84 +--------------------------------------
 5 files changed, 140 insertions(+), 83 deletions(-)
 create mode 100644 include/qemu-parse.h
 create mode 100644 qemu-parse.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 04b19ac56c..2e700e6e64 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2032,6 +2032,8 @@ F: tests/test-keyval.c
 F: tests/test-qemu-opts.c
 F: util/keyval.c
 F: util/qemu-option.c
+F: include/qemu-parse.h
+F: qemu-parse.c
 
 Coverity model
 M: Markus Armbruster <armbru@redhat.com>
diff --git a/Makefile.objs b/Makefile.objs
index bfb9271862..f29c60c59d 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -78,6 +78,8 @@ qemu-seccomp.o-libs := $(SECCOMP_LIBS)
 
 common-obj-$(CONFIG_FDT) += device_tree.o
 
+common-obj-y += qemu-parse.o
+
 common-obj-y += qapi/
 common-obj-y += util/machine-notify.o
 
diff --git a/include/qemu-parse.h b/include/qemu-parse.h
new file mode 100644
index 0000000000..156b238db6
--- /dev/null
+++ b/include/qemu-parse.h
@@ -0,0 +1,42 @@
+/*
+ * Copyright © 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef VL_H
+#define VL_H
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+/***********************************************************/
+/* QEMU Block devices */
+
+#define HD_OPTS "media=disk"
+#define CDROM_OPTS "media=cdrom"
+#define FD_OPTS ""
+#define PFLASH_OPTS ""
+#define MTD_OPTS ""
+#define SD_OPTS ""
+
+#define HAS_ARG 0x0001
+
+typedef struct QEMUOption {
+    const char *name;
+    int flags;
+    int index;
+    uint32_t arch_mask;
+} QEMUOption;
+
+const QEMUOption *lookup_opt(int argc, char **argv, const char **poptarg,
+                             int *poptind);
+
+int drive_init_func(void *opaque, QemuOpts *opts, Error **errp);
+
+int device_init_func(void *opaque, QemuOpts *opts, Error **errp);
+
+#endif /* VL_H */
+
diff --git a/qemu-parse.c b/qemu-parse.c
new file mode 100644
index 0000000000..2535374fdd
--- /dev/null
+++ b/qemu-parse.c
@@ -0,0 +1,93 @@
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
+#include "sysemu/blockdev.h"
+#include "sysemu/arch_init.h"
+#include "qemu/option.h"
+#include "qemu-options.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "monitor/qdev.h"
+#include "qom/object.h"
+#include "qemu-parse.h"
+
+/***********************************************************/
+/* QEMU Block devices */
+
+static const QEMUOption qemu_options[] = {
+    { "h", 0, QEMU_OPTION_h, QEMU_ARCH_ALL },
+#define QEMU_OPTIONS_GENERATE_OPTIONS
+#include "qemu-options-wrapper.h"
+    { NULL },
+};
+
+const QEMUOption *lookup_opt(int argc, char **argv, const char **poptarg,
+                             int *poptind)
+{
+    const QEMUOption *popt;
+    int optind = *poptind;
+    char *r = argv[optind];
+    const char *optarg;
+
+    loc_set_cmdline(argv, optind, 1);
+    optind++;
+    /* Treat --foo the same as -foo.  */
+    if (r[1] == '-') {
+        r++;
+    }
+    popt = qemu_options;
+    for (;;) {
+        if (!popt->name) {
+            error_report("invalid option");
+            exit(1);
+        }
+        if (!strcmp(popt->name, r + 1)) {
+            break;
+        }
+        popt++;
+    }
+    if (popt->flags & HAS_ARG) {
+        if (optind >= argc) {
+            error_report("requires an argument");
+            exit(1);
+        }
+        optarg = argv[optind++];
+        loc_set_cmdline(argv, optind - 2, 2);
+    } else {
+        optarg = NULL;
+    }
+
+    *poptarg = optarg;
+    *poptind = optind;
+
+    return popt;
+}
+
+int drive_init_func(void *opaque, QemuOpts *opts, Error **errp)
+{
+    BlockInterfaceType *block_default_type = opaque;
+
+    return drive_new(opts, *block_default_type, errp) == NULL;
+}
+
+int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
+{
+    DeviceState *dev;
+
+    dev = qdev_device_add(opts, errp);
+    if (!dev && *errp) {
+        error_report_err(*errp);
+        return -1;
+    } else if (dev) {
+        object_unref(OBJECT(dev));
+    }
+    return 0;
+}
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 39cbb6b50d..d1b32a33a2 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -36,6 +36,7 @@
 #include "sysemu/runstate.h"
 #include "sysemu/seccomp.h"
 #include "sysemu/tcg.h"
+#include "qemu-parse.h"
 
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
@@ -969,20 +970,6 @@ static int cleanup_add_fd(void *opaque, QemuOpts *opts, Error **errp)
 /***********************************************************/
 /* QEMU Block devices */
 
-#define HD_OPTS "media=disk"
-#define CDROM_OPTS "media=cdrom"
-#define FD_OPTS ""
-#define PFLASH_OPTS ""
-#define MTD_OPTS ""
-#define SD_OPTS ""
-
-static int drive_init_func(void *opaque, QemuOpts *opts, Error **errp)
-{
-    BlockInterfaceType *block_default_type = opaque;
-
-    return drive_new(opts, *block_default_type, errp) == NULL;
-}
-
 static int drive_enable_snapshot(void *opaque, QemuOpts *opts, Error **errp)
 {
     if (qemu_opt_get(opts, "snapshot") == NULL) {
@@ -1690,21 +1677,6 @@ static void help(int exitcode)
     exit(exitcode);
 }
 
-#define HAS_ARG 0x0001
-
-typedef struct QEMUOption {
-    const char *name;
-    int flags;
-    int index;
-    uint32_t arch_mask;
-} QEMUOption;
-
-static const QEMUOption qemu_options[] = {
-    { "h", 0, QEMU_OPTION_h, QEMU_ARCH_ALL },
-#define QEMU_OPTIONS_GENERATE_OPTIONS
-#include "qemu-options-wrapper.h"
-    { NULL },
-};
 
 typedef struct VGAInterfaceInfo {
     const char *opt_name;    /* option name */
@@ -2066,20 +2038,6 @@ static int device_help_func(void *opaque, QemuOpts *opts, Error **errp)
     return qdev_device_help(opts);
 }
 
-static int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
-{
-    DeviceState *dev;
-
-    dev = qdev_device_add(opts, errp);
-    if (!dev && *errp) {
-        error_report_err(*errp);
-        return -1;
-    } else if (dev) {
-        object_unref(OBJECT(dev));
-    }
-    return 0;
-}
-
 static int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
     Error *local_err = NULL;
@@ -2329,46 +2287,6 @@ static void qemu_unlink_pidfile(Notifier *n, void *data)
     }
 }
 
-static const QEMUOption *lookup_opt(int argc, char **argv,
-                                    const char **poptarg, int *poptind)
-{
-    const QEMUOption *popt;
-    int optind = *poptind;
-    char *r = argv[optind];
-    const char *optarg;
-
-    loc_set_cmdline(argv, optind, 1);
-    optind++;
-    /* Treat --foo the same as -foo.  */
-    if (r[1] == '-')
-        r++;
-    popt = qemu_options;
-    for(;;) {
-        if (!popt->name) {
-            error_report("invalid option");
-            exit(1);
-        }
-        if (!strcmp(popt->name, r + 1))
-            break;
-        popt++;
-    }
-    if (popt->flags & HAS_ARG) {
-        if (optind >= argc) {
-            error_report("requires an argument");
-            exit(1);
-        }
-        optarg = argv[optind++];
-        loc_set_cmdline(argv, optind - 2, 2);
-    } else {
-        optarg = NULL;
-    }
-
-    *poptarg = optarg;
-    *poptind = optind;
-
-    return popt;
-}
-
 static MachineClass *select_machine(void)
 {
     GSList *machines = object_class_get_list(TYPE_MACHINE, false);
-- 
2.25.GIT


