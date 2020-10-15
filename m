Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D96CC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:20:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96D4920760
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H60BdgP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D4920760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT7rm-0005If-Cr
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 14:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1kT7fL-0002eO-Sf
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:07:52 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1kT7fI-0002bT-Uh
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:07:51 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FI50Bo128007;
 Thu, 15 Oct 2020 18:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding;
 s=corp-2020-01-29; bh=i1c2DByy/3LmwH3uwnjdZjjNDu+C48QAzBknVDTuUzc=;
 b=H60BdgP5HK147M1uBSDB+8hSRrNqqVP6frWbNX48M0cBSiq5oLqr6NTlAC9JxXRnWqn8
 64Xtpg3LZ/yOn73G69MeiB13yeSsS17AUw7h4Y1VJuWbBnyyImHTIyOjwJVpz6Jp/YVe
 timWwR/jt7lLsfXUvQYRtmPrMFXUfGsJkX2tBLRtaryJkPaUl3XgCNt9kbZh+e+tkYkN
 fU2Tvrh3VyjncikZsRu5QXENepA3mtWa+NU9NFqER8tV+3Gj7vhvbudWufcITBeBpl+N
 nNRLUhIGjaB4LXv5zGwOrhlAByo1XX/wxcJo+X+beFVuDENKZlS1o1ZkKlg6X6uZxXxf Ow== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2130.oracle.com with ESMTP id 346g8gkcrd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 Oct 2020 18:07:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FI5exY040260;
 Thu, 15 Oct 2020 18:05:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 344by5hhrc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Oct 2020 18:05:41 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09FI5WVs002093;
 Thu, 15 Oct 2020 18:05:32 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 15 Oct 2020 11:05:31 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 07/19] multi-process: Initialize message handler in remote
 device
Date: Thu, 15 Oct 2020 14:05:00 -0400
Message-Id: <328d4bac8da62f29574ccf9b5859289c1531cdca.1602784930.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1602784930.git.jag.raman@oracle.com>
References: <cover.1602784930.git.jag.raman@oracle.com>
In-Reply-To: <cover.1602784930.git.jag.raman@oracle.com>
References: <cover.1602784930.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 suspectscore=1 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010150121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 suspectscore=1
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150121
Received-SPF: pass client-ip=141.146.126.79; envelope-from=jag.raman@oracle.com;
 helo=aserp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 11:04:16
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 alex.williamson@redhat.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Initializes the message handler function in the remote process. It is
called whenever there's an event pending on QIOChannel that registers
this function.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS              |  1 +
 hw/i386/meson.build      |  1 +
 hw/i386/remote-msg.c     | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/i386/remote.h |  9 +++++++
 4 files changed, 72 insertions(+)
 create mode 100644 hw/i386/remote-msg.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 42b5da5..7314536 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3106,6 +3106,7 @@ F: hw/i386/remote.c
 F: include/hw/i386/remote.h
 F: io/mpqemu-link.c
 F: include/io/mpqemu-link.h
+F: hw/i386/remote-msg.c
 
 Build and test automation
 -------------------------
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index d9d4f40..3a2aa6e 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -25,6 +25,7 @@ i386_ss.add(when: 'CONFIG_PC', if_true: files(
   'acpi-build.c',
   'port92.c'))
 i386_ss.add(when: 'CONFIG_MPQEMU', if_true: files('remote.c'))
+i386_ss.add(when: 'CONFIG_MPQEMU', if_true: files('remote-msg.c'))
 
 subdir('kvm')
 subdir('xen')
diff --git a/hw/i386/remote-msg.c b/hw/i386/remote-msg.c
new file mode 100644
index 0000000..83fd7bd
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
index d312972..3073db6 100644
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
 #define TYPE_REMOTE_MACHINE "x-remote-machine"
 #define REMOTE_MACHINE(obj) \
     OBJECT_CHECK(RemoteMachineState, (obj), TYPE_REMOTE_MACHINE)
 
+void coroutine_fn mpqemu_remote_msg_loop_co(void *data);
+
 #endif
-- 
1.8.3.1


