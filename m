Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73584C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EA5B2084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OiDUomOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA5B2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51048 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwcO-0006cA-Hc
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58963)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwBW-0005ew-Qe
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwBS-00025r-VB
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57416)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcwBS-0001xo-FL
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI8l7F065868;
 Mon, 17 Jun 2019 18:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=phtcguYrmxHbOtradT+KkWmWpDrxCK7VlmMbgNif274=;
 b=OiDUomOPm440S86UJZcWxiDTTpyojKWdXrdugWlvXRdE4eeno6jDFsVRToT3k5El82kg
 FdR/iWOe9xMshz8XeIOaigMAkmzNGkEpA8o55BJ8vTLDhl+PPyBpWWSRklZSYXphHGSk
 qJHtiGPX7S7pCE7y62fodM2lg+ojdFQD4/w6tbVVHZ+L5y+13cmmjJjJF4m74W+Bm4JJ
 7tYKG0o+jROcRa1zht0lUS0uVYssKaZ3GBl4riRlrYyOrEDxpfFsTqBTRxeN0KBArtwI
 vsdbnHek1v52sn/GRqLMDWLCMikKAns3O/rdEUgireIh3sBqrenSJYnsFKTLS2un5cEb /g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2t4rmp00p1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIF6Z2050383;
 Mon, 17 Jun 2019 18:16:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2t5h5t9fsd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:29 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5HIGSCw014992;
 Mon, 17 Jun 2019 18:16:28 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 11:16:28 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:16:26 -0700
Message-Id: <20190617181626.30141-1-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170162
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [RFC PATCH v2 22/35] multi-process: Extend monitor
 commands to remove device from remote process
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

Extend device_del QMP & HMP commands to hot-unplug device from remote
process.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 hmp.c                   |  9 +++++++++
 hw/proxy/monitor.c      | 15 ++++++++++++++
 include/hw/qdev-core.h  |  1 +
 include/io/proxy-link.h |  2 ++
 include/monitor/qdev.h  |  1 +
 qdev-monitor.c          | 15 ++++++++++++--
 remote/remote-main.c    | 45 +++++++++++++++++++++++++++++++++++++++++
 stubs/monitor.c         |  4 ++++
 8 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/hmp.c b/hmp.c
index ccc95d3feb..89cdaebfde 100644
--- a/hmp.c
+++ b/hmp.c
@@ -54,6 +54,7 @@
 #include "hw/rdma/rdma.h"
 #include "migration/snapshot.h"
 #include "migration/misc.h"
+#include "hw/boards.h"
 
 #ifdef CONFIG_SPICE
 #include <spice/enums.h>
@@ -2178,9 +2179,17 @@ void hmp_device_add(Monitor *mon, const QDict *qdict)
 
 void hmp_device_del(Monitor *mon, const QDict *qdict)
 {
+    MachineState *ms = MACHINE(current_machine);
     const char *id = qdict_get_str(qdict, "id");
     Error *err = NULL;
 
+#ifdef CONFIG_MPQEMU
+    if (g_hash_table_lookup(ms->remote_devs, id)) {
+        qmp_rdevice_del(id, &err);
+        return;
+    }
+#endif
+
     qmp_device_del(id, &err);
     hmp_handle_error(mon, &err);
 }
diff --git a/hw/proxy/monitor.c b/hw/proxy/monitor.c
index 400c83c0d5..c4d0ff1213 100644
--- a/hw/proxy/monitor.c
+++ b/hw/proxy/monitor.c
@@ -172,6 +172,8 @@ static void rdevice_add_del(QDict *qdict, proc_cmd_t cmd, Error **errp)
     if (cmd == DEVICE_ADD) {
         (void)g_hash_table_insert(ms->remote_devs, (gpointer)g_strdup(id),
                                   (gpointer)pdev);
+    } else {
+        (void)g_hash_table_remove(ms->remote_devs, (gpointer)id);
     }
 }
 
@@ -179,3 +181,16 @@ void qmp_rdevice_add(QDict *qdict, QObject **ret_data, Error **errp)
 {
     rdevice_add_del(qdict, DEVICE_ADD, errp);
 }
+
+void qmp_rdevice_del(const char *id, Error **errp)
+{
+    QDict *qdict = qdict_new();
+
+    qdict_put_str(qdict, "id", id);
+
+    qdict_put_str(qdict, "rid", id);
+
+    rdevice_add_del(qdict, DEVICE_DEL, errp);
+
+    qobject_unref(qdict);
+}
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 33ed3b8dde..cea42a92ab 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -358,6 +358,7 @@ BusState *qdev_get_parent_bus(DeviceState *dev);
 /*** BUS API. ***/
 
 DeviceState *qdev_find_recursive(BusState *bus, const char *id);
+DeviceState *find_device_state(const char *id, Error **errp);
 
 /* Returns 0 to walk children, > 0 to skip walk, < 0 to terminate walk. */
 typedef int (qbus_walkerfn)(BusState *bus, void *opaque);
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index 07a08a9175..bf2555c97e 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -61,6 +61,7 @@ typedef struct ProxyLinkState ProxyLinkState;
  * SET_IRQFD        Sets the IRQFD to be used to raise interrupts directly
  *                  from remote device
  * DEVICE_ADD       QMP/HMP command to hotplug device
+ * DEVICE_DEL       QMP/HMP command to hot-unplug device
  *
  */
 typedef enum {
@@ -72,6 +73,7 @@ typedef enum {
     BAR_READ,
     SET_IRQFD,
     DEVICE_ADD,
+    DEVICE_DEL,
     MAX,
 } proc_cmd_t;
 
diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
index e21692677e..c7642f7c2d 100644
--- a/include/monitor/qdev.h
+++ b/include/monitor/qdev.h
@@ -11,6 +11,7 @@ void hmp_info_qom_tree(Monitor *mon, const QDict *dict);
 void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp);
 
 void qmp_rdevice_add(QDict *qdict, QObject **ret_data, Error **errp);
+void qmp_rdevice_del(const char *id, Error **errp);
 
 int qdev_device_help(QemuOpts *opts);
 DeviceState *qdev_device_add(QemuOpts *opts, Error **errp);
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 80d570263f..744c807b0f 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -34,6 +34,7 @@
 #include "qemu/qemu-print.h"
 #include "sysemu/block-backend.h"
 #include "migration/misc.h"
+#include "hw/boards.h"
 
 /*
  * Aliases were a bad idea from the start.  Let's keep them
@@ -827,7 +828,7 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
     object_unref(OBJECT(dev));
 }
 
-static DeviceState *find_device_state(const char *id, Error **errp)
+DeviceState *find_device_state(const char *id, Error **errp)
 {
     Object *obj;
 
@@ -902,7 +903,17 @@ void qdev_unplug(DeviceState *dev, Error **errp)
 
 void qmp_device_del(const char *id, Error **errp)
 {
-    DeviceState *dev = find_device_state(id, errp);
+    MachineState *ms = MACHINE(current_machine);
+    DeviceState *dev;
+
+#ifdef CONFIG_MPQEMU
+    if (g_hash_table_lookup(ms->remote_devs, id)) {
+        qmp_rdevice_del(id, errp);
+        return;
+    }
+#endif
+
+    dev = find_device_state(id, errp);
     if (dev != NULL) {
         qdev_unplug(dev, errp);
     }
diff --git a/remote/remote-main.c b/remote/remote-main.c
index ba39ab6a46..c5dc7c0009 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -53,6 +53,7 @@
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "monitor/qdev.h"
+#include "qapi/qmp/qdict.h"
 
 static ProxyLinkState *proxy_link;
 PCIDevice *remote_pci_dev;
@@ -181,6 +182,47 @@ fail:
     PUT_REMOTE_WAIT(wait);
 }
 
+static void process_device_del_msg(ProcMsg *msg)
+{
+    Error *local_err = NULL;
+    DeviceState *dev = NULL;
+    const char *json = (const char *)msg->data2;
+    int wait = msg->fds[0];
+    QObject *qobj = NULL;
+    QDict *qdict = NULL;
+    const char *id;
+
+    qobj = qobject_from_json(json, &local_err);
+    if (local_err) {
+        goto fail;
+    }
+
+    qdict = qobject_to(QDict, qobj);
+    assert(qdict);
+
+    id = qdict_get_try_str(qdict, "id");
+    assert(id);
+
+    dev = find_device_state(id, &local_err);
+    if (local_err) {
+        goto fail;
+    }
+
+    if (dev) {
+        qdev_unplug(dev, &local_err);
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
@@ -235,6 +277,9 @@ static void process_msg(GIOCondition cond)
     case DEVICE_ADD:
         process_device_add_msg(msg);
         break;
+    case DEVICE_DEL:
+        process_device_del_msg(msg);
+        break;
     default:
         error_setg(&err, "Unknown command");
         goto finalize_loop;
diff --git a/stubs/monitor.c b/stubs/monitor.c
index a55b674777..ac24eeb5d4 100644
--- a/stubs/monitor.c
+++ b/stubs/monitor.c
@@ -51,3 +51,7 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
 void qmp_rdevice_add(QDict *qdict, QObject **ret_data, Error **errp)
 {
 }
+
+void qmp_rdevice_del(const char *id, Error **errp)
+{
+}
-- 
2.17.1


