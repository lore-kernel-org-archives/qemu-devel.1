Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD29AC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:31:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA1552084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o6EJ/39C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1552084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50970 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwPS-0003TF-VP
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58949)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwBW-0005en-OC
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwBS-00025S-Mg
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57448)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcwBS-0001ym-AX
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI8kVc065846;
 Mon, 17 Jun 2019 18:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=qHA0XPWNpBUQCEDqLyXVYTH83m+elOu8Ro8OwumTiLs=;
 b=o6EJ/39CTVnff8SG+xpuzF1gavK09pDx69afZ7YGGL5zNXcEuLJKuMKI8NENCaIj6Gpf
 r6OBfgc8CzFkDF3KOJ0LzvQ5Mm1VlFCjDiAcutCRK/hSACR18i0k/gub2/Bn6zdxsFeD
 lj6DZYw68UEU60Nxu8TjSG3H6tKOJXBtYnh1DfkmRhC52en13sSAL3v3ATpdqlWm7QIz
 D7F7nXawiEjMwtlW/QQLmtRqC5cJMlORYW7Br7pmlHasxsRP3/tW7E6hjINnz+dumEZk
 O+NPqDQlDkNOpnmR0RBV2kCEeAfshw0gQlAqPvFmWyqHfCmgYGSR5JG5dqyKta2WOt++ kg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2t4rmp00pd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIF5X8050183;
 Mon, 17 Jun 2019 18:16:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2t5h5t9ftb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:32 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5HIGVAf025270;
 Mon, 17 Jun 2019 18:16:31 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 18:16:31 +0000
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:16:29 -0700
Message-Id: <20190617181629.30187-1-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170162
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [RFC PATCH v2 23/35] multi-process: configure remote
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
Cc: elena.ufimtseva@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com,
 konrad.wilk@oracle.com, berrange@redhat.com, ross.lagerwall@citrix.com,
 liran.alon@oracle.com, stefanha@redhat.com, kanth.ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Add functions to configure remote devices.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 hw/proxy/qemu-proxy.c         | 38 ++++++++++++++++++++++++++++++++++-
 include/hw/proxy/qemu-proxy.h |  2 ++
 include/io/proxy-link.h       |  2 ++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index c691a05dac..1666cc546e 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -51,6 +51,7 @@
 #include "sysemu/kvm.h"
 #include "util/event_notifier-posix.c"
 #include "hw/boards.h"
+#include "include/qemu/log.h"
 
 /*
  * TODO: kvm_vm_ioctl is only available for per-target objects (NEED_CPU_H).
@@ -60,6 +61,39 @@
 int kvm_vm_ioctl(KVMState *s, int type, ...);
 
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
+
+    proxy_proc_send(pdev->proxy_link, &msg);
+
+    return;
+}
 
 int remote_spawn(PCIProxyDev *pdev, const char *command, Error **errp)
 {
@@ -292,7 +326,6 @@ static void init_proxy(PCIDevice *dev, char *command, Error **errp)
 
     proxy_link_set_sock(pdev->proxy_link, pdev->rsocket);
     configure_memory_sync(pdev->sync, pdev->proxy_link);
-    setup_irqfd(pdev);
 }
 
 static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
@@ -319,6 +352,9 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
     dev->init_proxy = init_proxy;
     dev->sync = REMOTE_MEM_SYNC(object_new(TYPE_MEMORY_LISTENER));
 
+    dev->set_remote_opts = set_remote_opts;
+    dev->proxy_ready = proxy_ready;
+
 }
 
 static void send_bar_access_msg(ProxyLinkState *proxy_link, MemoryRegion *mr,
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index b73077940c..4e949f778b 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -29,6 +29,8 @@
 #include "hw/proxy/memory-sync.h"
 #include "hw/pci/pci.h"
 #include "qemu/event_notifier.h"
+#include "hw/pci/pci.h"
+#include "block/qdict.h"
 
 #define TYPE_PCI_PROXY_DEV "pci-proxy-dev"
 
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index bf2555c97e..38bd80535a 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -72,6 +72,8 @@ typedef enum {
     BAR_WRITE,
     BAR_READ,
     SET_IRQFD,
+    DEV_OPTS,
+    DRIVE_OPTS,
     DEVICE_ADD,
     DEVICE_DEL,
     MAX,
-- 
2.17.1


