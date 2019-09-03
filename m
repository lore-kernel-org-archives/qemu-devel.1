Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E726C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:30:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48A1C2339E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RNtqDbql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A1C2339E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5GNO-0003CB-DQ
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5FaX-0008FD-7T
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FaV-0000uM-Uf
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37532)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FaV-0000tp-Mm
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KdY8c070955;
 Tue, 3 Sep 2019 20:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=pCUUTn8D7nq/xN69MM8FDXjkbfEeZhFTAK5krQ6GEbw=;
 b=RNtqDbqlMd2UJ44Nl9/5oORW7j6Bjo+6Zw4td79nQbC1t8Hi19Ef4myJwCj4DOB4sSg6
 Sr4dKrqvf3qxgvHBLNR53W1MKn/oPvB1rOfjO6dwJnLGf6dTdpWcm8BIShqtiQ6L2Tfl
 L6q18gA3btgSTEWCV/wntEpvYZMJYKGFEl0/MT9Ejnr273li7140wvdlA254UQeDp8d5
 ippHCkzyVtv2nkS93+cB/BKIvkAHkR+RmW6eWwaL52Q4uMXuF3136zLFKSzB5I9SiM6z
 SNGjCrqIvC5vGT5BhC2+uxa4eJlt8mtjvu12PC8SokBf93iLwYOLQvBbUq9JLnFB0v4V Qg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2usy4u834b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83Kc9Ri025299;
 Tue, 3 Sep 2019 20:39:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2us5pha0yb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:33 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83KdXBO013045;
 Tue, 3 Sep 2019 20:39:33 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:39:32 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:38:09 -0400
Message-Id: <d03fe8c51a046791e9885dc35fb509417d083c61.1567534653.git.jag.raman@oracle.com>
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
 definitions=main-1909030207
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [RFC v3 PATCH 43/45] multi-process: prevent duplicate
 memory initialization in remote
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

When multiple controllers are configured in a remote process,
it's better for the memory to be managed by only one of the proxy
objects for that process, in order to conserve file descriptors. Added
"mem_int" flag for this purpose.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 New patch in v3

 hw/proxy/qemu-proxy.c         | 13 ++++++++++++-
 include/hw/proxy/qemu-proxy.h |  1 +
 qdev-monitor.c                |  2 +-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index c812145..8b820cf 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -363,6 +363,13 @@ static void pci_proxy_write_config(PCIDevice *d, uint32_t addr, uint32_t val,
                    PCI_PROXY_DEV(d)->dev_id, CONF_WRITE);
 }
 
+static void pci_proxy_dev_inst_init(Object *obj)
+{
+    PCIProxyDev *dev = PCI_PROXY_DEV(obj);
+
+    dev->mem_init = false;
+}
+
 static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -377,6 +384,7 @@ static const TypeInfo pci_proxy_dev_type_info = {
     .name          = TYPE_PCI_PROXY_DEV,
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIProxyDev),
+    .instance_init = pci_proxy_dev_inst_init,
     .abstract      = true,
     .class_size    = sizeof(PCIProxyDevClass),
     .class_init    = pci_proxy_dev_class_init,
@@ -483,7 +491,10 @@ static void init_proxy(PCIDevice *dev, char *command, bool need_spawn, Error **e
     proxy_link_init_channel(pdev->proxy_link, &pdev->proxy_link->mmio,
                             pdev->mmio_sock);
 
-    configure_memory_sync(pdev->sync, pdev->proxy_link);
+    if (!pdev->mem_init) {
+        pdev->mem_init = true;
+        configure_memory_sync(pdev->sync, pdev->proxy_link);
+    }
 }
 
 static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index d88fbd4..610695f 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -51,6 +51,7 @@ typedef struct PCIProxyDev {
     ProxyLinkState *proxy_link;
 
     RemoteMemSync *sync;
+    bool mem_init;
     struct kvm_irqfd irqfd;
 
     EventNotifier intr;
diff --git a/qdev-monitor.c b/qdev-monitor.c
index f1065af..3b08e23 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -712,10 +712,10 @@ DeviceState *qdev_proxy_add(const char *rid, const char *id, char *bus,
         pdev->socket = old_pdev->socket;
         pdev->mmio_sock = old_pdev->mmio_sock;
         pdev->remote_pid = old_pdev->remote_pid;
+        pdev->mem_init = true;
     } else {
         pdev->rsocket = managed ? rsocket : -1;
         pdev->socket = managed ? rsocket : -1;
-
     }
     pdev->managed = managed;
 
-- 
1.8.3.1


