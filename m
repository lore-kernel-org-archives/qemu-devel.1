Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EFFC38BE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:11:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E4B20CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RzSn9zKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E4B20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43413 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6L0G-00056H-LK
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:11:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kmk-0007g3-1f
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kmi-0003qu-Is
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:01 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53606)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Kmi-0003eG-9u
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:00 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKraUh164125;
 Mon, 24 Feb 2020 20:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=ceaeBYb+TTIVt68VNOebp9OmXkjBwu41XUUu2Ljz5+k=;
 b=RzSn9zKtcSinxBc+MMSlknUr4z2zvVnfhu69fI5yX8RnUEe9c/NpM6dPbyVFC5N6oB17
 gxZa5yBnYD/1dweMC9+wMFKHI2bdoeqDRMUsgeI7zhPlKpOpX6yRZupyr4ppKnNkBF3q
 HHnFlBOYuv1+JMQ2tKMCjIaH/9TGR8jad15jfHwGmyZxWXa4r44jBQBwllO4np8NLq0+
 dRC6jOVFX5r4FXkguqP5Rw5N63cgcfcFbR6NP2KmH7U1gih1lsSjDkAfJxScmgPy0zp+
 tqQudvMHYkJCTjYN8by5s+tTuekKqmIEcYFSt1gjnw9PHP9EBM5cailBKywZ0myc3shH wQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2ybvr4p974-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKuerU073146;
 Mon, 24 Feb 2020 20:56:45 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2ybduv6dd4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:45 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01OKuhWv029971;
 Mon, 24 Feb 2020 20:56:43 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:42 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 30/50] multi-process: send heartbeat messages to remote
Date: Mon, 24 Feb 2020 15:55:21 -0500
Message-Id: <a7d4a080616996b90942aa8790a00dfdfc264702.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=3
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240154
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

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

In order to detect remote processes which are hung, the
proxy periodically sends heartbeat messages to confirm if
the remote process is alive

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 v4 -> v5:
  - Heart beat messages are sent asynchronously

 hw/proxy/qemu-proxy.c         | 115 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/proxy/qemu-proxy.h |   2 +
 include/io/mpqemu-link.h      |   1 +
 3 files changed, 118 insertions(+)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index c888677..bcb24f7 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -24,11 +24,104 @@
 #include "hw/boards.h"
 #include "include/qemu/log.h"
 
+QEMUTimer *hb_timer;
 static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
 static void setup_irqfd(PCIProxyDev *dev);
+static void pci_dev_exit(PCIDevice *dev);
+static void start_broadcast_timer(void);
+static void stop_broadcast_timer(void);
+static void childsig_handler(int sig, siginfo_t *siginfo, void *ctx);
+static void broadcast_init(void);
 static int config_op_send(PCIProxyDev *dev, uint32_t addr, uint32_t *val, int l,
                           unsigned int op);
 
+static void childsig_handler(int sig, siginfo_t *siginfo, void *ctx)
+{
+    /* TODO: Add proper handler. */
+    printf("Child (pid %d) is dead? Signal is %d, Exit code is %d.\n",
+           siginfo->si_pid, siginfo->si_signo, siginfo->si_code);
+}
+
+static void remote_ping_handler(void *opaque)
+{
+    PCIProxyDev *pdev = opaque;
+
+    if (!event_notifier_test_and_clear(&pdev->en_ping)) {
+        /*
+         * TODO: Is retry needed? Add the handling of the
+         * non-responsive process. How its done in case
+         * of managed process?
+         */
+        printf("No reply from remote process, pid %d\n", pdev->remote_pid);
+        event_notifier_cleanup(&pdev->en_ping);
+    }
+}
+
+static void broadcast_msg(void)
+{
+    MPQemuMsg msg;
+    PCIProxyDev *entry;
+
+    QLIST_FOREACH(entry, &proxy_dev_list.devices, next) {
+        if (event_notifier_get_fd(&entry->en_ping) == -1) {
+            continue;
+        }
+
+        memset(&msg, 0, sizeof(MPQemuMsg));
+
+        msg.num_fds = 1;
+        msg.cmd = PROXY_PING;
+        msg.bytestream = 0;
+        msg.size = 0;
+        msg.fds[0] = event_notifier_get_fd(&entry->en_ping);
+
+        mpqemu_msg_send(&msg, entry->mpqemu_link->com);
+    }
+}
+
+static void broadcast_init(void)
+{
+    PCIProxyDev *entry;
+
+    QLIST_FOREACH(entry, &proxy_dev_list.devices, next) {
+        event_notifier_init(&entry->en_ping, 0);
+        qemu_set_fd_handler(event_notifier_get_fd(&entry->en_ping),
+                            remote_ping_handler, NULL, entry);
+    }
+}
+
+#define NOP_INTERVAL 1000000
+
+static void remote_ping(void *opaque)
+{
+    broadcast_msg();
+    timer_mod(hb_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + NOP_INTERVAL);
+}
+
+static void start_broadcast_timer(void)
+{
+    hb_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                            remote_ping,
+                                            &proxy_dev_list);
+    timer_mod(hb_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + NOP_INTERVAL);
+
+}
+
+static void stop_broadcast_timer(void)
+{
+    timer_del(hb_timer);
+    timer_free(hb_timer);
+}
+
+static void set_sigchld_handler(void)
+{
+    struct sigaction sa_sigterm;
+    memset(&sa_sigterm, 0, sizeof(sa_sigterm));
+    sa_sigterm.sa_sigaction = childsig_handler;
+    sa_sigterm.sa_flags = SA_SIGINFO | SA_NOCLDWAIT | SA_NOCLDSTOP;
+    sigaction(SIGCHLD, &sa_sigterm, NULL);
+}
+
 static void probe_pci_info(PCIDevice *dev)
 {
     PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
@@ -111,6 +204,9 @@ static void proxy_ready(PCIDevice *dev)
 
     setup_irqfd(pdev);
     probe_pci_info(dev);
+    set_sigchld_handler();
+    broadcast_init();
+    start_broadcast_timer();
 }
 
 static int set_remote_opts(PCIDevice *dev, QDict *qdict, unsigned int cmd)
@@ -325,6 +421,7 @@ static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = pci_proxy_dev_realize;
+    k->exit = pci_dev_exit;
     k->config_read = pci_proxy_read_config;
     k->config_write = pci_proxy_write_config;
 }
@@ -455,6 +552,24 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
     dev->proxy_ready = proxy_ready;
 }
 
+static void pci_dev_exit(PCIDevice *pdev)
+{
+    PCIProxyDev *entry, *sentry;
+    PCIProxyDev *dev = PCI_PROXY_DEV(pdev);
+
+    stop_broadcast_timer();
+
+    QLIST_FOREACH_SAFE(entry, &proxy_dev_list.devices, next, sentry) {
+        if (entry->remote_pid == dev->remote_pid) {
+            QLIST_REMOVE(entry, next);
+        }
+    }
+
+    if (!QLIST_EMPTY(&proxy_dev_list.devices)) {
+        start_broadcast_timer();
+    }
+}
+
 static void send_bar_access_msg(PCIProxyDev *dev, MemoryRegion *mr,
                                 bool write, hwaddr addr, uint64_t *val,
                                 unsigned size, bool memory)
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index 7c6bddd..f7666fb 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -55,6 +55,8 @@ struct PCIProxyDev {
     EventNotifier resample;
 
     pid_t remote_pid;
+    EventNotifier en_ping;
+
     int socket;
 
     char *rid;
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 2ca89c5..aaaf1a4 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -60,6 +60,7 @@ typedef enum {
     DEVICE_DEL,
     GET_PCI_INFO,
     RET_PCI_INFO,
+    PROXY_PING,
     MAX,
 } mpqemu_cmd_t;
 
-- 
1.8.3.1


