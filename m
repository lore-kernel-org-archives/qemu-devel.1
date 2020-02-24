Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E6FC38BF9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:23:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DDA9218AC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DLVOPyR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDA9218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6LCM-0001sq-6l
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:23:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50973)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kmx-0008Io-AX
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kmv-00044r-K7
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:15 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42630)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Kmv-00043u-Bn
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:13 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKqUdo017508;
 Mon, 24 Feb 2020 20:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=rETKtHDkshwrTeRqU0486Rf1Kao7HcbWs/Qtqu1xgj4=;
 b=DLVOPyR9oZ0zN6yz0+5q/UIQzZI7COWpFQ+o+jAWj44DCLmnN+No/7XiDqfHQvb80pc9
 zzgfVUA8EbLyGZUl2pQM49LSWEBWmtVex1T8z0hWWw4XFcAsiMAVeh7k2Cd821GhtFdb
 TpTfdaclGH8cxiC9xc0LcK52URdYZe8KjCUoRldNrXsw8lX0Md0m5Z7cBn/RFu41p4Jc
 jKkN9kVIMHnXuhY09/LQES3vW+oT5SGqfVcyRX0SdB6zlKY2v6xfl/sK28JgHslWYK6C
 vJCYK8nwlOSPDeo4L9+NuUORmiF1da20EdRufs6nB3JbuHvS8WXB5PFOD0chGOdRWiFI Hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2yavxrhymg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:57:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKq8GI171412;
 Mon, 24 Feb 2020 20:57:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2ybdshkst4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:57:07 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01OKv6jU030206;
 Mon, 24 Feb 2020 20:57:06 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:57:06 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 45/50] multi-process/mig: Synchronize runstate of remote
 process
Date: Mon, 24 Feb 2020 15:55:36 -0500
Message-Id: <6d523c1692a465383fa5e1e380d67d8eea73ae0e.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=1 spamscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=1 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
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

Synchronize the runstate of the remote process with that of QEMU

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 hw/proxy/qemu-proxy.c         | 26 ++++++++++++++++++++++++++
 include/hw/proxy/qemu-proxy.h |  2 ++
 include/io/mpqemu-link.h      |  8 ++++++++
 include/sysemu/runstate.h     |  1 +
 qdev-monitor.c                | 11 ++++++++++-
 remote/remote-main.c          |  5 +++++
 remote/remote-opts.c          |  5 +++++
 runstate.c                    |  5 +++++
 8 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 1649f60..5876957 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -15,6 +15,7 @@
 #include "hw/pci/pci.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qstring.h"
+#include "sysemu/runstate.h"
 #include "hw/proxy/qemu-proxy.h"
 #include "hw/proxy/memory-sync.h"
 #include "qom/object.h"
@@ -765,6 +766,27 @@ static void init_proxy(PCIDevice *dev, char *command, char *exec_name,
     }
 }
 
+static void proxy_vm_state_change(void *opaque, int running, RunState state)
+{
+    PCIProxyDev *dev = opaque;
+    MPQemuMsg msg = { 0 };
+    int wait = -1;
+
+    msg.cmd = RUNSTATE_SET;
+    msg.bytestream = 0;
+    msg.size = sizeof(msg.data1);
+    msg.data1.runstate.state = state;
+
+    wait = eventfd(0, EFD_CLOEXEC);
+    msg.num_fds = 1;
+    msg.fds[0] = wait;
+
+    mpqemu_msg_send(&msg, dev->mpqemu_link->com);
+
+    wait_for_remote(wait);
+    close(wait);
+}
+
 static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
 {
     PCIProxyDev *dev = PCI_PROXY_DEV(device);
@@ -782,6 +804,8 @@ static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
         }
     }
 
+    dev->vmcse = qemu_add_vm_change_state_handler(proxy_vm_state_change, dev);
+
     dev->set_proxy_sock = set_proxy_sock;
     dev->get_proxy_sock = get_proxy_sock;
     dev->init_proxy = init_proxy;
@@ -807,6 +831,8 @@ static void pci_dev_exit(PCIDevice *pdev)
     if (!QLIST_EMPTY(&proxy_dev_list.devices)) {
         start_broadcast_timer();
     }
+
+    qemu_del_vm_change_state_handler(dev->vmcse);
 }
 
 static void send_bar_access_msg(PCIProxyDev *dev, MemoryRegion *mr,
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index 537c227..6784298 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -76,6 +76,8 @@ struct PCIProxyDev {
 
     ProxyMemoryRegion region[PCI_NUM_REGIONS];
 
+    VMChangeStateEntry *vmcse;
+
     uint64_t migsize;
 };
 
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 01371fc..beb8293 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -20,6 +20,8 @@
 #include "exec/cpu-common.h"
 #include "exec/hwaddr.h"
 
+#include "qapi/qapi-types-run-state.h"
+
 #define TYPE_MPQEMU_LINK "mpqemu-link"
 #define MPQEMU_LINK(obj) \
     OBJECT_CHECK(MPQemuLinkState, (obj), TYPE_MPQEMU_LINK)
@@ -65,6 +67,7 @@ typedef enum {
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
@@ -126,6 +133,7 @@ typedef struct {
         set_irqfd_msg_t set_irqfd;
         ret_pci_info_msg_t ret_pci_info;
         mmio_ret_msg_t mmio_ret;
+        runstate_msg_t runstate;
     } data1;
 
     int fds[REMOTE_MAX_FDS];
diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index ece939f..8c5810f 100644
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
index f120509..8efa1a8 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -35,6 +35,7 @@
 #include "qemu/option_int.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "migration/misc.h"
 #include "migration/migration.h"
 #include "qemu/cutils.h"
@@ -674,6 +675,7 @@ DeviceState *qdev_proxy_add(const char *rid, const char *id, char *bus,
     const char *str;
     bool need_spawn = false;
     bool remote_exists = false;
+    char *command = NULL;
 
     if (strlen(rid) > MAX_RID_LENGTH) {
         error_setg(errp, "rid %s is too long.", rid);
@@ -743,11 +745,18 @@ DeviceState *qdev_proxy_add(const char *rid, const char *id, char *bus,
         need_spawn = true;
     }
 
-    pdev->init_proxy(PCI_DEVICE(ds), cmd, exec_name, need_spawn, errp);
+    if (runstate_check(RUN_STATE_INMIGRATE)) {
+        command = g_strdup_printf("%s %s", cmd, "-incoming defer");
+    } else {
+        command = g_strdup(cmd);
+    }
+
+    pdev->init_proxy(PCI_DEVICE(ds), command, exec_name, need_spawn, errp);
 
     QLIST_INSERT_HEAD(&proxy_dev_list.devices, pdev, next);
 
     qemu_opts_del(proxy_opts);
+
     return ds;
 }
 
diff --git a/remote/remote-main.c b/remote/remote-main.c
index e97eb76..0260c7c 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -31,6 +31,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/config-file.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "block/block.h"
 #include "exec/ramlist.h"
 #include "exec/memattrs.h"
@@ -454,6 +455,10 @@ static void process_msg(GIOCondition cond, MPQemuChannel *chan)
     case START_MIG_OUT:
         process_start_mig_out(msg);
         break;
+    case RUNSTATE_SET:
+        remote_runstate_set(msg->data1.runstate.state);
+        notify_proxy(msg->fds[0], 0);
+        break;
     default:
         error_setg(&err, "Unknown command");
         goto finalize_loop;
diff --git a/remote/remote-opts.c b/remote/remote-opts.c
index e22ad5c..839baf1 100644
--- a/remote/remote-opts.c
+++ b/remote/remote-opts.c
@@ -40,8 +40,10 @@
 #include "remote/remote-opts.h"
 #include "include/qemu-common.h"
 #include "monitor/monitor.h"
+#include "sysemu/runstate.h"
 
 #include "vl.h"
+
 /*
  * In remote process, we parse only subset of options. The code
  * taken from vl.c to re-use in remote command line parser.
@@ -85,6 +87,9 @@ void parse_cmdline(int argc, char **argv, char **envp)
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


