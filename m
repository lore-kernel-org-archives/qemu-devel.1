Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B7FC38BE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29CCC20CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cykJKNqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CCC20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6L0a-0005TO-Ci
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:11:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6KmV-00075f-7f
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6KmT-0003XU-Bz
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:47 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6KmT-0003WI-2F
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:45 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKrnlt164218;
 Mon, 24 Feb 2020 20:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding;
 s=corp-2020-01-29; bh=aocQH+1NHhM+rtmsJWLML75T23tu0x51c8jh12GV0c8=;
 b=cykJKNqLMgMBRyS3OFkw4VSIJJxeK2YzO2t7k/qm/dhsj/0cEZrxOxW/p1M7nH/6+Vqm
 FB7NhsijCMK2CZdvYZngowJGtVhimn+MXd+7VCBJmELtIyETSGHbPibNzpEplbaSuQej
 ck2VNcaEigLUDTdZvg4NKU0TLWyRx31dCSucBiC3nMqjjwEJ6Mq1UjX4APk5/WaTGAcD
 APeu5OjVK20MdujJ4GB5cevfgvmEoI2LAMs69aM2BgXyj05xxUhg7Bs/hAAedPJm1tMG
 DQQIxZiXaPQli/MHRlO859Abjf7vndjCOuDRgfitYyG1DtfhFkm858Qy72djkXf2ahPe jQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2ybvr4p967-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKudIV073056;
 Mon, 24 Feb 2020 20:56:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2ybduv6da8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:39 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OKua2f028643;
 Mon, 24 Feb 2020 20:56:37 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:36 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 26/50] multi-process: refractor vl.c code
Date: Mon, 24 Feb 2020 15:55:17 -0500
Message-Id: <0487097d8961daab47bf9f31e5fa669642d5499c.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=1
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=1 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserp2120.oracle.com id
 01OKrnlt164218
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

To re-use for device initialization for remote emulated
devices and parsing options for remote process.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 Makefile.objs        |   5 ++
 remote/Makefile.objs |   1 +
 softmmu/vl.c         | 109 +-----------------------------------------
 vl-parse.c           | 130 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
 vl.h                 |  42 +++++++++++++++++
 5 files changed, 179 insertions(+), 108 deletions(-)
 create mode 100644 vl-parse.c
 create mode 100644 vl.h

diff --git a/Makefile.objs b/Makefile.objs
index aad33fc..689a722 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -96,6 +96,11 @@ qemu-seccomp.o-libs :=3D $(SECCOMP_LIBS)
=20
 common-obj-$(CONFIG_FDT) +=3D device_tree.o
=20
+common-obj-y +=3D vl-parse.o
+
+#######################################################################
+# qapi
+
 common-obj-y +=3D qapi/
=20
 endif # CONFIG_SOFTMMU
diff --git a/remote/Makefile.objs b/remote/Makefile.objs
index cbb3065..c1349ad 100644
--- a/remote/Makefile.objs
+++ b/remote/Makefile.objs
@@ -2,3 +2,4 @@ remote-pci-obj-$(CONFIG_MPQEMU) +=3D remote-main.o
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D pcihost.o
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D machine.o
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D iohub.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D../vl-parse.o
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 79a286c..b277de3 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -40,6 +40,7 @@
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qlist.h"
+#include "vl.h"
=20
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
@@ -975,20 +976,6 @@ static int cleanup_add_fd(void *opaque, QemuOpts *op=
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
@@ -1694,21 +1681,6 @@ static void help(int exitcode)
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
@@ -2070,45 +2042,6 @@ static int device_help_func(void *opaque, QemuOpts=
 *opts, Error **errp)
     return qdev_device_help(opts);
 }
=20
-#if defined(CONFIG_MPQEMU)
-static int rdevice_init_func(void *opaque, QemuOpts *opts, Error **errp)
-{
-    DeviceState *dev;
-
-    dev =3D qdev_remote_add(opts, errp);
-    if (!dev) {
-        error_setg(errp, "qdev_remote_add failed for device.");
-        return -1;
-    }
-    object_unref(OBJECT(dev));
-    return 0;
-}
-#endif
-
-static int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
-{
-    DeviceState *dev;
-
-#if defined(CONFIG_MPQEMU)
-    const char *remote;
-
-    remote =3D qemu_opt_get(opts, "remote");
-    if (remote) {
-        /* This will be a remote process */
-        return rdevice_init_func(opaque, opts, errp);
-    }
-#endif
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
@@ -2358,46 +2291,6 @@ static void qemu_unlink_pidfile(Notifier *n, void =
*data)
     }
 }
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
diff --git a/vl-parse.c b/vl-parse.c
new file mode 100644
index 0000000..b76bc95
--- /dev/null
+++ b/vl-parse.c
@@ -0,0 +1,130 @@
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
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "qemu/cutils.h"
+#include "qemu/error-report.h"
+#include "monitor/qdev.h"
+#include "monitor/qdev.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
+#include "qemu/option.h"
+#include "qemu-options.h"
+#include "sysemu/blockdev.h"
+
+#include "chardev/char.h"
+#include "monitor/monitor.h"
+#include "qemu/config-file.h"
+
+#include "sysemu/arch_init.h"
+
+#include "vl.h"
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
+const QEMUOption *lookup_opt(int argc, char **argv,
+                                    const char **poptarg, int *poptind)
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
+    if (!popt) {
+        error_report("Not valid qemu_options");
+    }
+    for (;;) {
+        if (!popt->name) {
+            error_report("invalid option*");
+            exit(1);
+            popt++;
+            continue;
+        }
+        if (!strcmp(popt->name, r + 1)) {
+            break;
+        }
+        popt++;
+    }
+    if (popt->flags & HAS_ARG) {
+        if (optind >=3D argc) {
+            error_report("optind %d, argc %d", optind, argc);
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
+    if (!drive_new(opts, *block_default_type, errp)) {
+        error_report_err(*errp);
+    }
+
+    return 0;
+}
+
+#if defined(CONFIG_MPQEMU)
+int rdevice_init_func(void *opaque, QemuOpts *opts, Error **errp)
+{
+    DeviceState *dev;
+
+    dev =3D qdev_remote_add(opts, errp);
+    if (!dev) {
+        error_setg(errp, "qdev_remote_add failed for device.");
+        return -1;
+    }
+    return 0;
+}
+#endif
+
+int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
+{
+    DeviceState *dev;
+
+#if defined(CONFIG_MPQEMU)
+    const char *remote =3D qemu_opt_get(opts, "rid");
+    if (remote) {
+        return 0;
+    }
+#endif
+
+    dev =3D qdev_device_add(opts, errp);
+    if (!dev) {
+        return -1;
+    }
+    object_unref(OBJECT(dev));
+    return 0;
+}
diff --git a/vl.h b/vl.h
new file mode 100644
index 0000000..a171fab
--- /dev/null
+++ b/vl.h
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
+
+#define HAS_ARG 0x0001
+typedef struct QEMUOption {
+    const char *name;
+    int flags;
+    int index;
+    uint32_t arch_mask;
+} QEMUOption;
+
+const QEMUOption *lookup_opt(int argc, char **argv,
+                                    const char **poptarg, int *poptind);
+
+int drive_init_func(void *opaque, QemuOpts *opts, Error **errp);
+int device_init_func(void *opaque, QemuOpts *opts, Error **errp);
+
+#if defined(CONFIG_MPQEMU)
+int rdevice_init_func(void *opaque, QemuOpts *opts, Error **errp);
+#endif
+
+#endif /* VL_H */
+
--=20
1.8.3.1


