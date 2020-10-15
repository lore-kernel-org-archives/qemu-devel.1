Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C788C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A70E820760
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nwG8HKMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70E820760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT7uJ-0007V9-IH
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 14:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1kT7dU-00007N-F3
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:05:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41798)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1kT7dS-0002R1-94
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:05:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FI5RS5038277;
 Thu, 15 Oct 2020 18:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=T7EWsnwsU/nzIG88N48tvesOvJhS5VoL8AlCSt08nas=;
 b=nwG8HKMaa1Oi9mHe8Lwqa54LTsI2oonQExz2DBmJmBxqXysp0cmdgtZCNtdcm0fTpWzv
 NdFgPRSBFS18uVBLsF7Xx+aFD/CndEgZir61Xqbu91ASAjFgrXpCx5wu19mTG6BU5ZH9
 Fh06FT13e/x5Zb0lETOqEdG9wXMC9q1abj1/COyUEi69Z7U7Uds/Wi6+rcX9Bc0FLaz2
 7mN9smwX46SaqR6oCWfLzXH2x8UsGvDOIQlSATDqyj4Ybr3h9YUZBT2KfZN7oTgAZUu+
 TmyKrh8/8k6q4qOVmgSls7DL4jUAH64wYFHCV0tgfBfq3xGSlxnPR2fuUHMNJ2Y7c9Cn 7A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 3434wkx756-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 Oct 2020 18:05:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FI5daF040208;
 Thu, 15 Oct 2020 18:05:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 344by5hj0a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Oct 2020 18:05:47 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09FI5jGX032537;
 Thu, 15 Oct 2020 18:05:45 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 15 Oct 2020 11:05:45 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 16/19] multi-process: Retrieve PCI info from remote process
Date: Thu, 15 Oct 2020 14:05:09 -0400
Message-Id: <1472f84ef416523d7d7f45e997ff5b6706bb6e58.1602784930.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1602784930.git.jag.raman@oracle.com>
References: <cover.1602784930.git.jag.raman@oracle.com>
In-Reply-To: <cover.1602784930.git.jag.raman@oracle.com>
References: <cover.1602784930.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 suspectscore=3 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010150121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=3 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150121
Received-SPF: pass client-ip=141.146.126.78; envelope-from=jag.raman@oracle.com;
 helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 14:05:33
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 alex.williamson@redhat.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/pci/proxy.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
index 93cffcc..ccffddb 100644
--- a/hw/pci/proxy.c
+++ b/hw/pci/proxy.c
@@ -24,6 +24,8 @@
 #include "sysemu/kvm.h"
 #include "util/event_notifier-posix.c"
 
+static void probe_pci_info(PCIDevice *dev, Error **errp);
+
 static void proxy_set_socket(PCIProxyDev *pdev, int fd, Error **errp)
 {
     pdev->ioc = qio_channel_new_fd(fd, errp);
@@ -87,6 +89,7 @@ static void setup_irqfd(PCIProxyDev *dev)
 static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
 {
     PCIProxyDev *dev = PCI_PROXY_DEV(device);
+    uint8_t *pci_conf = device->config;
     int fd;
 
     if (dev->fd) {
@@ -114,9 +117,14 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
     qemu_mutex_init(&dev->io_mutex);
     qio_channel_set_blocking(dev->ioc, true, NULL);
 
+    pci_conf[PCI_LATENCY_TIMER] = 0xff;
+    pci_conf[PCI_INTERRUPT_PIN] = 0x01;
+
     configure_memory_sync(&dev->sync, dev->ioc);
 
     setup_irqfd(dev);
+
+    probe_pci_info(PCI_DEVICE(dev), errp);
 }
 
 static void pci_proxy_dev_exit(PCIDevice *pdev)
@@ -270,3 +278,80 @@ const MemoryRegionOps proxy_mr_ops = {
         .max_access_size = 8,
     },
 };
+
+static void probe_pci_info(PCIDevice *dev, Error **errp)
+{
+    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
+    uint32_t orig_val, new_val, base_class, val;
+    PCIProxyDev *pdev = PCI_PROXY_DEV(dev);
+    DeviceClass *dc = DEVICE_CLASS(pc);
+    uint8_t type;
+    int i, size;
+    char *name;
+
+    config_op_send(pdev, PCI_VENDOR_ID, &val, 2, PCI_CONFIG_READ);
+    pc->vendor_id = (uint16_t)val;
+
+    config_op_send(pdev, PCI_DEVICE_ID, &val, 2, PCI_CONFIG_READ);
+    pc->device_id = (uint16_t)val;
+
+    config_op_send(pdev, PCI_CLASS_DEVICE, &val, 2, PCI_CONFIG_READ);
+    pc->class_id = (uint16_t)val;
+
+    config_op_send(pdev, PCI_SUBSYSTEM_ID, &val, 2, PCI_CONFIG_READ);
+    pc->subsystem_id = (uint16_t)val;
+
+    base_class = pc->class_id >> 4;
+    switch (base_class) {
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
+    for (i = 0; i < PCI_NUM_REGIONS; i++) {
+        config_op_send(pdev, PCI_BASE_ADDRESS_0 + (4 * i), &orig_val, 4,
+                       PCI_CONFIG_READ);
+        new_val = 0xffffffff;
+        config_op_send(pdev, PCI_BASE_ADDRESS_0 + (4 * i), &new_val, 4,
+                       PCI_CONFIG_WRITE);
+        config_op_send(pdev, PCI_BASE_ADDRESS_0 + (4 * i), &new_val, 4,
+                       PCI_CONFIG_READ);
+        size = (~(new_val & 0xFFFFFFF0)) + 1;
+        config_op_send(pdev, PCI_BASE_ADDRESS_0 + (4 * i), &orig_val, 4,
+                       PCI_CONFIG_WRITE);
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
+                                  &proxy_mr_ops, &pdev->region[i],
+                                  name, size);
+            pci_register_bar(dev, i, type, &pdev->region[i].mr);
+            g_free(name);
+        }
+    }
+}
-- 
1.8.3.1


