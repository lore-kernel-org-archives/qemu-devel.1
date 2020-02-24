Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591EBC38BE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2302B20CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wmNk/Wgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2302B20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6L3v-00048b-BI
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:14:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6KmK-0006eB-UX
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6KmJ-0003JU-Bb
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53226)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6KmJ-0003Gw-2x
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:35 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKrwU2164256;
 Mon, 24 Feb 2020 20:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=4SZlFhVtJVgG0M7NJTDMTWsu3V+OuqTI1X5r4RalZJk=;
 b=wmNk/WgzqpX9t9skk4TH6jR6A3cqGXn7VOlND6R3R/RbPAXPDUKriXqd0/uDavYds2Kp
 CzF3eFwOvOEDCMItq0gMcPtvslJuqh/dM6aAbbuN5p2OBe5V936Zj+suD9nX5EngvYRx
 UsN32fqENj6CTkJsuCH5yT/bkNk4y9L+FPZKLMBUT8RphdVY4gEgr5SOOVAcL+afwpom
 Q/KPIlBPdu+NumUHfrt9drag/0g1FKibFnX+dE3AH2I9pNRDG57TbhAB36ImRCuMQ5sb
 BSao6wFWMakL7Kp+quvYpbf9O73LVDfrgT8jKGHNRz7Ig0ePwkbnuwIvdJ/6Do+Q999v ZA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2ybvr4p94u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKpv3Q108634;
 Mon, 24 Feb 2020 20:56:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2ybe123tby-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:28 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01OKuPPK029738;
 Mon, 24 Feb 2020 20:56:26 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:25 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 19/50] multi-process: Retrieve PCI info from remote process
Date: Mon, 24 Feb 2020 15:55:10 -0500
Message-Id: <36605a80e00d5b6707dc8f13a5c528226c943692.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 suspectscore=3 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=3 phishscore=0
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

Retrieve PCI configuration info about the remote device and
configure the Proxy PCI object based on the returned information

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 New Patch in v5. Removes per-device proxy and adds support for a generic
 proxy object

 hw/proxy/qemu-proxy.c    | 84 +++++++++++++++++++++++++++++++++++++++++++++++-
 include/io/mpqemu-link.h | 10 ++++++
 remote/remote-main.c     | 20 ++++++++++++
 3 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 3ba05d9..c888677 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -26,12 +26,91 @@
 
 static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
 static void setup_irqfd(PCIProxyDev *dev);
+static int config_op_send(PCIProxyDev *dev, uint32_t addr, uint32_t *val, int l,
+                          unsigned int op);
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
+    mpqemu_msg_send(&msg, mpqemu_link->com);
+
+    mpqemu_msg_recv(&ret, mpqemu_link->com);
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
 
 static void proxy_ready(PCIDevice *dev)
 {
     PCIProxyDev *pdev = PCI_PROXY_DEV(dev);
 
     setup_irqfd(pdev);
+    probe_pci_info(dev);
 }
 
 static int set_remote_opts(PCIDevice *dev, QDict *qdict, unsigned int cmd)
@@ -254,7 +333,6 @@ static const TypeInfo pci_proxy_dev_type_info = {
     .name          = TYPE_PCI_PROXY_DEV,
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIProxyDev),
-    .abstract      = true,
     .class_size    = sizeof(PCIProxyDevClass),
     .class_init    = pci_proxy_dev_class_init,
     .interfaces = (InterfaceInfo[]) {
@@ -355,8 +433,12 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
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
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 90a8437..2ca89c5 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -58,6 +58,8 @@ typedef enum {
     DRIVE_OPTS,
     DEVICE_ADD,
     DEVICE_DEL,
+    GET_PCI_INFO,
+    RET_PCI_INFO,
     MAX,
 } mpqemu_cmd_t;
 
@@ -96,6 +98,13 @@ typedef struct {
     int intx;
 } set_irqfd_msg_t;
 
+ typedef struct {
+    uint16_t vendor_id;
+    uint16_t device_id;
+    uint16_t class_id;
+    uint16_t subsystem_id;
+} ret_pci_info_msg_t;
+
 typedef struct {
     mpqemu_cmd_t cmd;
     int bytestream;
@@ -106,6 +115,7 @@ typedef struct {
         sync_sysmem_msg_t sync_sysmem;
         bar_access_msg_t bar_access;
         set_irqfd_msg_t set_irqfd;
+        ret_pci_info_msg_t ret_pci_info;
     } data1;
 
     int fds[REMOTE_MAX_FDS];
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 02d78a4..0f830b8 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -126,6 +126,23 @@ fail:
     PUT_REMOTE_WAIT(wait);
 }
 
+static void process_get_pci_info_msg(PCIDevice *pci_dev, MPQemuMsg *msg)
+{
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
+    mpqemu_msg_send(&ret, mpqemu_link->com);
+}
+
 static void process_msg(GIOCondition cond, MPQemuChannel *chan)
 {
     MPQemuMsg *msg = NULL;
@@ -145,6 +162,9 @@ static void process_msg(GIOCondition cond, MPQemuChannel *chan)
     switch (msg->cmd) {
     case INIT:
         break;
+    case GET_PCI_INFO:
+        process_get_pci_info_msg(remote_pci_dev, msg);
+        break;
     case PCI_CONFIG_WRITE:
         process_config_write(msg);
         break;
-- 
1.8.3.1


