Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE57C38BFA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:23:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA0A4218AC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FzqvCtzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0A4218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6LCT-0001yT-3N
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kmy-0008LT-Bd
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kmx-00046k-4a
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:16 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Kmw-0003wV-So
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:15 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKra5g164127;
 Mon, 24 Feb 2020 20:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=myWcMfhqdAjSR8DPI97VT7FmO1ksEv3G863ka95yyYA=;
 b=FzqvCtzWqarBraJ7cSrwP8UoNkyL2seuFi6pe/9ufXzd6v1jQJygyK5w/dzahaS3oK3y
 nAW0yJObdw3y51DwrLMNycbrVNdMSAoMs1yu8auOnv1QSigW417qSllHJamTClwPorhB
 Gr7zLb4pNVKKgl1QsxRVDRdlW37h3Gali6tL5oI5ZsUZRj3CZPjHqwDZHtHrEyf+AYGd
 HUaPkBpkozVaqZO7Mxof+A6fTsXNjpr4l6q+cg6lZjch6Cxwyq9sDcdfHY8LMJ+SiUQ+
 TCOzhXKAd/Jcs5mrKdytpbXKw/r4R18HaKRGT1Ejd00vyuDef+SWTmydrcI5Roz6rhkD rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2ybvr4p989-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKqKQl171766;
 Mon, 24 Feb 2020 20:56:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2ybdshksj8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:58 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01OKuvc5030086;
 Mon, 24 Feb 2020 20:56:57 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:56 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 39/50] multi-process: prevent duplicate memory
 initialization in remote
Date: Mon, 24 Feb 2020 15:55:30 -0500
Message-Id: <c341ebff323d15a535b9a5a30aca1b9b6897bb51.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=1 spamscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=1 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
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

When multiple controllers are configured in a remote process,
it's better for the memory to be managed by only one of the proxy
objects for that process, in order to conserve file descriptors. Added
"mem_int" flag for this purpose.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 hw/proxy/qemu-proxy.c         | 13 ++++++++++++-
 include/hw/proxy/qemu-proxy.h |  1 +
 qdev-monitor.c                |  2 +-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 741f02a..b1b9282 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -453,6 +453,13 @@ static void proxy_device_reset(DeviceState *dev)
     close(wait);
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
@@ -470,6 +477,7 @@ static const TypeInfo pci_proxy_dev_type_info = {
     .name          = TYPE_PCI_PROXY_DEV,
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIProxyDev),
+    .instance_init = pci_proxy_dev_inst_init,
     .class_size    = sizeof(PCIProxyDevClass),
     .class_init    = pci_proxy_dev_class_init,
     .interfaces = (InterfaceInfo[]) {
@@ -566,7 +574,10 @@ static void init_proxy(PCIDevice *dev, char *command, char *exec_name,
     mpqemu_init_channel(pdev->mpqemu_link, &pdev->mpqemu_link->mmio,
                         pdev->mmio_sock);
 
-    configure_memory_sync(pdev->sync, pdev->mpqemu_link);
+    if (!pdev->mem_init) {
+        pdev->mem_init = true;
+        configure_memory_sync(pdev->sync, pdev->mpqemu_link);
+    }
 }
 
 static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index 2a2c732..5de8129 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -49,6 +49,7 @@ struct PCIProxyDev {
     MPQemuLinkState *mpqemu_link;
 
     RemoteMemSync *sync;
+    bool mem_init;
     struct kvm_irqfd irqfd;
 
     EventNotifier intr;
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 27b2ddc..f120509 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -732,9 +732,9 @@ DeviceState *qdev_proxy_add(const char *rid, const char *id, char *bus,
         pdev->socket = old_pdev->socket;
         pdev->mmio_sock = old_pdev->mmio_sock;
         pdev->remote_pid = old_pdev->remote_pid;
+        pdev->mem_init = true;
     } else {
         pdev->socket = managed ? socket : -1;
-
     }
     pdev->managed = managed;
 
-- 
1.8.3.1


