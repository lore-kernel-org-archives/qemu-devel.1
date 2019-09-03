Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF9BC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:58:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A9B2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NCXpOLPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A9B2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Fsf-0000Ze-MK
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 16:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5Fa4-0007fQ-6A
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5Fa2-0000X1-6W
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36802)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5Fa1-0000Vo-RQ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KXeGR066101;
 Tue, 3 Sep 2019 20:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=Q22KB8TATm5qt9z400d/WBN//xpURZqDM87m/OOmhks=;
 b=NCXpOLPxYeWEi9djZlaEpgfSf342GuP7MUzLODi1kWx4wl5qbext5HJLnqbRCkf2P0UQ
 esePhZOcw0LyxCc7B4g+JjLYZck2gWeNm7fg2DtY/HsCQGJabKqrxrFzEHZ3dS1gB9GQ
 RHGqH5W4XEWRv6oHvVyZq6q1J3nRT+ln8VAuRIr/eeRiNcGbx5uqPazzUAm/I30erbBG
 5HUvSzYE5onWZTIxrQv+isgRvuxX5h5aAGC/U2zNvKCHWDyCtKLFB/p+8IQTHB005CaI
 ujxDKk9sJXuWcdRpRucroU0Kg8q5tgVATotuCccPkzwm6s5wGWfsvYbo2cvCijYs7T9k Aw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2usy4u831y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KcAIb025408;
 Tue, 3 Sep 2019 20:39:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2us5pha0f5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:02 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83Kd1RP012515;
 Tue, 3 Sep 2019 20:39:01 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:39:01 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:37:50 -0400
Message-Id: <df6a748405162ef663cf7050661f407503177aed.1567534653.git.jag.raman@oracle.com>
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
Subject: [Qemu-devel] [RFC v3 PATCH 24/45] multi-process: remote: add
 setup_devices and setup_drive msg processing
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

Receive by remote side the configuration messages and build the device
object from JSON device descriptions.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 v1 -> v2:
   - for new command line suboptions with libvirtd support, clean
     the options before creating drives/devices
   - use default pci bus/address for now

 include/hw/qdev-core.h |   2 +
 qdev-monitor.c         |   2 +-
 remote/remote-main.c   | 231 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 234 insertions(+), 1 deletion(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 136df77..2f81894 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -360,6 +360,8 @@ BusState *qdev_get_parent_bus(DeviceState *dev);
 
 DeviceState *qdev_find_recursive(BusState *bus, const char *id);
 
+DeviceState *find_device_state(const char *id, Error **errp);
+
 /* Returns 0 to walk children, > 0 to skip walk, < 0 to terminate walk. */
 typedef int (qbus_walkerfn)(BusState *bus, void *opaque);
 typedef int (qdev_walkerfn)(DeviceState *dev, void *opaque);
diff --git a/qdev-monitor.c b/qdev-monitor.c
index d6f7572..69e467e 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -1017,7 +1017,7 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
     object_unref(OBJECT(dev));
 }
 
-static DeviceState *find_device_state(const char *id, Error **errp)
+DeviceState *find_device_state(const char *id, Error **errp)
 {
     Object *obj;
 
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 8af284e..3e92a83 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -48,6 +48,21 @@
 #include "exec/memattrs.h"
 #include "exec/address-spaces.h"
 #include "remote/iohub.h"
+#include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qobject.h"
+#include "qemu/option.h"
+#include "qemu/config-file.h"
+#include "monitor/qdev.h"
+#include "qapi/qmp/qdict.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/blockdev.h"
+#include "block/block.h"
+#include "qapi/qmp/qstring.h"
+#include "hw/qdev-properties.h"
+#include "hw/scsi/scsi.h"
+#include "block/qdict.h"
+#include "qapi/qmp/qlist.h"
+#include "qemu/log.h"
 
 static ProxyLinkState *proxy_link;
 PCIDevice *remote_pci_dev;
@@ -138,6 +153,200 @@ fail:
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
+static int init_drive(QDict *rqdict, Error **errp)
+{
+    QemuOpts *opts;
+    Error *local_error = NULL;
+
+    if (rqdict != NULL && qdict_size(rqdict) > 0) {
+        opts = qemu_opts_from_qdict(&qemu_drive_opts,
+                                    rqdict, &local_error);
+        if (!opts) {
+            error_propagate(errp, local_error);
+            return -EINVAL;
+        }
+    } else {
+        return -EINVAL;
+    }
+
+    qemu_opt_unset(opts, "rid");
+    qemu_opt_unset(opts, "socket");
+    qemu_opt_unset(opts, "remote");
+    qemu_opt_unset(opts, "command");
+
+    if (drive_new(opts, IF_IDE, &local_error) == NULL) {
+        error_propagate(errp, local_error);
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int setup_drive(ProcMsg *msg, Error **errp)
+{
+    QObject *obj;
+    QDict *qdict;
+    QString *qstr;
+    Error *local_error = NULL;
+    int rc = -EINVAL;
+
+    if (!msg->data2) {
+        return rc;
+    }
+
+    qstr = qstring_from_str((char *)msg->data2);
+    obj = qobject_from_json(qstring_get_str(qstr), &local_error);
+    if (!obj) {
+        error_propagate(errp, local_error);
+        return rc;
+    }
+
+    qdict = qobject_to(QDict, obj);
+    if (!qdict) {
+        return rc;
+    }
+
+    if (init_drive(qdict, &local_error)) {
+        error_setg(errp, "init_drive failed in setup_drive.");
+        return rc;
+    }
+
+    return 0;
+}
+
+static int setup_device(ProcMsg *msg, Error **errp)
+{
+    QObject *obj;
+    QDict *qdict;
+    QString *qstr;
+    QemuOpts *opts;
+    DeviceState *dev = NULL;
+    int rc = -EINVAL;
+    Error *local_error = NULL;
+
+    if (!msg->data2) {
+        return rc;
+    }
+
+    qstr = qstring_from_str((char *)msg->data2);
+    obj = qobject_from_json(qstring_get_str(qstr), &local_error);
+    if (!obj) {
+        error_setg(errp, "Could not get object!");
+        return rc;
+    }
+
+    qdict = qobject_to(QDict, obj);
+    if (!qdict) {
+        return rc;
+    }
+
+    g_assert(qdict_size(qdict) > 1);
+
+    opts = qemu_opts_from_qdict(&qemu_device_opts, qdict, &local_error);
+    qemu_opt_unset(opts, "rid");
+    qemu_opt_unset(opts, "socket");
+    qemu_opt_unset(opts, "remote");
+    qemu_opt_unset(opts, "command");
+    /*
+     * TODO: use the bus and addr from the device options. For now
+     * we use default value.
+     */
+    qemu_opt_unset(opts, "bus");
+    qemu_opt_unset(opts, "addr");
+
+    dev = qdev_device_add(opts, &local_error);
+    if (!dev) {
+        error_setg(errp, "Could not add device %s.",
+                   qstring_get_str(qobject_to_json(QOBJECT(qdict))));
+        return rc;
+    }
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        remote_pci_dev = PCI_DEVICE(dev);
+    }
+    qemu_opts_del(opts);
+
+    return 0;
+}
+
 static void process_msg(GIOCondition cond, ProcChannel *chan)
 {
     ProcMsg *msg = NULL;
@@ -183,11 +392,33 @@ static void process_msg(GIOCondition cond, ProcChannel *chan)
          */
         remote_sysmem_reconfig(msg, &err);
         if (err) {
+            error_report_err(err);
             goto finalize_loop;
         }
         break;
     case SET_IRQFD:
         process_set_irqfd_msg(remote_pci_dev, msg);
+        qdev_machine_creation_done();
+        qemu_mutex_lock_iothread();
+        qemu_run_machine_init_done_notifiers();
+        qemu_mutex_unlock_iothread();
+
+        break;
+    case DRIVE_OPTS:
+        if (setup_drive(msg, &err)) {
+            error_report_err(err);
+        }
+        break;
+    case DEV_OPTS:
+        if (setup_device(msg, &err)) {
+            error_report_err(err);
+        }
+        break;
+    case DEVICE_ADD:
+        process_device_add_msg(msg);
+        break;
+    case DEVICE_DEL:
+        process_device_del_msg(msg);
         break;
     default:
         error_setg(&err, "Unknown command");
-- 
1.8.3.1


