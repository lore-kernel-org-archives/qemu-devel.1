Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962AEC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:24:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E4DC21883
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="na1BJDyn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E4DC21883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5GHV-000682-QY
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5FaT-0008AZ-OM
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FaS-0000rk-2H
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60816)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FaR-0000qx-Om
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KdULG067244;
 Tue, 3 Sep 2019 20:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=EYC3/3Hhu1ZNcmw2+96oI5bIEQx1yWAUx+oyASHlWHc=;
 b=na1BJDyn7VygLKpZNVElc9+Ft59ESFEzOwNAeu53rgS9drRzbyjfsCP8Tb5bjNLxl6yq
 9+glwlA0i4HIjel6NJvlxzXwBM1HcFdEmQg8u1jdEjSC4q+29OJJGFtAa89k3qye4D47
 fq18fvPz1ogAybb024zMd4gUZ3cFffz0KSg7sGOYcPig3a8e127Hu8SkP1u3B2L/UzVR
 5K/ylJ7ELnC8Mw9HtymMT56KmBw9rKTcRowZ07Jzn2M0Xo+FnfIFCRESJnBwX6NQ8rHG
 e40EYOVRQnotvHKQddZLCJuUu4kmG3K27OQvTRrY20SFuZGXPIuGK2Wq9s/PRLdWC5w/ ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2usy66r2j7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KcI55094719;
 Tue, 3 Sep 2019 20:39:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2usu51u2bh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:29 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83KdSp4017854;
 Tue, 3 Sep 2019 20:39:28 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:39:27 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:38:06 -0400
Message-Id: <0d668ccf7c5fa09d4968d618df069ab74787ec29.1567534653.git.jag.raman@oracle.com>
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
 definitions=main-1909030207
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [RFC v3 PATCH 40/45] multi-process/mon: Refactor
 monitor/chardev functions out of vl.c
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
are refactored into a shared file that both QEMU & remote process
could use.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 New patch in v3

 vl-parse.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 vl.c       | 91 -------------------------------------------------------------
 vl.h       |  4 +++
 3 files changed, 96 insertions(+), 91 deletions(-)

diff --git a/vl-parse.c b/vl-parse.c
index d3716d1..bee904d 100644
--- a/vl-parse.c
+++ b/vl-parse.c
@@ -155,3 +155,95 @@ int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
     object_unref(OBJECT(dev));
     return 0;
 }
+
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
diff --git a/vl.c b/vl.c
index 08e9c09..3c03405 100644
--- a/vl.c
+++ b/vl.c
@@ -2264,19 +2264,6 @@ static int device_help_func(void *opaque, QemuOpts *opts, Error **errp)
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
@@ -2285,84 +2272,6 @@ static int fsdev_init_func(void *opaque, QemuOpts *opts, Error **errp)
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
diff --git a/vl.h b/vl.h
index 8c40fed..21ca747 100644
--- a/vl.h
+++ b/vl.h
@@ -50,5 +50,9 @@ int device_init_func(void *opaque, QemuOpts *opts, Error **errp);
 int rdrive_init_func(void *opaque, QemuOpts *opts, Error **errp);
 int rdevice_init_func(void *opaque, QemuOpts *opts, Error **errp);
 
+void monitor_parse(const char *optarg, const char *mode, bool pretty);
+int mon_init_func(void *opaque, QemuOpts *opts, Error **errp);
+int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp);
+
 #endif /* VL_H */
 
-- 
1.8.3.1


