Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC5BC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 206992071C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cg871aKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206992071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRTbZ-0008CN-08
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 00:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTIp-0004GY-Rm
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:17:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTIn-0003Ui-Se
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:17:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jRTIl-0003Td-QH
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:17:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4CmWP051965;
 Thu, 23 Apr 2020 04:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=s4YUcDMDMeJff/QsH9+E/U2kboF2ra3f7v4UbMNZs9k=;
 b=Cg871aKcyoD4LDxcw4WjoGEb7J66yIds9p88F9C1PCAKvZ1+Gc4cXKmrMa7vJtlI4L0C
 Cp2UlAJZW7OFTzPIXaqDuotiAuuHVSFqUfQsx2PGD504SMcw9FOeZntndCE7nuNcii6o
 O6PD4Npe7lUlSYTmb4Fp6zyPlFkZZCsLPZmHm2ehiEhDpp2wylkkxLsn+Uvwv8inSIyx
 V9ynsFGVVa8QiZJhEoQYkV+6IfANAexhgdv4ko3sJGGVkwyYP6tF9piKOeY0DBRLcgDD
 gNDifOUPtDx7jnjJ7tQgDOETsY0dXN41BkGDig99lU/R9eoWumIPnlTXxzhLRPrKQ/l/ iQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 30jhyc5475-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:17:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4CIfW089338;
 Thu, 23 Apr 2020 04:15:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 30gb1ku8d9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:15:18 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03N4FFm5026665;
 Thu, 23 Apr 2020 04:15:15 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 22 Apr 2020 21:15:15 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v6 28/36] multi-process: send heartbeat messages to
 remote
Date: Wed, 22 Apr 2020 21:14:03 -0700
Message-Id: <bf13fc6e633b70498ee47ad4bc5f22890edcf422.1587614626.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1587614626.git.elena.ufimtseva@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=3 spamscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 mlxscore=0
 clxscore=1015 suspectscore=3 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 00:14:40
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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
 hw/proxy/qemu-proxy.c         | 86 +++++++++++++++++++++++++++++++++++
 include/hw/proxy/qemu-proxy.h |  3 ++
 include/io/mpqemu-link.h      |  1 +
 io/mpqemu-link.c              |  5 ++
 4 files changed, 95 insertions(+)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 730e28483e..162014353f 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -21,6 +21,78 @@
 
 static void probe_pci_info(PCIDevice *dev);
 
+static void childsig_handler(int sig, siginfo_t *siginfo, void *ctx)
+{
+    /* TODO: Add proper handler. */
+    printf("Child (pid %d) is dead? Signal is %d, Exit code is %d.\n",
+           siginfo->si_pid, siginfo->si_signo, siginfo->si_code);
+}
+
+static void hb_msg(PCIProxyDev *dev)
+{
+    DeviceState *ds = DEVICE(dev);
+    MPQemuMsg msg = { 0 };
+    uint64_t ret;
+
+    if (event_notifier_get_fd(&dev->en_ping) == -1) {
+        return;
+    }
+
+    memset(&msg, 0, sizeof(MPQemuMsg));
+
+    msg.num_fds = 1;
+    msg.cmd = PROXY_PING;
+    msg.bytestream = 0;
+    msg.size = 0;
+    msg.fds[0] = event_notifier_get_fd(&dev->en_ping);
+
+    mpqemu_msg_send(&msg, dev->mpqemu_link->com);
+
+    ret = wait_for_remote(msg.fds[0]);
+
+    if (ret) {
+        printf("Lost contact with remote device %s\n", ds->id);
+        /* TODO: Initiate error recovery */
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
+static void set_sigchld_handler(void)
+{
+    struct sigaction sa_sigterm;
+    memset(&sa_sigterm, 0, sizeof(sa_sigterm));
+    sa_sigterm.sa_sigaction = childsig_handler;
+    sa_sigterm.sa_flags = SA_SIGINFO | SA_NOCLDWAIT | SA_NOCLDSTOP;
+    sigaction(SIGCHLD, &sa_sigterm, NULL);
+}
+
 static int config_op_send(PCIProxyDev *dev, uint32_t addr, uint32_t *val, int l,
                           unsigned int op)
 {
@@ -204,6 +276,19 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
     setup_irqfd(dev);
 
     probe_pci_info(PCI_DEVICE(dev));
+
+    set_sigchld_handler();
+
+    event_notifier_init(&dev->en_ping, 0);
+
+    start_hb_timer(dev);
+}
+
+static void pci_proxy_dev_exit(PCIDevice *pdev)
+{
+    PCIProxyDev *dev = PCI_PROXY_DEV(pdev);
+
+    stop_hb_timer(dev);
 }
 
 static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
@@ -211,6 +296,7 @@ static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = pci_proxy_dev_realize;
+    k->exit = pci_proxy_dev_exit;
     k->config_read = pci_proxy_read_config;
     k->config_write = pci_proxy_write_config;
 }
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index 0d8ec6d686..26f0a41110 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -55,6 +55,9 @@ struct PCIProxyDev {
     EventNotifier intr;
     EventNotifier resample;
 
+    EventNotifier en_ping;
+    QEMUTimer *hb_timer;
+
     int socket;
 
     ProxyMemoryRegion region[PCI_NUM_REGIONS];
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 102c736705..45ea1fcafa 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -50,6 +50,7 @@ typedef enum {
     SET_IRQFD,
     GET_PCI_INFO,
     RET_PCI_INFO,
+    PROXY_PING,
     MAX,
 } mpqemu_cmd_t;
 
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index ea519a980e..91a3395566 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -394,6 +394,11 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
             return false;
         }
         break;
+    case PROXY_PING:
+        if (msg->size != 0) {
+            return false;
+        }
+        break;
     default:
         break;
     }
-- 
2.25.GIT


