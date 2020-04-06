Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410B5C2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:52:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0790B206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rH5IqK5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0790B206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOQf-0003qf-3T
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 05:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGo-0002BU-59
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGm-0002Ka-Pc
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jLOGm-0002Jh-Fw
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369cw59025095;
 Mon, 6 Apr 2020 09:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=b3tR5kc/fZFEBgfsLLZnsuzzLDNVQvVsWREjDfZMZ4I=;
 b=rH5IqK5K5Pn1Kk+dl0juay/pKJYx6jgizwSxUx4ZIGowRh78zHOb54bXBvNrhnPdGBjZ
 geSy6wQBbGugBjkUCoGt8DootuZAMT0RWvYe7o6MF2dyEUziblRwb/qK8WWVjXBVgkVI
 qOr5mCPhBOe/weeVaEJqPS2no0aq8XELSJN8WVq1+q+10Dc+xo6zDHs5EwBfegAHA1g9
 tkBV13Rl6k2IWEhhEH+x5pcVq4jkJQX7jjgTFasMxv/8gCgvKOMroZ4VEVgtDLSMfF5Z
 dP1TeuZKTspm3dYooPZOZTedl8OLhlU8HTi9ZwEz1EfBRSm7TDTI6VtY/esvCw/ND0iP BA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 306jvmwr55-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:42:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369fNth066091;
 Mon, 6 Apr 2020 09:42:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 307419xgyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:42:02 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0369g2lx030676;
 Mon, 6 Apr 2020 09:42:02 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 06 Apr 2020 02:42:01 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v6 18/36] multi-process: Initialize Proxy Object's
 communication channel
Date: Mon,  6 Apr 2020 02:41:08 -0700
Message-Id: <b504fd16c5f23df23134e3915bcbd3ffc9470e34.1586165556.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1586165555.git.elena.ufimtseva@oracle.com>
References: <cover.1586165555.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=1
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060083
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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

Add "socket" object property which initializes the communication channel

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 hw/proxy/qemu-proxy.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index bf6c4117ef..40bf56fd37 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -14,6 +14,25 @@
 #include "hw/proxy/qemu-proxy.h"
 #include "hw/pci/pci.h"
 
+static void proxy_set_socket(Object *obj, const char *str, Error **errp)
+{
+    PCIProxyDev *pdev = PCI_PROXY_DEV(obj);
+
+    pdev->socket = atoi(str);
+
+    mpqemu_init_channel(pdev->mpqemu_link, &pdev->mpqemu_link->com,
+                        pdev->socket);
+}
+
+static void proxy_init(Object *obj)
+{
+    PCIProxyDev *pdev = PCI_PROXY_DEV(obj);
+
+    pdev->mpqemu_link = mpqemu_link_create();
+
+    object_property_add_str(obj, "socket", NULL, proxy_set_socket, NULL);
+}
+
 static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
 {
     PCIProxyDev *dev = PCI_PROXY_DEV(device);
@@ -41,6 +60,7 @@ static const TypeInfo pci_proxy_dev_type_info = {
     .instance_size = sizeof(PCIProxyDev),
     .class_size    = sizeof(PCIProxyDevClass),
     .class_init    = pci_proxy_dev_class_init,
+    .instance_init = proxy_init,
     .interfaces = (InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
-- 
2.25.GIT


