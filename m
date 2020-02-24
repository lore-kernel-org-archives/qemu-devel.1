Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB67C38BE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 20:59:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8AAF21556
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 20:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iWZnQyrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8AAF21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6KpD-0003Be-SX
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 15:59:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6Klx-0005ni-Dc
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Klw-0002pR-0p
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:13 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52506)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Klv-0002mw-1J
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:11 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKrZj7164095;
 Mon, 24 Feb 2020 20:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=wZO3A2sTSI60a6rOgnl5OMupRv+gO+g6Ho8RtvDFics=;
 b=iWZnQyrzIpp1HQdyJc092xe49Gyj4EleomNOdJQ75g6pDWq4dP0flZVa7VayrYbKxhlI
 WajJE6tjdOC4fi9sQEXu+JCmSzP0CNro/Lf4j4pSKDH9Vua1eloQvnQJ5AIABT42Za73
 YTtkNbdOSG+fnC4Xv55aCog7xoe0J10nAQcixyUEGqLTdV4euPUvPFXJ4st+oRGrlDja
 lYLMGaZRWt9HF9xyNXAhkOryoD/xl+41z1eprJyGTyMWrJTToYJNeEhrKGtG+XZjCzqn
 cEmHH06B1UqqZsJsew7nRkDL6culQIV2cgkBxCTRo5vQBjlU6hmdXWHbM40ydqAv3+0a qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2ybvr4p929-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKq7Wd088963;
 Mon, 24 Feb 2020 20:56:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2yby5dm9s7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:00 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OKtwvp028220;
 Mon, 24 Feb 2020 20:55:58 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:55:58 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 02/50] multi-process: Refactor machine_init and exit
 notifiers
Date: Mon, 24 Feb 2020 15:54:53 -0500
Message-Id: <5087037defe31df3abbcd677d206540247649b83.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0
 suspectscore=1 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=1 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
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

Relocate machine_int and exit notifiers into common code

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 include/sysemu/sysemu.h |  2 ++
 softmmu/vl.c            | 42 ------------------------------------------
 util/notify.c           | 43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 42 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index dec64fc..2f37e2b 100644
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
index 92c7b3a..94a7b93 100644
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
@@ -2324,21 +2318,6 @@ static MachineClass *machine_parse(const char *name, GSList *machines)
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
 
@@ -2349,27 +2328,6 @@ static void qemu_unlink_pidfile(Notifier *n, void *data)
     }
 }
 
-bool machine_init_done;
-
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
diff --git a/util/notify.c b/util/notify.c
index 76bab21..0e7479b 100644
--- a/util/notify.c
+++ b/util/notify.c
@@ -15,6 +15,15 @@
 
 #include "qemu/osdep.h"
 #include "qemu/notify.h"
+#include "sysemu/sysemu.h"
+
+bool machine_init_done;
+
+static NotifierList machine_init_done_notifiers =
+    NOTIFIER_LIST_INITIALIZER(machine_init_done_notifiers);
+
+static NotifierList exit_notifiers =
+    NOTIFIER_LIST_INITIALIZER(exit_notifiers);
 
 void notifier_list_init(NotifierList *list)
 {
@@ -74,3 +83,37 @@ int notifier_with_return_list_notify(NotifierWithReturnList *list, void *data)
     }
     return ret;
 }
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
1.8.3.1


