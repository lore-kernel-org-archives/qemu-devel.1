Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C082C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:36:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB6D12084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rgkFdnnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6D12084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50996 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwUq-0006uE-9i
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58954)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwBW-0005eu-P4
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwBS-00025A-Jm
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57574)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcwBS-00022d-08
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI8ku8065840;
 Mon, 17 Jun 2019 18:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=scmLrVP4xYg0Tw9BE11vcEOCdPW9WepFgHJ0GpUVuMU=;
 b=rgkFdnnwvYbteX7UK6QxopcUysjNIZHBkg1sq3Y/HL7pNSQXHPJst+zmwRn58PuTgsFd
 qur8mTFdZh6M7QV6TBByKrB7u4bRRz5AuRZT/O11bGPDeAESz3bZH0xXDYFA1VfttiIR
 36JikwrCOXonR6j7wdhph6sVwolAcxnn/5rbY3WmTeXWlucqNpQugKicqzKpl554lwV5
 0IVLpe6oEjKKgYAJlrKHCA9UC09NA/JRC8v1YCryz31W2G8W0153B4pTExcWWhHPmBGZ
 Bgv3x4JmHKuN3oA//iGnldU3/japw4kPju0nCol8rwMukP+auU9cI7qewV5nGJDdhvFA yQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2t4rmp00pw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIGPUk181160;
 Mon, 17 Jun 2019 18:16:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2t5mgbgb5h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:41 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5HIGeYL025311;
 Mon, 17 Jun 2019 18:16:40 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 11:16:39 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:16:31 -0700
Message-Id: <20190617181631.30233-1-elena.ufimtseva@oracle.com>
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
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170162
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [RFC PATCH v2 24/35] multi-process: add qdev_proxy_add
 to create proxy devices
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
 konrad.wilk@oracle.com, ross.lagerwall@citrix.com, imammedo@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, marcandre.lureau@redhat.com,
 kanth.ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

This is handled while parsing the command line options.
The parsed options are being sent to remote process
as the messgaes containing JSON strings.

Changes in v2:
 - parse socket and command suboptions of drive/device commands;

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 include/hw/proxy/qemu-proxy.h |   7 ++
 include/monitor/qdev.h        |   5 +
 qdev-monitor.c                | 166 ++++++++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+)

diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index 4e949f778b..a4c6989248 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -85,6 +85,13 @@ typedef struct PCIProxyDevClass {
 
 int remote_spawn(PCIProxyDev *pdev, const char *command, Error **errp);
 
+typedef struct PCIProxyDevList {
+    QLIST_HEAD(, PCIProxyDev) devices;
+} proxy_dev_list_t;
+
+extern QemuMutex proxy_list_lock;
+extern proxy_dev_list_t proxy_dev_list;
+
 void proxy_default_bar_write(PCIProxyDev *dev, MemoryRegion *mr, hwaddr addr,
                              uint64_t val, unsigned size, bool memory);
 
diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
index c7642f7c2d..965c58d127 100644
--- a/include/monitor/qdev.h
+++ b/include/monitor/qdev.h
@@ -2,6 +2,7 @@
 #define MONITOR_QDEV_H
 
 #include "hw/qdev-core.h"
+#include "hw/proxy/qemu-proxy.h"
 
 /*** monitor commands ***/
 
@@ -12,8 +13,12 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp);
 
 void qmp_rdevice_add(QDict *qdict, QObject **ret_data, Error **errp);
 void qmp_rdevice_del(const char *id, Error **errp);
+DeviceState *qdev_remote_add(QemuOpts *opts, bool device, Error **errp);
+void qdev_proxy_fire(void);
 
 int qdev_device_help(QemuOpts *opts);
+DeviceState *qdev_proxy_add(const char *rid, const char *id, char *command,
+                            int rsocket, bool managed, Error **errp);
 DeviceState *qdev_device_add(QemuOpts *opts, Error **errp);
 void qdev_set_id(DeviceState *dev, const char *id);
 
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 744c807b0f..596d01f49a 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -35,6 +35,16 @@
 #include "sysemu/block-backend.h"
 #include "migration/misc.h"
 #include "hw/boards.h"
+#include "hw/proxy/qemu-proxy.h"
+#include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qstring.h"
+#include "sysemu/sysemu.h"
+#include "hw/proxy/proxy-lsi53c895a.h"
+#include "include/qemu/cutils.h"
+#include "include/qemu/log.h"
+#include "qapi/qmp/qlist.h"
+#include "hw/proxy/qemu-proxy.h"
+#include "io/proxy-link.h"
 
 /*
  * Aliases were a bad idea from the start.  Let's keep them
@@ -47,6 +57,8 @@ typedef struct QDevAlias
     uint32_t arch_mask;
 } QDevAlias;
 
+proxy_dev_list_t proxy_dev_list;
+QemuMutex proxy_list_lock;
 /* Please keep this table sorted by typename. */
 static const QDevAlias qdev_alias_table[] = {
     { "e1000", "e1000-82540em" },
@@ -562,6 +574,160 @@ void qdev_set_id(DeviceState *dev, const char *id)
     }
 }
 
+#if defined(CONFIG_MPQEMU)
+PCIProxyDev *get_proxy_object(const char *rid);
+PCIProxyDev *get_proxy_object(const char *rid)
+{
+    PCIProxyDev *entry;
+
+    qemu_mutex_lock(&proxy_list_lock);
+    QLIST_FOREACH(entry, &proxy_dev_list.devices, next) {
+        if (strncmp(entry->rid, rid, strlen(entry->rid)) == 0) {
+            qemu_mutex_unlock(&proxy_list_lock);
+            return entry;
+        }
+    }
+    qemu_mutex_unlock(&proxy_list_lock);
+    return NULL;
+
+}
+
+#define MAX_RID_LENGTH 10
+void qdev_proxy_fire(void)
+{
+    PCIProxyDev *entry;
+
+    QLIST_FOREACH(entry, &proxy_dev_list.devices, next) {
+        if (entry->proxy_ready) {
+            entry->proxy_ready(PCI_DEVICE(entry));
+        }
+    }
+}
+
+DeviceState *qdev_proxy_add(const char *rid, const char *id, char *command,
+                            int rsocket, bool managed, Error **errp)
+{
+    DeviceState *ds;
+    PCIProxyDev *pdev;
+    QemuOpts *proxy_opts;
+    const char *proxy_type;
+    Error *local_err = NULL;
+    QDict *qdict;
+    const char *str;
+
+    pdev = get_proxy_object(rid);
+    if (pdev) {
+        return DEVICE(pdev);
+    }
+
+    if (strlen(rid) > MAX_RID_LENGTH) {
+        error_setg(errp, "rid %s is too long.", rid);
+        return NULL;
+    }
+
+    proxy_opts = qemu_opts_create(&qemu_device_opts, NULL, 0,
+                                  errp);
+
+    /* TODO: remove hardcoded type and add approptiate type identification. */
+    proxy_type = TYPE_PROXY_LSI53C895A;
+
+    qemu_opts_set_id(proxy_opts, (char *)rid);
+    qemu_opt_set(proxy_opts, "driver", proxy_type, &local_err);
+
+    qdict = qemu_opts_to_qdict(proxy_opts, NULL);
+    str = qstring_get_str(qobject_to_json(QOBJECT(qdict)));
+
+    ds = qdev_device_add(proxy_opts, &local_err);
+    if (!ds) {
+        error_setg(errp, "Could not create proxy device"
+                      " with opts %s.", str);
+        qemu_opts_del(proxy_opts);
+        return NULL;
+    }
+    qdev_set_id(ds, qemu_opts_id(proxy_opts));
+
+    pdev = PCI_PROXY_DEV(ds);
+    if (!pdev) {
+        error_setg(errp, "qdev_device_add failed.");
+        qemu_opts_del(proxy_opts);
+        return NULL;
+    }
+    pdev->rid = g_strdup(rid);
+    pdev->rsocket = managed ? rsocket : -1;
+    pdev->managed = managed;
+    pdev->init_proxy(PCI_DEVICE(ds), command, errp);
+
+    qemu_mutex_lock(&proxy_list_lock);
+    QLIST_INSERT_HEAD(&proxy_dev_list.devices, pdev, next);
+    qemu_mutex_unlock(&proxy_list_lock);
+
+    qemu_opts_del(proxy_opts);
+    return ds;
+}
+
+DeviceState *qdev_remote_add(QemuOpts *opts, bool device, Error **errp)
+{
+    PCIProxyDev *pdev = NULL;
+    DeviceState *dev;
+    const char *rid, *rsocket = NULL, *command = NULL;
+    QDict *qdict_new;
+
+    if (!proxy_list_lock.initialized) {
+        QLIST_INIT(&proxy_dev_list.devices);
+        qemu_mutex_init(&proxy_list_lock);
+    }
+
+    rid = qemu_opt_get(opts, "rid");
+    if (!rid) {
+        error_setg(errp, "rdevice option needs rid specified.");
+        return NULL;
+    }
+
+    rsocket = qemu_opt_get(opts, "socket");
+    if (rsocket) {
+        if (strlen(rsocket) > MAX_RID_LENGTH) {
+            error_setg(errp, "Socket number is incorrect.");
+            return NULL;
+        }
+    }
+
+    /*
+     * TODO: verify command with known commands and on remote end.
+     * How else can we verify the binary we launch without libvirtd support?
+     */
+    command = qemu_opt_get(opts, "command");
+    if (!rsocket && !command) {
+        error_setg(errp, "rdevice option needs socket or command specified.");
+        return NULL;
+    }
+    dev = qdev_proxy_add(rid, qemu_opt_get(opts, "id"), (char *)command,
+                         rsocket ? atoi(rsocket) : -1, rsocket ? true : false, errp);
+    if (!dev) {
+        error_setg(errp, "qdev_proxy_add error.");
+        return NULL;
+    }
+
+    qdict_new = qemu_opts_to_qdict(opts, NULL);
+
+    if (!qdict_new) {
+        error_setg(errp, "Could not parse rdevice options.");
+        return NULL;
+    }
+
+    pdev = PCI_PROXY_DEV(dev);
+    if (!pdev->set_remote_opts) {
+        /* TODO: destroy proxy? */
+        error_setg(errp, "set_remote_opts not set.");
+        return NULL;
+    } else {
+        pdev->set_remote_opts(PCI_DEVICE(pdev), qdict_new,
+                              device ? DEV_OPTS : DRIVE_OPTS);
+    }
+
+    return dev;
+}
+#endif /*defined(CONFIG_MPQEMU)*/
+
 DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
 {
     DeviceClass *dc;
-- 
2.17.1


