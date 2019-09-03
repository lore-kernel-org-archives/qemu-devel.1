Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F30C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:00:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF78C2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ki0LXxxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF78C2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Fub-0002SP-UP
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5Fa3-0007f3-Ua
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5Fa1-0000Vz-8e
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36782)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5Fa0-0000Ue-QN
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KXeZs066077;
 Tue, 3 Sep 2019 20:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=Gz7N/piIslEYXG1oWtGqf1mRnr/vyekO1Re1YGs6iXU=;
 b=Ki0LXxxX5uvH/tP4uRYAmbYh0KiQd15uTFky8ZgOxGV+gkhP50/cxe22H0UEoBxPM23A
 +QiD7I7blCMO5xaBZg0NLRD+i5PKvr8mvCJDOA+aU0DXVY1oXjmBBmhPhEmBGCfPx9tq
 Om5IsyadSQB3zVTNC+z7DWmfhzHu0iSkelcXi0swaycuF5yF28YsEEe7MRUfQFHaK4xJ
 TPiW+VgBtKOsqaHrNKGaTMmMrGZlTraxZdH0O6143h8Qmpyar3QEsBeYePNxtj+zbrIP
 jHATPpTw1HlW/GbqQZJlUiWPJ2b7FsOW/CN/dT5Pss6Kty1N3GFr8aW7wfiTmLsRVMcm Tw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2usy4u831x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KcKs4188118;
 Tue, 3 Sep 2019 20:39:02 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2usu5118a3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:02 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x83Kd011028800;
 Tue, 3 Sep 2019 20:39:00 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:38:59 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:37:49 -0400
Message-Id: <1b3e4b481f9a66ca38ed94e574e7cf894cf982cc.1567534653.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030207
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030206
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [RFC v3 PATCH 23/45] multi-process: add qdev_proxy_add
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

This is handled while parsing the command line options.
The parsed options are being sent to remote process
as the messgaes containing JSON strings.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 v1 -> v2:
   - parse socket and command suboptions of drive/device commands

 hw/proxy/qemu-proxy.c         |   3 +-
 include/hw/proxy/qemu-proxy.h |   7 ++
 include/monitor/qdev.h        |  24 ++++
 qdev-monitor.c                | 254 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 287 insertions(+), 1 deletion(-)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index dea6784..61808c5 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -360,7 +360,8 @@ static void init_proxy(PCIDevice *dev, char *command, bool need_spawn, Error **e
 
     if (!pdev->managed) {
         if (need_spawn) {
-            if (!remote_spawn(pdev, command, &local_error)) {
+            if (remote_spawn(pdev, command, &local_error)) {
+                fprintf(stderr, "remote spawn failed\n");
                 return;
             }
         }
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index 4312f9e..fb408cf 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -86,6 +86,13 @@ typedef struct PCIProxyDevClass {
 
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
index 084799e..6b5020e 100644
--- a/include/monitor/qdev.h
+++ b/include/monitor/qdev.h
@@ -2,6 +2,7 @@
 #define MONITOR_QDEV_H
 
 #include "hw/qdev-core.h"
+#include "hw/proxy/qemu-proxy.h"
 
 /*** monitor commands ***/
 
@@ -9,7 +10,30 @@ void hmp_info_qtree(Monitor *mon, const QDict *qdict);
 void hmp_info_qdm(Monitor *mon, const QDict *qdict);
 void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp);
 
+DeviceState *qdev_remote_add(QemuOpts *opts, bool device, Error **errp);
+void qdev_proxy_fire(void);
+
 int qdev_device_help(QemuOpts *opts);
+DeviceState *qdev_proxy_add(const char *rid, const char *id, char *bus,
+                            char *command, int rsocket, bool managed,
+                            Error **errp);
+
+struct remote_process {
+    int rid;
+    int remote_pid;
+    unsigned int type;
+    int socket;
+    char *command;
+    QemuOpts *opts;
+
+    QLIST_ENTRY(remote_process) next;
+};
+
+void remote_process_register(struct remote_process *p);
+
+struct remote_process *get_remote_process_type(unsigned int type);
+struct remote_process *get_remote_process_rid(unsigned int rid);
+
 DeviceState *qdev_device_add(QemuOpts *opts, Error **errp);
 void qdev_set_id(DeviceState *dev, const char *id);
 
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 58222c2..d6f7572 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -34,6 +34,17 @@
 #include "qemu/qemu-print.h"
 #include "sysemu/block-backend.h"
 #include "migration/misc.h"
+#include "hw/boards.h"
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
@@ -46,6 +57,8 @@ typedef struct QDevAlias
     uint32_t arch_mask;
 } QDevAlias;
 
+proxy_dev_list_t proxy_dev_list;
+QemuMutex proxy_list_lock;
 /* Please keep this table sorted by typename. */
 static const QDevAlias qdev_alias_table[] = {
     { "e1000", "e1000-82540em" },
@@ -561,6 +574,247 @@ void qdev_set_id(DeviceState *dev, const char *id)
     }
 }
 
+static QLIST_HEAD(, remote_process) remote_processes;
+
+void remote_process_register(struct remote_process *p)
+{
+    QLIST_INSERT_HEAD(&remote_processes, p, next);
+}
+
+struct remote_process *get_remote_process_rid(unsigned int rid)
+{
+    struct remote_process *p;
+
+    QLIST_FOREACH(p, &remote_processes, next) {
+        if (rid == p->rid) {
+            return p;
+        }
+    }
+    return NULL;
+}
+
+struct remote_process *get_remote_process_type(unsigned int type)
+{
+    struct remote_process *p;
+
+    QLIST_FOREACH(p, &remote_processes, next) {
+        if (type == p->type) {
+            return p;
+        }
+    }
+    return NULL;
+}
+
+#if defined(CONFIG_MPQEMU)
+
+static PCIProxyDev *get_proxy_object_rid(const char *rid)
+{
+    PCIProxyDev *entry;
+    if (!proxy_list_lock.initialized) {
+        QLIST_INIT(&proxy_dev_list.devices);
+        qemu_mutex_init(&proxy_list_lock);
+    }
+
+    qemu_mutex_lock(&proxy_list_lock);
+    QLIST_FOREACH(entry, &proxy_dev_list.devices, next) {
+        if (strncmp(entry->rid, rid, strlen(entry->rid)) == 0) {
+            qemu_mutex_unlock(&proxy_list_lock);
+            return entry;
+        }
+    }
+    qemu_mutex_unlock(&proxy_list_lock);
+
+    return NULL;
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
+DeviceState *qdev_proxy_add(const char *rid, const char *id, char *bus,
+                            char *command, int rsocket, bool managed,
+                            Error **errp)
+{
+    DeviceState *ds;
+    PCIProxyDev *pdev, *old_pdev;
+    QemuOpts *proxy_opts;
+    const char *proxy_type;
+    Error *local_err = NULL;
+    QDict *qdict;
+    const char *str;
+    bool need_spawn = false;
+    bool remote_exists = false;
+
+    if (strlen(rid) > MAX_RID_LENGTH) {
+        error_setg(errp, "rid %s is too long.", rid);
+        return NULL;
+    }
+
+    old_pdev = get_proxy_object_rid(rid);
+    if (old_pdev) {
+        remote_exists = true;
+        if (old_pdev->dev_id) {
+            if (id) {
+                if (strncmp(id, old_pdev->dev_id,
+                            strlen(old_pdev->dev_id)) == 0) {
+                    return DEVICE(old_pdev);
+                }
+            } else {
+            /* check if device belongs to this proxy, use bus */
+                if (bus) {
+                    if (strncmp(bus, old_pdev->dev_id,
+                                strlen(old_pdev->dev_id)) == 0) {
+                        return DEVICE(old_pdev);
+                    }
+                }
+            }
+        }
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
+    if (old_pdev) {
+        pdev->rsocket = old_pdev->rsocket;
+        pdev->socket = old_pdev->socket;
+        pdev->remote_pid = old_pdev->remote_pid;
+    } else {
+        pdev->rsocket = managed ? rsocket : -1;
+        pdev->socket = managed ? rsocket : -1;
+
+    }
+    pdev->managed = managed;
+
+    /* With no libvirt, we will need to spawn. For now, every time. */
+    if (!remote_exists) {
+        need_spawn = true;
+    }
+
+    pdev->init_proxy(PCI_DEVICE(ds), command, need_spawn, errp);
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
+    const char *id = NULL;
+    const char *driver = NULL;
+    const char *bus = NULL;
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
+    if (device) {
+        driver = qemu_opt_get(opts, "driver");
+        /* TODO: properly identify the device class. */
+        if (strncmp(driver, "lsi", 3) == 0) {
+            id = qemu_opts_id(opts);
+            if (!id) {
+                error_setg(errp, "qdev_remote_add option needs id specified.");
+                return NULL;
+            }
+        }
+    }
+
+    rsocket = qemu_opt_get(opts, "socket");
+    if (rsocket) {
+        if (strlen(rsocket) > MAX_RID_LENGTH) {
+            error_setg(errp, "Socket number is incorrect.");
+            return NULL;
+        }
+    }
+    /*
+     * TODO: verify command with known commands and on remote end.
+     * How else can we verify the binary we launch without libvirtd support?
+     */
+    command = qemu_opt_get(opts, "command");
+    if (!rsocket && !command) {
+        error_setg(errp, "rdevice option needs socket or command specified.");
+        return NULL;
+    }
+
+    bus = qemu_opt_get(opts, "bus");
+    dev = qdev_proxy_add(rid, id, (char *)bus, (char *)command,
+                         rsocket ? atoi(rsocket) : -1,
+                         rsocket ? true : false, errp);
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
+        error_setg(errp, "set_remote_opts failed.");
+        return NULL;
+    } else {
+        if (id && !pdev->dev_id) {
+            pdev->dev_id = g_strdup(id);
+        }
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
1.8.3.1


