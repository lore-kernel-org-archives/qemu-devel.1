Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C43BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:34:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4186521744
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PFtXduBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4186521744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Zrm-0003Uc-IQ
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 14:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1k1ZgO-0004Ty-W6
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:23:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1k1ZgM-0005cQ-Uz
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:23:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VILrZW092491;
 Fri, 31 Jul 2020 18:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=Cp31gXjCB8wqFIrDFOw1UVPPgllJrTL3LYP20xqFoq4=;
 b=PFtXduBWjp6mCr+kp6VC1gUrj0OVE49eTPw/LOFNJ0H2KXIOc1TAIUBdArn1PoY0kEZe
 1C1e5YRfg+UJUh6wZbBswbJMN/btLvjIbQ11jnFCXDRMQEBQFkWqpSkBWXuS3RpocKfh
 Z21gnxTSKkkCAeHRDqNg4+O6nezkF3W47SI0ZiBcnc9ElwgX+FomhNFBLoBbdx2g0mXO
 S4AJP38O2lnHs1cY6VjMNVRDmXtEpIQDvVG8326l6UV9QYBJAhqC6anYW+aoXXS+8xNa
 5zVKjzmr+bNjv+Y8+OCr+WPLY8R/kVdncT+p0NCiTEN+kgR0u74NW8KaxAa7klZ6ywK9 8g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 32mf702ujf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 Jul 2020 18:22:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VIIsRS086194;
 Fri, 31 Jul 2020 18:20:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 32hu608m2n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Jul 2020 18:20:56 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06VIKsow020198;
 Fri, 31 Jul 2020 18:20:54 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 31 Jul 2020 11:20:54 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 12/20] multi-process: Forward PCI config space acceses to
 the remote process
Date: Fri, 31 Jul 2020 14:20:19 -0400
Message-Id: <680ecea54c4456b0414547c9e440c7b944f481f5.1596217462.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1596217462.git.jag.raman@oracle.com>
References: <cover.1596217462.git.jag.raman@oracle.com>
In-Reply-To: <cover.1596217462.git.jag.raman@oracle.com>
References: <cover.1596217462.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007310137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 suspectscore=1
 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310137
Received-SPF: pass client-ip=156.151.31.85; envelope-from=jag.raman@oracle.com;
 helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 14:20:51
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
 hw/i386/remote-msg.c     | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/pci/proxy.c           | 55 ++++++++++++++++++++++++++++++++++++++++
 include/io/mpqemu-link.h |  8 ++++++
 io/mpqemu-link.c         | 14 +++++++++++
 4 files changed, 142 insertions(+)

diff --git a/hw/i386/remote-msg.c b/hw/i386/remote-msg.c
index 4315d2c..c5b8651 100644
--- a/hw/i386/remote-msg.c
+++ b/hw/i386/remote-msg.c
@@ -15,6 +15,12 @@
 #include "io/mpqemu-link.h"
 #include "qapi/error.h"
 #include "sysemu/runstate.h"
+#include "hw/pci/pci.h"
+
+static void process_config_write(QIOChannel *ioc, PCIDevice *dev,
+                                 MPQemuMsg *msg);
+static void process_config_read(QIOChannel *ioc, PCIDevice *dev,
+                                MPQemuMsg *msg);
 
 gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondition cond,
                             gpointer opaque)
@@ -46,6 +52,12 @@ gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondition cond,
     }
 
     switch (msg.cmd) {
+    case PCI_CONFIG_WRITE:
+        process_config_write(ioc, pci_dev, &msg);
+        break;
+    case PCI_CONFIG_READ:
+        process_config_read(ioc, pci_dev, &msg);
+        break;
     default:
         error_setg(&local_err,
                    "Unknown command (%d) received for device %s (pid=%d)",
@@ -62,3 +74,56 @@ exit:
 
     return TRUE;
 }
+
+static void process_config_write(QIOChannel *ioc, PCIDevice *dev,
+                                 MPQemuMsg *msg)
+{
+    ConfDataMsg *conf = (ConfDataMsg *)msg->data2;
+    MPQemuMsg ret = { 0 };
+    Error *local_err = NULL;
+
+    if ((conf->addr + sizeof(conf->val)) > pci_config_size(dev)) {
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
+    mpqemu_msg_send(&ret, ioc, &local_err);
+    if (local_err) {
+        error_report("Could not send message to proxy from pid %d",
+                     getpid());
+    }
+}
+
+static void process_config_read(QIOChannel *ioc, PCIDevice *dev,
+                                MPQemuMsg *msg)
+{
+    ConfDataMsg *conf = (ConfDataMsg *)msg->data2;
+    MPQemuMsg ret = { 0 };
+    Error *local_err = NULL;
+
+    if ((conf->addr + sizeof(conf->val)) > pci_config_size(dev)) {
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
+    mpqemu_msg_send(&ret, ioc, &local_err);
+    if (local_err) {
+        error_report("Could not send message to proxy from pid %d",
+                     getpid());
+    }
+
+}
diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
index 014c1cb..945cc35 100644
--- a/hw/pci/proxy.c
+++ b/hw/pci/proxy.c
@@ -15,6 +15,8 @@
 #include "io/channel-util.h"
 #include "hw/qdev-properties.h"
 #include "monitor/monitor.h"
+#include "io/mpqemu-link.h"
+#include "qemu/error-report.h"
 
 static void proxy_set_socket(PCIProxyDev *pdev, int fd, Error **errp)
 {
@@ -51,6 +53,56 @@ static void pci_proxy_dev_exit(PCIDevice *pdev)
     qio_channel_close(dev->ioc, NULL);
 }
 
+static int config_op_send(PCIProxyDev *pdev, uint32_t addr, uint32_t *val,
+                          int l, unsigned int op)
+{
+    ConfDataMsg conf_data;
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
+    ret = mpqemu_msg_send_and_await_reply(&msg, pdev->ioc, &local_err);
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
@@ -58,6 +110,9 @@ static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
 
     k->realize = pci_proxy_dev_realize;
     k->exit = pci_proxy_dev_exit;
+    k->config_read = pci_proxy_read_config;
+    k->config_write = pci_proxy_write_config;
+
     device_class_set_props(dc, proxy_properties);
 }
 
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 98383f9..9bd754e 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -34,6 +34,8 @@ typedef enum {
     INIT = 0,
     SYNC_SYSMEM,
     RET_MSG,
+    PCI_CONFIG_WRITE,
+    PCI_CONFIG_READ,
     MAX = INT_MAX,
 } MPQemuCmd;
 
@@ -43,6 +45,12 @@ typedef struct {
     off_t offsets[REMOTE_MAX_FDS];
 } SyncSysmemMsg;
 
+typedef struct {
+    uint32_t addr;
+    uint32_t val;
+    int l;
+} ConfDataMsg;
+
 /**
  * Maximum size of data2 field in the message to be transmitted.
  */
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index aad1d77..5d04b81 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -255,6 +255,20 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
             return false;
         }
         break;
+    case PCI_CONFIG_WRITE:
+    case PCI_CONFIG_READ:
+        if (msg->size != sizeof(ConfDataMsg)) {
+            return false;
+        }
+        if (!msg->bytestream) {
+            return false;
+        }
+        ConfDataMsg *conf = (ConfDataMsg *)msg->data2;
+
+        if (conf->l != 1 && conf->l != 2 && conf->l != 4) {
+            return false;
+        }
+        break;
     default:
         break;
     }
-- 
1.8.3.1


