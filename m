Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F36C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:13:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5965A20775
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Oe89Vxpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5965A20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpEOg-0004hE-Gf
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 13:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpELP-0007vq-K7
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:10:23 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47030)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpELM-00072i-8D
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:10:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH2ZtU156367;
 Sat, 27 Jun 2020 17:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=QWNGmCt4M4eOkFjbFAU1RTjyDzQBljVmuABqcrHbEqQ=;
 b=Oe89Vxpm0OnZWICWa9mqkbCnvGpIwam0PNtn3nZZN1VYa/w029YxLEKVnG83n3rqo8vU
 RwGUO6HxQdgfAot3m2QIljLwYkl9kT/uwJ9rqGs6xzGB0Yxw6MJX/vehrXCu7JJv9o/s
 j0uvhB09W494JKNZsL6MDgYYZIAJuWA55/YNE0tCIqFvQIBZJAb9ZJY0rKmkVcMijl9y
 qC4NzBhT3CzGc5XzcIN2W/hZCQrOr3//TR1irdOjtQmHl30HUAbrr+hMP7TACsWkQ+ql
 cuhWK9TzHNTsVA4J2Czy2DwHNMhPy4/OFdDe0vbN/odBg334WUe+4eSV3anEWROt83yz WQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 31wx2m9axn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 27 Jun 2020 17:10:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH7atv195219;
 Sat, 27 Jun 2020 17:10:12 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 31wu7s8y44-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 27 Jun 2020 17:10:12 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05RHABIG024202;
 Sat, 27 Jun 2020 17:10:11 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 27 Jun 2020 10:10:11 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v7 13/21] multi-process: Forward PCI config space acceses to
 the remote process
Date: Sat, 27 Jun 2020 10:09:35 -0700
Message-Id: <736d124ffb6c58e8061baba2503981f5e8b3f70b.1593273671.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1593273671.git.elena.ufimtseva@oracle.com>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9665
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=1 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006270124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9665
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 impostorscore=0 cotscore=-2147483648 priorityscore=1501 malwarescore=0
 phishscore=0 suspectscore=1 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006270123
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=elena.ufimtseva@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 13:10:09
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

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

The Proxy Object sends the PCI config space accesses as messages
to the remote process over the communication channel

TODO:
Investigate if the local PCI config writes can be dropped.
Without the proxy local PCI config space writes for the device,
the driver in the guest times out on the probing.
We have tried to only refer to the remote for the PCI config writes,
but the driver timeout in the guest forced as to left this
as it is (removing local PCI config only).

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 hw/i386/remote-msg.c     | 54 ++++++++++++++++++++++++++++++++++++++++
 hw/pci/proxy.c           | 54 ++++++++++++++++++++++++++++++++++++++++
 include/io/mpqemu-link.h |  8 ++++++
 io/mpqemu-link.c         | 14 +++++++++++
 4 files changed, 130 insertions(+)

diff --git a/hw/i386/remote-msg.c b/hw/i386/remote-msg.c
index 68f50866bb..aa5780d521 100644
--- a/hw/i386/remote-msg.c
+++ b/hw/i386/remote-msg.c
@@ -11,10 +11,16 @@
 
 static void process_connect_dev_msg(MPQemuMsg *msg, QIOChannel *com,
                                     Error **errp);
+static void process_config_write(QIOChannel *ioc, PCIDevice *dev,
+                                 MPQemuMsg *msg);
+static void process_config_read(QIOChannel *ioc, PCIDevice *dev,
+                                MPQemuMsg *msg);
 
 gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondition cond,
                             gpointer opaque)
 {
+    DeviceState *dev = (DeviceState *)opaque;
+    PCIDevice *pci_dev = PCI_DEVICE(dev);
     Error *local_err = NULL;
     MPQemuMsg msg = { 0 };
 
@@ -42,6 +48,12 @@ gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondition cond,
     case CONNECT_DEV:
         process_connect_dev_msg(&msg, ioc, &local_err);
         break;
+    case PCI_CONFIG_WRITE:
+        process_config_write(ioc, pci_dev, &msg);
+        break;
+    case PCI_CONFIG_READ:
+        process_config_read(ioc, pci_dev, &msg);
+        break;
     default:
         error_setg(&local_err, "Unknown command (%d) received from proxy \
                    in remote process pid=%d", msg.cmd, getpid());
@@ -89,3 +101,45 @@ exit:
 
     mpqemu_msg_send(&ret, com);
 }
+
+static void process_config_write(QIOChannel *ioc, PCIDevice *dev,
+                                 MPQemuMsg *msg)
+{
+    struct conf_data_msg *conf = (struct conf_data_msg *)msg->data2;
+    MPQemuMsg ret = { 0 };
+
+    if (conf->addr >= PCI_CFG_SPACE_EXP_SIZE) {
+        error_report("Bad address received when writing PCI config, pid %d",
+                     getpid());
+        ret.data1.u64 = UINT64_MAX;
+    } else {
+        pci_default_write_config(dev, conf->addr, conf->val, conf->l);
+    }
+
+    ret.cmd = RET_MSG;
+    ret.bytestream = 0;
+    ret.size = sizeof(ret.data1);
+
+    mpqemu_msg_send(&ret, ioc);
+}
+
+static void process_config_read(QIOChannel *ioc, PCIDevice *dev,
+                                MPQemuMsg *msg)
+{
+    struct conf_data_msg *conf = (struct conf_data_msg *)msg->data2;
+    MPQemuMsg ret = { 0 };
+
+    if (conf->addr >= PCI_CFG_SPACE_EXP_SIZE) {
+        error_report("Bad address received when reading PCI config, pid %d",
+                     getpid());
+        ret.data1.u64 = UINT64_MAX;
+    } else {
+        ret.data1.u64 = pci_default_read_config(dev, conf->addr, conf->l);
+    }
+
+    ret.cmd = RET_MSG;
+    ret.bytestream = 0;
+    ret.size = sizeof(ret.data1);
+
+    mpqemu_msg_send(&ret, ioc);
+}
diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
index 16649ed0ec..8934070a20 100644
--- a/hw/pci/proxy.c
+++ b/hw/pci/proxy.c
@@ -16,6 +16,7 @@
 #include "hw/qdev-properties.h"
 #include "monitor/monitor.h"
 #include "io/mpqemu-link.h"
+#include "qemu/error-report.h"
 
 static void proxy_set_socket(PCIProxyDev *pdev, int fd, Error **errp)
 {
@@ -69,12 +70,65 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
     }
 }
 
+static int config_op_send(PCIProxyDev *pdev, uint32_t addr, uint32_t *val,
+                          int l, unsigned int op)
+{
+    struct conf_data_msg conf_data;
+    MPQemuMsg msg = { 0 };
+    long ret = -EINVAL;
+    Error *local_err = NULL;
+
+    conf_data.addr = addr;
+    conf_data.val = (op == PCI_CONFIG_WRITE) ? *val : 0;
+    conf_data.l = l;
+
+    msg.data2 = (uint8_t *)&conf_data;
+
+    msg.size = sizeof(conf_data);
+    msg.cmd = op;
+    msg.bytestream = 1;
+
+    ret = mpqemu_msg_send_reply_co(&msg, pdev->dev, &local_err);
+    if (local_err) {
+        error_report("Failed to exchange PCI_CONFIG message with remote");
+    }
+    if (op == PCI_CONFIG_READ) {
+        *val = (uint32_t)ret;
+    }
+
+    return ret;
+}
+
+static uint32_t pci_proxy_read_config(PCIDevice *d, uint32_t addr, int len)
+{
+    uint32_t val;
+
+    (void)config_op_send(PCI_PROXY_DEV(d), addr, &val, len, PCI_CONFIG_READ);
+
+    return val;
+}
+
+static void pci_proxy_write_config(PCIDevice *d, uint32_t addr, uint32_t val,
+                                   int l)
+{
+    /*
+     * Some of the functions access the copy of the remote device
+     * PCI config space, therefore maintain it updated.
+     */
+    pci_default_write_config(d, addr, val, l);
+
+    (void)config_op_send(PCI_PROXY_DEV(d), addr, &val, l, PCI_CONFIG_WRITE);
+}
+
 static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = pci_proxy_dev_realize;
+    k->config_read = pci_proxy_read_config;
+    k->config_write = pci_proxy_write_config;
+
     device_class_set_props(dc, proxy_properties);
 }
 
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index d620806c17..bbd6f3db44 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -38,6 +38,8 @@ typedef enum {
     SYNC_SYSMEM,
     CONNECT_DEV,
     RET_MSG,
+    PCI_CONFIG_WRITE,
+    PCI_CONFIG_READ,
     MAX = INT_MAX,
 } MPQemuCmd;
 
@@ -47,6 +49,12 @@ typedef struct {
     off_t offsets[REMOTE_MAX_FDS];
 } SyncSysmemMsg;
 
+struct conf_data_msg {
+    uint32_t addr;
+    uint32_t val;
+    int l;
+};
+
 /**
  * Maximum size of data2 field in the message to be transmitted.
  */
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index 54df3b254e..19887611d0 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -242,6 +242,20 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
             return false;
         }
         break;
+    case PCI_CONFIG_WRITE:
+    case PCI_CONFIG_READ:
+        if (msg->size != sizeof(struct conf_data_msg)) {
+            return false;
+        }
+        if (!msg->bytestream) {
+            return false;
+        }
+        struct conf_data_msg *conf = (struct conf_data_msg *)msg->data2;
+
+        if (conf->l != 1 && conf->l != 2 && conf->l != 4) {
+            return false;
+        }
+        break;
     default:
         break;
     }
-- 
2.25.GIT


