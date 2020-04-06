Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CC9C2BA1E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:54:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7899206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b9kAYaqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7899206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOSK-0007HY-1M
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 05:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOIK-0005fl-AE
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOII-0003d0-OC
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:43:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46692)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jLOII-0003cH-Fq
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:43:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369gtkH028646;
 Mon, 6 Apr 2020 09:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=wWLay3pm8AxpvecMxv9+x86nn94U64jdP+vfUO8kaz8=;
 b=b9kAYaqNiWK/ekjYBp3vmvJ8Cyel5VjGwGgaT2Sk0TG4+wmL+GFk77b/gR7BLktNCec3
 vFL/64AcR3D6kv+2Cza10mXJNk+9+rjyAKWzIR6kx+B7TpoxYpdhP/30Xw5NshKbje+d
 xnavkTdT7Eqmf5vb+YrV/6d/yBUF8tiaNB59Hq/i2V5a5OQwk+wZM+cpsGcF/4MyJ2r8
 OoHQgnIAYXo4a/H/J/lXMLYGILpwNiEnyl0YfZSv9RFAMMOuawv/LOB/ELYNYKbyGiai
 xhI6Nsd8qeTA1+Y8uKkBgsqac27weq0jhgDxFmlDjKlWr92oeNPS+PFYGbAsscvF9eZx +A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 306jvmwrbb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:43:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369bLJ5056323;
 Mon, 6 Apr 2020 09:41:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 3073qcnby8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:41:38 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0369faQi006721;
 Mon, 6 Apr 2020 09:41:37 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 06 Apr 2020 02:41:36 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v6 03/36] command-line: refractor parser code
Date: Mon,  6 Apr 2020 02:40:53 -0700
Message-Id: <e9a5c0588905289b05ab03bee957b700de39f167.1586165555.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1586165555.git.elena.ufimtseva@oracle.com>
References: <cover.1586165555.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=1
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060084
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2120.oracle.com id
 0369gtkH028646
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
index b5c86ec494..611d9a64b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2003,6 +2003,8 @@ F: tests/test-keyval.c
 F: tests/test-qemu-opts.c
 F: util/keyval.c
 F: util/qemu-option.c
+F: include/qemu-parse.h
+F: qemu-parse.c
=20
 Coverity model
 M: Markus Armbruster <armbru@redhat.com>
diff --git a/Makefile.objs b/Makefile.objs
index bfb9271862..f29c60c59d 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -78,6 +78,8 @@ qemu-seccomp.o-libs :=3D $(SECCOMP_LIBS)
=20
 common-obj-$(CONFIG_FDT) +=3D device_tree.o
=20
+common-obj-y +=3D qemu-parse.o
+
 common-obj-y +=3D qapi/
 common-obj-y +=3D util/machine-notify.o
=20
diff --git a/include/qemu-parse.h b/include/qemu-parse.h
new file mode 100644
index 0000000000..156b238db6
--- /dev/null
+++ b/include/qemu-parse.h
@@ -0,0 +1,42 @@
+/*
+ * Copyright =C2=A9 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
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
+#define HD_OPTS "media=3Ddisk"
+#define CDROM_OPTS "media=3Dcdrom"
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
+const QEMUOption *lookup_opt(int argc, char **argv, const char **poptarg=
,
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
+ * Copyright =C2=A9 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
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
+static const QEMUOption qemu_options[] =3D {
+    { "h", 0, QEMU_OPTION_h, QEMU_ARCH_ALL },
+#define QEMU_OPTIONS_GENERATE_OPTIONS
+#include "qemu-options-wrapper.h"
+    { NULL },
+};
+
+const QEMUOption *lookup_opt(int argc, char **argv, const char **poptarg=
,
+                             int *poptind)
+{
+    const QEMUOption *popt;
+    int optind =3D *poptind;
+    char *r =3D argv[optind];
+    const char *optarg;
+
+    loc_set_cmdline(argv, optind, 1);
+    optind++;
+    /* Treat --foo the same as -foo.  */
+    if (r[1] =3D=3D '-') {
+        r++;
+    }
+    popt =3D qemu_options;
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
+        if (optind >=3D argc) {
+            error_report("requires an argument");
+            exit(1);
+        }
+        optarg =3D argv[optind++];
+        loc_set_cmdline(argv, optind - 2, 2);
+    } else {
+        optarg =3D NULL;
+    }
+
+    *poptarg =3D optarg;
+    *poptind =3D optind;
+
+    return popt;
+}
+
+int drive_init_func(void *opaque, QemuOpts *opts, Error **errp)
+{
+    BlockInterfaceType *block_default_type =3D opaque;
+
+    return drive_new(opts, *block_default_type, errp) =3D=3D NULL;
+}
+
+int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
+{
+    DeviceState *dev;
+
+    dev =3D qdev_device_add(opts, errp);
+    if (!dev && *errp) {
+        error_report_err(*errp);
+        return -1;
+    } else if (dev) {
+        object_unref(OBJECT(dev));
+    }
+    return 0;
+}
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 380aefd56e..33568108b0 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -36,6 +36,7 @@
 #include "sysemu/runstate.h"
 #include "sysemu/seccomp.h"
 #include "sysemu/tcg.h"
+#include "qemu-parse.h"
=20
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
@@ -970,20 +971,6 @@ static int cleanup_add_fd(void *opaque, QemuOpts *op=
ts, Error **errp)
 /***********************************************************/
 /* QEMU Block devices */
=20
-#define HD_OPTS "media=3Ddisk"
-#define CDROM_OPTS "media=3Dcdrom"
-#define FD_OPTS ""
-#define PFLASH_OPTS ""
-#define MTD_OPTS ""
-#define SD_OPTS ""
-
-static int drive_init_func(void *opaque, QemuOpts *opts, Error **errp)
-{
-    BlockInterfaceType *block_default_type =3D opaque;
-
-    return drive_new(opts, *block_default_type, errp) =3D=3D NULL;
-}
-
 static int drive_enable_snapshot(void *opaque, QemuOpts *opts, Error **e=
rrp)
 {
     if (qemu_opt_get(opts, "snapshot") =3D=3D NULL) {
@@ -1691,21 +1678,6 @@ static void help(int exitcode)
     exit(exitcode);
 }
=20
-#define HAS_ARG 0x0001
-
-typedef struct QEMUOption {
-    const char *name;
-    int flags;
-    int index;
-    uint32_t arch_mask;
-} QEMUOption;
-
-static const QEMUOption qemu_options[] =3D {
-    { "h", 0, QEMU_OPTION_h, QEMU_ARCH_ALL },
-#define QEMU_OPTIONS_GENERATE_OPTIONS
-#include "qemu-options-wrapper.h"
-    { NULL },
-};
=20
 typedef struct VGAInterfaceInfo {
     const char *opt_name;    /* option name */
@@ -2067,20 +2039,6 @@ static int device_help_func(void *opaque, QemuOpts=
 *opts, Error **errp)
     return qdev_device_help(opts);
 }
=20
-static int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
-{
-    DeviceState *dev;
-
-    dev =3D qdev_device_add(opts, errp);
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
     Error *local_err =3D NULL;
@@ -2332,46 +2290,6 @@ static void qemu_unlink_pidfile(Notifier *n, void =
*data)
=20
 bool machine_init_done;
=20
-static const QEMUOption *lookup_opt(int argc, char **argv,
-                                    const char **poptarg, int *poptind)
-{
-    const QEMUOption *popt;
-    int optind =3D *poptind;
-    char *r =3D argv[optind];
-    const char *optarg;
-
-    loc_set_cmdline(argv, optind, 1);
-    optind++;
-    /* Treat --foo the same as -foo.  */
-    if (r[1] =3D=3D '-')
-        r++;
-    popt =3D qemu_options;
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
-        if (optind >=3D argc) {
-            error_report("requires an argument");
-            exit(1);
-        }
-        optarg =3D argv[optind++];
-        loc_set_cmdline(argv, optind - 2, 2);
-    } else {
-        optarg =3D NULL;
-    }
-
-    *poptarg =3D optarg;
-    *poptind =3D optind;
-
-    return popt;
-}
-
 static MachineClass *select_machine(void)
 {
     GSList *machines =3D object_class_get_list(TYPE_MACHINE, false);
--=20
2.25.GIT


