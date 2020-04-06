Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB22C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:01:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363FE2063A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uis10KAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363FE2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOZ0-0002KJ-9Q
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOJC-00077h-JM
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOJB-0004Ft-7G
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:44:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37032)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jLOJA-0004Ey-UO
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:44:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369i3Q5093135;
 Mon, 6 Apr 2020 09:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=jbQyi+l5kcRmEtgZvNOXkZwgs6yQkKCSn5xC7Wm2LPw=;
 b=uis10KAtowgcUHfYe78p2M1bXPWBY5z4zQhmOUgwuSfUv4xIFGQabHVjQkOn5bH05A5S
 TMzWwt7FluntTjYyuuJMHPtqGOiaEUaCG1yCqq8PP7UNN5tNqIsf55HtMVUbdjxYl+mK
 tXUbi2utUUbfethi685q9/aKilQvwiJGkuO7xHYeRRcbk1lTurCezWThfk0wPVwfEv2W
 WZ2YZQ2gv5oM6h96VA341RzD8Itavp0qiqOAyxhjYEa/QQLiQwu/6cWe4e7kDMAY76oH
 WN31OKG4bqbzzSvQgpmO/iqk37AZZ3aUJkwvCyzg2dRTd90Hz2qvGA+JWUUqEZDxxuZ8 8A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 306hnqwu8m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:44:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369chFP092235;
 Mon, 6 Apr 2020 09:42:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 3073spk6ke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:42:22 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0369gLXR032052;
 Mon, 6 Apr 2020 09:42:22 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 06 Apr 2020 02:42:21 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v6 30/36] multi-process: perform device reset in the remote
 process
Date: Mon,  6 Apr 2020 02:41:20 -0700
Message-Id: <472b75b4180021fdf2d4de540de0b94e34ffe964.1586165556.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1586165555.git.elena.ufimtseva@oracle.com>
References: <cover.1586165555.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=1 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=1
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060084
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Perform device reset in the remote process when QEMU performs
device reset. This is required to reset the internal state
(like registers, etc...) of emulated devices

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 hw/proxy/qemu-proxy.c    | 25 +++++++++++++++++++++++++
 include/io/mpqemu-link.h |  1 +
 remote/remote-main.c     | 13 +++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 162014353f..cffc227acd 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -291,14 +291,39 @@ static void pci_proxy_dev_exit(PCIDevice *pdev)
     stop_hb_timer(dev);
 }
 
+static void proxy_device_reset(DeviceState *dev)
+{
+    PCIProxyDev *pdev = PCI_PROXY_DEV(dev);
+    MPQemuMsg msg;
+    int wait = -1;
+
+    memset(&msg, 0, sizeof(MPQemuMsg));
+
+    msg.bytestream = 0;
+    msg.size = sizeof(msg.data1);
+    msg.cmd = DEVICE_RESET;
+
+    wait = GET_REMOTE_WAIT;
+    msg.num_fds = 1;
+    msg.fds[0] = wait;
+
+    mpqemu_msg_send(&msg, pdev->mpqemu_link->com);
+
+    (void)wait_for_remote(wait);
+
+    PUT_REMOTE_WAIT(wait);
+}
+
 static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
     k->realize = pci_proxy_dev_realize;
     k->exit = pci_proxy_dev_exit;
     k->config_read = pci_proxy_read_config;
     k->config_write = pci_proxy_write_config;
+    dc->reset = proxy_device_reset;
 }
 
 static const TypeInfo pci_proxy_dev_type_info = {
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 45ea1fcafa..22fb234744 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -51,6 +51,7 @@ typedef enum {
     GET_PCI_INFO,
     RET_PCI_INFO,
     PROXY_PING,
+    DEVICE_RESET,
     MAX,
 } mpqemu_cmd_t;
 
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 18184b3f4b..6e198de35f 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -38,6 +38,7 @@
 #include "exec/address-spaces.h"
 #include "remote/iohub.h"
 #include "remote-opts.h"
+#include "sysemu/reset.h"
 
 static void process_msg(GIOCondition cond, MPQemuLinkState *link,
                         MPQemuChannel *chan);
@@ -185,6 +186,15 @@ static void process_get_pci_info_msg(MPQemuLinkState *link, MPQemuMsg *msg)
     mpqemu_msg_send(&ret, link->dev);
 }
 
+static void process_device_reset_msg(MPQemuMsg *msg)
+{
+    qemu_devices_reset();
+
+    if (msg->num_fds == 1) {
+            notify_proxy(msg->fds[0], 0);
+    }
+}
+
 static void process_msg(GIOCondition cond, MPQemuLinkState *link,
                         MPQemuChannel *chan)
 {
@@ -247,6 +257,9 @@ static void process_msg(GIOCondition cond, MPQemuLinkState *link,
         wait = msg->fds[0];
         notify_proxy(wait, 0);
         break;
+    case DEVICE_RESET:
+        process_device_reset_msg(msg);
+        break;
     default:
         error_setg(&err, "Unknown command");
         goto finalize_loop;
-- 
2.25.GIT


