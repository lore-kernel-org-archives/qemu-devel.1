Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDBFC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE1C72064A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AF6Mvbdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1C72064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51132 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwkF-0006Ni-7k
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59675)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwDo-0007YG-5b
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:19:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwDm-0003Np-7y
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:19:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58190)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcwDk-0003Ld-5T
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:19:10 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI9xG6159764;
 Mon, 17 Jun 2019 18:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=GVfZaEumk+tL1PxhWsdZuCbVi1wtcAWJo1xAyAk8fG8=;
 b=AF6MvbdkDxmj7pznfwLxoBmAiw1kY25w1qfOemn3oBqPEHxY/eDdtwL3qQVFl62jgpp/
 2Ek5c0hbSqGwpnj3aMnNatWfn14LMrWWPqLJf+cyNNKL0YLloVPGOSionGUUyCVWd8YK
 kQpR0vPak7A+7rp0zZSN/HY/2kQ6T3VlGVrET9zO9Eblh3DoN3Soow4FK0uXR+WMciux
 5Z26eo1i9m7jtVfcwA45eGFWku6XYWv9i2ia9nVlrI4mf17de2jvOOiILxrVFGKwid5E
 OENEnP7oiVkd/0aBWtJopNT6KlaaMU/JD473wn0ctmlcQWEYd97xRpa+rCIGidmo9pdm Wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2t4saq7yuq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:19:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIGPAE181089;
 Mon, 17 Jun 2019 18:17:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2t5mgbgbd3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:17:04 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5HIH3fC015304;
 Mon, 17 Jun 2019 18:17:03 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 11:17:03 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:17:00 -0700
Message-Id: <20190617181700.30700-1-elena.ufimtseva@oracle.com>
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
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [RFC PATCH v2 33/35] multi-process: Extend
 block_resize command to support remote block device
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
 konrad.wilk@oracle.com, armbru@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, liran.alon@oracle.com, berrange@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, kanth.ghatraju@oracle.com,
 kwolf@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jagannathan Raman <jag.raman@oracle.com>

Extend block_resize QMP/HMP commands to resize block devices on a remote
process.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 Changes in v2:
  - removed separate QMP/HMP command.
  - extended existing QMP command
  - refactor code to send messages to remote
---
 blockdev.c                | 15 +++++++++++++++
 hmp.c                     |  8 ++++++++
 hmp.h                     |  1 +
 hw/proxy/monitor.c        | 39 +++++++++++++++++++++++++++++++++++++++
 include/io/proxy-link.h   |  2 ++
 include/sysemu/blockdev.h |  4 ++++
 remote/remote-main.c      | 36 ++++++++++++++++++++++++++++++++++++
 stubs/monitor.c           |  5 +++++
 8 files changed, 110 insertions(+)

diff --git a/blockdev.c b/blockdev.c
index d554b1802f..6e1ad12a95 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3115,12 +3115,27 @@ void qmp_block_resize(bool has_device, const char *device,
                       bool has_node_name, const char *node_name,
                       int64_t size, Error **errp)
 {
+    MachineState *ms = MACHINE(current_machine);
     Error *local_err = NULL;
     BlockBackend *blk = NULL;
     BlockDriverState *bs;
     AioContext *aio_context;
     int ret;
 
+#ifdef CONFIG_MPQEMU
+    /*
+     * TODO: Assumes "device" for remote drive. Add support for
+     * "nodename" as well
+     */
+    if (has_device && g_hash_table_lookup(ms->remote_devs, device)) {
+        qmp_rblock_resize(device, device, size, errp);
+        if (local_err) {
+            error_propagate(errp, local_err);
+        }
+        return;
+    }
+#endif
+
     bs = bdrv_lookup_bs(has_device ? device : NULL,
                         has_node_name ? node_name : NULL,
                         &local_err);
diff --git a/hmp.c b/hmp.c
index 89cdaebfde..e56b3b1f96 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1339,10 +1339,18 @@ void hmp_balloon(Monitor *mon, const QDict *qdict)
 
 void hmp_block_resize(Monitor *mon, const QDict *qdict)
 {
+    MachineState *ms = MACHINE(current_machine);
     const char *device = qdict_get_str(qdict, "device");
     int64_t size = qdict_get_int(qdict, "size");
     Error *err = NULL;
 
+#ifdef CONFIG_MPQEMU
+    if (g_hash_table_lookup(ms->remote_devs, device)) {
+        hmp_rblock_resize(mon, qdict, &err);
+        return;
+    }
+#endif
+
     qmp_block_resize(true, device, false, NULL, size, &err);
     hmp_handle_error(mon, &err);
 }
diff --git a/hmp.h b/hmp.h
index 6919f99218..5f46783d25 100644
--- a/hmp.h
+++ b/hmp.h
@@ -151,5 +151,6 @@ void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
 void hmp_info_sev(Monitor *mon, const QDict *qdict);
 void hmp_info_remote(Monitor *mon, const QDict *qdict);
+void hmp_rblock_resize(Monitor *mon, const QDict *qdict, Error **errp);
 
 #endif
diff --git a/hw/proxy/monitor.c b/hw/proxy/monitor.c
index e48b7f05d7..90f66aec6a 100644
--- a/hw/proxy/monitor.c
+++ b/hw/proxy/monitor.c
@@ -255,3 +255,42 @@ void hmp_rdrive_del(Monitor *mon, const QDict *qdict)
         (void)g_hash_table_remove(ms->remote_devs, (gpointer)id);
     }
 }
+
+void qmp_rblock_resize(const char *id, const char *device, int64_t size,
+                       Error **errp)
+{
+    MachineState *ms = MACHINE(current_machine);
+    PCIProxyDev *pdev = NULL;
+    QString *json;
+    QDict *qdict;
+
+    pdev = (PCIProxyDev *)g_hash_table_lookup(ms->remote_devs, id);
+    if (!pdev) {
+        error_setg(errp, "No remote device named %s", device);
+        return;
+    }
+
+    qdict = qdict_new();
+    qdict_put_str(qdict, "device", device);
+    qdict_put_int(qdict, "size", size);
+
+    json = qobject_to_json(QOBJECT(qdict));
+
+    (void)send_monitor_msg(pdev, BLOCK_RESIZE, strlen(qstring_get_str(json)),
+                           (uint8_t *)qstring_get_str(json));
+}
+
+void hmp_rblock_resize(Monitor *mon, const QDict *qdict, Error **errp)
+{
+    Error *local_err = NULL;
+    const char *device;
+    int64_t size;
+
+    device = qdict_get_str(qdict, "device");
+    size = qdict_get_int(qdict, "size");
+
+    qmp_rblock_resize(device, device, size, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+    }
+}
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index bcec97d615..fea9fe5ae1 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -64,6 +64,7 @@ typedef struct ProxyLinkState ProxyLinkState;
  * DEVICE_DEL       QMP/HMP command to hot-unplug device
  * DRIVE_ADD        HMP command to hotplug drive
  * DRIVE_DEL        HMP command to hot-unplug drive
+ * BLOCK_RESIZE     QMP/HMP command to resize block backend
  *
  */
 typedef enum {
@@ -81,6 +82,7 @@ typedef enum {
     DRIVE_ADD,
     DRIVE_DEL,
     PROXY_PING,
+    BLOCK_RESIZE,
     MAX,
 } proc_cmd_t;
 
diff --git a/include/sysemu/blockdev.h b/include/sysemu/blockdev.h
index e6a9780025..975ecae54f 100644
--- a/include/sysemu/blockdev.h
+++ b/include/sysemu/blockdev.h
@@ -62,4 +62,8 @@ DriveInfo *drive_new(QemuOpts *arg, BlockInterfaceType block_default_type,
 void hmp_commit(Monitor *mon, const QDict *qdict);
 void hmp_drive_del(Monitor *mon, const QDict *qdict);
 void hmp_rdrive_del(Monitor *mon, const QDict *qdict);
+
+void qmp_rblock_resize(const char *id, const char *device, int64_t size,
+                       Error **errp);
+
 #endif
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 4866322b7e..fbaae8bf3a 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -64,6 +64,7 @@
 #include "qapi/qmp/qlist.h"
 #include "qemu/log.h"
 #include "qemu/cutils.h"
+#include "qapi/qapi-commands-block-core.h"
 
 static ProxyLinkState *proxy_link;
 PCIDevice *remote_pci_dev;
@@ -272,6 +273,38 @@ static void process_drive_del_msg(ProcMsg *msg)
     PUT_REMOTE_WAIT(wait);
 }
 
+static void process_block_resize_msg(ProcMsg *msg)
+{
+    const char *json = (const char *)msg->data2;
+    Error *local_err = NULL;
+    int wait = msg->fds[0];
+    const char *device;
+    int64_t size;
+    QObject *qobj = NULL;
+    QDict *qdict = NULL;
+
+    qobj = qobject_from_json(json, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return;
+    }
+
+    qdict = qobject_to(QDict, qobj);
+    assert(qdict);
+
+    device = qdict_get_str(qdict, "device");
+    size = qdict_get_int(qdict, "size");
+
+    qmp_block_resize(true, device, false, NULL, size, &local_err);
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
@@ -482,6 +515,9 @@ static void process_msg(GIOCondition cond)
         notify_proxy(wait, (uint32_t)getpid());
         PUT_REMOTE_WAIT(wait);
         break;
+    case BLOCK_RESIZE:
+        process_block_resize_msg(msg);
+        break;
     default:
         error_setg(&err, "Unknown command");
         goto finalize_loop;
diff --git a/stubs/monitor.c b/stubs/monitor.c
index 653c308934..79e008df41 100644
--- a/stubs/monitor.c
+++ b/stubs/monitor.c
@@ -60,3 +60,8 @@ void qmp_rdevice_del(const char *id, Error **errp)
 void hmp_rdrive_del(Monitor *mon, const QDict *qdict)
 {
 }
+
+void qmp_rblock_resize(const char *id, const char *device, int64_t size,
+                       Error **errp)
+{
+}
-- 
2.17.1


