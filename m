Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B22C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC162063A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jQkhXT1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC162063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOXH-0007Xt-12
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 05:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOIw-0006XS-Km
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOIv-00042b-2M
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:44:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36838)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jLOIu-00041l-Pm
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:44:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369hpLH093026;
 Mon, 6 Apr 2020 09:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=1PhzKLozBMPHH7oqxxC9Ov6cuOiC3lWW+T0/mLX01j8=;
 b=jQkhXT1MOpd41igH4GxelcfLH4QTc+TTA7Su3HtOjmm3FpWWIJQfJckqI1yTGWp6J/lZ
 S2X6A7gP+Y5utnK4chznX9nnPRghjOgUvRnJ7+PH4T1l7z3zELN3s6nP/nruJ1Ospfop
 lbVcfMspJW7V/8cbqXxnXn9/MycjSkV1PlLjYXMq528e5JyjdWGNmUXArqUC9VP+bNI5
 KAU/X08dnN8BEi0wFnkd8rNV6gGB6Y9y8jz9i3VStLhgYQcAJ4Hp228mfjimxTlUP37h
 rMxWxsBXl3hyCTYMrA9TMoP9xvWoD4ovAp9SsAprkobLhvg60eItEvrcBwgEKQgjx65Z YA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 306hnqwu7r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:44:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369ciqa092283;
 Mon, 6 Apr 2020 09:42:13 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 3073spk6ey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:42:13 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0369gC6K032002;
 Mon, 6 Apr 2020 09:42:12 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 06 Apr 2020 02:42:12 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v6 24/36] multi-process: Retrieve PCI info from remote process
Date: Mon,  6 Apr 2020 02:41:14 -0700
Message-Id: <c873c6abec14cb5ddd82e855424013f7b5d7be9d.1586165556.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1586165555.git.elena.ufimtseva@oracle.com>
References: <cover.1586165555.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=3 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=3
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

From: Jagannathan Raman <jag.raman@oracle.com>

Retrieve PCI configuration info about the remote device and
configure the Proxy PCI object based on the returned information

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 hw/proxy/qemu-proxy.c    | 84 ++++++++++++++++++++++++++++++++++++++++
 include/io/mpqemu-link.h | 10 +++++
 remote/remote-main.c     | 21 ++++++++++
 3 files changed, 115 insertions(+)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index a78694736b..730e28483e 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -19,6 +19,8 @@
 #include "sysemu/kvm.h"
 #include "util/event_notifier-posix.c"
 
+static void probe_pci_info(PCIDevice *dev);
+
 static int config_op_send(PCIProxyDev *dev, uint32_t addr, uint32_t *val, int l,
                           unsigned int op)
 {
@@ -182,8 +184,12 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
 {
     PCIProxyDev *dev = PCI_PROXY_DEV(device);
     PCIProxyDevClass *k = PCI_PROXY_DEV_GET_CLASS(dev);
+    uint8_t *pci_conf = device->config;
     Error *local_err = NULL;
 
+    pci_conf[PCI_LATENCY_TIMER] = 0xff;
+    pci_conf[PCI_INTERRUPT_PIN] = 0x01;
+
     if (k->realize) {
         k->realize(dev, &local_err);
         if (local_err) {
@@ -196,6 +202,8 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
     configure_memory_sync(dev->sync, dev->mpqemu_link);
 
     setup_irqfd(dev);
+
+    probe_pci_info(PCI_DEVICE(dev));
 }
 
 static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
@@ -291,3 +299,79 @@ const MemoryRegionOps proxy_default_ops = {
         .max_access_size = 1,
     },
 };
+
+static void probe_pci_info(PCIDevice *dev)
+{
+    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
+    DeviceClass *dc = DEVICE_CLASS(pc);
+    PCIProxyDev *pdev = PCI_PROXY_DEV(dev);
+    MPQemuLinkState *mpqemu_link = pdev->mpqemu_link;
+    MPQemuMsg msg, ret;
+    uint32_t orig_val, new_val, class;
+    uint8_t type;
+    int i, size;
+    char *name;
+
+    memset(&msg, 0, sizeof(MPQemuMsg));
+    msg.bytestream = 0;
+    msg.size = 0;
+    msg.cmd = GET_PCI_INFO;
+    mpqemu_msg_send(&msg, mpqemu_link->dev);
+
+    mpqemu_msg_recv(&ret, mpqemu_link->dev);
+
+    pc->vendor_id = ret.data1.ret_pci_info.vendor_id;
+    pc->device_id = ret.data1.ret_pci_info.device_id;
+    pc->class_id = ret.data1.ret_pci_info.class_id;
+    pc->subsystem_id = ret.data1.ret_pci_info.subsystem_id;
+
+    config_op_send(pdev, 11, &class, 1, PCI_CONFIG_READ);
+    switch (class) {
+    case PCI_BASE_CLASS_BRIDGE:
+        set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+        break;
+    case PCI_BASE_CLASS_STORAGE:
+        set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+        break;
+    case PCI_BASE_CLASS_NETWORK:
+        set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+        break;
+    case PCI_BASE_CLASS_INPUT:
+        set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+        break;
+    case PCI_BASE_CLASS_DISPLAY:
+        set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+        break;
+    case PCI_BASE_CLASS_PROCESSOR:
+        set_bit(DEVICE_CATEGORY_CPU, dc->categories);
+        break;
+    default:
+        set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+        break;
+    }
+
+    for (i = 0; i < 6; i++) {
+        config_op_send(pdev, 0x10 + (4 * i), &orig_val, 4, PCI_CONFIG_READ);
+        new_val = 0xffffffff;
+        config_op_send(pdev, 0x10 + (4 * i), &new_val, 4, PCI_CONFIG_WRITE);
+        config_op_send(pdev, 0x10 + (4 * i), &new_val, 4, PCI_CONFIG_READ);
+        size = (~(new_val & 0xFFFFFFF0)) + 1;
+        config_op_send(pdev, 0x10 + (4 * i), &orig_val, 4, PCI_CONFIG_WRITE);
+        type = (new_val & 0x1) ?
+                   PCI_BASE_ADDRESS_SPACE_IO : PCI_BASE_ADDRESS_SPACE_MEMORY;
+
+        if (size) {
+            pdev->region[i].dev = pdev;
+            pdev->region[i].present = true;
+            if (type == PCI_BASE_ADDRESS_SPACE_MEMORY) {
+                pdev->region[i].memory = true;
+            }
+            name = g_strdup_printf("bar-region-%d", i);
+            memory_region_init_io(&pdev->region[i].mr, OBJECT(pdev),
+                                  &proxy_default_ops, &pdev->region[i],
+                                  name, size);
+            pci_register_bar(dev, i, type, &pdev->region[i].mr);
+            g_free(name);
+        }
+    }
+}
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 14e4be2bd0..102c736705 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -48,6 +48,8 @@ typedef enum {
     BAR_WRITE,
     BAR_READ,
     SET_IRQFD,
+    GET_PCI_INFO,
+    RET_PCI_INFO,
     MAX,
 } mpqemu_cmd_t;
 
@@ -70,6 +72,13 @@ typedef struct {
     bool memory;
 } bar_access_msg_t;
 
+typedef struct {
+    uint16_t vendor_id;
+    uint16_t device_id;
+    uint16_t class_id;
+    uint16_t subsystem_id;
+} ret_pci_info_msg_t;
+
 /**
  * MPQemuMsg:
  * @cmd: The remote command
@@ -98,6 +107,7 @@ typedef struct {
         sync_sysmem_msg_t sync_sysmem;
         bar_access_msg_t bar_access;
         set_irqfd_msg_t set_irqfd;
+        ret_pci_info_msg_t ret_pci_info;
     } data1;
 
     int fds[REMOTE_MAX_FDS];
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 697fb992a1..d249eba9e8 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -165,6 +165,24 @@ fail:
     PUT_REMOTE_WAIT(wait);
 }
 
+static void process_get_pci_info_msg(MPQemuLinkState *link, MPQemuMsg *msg)
+{
+    PCIDevice *pci_dev = LINK_TO_DEV(link);
+    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
+    MPQemuMsg ret = { 0 };
+
+    ret.cmd = RET_PCI_INFO;
+
+    ret.data1.ret_pci_info.vendor_id = pc->vendor_id;
+    ret.data1.ret_pci_info.device_id = pc->device_id;
+    ret.data1.ret_pci_info.class_id = pc->class_id;
+    ret.data1.ret_pci_info.subsystem_id = pc->subsystem_id;
+
+    ret.size = sizeof(ret.data1);
+
+    mpqemu_msg_send(&ret, link->dev);
+}
+
 static void process_msg(GIOCondition cond, MPQemuLinkState *link,
                         MPQemuChannel *chan)
 {
@@ -219,6 +237,9 @@ static void process_msg(GIOCondition cond, MPQemuLinkState *link,
     case SET_IRQFD:
         process_set_irqfd_msg(LINK_TO_DEV(link), msg);
         break;
+    case GET_PCI_INFO:
+        process_get_pci_info_msg(link, msg);
+        break;
     default:
         error_setg(&err, "Unknown command");
         goto finalize_loop;
-- 
2.25.GIT


