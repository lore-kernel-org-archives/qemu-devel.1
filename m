Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AF5C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC9B2230F2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p7YM7yoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9B2230F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Fm6-0001Vh-Nc
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 16:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5FZz-0007Ze-Vx
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FZx-0000Ry-L5
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57028)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FZx-0000Qh-Bo
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KXfki053278;
 Tue, 3 Sep 2019 20:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=AAj/+tREyKBkCTDYSnVjDbyD9kk7j1Ya6lqslo/cMuU=;
 b=p7YM7yoenVaYfzuDc20JekfP3TYmK10PjrVC1dIRKuhAShd25Kw3wtHMObEF6R/MuU6g
 xQCezRjsbu8vb0nXzdRjj7Rs3oCZVSJARK9+gAd2NwW3A6jL4RbuNu4r1h3kaH5cDhbh
 QcOoGUe5FPdZGDsIIIaClKnz0iI+d7PVB3e77ZQ8MrP3Y95lCCag+rKZ3j2uNRJIPdGO
 VZK8dGtLNpEq/v8bdWQdVqbnYHjsO2fH3Uuwr1iOLg8KgtyJrB5qW/6DrNVl5tsCbJ2W
 QRJDyvHOaT1S5owkb1jyVAXPZo31ozgpYuD5LB9KU0wynw169BhhkiJ/xnFHdyWO70Yq VQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2usy6n020x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KcYYE178175;
 Tue, 3 Sep 2019 20:38:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2us4wegqqw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:59 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83Kcw91012411;
 Tue, 3 Sep 2019 20:38:58 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:38:58 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:37:48 -0400
Message-Id: <8d7ad61c3b4d43ec73a8fd9c56b3b652b5a7da72.1567534653.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030207
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030206
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [RFC v3 PATCH 22/45] multi-process: configure remote
 side devices
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

Add functions to configure remote devices.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 hw/proxy/qemu-proxy.c         | 43 ++++++++++++++++++++++++++++++++++++++++++-
 include/hw/proxy/qemu-proxy.h |  2 ++
 include/io/proxy-link.h       |  4 ++++
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index f92d29a..dea6784 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -50,8 +50,47 @@
 #include "qemu/event_notifier.h"
 #include "sysemu/kvm.h"
 #include "util/event_notifier-posix.c"
+#include "hw/boards.h"
+#include "include/qemu/log.h"
 
 static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
+static void setup_irqfd(PCIProxyDev *dev);
+
+static void proxy_ready(PCIDevice *dev)
+{
+    PCIProxyDev *pdev = PCI_PROXY_DEV(dev);
+
+    setup_irqfd(pdev);
+}
+
+static void set_remote_opts(PCIDevice *dev, QDict *qdict, unsigned int cmd)
+{
+    QString *qstr;
+    ProcMsg msg;
+    const char *str;
+    PCIProxyDev *pdev;
+
+    pdev = PCI_PROXY_DEV(dev);
+
+    qstr = qobject_to_json(QOBJECT(qdict));
+    str = qstring_get_str(qstr);
+
+    memset(&msg, 0, sizeof(ProcMsg));
+
+    msg.data2 = (uint8_t *)str;
+    msg.cmd = cmd;
+    msg.bytestream = 1;
+    msg.size = qstring_get_length(qstr) + 1;
+    msg.num_fds = 0;
+    if (pdev->dev_id) {
+        msg.id = (uint8_t *)pdev->dev_id;
+        msg.size_id = strlen((char *)pdev->dev_id) + 1;
+    }
+
+    proxy_proc_send(pdev->proxy_link, &msg, pdev->proxy_link->com);
+
+    return;
+}
 
 static int add_argv(char *command_str, char **argv, int argc)
 {
@@ -344,7 +383,6 @@ static void init_proxy(PCIDevice *dev, char *command, bool need_spawn, Error **e
                             pdev->socket);
 
     configure_memory_sync(pdev->sync, pdev->proxy_link);
-    setup_irqfd(pdev);
 }
 
 static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
@@ -364,6 +402,9 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
     dev->get_proxy_sock = get_proxy_sock;
     dev->init_proxy = init_proxy;
     dev->sync = REMOTE_MEM_SYNC(object_new(TYPE_MEMORY_LISTENER));
+
+    dev->set_remote_opts = set_remote_opts;
+    dev->proxy_ready = proxy_ready;
 }
 
 static void send_bar_access_msg(PCIProxyDev *dev, MemoryRegion *mr,
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index e73835e..4312f9e 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -28,6 +28,8 @@
 #include "io/proxy-link.h"
 #include "hw/proxy/memory-sync.h"
 #include "qemu/event_notifier.h"
+#include "hw/pci/pci.h"
+#include "block/qdict.h"
 
 #define TYPE_PCI_PROXY_DEV "pci-proxy-dev"
 
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index e70bf50..13fb312 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -70,6 +70,10 @@ typedef enum {
     BAR_WRITE,
     BAR_READ,
     SET_IRQFD,
+    DEV_OPTS,
+    DRIVE_OPTS,
+    DEVICE_ADD,
+    DEVICE_DEL,
     MAX,
 } proc_cmd_t;
 
-- 
1.8.3.1


