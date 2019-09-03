Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83320C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4388E208E4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ctb1/SRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4388E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Fnb-0003WG-Oy
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 16:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5FZs-0007OR-07
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FZq-0000LB-RW
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59924)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FZq-0000KM-JI
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KXqVE062439;
 Tue, 3 Sep 2019 20:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=PrJg6TSW3hB3SOAHdr8gQqvqSW+zQgyWsqtOk/RNj3g=;
 b=ctb1/SRi9aAcw0xMMuseE+yU9t16SipL9nGv7kE3Q1m3wzoFNqLKtnko2KJt/XFg3LRy
 hmSFyMgs3yJFiYPvbrLVARQwmwVU0NC2FrDsYHGcNFeeOYIOxYPc+7NaNQkraUtziHSB
 reWy9MLyhN+3aPMXOKs449RTfrG7RV2+yjDcNpc6FU6I42VoFyrj5Kqics93Cllfmmzn
 WvKAaga3yVYzFZLwX66lJlpCY6xV+dc3+l31Oa7aFMP5ysAMfFr39nw5o7GRKRzNsOyc
 aqviygzRdg7QZ/AOpqVMOeCk6BFJ0G3UZrR24UUxYBc+SnBp2C5aJyhsHztaID4XF02z iQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2usy66r2ed-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KcZMI178242;
 Tue, 3 Sep 2019 20:38:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2us4wegqfa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:51 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83KcnKI017496;
 Tue, 3 Sep 2019 20:38:50 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:38:49 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:37:43 -0400
Message-Id: <41b228aa6e1cd78146ac23d59f06060dcd4c7bfc.1567534653.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030207
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030206
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [RFC v3 PATCH 17/45] multi-process: modify BARs
 read/write to support dev_id
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

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
---
 New patch in v3

 hw/proxy/qemu-proxy.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 44668bf..1021045 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -288,13 +288,16 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
     dev->init_proxy = init_proxy;
 }
 
-static void send_bar_access_msg(ProxyLinkState *proxy_link, MemoryRegion *mr,
+static void send_bar_access_msg(PCIProxyDev *dev, MemoryRegion *mr,
                                 bool write, hwaddr addr, uint64_t *val,
                                 unsigned size, bool memory)
 {
+    ProxyLinkState *proxy_link;
     ProcMsg msg;
     int wait;
 
+    proxy_link = dev->proxy_link;
+
     memset(&msg, 0, sizeof(ProcMsg));
 
     msg.bytestream = 0;
@@ -314,18 +317,31 @@ static void send_bar_access_msg(ProxyLinkState *proxy_link, MemoryRegion *mr,
         msg.fds[0] = wait;
     }
 
+    if (dev->dev_id) {
+        msg.size_id = strlen(dev->dev_id) + 1;
+        msg.id = calloc(1, msg.size_id);
+        memcpy(msg.id, dev->dev_id, msg.size_id);
+    } else {
+        msg.size_id = 0;
+    }
+
     proxy_proc_send(proxy_link, &msg, proxy_link->com);
 
     if (!write) {
         *val = wait_for_remote(wait);
         PUT_REMOTE_WAIT(wait);
     }
+
+    if (msg.id) {
+        free(msg.id);
+    }
+
 }
 
 void proxy_default_bar_write(PCIProxyDev *dev, MemoryRegion *mr, hwaddr addr,
                              uint64_t val, unsigned size, bool memory)
 {
-    send_bar_access_msg(dev->proxy_link, mr, true, addr, &val, size, memory);
+    send_bar_access_msg(dev, mr, true, addr, &val, size, memory);
 }
 
 uint64_t proxy_default_bar_read(PCIProxyDev *dev, MemoryRegion *mr, hwaddr addr,
@@ -333,7 +349,7 @@ uint64_t proxy_default_bar_read(PCIProxyDev *dev, MemoryRegion *mr, hwaddr addr,
 {
     uint64_t val;
 
-    send_bar_access_msg(dev->proxy_link, mr, false, addr, &val, size, memory);
+    send_bar_access_msg(dev, mr, false, addr, &val, size, memory);
 
     return val;
 }
-- 
1.8.3.1


