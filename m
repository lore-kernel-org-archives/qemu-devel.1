Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313B9C38BE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2CEC20CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="udsqpSyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CEC20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6L2M-0000X3-TQ
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:13:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6KmJ-0006bL-M5
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6KmH-0003HT-Py
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:35 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53210)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6KmH-0003FZ-Gh
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:33 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKtGND165554;
 Mon, 24 Feb 2020 20:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=KTUDkY6I7G6/v4ESCvEvNYLdRjtFDA47GR9+7WL+PKE=;
 b=udsqpSyNogf5VkVVb+HUQi/O0O845VFPZAmA9QxkxMAPjPYhEaanMdQaLijzwLJiQ9CM
 hXFpKaqUifjfStpPBKmA8odFdaNiDlMkHmdBk+th8yv+yX+5U78YXxWeYjlfuHXWBefh
 GVa0PjQN9Cox9X749q7PnnrisgYi6z63rFconJRASWmU79dEayhCeJBs3ZtLSa9LqG2P
 JZSSbBNLf/hylpJIW70kxHouxGy6FfxrJJtuh8YVAblYZ9/0alyfe7EzFlv8c+1xJcrF
 x1qkO+SoQLUbRMXkv4RJpqDWnKHw/yBvLia1p/3LCEpMqKLESPd46iIVt0VFgSLOWV6y 1w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2ybvr4p94w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKq7Wf088963;
 Mon, 24 Feb 2020 20:56:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2yby5dmbkw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:28 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OKuRkV028390;
 Mon, 24 Feb 2020 20:56:27 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:27 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 20/50] multi-process: add qdev_proxy_add to create proxy
 devices
Date: Mon, 24 Feb 2020 15:55:11 -0500
Message-Id: <4566f166ac78c6a55365386c3a9f19cd0aa3a258.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0
 suspectscore=1 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=1 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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

This is handled while parsing the command line options.
The parsed options are being sent to remote process
as the messgaes containing JSON strings.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 v4 -> v5:
  - Removed support for DRIVE_OPTS as it's managed by remote process
  - Addressed locking issues
  - Squashed fix to a previous patch

 include/hw/proxy/qemu-proxy.h |  10 +-
 include/monitor/qdev.h        |  25 +++++
 qdev-monitor.c                | 245 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 279 insertions(+), 1 deletion(-)

diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index cd8505a..7c6bddd 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -58,8 +58,9 @@ struct PCIProxyDev {
     int socket;
 
     char *rid;
-
+    char *dev_id;
     bool managed;
+    QLIST_ENTRY(PCIProxyDev) next;
 
     void (*set_proxy_sock) (PCIDevice *dev, int socket);
     int (*get_proxy_sock) (PCIDevice *dev);
@@ -80,6 +81,13 @@ typedef struct PCIProxyDevClass {
     char *command;
 } PCIProxyDevClass;
 
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
index eaa947d..d47a544 100644
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
 
+DeviceState *qdev_remote_add(QemuOpts *opts, Error **errp);
+void qdev_proxy_fire(void);
+
 int qdev_device_help(QemuOpts *opts);
+DeviceState *qdev_proxy_add(const char *rid, const char *id, char *bus,
+                            char *command, char *exec_name, int socket,
+                            bool managed, Error **errp);
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
index 8ce71a2..60557ed 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -38,6 +38,15 @@
 #include "migration/misc.h"
 #include "migration/migration.h"
 #include "qemu/cutils.h"
+#include "hw/boards.h"
+#include "hw/proxy/qemu-proxy.h"
+#include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qstring.h"
+#include "sysemu/sysemu.h"
+#include "include/qemu/log.h"
+#include "qapi/qmp/qlist.h"
+#include "hw/proxy/qemu-proxy.h"
+#include "io/mpqemu-link.h"
 
 /*
  * Aliases were a bad idea from the start.  Let's keep them
@@ -50,6 +59,8 @@ typedef struct QDevAlias
     uint32_t arch_mask;
 } QDevAlias;
 
+proxy_dev_list_t proxy_dev_list;
+
 /* Please keep this table sorted by typename. */
 static const QDevAlias qdev_alias_table[] = {
     { "e1000", "e1000-82540em" },
@@ -592,6 +603,240 @@ static bool should_hide_device(QemuOpts *opts)
     return true;
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
+
+    QLIST_FOREACH(entry, &proxy_dev_list.devices, next) {
+        if (strncmp(entry->rid, rid, strlen(entry->rid)) == 0) {
+            return entry;
+        }
+    }
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
+                            char *cmd, char *exec_name, int socket,
+                            bool managed, Error **errp)
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
+    proxy_type = TYPE_PCI_PROXY_DEV;
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
+        pdev->socket = old_pdev->socket;
+        pdev->remote_pid = old_pdev->remote_pid;
+    } else {
+        pdev->socket = managed ? socket : -1;
+
+    }
+    pdev->managed = managed;
+
+    /* With no libvirt, we will need to spawn. For now, every time. */
+    if (!remote_exists) {
+        need_spawn = true;
+    }
+
+    pdev->init_proxy(PCI_DEVICE(ds), cmd, exec_name, need_spawn, errp);
+
+    QLIST_INSERT_HEAD(&proxy_dev_list.devices, pdev, next);
+
+    qemu_opts_del(proxy_opts);
+    return ds;
+}
+
+DeviceState *qdev_remote_add(QemuOpts *opts, Error **errp)
+{
+    PCIProxyDev *pdev = NULL;
+    DeviceState *dev;
+    const char *rid, *socket = NULL, *command = NULL;
+    QDict *qdict_new;
+    const char *id = NULL;
+    const char *driver = NULL;
+    const char *bus = NULL;
+    const char *exec_name = NULL;
+
+    rid = qemu_opt_get(opts, "rid");
+    if (!rid) {
+        error_setg(errp, "rdevice option needs rid specified.");
+        return NULL;
+    }
+
+    driver = qemu_opt_get(opts, "driver");
+    /* TODO: properly identify the device class. */
+    if (strncmp(driver, "lsi", 3) == 0) {
+        id = qemu_opts_id(opts);
+        if (!id) {
+            error_setg(errp, "qdev_remote_add option needs id specified.");
+            return NULL;
+        }
+    }
+
+    socket = qemu_opt_get(opts, "socket");
+    if (socket) {
+        if (strlen(socket) > MAX_RID_LENGTH) {
+            error_setg(errp, "Socket number is incorrect.");
+            return NULL;
+        }
+    }
+    /*
+     * TODO: verify command with known commands and on remote end.
+     * How else can we verify the binary we launch without libvirtd support?
+     */
+    command = qemu_opt_get(opts, "command");
+    if (!socket && !command) {
+        error_setg(errp, "remote device needs socket or command specified.");
+        return NULL;
+    }
+
+    exec_name = qemu_opt_get(opts, "exec");
+    if (!exec_name && !socket) {
+        error_setg(errp, "exec name is not specified.");
+        return NULL;
+    }
+
+    bus = qemu_opt_get(opts, "bus");
+    dev = qdev_proxy_add(rid, id, (char *)bus, (char *)command,
+                         (char *)exec_name,
+                         socket ? atoi(socket) : -1,
+                         socket ? true : false, errp);
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
+        if (pdev->set_remote_opts(PCI_DEVICE(pdev), qdict_new,
+                                  DEV_OPTS)) {
+            error_setg(errp, "Remote process was unable to set options");
+            return NULL;
+        }
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


