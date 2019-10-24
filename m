Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7431CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:42:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EA9A20684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E23NGreU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA9A20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZdh-0007EE-2R
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ9d-0008Qz-4d
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ9b-0004lS-7H
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:11:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60738)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZ9a-0004kr-Tg
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:11:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94MZv099572;
 Thu, 24 Oct 2019 09:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=isX1KAndj6ulSnNqa6bQoDEYVpd7UGNGOW9edca/S74=;
 b=E23NGreUKUTLzPI0U1Z7zVOfn4B9I+n1rF+U/zHeAYiEWqk9UbkJUHQEDCwSNcWy2DJe
 oLDz226cvZqL5pxDMBYZqbuMn8dazP5ivQHymb9wMqsZ9at7CEqGUZ312nmQcw7UAvn2
 dKWVp6MKYF/PpewMoof1KU4VWRy1ZwLYCeO0lqrTwkeOpiFZat0CL+AklZuAM9NHTIFM
 1d4eNgZ+ah0Yz7Te39k2SH/HKolaOdG+LURxsOFgkZ0Uci9EikjI/lXxSIOOeT8atkqY
 4xz3wqqNPy3XpZM2F3clqbn7PX3GGsV0r96eGmUicmHZp/jqmwXzUVLRR0ovWbW9mtCp Dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2vqteq2ajg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:11:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O98Mrl047226;
 Thu, 24 Oct 2019 09:11:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2vu0fnu8ct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:11:29 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9O9BSCm002614;
 Thu, 24 Oct 2019 09:11:28 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:11:28 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 37/49] multi-process/mon: Refactor monitor/chardev
 functions out of vl.c
Date: Thu, 24 Oct 2019 05:09:18 -0400
Message-Id: <0dd799b9be18a4ad4c888b403fee3f823516ee45.1571905346.git.jag.raman@oracle.com>
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

Some of the initialization helper functions w.r.t monitor & chardev
in vl.c are also used by the remote process. Therefore, these functions
are refactored into shared files that both QEMU & remote process
could use.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 New patch in v3

 v3 -> v4
   - Moved monitor related functions to monitor.c and chardev functions
     to char.c

 chardev/char.c            | 14 ++++++++
 include/chardev/char.h    |  1 +
 include/monitor/monitor.h |  2 ++
 monitor/monitor.c         | 83 +++++++++++++++++++++++++++++++++++++++++-
 remote/remote-main.c      |  1 +
 remote/remote-opts.c      |  1 +
 vl-parse.c                | 35 +++++++++---------
 vl.c                      | 91 -----------------------------------------------
 8 files changed, 119 insertions(+), 109 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 7b6b2cb..9f339ec 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -1168,4 +1168,18 @@ static void register_types(void)
     qemu_add_machine_init_done_notifier(&chardev_machine_done_notify);
 }
 
+int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp)
+{
+    Error *local_err = NULL;
+
+    if (!qemu_chr_new_from_opts(opts, NULL, &local_err)) {
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return -1;
+        }
+        exit(0);
+    }
+    return 0;
+}
+
 type_init(register_types);
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 087b202..bad076c 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -290,4 +290,5 @@ GSource *qemu_chr_timeout_add_ms(Chardev *chr, guint ms,
 /* console.c */
 void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend, Error **errp);
 
+int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp);
 #endif
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index a81eeff..ed1963a 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -42,5 +42,7 @@ int monitor_fdset_get_fd(int64_t fdset_id, int flags);
 int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd);
 void monitor_fdset_dup_fd_remove(int dup_fd);
 int64_t monitor_fdset_dup_fd_find(int dup_fd);
+void monitor_parse(const char *optarg, const char *mode, bool pretty);
+int mon_init_func(void *opaque, QemuOpts *opts, Error **errp);
 
 #endif /* MONITOR_H */
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 12898b6..18bcb57 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -33,7 +33,10 @@
 #include "sysemu/qtest.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
-
+#include "qemu/cutils.h"
+#include "qemu/option.h"
+#include "qemu-options.h"
+#include "qemu/config-file.h"
 /*
  * To prevent flooding clients, events can be throttled. The
  * throttling is calculated globally, rather than per-Monitor
@@ -609,6 +612,84 @@ void monitor_init_globals_core(void)
                                    NULL);
 }
 
+void monitor_parse(const char *optarg, const char *mode, bool pretty)
+{
+    static int monitor_device_index;
+    QemuOpts *opts;
+    const char *p;
+    char label[32];
+
+    if (strstart(optarg, "chardev:", &p)) {
+        snprintf(label, sizeof(label), "%s", p);
+    } else {
+        snprintf(label, sizeof(label), "compat_monitor%d",
+                 monitor_device_index);
+        opts = qemu_chr_parse_compat(label, optarg, true);
+        if (!opts) {
+            error_report("parse error: %s", optarg);
+            exit(1);
+        }
+    }
+
+    opts = qemu_opts_create(qemu_find_opts("mon"), label, 1, &error_fatal);
+    qemu_opt_set(opts, "mode", mode, &error_abort);
+    qemu_opt_set(opts, "chardev", label, &error_abort);
+    if (!strcmp(mode, "control")) {
+        qemu_opt_set_bool(opts, "pretty", pretty, &error_abort);
+    } else {
+        assert(pretty == false);
+    }
+    monitor_device_index++;
+}
+
+int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
+{
+    Chardev *chr;
+    bool qmp;
+    bool pretty = false;
+    const char *chardev;
+    const char *mode;
+
+    mode = qemu_opt_get(opts, "mode");
+    if (mode == NULL) {
+        mode = "readline";
+    }
+    if (strcmp(mode, "readline") == 0) {
+        qmp = false;
+    } else if (strcmp(mode, "control") == 0) {
+        qmp = true;
+    } else {
+        error_setg(errp, "unknown monitor mode \"%s\"", mode);
+        return -1;
+    }
+
+    if (!qmp && qemu_opt_get(opts, "pretty")) {
+        warn_report("'pretty' is deprecated for HMP monitors, it has no effect "
+                    "and will be removed in future versions");
+    }
+    if (qemu_opt_get_bool(opts, "pretty", 0)) {
+        pretty = true;
+    }
+
+    chardev = qemu_opt_get(opts, "chardev");
+    if (!chardev) {
+        error_report("chardev is required");
+        exit(1);
+    }
+    chr = qemu_chr_find(chardev);
+    if (chr == NULL) {
+        error_setg(errp, "chardev \"%s\" not found", chardev);
+        return -1;
+    }
+
+    if (qmp) {
+        monitor_init_qmp(chr, pretty);
+    } else {
+        monitor_init_hmp(chr, true);
+    }
+    return 0;
+}
+
 QemuOptsList qemu_mon_opts = {
     .name = "mon",
     .implied_opt_name = "chardev",
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 4459d26..30182dc 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -67,6 +67,7 @@
 #include "qemu/cutils.h"
 #include "remote-opts.h"
 #include "monitor/monitor.h"
+#include "chardev/char.h"
 #include "sysemu/reset.h"
 
 static MPQemuLinkState *mpqemu_link;
diff --git a/remote/remote-opts.c b/remote/remote-opts.c
index 0ebe6b1..7de6195 100644
--- a/remote/remote-opts.c
+++ b/remote/remote-opts.c
@@ -55,6 +55,7 @@
 #include "block/block.h"
 #include "remote/remote-opts.h"
 #include "include/qemu-common.h"
+#include "monitor/monitor.h"
 
 #include "vl.h"
 /*
diff --git a/vl-parse.c b/vl-parse.c
index 4e2bd7c..011a9ef 100644
--- a/vl-parse.c
+++ b/vl-parse.c
@@ -110,49 +110,50 @@ int drive_init_func(void *opaque, QemuOpts *opts, Error **errp)
     return 0;
 }
 
-#if defined(CONFIG_MPQEMU)
-int rdrive_init_func(void *opaque, QemuOpts *opts, Error **errp)
+int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
     DeviceState *dev;
+    const char *remote = NULL;
 
-    dev = qdev_remote_add(opts, false /* this is drive */, errp);
+    remote = qemu_opt_get(opts, "rid");
+    if (remote) {
+        return 0;
+    }
+
+    dev = qdev_device_add(opts, errp);
     if (!dev) {
-        error_setg(errp, "qdev_remote_add failed for drive.");
         return -1;
     }
     object_unref(OBJECT(dev));
     return 0;
 }
-#endif
 
 #if defined(CONFIG_MPQEMU)
-int rdevice_init_func(void *opaque, QemuOpts *opts, Error **errp)
+int rdrive_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
     DeviceState *dev;
 
-    dev = qdev_remote_add(opts, true /* this is device */, errp);
+    dev = qdev_remote_add(opts, false /* this is drive */, errp);
     if (!dev) {
-        error_setg(errp, "qdev_remote_add failed for device.");
+        error_setg(errp, "qdev_remote_add failed for drive.");
         return -1;
     }
+    object_unref(OBJECT(dev));
     return 0;
 }
 #endif
 
-int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
+#if defined(CONFIG_MPQEMU)
+int rdevice_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
     DeviceState *dev;
-    const char *remote = NULL;
 
-    remote = qemu_opt_get(opts, "rid");
-    if (remote) {
-        return 0;
-    }
-
-    dev = qdev_device_add(opts, errp);
+    dev = qdev_remote_add(opts, true /* this is device */, errp);
     if (!dev) {
+        error_setg(errp, "qdev_remote_add failed for device.");
         return -1;
     }
-    object_unref(OBJECT(dev));
     return 0;
 }
+#endif
+
diff --git a/vl.c b/vl.c
index 1417ff2..a6a0db8 100644
--- a/vl.c
+++ b/vl.c
@@ -2279,19 +2279,6 @@ static int device_help_func(void *opaque, QemuOpts *opts, Error **errp)
     return qdev_device_help(opts);
 }
 
-static int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp)
-{
-    Error *local_err = NULL;
-
-    if (!qemu_chr_new_from_opts(opts, NULL, &local_err)) {
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return -1;
-        }
-        exit(0);
-    }
-    return 0;
-}
 
 #ifdef CONFIG_VIRTFS
 static int fsdev_init_func(void *opaque, QemuOpts *opts, Error **errp)
@@ -2300,84 +2287,6 @@ static int fsdev_init_func(void *opaque, QemuOpts *opts, Error **errp)
 }
 #endif
 
-static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
-{
-    Chardev *chr;
-    bool qmp;
-    bool pretty = false;
-    const char *chardev;
-    const char *mode;
-
-    mode = qemu_opt_get(opts, "mode");
-    if (mode == NULL) {
-        mode = "readline";
-    }
-    if (strcmp(mode, "readline") == 0) {
-        qmp = false;
-    } else if (strcmp(mode, "control") == 0) {
-        qmp = true;
-    } else {
-        error_setg(errp, "unknown monitor mode \"%s\"", mode);
-        return -1;
-    }
-
-    if (!qmp && qemu_opt_get(opts, "pretty")) {
-        warn_report("'pretty' is deprecated for HMP monitors, it has no effect "
-                    "and will be removed in future versions");
-    }
-    if (qemu_opt_get_bool(opts, "pretty", 0)) {
-        pretty = true;
-    }
-
-    chardev = qemu_opt_get(opts, "chardev");
-    if (!chardev) {
-        error_report("chardev is required");
-        exit(1);
-    }
-    chr = qemu_chr_find(chardev);
-    if (chr == NULL) {
-        error_setg(errp, "chardev \"%s\" not found", chardev);
-        return -1;
-    }
-
-    if (qmp) {
-        monitor_init_qmp(chr, pretty);
-    } else {
-        monitor_init_hmp(chr, true);
-    }
-    return 0;
-}
-
-static void monitor_parse(const char *optarg, const char *mode, bool pretty)
-{
-    static int monitor_device_index = 0;
-    QemuOpts *opts;
-    const char *p;
-    char label[32];
-
-    if (strstart(optarg, "chardev:", &p)) {
-        snprintf(label, sizeof(label), "%s", p);
-    } else {
-        snprintf(label, sizeof(label), "compat_monitor%d",
-                 monitor_device_index);
-        opts = qemu_chr_parse_compat(label, optarg, true);
-        if (!opts) {
-            error_report("parse error: %s", optarg);
-            exit(1);
-        }
-    }
-
-    opts = qemu_opts_create(qemu_find_opts("mon"), label, 1, &error_fatal);
-    qemu_opt_set(opts, "mode", mode, &error_abort);
-    qemu_opt_set(opts, "chardev", label, &error_abort);
-    if (!strcmp(mode, "control")) {
-        qemu_opt_set_bool(opts, "pretty", pretty, &error_abort);
-    } else {
-        assert(pretty == false);
-    }
-    monitor_device_index++;
-}
-
 struct device_config {
     enum {
         DEV_USB,       /* -usbdevice     */
-- 
1.8.3.1


