Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC03C38C00
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCB5B218AC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wPejLVWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB5B218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6LHs-0004FA-SX
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kn5-0000DG-KE
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kn4-0004CN-8x
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:23 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54132)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Kn3-00042p-W6
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKraG9164141;
 Mon, 24 Feb 2020 20:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=r33JqoYyvd7qRET/DSaqmHS6AvTJ0RmaWoQwJRwosSY=;
 b=wPejLVWQJV0EispF7OgFGpqA8zm6wRQeDTIdM/mf7smtF3048/87zIK1fG2upe+p0fK6
 h7JguyfHvUAXKYbO7rL/G5hndPqKXLWHXdeHVltCb+jRkkiXtNn23lIft3s8qm4+kDcI
 /sXFFzu0vB2pFnwLoFnql0TfgxdV80El5kOaWcUL4On2odH5opytvEc2tEXouwlfHym0
 Udtfn3+FDYJvgPUDkgAhukf5QqiQQnS74dFKJ4MZsQJbdHGuSHDW2e0gh8/clMN3x0LJ
 Zg5mWbwWQuqy2dmCuMEAdC+tuowE9fhF5eHLPFv3ihsqFhnWmVYMnTz2FsJXe6Nefl7m VQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2ybvr4p99a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:57:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKqoFK172448;
 Mon, 24 Feb 2020 20:57:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2ybdshkss5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:57:06 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OKv42U028905;
 Mon, 24 Feb 2020 20:57:05 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:57:04 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 44/50] multi-process/mig: refactor runstate_check into
 common file
Date: Mon, 24 Feb 2020 15:55:35 -0500
Message-Id: <99597f15a6e42c34b5a2e7f88430ed56c89feb76.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=1 spamscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
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

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

runstate_check file is refactored into vl-parse.c

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 Makefile.objs             |  2 ++
 include/sysemu/runstate.h |  2 ++
 runstate.c                | 36 ++++++++++++++++++++++++++++++++++++
 softmmu/vl.c              | 10 ----------
 stubs/runstate-check.c    |  3 +++
 5 files changed, 43 insertions(+), 10 deletions(-)
 create mode 100644 runstate.c

diff --git a/Makefile.objs b/Makefile.objs
index 65009da..cf2200d 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -40,6 +40,7 @@ remote-pci-obj-$(CONFIG_MPQEMU) += blockdev.o
 remote-pci-obj-$(CONFIG_MPQEMU) += qdev-monitor.o
 remote-pci-obj-$(CONFIG_MPQEMU) += bootdevice.o
 remote-pci-obj-$(CONFIG_MPQEMU) += iothread.o
+remote-pci-obj-$(CONFIG_MPQEMU) += runstate.o
 
 ##############################################################
 # remote-lsi-obj-y is code used to implement remote LSI device
@@ -103,6 +104,7 @@ qemu-seccomp.o-libs := $(SECCOMP_LIBS)
 common-obj-$(CONFIG_FDT) += device_tree.o
 
 common-obj-y += vl-parse.o
+common-obj-y += runstate.o
 
 #######################################################################
 # qapi
diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index f760094..ece939f 100644
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
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 42d5682..d95ee2f 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -620,11 +620,6 @@ static int default_driver_check(void *opaque, QemuOpts *opts, Error **errp)
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
@@ -732,11 +727,6 @@ static const RunStateTransition runstate_transitions_def[] = {
 
 static bool runstate_valid_transitions[RUN_STATE__MAX][RUN_STATE__MAX];
 
-bool runstate_check(RunState state)
-{
-    return current_run_state == state;
-}
-
 bool runstate_store(char *str, size_t size)
 {
     const char *state = RunState_str(current_run_state);
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
-- 
1.8.3.1


