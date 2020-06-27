Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93D2C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 759D920775
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gdh1Dc2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 759D920775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpEUO-0006jl-MS
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 13:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpENC-0002Ul-9K
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:12:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35958)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpENA-0007S3-50
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:12:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH3JNh035284;
 Sat, 27 Jun 2020 17:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=4k9fx2q6kY1mKRKRGH07PEv7wgKf1PhBB3YTNZ5WUNg=;
 b=gdh1Dc2kcpUC/hRHFJdsGY3uaPvsKnCVzVMgseZ/AbGhrfAGlD1na5+D9fs/95s0xoWz
 prvBj5GDrrj5p7Lp04YUWgKdChS2BvJWDnxpEM3HSVSuX80oBMj1TrYY3gxmEffsNX3r
 RMz0E/re3kJWp1BRD89Spl1GDl2YYTi00R0cZZVf/jWLSJ/orOiLce4489DoUR+u9as0
 pmy/mr97KQ1e0dJCj0fDAiiZqDu6L8vGb5f23cEPgOItS8Ovc8DNsJDf5zkrrKXsa+gx
 UlewjrYx022HIGt+eiyIR0fgQXCDBoDMfcMryP1/Y4u9UjXMicRCj47tsZ6G1uFx5eOA BA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 31wwhr9cc8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 27 Jun 2020 17:12:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH8P04102197;
 Sat, 27 Jun 2020 17:10:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 31wwx17sgv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 27 Jun 2020 17:10:04 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05RHA4LB024189;
 Sat, 27 Jun 2020 17:10:04 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 27 Jun 2020 10:10:03 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v7 09/21] multi-process: Initialize message handler in remote
 device
Date: Sat, 27 Jun 2020 10:09:31 -0700
Message-Id: <6918de2756774d1c6e2c0f9105d8eeceff28938c.1593273671.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1593273671.git.elena.ufimtseva@oracle.com>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9665
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=3
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006270124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9665
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 cotscore=-2147483648
 mlxscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=3 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006270123
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 13:03:10
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
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
 liran.alon@oracle.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
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
 hw/i386/Makefile.objs    |  1 +
 hw/i386/remote-msg.c     | 52 ++++++++++++++++++++++++++++++++++++++++
 hw/i386/remote.c         |  4 ++++
 include/hw/i386/remote.h |  3 +++
 5 files changed, 61 insertions(+)
 create mode 100644 hw/i386/remote-msg.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 50a5fc53d6..e204b3e0c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2949,6 +2949,7 @@ F: hw/i386/remote.c
 F: include/hw/i386/remote.h
 F: io/mpqemu-link.c
 F: include/io/mpqemu-link.h
+F: hw/i386/remote-msg.c
 
 Build and test automation
 -------------------------
diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 5ead266a15..83969585c1 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -15,6 +15,7 @@ obj-$(CONFIG_VMPORT) += vmport.o
 obj-$(CONFIG_VMMOUSE) += vmmouse.o
 obj-$(CONFIG_PC) += port92.o
 obj-$(CONFIG_MPQEMU) += remote.o
+obj-$(CONFIG_MPQEMU) += remote-msg.o
 
 obj-y += kvmvapic.o
 obj-$(CONFIG_ACPI) += acpi-common.o
diff --git a/hw/i386/remote-msg.c b/hw/i386/remote-msg.c
new file mode 100644
index 0000000000..58e24ab2ad
--- /dev/null
+++ b/hw/i386/remote-msg.c
@@ -0,0 +1,52 @@
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
+    Error *local_err = NULL;
+    MPQemuMsg msg = { 0 };
+
+    if (cond & G_IO_HUP) {
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+    }
+
+    if (cond & (G_IO_ERR | G_IO_NVAL)) {
+        error_setg(&local_err, "Error %d while processing message from proxy \
+                   in remote process pid=%d", errno, getpid());
+        return FALSE;
+    }
+
+    if (mpqemu_msg_recv(&msg, ioc) < 0) {
+        return FALSE;
+    }
+
+    if (!mpqemu_msg_valid(&msg)) {
+        error_report("Received invalid message from proxy \
+                     in remote process pid=%d", getpid());
+        return TRUE;
+    }
+
+    switch (msg.cmd) {
+    default:
+        error_setg(&local_err, "Unknown command (%d) received from proxy \
+                   in remote process pid=%d", msg.cmd, getpid());
+    }
+
+    if (msg.data2) {
+        free(msg.data2);
+    }
+
+    if (local_err) {
+        error_report_err(local_err);
+        return FALSE;
+    }
+
+    return TRUE;
+}
diff --git a/hw/i386/remote.c b/hw/i386/remote.c
index 1a1becffe0..5342e884ad 100644
--- a/hw/i386/remote.c
+++ b/hw/i386/remote.c
@@ -16,6 +16,7 @@
 #include "exec/memory.h"
 #include "qapi/error.h"
 #include "io/channel-util.h"
+#include "io/channel.h"
 
 static void remote_machine_init(MachineState *machine)
 {
@@ -50,6 +51,9 @@ static void remote_set_socket(Object *obj, const char *str, Error **errp)
     int fd = atoi(str);
 
     s->ioc = qio_channel_new_fd(fd, &local_err);
+
+    qio_channel_add_watch(s->ioc, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+                          mpqemu_process_msg, NULL, NULL);
 }
 
 static void remote_instance_init(Object *obj)
diff --git a/include/hw/i386/remote.h b/include/hw/i386/remote.h
index 0f8b861e7a..c3890e57ab 100644
--- a/include/hw/i386/remote.h
+++ b/include/hw/i386/remote.h
@@ -30,4 +30,7 @@ typedef struct RemMachineState {
 #define REMOTE_MACHINE(obj) \
     OBJECT_CHECK(RemMachineState, (obj), TYPE_REMOTE_MACHINE)
 
+gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondition cond,
+                            gpointer opaque);
+
 #endif
-- 
2.25.GIT


