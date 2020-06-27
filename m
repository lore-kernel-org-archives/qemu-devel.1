Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6D6C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE77920760
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IKjXULXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE77920760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpEY1-0002Wc-4e
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 13:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpENY-00031l-4V
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:12:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53580)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpENU-0007UW-8y
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:12:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RHCO8F193179;
 Sat, 27 Jun 2020 17:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=YF0bbzvQlbn//cFkHghHM30Yolv8Z4AkTDb8vO2GHIQ=;
 b=IKjXULXo5uHQCzEqwFg7fMb9iC8meEpozenoK5v3DG2B9n+buA7NZfszs6pyJi2w0H2/
 mIQ7kgnAEeKHBsl96WSic1NzKHb8oY40sZQod3doJdbRpt7EonCSff63aYTfURl15zlK
 IMniNBvP3t2o3H8G7d1qlynPtS9oh+YQDYxR8MA0Fkjbq9MdNbc0QseHSWUgV6VwDFE+
 mBCMDXYW9KbMXoThS25XUWq1fIyfKrYKS6R4Y2pgl8nHguAaa2hk4vl8WvVYOmEzxh6q
 sLaWoLdFxHwU8ay5X1v9Iefu4nh4h6iFekL3KkjM9WSKkVeOcSPjf1BTcK514SFPjJB6 8w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 31wxrms9b2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 27 Jun 2020 17:12:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH8mPK172225;
 Sat, 27 Jun 2020 17:10:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 31wwehn512-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 27 Jun 2020 17:10:23 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05RHAM5Q024371;
 Sat, 27 Jun 2020 17:10:22 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 27 Jun 2020 10:10:22 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v7 17/21] multi-process: Retrieve PCI info from remote process
Date: Sat, 27 Jun 2020 10:09:39 -0700
Message-Id: <a6b53187fa9f8ae1bf8470a8a6da36f66a87d53a.1593273671.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1593273671.git.elena.ufimtseva@oracle.com>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9665
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006270124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9665
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 cotscore=-2147483648
 lowpriorityscore=0 suspectscore=3 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006270124
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 13:10:10
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
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
 hw/i386/remote-msg.c     | 23 +++++++++++
 hw/pci/proxy.c           | 89 ++++++++++++++++++++++++++++++++++++++++
 include/io/mpqemu-link.h |  9 ++++
 io/mpqemu-link.c         |  5 +++
 4 files changed, 126 insertions(+)

diff --git a/hw/i386/remote-msg.c b/hw/i386/remote-msg.c
index 67fee4bb57..9379ee6442 100644
--- a/hw/i386/remote-msg.c
+++ b/hw/i386/remote-msg.c
@@ -20,6 +20,8 @@ static void process_config_read(QIOChannel *ioc, PCIDevice *dev,
                                 MPQemuMsg *msg);
 static void process_bar_write(QIOChannel *ioc, MPQemuMsg *msg, Error **errp);
 static void process_bar_read(QIOChannel *ioc, MPQemuMsg *msg, Error **errp);
+static void process_get_pci_info_msg(QIOChannel *ioc, MPQemuMsg *msg,
+                                     PCIDevice *pci_dev);
 
 gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondition cond,
                             gpointer opaque)
@@ -71,6 +73,9 @@ gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondition cond,
     case SET_IRQFD:
         process_set_irqfd_msg(pci_dev, &msg);
         break;
+    case GET_PCI_INFO:
+        process_get_pci_info_msg(ioc, &msg, pci_dev);
+        break;
     default:
         error_setg(&local_err, "Unknown command (%d) received from proxy \
                    in remote process pid=%d", msg.cmd, getpid());
@@ -246,3 +251,21 @@ fail:
 
     mpqemu_msg_send(&ret, ioc);
 }
+
+static void process_get_pci_info_msg(QIOChannel *ioc, MPQemuMsg *msg,
+                                     PCIDevice *pci_dev)
+{
+    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
+    MPQemuMsg ret = { 0 };
+
+    ret.cmd = RET_MSG;
+
+    ret.data1.ret_pci_info.vendor_id = pc->vendor_id;
+    ret.data1.ret_pci_info.device_id = pc->device_id;
+    ret.data1.ret_pci_info.class_id = pc->class_id;
+    ret.data1.ret_pci_info.subsystem_id = pc->subsystem_id;
+
+    ret.size = sizeof(ret.data1);
+
+    mpqemu_msg_send(&ret, ioc);
+}
diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
index 9d8559b6d4..449341e459 100644
--- a/hw/pci/proxy.c
+++ b/hw/pci/proxy.c
@@ -23,6 +23,8 @@
 #include "sysemu/kvm.h"
 #include "util/event_notifier-posix.c"
 
+static void probe_pci_info(PCIDevice *dev);
+
 static void proxy_set_socket(PCIProxyDev *pdev, int fd, Error **errp)
 {
     DeviceState *dev = DEVICE(pdev);
@@ -110,6 +112,7 @@ static void setup_irqfd(PCIProxyDev *dev)
 static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
 {
     PCIProxyDev *dev = PCI_PROXY_DEV(device);
+    uint8_t *pci_conf = device->config;
     int proxyfd;
 
     if (dev->fd) {
@@ -121,9 +124,14 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
         proxy_set_socket(dev, proxyfd, errp);
     }
 
+    pci_conf[PCI_LATENCY_TIMER] = 0xff;
+    pci_conf[PCI_INTERRUPT_PIN] = 0x01;
+
     configure_memory_sync(&dev->sync, dev->com);
 
     setup_irqfd(dev);
+
+    probe_pci_info(PCI_DEVICE(dev));
 }
 
 static int config_op_send(PCIProxyDev *pdev, uint32_t addr, uint32_t *val,
@@ -267,3 +275,84 @@ const MemoryRegionOps proxy_mr_ops = {
         .max_access_size = 1,
     },
 };
+
+static void probe_pci_info(PCIDevice *dev)
+{
+    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
+    DeviceClass *dc = DEVICE_CLASS(pc);
+    PCIProxyDev *pdev = PCI_PROXY_DEV(dev);
+    MPQemuMsg msg = { 0 }, ret =  { 0 };
+    uint32_t orig_val, new_val, class;
+    uint8_t type;
+    int i, size;
+    char *name;
+    Error *local_err = NULL;
+
+    msg.bytestream = 0;
+    msg.size = 0;
+    msg.cmd = GET_PCI_INFO;
+
+    ret.data1.u64  = mpqemu_msg_send_reply_co(&msg, pdev->dev, &local_err);
+    if (local_err) {
+        error_report("Error while sending GET_PCI_INFO message");
+    }
+
+    pc->vendor_id = ret.data1.ret_pci_info.vendor_id;
+    pc->device_id = ret.data1.ret_pci_info.device_id;
+    pc->class_id = ret.data1.ret_pci_info.class_id;
+    pc->subsystem_id = ret.data1.ret_pci_info.subsystem_id;
+
+    config_op_send(pdev, PCI_CLASS_DEVICE, &class, 1, PCI_CONFIG_READ);
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
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index a563b557ce..4b96cb8ccb 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -43,6 +43,7 @@ typedef enum {
     BAR_WRITE,
     BAR_READ,
     SET_IRQFD,
+    GET_PCI_INFO,
     MAX = INT_MAX,
 } MPQemuCmd;
 
@@ -69,6 +70,13 @@ typedef struct {
     int intx;
 } SetIrqFdMsg;
 
+typedef struct {
+    uint16_t vendor_id;
+    uint16_t device_id;
+    uint16_t class_id;
+    uint16_t subsystem_id;
+} RetPCIInfoMsg;
+
 /**
  * Maximum size of data2 field in the message to be transmitted.
  */
@@ -98,6 +106,7 @@ typedef struct {
         SyncSysmemMsg sync_sysmem;
         BarAccessMsg bar_access;
         SetIrqFdMsg set_irqfd;
+        RetPCIInfoMsg ret_pci_info;
     } data1;
 
     int fds[REMOTE_MAX_FDS];
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index 561ac0576f..d09b2a2f50 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -263,6 +263,11 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
             return false;
         }
         break;
+    case GET_PCI_INFO:
+        if (msg->size) {
+            return false;
+        }
+        break;
     default:
         break;
     }
-- 
2.25.GIT


