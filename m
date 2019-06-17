Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780F9C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:41:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 336452084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vzY4ZPth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336452084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51024 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwZ3-00023g-D2
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58952)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwBW-0005et-Oz
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwBS-00024H-0o
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcwBR-0001vy-Lb
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI9xFx159764;
 Mon, 17 Jun 2019 18:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=kt9k8lGfADW3bbD0lOnFJDXER1tr+LSKD0g4331gr2E=;
 b=vzY4ZPthEeuszYkSBu4tXJa4fhrW0XQTZA3dtpiESumG5QPY6IHvgXLY8VdfSXJkrCe8
 ltgNSQcc0pukOh+DmafpmVYu45MDRiSEYcehSnOnA3w+JazvH+4AeG7urwr7HFQLV3Ho
 bQPJyj+oZXbxCKBydlCGNeIJQI5/j7mjYFYwMzlt9jgGI+RIVkVJsR6/sp6QrDOJsTJz
 5lqHv9ogBlBLGYyAuYnnxDo3wW33SDsFzLJqv4XQno3gW1TxPQ75p/wY+d1+Z59klfo2
 9UzGJTTI4dbskPtZJMQUJ0k2BHwVZLnvz5wXeLjjWOF67z38m0BRt/O2hPCfKsFLznMa qA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2t4saq7ygq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIGP9O181124;
 Mon, 17 Jun 2019 18:16:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2t5mgbgb0c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:26 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5HIGQFL014985;
 Mon, 17 Jun 2019 18:16:26 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 11:16:25 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:16:23 -0700
Message-Id: <20190617181623.30093-1-elena.ufimtseva@oracle.com>
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
Subject: [Qemu-devel] [RFC PATCH v2 21/35] multi-process: Extend monitor
 commands to add a device to remote process
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
 pbonzini@redhat.com, kanth.ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jagannathan Raman <jag.raman@oracle.com>

Extend device_add QMP & HMP commands to hotplug device to a remote process

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 hmp-commands.hx         |  4 +-
 hmp.c                   |  8 ++++
 hw/proxy/monitor.c      | 93 +++++++++++++++++++++++++++++++++++++++++
 include/io/proxy-link.h |  2 +
 include/monitor/qdev.h  |  2 +
 qdev-monitor.c          |  7 ++++
 remote/remote-main.c    | 48 +++++++++++++++++++++
 stubs/monitor.c         |  5 +++
 8 files changed, 167 insertions(+), 2 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 9b4035965c..605d18be85 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -712,8 +712,8 @@ ETEXI
 
     {
         .name       = "device_add",
-        .args_type  = "device:O",
-        .params     = "driver[,prop=value][,...]",
+        .args_type  = "device:O,rid:s?",
+        .params     = "driver[,prop=value][,...][rid=rid]",
         .help       = "add device, like -device on the command line",
         .cmd        = hmp_device_add,
         .command_completion = device_add_completion,
diff --git a/hmp.c b/hmp.c
index 4bb3af748e..ccc95d3feb 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2164,7 +2164,15 @@ void hmp_device_add(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
 
+#ifdef CONFIG_MPQEMU
+    if (qdict_get_try_str(qdict, "rid")) {
+        qmp_rdevice_add((QDict *)qdict, NULL, &err);
+        return;
+    }
+#endif
+
     qmp_device_add((QDict *)qdict, NULL, &err);
+
     hmp_handle_error(mon, &err);
 }
 
diff --git a/hw/proxy/monitor.c b/hw/proxy/monitor.c
index 694f34a446..400c83c0d5 100644
--- a/hw/proxy/monitor.c
+++ b/hw/proxy/monitor.c
@@ -23,6 +23,7 @@
  */
 
 #include <sys/types.h>
+#include <string.h>
 
 #include "qemu/osdep.h"
 #include "qapi/qapi-types-block-core.h"
@@ -32,6 +33,13 @@
 #include "hmp.h"
 #include "hw/boards.h"
 #include "hw/proxy/qemu-proxy.h"
+#include "qapi/qapi-commands-misc.h"
+#include "monitor/qdev.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qstring.h"
+#include "qapi/error.h"
+#include "io/proxy-link.h"
 
 /*
  * TODO: Is there a callback where the allocated memory for QMP could be free'd
@@ -86,3 +94,88 @@ void hmp_info_remote(Monitor *mon, const QDict *qdict)
                        pdev->remote_pid, pdev->rid, id, k->command);
     }
 }
+
+static PCIProxyDev *get_proxy_device(QDict *qdict, const char *opt,
+                                     Error **errp)
+{
+    MachineState *ms = MACHINE(current_machine);
+    PCIProxyDev *pdev = NULL;
+    const char *key;
+
+    key = qdict_get_try_str(qdict, opt);
+    if (!key) {
+        error_setg(errp, "Please specify %s option", opt);
+        return NULL;
+    }
+
+    pdev = (PCIProxyDev *)g_hash_table_lookup(ms->remote_devs, key);
+    if (!pdev) {
+        error_setg(errp,
+                   "No remote device by ID %s. Use query-remote command to get remote devices",
+                   key);
+    }
+
+    return pdev;
+}
+
+static int send_monitor_msg(PCIProxyDev *pdev, proc_cmd_t cmd, size_t size,
+                             uint8_t *data)
+{
+    ProcMsg msg = {0};
+    int wait;
+
+    wait = GET_REMOTE_WAIT;
+
+    msg.cmd = cmd;
+    msg.bytestream = 1;
+    msg.size = size;
+    msg.data2 = data;
+    msg.num_fds = 1;
+    msg.fds[0] = wait;
+
+    proxy_proc_send(pdev->proxy_link, &msg);
+    (void)wait_for_remote(wait);
+    PUT_REMOTE_WAIT(wait);
+
+    /* Indicate success/failure of remote operation */
+    return 0;
+}
+
+static void rdevice_add_del(QDict *qdict, proc_cmd_t cmd, Error **errp)
+{
+    MachineState *ms = MACHINE(current_machine);
+    PCIProxyDev *pdev = NULL;
+    const char *id;
+    QString *json;
+    int ret;
+
+    pdev = get_proxy_device(qdict, "rid", errp);
+    if (*errp) {
+        return;
+    }
+
+    qdict_del(qdict, "rid");
+
+    id = qdict_get_str(qdict, "id");
+
+    json = qobject_to_json(QOBJECT(qdict));
+
+    ret = send_monitor_msg(pdev, cmd, strlen(qstring_get_str(json)),
+                           (uint8_t *)qstring_get_str(json));
+
+    qstring_destroy_obj(QOBJECT(json));
+
+    if (ret) {
+        return;
+    }
+
+    if (cmd == DEVICE_ADD) {
+        (void)g_hash_table_insert(ms->remote_devs, (gpointer)g_strdup(id),
+                                  (gpointer)pdev);
+    }
+}
+
+void qmp_rdevice_add(QDict *qdict, QObject **ret_data, Error **errp)
+{
+    rdevice_add_del(qdict, DEVICE_ADD, errp);
+}
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index 843ac30e87..07a08a9175 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -60,6 +60,7 @@ typedef struct ProxyLinkState ProxyLinkState;
  * BAR_READ         Reads from PCI BAR region
  * SET_IRQFD        Sets the IRQFD to be used to raise interrupts directly
  *                  from remote device
+ * DEVICE_ADD       QMP/HMP command to hotplug device
  *
  */
 typedef enum {
@@ -70,6 +71,7 @@ typedef enum {
     BAR_WRITE,
     BAR_READ,
     SET_IRQFD,
+    DEVICE_ADD,
     MAX,
 } proc_cmd_t;
 
diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
index 0ff3331284..e21692677e 100644
--- a/include/monitor/qdev.h
+++ b/include/monitor/qdev.h
@@ -10,6 +10,8 @@ void hmp_info_qdm(Monitor *mon, const QDict *qdict);
 void hmp_info_qom_tree(Monitor *mon, const QDict *dict);
 void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp);
 
+void qmp_rdevice_add(QDict *qdict, QObject **ret_data, Error **errp);
+
 int qdev_device_help(QemuOpts *opts);
 DeviceState *qdev_device_add(QemuOpts *opts, Error **errp);
 void qdev_set_id(DeviceState *dev, const char *id);
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 373b9ad445..80d570263f 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -802,6 +802,13 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
     QemuOpts *opts;
     DeviceState *dev;
 
+#ifdef CONFIG_MPQEMU
+    if (qdict_get_try_str(qdict, "rid")) {
+        qmp_rdevice_add(qdict, NULL, errp);
+        return;
+    }
+#endif
+
     opts = qemu_opts_from_qdict(qemu_find_opts("device"), qdict, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/remote/remote-main.c b/remote/remote-main.c
index f4ded7afb4..ba39ab6a46 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -48,6 +48,11 @@
 #include "exec/memattrs.h"
 #include "exec/address-spaces.h"
 #include "remote/iohub.h"
+#include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qobject.h"
+#include "qemu/option.h"
+#include "qemu/config-file.h"
+#include "monitor/qdev.h"
 
 static ProxyLinkState *proxy_link;
 PCIDevice *remote_pci_dev;
@@ -138,6 +143,44 @@ fail:
     PUT_REMOTE_WAIT(wait);
 }
 
+static void process_device_add_msg(ProcMsg *msg)
+{
+    Error *local_err = NULL;
+    const char *json = (const char *)msg->data2;
+    int wait = msg->fds[0];
+    QObject *qobj = NULL;
+    QDict *qdict = NULL;
+    QemuOpts *opts = NULL;
+
+    qobj = qobject_from_json(json, &local_err);
+    if (local_err) {
+        goto fail;
+    }
+
+    qdict = qobject_to(QDict, qobj);
+    assert(qdict);
+
+    opts = qemu_opts_from_qdict(qemu_find_opts("device"), qdict, &local_err);
+    if (local_err) {
+        goto fail;
+    }
+
+    (void)qdev_device_add(opts, &local_err);
+    if (local_err) {
+        goto fail;
+    }
+
+fail:
+    if (local_err) {
+        error_report_err(local_err);
+        /* TODO: communicate the exact error message to proxy */
+    }
+
+    notify_proxy(wait, 1);
+
+    PUT_REMOTE_WAIT(wait);
+}
+
 static void process_msg(GIOCondition cond)
 {
     ProcMsg *msg = NULL;
@@ -189,6 +232,9 @@ static void process_msg(GIOCondition cond)
     case SET_IRQFD:
         process_set_irqfd_msg(remote_pci_dev, msg);
         break;
+    case DEVICE_ADD:
+        process_device_add_msg(msg);
+        break;
     default:
         error_setg(&err, "Unknown command");
         goto finalize_loop;
@@ -213,6 +259,8 @@ int main(int argc, char *argv[])
 
     bdrv_init_with_whitelist();
 
+    qemu_add_opts(&qemu_device_opts);
+
     if (qemu_init_main_loop(&err)) {
         error_report_err(err);
         return -EBUSY;
diff --git a/stubs/monitor.c b/stubs/monitor.c
index f3dc2750cb..a55b674777 100644
--- a/stubs/monitor.c
+++ b/stubs/monitor.c
@@ -5,6 +5,7 @@
 #include "monitor/monitor.h"
 #include "qapi/qapi-types-misc.h"
 #include "qapi/qapi-commands-misc.h"
+#include "monitor/qdev.h"
 
 __thread Monitor *cur_mon;
 
@@ -46,3 +47,7 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
 {
     return NULL;
 }
+
+void qmp_rdevice_add(QDict *qdict, QObject **ret_data, Error **errp)
+{
+}
-- 
2.17.1


