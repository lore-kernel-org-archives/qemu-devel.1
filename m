Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E21BC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:55:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16CAD206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xKN+2vBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16CAD206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOTw-00017Y-8s
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 05:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOIE-0005aZ-A7
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:43:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOIC-0003Z0-Qy
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:43:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36206)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jLOIC-0003Y4-If
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:43:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369dtf4089528;
 Mon, 6 Apr 2020 09:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=vo9XVqRjUwLdxamis5vtm7R1B8Mjc6k73iBRSiBen4E=;
 b=xKN+2vBvhNqIovOWgZc830JzkIabzB6WoCHUoaeutPeHsL5IWqrnGFv+J9SlqAEuPyy1
 1L33ZlWCiWL8xn6olSL8hx58vtq8II7uGGTl+T1X7/XjG05cRAmqFFVbdPZzcHrwfoar
 GrBHFETFrK3WVCD5EaJncMV0tv0ko4eSGmZSDECjs5zE7hBojj5AwfzFOmMYaOaN54OW
 YG+W5TlH+rIjqu4HkD1QWVH/7ppRDtAZpRxiBBmmK4jkrmZtINakRNeL4WrgupU0oeJq
 NiWETFcpjXycqYO9/9/yJsYfnjyrwHxWZg+CiRv966hVJJBdQuDKE0j12iLzDFKqkHwF 6A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 306hnqwu5g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:43:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369bLHC056293;
 Mon, 6 Apr 2020 09:41:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 3073qcnbwu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:41:37 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0369fZbY013461;
 Mon, 6 Apr 2020 09:41:35 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 06 Apr 2020 02:41:34 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v6 02/36] multi-process: Refactor machine_init and exit
 notifiers
Date: Mon,  6 Apr 2020 02:40:52 -0700
Message-Id: <a390c0cab4aca444ed4e2bde3bdb2a8e39fbec0d.1586165555.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1586165555.git.elena.ufimtseva@oracle.com>
References: <cover.1586165555.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=1
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060083
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

Relocate machine_int and exit notifiers into common code

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 Makefile.objs             |  1 +
 include/sysemu/sysemu.h   |  2 ++
 softmmu/vl.c              | 40 -----------------------
 stubs/machine-init-done.c | 12 +++++++
 util/machine-notify.c     | 67 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 82 insertions(+), 40 deletions(-)
 create mode 100644 util/machine-notify.c

diff --git a/Makefile.objs b/Makefile.objs
index a7c967633a..bfb9271862 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -79,6 +79,7 @@ qemu-seccomp.o-libs := $(SECCOMP_LIBS)
 common-obj-$(CONFIG_FDT) += device_tree.o
 
 common-obj-y += qapi/
+common-obj-y += util/machine-notify.o
 
 endif # CONFIG_SOFTMMU
 
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index ef81302e1a..2438dd7bea 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -17,11 +17,13 @@ extern bool qemu_uuid_set;
 
 void qemu_add_exit_notifier(Notifier *notify);
 void qemu_remove_exit_notifier(Notifier *notify);
+void qemu_run_exit_notifiers(void);
 
 extern bool machine_init_done;
 
 void qemu_add_machine_init_done_notifier(Notifier *notify);
 void qemu_remove_machine_init_done_notifier(Notifier *notify);
+void qemu_run_machine_init_done_notifiers(void);
 
 extern int autostart;
 
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 814537bb42..380aefd56e 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -173,12 +173,6 @@ int icount_align_option;
 QemuUUID qemu_uuid;
 bool qemu_uuid_set;
 
-static NotifierList exit_notifiers =
-    NOTIFIER_LIST_INITIALIZER(exit_notifiers);
-
-static NotifierList machine_init_done_notifiers =
-    NOTIFIER_LIST_INITIALIZER(machine_init_done_notifiers);
-
 bool xen_allowed;
 uint32_t xen_domid;
 enum xen_mode xen_mode = XEN_EMULATE;
@@ -2326,21 +2320,6 @@ static MachineClass *machine_parse(const char *name, GSList *machines)
     return mc;
 }
 
-void qemu_add_exit_notifier(Notifier *notify)
-{
-    notifier_list_add(&exit_notifiers, notify);
-}
-
-void qemu_remove_exit_notifier(Notifier *notify)
-{
-    notifier_remove(notify);
-}
-
-static void qemu_run_exit_notifiers(void)
-{
-    notifier_list_notify(&exit_notifiers, NULL);
-}
-
 static const char *pid_file;
 static Notifier qemu_unlink_pidfile_notifier;
 
@@ -2353,25 +2332,6 @@ static void qemu_unlink_pidfile(Notifier *n, void *data)
 
 bool machine_init_done;
 
-void qemu_add_machine_init_done_notifier(Notifier *notify)
-{
-    notifier_list_add(&machine_init_done_notifiers, notify);
-    if (machine_init_done) {
-        notify->notify(notify, NULL);
-    }
-}
-
-void qemu_remove_machine_init_done_notifier(Notifier *notify)
-{
-    notifier_remove(notify);
-}
-
-static void qemu_run_machine_init_done_notifiers(void)
-{
-    machine_init_done = true;
-    notifier_list_notify(&machine_init_done_notifiers, NULL);
-}
-
 static const QEMUOption *lookup_opt(int argc, char **argv,
                                     const char **poptarg, int *poptind)
 {
diff --git a/stubs/machine-init-done.c b/stubs/machine-init-done.c
index cd8e81392d..fc8be8cead 100644
--- a/stubs/machine-init-done.c
+++ b/stubs/machine-init-done.c
@@ -3,6 +3,18 @@
 
 bool machine_init_done = true;
 
+static NotifierList machine_init_done_notifiers =
+    NOTIFIER_LIST_INITIALIZER(machine_init_done_notifiers);
+
 void qemu_add_machine_init_done_notifier(Notifier *notify)
 {
 }
+
+void qemu_remove_machine_init_done_notifier(Notifier *notify)
+{
+}
+
+void qemu_run_machine_init_done_notifiers(void)
+{
+    notifier_list_notify(&machine_init_done_notifiers, NULL);
+}
diff --git a/util/machine-notify.c b/util/machine-notify.c
new file mode 100644
index 0000000000..63fc59a5a6
--- /dev/null
+++ b/util/machine-notify.c
@@ -0,0 +1,67 @@
+/*
+ * Machine notifiers.
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
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
+#include "qemu/notify.h"
+#include "sysemu/sysemu.h"
+
+static NotifierList machine_init_done_notifiers =
+    NOTIFIER_LIST_INITIALIZER(machine_init_done_notifiers);
+
+static NotifierList exit_notifiers =
+    NOTIFIER_LIST_INITIALIZER(exit_notifiers);
+
+void qemu_add_machine_init_done_notifier(Notifier *notify)
+{
+    notifier_list_add(&machine_init_done_notifiers, notify);
+    if (machine_init_done) {
+        notify->notify(notify, NULL);
+    }
+}
+
+void qemu_remove_machine_init_done_notifier(Notifier *notify)
+{
+    notifier_remove(notify);
+}
+
+void qemu_run_machine_init_done_notifiers(void)
+{
+    machine_init_done = true;
+    notifier_list_notify(&machine_init_done_notifiers, NULL);
+}
+
+void qemu_add_exit_notifier(Notifier *notify)
+{
+    notifier_list_add(&exit_notifiers, notify);
+}
+
+void qemu_remove_exit_notifier(Notifier *notify)
+{
+    notifier_remove(notify);
+}
+
+void qemu_run_exit_notifiers(void)
+{
+    notifier_list_notify(&exit_notifiers, NULL);
+}
-- 
2.25.GIT


