Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A52BC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9024208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q04EoOR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9024208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51106 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwhf-0001t5-7K
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59117)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwBc-0005kZ-SV
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwBb-0002CI-2P
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43586)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcwBa-00024R-L2
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI8v4E149300;
 Mon, 17 Jun 2019 18:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=3uLBtALvohcNLxi6toagSE1sKXSECqfCo0r/AsNw64g=;
 b=Q04EoOR5uOrcTqbaYJQdhaik68lMKyvD+wRIYPh1qrG3JbVH6/rQF1hAqS1tapqVcx31
 Lu2lvLB07cRBsm/jD0RJ6O+JrBrvYERBxiLmNpt1xKHrUL2/PX0a3AiH5d3GC2tr4tJl
 ov2L4X7jfw8SbJPF+batRwB/Z8qY7D1lSDOsxJGeNaOWWYtaUUQ8sYJMIPwp7DLEcOho
 PYZxAIBuVRADZlxNWv/jB2GVcB/syk1qOczHbuXc58cAMSJgHVt2w7wuRkiv5D/YH0u3
 fYzhwYzbPCAT6XCMj0pgPYcoZTCh3k1ZTbZ/WQ4CeY/Fc/mPVfEVj2euxIgSS8xhAZJh ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2t4r3tg308-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIGP9W181124;
 Mon, 17 Jun 2019 18:16:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2t5mgbgb6f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:44 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5HIGhwr025332;
 Mon, 17 Jun 2019 18:16:43 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 11:16:42 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:16:40 -0700
Message-Id: <20190617181640.30279-1-elena.ufimtseva@oracle.com>
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
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [RFC PATCH v2 25/35] multi-process: remote: add
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
Cc: elena.ufimtseva@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com,
 konrad.wilk@oracle.com, ross.lagerwall@citrix.com, liran.alon@oracle.com,
 stefanha@redhat.com, kanth.ghatraju@oracle.com
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
 Changes in v2:
  - for new command line suboptions with libvirtd support, clean
 the options before creating drives/devices.
 - use default pci bus/address for now.
---
 remote/remote-main.c | 140 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/remote/remote-main.c b/remote/remote-main.c
index c5dc7c0009..8db2f36b90 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -54,6 +54,15 @@
 #include "qemu/config-file.h"
 #include "monitor/qdev.h"
 #include "qapi/qmp/qdict.h"
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
@@ -223,6 +232,121 @@ fail:
     PUT_REMOTE_WAIT(wait);
 }
 
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
 static void process_msg(GIOCondition cond)
 {
     ProcMsg *msg = NULL;
@@ -268,11 +392,27 @@ static void process_msg(GIOCondition cond)
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
         break;
     case DEVICE_ADD:
         process_device_add_msg(msg);
-- 
2.17.1


