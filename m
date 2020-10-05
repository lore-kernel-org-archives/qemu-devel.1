Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDCCC46466
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 18:54:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B362020853
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 18:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MhOJyDkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B362020853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPVcZ-00005g-PD
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 14:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kPVaJ-0006le-I0
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 14:51:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kPVaE-00084r-Gt
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 14:51:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095InpIk076385;
 Mon, 5 Oct 2020 18:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=GfH29LOVukU9oR+y74tZgNODRb6C2k/ly1HK3rCi9kI=;
 b=MhOJyDkOyG6SsItdAVAIOykByzm21Sc6ffB6GEFve+QLdZETywa3Kr14ahK8P8/4gS/4
 yTgJFta4UnD5GqydDamhZcnC9vYGHIrpDFlWga8Tct6AAceo2hfrvQvLgse+/hfRr9fa
 2At48tPi1UE5EVoI2FAy44V/PUFoUKJARbbK6c2AeQ/+72uf5J+OaV2CnpUxEXSu5sPu
 Bzz1EZOlUrhoKL/roJVYmUFF44xqdp14ci4JthfwDsffv04LKH+Y+xsWCFtjEdmg3Dkg
 TNJJOXgdWQcmsIt2eGbqOoTcFZIa/j1CKSgVwY+++5AhkF9Pl3q3WG4b4ET4cBtQjtOO 7g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 33ym34c9sc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 05 Oct 2020 18:51:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095IpDIm182547;
 Mon, 5 Oct 2020 18:51:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 33y2vkvfdc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 05 Oct 2020 18:51:31 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 095IpUeL001992;
 Mon, 5 Oct 2020 18:51:30 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 05 Oct 2020 11:51:30 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v10 12/19] multi-process: Forward PCI config space acceses to
 the remote process
Date: Mon,  5 Oct 2020 11:51:00 -0700
Message-Id: <fc7a3b03ab53f317b2bb012362fcd7ed0b07f4ac.1601923020.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1601923020.git.elena.ufimtseva@oracle.com>
References: <cover.1601923020.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 malwarescore=0 suspectscore=1 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 priorityscore=1501
 mlxscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=1 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050136
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=elena.ufimtseva@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 14:51:29
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
 stefanha@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/i386/remote-msg.c     | 62 ++++++++++++++++++++++++++++++++++++++++
 hw/pci/proxy.c           | 50 ++++++++++++++++++++++++++++++++
 include/io/mpqemu-link.h |  9 ++++++
 io/mpqemu-link.c         |  6 ++++
 4 files changed, 127 insertions(+)

diff --git a/hw/i386/remote-msg.c b/hw/i386/remote-msg.c
index 6451b77ae2..94937db1c5 100644
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
 
 void coroutine_fn mpqemu_remote_msg_loop_co(void *data)
 {
@@ -43,6 +49,12 @@ void coroutine_fn mpqemu_remote_msg_loop_co(void *data)
         }
 
         switch (msg.cmd) {
+        case PCI_CONFIG_WRITE:
+            process_config_write(com->ioc, pci_dev, &msg);
+            break;
+        case PCI_CONFIG_READ:
+            process_config_read(com->ioc, pci_dev, &msg);
+            break;
         default:
             error_setg(&local_err,
                        "Unknown command (%d) received for device %s (pid=%d)",
@@ -60,3 +72,53 @@ void coroutine_fn mpqemu_remote_msg_loop_co(void *data)
 
     return;
 }
+
+static void process_config_write(QIOChannel *ioc, PCIDevice *dev,
+                                 MPQemuMsg *msg)
+{
+    ConfDataMsg *conf = (ConfDataMsg *)&msg->data.conf_data;
+    MPQemuMsg ret = { 0 };
+    Error *local_err = NULL;
+
+    if ((conf->addr + sizeof(conf->val)) > pci_config_size(dev)) {
+        error_report("Bad address received when writing PCI config, pid %d",
+                     getpid());
+        ret.data.u64 = UINT64_MAX;
+    } else {
+        pci_default_write_config(dev, conf->addr, conf->val, conf->l);
+    }
+
+    ret.cmd = RET_MSG;
+    ret.size = sizeof(ret.data.u64);
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
+    ConfDataMsg *conf = (ConfDataMsg *)&msg->data.conf_data;
+    MPQemuMsg ret = { 0 };
+    Error *local_err = NULL;
+
+    if ((conf->addr + sizeof(conf->val)) > pci_config_size(dev)) {
+        error_report("Bad address received when reading PCI config, pid %d",
+                     getpid());
+        ret.data.u64 = UINT64_MAX;
+    } else {
+        ret.data.u64 = pci_default_read_config(dev, conf->addr, conf->l);
+    }
+
+    ret.cmd = RET_MSG;
+    ret.size = sizeof(ret.data.u64);
+
+    mpqemu_msg_send(&ret, ioc, &local_err);
+    if (local_err) {
+        error_report("Could not send message to proxy from pid %d",
+                     getpid());
+    }
+}
diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
index 6b954f22a5..083ec8382a 100644
--- a/hw/pci/proxy.c
+++ b/hw/pci/proxy.c
@@ -16,6 +16,8 @@
 #include "hw/qdev-properties.h"
 #include "monitor/monitor.h"
 #include "migration/blocker.h"
+#include "io/mpqemu-link.h"
+#include "qemu/error-report.h"
 
 static void proxy_set_socket(PCIProxyDev *pdev, int fd, Error **errp)
 {
@@ -65,6 +67,51 @@ static void pci_proxy_dev_exit(PCIDevice *pdev)
     qio_channel_close(dev->ioc, NULL);
 }
 
+static int config_op_send(PCIProxyDev *pdev, uint32_t addr, uint32_t *val,
+                          int l, unsigned int op)
+{
+    MPQemuMsg msg = { 0 };
+    uint64_t ret = -EINVAL;
+    Error *local_err = NULL;
+
+    msg.cmd = op;
+    msg.data.conf_data.addr = addr;
+    msg.data.conf_data.val = (op == PCI_CONFIG_WRITE) ? *val : 0;
+    msg.data.conf_data.l = l;
+    msg.size = sizeof(ConfDataMsg);
+
+    ret = mpqemu_msg_send_and_await_reply(&msg, pdev, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
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
@@ -72,6 +119,9 @@ static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
 
     k->realize = pci_proxy_dev_realize;
     k->exit = pci_proxy_dev_exit;
+    k->config_read = pci_proxy_read_config;
+    k->config_write = pci_proxy_write_config;
+
     device_class_set_props(dc, proxy_properties);
 }
 
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 4bea5daeb4..459d345897 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -34,6 +34,8 @@ typedef enum {
     MPQEMU_CMD_INIT,
     SYNC_SYSMEM,
     RET_MSG,
+    PCI_CONFIG_WRITE,
+    PCI_CONFIG_READ,
     MPQEMU_CMD_MAX,
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
  * MPQemuMsg:
  * @cmd: The remote command
@@ -60,6 +68,7 @@ typedef struct {
 
     union {
         uint64_t u64;
+        ConfDataMsg conf_data;
         SyncSysmemMsg sync_sysmem;
     } data;
 
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index 618061753b..4e0f57a7f5 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -271,6 +271,12 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
             return false;
         }
         break;
+    case PCI_CONFIG_WRITE:
+    case PCI_CONFIG_READ:
+        if (msg->size != sizeof(ConfDataMsg)) {
+            return false;
+        }
+        break;
     default:
         break;
     }
-- 
2.25.GIT


