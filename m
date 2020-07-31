Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4BEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:27:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C9B22B42
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OXjljRQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C9B22B42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Zki-0002FS-T4
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 14:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1k1ZeO-0001mi-Tq
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:21:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36622)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1k1ZeM-0005OI-OO
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:21:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VIBlfC055633;
 Fri, 31 Jul 2020 18:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding;
 s=corp-2020-01-29; bh=E/wykNAjap6NAVOpdZR1KglNLHYNi/R2sWGbK2uAmBE=;
 b=OXjljRQgq+qiQc2/0nUIMJwhCf3ToIAgFwTmGsWCZOjoUL41dcGFw7LNhCNQjUxp4wJC
 PfoNntgc/F5Tp4LgshpHMBbKJxRdyjJ6A6I6x/JJN4qP3lIvb3jd4s6GOtWmv9/s49U3
 X7eTQIPXaBZfZZDmZtr8HkmxfteJzAC1J2kOTrgbT0EWqUO7aDwa4G5rN0XQRexNVQPd
 KjqyPFBStKz6ytT5fqbu5E03hYxm5uQv/OD8G9txsxSuBsU333DDNwgGE/n9tDzr+s4b
 ru8yYbFZE7pNtePgi3hvDxpPX13aE67QNK6pQNcln41sMZUwOVP/g7shfaOqfzPKFngs 6A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 32mf9g2tq8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 Jul 2020 18:20:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VIHVgA074059;
 Fri, 31 Jul 2020 18:20:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 32hu606sc5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Jul 2020 18:20:51 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06VIKoUN020182;
 Fri, 31 Jul 2020 18:20:50 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 31 Jul 2020 11:20:49 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 09/20] multi-process: Associate fd of a PCIDevice with its
 object
Date: Fri, 31 Jul 2020 14:20:16 -0400
Message-Id: <c00243a3b4994e5f276e289f2b5f012bea275a9c.1596217462.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1596217462.git.jag.raman@oracle.com>
References: <cover.1596217462.git.jag.raman@oracle.com>
In-Reply-To: <cover.1596217462.git.jag.raman@oracle.com>
References: <cover.1596217462.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0
 suspectscore=3 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=3 clxscore=1015 mlxscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310136
Received-SPF: pass client-ip=141.146.126.78; envelope-from=jag.raman@oracle.com;
 helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 14:20:51
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 alex.williamson@redhat.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Associate the file descriptor for a PCIDevice in remote process with
DeviceState object.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 MAINTAINERS                  |   2 +
 hw/i386/Makefile.objs        |   1 +
 hw/i386/remote-obj.c         | 127 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/i386/remote-obj.h |  42 ++++++++++++++
 4 files changed, 172 insertions(+)
 create mode 100644 hw/i386/remote-obj.c
 create mode 100644 include/hw/i386/remote-obj.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 40e0654..9fd278f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3047,6 +3047,8 @@ F: include/hw/i386/remote.h
 F: io/mpqemu-link.c
 F: include/io/mpqemu-link.h
 F: hw/i386/remote-msg.c
+F: include/hw/i386/remote-obj.h
+F: hw/i386/remote-obj.c
 
 Build and test automation
 -------------------------
diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 8396958..30d7102 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -16,6 +16,7 @@ obj-$(CONFIG_VMMOUSE) += vmmouse.o
 obj-$(CONFIG_PC) += port92.o
 obj-$(CONFIG_MPQEMU) += remote.o
 obj-$(CONFIG_MPQEMU) += remote-msg.o
+obj-$(CONFIG_MPQEMU) += remote-obj.o
 
 obj-y += kvmvapic.o
 obj-$(CONFIG_ACPI) += acpi-common.o
diff --git a/hw/i386/remote-obj.c b/hw/i386/remote-obj.c
new file mode 100644
index 0000000..4fc1d83
--- /dev/null
+++ b/hw/i386/remote-obj.c
@@ -0,0 +1,127 @@
+/*
+ * Copyright © 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL-v2, version 2 or later.
+ *
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+#include "hw/i386/remote-obj.h"
+#include "qemu/error-report.h"
+#include "qom/object_interfaces.h"
+#include "hw/qdev-core.h"
+#include "io/channel.h"
+#include "hw/qdev-core.h"
+#include "hw/i386/remote.h"
+#include "io/channel-util.h"
+#include "qapi/error.h"
+#include "sysemu/sysemu.h"
+#include "hw/pci/pci.h"
+
+static void remote_object_set_fd(Object *obj, const char *str, Error **errp)
+{
+    RemoteObject *o = REMOTE_OBJECT(obj);
+
+    o->fd = atoi(str);
+}
+
+static void remote_object_set_devid(Object *obj, const char *str, Error **errp)
+{
+    RemoteObject *o = REMOTE_OBJECT(obj);
+
+    o->devid = g_strdup(str);
+}
+
+static void remote_object_machine_done(Notifier *notifier, void *data)
+{
+    RemoteObject *o = container_of(notifier, RemoteObject, machine_done);
+    DeviceState *dev = NULL;
+    QIOChannel *ioc = NULL;
+    Error *err = NULL;
+
+    dev = qdev_find_recursive(sysbus_get_default(), o->devid);
+    if (!dev || !object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        error_report("%s is not a PCI device", o->devid);
+        return;
+    }
+
+    ioc = qio_channel_new_fd(o->fd, &err);
+    if (!ioc) {
+        error_free(err);
+        error_report("Failed to allocate IO channel");
+        return;
+    }
+
+    qio_channel_add_watch(ioc, G_IO_IN | G_IO_HUP, mpqemu_process_msg,
+                          (void *)PCI_DEVICE(dev), NULL);
+}
+
+static void remote_object_init(Object *obj)
+{
+    RemoteObjectClass *k = REMOTE_OBJECT_GET_CLASS(obj);
+    RemoteObject *o = REMOTE_OBJECT(obj);
+
+    if (k->nr_devs >= k->max_devs) {
+        error_report("Reached maximum number of devices: %u", k->max_devs);
+        return;
+    }
+
+    o->ioc = NULL;
+    o->fd = -1;
+    o->devid = NULL;
+
+    k->nr_devs++;
+
+    object_property_add_str(obj, "fd", NULL, remote_object_set_fd);
+    object_property_set_description(obj, "fd",
+                                    "file descriptor for the object");
+    object_property_add_str(obj, "devid", NULL, remote_object_set_devid);
+    object_property_set_description(obj, "devid",
+                                    "id of device to associate");
+
+    o->machine_done.notify = remote_object_machine_done;
+    qemu_add_machine_init_done_notifier(&o->machine_done);
+}
+
+static void remote_object_finalize(Object *obj)
+{
+    RemoteObjectClass *k = REMOTE_OBJECT_GET_CLASS(obj);
+    RemoteObject *o = REMOTE_OBJECT(obj);
+
+    qio_channel_close(o->ioc, NULL);
+    k->nr_devs--;
+    g_free(o->devid);
+}
+
+static void remote_object_class_init(ObjectClass *klass, void *data)
+{
+    RemoteObjectClass *k = REMOTE_OBJECT_CLASS(klass);
+
+    k->max_devs = 1;
+    k->nr_devs = 0;
+}
+
+static const TypeInfo remote_object_info = {
+    .name = TYPE_REMOTE_OBJECT,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(RemoteObject),
+    .instance_init = remote_object_init,
+    .instance_finalize = remote_object_finalize,
+    .class_size = sizeof(RemoteObjectClass),
+    .class_init = remote_object_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+static void register_types(void)
+{
+    type_register_static(&remote_object_info);
+}
+
+type_init(register_types);
diff --git a/include/hw/i386/remote-obj.h b/include/hw/i386/remote-obj.h
new file mode 100644
index 0000000..8513c2b
--- /dev/null
+++ b/include/hw/i386/remote-obj.h
@@ -0,0 +1,42 @@
+/*
+ * Copyright © 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL-v2, version 2 or later.
+ *
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef REMOTE_OBJECT_H
+#define REMOTE_OBJECT_H
+
+#include "io/channel.h"
+#include "qemu/notify.h"
+
+#define TYPE_REMOTE_OBJECT "remote-object"
+#define REMOTE_OBJECT(obj) \
+    OBJECT_CHECK(RemoteObject, (obj), TYPE_REMOTE_OBJECT)
+#define REMOTE_OBJECT_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(RemoteObjectClass, (obj), TYPE_REMOTE_OBJECT)
+#define REMOTE_OBJECT_CLASS(klass) \
+    OBJECT_CLASS_CHECK(RemoteObjectClass, (klass), TYPE_REMOTE_OBJECT)
+
+typedef struct {
+    ObjectClass parent_class;
+
+    unsigned int nr_devs;
+    unsigned int max_devs;
+} RemoteObjectClass;
+
+typedef struct {
+    /* private */
+    Object parent;
+
+    Notifier machine_done;
+
+    int fd;
+    char *devid;
+    QIOChannel *ioc;
+} RemoteObject;
+
+#endif
-- 
1.8.3.1


