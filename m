Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95599CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:24:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BD2A205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qscR0CGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD2A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZME-00033H-Ty
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ8q-0006hX-U9
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ8p-0004Iq-7X
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:10:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60730)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZ8o-0004II-VM
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:10:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94NgN094929;
 Thu, 24 Oct 2019 09:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=iFiVcwKNR9jUbmKD8dfsLaSdKBy0NIJkJ5X8IrIg8Y4=;
 b=qscR0CGO61yiRoBMBf9aD83cxNFlOLB/mg7ifGzPj8oBWhmXPXoBtGpssONBGRIJ8MpE
 wTbNSnFlSfjxfiaWWfY2Rj2Sbi/B/7ZfepXYhU6lP0x76qAIUZ6e6VO7qW/dSAvcDTHy
 oxUj0cXbomo26CwOiopXdsVO/JWdKj9tWBUoT2SmZv7fjNsFbLMpmXDzCHxTcqYQMSIE
 /PlhG4zNTMNfAHIpEgdAVi5jFfg2PsJW41G1q+mZUeG3Du0CizCAIDBvCV18sEypCg2R
 ULFBgg5ibtEXWk8CLTwzNAi6RNCeumcvP0aUEeip7U2117u6Ehuf0aseFlZkekFPDwtj zQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2vqu4r24ny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:10:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O98mUY076167;
 Thu, 24 Oct 2019 09:10:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2vtjkj2xdt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:10:41 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9O9Aeo4002203;
 Thu, 24 Oct 2019 09:10:40 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:10:40 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 21/49] multi-process: remote: add setup_devices and
 setup_drive msg processing
Date: Thu, 24 Oct 2019 05:09:02 -0400
Message-Id: <3b01965059d7a258317081c2e9ebbd8d2feca872.1571905346.git.jag.raman@oracle.com>
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
X-Received-From: 156.151.31.85
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
index aa123f8..19b117d 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -357,6 +357,8 @@ BusState *qdev_get_parent_bus(DeviceState *dev);
 
 DeviceState *qdev_find_recursive(BusState *bus, const char *id);
 
+DeviceState *find_device_state(const char *id, Error **errp);
+
 /* Returns 0 to walk children, > 0 to skip walk, < 0 to terminate walk. */
 typedef int (qbus_walkerfn)(BusState *bus, void *opaque);
 typedef int (qdev_walkerfn)(DeviceState *dev, void *opaque);
diff --git a/qdev-monitor.c b/qdev-monitor.c
index eeff43e..e1d05e4 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -1025,7 +1025,7 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
     object_unref(OBJECT(dev));
 }
 
-static DeviceState *find_device_state(const char *id, Error **errp)
+DeviceState *find_device_state(const char *id, Error **errp)
 {
     Object *obj;
 
diff --git a/remote/remote-main.c b/remote/remote-main.c
index cede97c..5b3ffd8 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -49,6 +49,21 @@
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
 
 static MPQemuLinkState *mpqemu_link;
 PCIDevice *remote_pci_dev;
@@ -139,6 +154,200 @@ fail:
     PUT_REMOTE_WAIT(wait);
 }
 
+static void process_device_add_msg(MPQemuMsg *msg)
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
+static void process_device_del_msg(MPQemuMsg *msg)
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
+static int setup_drive(MPQemuMsg *msg, Error **errp)
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
+static int setup_device(MPQemuMsg *msg, Error **errp)
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
 static void process_msg(GIOCondition cond, MPQemuChannel *chan)
 {
     MPQemuMsg *msg = NULL;
@@ -184,11 +393,33 @@ static void process_msg(GIOCondition cond, MPQemuChannel *chan)
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


