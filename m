Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7342EC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:15:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA5F20775
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WLMXje3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA5F20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpEQN-00081F-Gz
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 13:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpELd-0008TN-As
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:10:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpELb-0007BE-56
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:10:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH31c2034862;
 Sat, 27 Jun 2020 17:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=qllWI9fa6u/yVyuNXQBhUrQQ+jCVeLWDkqwJoPYzt5Y=;
 b=WLMXje3U0az2a+XjwWVvflgV4zu8xwDth4JkYX8MKH2cHIpVvJMJ44z61gzbSOkGCPGH
 +092avTiK2HM3idvvT9F4VehKEtfSPVSPoboKRoNZapMU5bDeFDp0vYtz/k8Ku0XLS7r
 ndGF7yTcu/jabIhVGOy3rN8jdSt6tw32pUyFCcJ2b3SRqw8ZStQ6bbcBcAsxh0kfN0RO
 Sd/k5eCpw9E7sg5cdL+CFC11Fy2iHoBqnRxaj8LAKZZszGFfc7OPDsOlizsUw0EU+Tpp
 p4PmgVjWEJr+PDEBFANKuc027U3cZUI4veQdTw9I/3G86JowrgglwWqe/OCBDIIbe8gx jg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 31wwhr9c9y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 27 Jun 2020 17:10:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH8TPe171840;
 Sat, 27 Jun 2020 17:10:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 31wwehn51j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 27 Jun 2020 17:10:25 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05RHAOQG024377;
 Sat, 27 Jun 2020 17:10:24 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 27 Jun 2020 10:10:23 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v7 18/21] multi-process: heartbeat messages to remote
Date: Sat, 27 Jun 2020 10:09:40 -0700
Message-Id: <c93ff92180d1e5a1bcb620331bc57f6ae9c5447c.1593273671.git.elena.ufimtseva@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 cotscore=-2147483648
 mlxscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=3 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006270123
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 13:03:10
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

In order to detect remote processes which are hung, the
proxy periodically sends heartbeat messages to confirm if
the remote process is alive. The remote process responds
to this heartbeat message to confirm it is alive.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 hw/i386/remote-msg.c     | 14 ++++++++++
 hw/pci/proxy.c           | 58 ++++++++++++++++++++++++++++++++++++++++
 include/hw/pci/proxy.h   |  2 ++
 include/io/mpqemu-link.h |  1 +
 io/mpqemu-link.c         |  1 +
 5 files changed, 76 insertions(+)

diff --git a/hw/i386/remote-msg.c b/hw/i386/remote-msg.c
index 9379ee6442..919bddc1d5 100644
--- a/hw/i386/remote-msg.c
+++ b/hw/i386/remote-msg.c
@@ -22,6 +22,7 @@ static void process_bar_write(QIOChannel *ioc, MPQemuMsg *msg, Error **errp);
 static void process_bar_read(QIOChannel *ioc, MPQemuMsg *msg, Error **errp);
 static void process_get_pci_info_msg(QIOChannel *ioc, MPQemuMsg *msg,
                                      PCIDevice *pci_dev);
+static void process_proxy_ping_msg(QIOChannel *ioc);
 
 gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondition cond,
                             gpointer opaque)
@@ -76,6 +77,9 @@ gboolean mpqemu_process_msg(QIOChannel *ioc, GIOCondition cond,
     case GET_PCI_INFO:
         process_get_pci_info_msg(ioc, &msg, pci_dev);
         break;
+    case PROXY_PING:
+        process_proxy_ping_msg(ioc);
+        break;
     default:
         error_setg(&local_err, "Unknown command (%d) received from proxy \
                    in remote process pid=%d", msg.cmd, getpid());
@@ -269,3 +273,13 @@ static void process_get_pci_info_msg(QIOChannel *ioc, MPQemuMsg *msg,
 
     mpqemu_msg_send(&ret, ioc);
 }
+
+static void process_proxy_ping_msg(QIOChannel *ioc)
+{
+    MPQemuMsg ret = { 0 };
+
+    ret.cmd = RET_MSG;
+    ret.size = sizeof(ret.data1);
+
+    mpqemu_msg_send(&ret, ioc);
+}
diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
index 449341e459..e2e9a13287 100644
--- a/hw/pci/proxy.c
+++ b/hw/pci/proxy.c
@@ -24,6 +24,8 @@
 #include "util/event_notifier-posix.c"
 
 static void probe_pci_info(PCIDevice *dev);
+static void start_hb_timer(PCIProxyDev *dev);
+static void pci_proxy_dev_exit(PCIDevice *pdev);
 
 static void proxy_set_socket(PCIProxyDev *pdev, int fd, Error **errp)
 {
@@ -132,6 +134,8 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
     setup_irqfd(dev);
 
     probe_pci_info(PCI_DEVICE(dev));
+
+    start_hb_timer(dev);
 }
 
 static int config_op_send(PCIProxyDev *pdev, uint32_t addr, uint32_t *val,
@@ -192,6 +196,7 @@ static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
     k->realize = pci_proxy_dev_realize;
     k->config_read = pci_proxy_read_config;
     k->config_write = pci_proxy_write_config;
+    k->exit = pci_proxy_dev_exit;
 
     device_class_set_props(dc, proxy_properties);
 }
@@ -356,3 +361,56 @@ static void probe_pci_info(PCIDevice *dev)
         }
     }
 }
+
+static void hb_msg(PCIProxyDev *dev)
+{
+    DeviceState *ds = DEVICE(dev);
+    MPQemuMsg msg = { 0 };
+    long ret = -EINVAL;
+    Error *local_err = NULL;
+
+    msg.cmd = PROXY_PING;
+    msg.bytestream = 0;
+    msg.size = 0;
+
+    ret = mpqemu_msg_send_reply_co(&msg, dev->com, &local_err);
+    if (local_err) {
+        error_report("Lost contact with remote device %s, error code %ld",
+                     ds->id, ret);
+    }
+}
+
+#define NOP_INTERVAL 1000
+
+static void remote_ping(void *opaque)
+{
+    PCIProxyDev *dev = opaque;
+
+    hb_msg(dev);
+
+    timer_mod(dev->hb_timer,
+              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + NOP_INTERVAL);
+}
+
+static void start_hb_timer(PCIProxyDev *dev)
+{
+    dev->hb_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                 remote_ping,
+                                 dev);
+
+    timer_mod(dev->hb_timer,
+              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + NOP_INTERVAL);
+}
+
+static void stop_hb_timer(PCIProxyDev *dev)
+{
+    timer_del(dev->hb_timer);
+    timer_free(dev->hb_timer);
+}
+
+static void pci_proxy_dev_exit(PCIDevice *pdev)
+{
+    PCIProxyDev *dev = PCI_PROXY_DEV(pdev);
+
+    stop_hb_timer(dev);
+}
diff --git a/include/hw/pci/proxy.h b/include/hw/pci/proxy.h
index e6f076ae95..037740309d 100644
--- a/include/hw/pci/proxy.h
+++ b/include/hw/pci/proxy.h
@@ -53,6 +53,8 @@ struct PCIProxyDev {
     EventNotifier intr;
     EventNotifier resample;
 
+    QEMUTimer *hb_timer;
+
     ProxyMemoryRegion region[PCI_NUM_REGIONS];
 };
 
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 4b96cb8ccb..676d7eb3ef 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -44,6 +44,7 @@ typedef enum {
     BAR_READ,
     SET_IRQFD,
     GET_PCI_INFO,
+    PROXY_PING,
     MAX = INT_MAX,
 } MPQemuCmd;
 
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index d09b2a2f50..7452e55e17 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -264,6 +264,7 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
         }
         break;
     case GET_PCI_INFO:
+    case PROXY_PING:
         if (msg->size) {
             return false;
         }
-- 
2.25.GIT


