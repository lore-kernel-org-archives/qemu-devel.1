Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACFAFA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 11:37:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00425205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 11:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00425205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKhch-0000W6-ST
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 07:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1iKhUA-00010h-LS
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 07:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1iKhU8-0005On-Qs
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 07:28:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:55310)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1iKhU8-0005O1-I3
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 07:28:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Oct 2019 04:28:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,303,1566889200"; d="scan'208";a="208393364"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by fmsmga001.fm.intel.com with ESMTP; 16 Oct 2019 04:28:48 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>
Subject: [RFC PATCH 1/4] net/awd.c: Introduce Advanced Watch Dog module
 framework
Date: Wed, 16 Oct 2019 19:22:06 +0800
Message-Id: <20191016112209.9024-2-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016112209.9024-1-chen.zhang@intel.com>
References: <20191016112209.9024-1-chen.zhang@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
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
Cc: Zhang Chen <chen.zhang@intel.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

This patch introduce a new module named Advanced Watch Dog,
and defined the input and output parameter. AWD use standard chardev
as the way of communicationg with the outside world.
Demo command:
-object advanced-watchdog,id=heart1,server=on,awd_node=h1,notification_node=heartbeat0,opt_script=opt_script_path,iothread=iothread1,pulse_interval=1000,timeout=5000

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 net/Makefile.objs |   1 +
 net/awd.c         | 261 ++++++++++++++++++++++++++++++++++++++++++++++
 qemu-options.hx   |   6 ++
 3 files changed, 268 insertions(+)
 create mode 100644 net/awd.c

diff --git a/net/Makefile.objs b/net/Makefile.objs
index c5d076d19c..139b1394e9 100644
--- a/net/Makefile.objs
+++ b/net/Makefile.objs
@@ -19,6 +19,7 @@ common-obj-y += colo-compare.o
 common-obj-y += colo.o
 common-obj-y += filter-rewriter.o
 common-obj-y += filter-replay.o
+common-obj-y += awd.o
 
 tap-obj-$(CONFIG_LINUX) = tap-linux.o
 tap-obj-$(CONFIG_BSD) = tap-bsd.o
diff --git a/net/awd.c b/net/awd.c
new file mode 100644
index 0000000000..d42b4a7372
--- /dev/null
+++ b/net/awd.c
@@ -0,0 +1,261 @@
+/*
+ * Advanced Watch Dog
+ *
+ * COarse-grain LOck-stepping Virtual Machines for Non-stop Service (COLO)
+ * (a.k.a. Fault Tolerance or Continuous Replication)
+ *
+ * Copyright (c) 2019 Intel Corporation
+ *
+ * Author: Zhang Chen <chen.zhang@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "trace.h"
+#include "qemu-common.h"
+#include "qapi/error.h"
+#include "net/net.h"
+#include "qom/object_interfaces.h"
+#include "qom/object.h"
+#include "chardev/char-fe.h"
+#include "qemu/sockets.h"
+#include "sysemu/iothread.h"
+
+#define TYPE_AWD  "advanced-watchdog"
+#define AWD(obj)  OBJECT_CHECK(AwdState, (obj), TYPE_AWD)
+
+#define AWD_READ_LEN_MAX NET_BUFSIZE
+/* Default advanced watchdog pulse interval */
+#define AWD_PULSE_INTERVAL_DEFAULT 5000
+/* Default advanced watchdog timeout */
+#define AWD_TIMEOUT_DEFAULT 2000
+
+typedef struct AwdState {
+    Object parent;
+
+    bool server;
+    char *awd_node;
+    char *notification_node;
+    char *opt_script;
+    uint32_t pulse_interval;
+    uint32_t timeout;
+    IOThread *iothread;
+} AwdState;
+
+typedef struct AwdClass {
+    ObjectClass parent_class;
+} AwdClass;
+
+static char *awd_get_node(Object *obj, Error **errp)
+{
+    AwdState *s = AWD(obj);
+
+    return g_strdup(s->awd_node);
+}
+
+static void awd_set_node(Object *obj, const char *value, Error **errp)
+{
+    AwdState *s = AWD(obj);
+
+    g_free(s->awd_node);
+    s->awd_node = g_strdup(value);
+}
+
+static char *noti_get_node(Object *obj, Error **errp)
+{
+    AwdState *s = AWD(obj);
+
+    return g_strdup(s->notification_node);
+}
+
+static void noti_set_node(Object *obj, const char *value, Error **errp)
+{
+    AwdState *s = AWD(obj);
+
+    g_free(s->notification_node);
+    s->notification_node = g_strdup(value);
+}
+
+static char *opt_script_get_node(Object *obj, Error **errp)
+{
+    AwdState *s = AWD(obj);
+
+    return g_strdup(s->opt_script);
+}
+
+static void opt_script_set_node(Object *obj, const char *value, Error **errp)
+{
+    AwdState *s = AWD(obj);
+
+    g_free(s->opt_script);
+    s->opt_script = g_strdup(value);
+}
+
+static bool awd_get_server(Object *obj, Error **errp)
+{
+    AwdState *s = AWD(obj);
+
+    return s->server;
+}
+
+static void awd_set_server(Object *obj, bool value, Error **errp)
+{
+    AwdState *s = AWD(obj);
+
+    s->server = value;
+}
+
+static void awd_get_interval(Object *obj, Visitor *v,
+                                   const char *name, void *opaque,
+                                   Error **errp)
+{
+    AwdState *s = AWD(obj);
+    uint32_t value = s->pulse_interval;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void awd_set_interval(Object *obj, Visitor *v,
+                                   const char *name, void *opaque,
+                                   Error **errp)
+{
+    AwdState *s = AWD(obj);
+    Error *local_err = NULL;
+    uint32_t value;
+
+    visit_type_uint32(v, name, &value, &local_err);
+    if (local_err) {
+        goto out;
+    }
+    if (!value) {
+        error_setg(&local_err, "Property '%s.%s' requires a positive value",
+                   object_get_typename(obj), name);
+        goto out;
+    }
+    s->pulse_interval = value;
+
+out:
+    error_propagate(errp, local_err);
+}
+
+static void awd_get_timeout(Object *obj, Visitor *v,
+                            const char *name, void *opaque,
+                            Error **errp)
+{
+    AwdState *s = AWD(obj);
+    uint32_t value = s->timeout;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void awd_set_timeout(Object *obj, Visitor *v,
+                            const char *name, void *opaque,
+                            Error **errp)
+{
+    AwdState *s = AWD(obj);
+    Error *local_err = NULL;
+    uint32_t value;
+
+    visit_type_uint32(v, name, &value, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
+    if (!value) {
+        error_setg(&local_err, "Property '%s.%s' requires a positive value",
+                   object_get_typename(obj), name);
+        goto out;
+    }
+    s->timeout = value;
+
+out:
+    error_propagate(errp, local_err);
+}
+
+static void awd_complete(UserCreatable *uc, Error **errp)
+{
+    AwdState *s = AWD(uc);
+
+    if (!s->awd_node || !s->iothread ||
+        !s->notification_node || !s->opt_script) {
+        error_setg(errp, "advanced-watchdog needs 'awd_node', "
+                   "'notification_node', 'opt_script' "
+                   "and 'server' property set");
+        return;
+    }
+
+    return;
+}
+
+static void awd_class_init(ObjectClass *oc, void *data)
+{
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
+
+    ucc->complete = awd_complete;
+}
+
+static void awd_init(Object *obj)
+{
+    AwdState *s = AWD(obj);
+
+    object_property_add_str(obj, "awd_node",
+                            awd_get_node, awd_set_node,
+                            NULL);
+
+    object_property_add_str(obj, "notification_node",
+                            noti_get_node, noti_set_node,
+                            NULL);
+
+    object_property_add_str(obj, "opt_script",
+                            opt_script_get_node, opt_script_set_node,
+                            NULL);
+
+    object_property_add_bool(obj, "server",
+                             awd_get_server,
+                             awd_set_server, NULL);
+
+    object_property_add(obj, "pulse_interval", "uint32",
+                        awd_get_interval,
+                        awd_set_interval, NULL, NULL, NULL);
+
+    object_property_add(obj, "timeout", "uint32",
+                        awd_get_timeout,
+                        awd_set_timeout, NULL, NULL, NULL);
+
+    object_property_add_link(obj, "iothread", TYPE_IOTHREAD,
+                            (Object **)&s->iothread,
+                            object_property_allow_set_link,
+                            OBJ_PROP_LINK_STRONG, NULL);
+}
+
+static void awd_finalize(Object *obj)
+{
+    AwdState *s = AWD(obj);
+
+    g_free(s->awd_node);
+    g_free(s->notification_node);
+}
+
+static const TypeInfo awd_info = {
+    .name = TYPE_AWD,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(AwdState),
+    .instance_init = awd_init,
+    .instance_finalize = awd_finalize,
+    .class_size = sizeof(AwdClass),
+    .class_init = awd_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+static void register_types(void)
+{
+    type_register_static(&awd_info);
+}
+
+type_init(register_types);
diff --git a/qemu-options.hx b/qemu-options.hx
index 793d70ff93..a4c1e2e2d1 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4520,6 +4520,12 @@ Dump the network traffic on netdev @var{dev} to the file specified by
 The file format is libpcap, so it can be analyzed with tools such as tcpdump
 or Wireshark.
 
+@item -object advanced-watchdog,id=@var{id},awd_node=@var{chardevid},notification_node=@var{chardevid},server=@var{server},iothread=@var{id}[,pulse_interval=@var{time_ms},timeout=@var{time_ms}]
+
+Advanced Watch Dog is an universal monitoring module on VMM side, it can be used to detect network down(VMM to guest, VMM to VMM, VMM to another remote server) and do previously set operation.
+for example: send message to admin, notify another VMM, send qmp command to qemu do some operation like restart the VM, build VMM heartbeat system, etc.
+It make user have basic VM/Host network monitoring tools and basic false tolerance and recovery solution.
+
 @item -object colo-compare,id=@var{id},primary_in=@var{chardevid},secondary_in=@var{chardevid},outdev=@var{chardevid},iothread=@var{id}[,vnet_hdr_support][,notify_dev=@var{id}]
 
 Colo-compare gets packet from primary_in@var{chardevid} and secondary_in@var{chardevid}, than compare primary packet with
-- 
2.17.1


