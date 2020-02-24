Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E2EC38BE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:21:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B6020732
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KWO5Wn5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B6020732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6LAh-0006qd-1d
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:21:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kmf-0007TD-5E
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kmd-0003jW-Pd
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:57 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42072)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Kmd-0003iN-GA
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:55 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKqVl4017560;
 Mon, 24 Feb 2020 20:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=K4N24fAHtaqqUMoKG6qIOiC5sm1MjAK0vc1+m05x96Y=;
 b=KWO5Wn5Ihw2X+7X0A42sH7s02QQuM3n1BZuwtXANOGw5JW+li+EfcTbz2ShaJ1Ydi6Cl
 vP9ZiyhHfoY5ZnBm7xgP8zYYuvjXgNVzzH1+7vg+hAksUwkZVcpFlLUOV+JyKsLOVtki
 5bgvFH2GgP/e/buh/T1/QVVf9d/i909t2wInDxjIgrMUsrCB4YiH6vTitnU+gbNbaVbR
 n66AntlYXpe6M0z6Yw6pcIfoqMCT2iw9n9rQt9bAn31KiQnenMtXhtEHq4R5UGZh39ci
 MXTU3GXPs9EwUYcUc+Wd4264TMG/CQrjorhJMKLL3Z0VfjHye/EO3iSdqkdD4PZVL+dC Iw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2yavxrhyj3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKunYN073464;
 Mon, 24 Feb 2020 20:56:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2ybduv6dg1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:49 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01OKulaE030045;
 Mon, 24 Feb 2020 20:56:47 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:47 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 33/50] multi-process: perform device reset in the remote
 process
Date: Mon, 24 Feb 2020 15:55:24 -0500
Message-Id: <d7d7efb01a83cfd9458a422b042a31a3767301c1.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=1
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=1 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
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

Perform device reset in the remote process when QEMU performs
device reset. This is required to reset the internal state
(like registers, etc...) of emulated devices

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 V4 -> v5:
  - Device reset wait for remote

 hw/proxy/qemu-proxy.c    | 25 +++++++++++++++++++++++++
 include/io/mpqemu-link.h |  1 +
 remote/remote-main.c     | 14 ++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 68517aa..741f02a 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -431,14 +431,39 @@ static void pci_proxy_write_config(PCIDevice *d, uint32_t addr, uint32_t val,
     config_op_send(PCI_PROXY_DEV(d), addr, &val, l, PCI_CONFIG_WRITE);
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
+    wait = eventfd(0, EFD_CLOEXEC);
+    msg.num_fds = 1;
+    msg.fds[0] = wait;
+
+    mpqemu_msg_send(&msg, pdev->mpqemu_link->com);
+
+    wait_for_remote(wait);
+    close(wait);
+}
+
 static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
     k->realize = pci_proxy_dev_realize;
     k->exit = pci_dev_exit;
     k->config_read = pci_proxy_read_config;
     k->config_write = pci_proxy_write_config;
+
+    dc->reset = proxy_device_reset;
 }
 
 static const TypeInfo pci_proxy_dev_type_info = {
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 3962630..d2234ca 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -62,6 +62,7 @@ typedef enum {
     RET_PCI_INFO,
     PROXY_PING,
     MMIO_RETURN,
+    DEVICE_RESET,
     MAX,
 } mpqemu_cmd_t;
 
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 6cfc446..5284ee9 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -53,8 +53,11 @@
 #include "qemu/log.h"
 #include "qemu/cutils.h"
 #include "remote-opts.h"
+#include "monitor/monitor.h"
+#include "sysemu/reset.h"
 
 static MPQemuLinkState *mpqemu_link;
+
 PCIDevice *remote_pci_dev;
 bool create_done;
 
@@ -241,6 +244,11 @@ fail:
     PUT_REMOTE_WAIT(wait);
 }
 
+static void process_device_reset_msg(MPQemuMsg *msg)
+{
+    qemu_devices_reset();
+}
+
 static int setup_device(MPQemuMsg *msg, Error **errp)
 {
     QObject *obj;
@@ -395,6 +403,12 @@ static void process_msg(GIOCondition cond, MPQemuChannel *chan)
         wait = msg->fds[0];
         notify_proxy(wait, (uint32_t)getpid());
         break;
+    case DEVICE_RESET:
+        process_device_reset_msg(msg);
+        if (msg->num_fds == 1) {
+            notify_proxy(msg->fds[0], 0);
+        }
+        break;
     default:
         error_setg(&err, "Unknown command");
         goto finalize_loop;
-- 
1.8.3.1


