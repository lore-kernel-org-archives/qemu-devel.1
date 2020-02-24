Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72677C38BE0
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC24920CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JJerVPRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC24920CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Kya-0001Rz-Ll
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:09:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6KmL-0006ga-QO
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6KmK-0003L3-6K
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:37 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41502)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6KmJ-0003J2-TZ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:36 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKr9j5017946;
 Mon, 24 Feb 2020 20:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=A9lFt0ytBreS5j3MbmLpvKry6kuysj3rARiDXYdNt3E=;
 b=JJerVPRalwDjWXHtN+GOPE1fJ/i1kt8MFpSxkSwPLgaCIbfw8l8V73z1cHHKDwtMf5gS
 v4V8xQEmG2L4r1l4tExqRkwe3RMaqFt7lKQTDsyjPv0WtBjlsNf1OlspG/TL2eYFm6uB
 EuA5jLI8o2Ke7bevuBFSRl276Lsuqb81ugRu29sACjxhY/vXSkGl7dG9qQonFHFW9wzp
 874CEhkou1sNKISZAXm+PyiQEl9T5iFqCKdWg6KQuFf5rfQUfFamSaYsmDzpdw5dGHlM
 /yeA5QTlVSCZZKQsx0guvEfKUJTnL+lalPBdsQISa3+rDrXoZpe109o8iDoB21SnMUIG wQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2yavxrhyfn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKptIp108399;
 Mon, 24 Feb 2020 20:56:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2ybe123tgx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:30 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OKuTYb028543;
 Mon, 24 Feb 2020 20:56:29 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:28 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 21/50] multi-process: remote: add setup_devices msg
 processing
Date: Mon, 24 Feb 2020 15:55:12 -0500
Message-Id: <9598678238bde438ebbb4087d92f779c940ab9a4.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 suspectscore=1 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=1 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
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

Receive by remote side the configuration messages and build the
device object from JSON device descriptions.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 include/hw/qdev-core.h |   2 +
 qdev-monitor.c         |   2 +-
 remote/remote-main.c   | 182 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 185 insertions(+), 1 deletion(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 1405b8a..64a4d58 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -392,6 +392,8 @@ BusState *qdev_get_parent_bus(DeviceState *dev);
 
 DeviceState *qdev_find_recursive(BusState *bus, const char *id);
 
+DeviceState *find_device_state(const char *id, Error **errp);
+
 /* Returns 0 to walk children, > 0 to skip walk, < 0 to terminate walk. */
 typedef int (qbus_walkerfn)(BusState *bus, void *opaque);
 typedef int (qdev_walkerfn)(DeviceState *dev, void *opaque);
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 60557ed..ccd2ce0 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -1055,7 +1055,7 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
     object_unref(OBJECT(dev));
 }
 
-static DeviceState *find_device_state(const char *id, Error **errp)
+DeviceState *find_device_state(const char *id, Error **errp)
 {
     Object *obj;
 
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 0f830b8..3a67cb9 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -36,6 +36,21 @@
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
@@ -143,6 +158,156 @@ static void process_get_pci_info_msg(PCIDevice *pci_dev, MPQemuMsg *msg)
     mpqemu_msg_send(&ret, mpqemu_link->com);
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
+static int setup_device(MPQemuMsg *msg, Error **errp)
+{
+    QObject *obj;
+    QDict *qdict;
+    QString *qstr;
+    QemuOpts *opts = NULL;
+    DeviceState *dev = NULL;
+    int wait = -1;
+    int rc = -EINVAL;
+    Error *local_error = NULL;
+
+    if (msg->num_fds == 1) {
+        wait = msg->fds[0];
+    } else {
+        error_setg(errp, "Numebr of FDs is incorrect");
+        return rc;
+    }
+
+    if (!msg->data2) {
+        return rc;
+    }
+
+    qstr = qstring_from_str((char *)msg->data2);
+    obj = qobject_from_json(qstring_get_str(qstr), &local_error);
+    if (!obj) {
+        error_setg(errp, "Could not get object!");
+        goto device_failed;
+    }
+
+    qdict = qobject_to(QDict, obj);
+    if (!qdict) {
+        error_setg(errp, "Could not get QDict");
+        goto device_failed;
+    }
+
+    g_assert(qdict_size(qdict) > 1);
+
+    opts = qemu_opts_from_qdict(&qemu_device_opts, qdict, &local_error);
+    qemu_opt_unset(opts, "rid");
+    qemu_opt_unset(opts, "socket");
+    qemu_opt_unset(opts, "remote");
+    qemu_opt_unset(opts, "command");
+    qemu_opt_unset(opts, "exec");
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
+        goto device_failed;
+    }
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        remote_pci_dev = PCI_DEVICE(dev);
+    }
+
+    notify_proxy(wait, (uint32_t)REMOTE_OK);
+    qemu_opts_del(opts);
+    return 0;
+
+ device_failed:
+    notify_proxy(wait, (uint32_t)REMOTE_FAIL);
+    qemu_opts_del(opts);
+    return rc;
+
+}
+
 static void process_msg(GIOCondition cond, MPQemuChannel *chan)
 {
     MPQemuMsg *msg = NULL;
@@ -190,11 +355,28 @@ static void process_msg(GIOCondition cond, MPQemuChannel *chan)
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


