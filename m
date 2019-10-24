Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA84CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8857420684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CLRwokvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8857420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZdF-0006Ep-Fj
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZA1-0000uU-Fn
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:12:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ9z-00052e-KE
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:12:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33590)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZ9y-00051r-UJ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:11:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94MZL094876;
 Thu, 24 Oct 2019 09:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=N8PJ1VFLIRV6XErZ+8XozqEUwrGNVhMsDzQHeeVf7e8=;
 b=CLRwokvAAFypNPmna/GjuHSF2ECutc/tmUMIZRK43SVh9Kq3QCMG2FkqkEsgbdnBuSJC
 gjgBExn3nYQMX6F3U9PqbOGotR7rCDHKhoqZitEfdo3apIYl0VmM28PG2dqPoYexdv6p
 ZKirPeyPnWMAOSbf2kL+ZWEf0DoyvZI1EpOvEof7PLdvVT7IGBpqaNqNrKXOvRdJVDf7
 Hh8AneCpqdyQ5kgY+q3gyxmYzkUEs7V5yvh6J/UEIKioXqjHpNSGYU1PkBSP63SGlXtP
 qScpvEWuM284KTL7AxcdS8JlMHTZf3anVVteZ+pph50E7uUYTiEVMcX83DcTv/mopplf Aw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2vqu4r24t4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:11:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O98jLj076057;
 Thu, 24 Oct 2019 09:11:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2vtjkj30sy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:11:52 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9O9BpZP024555;
 Thu, 24 Oct 2019 09:11:51 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:11:50 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 44/49] multi-process/mig: refactor runstate_check into
 common file
Date: Thu, 24 Oct 2019 05:09:25 -0400
Message-Id: <ee0c69c6f3c80bba6646260f92f4c4d8176f0a54.1571905346.git.jag.raman@oracle.com>
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

runstate_check file is refactored into vl-parse.c

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 New patch in v4

 Makefile.objs             |  2 ++
 include/sysemu/runstate.h |  2 ++
 runstate.c                | 36 ++++++++++++++++++++++++++++++++++++
 stubs/runstate-check.c    |  3 +++
 vl-parse.c                |  1 -
 vl.c                      | 10 ----------
 6 files changed, 43 insertions(+), 11 deletions(-)
 create mode 100644 runstate.c

diff --git a/Makefile.objs b/Makefile.objs
index ebb1938..66fbee0 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -38,6 +38,7 @@ remote-pci-obj-$(CONFIG_MPQEMU) += blockdev.o
 remote-pci-obj-$(CONFIG_MPQEMU) += qdev-monitor.o
 remote-pci-obj-$(CONFIG_MPQEMU) += bootdevice.o
 remote-pci-obj-$(CONFIG_MPQEMU) += iothread.o
+remote-pci-obj-$(CONFIG_MPQEMU) += runstate.o
 
 ##############################################################
 # remote-lsi-obj-y is code used to implement remote LSI device
@@ -111,6 +112,7 @@ qemu-seccomp.o-libs := $(SECCOMP_LIBS)
 common-obj-$(CONFIG_FDT) += device_tree.o
 
 common-obj-y += vl-parse.o
+common-obj-y += runstate.o
 
 remote-pci-obj-$(CONFIG_MPQEMU) += net/
 
diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 0b41555..e89ebf8 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -4,6 +4,8 @@
 #include "qapi/qapi-types-run-state.h"
 #include "qemu/notify.h"
 
+extern RunState current_run_state;
+
 bool runstate_check(RunState state);
 void runstate_set(RunState new_state);
 int runstate_is_running(void);
diff --git a/runstate.c b/runstate.c
new file mode 100644
index 0000000..273345a
--- /dev/null
+++ b/runstate.c
@@ -0,0 +1,36 @@
+/*
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
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "sysemu/runstate.h"
+
+/***********************************************************/
+/* QEMU state */
+
+RunState current_run_state = RUN_STATE_PRECONFIG;
+
+bool runstate_check(RunState state)
+{
+    return current_run_state == state;
+}
diff --git a/stubs/runstate-check.c b/stubs/runstate-check.c
index 2ccda2b..3038bcb 100644
--- a/stubs/runstate-check.c
+++ b/stubs/runstate-check.c
@@ -1,6 +1,9 @@
 #include "qemu/osdep.h"
 
 #include "sysemu/runstate.h"
+
+#pragma weak runstate_check
+
 bool runstate_check(RunState state)
 {
     return state == RUN_STATE_PRELAUNCH;
diff --git a/vl-parse.c b/vl-parse.c
index 1c8ecbe..3bf1f0f 100644
--- a/vl-parse.c
+++ b/vl-parse.c
@@ -159,4 +159,3 @@ int rdevice_init_func(void *opaque, QemuOpts *opts, Error **errp)
     return 0;
 }
 #endif
-
diff --git a/vl.c b/vl.c
index 8a26d81..725429b 100644
--- a/vl.c
+++ b/vl.c
@@ -665,11 +665,6 @@ static int default_driver_check(void *opaque, QemuOpts *opts, Error **errp)
     return 0;
 }
 
-/***********************************************************/
-/* QEMU state */
-
-static RunState current_run_state = RUN_STATE_PRECONFIG;
-
 /* We use RUN_STATE__MAX but any invalid value will do */
 static RunState vmstop_requested = RUN_STATE__MAX;
 static QemuMutex vmstop_lock;
@@ -777,11 +772,6 @@ static const RunStateTransition runstate_transitions_def[] = {
 
 static bool runstate_valid_transitions[RUN_STATE__MAX][RUN_STATE__MAX];
 
-bool runstate_check(RunState state)
-{
-    return current_run_state == state;
-}
-
 bool runstate_store(char *str, size_t size)
 {
     const char *state = RunState_str(current_run_state);
-- 
1.8.3.1


