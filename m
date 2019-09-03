Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BB0C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:13:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EBFB21897
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pV/rFPeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EBFB21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5G6l-0004Yx-DP
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5FaR-00087c-GE
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FaQ-0000qC-9W
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60762)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FaQ-0000pX-19
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KdRrc067219;
 Tue, 3 Sep 2019 20:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=g9Q8L0XLVMN0buTbSVSf7NJVZyxcqAaV9TdcvRBTvug=;
 b=pV/rFPeZOZC8F/wVhNiLB709zdWVqcUxkxGc8poz9j8QzISl7hpgCeHpV2OGgQF3uGos
 7rAKGgl2jQlcR9MSrEIWA4je97/0YsnalGXAmKzU6KuMEBmNH/Cjw+JzTz2f5xPCgs3g
 +o/cjobZcGBY8quR037xqvKvyrMtjK+qleKpGNTi9mEsN8ww4nn1o4BmcazWKMt98JQj
 fElB/y+v/SMLhziQhdqlXwOk92wkLRu1USqNx21niBGQ3VWaQ3jPxFzgMP7lTHsBF4lU
 Yu97r/hwx+hdBsLBG+KhbGQuFjSdJ5Grd4TuPBT7W/mmXL1GTkJH2ggz7ZdaCPaYpx0v Lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2usy66r2ht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KcCi0025802;
 Tue, 3 Sep 2019 20:39:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2us5pha0sd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:23 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83KdMEH012875;
 Tue, 3 Sep 2019 20:39:22 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:39:21 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:38:03 -0400
Message-Id: <3759424c8abd52955a2abe0a619dfaa79293e8ec.1567534653.git.jag.raman@oracle.com>
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
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [RFC v3 PATCH 37/45] multi-process: perform device
 reset in the remote process
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

Perform device reset in the remote process when QEMU performs
device reset. This is required to reset the internal state
(like registers, etc...) of emulated devices

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 New patch in v3

 hw/proxy/proxy-lsi53c895a.c   |  6 ++++++
 hw/proxy/qemu-proxy.c         | 14 ++++++++++++++
 include/hw/proxy/qemu-proxy.h |  2 ++
 include/io/proxy-link.h       |  1 +
 remote/remote-main.c          | 11 +++++++++++
 5 files changed, 34 insertions(+)

diff --git a/hw/proxy/proxy-lsi53c895a.c b/hw/proxy/proxy-lsi53c895a.c
index e8a8d36..8640749 100644
--- a/hw/proxy/proxy-lsi53c895a.c
+++ b/hw/proxy/proxy-lsi53c895a.c
@@ -128,6 +128,11 @@ static void proxy_lsi_realize(PCIProxyDev *dev, Error **errp)
     pci_register_bar(pci_dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->ram_io);
 }
 
+static void proxy_lsi_reset(DeviceState *dev)
+{
+    proxy_device_reset(dev);
+}
+
 static void proxy_lsi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -145,6 +150,7 @@ static void proxy_lsi_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 
     dc->desc = "LSI Proxy Device";
+    dc->reset = proxy_lsi_reset;
 }
 
 static const TypeInfo lsi_proxy_dev_type_info = {
diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index db9a208..c812145 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -588,3 +588,17 @@ uint64_t proxy_default_bar_read(PCIProxyDev *dev, MemoryRegion *mr, hwaddr addr,
 
     return val;
 }
+
+void proxy_device_reset(DeviceState *dev)
+{
+    PCIProxyDev *pdev = PCI_PROXY_DEV(dev);
+    ProcMsg msg;
+
+    memset(&msg, 0, sizeof(ProcMsg));
+
+    msg.bytestream = 0;
+    msg.size = sizeof(msg.data1);
+    msg.cmd = DEVICE_RESET;
+
+    proxy_proc_send(pdev->proxy_link, &msg, pdev->proxy_link->com);
+}
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index a03c6cc..d88fbd4 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -100,4 +100,6 @@ void proxy_default_bar_write(PCIProxyDev *dev, MemoryRegion *mr, hwaddr addr,
 uint64_t proxy_default_bar_read(PCIProxyDev *dev, MemoryRegion *mr, hwaddr addr,
                                 unsigned size, bool memory);
 
+void proxy_device_reset(DeviceState *dev);
+
 #endif /* QEMU_PROXY_H */
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index 32b2c1a..eb51d29 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -76,6 +76,7 @@ typedef enum {
     DEVICE_DEL,
     PROXY_PING,
     MMIO_RETURN,
+    DEVICE_RESET,
     MAX,
 } proc_cmd_t;
 
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 2a9ebae..a6ff338 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -66,6 +66,9 @@
 #include "qemu/cutils.h"
 #include "remote-opts.h"
 
+#include "monitor/monitor.h"
+#include "sysemu/reset.h"
+
 static ProxyLinkState *proxy_link;
 
 typedef struct remote_pci_devs {
@@ -302,6 +305,11 @@ fail:
     del_from_pci_devs_list((const char *)msg->id);
 }
 
+static void process_device_reset_msg(ProcMsg *msg)
+{
+    qemu_devices_reset();
+}
+
 static int init_drive(QDict *rqdict, Error **errp)
 {
     QemuOpts *opts;
@@ -520,6 +528,9 @@ static void process_msg(GIOCondition cond, ProcChannel *chan)
         notify_proxy(wait, (uint32_t)getpid());
         PUT_REMOTE_WAIT(wait);
         break;
+    case DEVICE_RESET:
+        process_device_reset_msg(msg);
+        break;
     default:
         error_setg(&err, "Unknown command");
         goto finalize_loop;
-- 
1.8.3.1


