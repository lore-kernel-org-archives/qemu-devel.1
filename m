Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51327CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 181B620856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kAA25MZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181B620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZmx-0003Jq-CH
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZA3-0000zX-Nd
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZA2-00054O-2D
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:12:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33638)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZA1-00053j-Q6
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:12:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94NgR094929;
 Thu, 24 Oct 2019 09:11:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=IJpExN9EMVkwIbWLHn4MVZ2YU5YiDpieBDAknwGb7+w=;
 b=kAA25MZVo7X0ITodjipGSB2TQPqivho5Pq3DYVcBbtro+gQxusNjhT8AWjuOCU6pOr+t
 gNTqCOs6ywZvrSLXLSwQuQSK5yleP3OQW67w/Y4P0KI1LRk3xxZZLa3Vb8Cj7ut51qUB
 YV4e9pmXKjyyvJMPaRF41XR87+TNEismmpgGxTwGb4elwhI1j8MwgV4G8cP4umHN72Vp
 WT5cXhlueI+sypIeuiLyno/fENYE3jt0c0XpIwwo6wk71XUMbTY5wpP/NDa4WOy06GPZ
 2YwfG6EtteFzlnIbblNBwrYKawZkACr7k9KWnkYmztNXBSTMYK4xT0anKX8JLBVq40V8 uA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2vqu4r24tb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:11:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O98lcb076078;
 Thu, 24 Oct 2019 09:11:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2vtjkj30xc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:11:56 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9O9BsU4009911;
 Thu, 24 Oct 2019 09:11:54 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:11:54 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 45/49] multi-process/mig: Synchronize runstate of
 remote process
Date: Thu, 24 Oct 2019 05:09:26 -0400
Message-Id: <5ef7500148d9c15b236f551f6af7b8a4a8d6e81d.1571905346.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
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

Synchronize the runstate of the remote process with that of QEMU

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 New patch in v4

 hw/proxy/qemu-proxy.c         | 18 ++++++++++++++++++
 include/hw/proxy/qemu-proxy.h |  2 ++
 include/io/mpqemu-link.h      |  8 ++++++++
 include/sysemu/runstate.h     |  1 +
 qdev-monitor.c                | 13 ++++++++++++-
 remote/remote-main.c          |  4 ++++
 remote/remote-opts.c          |  5 +++++
 runstate.c                    |  5 +++++
 8 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index c85ffb3..eff299b 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -44,6 +44,7 @@
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qstring.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "hw/proxy/qemu-proxy.h"
 #include "hw/proxy/memory-sync.h"
 #include "qom/object.h"
@@ -656,6 +657,19 @@ static void init_proxy(PCIDevice *dev, char *command, bool need_spawn, Error **e
     }
 }
 
+static void proxy_vm_state_change(void *opaque, int running, RunState state)
+{
+    PCIProxyDev *dev = opaque;
+    MPQemuMsg msg = { 0 };
+
+    msg.cmd = RUNSTATE_SET;
+    msg.bytestream = 0;
+    msg.size = sizeof(msg.data1);
+    msg.data1.runstate.state = state;
+
+    mpqemu_msg_send(dev->mpqemu_link, &msg, dev->mpqemu_link->com);
+}
+
 static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
 {
     PCIProxyDev *dev = PCI_PROXY_DEV(device);
@@ -681,6 +695,8 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
                          &dev->region[r].mr);
     }
 
+    dev->vmcse = qemu_add_vm_change_state_handler(proxy_vm_state_change, dev);
+
     dev->set_proxy_sock = set_proxy_sock;
     dev->get_proxy_sock = get_proxy_sock;
     dev->init_proxy = init_proxy;
@@ -706,6 +722,8 @@ static void pci_dev_exit(PCIDevice *pdev)
     if (!QLIST_EMPTY(&proxy_dev_list.devices)) {
         start_heartbeat_timer();
     }
+
+    qemu_del_vm_change_state_handler(dev->vmcse);
 }
 
 static void send_bar_access_msg(PCIProxyDev *dev, MemoryRegion *mr,
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index b122e6d..7fe987d 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -90,6 +90,8 @@ struct PCIProxyDev {
 
     ProxyMemoryRegion region[PCI_NUM_REGIONS];
 
+    VMChangeStateEntry *vmcse;
+
     uint64_t migsize;
 };
 
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 05dc55e..f5a0bbb 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -39,6 +39,8 @@
 #include "exec/cpu-common.h"
 #include "exec/hwaddr.h"
 
+#include "qapi/qapi-types-run-state.h"
+
 #define TYPE_MPQEMU_LINK "mpqemu-link"
 #define MPQEMU_LINK(obj) \
     OBJECT_CHECK(MPQemuLinkState, (obj), TYPE_MPQEMU_LINK)
@@ -77,6 +79,7 @@ typedef enum {
     DEVICE_RESET,
     START_MIG_OUT,
     START_MIG_IN,
+    RUNSTATE_SET,
     MAX,
 } mpqemu_cmd_t;
 
@@ -115,6 +118,10 @@ typedef struct {
 } mmio_ret_msg_t;
 
 typedef struct {
+    RunState state;
+} runstate_msg_t;
+
+typedef struct {
     mpqemu_cmd_t cmd;
     int bytestream;
     size_t size;
@@ -125,6 +132,7 @@ typedef struct {
         bar_access_msg_t bar_access;
         set_irqfd_msg_t set_irqfd;
         mmio_ret_msg_t mmio_ret;
+        runstate_msg_t runstate;
     } data1;
 
     int fds[REMOTE_MAX_FDS];
diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index e89ebf8..c7ad916 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -8,6 +8,7 @@ extern RunState current_run_state;
 
 bool runstate_check(RunState state);
 void runstate_set(RunState new_state);
+void remote_runstate_set(RunState state);
 int runstate_is_running(void);
 bool runstate_needs_reset(void);
 bool runstate_store(char *str, size_t size);
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 2a2c10b..c6aa35c 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -34,6 +34,7 @@
 #include "qemu/qemu-print.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "migration/misc.h"
 #include "hw/boards.h"
 #include "hw/proxy/qemu-proxy.h"
@@ -641,7 +642,7 @@ void qdev_proxy_fire(void)
 }
 
 DeviceState *qdev_proxy_add(const char *rid, const char *id, char *bus,
-                            char *command, int rsocket, bool managed,
+                            char *cmd, int rsocket, bool managed,
                             Error **errp)
 {
     DeviceState *ds;
@@ -653,6 +654,7 @@ DeviceState *qdev_proxy_add(const char *rid, const char *id, char *bus,
     const char *str;
     bool need_spawn = false;
     bool remote_exists = false;
+    char *command;
 
     if (strlen(rid) > MAX_RID_LENGTH) {
         error_setg(errp, "rid %s is too long.", rid);
@@ -725,6 +727,12 @@ DeviceState *qdev_proxy_add(const char *rid, const char *id, char *bus,
         need_spawn = true;
     }
 
+    if (runstate_check(RUN_STATE_INMIGRATE)) {
+        command = g_strdup_printf("%s %s", cmd, "-incoming defer");
+    } else {
+        command = g_strdup(cmd);
+    }
+
     pdev->init_proxy(PCI_DEVICE(ds), command, need_spawn, errp);
 
     qemu_mutex_lock(&proxy_list_lock);
@@ -732,6 +740,9 @@ DeviceState *qdev_proxy_add(const char *rid, const char *id, char *bus,
     qemu_mutex_unlock(&proxy_list_lock);
 
     qemu_opts_del(proxy_opts);
+
+    g_free(command);
+
     return ds;
 }
 
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 0284039..2de5ddf 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -45,6 +45,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/config-file.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "block/block.h"
 #include "exec/memattrs.h"
 #include "exec/address-spaces.h"
@@ -497,6 +498,9 @@ static void process_msg(GIOCondition cond, MPQemuChannel *chan)
     case START_MIG_OUT:
         process_start_mig_out(msg);
         break;
+    case RUNSTATE_SET:
+        remote_runstate_set(msg->data1.runstate.state);
+        break;
     default:
         error_setg(&err, "Unknown command");
         goto finalize_loop;
diff --git a/remote/remote-opts.c b/remote/remote-opts.c
index 1b1824e..d3ae221 100644
--- a/remote/remote-opts.c
+++ b/remote/remote-opts.c
@@ -56,8 +56,10 @@
 #include "remote/remote-opts.h"
 #include "include/qemu-common.h"
 #include "monitor/monitor.h"
+#include "sysemu/runstate.h"
 
 #include "vl.h"
+
 /*
  * In remote process, we parse only subset of options. The code
  * taken from vl.c to re-use in remote command line parser.
@@ -101,6 +103,9 @@ void parse_cmdline(int argc, char **argv, char **envp)
             case QEMU_OPTION_qmp:
                 monitor_parse(optarg, "control", false);
                 break;
+            case QEMU_OPTION_incoming:
+                remote_runstate_set(RUN_STATE_INMIGRATE);
+                break;
             case QEMU_OPTION_monitor:
                 if (!strncmp(optarg, "stdio", 5)) {
                     warn_report("STDIO not supported in remote process");
diff --git a/runstate.c b/runstate.c
index 273345a..9c5c627 100644
--- a/runstate.c
+++ b/runstate.c
@@ -34,3 +34,8 @@ bool runstate_check(RunState state)
 {
     return current_run_state == state;
 }
+
+void remote_runstate_set(RunState state)
+{
+    current_run_state = state;
+}
-- 
1.8.3.1


