Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CD5C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:25:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC72922B42
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WnR0yxNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC72922B42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1ZiJ-0006uB-1F
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 14:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1k1ZeM-0001ir-Fz
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:20:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36562)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1k1ZeK-0005MT-Db
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:20:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VICNa3055889;
 Fri, 31 Jul 2020 18:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding;
 s=corp-2020-01-29; bh=fqZkHL+Lq0OIw+iBNmqKPRMYmFD9NYg+1iNuL7DR8+s=;
 b=WnR0yxNqnw5tmV+qerUcxEgYk0hGdHQHMKWUcifc8DZFYoVLyvkavyQ0vMBwqZ8lWk4j
 /98NWNceW87m3rqd9owC5J4clm8mdG3mXL15iqg/TQ+L2tQ2tvzCdskLh+LwO/lZBfSe
 eEuXkAGc6xu2Q8qZM1YNb7sP5L4MYXOtktnGLxYD/x/5kdIlxn8DZu4wYasTltOcNcvU
 6tVcn6lKcKw6rYGLY3pliF8ioZ9uxk+UmeZWmJhNc0jWagRkON4CTToYzKlKxio+AgrE
 8n0ngEepRHVxfy2HE0Tc87AamTYCIixwKOl2Rs1e5qrNm9tdQYpceiIBIHcPK0wOSaFN Pw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 32mf9g2tq4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 Jul 2020 18:20:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VIHVlB074002;
 Fri, 31 Jul 2020 18:20:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 32hu606sau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Jul 2020 18:20:49 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06VIKmjL023526;
 Fri, 31 Jul 2020 18:20:48 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 31 Jul 2020 11:20:48 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 08/20] multi-process: Initialize message handler in remote
 device
Date: Fri, 31 Jul 2020 14:20:15 -0400
Message-Id: <0851c9322a54f6cba2de750529f9ebf21e1ba50e.1596217462.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1596217462.git.jag.raman@oracle.com>
References: <cover.1596217462.git.jag.raman@oracle.com>
In-Reply-To: <cover.1596217462.git.jag.raman@oracle.com>
References: <cover.1596217462.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0
 suspectscore=1 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=1 clxscore=1015 mlxscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310136
Received-SPF: pass client-ip=141.146.126.78; envelope-from=jag.raman@oracle.com;
 helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 14:20:51
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
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
---
 MAINTAINERS              |  1 +
 hw/i386/Makefile.objs    |  1 +
 hw/i386/remote-msg.c     | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/i386/remote.h |  4 +++
 4 files changed, 70 insertions(+)
 create mode 100644 hw/i386/remote-msg.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 41fe809..40e0654 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3046,6 +3046,7 @@ F: hw/i386/remote.c
 F: include/hw/i386/remote.h
 F: io/mpqemu-link.c
 F: include/io/mpqemu-link.h
+F: hw/i386/remote-msg.c
 
 Build and test automation
 -------------------------
diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 5ead266..8396958 100644
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
index 0000000..4315d2c
--- /dev/null
+++ b/hw/i386/remote-msg.c
@@ -0,0 +1,64 @@
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
+
+    if (cond & G_IO_HUP) {
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+        return FALSE;
+    }
+
+    if (cond & (G_IO_ERR | G_IO_NVAL)) {
+        error_report("Error %d while processing message from proxy \
+                   in remote process pid=%d", errno, getpid());
+        return FALSE;
+    }
+
+    mpqemu_msg_recv(&msg, ioc, &local_err);
+    if (local_err) {
+        goto exit;
+    }
+
+    if (!mpqemu_msg_valid(&msg)) {
+        error_report("Received invalid message from proxy \
+                     in remote process pid=%d", getpid());
+        return FALSE;
+    }
+
+    switch (msg.cmd) {
+    default:
+        error_setg(&local_err,
+                   "Unknown command (%d) received for device %s (pid=%d)",
+                   msg.cmd, DEVICE(pci_dev)->id, getpid());
+    }
+
+    mpqemu_msg_cleanup(&msg);
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
index 5b36b25..7f9028f 100644
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
1.8.3.1


