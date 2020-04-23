Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02507C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:28:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDDB22075A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n2TOW5XU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDDB22075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRTTX-0006I8-Qq
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 00:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTHq-0002cR-VF
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTHq-0001mL-3c
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:16:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42416)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jRTHp-0001lI-Je
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:16:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4Cgi8131617;
 Thu, 23 Apr 2020 04:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=D7zhh7DfvdBrdzrMah9OjgPIqq0A9PS4ecWwLXqZZfE=;
 b=n2TOW5XUKnAUEiL9StABNdsm6v85kv4nMfczMlTPs2oST10vlPFcG3lU1NJvAWuKv84J
 yY2ET7vhhHdj0jVC82LIFtuV5+34IVBl9rEzLgA6k6epksY7CEior6/eVlk8KwFvQGNg
 DeFE3SUPNyQi+hUqx2LYfKj58/DSe6N9trfqgndrrwMaYfy7z53VeQyywME+3c5kKc7W
 4zqNS2ontloeYv0ZQlgKvFdvqJGGVk1bQzAP21dlKGAG/T9FsNEp91Z3w5RgTYseKatE
 5pHRG2UVhw4td+Udt4txV3TXP6Mnn2KrEusWULkSGqPcLLnxKhr8iY2xpNesNgWe9M9e 2w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 30jvq4s937-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:16:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4BfY6093736;
 Thu, 23 Apr 2020 04:14:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 30gb3ux067-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:14:23 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03N4ELOh020051;
 Thu, 23 Apr 2020 04:14:21 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 22 Apr 2020 21:14:20 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v6 02/36] multi-process: Refactor machine_init and exit
 notifiers
Date: Wed, 22 Apr 2020 21:13:37 -0700
Message-Id: <acd4af5297d0bdec6126a5ebfebc519fca3a3875.1587614626.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1587614626.git.elena.ufimtseva@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=1 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=elena.ufimtseva@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 00:14:28
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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

Relocate machine_int and exit notifiers into common code

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 MAINTAINERS                 |  1 +
 Makefile.objs               |  1 +
 include/sysemu/sysemu.h     |  2 ++
 softmmu/vl.c                | 42 ----------------------
 stubs/Makefile.objs         |  2 ++
 stubs/machine-init-add.c    |  7 ++++
 stubs/machine-init-done.c   |  5 ++-
 stubs/machine-init-remove.c |  8 +++++
 util/machine-notify.c       | 69 +++++++++++++++++++++++++++++++++++++
 9 files changed, 92 insertions(+), 45 deletions(-)
 create mode 100644 stubs/machine-init-add.c
 create mode 100644 stubs/machine-init-remove.c
 create mode 100644 util/machine-notify.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8cbc1fac2b..04b19ac56c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2133,6 +2133,7 @@ F: util/qemu-timer.c
 F: softmmu/vl.c
 F: softmmu/main.c
 F: qapi/run-state.json
+F: util/machine-notify.c
 
 Human Monitor (HMP)
 M: Dr. David Alan Gilbert <dgilbert@redhat.com>
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
index 32c0047889..39cbb6b50d 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -172,12 +172,6 @@ int icount_align_option;
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
@@ -2325,21 +2319,6 @@ static MachineClass *machine_parse(const char *name, GSList *machines)
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
 
@@ -2350,27 +2329,6 @@ static void qemu_unlink_pidfile(Notifier *n, void *data)
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
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 45be5dc0ed..f884bb6180 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -43,4 +43,6 @@ stub-obj-y += pci-host-piix.o
 stub-obj-y += ram-block.o
 stub-obj-y += ramfb.o
 stub-obj-y += fw_cfg.o
+stub-obj-y += machine-init-add.o
+stub-obj-y += machine-init-remove.o
 stub-obj-$(CONFIG_SOFTMMU) += semihost.o
diff --git a/stubs/machine-init-add.c b/stubs/machine-init-add.c
new file mode 100644
index 0000000000..520dcb9801
--- /dev/null
+++ b/stubs/machine-init-add.c
@@ -0,0 +1,7 @@
+#include "qemu/osdep.h"
+#include "sysemu/sysemu.h"
+
+void qemu_add_machine_init_done_notifier(Notifier *notify)
+{
+}
+
diff --git a/stubs/machine-init-done.c b/stubs/machine-init-done.c
index cd8e81392d..a34d838f7a 100644
--- a/stubs/machine-init-done.c
+++ b/stubs/machine-init-done.c
@@ -3,6 +3,5 @@
 
 bool machine_init_done = true;
 
-void qemu_add_machine_init_done_notifier(Notifier *notify)
-{
-}
+NotifierList machine_init_done_notifiers =
+    NOTIFIER_LIST_INITIALIZER(machine_init_done_notifiers);
diff --git a/stubs/machine-init-remove.c b/stubs/machine-init-remove.c
new file mode 100644
index 0000000000..30aee27c2d
--- /dev/null
+++ b/stubs/machine-init-remove.c
@@ -0,0 +1,8 @@
+#include "qemu/osdep.h"
+#include "sysemu/sysemu.h"
+
+void qemu_remove_machine_init_done_notifier(Notifier *notify)
+{
+}
+
+
diff --git a/util/machine-notify.c b/util/machine-notify.c
new file mode 100644
index 0000000000..718af79335
--- /dev/null
+++ b/util/machine-notify.c
@@ -0,0 +1,69 @@
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
+bool machine_init_done;
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


