Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567C1C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22DAA2084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a/PHizzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DAA2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51010 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwWD-0000Kt-Ct
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59179)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwBj-0005sA-PT
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwBh-0002JS-QO
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:17:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56446)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcwBh-0002HB-02
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:17:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI8uWC159143;
 Mon, 17 Jun 2019 18:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=luvCTnUgcQuSR2sA80lgp+w2naBhphhsCAlzxkjYxZo=;
 b=a/PHizzktPgDOWTbyoHmtW8iILBSe34hhJQKEI9HY3sEtU0AHnXYcM6myKR/aORnwTne
 f/OV9AUK8Nitf+t+Szph/gmpwQqZUn1Utpzny5Or0S9jHvZk5FBzxhwTVeO8pWXNg5UJ
 7lXTOmatmmEHwDzMrGgCjRPiYqf4if9mDLuNLJ0Iya9a8HddUYZyIykmY6fMJ9E2Yg9k
 OX2PtVm8H/FNvN9PL9iiFWGZhLMaguxpBPDlqNx2AQXZenrOXpH+UfnLmBdhyAimhokq
 IWxw1M7WQKdMFj6qv4CddE5P3ntSJSIN4uCkGdW10j6uT+L0UTBfgQkRWb8n3J96+v62 aA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2t4saq7yk5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIF5D0050134;
 Mon, 17 Jun 2019 18:16:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2t5h5t9g38-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:58 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5HIGv7P015218;
 Mon, 17 Jun 2019 18:16:57 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 11:16:57 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:16:55 -0700
Message-Id: <20190617181655.30551-1-elena.ufimtseva@oracle.com>
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
Subject: [Qemu-devel] [RFC PATCH v2 31/35] multi-process: Extend drive_add
 to add drive to remote device
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
 konrad.wilk@oracle.com, dgilbert@redhat.com, ross.lagerwall@citrix.com,
 liran.alon@oracle.com, berrange@redhat.com, stefanha@redhat.com,
 kanth.ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jagannathan Raman <jag.raman@oracle.com>

Extend drive_add HMP command to hot-plug drive to a remote device.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 device-hotplug.c        |  7 +++++++
 hmp-commands.hx         |  5 +++--
 hw/proxy/monitor.c      | 35 +++++++++++++++++++++++++++++++++++
 include/io/proxy-link.h |  2 ++
 include/sysemu/sysemu.h |  1 +
 remote/machine.c        |  8 ++++++++
 remote/remote-main.c    | 31 +++++++++++++++++++++++++++++++
 7 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/device-hotplug.c b/device-hotplug.c
index 6153259d71..094702ff3e 100644
--- a/device-hotplug.c
+++ b/device-hotplug.c
@@ -63,6 +63,13 @@ void hmp_drive_add(Monitor *mon, const QDict *qdict)
     const char *opts = qdict_get_str(qdict, "opts");
     bool node = qdict_get_try_bool(qdict, "node", false);
 
+#ifdef CONFIG_MPQEMU
+    if (qdict_get_try_str(qdict, "rid")) {
+        hmp_rdrive_add(mon, qdict);
+        return;
+    }
+#endif
+
     if (node) {
         hmp_drive_add_node(mon, opts);
         return;
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 605d18be85..2757b07ecf 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1341,12 +1341,13 @@ ETEXI
 
     {
         .name       = "drive_add",
-        .args_type  = "node:-n,pci_addr:s,opts:s",
+        .args_type  = "node:-n,pci_addr:s,opts:s,rid:s?",
         .params     = "[-n] [[<domain>:]<bus>:]<slot>\n"
                       "[file=file][,if=type][,bus=n]\n"
                       "[,unit=m][,media=d][,index=i]\n"
                       "[,snapshot=on|off][,cache=on|off]\n"
-                      "[,readonly=on|off][,copy-on-read=on|off]",
+                      "[,readonly=on|off][,copy-on-read=on|off]\n",
+                      "[rid=rid]",
         .help       = "add drive to PCI storage controller",
         .cmd        = hmp_drive_add,
     },
diff --git a/hw/proxy/monitor.c b/hw/proxy/monitor.c
index c4d0ff1213..e3f368aa94 100644
--- a/hw/proxy/monitor.c
+++ b/hw/proxy/monitor.c
@@ -40,6 +40,7 @@
 #include "qapi/qmp/qstring.h"
 #include "qapi/error.h"
 #include "io/proxy-link.h"
+#include "sysemu/sysemu.h"
 
 /*
  * TODO: Is there a callback where the allocated memory for QMP could be free'd
@@ -194,3 +195,37 @@ void qmp_rdevice_del(const char *id, Error **errp)
 
     qobject_unref(qdict);
 }
+
+void hmp_rdrive_add(Monitor *mon, const QDict *qdict)
+{
+    MachineState *ms = MACHINE(current_machine);
+    Error *local_err = NULL;
+    PCIProxyDev *pdev = NULL;
+    const char *id, *optstr;
+    QemuOpts *opts;
+    char *data;
+    int ret;
+
+    pdev = get_proxy_device((QDict *)qdict, "rid", &local_err);
+    if (local_err) {
+        monitor_printf(mon, "rdrive_add error: %s\n",
+                       error_get_pretty(local_err));
+        error_free(local_err);
+        return;
+    }
+
+    optstr = qdict_get_str(qdict, "opts");
+    opts = drive_def(optstr);
+
+    id = g_strdup(qemu_opts_id(opts));
+    data = g_strdup(optstr);
+
+    ret = send_monitor_msg(pdev, DRIVE_ADD, strlen(data), (uint8_t *)data);
+
+    if (!ret) {
+        (void)g_hash_table_insert(ms->remote_devs, (gpointer)g_strdup(id),
+                                  (gpointer)pdev);
+    }
+
+    g_free(data);
+}
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index 2ba3e614f0..e102bcc8f5 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -62,6 +62,7 @@ typedef struct ProxyLinkState ProxyLinkState;
  *                  from remote device
  * DEVICE_ADD       QMP/HMP command to hotplug device
  * DEVICE_DEL       QMP/HMP command to hot-unplug device
+ * DRIVE_ADD        HMP command to hotplug drive
  *
  */
 typedef enum {
@@ -76,6 +77,7 @@ typedef enum {
     DRIVE_OPTS,
     DEVICE_ADD,
     DEVICE_DEL,
+    DRIVE_ADD,
     PROXY_PING,
     MAX,
 } proc_cmd_t;
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 5f133cae83..be2c533b9a 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -138,6 +138,7 @@ extern unsigned int nb_prom_envs;
 
 /* generic hotplug */
 void hmp_drive_add(Monitor *mon, const QDict *qdict);
+void hmp_rdrive_add(Monitor *mon, const QDict *qdict);
 
 /* pcie aer error injection */
 void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict);
diff --git a/remote/machine.c b/remote/machine.c
index 5b03167dd5..3c9a53010e 100644
--- a/remote/machine.c
+++ b/remote/machine.c
@@ -74,6 +74,8 @@ static void remote_machine_init(Object *obj)
     MemoryRegion *system_memory, *system_io, *pci_memory;
     PCIHostState *pci_host;
     PCIDevice *pci_dev;
+    MachineState *ms;
+    MachineClass *mc;
 
     Error *error_abort = NULL;
 
@@ -116,6 +118,12 @@ static void remote_machine_init(Object *obj)
 
     pci_bus_irqs(pci_host->bus, remote_iohub_set_irq, remote_iohub_map_irq,
                  s->iohub, REMOTE_IOHUB_NB_PIRQS);
+
+    ms = MACHINE(s);
+
+    mc = MACHINE_GET_CLASS(ms);
+
+    mc->block_default_type = IF_IDE;
 }
 
 static const TypeInfo remote_machine = {
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 43134762bc..860b5e30f9 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -234,6 +234,29 @@ fail:
     PUT_REMOTE_WAIT(wait);
 }
 
+static void process_drive_add_msg(ProcMsg *msg)
+{
+    Error *local_err = NULL;
+    const char *optstr = (const char *)msg->data2;
+    int wait = msg->fds[0];
+    QemuOpts *opts;
+    MachineClass *mc;
+
+    opts = drive_def(optstr);
+    assert(opts);
+
+    mc = MACHINE_GET_CLASS(current_machine);
+    (void)drive_new(opts, mc->block_default_type, &local_err);
+
+    if (local_err) {
+        error_report_err(local_err);
+    }
+
+    notify_proxy(wait, 1);
+
+    PUT_REMOTE_WAIT(wait);
+}
+
 static int init_drive(QDict *rqdict, Error **errp)
 {
     QemuOpts *opts;
@@ -433,6 +456,9 @@ static void process_msg(GIOCondition cond)
     case DEVICE_DEL:
         process_device_del_msg(msg);
         break;
+    case DRIVE_ADD:
+        process_drive_add_msg(msg);
+        break;
     case PROXY_PING:
         wait = msg->fds[0];
         notify_proxy(wait, (uint32_t)getpid());
@@ -464,6 +490,11 @@ int main(int argc, char *argv[])
     bdrv_init_with_whitelist();
 
     qemu_add_opts(&qemu_device_opts);
+    qemu_add_opts(&qemu_drive_opts);
+    qemu_add_drive_opts(&qemu_legacy_drive_opts);
+    qemu_add_drive_opts(&qemu_common_drive_opts);
+    qemu_add_drive_opts(&qemu_drive_opts);
+    qemu_add_drive_opts(&bdrv_runtime_opts);
 
     if (qemu_init_main_loop(&err)) {
         error_report_err(err);
-- 
2.17.1


