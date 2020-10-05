Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93CFC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:03:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6443920FC3
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BO9cqe9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6443920FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPVlK-0001lA-El
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 15:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kPVaB-0006eJ-Jv
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 14:51:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kPVa9-00083e-Ag
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 14:51:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095InPjl184594;
 Mon, 5 Oct 2020 18:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=F56bvLYTO4rQ82quXFrq0H0xxB6A2M92PAv/VM0qrVg=;
 b=BO9cqe9anoJGtnvAI3lG34arvQ/9Q//1SvKRnPq6HBzDv3c5llJdSQMwz3gyY0yl23+N
 BhjQg9+hs82JdSPLTY8nt7ZW7mHmUjL5YGJAZeY6vCRhMUiDxRYqSzhL/3RZhhRnVHCA
 vASTyD6X3ZlPsrZSyp4y4pqovqSozqTuJad/NLPueWLtNxiDMmk1gH8p2UNaYeBRZGMX
 QhWI4w4LBu9d91FojauQagR3E7oAGO9cRnCe8FAErrOwepeXelVuEcPf7P+QbJILalMZ
 dFmZzcWGFk6M5pDma/J64PJIR/28bjOq7eKwh0oJF7PRu0Y8RA54G+oHOkkzrScF4oJ0 DQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 33xhxmq54r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 05 Oct 2020 18:51:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095IpDj4182621;
 Mon, 5 Oct 2020 18:51:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 33y2vkvf5k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 05 Oct 2020 18:51:23 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 095IpM6V005270;
 Mon, 5 Oct 2020 18:51:22 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 05 Oct 2020 11:51:22 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v10 07/19] multi-process: Initialize message handler in remote
 device
Date: Mon,  5 Oct 2020 11:50:55 -0700
Message-Id: <5d30e11c97869c7ae9ce6fd9c3318098ee8f23ec.1601923020.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1601923020.git.elena.ufimtseva@oracle.com>
References: <cover.1601923020.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 malwarescore=0 suspectscore=1 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=1 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050136
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 12:40:53
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
 hw/i386/remote-msg.c     | 61 ++++++++++++++++++++++++++++++++++++++++
 include/hw/i386/remote.h |  9 ++++++
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
index 0000000000..83fd7bd852
--- /dev/null
+++ b/hw/i386/remote-msg.c
@@ -0,0 +1,61 @@
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
+void coroutine_fn mpqemu_remote_msg_loop_co(void *data)
+{
+    RemoteCommDev *com = (RemoteCommDev *)data;
+    PCIDevice *pci_dev = NULL;
+
+    pci_dev = com->dev;
+    for (;;) {
+        MPQemuMsg msg = {0};
+        Error *local_err = NULL;
+
+        if (!com->ioc) {
+            error_report("ERROR: No channel available");
+            break;
+        }
+        mpqemu_msg_recv(&msg, com->ioc, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            break;
+        }
+
+        if (!mpqemu_msg_valid(&msg)) {
+            error_report("Received invalid message from proxy"
+                         "in remote process pid=%d", getpid());
+            break;
+        }
+
+        switch (msg.cmd) {
+        default:
+            error_setg(&local_err,
+                       "Unknown command (%d) received for device %s (pid=%d)",
+                       msg.cmd, DEVICE(pci_dev)->id, getpid());
+        }
+
+        if (local_err) {
+            error_report_err(local_err);
+            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+            break;
+        }
+    }
+    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+
+    return;
+}
diff --git a/include/hw/i386/remote.h b/include/hw/i386/remote.h
index 5b36b25ca1..e21bd5f68f 100644
--- a/include/hw/i386/remote.h
+++ b/include/hw/i386/remote.h
@@ -14,6 +14,7 @@
 #include "qom/object.h"
 #include "hw/boards.h"
 #include "hw/pci-host/remote.h"
+#include "io/channel.h"
 
 typedef struct RemoteMachineState {
     MachineState parent_obj;
@@ -21,8 +22,16 @@ typedef struct RemoteMachineState {
     RemotePCIHost *host;
 } RemoteMachineState;
 
+/* Used to pass to co-routine device and ioc. */
+typedef struct RemoteCommDev {
+    PCIDevice *dev;
+    QIOChannel *ioc;
+} RemoteCommDev;
+
 #define TYPE_REMOTE_MACHINE "remote-machine"
 #define REMOTE_MACHINE(obj) \
     OBJECT_CHECK(RemoteMachineState, (obj), TYPE_REMOTE_MACHINE)
 
+void coroutine_fn mpqemu_remote_msg_loop_co(void *data);
+
 #endif
-- 
2.25.GIT


