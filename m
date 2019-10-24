Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB55CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:21:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D54205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="grzprsxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D54205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZJb-0007na-55
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ8m-0006Va-H7
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ8l-0004E6-9o
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:10:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59870)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZ8l-0004DZ-1A
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:10:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94rfs100053;
 Thu, 24 Oct 2019 09:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=iMg6Ts1aZSw54dFDez9o2my5CKYdiynWWTJ9KPLx0Os=;
 b=grzprsxus2shgwvAgQfxmLcK8PlUhmzIdMbtXSJf2yy8EEtLRB+bD0ui1vTVPxSxMnD3
 95iNidXWGFfmwP9Znqnm2Vrja7Gn+iVt05cvi3tncAqT4VsaHRPluFXpBBP0bIW8H6h/
 NZRwIymfsThASdV6ZCKwz1LZ2PszKCG0VXjLER+wro5i73y8suYHg3/FV3IgTjmSa/en
 LErvtGyQdZHso50BkVnfvJtiqSwkLqDI04RS6Jx/kc4CPV/WM4gxepA7Kyme/+/JZMvm
 4tNSKr57JZa00HH7zejPF88KGBMSQ/d4Zm2tV1MfsGfzQKN9o7MdkTxvCioYCW9mj8Yl FA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2vqteq2afh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:10:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O983a6093263;
 Thu, 24 Oct 2019 09:10:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2vtm244guh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:10:37 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9O9Aark002164;
 Thu, 24 Oct 2019 09:10:36 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:10:36 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 19/49] multi-process: configure remote side devices
Date: Thu, 24 Oct 2019 05:09:00 -0400
Message-Id: <f36f81254336de4efb71b4869bd3c9e02d328392.1571905346.git.jag.raman@oracle.com>
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
 hw/proxy/qemu-proxy.c         | 39 ++++++++++++++++++++++++++++++++++++++-
 include/hw/proxy/qemu-proxy.h |  2 ++
 include/io/mpqemu-link.h      |  4 ++++
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index bd7dd35..3b84055 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -50,8 +50,43 @@
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
+    MPQemuMsg msg;
+    const char *str;
+    PCIProxyDev *pdev;
+
+    pdev = PCI_PROXY_DEV(dev);
+
+    qstr = qobject_to_json(QOBJECT(qdict));
+    str = qstring_get_str(qstr);
+
+    memset(&msg, 0, sizeof(MPQemuMsg));
+
+    msg.data2 = (uint8_t *)str;
+    msg.cmd = cmd;
+    msg.bytestream = 1;
+    msg.size = qstring_get_length(qstr) + 1;
+    msg.num_fds = 0;
+
+    mpqemu_msg_send(pdev->mpqemu_link, &msg, pdev->mpqemu_link->com);
+
+    return;
+}
 
 static int add_argv(char *command_str, char **argv, int argc)
 {
@@ -325,7 +360,6 @@ static void init_proxy(PCIDevice *dev, char *command, bool need_spawn, Error **e
                         pdev->socket);
 
     configure_memory_sync(pdev->sync, pdev->mpqemu_link);
-    setup_irqfd(pdev);
 }
 
 static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
@@ -357,6 +391,9 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
     dev->get_proxy_sock = get_proxy_sock;
     dev->init_proxy = init_proxy;
     dev->sync = REMOTE_MEM_SYNC(object_new(TYPE_MEMORY_LISTENER));
+
+    dev->set_remote_opts = set_remote_opts;
+    dev->proxy_ready = proxy_ready;
 }
 
 static void send_bar_access_msg(PCIProxyDev *dev, MemoryRegion *mr,
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index 0fad7e3..80aadf9 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -28,6 +28,8 @@
 #include "io/mpqemu-link.h"
 #include "hw/proxy/memory-sync.h"
 #include "qemu/event_notifier.h"
+#include "hw/pci/pci.h"
+#include "block/qdict.h"
 
 #define TYPE_PCI_PROXY_DEV "pci-proxy-dev"
 
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 1885ad7..3145b0e 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -68,6 +68,10 @@ typedef enum {
     BAR_WRITE,
     BAR_READ,
     SET_IRQFD,
+    DEV_OPTS,
+    DRIVE_OPTS,
+    DEVICE_ADD,
+    DEVICE_DEL,
     MAX,
 } mpqemu_cmd_t;
 
-- 
1.8.3.1


