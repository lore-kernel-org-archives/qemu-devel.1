Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9B0C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:05:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 864F721883
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N0z9o2Pl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864F721883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Fzk-0006E3-D6
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5FZs-0007Pm-VM
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FZr-0000My-Oj
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36640)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FZr-0000L5-FZ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KXnAZ066152;
 Tue, 3 Sep 2019 20:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=GUtOh6uWmy5bBzOxxzJ1uCCKmTjk2dTU82Y4WxCFH9g=;
 b=N0z9o2PlxKEEX+lSRQaazjyIsUChKHzY4WuqMFBQBr3rmiwNqoza8SiCDrksLdkxK7T+
 Nh3HunISNjzXo1dFTl7deGUgPMM4+tWUd/V/RkHDhGV8rKsKmFxjtuRnX42SQcTkISA2
 Knydyu2Tavf9vP8YXx+a8h7KvuDEN9JTH1T0QH5xoup+drdb+F4sigwC8EGS7KXKtzxq
 D1EljkCVXY4KJ7Gyj1hkngwjqeTHcF4GqlBv6iGDLao4fxwGGpVdmLyccerCj8MSp+EF
 ijz5As/nMwuwNwCkRRMzrnf5RRrI1lii4wlUljYzJyScDNFafj7XwrEM3lQhDyQVFyTa MA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2usy4u830w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KcMJf095268;
 Tue, 3 Sep 2019 20:38:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2usu51u1u6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:52 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83Kcpj9012358;
 Tue, 3 Sep 2019 20:38:51 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:38:50 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:37:44 -0400
Message-Id: <74468c1d1d6d7ff7afb08d367edb6979ea5e3a31.1567534653.git.jag.raman@oracle.com>
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
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [RFC v3 PATCH 18/45] multi-process: support dev id in
 config read/write
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
---
 New patch in v3

 hw/proxy/qemu-proxy.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 1021045..789f39a 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -151,12 +151,16 @@ static void set_proxy_sock(PCIDevice *dev, int socket)
 }
 
 static int config_op_send(PCIProxyDev *dev, uint32_t addr, uint32_t *val, int l,
-                          unsigned int op)
+                          char *id, unsigned int op)
 {
     ProcMsg msg;
     struct conf_data_msg conf_data;
     int wait;
 
+    if (!id) {
+        return -EINVAL;
+    }
+
     memset(&msg, 0, sizeof(ProcMsg));
     conf_data.addr = addr;
     conf_data.val = (op == CONF_WRITE) ? *val : 0;
@@ -171,6 +175,8 @@ static int config_op_send(PCIProxyDev *dev, uint32_t addr, uint32_t *val, int l,
     msg.size = sizeof(conf_data);
     msg.cmd = op;
     msg.bytestream = 1;
+    msg.id = (uint8_t *)g_strdup(dev->dev_id);
+    msg.size_id = strlen(dev->dev_id) + 1;
 
     if (op == CONF_WRITE) {
         msg.num_fds = 0;
@@ -188,6 +194,7 @@ static int config_op_send(PCIProxyDev *dev, uint32_t addr, uint32_t *val, int l,
     }
 
     free(msg.data2);
+    free(msg.id);
 
     return 0;
 }
@@ -198,7 +205,8 @@ static uint32_t pci_proxy_read_config(PCIDevice *d, uint32_t addr, int len)
 
     (void)pci_default_read_config(d, addr, len);
 
-    config_op_send(PCI_PROXY_DEV(d), addr, &val, len, CONF_READ);
+    config_op_send(PCI_PROXY_DEV(d), addr, &val, len,
+                   PCI_PROXY_DEV(d)->dev_id, CONF_READ);
 
     return val;
 }
@@ -208,7 +216,8 @@ static void pci_proxy_write_config(PCIDevice *d, uint32_t addr, uint32_t val,
 {
     pci_default_write_config(d, addr, val, l);
 
-    config_op_send(PCI_PROXY_DEV(d), addr, &val, l, CONF_WRITE);
+    config_op_send(PCI_PROXY_DEV(d), addr, &val, l,
+                   PCI_PROXY_DEV(d)->dev_id, CONF_WRITE);
 }
 
 static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
-- 
1.8.3.1


