Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1F1C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32B99208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3cdDLhHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B99208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51034 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwaj-0004l6-FP
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59266)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwC0-00061z-Vc
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:17:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwBz-0002RF-B7
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:17:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57840)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcwBx-0002Ly-76
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:17:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI8kF5065852;
 Mon, 17 Jun 2019 18:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=c/oRzO5GwQrsLOuRCTKoMevsHyRTNOaXCBnIeWLFI0M=;
 b=3cdDLhHRm/e/EtTmHSPcwpHbZoUKFGM0KFbpGm6bpTaagxhdehNe2onYGk3tY8P+IMK8
 2NvorOuP4GEWmixb0VWB73aCE6FFCpYQryAs75O+21O0JHh8qxA/foA6GWmh+vIYXV2Y
 /ga8VygTLnBv/M7ACAsn5ltY5+cJfClo87SHkAjCBlyE4dEOY6MPXtOgx7hv51Jftgzq
 qnhOSZQY4uDI4X3W805ZWLn8+YNoc/vxg68TOsHAW5RNNkhzn8y+2Zw6HCCBjtsGWDm4
 ROTG4+hXAkZn55qaC2cfUoF2MnL2sIlgVZVAYfrcklva/bq7r2mMT0NVjuanQStx7kv6 xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2t4rmp00rs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:17:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIH5NU055935;
 Mon, 17 Jun 2019 18:17:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2t5h5t9g4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:17:05 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5HIH0iq025530;
 Mon, 17 Jun 2019 18:17:00 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 11:17:00 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:16:57 -0700
Message-Id: <20190617181657.30598-1-elena.ufimtseva@oracle.com>
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
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [RFC PATCH v2 32/35] multi-process: Extend drive_del
 command to delete drive from remote process
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
 kwolf@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jagannathan Raman <jag.raman@oracle.com>

Extend drive_del HMP command to hot-unplug drive from a remote process.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 blockdev.c                |  9 +++++++++
 hw/proxy/monitor.c        | 26 ++++++++++++++++++++++++++
 include/io/proxy-link.h   |  2 ++
 include/sysemu/blockdev.h |  1 +
 remote/remote-main.c      | 18 ++++++++++++++++++
 stubs/monitor.c           |  5 +++++
 6 files changed, 61 insertions(+)

diff --git a/blockdev.c b/blockdev.c
index 79fbac8450..d554b1802f 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -61,6 +61,7 @@
 #include "qemu/cutils.h"
 #include "qemu/help_option.h"
 #include "qemu/throttle-options.h"
+#include "hw/boards.h"
 
 static QTAILQ_HEAD(, BlockDriverState) monitor_bdrv_states =
     QTAILQ_HEAD_INITIALIZER(monitor_bdrv_states);
@@ -3044,12 +3045,20 @@ BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *node,
 
 void hmp_drive_del(Monitor *mon, const QDict *qdict)
 {
+    MachineState *ms = MACHINE(current_machine);
     const char *id = qdict_get_str(qdict, "id");
     BlockBackend *blk;
     BlockDriverState *bs;
     AioContext *aio_context;
     Error *local_err = NULL;
 
+#ifdef CONFIG_MPQEMU
+    if (g_hash_table_lookup(ms->remote_devs, id)) {
+        hmp_rdrive_del(mon, qdict);
+        return;
+    }
+#endif
+
     bs = bdrv_find_node(id);
     if (bs) {
         qmp_blockdev_del(id, &local_err);
diff --git a/hw/proxy/monitor.c b/hw/proxy/monitor.c
index e3f368aa94..e48b7f05d7 100644
--- a/hw/proxy/monitor.c
+++ b/hw/proxy/monitor.c
@@ -41,6 +41,7 @@
 #include "qapi/error.h"
 #include "io/proxy-link.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/blockdev.h"
 
 /*
  * TODO: Is there a callback where the allocated memory for QMP could be free'd
@@ -229,3 +230,28 @@ void hmp_rdrive_add(Monitor *mon, const QDict *qdict)
 
     g_free(data);
 }
+
+void hmp_rdrive_del(Monitor *mon, const QDict *qdict)
+{
+    MachineState *ms = MACHINE(current_machine);
+    Error *local_err = NULL;
+    PCIProxyDev *pdev = NULL;
+    const char *id;
+    int ret;
+
+    pdev = get_proxy_device((QDict *)qdict, "id", &local_err);
+    if (local_err) {
+        monitor_printf(mon, "rdrive_del error: %s\n",
+                       error_get_pretty(local_err));
+        error_free(local_err);
+        return;
+    }
+
+    id = qdict_get_str(qdict, "id");
+
+    ret = send_monitor_msg(pdev, DRIVE_DEL, strlen(id), (uint8_t *)id);
+
+    if (!ret) {
+        (void)g_hash_table_remove(ms->remote_devs, (gpointer)id);
+    }
+}
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index e102bcc8f5..bcec97d615 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -63,6 +63,7 @@ typedef struct ProxyLinkState ProxyLinkState;
  * DEVICE_ADD       QMP/HMP command to hotplug device
  * DEVICE_DEL       QMP/HMP command to hot-unplug device
  * DRIVE_ADD        HMP command to hotplug drive
+ * DRIVE_DEL        HMP command to hot-unplug drive
  *
  */
 typedef enum {
@@ -78,6 +79,7 @@ typedef enum {
     DEVICE_ADD,
     DEVICE_DEL,
     DRIVE_ADD,
+    DRIVE_DEL,
     PROXY_PING,
     MAX,
 } proc_cmd_t;
diff --git a/include/sysemu/blockdev.h b/include/sysemu/blockdev.h
index d34c4920dc..e6a9780025 100644
--- a/include/sysemu/blockdev.h
+++ b/include/sysemu/blockdev.h
@@ -61,4 +61,5 @@ DriveInfo *drive_new(QemuOpts *arg, BlockInterfaceType block_default_type,
 
 void hmp_commit(Monitor *mon, const QDict *qdict);
 void hmp_drive_del(Monitor *mon, const QDict *qdict);
+void hmp_rdrive_del(Monitor *mon, const QDict *qdict);
 #endif
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 860b5e30f9..4866322b7e 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -257,6 +257,21 @@ static void process_drive_add_msg(ProcMsg *msg)
     PUT_REMOTE_WAIT(wait);
 }
 
+static void process_drive_del_msg(ProcMsg *msg)
+{
+    const char *idstr = (const char *)msg->data2;
+    int wait = msg->fds[0];
+    QDict *qdict = qdict_new();
+
+    qdict_put_str(qdict, "id", idstr);
+
+    hmp_drive_del(NULL, qdict);
+
+    notify_proxy(wait, 1);
+
+    PUT_REMOTE_WAIT(wait);
+}
+
 static int init_drive(QDict *rqdict, Error **errp)
 {
     QemuOpts *opts;
@@ -459,6 +474,9 @@ static void process_msg(GIOCondition cond)
     case DRIVE_ADD:
         process_drive_add_msg(msg);
         break;
+    case DRIVE_DEL:
+        process_drive_del_msg(msg);
+        break;
     case PROXY_PING:
         wait = msg->fds[0];
         notify_proxy(wait, (uint32_t)getpid());
diff --git a/stubs/monitor.c b/stubs/monitor.c
index ac24eeb5d4..653c308934 100644
--- a/stubs/monitor.c
+++ b/stubs/monitor.c
@@ -6,6 +6,7 @@
 #include "qapi/qapi-types-misc.h"
 #include "qapi/qapi-commands-misc.h"
 #include "monitor/qdev.h"
+#include "sysemu/blockdev.h"
 
 __thread Monitor *cur_mon;
 
@@ -55,3 +56,7 @@ void qmp_rdevice_add(QDict *qdict, QObject **ret_data, Error **errp)
 void qmp_rdevice_del(const char *id, Error **errp)
 {
 }
+
+void hmp_rdrive_del(Monitor *mon, const QDict *qdict)
+{
+}
-- 
2.17.1


