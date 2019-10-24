Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AD8CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B97E20684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T7ipIBkP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B97E20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZYP-0003nV-NB
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZAA-0001FK-Jk
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:12:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZA9-00058N-3q
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:12:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33766)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZA8-00057q-Rw
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:12:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94MZM094876;
 Thu, 24 Oct 2019 09:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=gCWsykrT2ZYwtnVJc3JGpccSZ6Ixl2ZrCx98KSbpob0=;
 b=T7ipIBkPDjTApC0Ir+dPxrP0oYEqzLyBNE2Rr9bCHxp1Hq+DF6GSc9gyCaWZ0D4TFKj2
 7Q/rq7WPmteWmnGSVRjfzf4GGSMUuon5Mfb+YwggZugRuO5rrmzebnx5ngE9zBvNHvap
 V9jvF5C0rn3n0k/iZBVM/x0wBg2AHeNia1QUigA45yiR7sOdZixutwaXhkpOWOWDa4bx
 QjVvbKjHULXPfN2GK6Pg3cW4Il78hMtIIMigNk47Psry+e2eFfHa7MhylV6luuCEMHk9
 TMz/qPRec3omKJaJvuyM+BqsA+0AKUU/Cg/Q32FWCxZYSi6O80NpwXAJQdrcQevMEq/R wQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2vqu4r24u0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:12:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O97jeA170529;
 Thu, 24 Oct 2019 09:12:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2vtsk489s5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:12:02 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9O9C11F024604;
 Thu, 24 Oct 2019 09:12:01 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:12:00 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 47/49] multi-process: Enable support for multiple
 devices in remote
Date: Thu, 24 Oct 2019 05:09:28 -0400
Message-Id: <c67656abcd0e41278710460d2920036254ecffb7.1571905346.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240089
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 kraxel@redhat.com, jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
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
 New patch in v4

 hw/proxy/qemu-proxy.c         |  3 +++
 include/hw/proxy/qemu-proxy.h |  3 +++
 include/io/mpqemu-link.h      |  1 +
 qdev-monitor.c                |  2 ++
 remote/remote-main.c          | 34 ++++++++++++++++++++++++----------
 5 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index eff299b..2231c36 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -176,6 +176,7 @@ static void set_remote_opts(PCIDevice *dev, QDict *qdict, unsigned int cmd)
     msg.bytestream = 1;
     msg.size = qstring_get_length(qstr) + 1;
     msg.num_fds = 0;
+    msg.id = pdev->id;
 
     mpqemu_msg_send(pdev->mpqemu_link, &msg, pdev->mpqemu_link->com);
 
@@ -322,6 +323,7 @@ static int config_op_send(PCIProxyDev *dev, uint32_t addr, uint32_t *val, int l,
     msg.size = sizeof(conf_data);
     msg.cmd = op;
     msg.bytestream = 1;
+    msg.id = dev->id;
 
     if (op == CONF_WRITE) {
         msg.num_fds = 0;
@@ -602,6 +604,7 @@ static void setup_irqfd(PCIProxyDev *dev)
 
     memset(&msg, 0, sizeof(MPQemuMsg));
     msg.cmd = SET_IRQFD;
+    msg.id = dev->id;
     msg.num_fds = 2;
     msg.fds[0] = event_notifier_get_fd(&dev->intr);
     msg.fds[1] = event_notifier_get_fd(&dev->resample);
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index 7fe987d..6a0a574 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -57,6 +57,9 @@ extern const MemoryRegionOps proxy_default_ops;
 struct PCIProxyDev {
     PCIDevice parent_dev;
 
+    uint64_t id;
+    uint64_t nr_devices;
+
     int n_mr_sections;
     MemoryRegionSection *mr_sections;
 
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index f5a0bbb..ba81515 100644
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
index c6aa35c..70a7a5a 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -716,9 +716,11 @@ DeviceState *qdev_proxy_add(const char *rid, const char *id, char *bus,
         pdev->mmio_sock = old_pdev->mmio_sock;
         pdev->remote_pid = old_pdev->remote_pid;
         pdev->mem_init = true;
+        pdev->id = old_pdev->nr_devices++;
     } else {
         pdev->rsocket = managed ? rsocket : -1;
         pdev->socket = managed ? rsocket : -1;
+        pdev->id =  pdev->nr_devices++;
     }
     pdev->managed = managed;
 
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 600c894..93b8500 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -85,7 +85,8 @@
 
 static MPQemuLinkState *mpqemu_link;
 
-PCIDevice *remote_pci_dev;
+PCIDevice **remote_pci_devs;
+uint64_t nr_devices;
 bool create_done;
 
 static void process_config_write(MPQemuMsg *msg)
@@ -93,7 +94,8 @@ static void process_config_write(MPQemuMsg *msg)
     struct conf_data_msg *conf = (struct conf_data_msg *)msg->data2;
 
     qemu_mutex_lock_iothread();
-    pci_default_write_config(remote_pci_dev, conf->addr, conf->val, conf->l);
+    pci_default_write_config(remote_pci_devs[msg->id], conf->addr, conf->val,
+                             conf->l);
     qemu_mutex_unlock_iothread();
 }
 
@@ -106,7 +108,8 @@ static void process_config_read(MPQemuMsg *msg)
     wait = msg->fds[0];
 
     qemu_mutex_lock_iothread();
-    val = pci_default_read_config(remote_pci_dev, conf->addr, conf->l);
+    val = pci_default_read_config(remote_pci_devs[msg->id], conf->addr,
+                                  conf->l);
     qemu_mutex_unlock_iothread();
 
     notify_proxy(wait, val);
@@ -366,9 +369,17 @@ static int setup_device(MPQemuMsg *msg, Error **errp)
                    qstring_get_str(qobject_to_json(QOBJECT(qdict))));
         return rc;
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
+
     qemu_opts_del(opts);
 
     return 0;
@@ -489,12 +500,15 @@ static void process_msg(GIOCondition cond, MPQemuChannel *chan)
         }
         break;
     case SET_IRQFD:
-        process_set_irqfd_msg(remote_pci_dev, msg);
-        qdev_machine_creation_done();
-        qemu_mutex_lock_iothread();
-        qemu_run_machine_init_done_notifiers();
-        qemu_mutex_unlock_iothread();
-        create_done = true;
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
     case DRIVE_OPTS:
         if (setup_drive(msg, &err)) {
-- 
1.8.3.1


