Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841DCC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:52:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C54C2064A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3pOMMzA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C54C2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51130 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwk1-0005nP-Jh
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59140)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwBd-0005n3-RJ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwBb-0002DN-Pn
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56364)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcwBb-0002Bs-EE
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI8mXw159114;
 Mon, 17 Jun 2019 18:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=R5l+VuYvr/6NBbItTEbfPVYS+QRH6VWHAFYxJS+dhpk=;
 b=3pOMMzA7VvdC9Pb5jj2aeH5nmpLtIfRABSH9gxaUMTgN4O/R1facniMM2zkPAdS62Csw
 EVMPBeiJ7vXMoU96JbpImVK9Ar0Cyhv9NyERHGFFw5JhuJiQB6+n/YhPJb/ETPVB//at
 6/SWSLDmhswjg8yjikpr8hlJvSu/m9kdnBPhRw2+stnY9W0QeCoL5vmQlACcUPtwYcnh
 S7h0kvElxjmuG9CEXBx/BnuSIDZgotwe1FTqIuwf/L8bQfyGXwkJvqRShpKvOgt4DrIn
 i7Jnj3ktFDsjTSEoJgEbRkX/Gk5qabCDK6Xi1hXaS3tBaxesYsZyxbgphOL6TqKTrSnE 4w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2t4saq7yjs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIF9mq118034;
 Mon, 17 Jun 2019 18:16:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2t5cpdkfbr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:53 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5HIGquJ028456;
 Mon, 17 Jun 2019 18:16:52 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 11:16:52 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:16:50 -0700
Message-Id: <20190617181650.30461-1-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170162
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [RFC PATCH v2 29/35] multi-process: add heartbeat
 timer and signal handler
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
Cc: elena.ufimtseva@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com,
 konrad.wilk@oracle.com, berrange@redhat.com, ross.lagerwall@citrix.com,
 liran.alon@oracle.com, stefanha@redhat.com, kanth.ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Add a signal handler for launched remote processes and set up
the heartbit timer for remote processes.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 hw/proxy/qemu-proxy.c   | 101 ++++++++++++++++++++++++++++++++++++++++
 include/io/proxy-link.h |   1 +
 2 files changed, 102 insertions(+)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 1666cc546e..4ee7521987 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -60,14 +60,96 @@
  */
 int kvm_vm_ioctl(KVMState *s, int type, ...);
 
+QEMUTimer *hb_timer;
 static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
 static void setup_irqfd(PCIProxyDev *dev);
+static void pci_dev_exit(PCIDevice *dev);
+static void start_heartbeat_timer(void);
+static void stop_heartbeat_timer(void);
+static void childsig_handler(int sig, siginfo_t *siginfo, void *ctx);
+static void broadcast_msg(ProcMsg *msg, bool need_reply);
+
+static void childsig_handler(int sig, siginfo_t *siginfo, void *ctx)
+{
+    /* TODO: Add proper handler. */
+    printf("Child (pid %d) is dead? Signal is %d, Exit code is %d.\n",
+           siginfo->si_pid, siginfo->si_signo, siginfo->si_code);
+}
+
+static void broadcast_msg(ProcMsg *msg, bool need_reply)
+{
+    PCIProxyDev *entry;
+    unsigned int pid;
+    int wait;
+
+    QLIST_FOREACH(entry, &proxy_dev_list.devices, next) {
+        if (need_reply) {
+            wait = GET_REMOTE_WAIT;
+            msg->num_fds = 1;
+            msg->fds[0] = wait;
+        }
+
+        proxy_proc_send(entry->proxy_link, msg);
+        if (need_reply) {
+            pid = (uint32_t)wait_for_remote(wait);
+            PUT_REMOTE_WAIT(wait);
+            /* TODO: Add proper handling. */
+            if (pid) {
+                need_reply = 0;
+            }
+        }
+    }
+}
+
+#define NOP_INTERVAL 1000000
+
+static void remote_ping(void *opaque)
+{
+    ProcMsg msg;
+
+    memset(&msg, 0, sizeof(ProcMsg));
+
+    msg.num_fds = 0;
+    msg.cmd = PROXY_PING;
+    msg.bytestream = 0;
+    msg.size = 0;
+
+    broadcast_msg(&msg, true);
+    timer_mod(hb_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + NOP_INTERVAL);
+
+}
+
+void start_heartbeat_timer(void)
+{
+    hb_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                            remote_ping,
+                                            &proxy_dev_list);
+    timer_mod(hb_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + NOP_INTERVAL);
+
+}
+
+static void stop_heartbeat_timer(void)
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
 
 static void proxy_ready(PCIDevice *dev)
 {
     PCIProxyDev *pdev = PCI_PROXY_DEV(dev);
 
     setup_irqfd(pdev);
+    set_sigchld_handler();
+    start_heartbeat_timer();
 }
 
 static void set_remote_opts(PCIDevice *dev, QDict *qdict, unsigned int cmd)
@@ -228,6 +310,7 @@ static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = pci_proxy_dev_realize;
+    k->exit = pci_dev_exit;
     k->config_read = pci_proxy_read_config;
     k->config_write = pci_proxy_write_config;
 }
@@ -357,6 +440,24 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
 
 }
 
+static void pci_dev_exit(PCIDevice *pdev)
+{
+    PCIProxyDev *entry, *sentry;
+    PCIProxyDev *dev = PCI_PROXY_DEV(pdev);
+
+    stop_heartbeat_timer();
+
+    QLIST_FOREACH_SAFE(entry, &proxy_dev_list.devices, next, sentry) {
+        if (entry->remote_pid == dev->remote_pid) {
+            QLIST_REMOVE(entry, next);
+        }
+    }
+
+    if (!QLIST_EMPTY(&proxy_dev_list.devices)) {
+        start_heartbeat_timer();
+    }
+}
+
 static void send_bar_access_msg(ProxyLinkState *proxy_link, MemoryRegion *mr,
                                 bool write, hwaddr addr, uint64_t *val,
                                 unsigned size, bool memory)
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index 38bd80535a..2ba3e614f0 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -76,6 +76,7 @@ typedef enum {
     DRIVE_OPTS,
     DEVICE_ADD,
     DEVICE_DEL,
+    PROXY_PING,
     MAX,
 } proc_cmd_t;
 
-- 
2.17.1


