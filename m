Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD410C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:44:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 785B7206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vNSYIyda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785B7206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOJA-0006TE-HD
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 05:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGO-0001Pb-4K
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGL-0001zg-Qs
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:41:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45240)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jLOGL-0001xQ-GD
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:41:49 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369djKw069599;
 Mon, 6 Apr 2020 09:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=c0j6bwfYWxJ8tWMCbFF9L/DxtHFtQGMxoI2UFJHCj6M=;
 b=vNSYIydaMYvu4imO4V+i3s1FhFzfZq/HRA2Xkww+8qHuy2BcroyJ56a8oYxSMtK1FM2/
 50F+sBPgfmPgKbFlmFIQC/CHI8Gbce4DIGhcFa1pxuj2oUtV5p0av+dA5LH58LK22HY+
 VOVGX15hc48TgeJZB3ctJVeSbPwdR7yojt0GPMZ3CoC+izkEHiHjFDDVYspf82lTKVL7
 xv8EjZ5W5AA2V7tEkyIPmRzTP+5+GtXRW9EOVwV9Rgyu1whAUaBQ661K0RBrp713gLFq
 wH0wNHxSxZt1h3qhd9iHXjYw3Cgp2fBKFE9CnIpO3iD0fQuiNzbzwbiSzv/Kpotzsul8 mA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 306j6m5t9t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:41:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369cU1I006266;
 Mon, 6 Apr 2020 09:41:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 3073xvttbg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:41:42 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0369fe6b031755;
 Mon, 6 Apr 2020 09:41:40 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 06 Apr 2020 02:41:39 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v6 05/36] multi-process: Refactor monitor functions out of vl.c
Date: Mon,  6 Apr 2020 02:40:55 -0700
Message-Id: <42e0baf1cbf308ed01bcd72fcc5b829965855883.1586165555.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1586165555.git.elena.ufimtseva@oracle.com>
References: <cover.1586165555.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 mlxlogscore=999
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 spamscore=0
 priorityscore=1501 suspectscore=1 lowpriorityscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060083
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

Some of the initialization helper functions w.r.t monitor
in vl.c are also used by the remote process. Therefore, these functions
are refactored into shared files that both QEMU & remote process
could use.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/monitor/monitor.h |  3 +++
 monitor/monitor.c         | 37 +++++++++++++++++++++++++++++++++++++
 softmmu/vl.c              | 35 -----------------------------------
 3 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 1018d754a6..3803e904f2 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -48,4 +48,7 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd);
 void monitor_fdset_dup_fd_remove(int dup_fd);
 int64_t monitor_fdset_dup_fd_find(int dup_fd);
 
+int mon_init_func(void *opaque, QemuOpts *opts, Error **errp);
+void monitor_parse(const char *optarg, const char *mode, bool pretty);
+
 #endif /* MONITOR_H */
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 125494410a..88423b38b6 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -35,6 +35,8 @@
 #include "sysemu/qtest.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
+#include "qemu/cutils.h"
+#include "qemu/config-file.h"
 
 /*
  * To prevent flooding clients, events can be throttled. The
@@ -611,6 +613,41 @@ void monitor_init_globals_core(void)
                                    NULL);
 }
 
+int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
+{
+    return monitor_init_opts(opts, errp);
+}
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
 int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
 {
     Chardev *chr;
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 9517f0b167..f30b6994e8 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2046,41 +2046,6 @@ static int fsdev_init_func(void *opaque, QemuOpts *opts, Error **errp)
 }
 #endif
 
-static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
-{
-    return monitor_init_opts(opts, errp);
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
2.25.GIT


