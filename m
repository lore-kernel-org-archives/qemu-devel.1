Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13CFC38BF9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:27:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F03F218AC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cg0yzKu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F03F218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6LG6-0000lY-KY
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6KnC-0000KP-99
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kn9-0004Fc-Qd
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:30 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Kn9-00047p-80
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:27 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKrwcL164272;
 Mon, 24 Feb 2020 20:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=+1jeGUAaUlIqzn5k0+XSLH8Faol3m+U3usz3h4qw4NQ=;
 b=Cg0yzKu6onqOwRbX6sj4cz2eIZrIqDNqdfIegCuN22l0pIynxeFyI4zZNMMCfrfteQvg
 1gJ1J7G9fHyEVrHNSVksrKWBpDVI8oaxiHxyCYJ+Zr6AayHYL0SdwarkQ52ohHjMQ3/0
 LADoIo3wXJeYuRsaR1Jd+8hWrREdHLMmjSq6K/Bk7i8/EvAB2pG9YDxyR3KFECKC+6Ue
 +R1KHLcvTF6ffrsPv6xTMQYrV2uKCdpcBUKRb+b/Sd0qG9fumn0O3W2K4IWNQ6g8N7QU
 u6TzNuc9VsDTvgEl7GIeokNsrINUZmlnvcpOl5w8D/56x9vID5CDBf+6H0HzAyjKg02P /w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2ybvr4p99s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:57:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKpxwk108725;
 Mon, 24 Feb 2020 20:57:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2ybe123v1p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:57:10 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01OKv9p1009755;
 Mon, 24 Feb 2020 20:57:09 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:57:09 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 47/50] multi-process: Enable support for multiple devices
 in remote
Date: Mon, 24 Feb 2020 15:55:38 -0500
Message-Id: <cf33de60b827e0cdd3d5fce48eb038cb056dc304.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 suspectscore=1 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=1 phishscore=0
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

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Add support to allow multiple devices to be configured in the
remote process

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 hw/proxy/qemu-proxy.c         |  4 ++-
 include/hw/proxy/qemu-proxy.h |  3 +++
 include/io/mpqemu-link.h      |  1 +
 qdev-monitor.c                |  2 ++
 remote/remote-main.c          | 62 +++++++++++++++++++++++++++++++++++--------
 5 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 5876957..4d4eff4 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -242,7 +242,7 @@ static int set_remote_opts(PCIDevice *dev, QDict *qdict, unsigned int cmd)
     msg.cmd = cmd;
     msg.bytestream = 1;
     msg.size = qstring_get_length(qstr) + 1;
-
+    msg.id = pdev->id;
 
     wait = eventfd(0, EFD_NONBLOCK);
     msg.num_fds = 1;
@@ -404,6 +404,7 @@ static int config_op_send(PCIProxyDev *dev, uint32_t addr, uint32_t *val, int l,
     msg.size = sizeof(conf_data);
     msg.cmd = op;
     msg.bytestream = 1;
+    msg.id = dev->id;
 
     if (op == PCI_CONFIG_WRITE) {
         msg.num_fds = 0;
@@ -710,6 +711,7 @@ static void setup_irqfd(PCIProxyDev *dev)
 
     memset(&msg, 0, sizeof(MPQemuMsg));
     msg.cmd = SET_IRQFD;
+    msg.id = dev->id;
     msg.num_fds = 2;
     msg.fds[0] = event_notifier_get_fd(&dev->intr);
     msg.fds[1] = event_notifier_get_fd(&dev->resample);
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index 6784298..5ff3aec 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -43,6 +43,9 @@ extern const MemoryRegionOps proxy_default_ops;
 struct PCIProxyDev {
     PCIDevice parent_dev;
 
+    uint64_t id;
+    uint64_t nr_devices;
+
     int n_mr_sections;
     MemoryRegionSection *mr_sections;
 
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index beb8293..722f08c 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -124,6 +124,7 @@ typedef struct {
 typedef struct {
     mpqemu_cmd_t cmd;
     int bytestream;
+    uint64_t id;
     size_t size;
 
     union {
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 8efa1a8..cda2545 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -735,8 +735,10 @@ DeviceState *qdev_proxy_add(const char *rid, const char *id, char *bus,
         pdev->mmio_sock = old_pdev->mmio_sock;
         pdev->remote_pid = old_pdev->remote_pid;
         pdev->mem_init = true;
+        pdev->id = old_pdev->nr_devices++;
     } else {
         pdev->socket = managed ? socket : -1;
+        pdev->id =  pdev->nr_devices++;
     }
     pdev->managed = managed;
 
diff --git a/remote/remote-main.c b/remote/remote-main.c
index ab4ad0b..20d160e 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -72,15 +72,23 @@
 
 static MPQemuLinkState *mpqemu_link;
 
-PCIDevice *remote_pci_dev;
+PCIDevice **remote_pci_devs;
+uint64_t nr_devices;
+#define MAX_REMOTE_DEVICES 256
+
 bool create_done;
 
 static void process_config_write(MPQemuMsg *msg)
 {
     struct conf_data_msg *conf = (struct conf_data_msg *)msg->data2;
 
+    if (msg->id > nr_devices) {
+        return;
+    }
+
     qemu_mutex_lock_iothread();
-    pci_default_write_config(remote_pci_dev, conf->addr, conf->val, conf->l);
+    pci_default_write_config(remote_pci_devs[msg->id], conf->addr, conf->val,
+                             conf->l);
     qemu_mutex_unlock_iothread();
 }
 
@@ -92,8 +100,13 @@ static void process_config_read(MPQemuMsg *msg)
 
     wait = msg->fds[0];
 
+    if (msg->id > nr_devices) {
+        return;
+    }
+
     qemu_mutex_lock_iothread();
-    val = pci_default_read_config(remote_pci_dev, conf->addr, conf->l);
+    val = pci_default_read_config(remote_pci_devs[msg->id], conf->addr,
+                                  conf->l);
     qemu_mutex_unlock_iothread();
 
     notify_proxy(wait, val);
@@ -282,6 +295,13 @@ static int setup_device(MPQemuMsg *msg, Error **errp)
     }
 
     if (!msg->data2) {
+        error_setg(errp, "Message data is empty");
+        return rc;
+    }
+
+    if (msg->id > MAX_REMOTE_DEVICES) {
+        error_setg(errp, "id of the device is larger than max number of "\
+                         "devices per remote process.");
         return rc;
     }
 
@@ -319,8 +339,15 @@ static int setup_device(MPQemuMsg *msg, Error **errp)
                    qstring_get_str(qobject_to_json(QOBJECT(qdict))));
         goto device_failed;
     }
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
-        remote_pci_dev = PCI_DEVICE(dev);
+        if (nr_devices <= msg->id) {
+            nr_devices = msg->id + 1;
+            remote_pci_devs = g_realloc(remote_pci_devs,
+                                        nr_devices * sizeof(PCIDevice *));
+        }
+
+        remote_pci_devs[msg->id] = PCI_DEVICE(dev);
     }
 
     notify_proxy(wait, (uint32_t)REMOTE_OK);
@@ -405,11 +432,17 @@ static void process_msg(GIOCondition cond, MPQemuChannel *chan)
         goto finalize_loop;
     }
 
+    if (msg->id > MAX_REMOTE_DEVICES) {
+        error_setg(&err, "id of the device is larger than max number of "\
+                         "devices per remote process.");
+        goto finalize_loop;
+    }
+
     switch (msg->cmd) {
     case INIT:
         break;
     case GET_PCI_INFO:
-        process_get_pci_info_msg(remote_pci_dev, msg);
+        process_get_pci_info_msg(remote_pci_devs[msg->id], msg);
         break;
     case PCI_CONFIG_WRITE:
         if (create_done) {
@@ -449,12 +482,19 @@ static void process_msg(GIOCondition cond, MPQemuChannel *chan)
         }
         break;
     case SET_IRQFD:
-        process_set_irqfd_msg(remote_pci_dev, msg);
-        qdev_machine_creation_done();
-        qemu_mutex_lock_iothread();
-        qemu_run_machine_init_done_notifiers();
-        qemu_mutex_unlock_iothread();
-        create_done = true;
+        if (msg->id > nr_devices) {
+            error_setg(&err, "incorrect device id in the message");
+            goto finalize_loop;
+        }
+        process_set_irqfd_msg(remote_pci_devs[msg->id], msg);
+
+        if (!create_done) {
+            qdev_machine_creation_done();
+            qemu_mutex_lock_iothread();
+            qemu_run_machine_init_done_notifiers();
+            qemu_mutex_unlock_iothread();
+            create_done = true;
+        }
         break;
     case DEV_OPTS:
         if (setup_device(msg, &err)) {
-- 
1.8.3.1


