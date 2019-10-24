Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A63DCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E798A205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C2hi090u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E798A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNa0q-0001Ax-Fu
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZBO-0005Qw-Fy
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZBN-0005my-6S
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:13:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34384)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZBM-0005mk-Uq
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:13:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94s7L100066;
 Thu, 24 Oct 2019 09:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=yI2wGKXkkFdVlfFpbe0//221YQeG7qB/jqZ/0nHBlMY=;
 b=C2hi090uhSq4aOmMojHR/mpeWhpSYhOr9qFLtnqieTGBrTRdG/XvR5Me2jyG4SF8RA9G
 aUTf9c/6oqy20pmnk9uUnV+JzJx7opv4TjzcL7N4BwyJPTirRtkHEGGn+Eu4HWUZ+q4+
 3yiRtnkIkhZ+jZUxV/IpP+zthnPSfOpR8qgNl1Sv22DINnnrCjgifFEgPKXuRBy1DdG0
 tQegBkS27Hw7xOzYGJtYRu4ZgQVBa7LjitWsVPSPSRhJsDtG7VoSG+rQY34sqcgvRqxv
 yvOEBrd9OEekNZG04h4jZ3zbG79+s7fHvHr1oiLtIkl/DqYiD4k/gbw5OcUHZTu4TWm7 6A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2vqteq2att-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:13:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O97n26170844;
 Thu, 24 Oct 2019 09:11:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2vtsk4884n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:11:17 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9O9BGiU002536;
 Thu, 24 Oct 2019 09:11:16 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:11:16 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 33/49] multi-process: perform device reset in the
 remote process
Date: Thu, 24 Oct 2019 05:09:14 -0400
Message-Id: <7579c5df98f9c09933685209395aa4a0e0ceb857.1571905346.git.jag.raman@oracle.com>
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
 include/io/mpqemu-link.h      |  1 +
 remote/remote-main.c          | 11 +++++++++++
 5 files changed, 34 insertions(+)

diff --git a/hw/proxy/proxy-lsi53c895a.c b/hw/proxy/proxy-lsi53c895a.c
index 7734ae2..f6bd8a1 100644
--- a/hw/proxy/proxy-lsi53c895a.c
+++ b/hw/proxy/proxy-lsi53c895a.c
@@ -57,6 +57,11 @@ static void proxy_lsi_realize(PCIProxyDev *dev, Error **errp)
                           &dev->region[2], "proxy-lsi-ram", 0x2000);
 }
 
+static void proxy_lsi_reset(DeviceState *dev)
+{
+    proxy_device_reset(dev);
+}
+
 static void proxy_lsi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -74,6 +79,7 @@ static void proxy_lsi_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 
     dc->desc = "LSI Proxy Device";
+    dc->reset = proxy_lsi_reset;
 }
 
 static const TypeInfo lsi_proxy_dev_type_info = {
diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 74aecd3..5aada67 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -577,3 +577,17 @@ const MemoryRegionOps proxy_default_ops = {
         .max_access_size = 1,
     },
 };
+
+void proxy_device_reset(DeviceState *dev)
+{
+    PCIProxyDev *pdev = PCI_PROXY_DEV(dev);
+    MPQemuMsg msg;
+
+    memset(&msg, 0, sizeof(MPQemuMsg));
+
+    msg.bytestream = 0;
+    msg.size = sizeof(msg.data1);
+    msg.cmd = DEVICE_RESET;
+
+    mpqemu_msg_send(pdev->mpqemu_link, &msg, pdev->mpqemu_link->com);
+}
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index 5e858cc..672303c 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -112,4 +112,6 @@ void proxy_default_bar_write(void *opaque, hwaddr addr, uint64_t val,
 
 uint64_t proxy_default_bar_read(void *opaque, hwaddr addr, unsigned size);
 
+void proxy_device_reset(DeviceState *dev);
+
 #endif /* QEMU_PROXY_H */
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 4911eea..6fcc6f5 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -74,6 +74,7 @@ typedef enum {
     DEVICE_DEL,
     PROXY_PING,
     MMIO_RETURN,
+    DEVICE_RESET,
     MAX,
 } mpqemu_cmd_t;
 
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 0a1326d..4459d26 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -66,8 +66,11 @@
 #include "qemu/log.h"
 #include "qemu/cutils.h"
 #include "remote-opts.h"
+#include "monitor/monitor.h"
+#include "sysemu/reset.h"
 
 static MPQemuLinkState *mpqemu_link;
+
 PCIDevice *remote_pci_dev;
 bool create_done;
 
@@ -237,6 +240,11 @@ fail:
     PUT_REMOTE_WAIT(wait);
 }
 
+static void process_device_reset_msg(MPQemuMsg *msg)
+{
+    qemu_devices_reset();
+}
+
 static int init_drive(QDict *rqdict, Error **errp)
 {
     QemuOpts *opts;
@@ -441,6 +449,9 @@ static void process_msg(GIOCondition cond, MPQemuChannel *chan)
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


