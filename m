Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33706C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 11:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1CC22133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 11:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AQ1IwIwn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CC22133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46584 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEXbM-0000hk-7D
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 07:10:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hEXTT-0003F6-OT
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hEXTP-0000tB-89
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:02:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hEXTN-0007Hb-Jj
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:02:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3BArwCC090728; Thu, 11 Apr 2019 11:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id : in-reply-to : references : mime-version :
	content-transfer-encoding; s=corp-2018-07-02;
	bh=1lQQU8onCKOeE0LqztxuYSPLnayuzTvoGHT3m+GuAYM=;
	b=AQ1IwIwnVKXev37V2LLMBBSyRqh+i9auAZi0vm3Gl/3DfeD5jQgH/zvLponypZkrdEJm
	JwRxf3byDJbvJALK4cJjSBXyfr5vc+/kljOyGSCiZqAAa+S9obL9EFr7nJfhav7mSvQk
	ho+YuYxqBcIr7cUbNdD1bJcnaiR7eaN5jwFEK3P34sUIzq2B4nH0ejiP6EgqKSOjMmhA
	XencES8PwIjzrpBFeC/LX4yW9vuxlJT9Dupq7xKYNHPWUImguYuinG2QRW3R5ELO8IQC
	0S4Rzpsw78pJSyoVcZ5Rc0ABC5uPYycrjdiAd18i7ar17fwEeRFoW8dYN+k3Wp9r4Qxc
	4g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 2rpmrqg6s8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2019 11:02:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3BB1k5i060041; Thu, 11 Apr 2019 11:02:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3020.oracle.com with ESMTP id 2rpytcq8tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2019 11:02:06 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3BB25iP014715;
	Thu, 11 Apr 2019 11:02:05 GMT
Received: from host4.lan (/77.138.183.59)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 11 Apr 2019 04:02:04 -0700
From: Yuval Shaia <yuval.shaia@oracle.com>
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org,
	mst@redhat.com, cohuck@redhat.com, marcel.apfelbaum@gmail.com,
	linux-rdma@vger.kernel.org, jgg@mellanox.com
Date: Thu, 11 Apr 2019 14:01:55 +0300
Message-Id: <20190411110157.14252-2-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411110157.14252-1-yuval.shaia@oracle.com>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9223
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904110077
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9223
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904110077
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [RFC 1/3] virtio-net: Move some virtio-net-pci decl to
 include/hw/virtio
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411110155.b_gP3mTI-0DTn0hZwqu8VQv-fP0zZNYj44R924Uwzoc@z>

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/virtio/virtio-net-pci.c         | 18 ++-------------
 include/hw/virtio/virtio-net-pci.h | 35 ++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 16 deletions(-)
 create mode 100644 include/hw/virtio/virtio-net-pci.h

diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
index db07ab9e21..63617d5550 100644
--- a/hw/virtio/virtio-net-pci.c
+++ b/hw/virtio/virtio-net-pci.c
@@ -17,24 +17,10 @@
 
 #include "qemu/osdep.h"
 
-#include "hw/virtio/virtio-net.h"
+#include "hw/virtio/virtio-net-pci.h"
 #include "virtio-pci.h"
 #include "qapi/error.h"
 
-typedef struct VirtIONetPCI VirtIONetPCI;
-
-/*
- * virtio-net-pci: This extends VirtioPCIProxy.
- */
-#define TYPE_VIRTIO_NET_PCI "virtio-net-pci-base"
-#define VIRTIO_NET_PCI(obj) \
-        OBJECT_CHECK(VirtIONetPCI, (obj), TYPE_VIRTIO_NET_PCI)
-
-struct VirtIONetPCI {
-    VirtIOPCIProxy parent_obj;
-    VirtIONet vdev;
-};
-
 static Property virtio_net_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
@@ -82,7 +68,7 @@ static void virtio_net_pci_instance_init(Object *obj)
 
 static const VirtioPCIDeviceTypeInfo virtio_net_pci_info = {
     .base_name             = TYPE_VIRTIO_NET_PCI,
-    .generic_name          = "virtio-net-pci",
+    .generic_name          = TYPE_VIRTIO_NET_PCI_GENERIC,
     .transitional_name     = "virtio-net-pci-transitional",
     .non_transitional_name = "virtio-net-pci-non-transitional",
     .instance_size = sizeof(VirtIONetPCI),
diff --git a/include/hw/virtio/virtio-net-pci.h b/include/hw/virtio/virtio-net-pci.h
new file mode 100644
index 0000000000..f14e6ed992
--- /dev/null
+++ b/include/hw/virtio/virtio-net-pci.h
@@ -0,0 +1,35 @@
+/*
+ * PCI Virtio Network Device
+ *
+ * Copyright IBM, Corp. 2007
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef QEMU_VIRTIO_NET_PCI_H
+#define QEMU_VIRTIO_NET_PCI_H
+
+#include "hw/virtio/virtio-net.h"
+#include "virtio-pci.h"
+
+typedef struct VirtIONetPCI VirtIONetPCI;
+
+/*
+ * virtio-net-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_NET_PCI_GENERIC "virtio-net-pci"
+#define TYPE_VIRTIO_NET_PCI "virtio-net-pci-base"
+#define VIRTIO_NET_PCI(obj) \
+        OBJECT_CHECK(VirtIONetPCI, (obj), TYPE_VIRTIO_NET_PCI)
+
+struct VirtIONetPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIONet vdev;
+};
+
+#endif
-- 
2.20.1


