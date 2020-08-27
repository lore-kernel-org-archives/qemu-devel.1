Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960F3C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 18:26:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AEBD2087E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 18:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CRXwvsCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AEBD2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBMbG-0003mz-N0
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 14:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kBMQY-0004TQ-1V
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 14:15:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33262)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kBMQV-0007UK-Tx
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 14:15:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07RIEn6U027359;
 Thu, 27 Aug 2020 18:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=CybB/yG/bQoOrCODshdUZtfubGaxmBvgtfOKg9pBEuA=;
 b=CRXwvsCd386ZqB0KX++A5rJqZj7CKJ5wapIBxY1dKmxnoMT19ku78usnRfA/Rz5f/W9U
 jE2NmDHllvxDo/Cl/4VtyyTsz+5jICU6ZEb/xubgZ6yvU4Sr4B8eMEiI7ZwWMsEx+SzS
 MF68tjWXBNlKccxjJBd1bVl48Ra6tB15Lsu/jKX5SvxVghFNWDWT6FCsGvrJgmpy42L/
 QZy8UsaOT3+uMmptve2/YAbqIP+YWiOxlggA/wtkPY0O6QLk6eD6MWzu2ftWm8D1PFw/
 2z9bWYhFWHLAI2MhoXRfWe9n2Qg6C8g5einZXJb9k9qM4/sXSQkzOD2oc/BbjrZe7I8H 9Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 333dbs7yhf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Aug 2020 18:15:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07RI4tED072620;
 Thu, 27 Aug 2020 18:13:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 333r9nqymm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2020 18:13:01 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07RICxTc021081;
 Thu, 27 Aug 2020 18:12:59 GMT
Received: from flaka.hsd1.ca.comcast.net (/10.159.136.159)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 27 Aug 2020 11:12:58 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v9 08/20] multi-process: Initialize message handler in remote
 device
Date: Thu, 27 Aug 2020 11:12:19 -0700
Message-Id: <20200827181231.22778-9-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
References: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008270136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=1
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270137
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=elena.ufimtseva@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 14:13:10
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 stefanha@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jagannathan Raman <jag.raman@oracle.com>

Initializes the message handler function in the remote process. It is
called whenever there's an event pending on QIOChannel that registers
this function.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 MAINTAINERS              |  1 +
 hw/i386/meson.build      |  1 +
 hw/i386/remote-msg.c     | 66 ++++++++++++++++++++++++++++++++++++++++
 include/hw/i386/remote.h |  4 +++
 4 files changed, 72 insertions(+)
 create mode 100644 hw/i386/remote-msg.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ca1f8ccff..9885c9499f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3047,6 +3047,7 @@ F: hw/i386/remote.c
 F: include/hw/i386/remote.h
 F: io/mpqemu-link.c
 F: include/io/mpqemu-link.h
+F: hw/i386/remote-msg.c
 
 Build and test automation
 -------------------------
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 1c1668c5db..238ae0879d 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -24,6 +24,7 @@ i386_ss.add(when: 'CONFIG_PC', if_true: files(
   'acpi-build.c',
   'port92.c'))
 i386_ss.add(when: 'CONFIG_MPQEMU', if_true: files('remote.c'))
+i386_ss.add(when: 'CONFIG_MPQEMU', if_true: files('remote-msg.c'))
 
 subdir('kvm')
 subdir('xen')
diff --git a/hw/i386/remote-msg.c b/hw/i386/remote-msg.c
new file mode 100644
index 0000000000..2a855d5850
--- /dev/null
+++ b/hw/i386/remote-msg.c
@@ -0,0 +1,66 @@
+/*
+ * Copyright © 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL-v2, version 2 or later.
+ *
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+#include "hw/i386/remote.h"
+#include "io/channel.h"
+#include "io/mpqemu-link.h"
+#include "qapi/error.h"
+#include "sysemu/runstate.h"
+
+gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondition cond,
+                            gpointer opaque)
+{
+    PCIDevice *pci_dev = (PCIDevice *)opaque;
+    Error *local_err = NULL;
+    MPQemuMsg msg = { 0 };
+    MPQemuRequest req = { 0 };
+
+    if (cond & G_IO_HUP) {
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+        return FALSE;
+    }
+
+    if (cond & (G_IO_ERR | G_IO_NVAL)) {
+        error_report("Error %d while processing message from proxy"
+                     "in remote process pid=%d", errno, getpid());
+        return FALSE;
+    }
+
+    req.msg = &msg;
+    req.ioc = ioc;
+
+    mpqemu_msg_recv_in_co(&req, ioc, &local_err);
+    if (local_err) {
+        goto exit;
+    }
+
+    if (!mpqemu_msg_valid(&msg)) {
+        error_report("Received invalid message from proxy"
+                     "in remote process pid=%d", getpid());
+        return FALSE;
+    }
+
+    switch (msg.cmd) {
+    default:
+        error_setg(&local_err,
+                   "Unknown command (%d) received for device %s (pid=%d)",
+                   req.msg->cmd, DEVICE(pci_dev)->id, getpid());
+    }
+
+exit:
+    if (local_err) {
+        error_report_err(local_err);
+        return FALSE;
+    }
+
+    return TRUE;
+}
diff --git a/include/hw/i386/remote.h b/include/hw/i386/remote.h
index 5b36b25ca1..7f9028fcce 100644
--- a/include/hw/i386/remote.h
+++ b/include/hw/i386/remote.h
@@ -14,6 +14,7 @@
 #include "qom/object.h"
 #include "hw/boards.h"
 #include "hw/pci-host/remote.h"
+#include "io/channel.h"
 
 typedef struct RemoteMachineState {
     MachineState parent_obj;
@@ -25,4 +26,7 @@ typedef struct RemoteMachineState {
 #define REMOTE_MACHINE(obj) \
     OBJECT_CHECK(RemoteMachineState, (obj), TYPE_REMOTE_MACHINE)
 
+gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondition cond,
+                            gpointer opaque);
+
 #endif
-- 
2.25.GIT


