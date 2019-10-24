Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE046CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:24:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330A8205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hM4kCSpD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330A8205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZLn-0002Z7-FJ
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ8p-0006eE-Iy
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ8n-0004Gs-Nq
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:10:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45426)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZ8n-0004FI-EP
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:10:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94UAH116449;
 Thu, 24 Oct 2019 09:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=1Va1ADzHWzWfOMbelsFfjVosW32ccuuUc+geYkrKeOM=;
 b=hM4kCSpD0R2ieHtiYjNxHYzR4Y3dmrsTfQZP17qouXPpYnEHK8PsnTWzsCVZB6YsdKSs
 TmhZ43e7sOysTyFOsbpf3OP8/vhtpxB+zB1nF+SvhsixLoK5WFc4YrzwAgrith9aTUQ3
 qiz/T7aI3XfgwIEpjnjAlylPub7apeTG2Ayf8v+7LVAvN+hryel+JHwZEMONgmjCwBzt
 9sC7j2oWf+AAask/ywrylhGJyeYsggluh8nHkUPcN3lL5nU17iq5l/HnzkY8mMyB0cZ/
 Q6MH9E6AVQS+BDja75ht12fXw9vA78OosFVNKkzY9cO7h/v0iqBdHL0JHrN0AFeAdmLM Pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2vqswttdyq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:10:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O97iad170512;
 Thu, 24 Oct 2019 09:10:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2vtsk486kk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:10:39 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9O9AcGN009298;
 Thu, 24 Oct 2019 09:10:38 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:10:38 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 20/49] multi-process: add qdev_proxy_add to create
 proxy devices
Date: Thu, 24 Oct 2019 05:09:01 -0400
Message-Id: <36de8c87e14b6623fd1a570c0c34dd0667ba8aec.1571905346.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240089
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
 include/monitor/qdev.h        |  25 +++++
 qdev-monitor.c                | 254 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 288 insertions(+), 1 deletion(-)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 3b84055..fc1c731 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -337,7 +337,8 @@ static void init_proxy(PCIDevice *dev, char *command, bool need_spawn, Error **e
 
     if (!pdev->managed) {
         if (need_spawn) {
-            if (!remote_spawn(pdev, command, &local_error)) {
+            if (remote_spawn(pdev, command, &local_error)) {
+                fprintf(stderr, "remote spawn failed\n");
                 return;
             }
         }
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index 80aadf9..ac61a9b 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -99,6 +99,13 @@ typedef struct PCIProxyDevClass {
 
 int remote_spawn(PCIProxyDev *pdev, const char *command, Error **errp);
 
+typedef struct PCIProxyDevList {
+    QLIST_HEAD(, PCIProxyDev) devices;
+} proxy_dev_list_t;
+
+extern QemuMutex proxy_list_lock;
+extern proxy_dev_list_t proxy_dev_list;
+
 void proxy_default_bar_write(void *opaque, hwaddr addr, uint64_t val,
                              unsigned size);
 
diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
index eaa947d..0bc355a 100644
--- a/include/monitor/qdev.h
+++ b/include/monitor/qdev.h
@@ -1,13 +1,38 @@
 #ifndef MONITOR_QDEV_H
 #define MONITOR_QDEV_H
 
+#include "hw/proxy/qemu-proxy.h"
+
 /*** monitor commands ***/
 
 void hmp_info_qtree(Monitor *mon, const QDict *qdict);
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
index 148df9c..eeff43e 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -35,6 +35,17 @@
 #include "sysemu/block-backend.h"
 #include "sysemu/sysemu.h"
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
+#include "io/mpqemu-link.h"
 
 /*
  * Aliases were a bad idea from the start.  Let's keep them
@@ -47,6 +58,8 @@ typedef struct QDevAlias
     uint32_t arch_mask;
 } QDevAlias;
 
+proxy_dev_list_t proxy_dev_list;
+QemuMutex proxy_list_lock;
 /* Please keep this table sorted by typename. */
 static const QDevAlias qdev_alias_table[] = {
     { "e1000", "e1000-82540em" },
@@ -562,6 +575,247 @@ void qdev_set_id(DeviceState *dev, const char *id)
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


