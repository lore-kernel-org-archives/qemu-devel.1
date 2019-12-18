Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DCAC3F68F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 16:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40AC4227BF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 16:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hrk2k/SH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AC4227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihc7j-0005gl-FH
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 11:24:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihc3i-000060-Mu
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:20:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihc3g-0004Ss-Di
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:20:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22459
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihc3g-0004Ok-4I
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576686019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XC3DU+xE03xpzFSp+47bIvCQuItfIoSo7gEoBX5A53A=;
 b=Hrk2k/SHkFZSpHExORXMtfrvhjGu6yjkcoo+qcBkWjk7XXkQzgAJ60n9zZ2a2bnvFJdVuo
 C2zIL8+4TgPOl9VKSEIgdbHdedccxuXgNkRZ0UOyCWMlxb2QagDIdfiJDK3CjAsgdb8vlh
 i3ebZKWzk6K8Zpl04xt4OroqacIA5Uo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-93n6aiyqPKuq-UvQfxLaHg-1; Wed, 18 Dec 2019 11:20:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D69F718B5FC2;
 Wed, 18 Dec 2019 16:20:14 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-210.ams2.redhat.com
 [10.36.116.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB4021000322;
 Wed, 18 Dec 2019 16:20:13 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 3/4] monitor: Create monitor/qmp-cmds-monitor.c
Date: Wed, 18 Dec 2019 17:19:51 +0100
Message-Id: <20191218161952.10202-4-kwolf@redhat.com>
In-Reply-To: <20191218161952.10202-1-kwolf@redhat.com>
References: <20191218161952.10202-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 93n6aiyqPKuq-UvQfxLaHg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move all of the QMP commands handlers to implement the 'monitor' module
(qapi/monitor.json) that can be shared between the system emulator and
tools such as a storage daemon to a new file monitor/qmp-cmds-monitor.c.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 monitor/misc.c             | 110 --------------------------
 monitor/qmp-cmds-monitor.c | 153 +++++++++++++++++++++++++++++++++++++
 monitor/qmp-cmds.c         |  14 ----
 monitor/Makefile.objs      |   3 +-
 4 files changed, 155 insertions(+), 125 deletions(-)
 create mode 100644 monitor/qmp-cmds-monitor.c

diff --git a/monitor/misc.c b/monitor/misc.c
index 3baa15f3bf..c647ba6313 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -67,7 +67,6 @@
 #include "qemu/thread.h"
 #include "block/qapi.h"
 #include "qapi/qapi-commands.h"
-#include "qapi/qapi-emit-events.h"
 #include "qapi/error.h"
 #include "qapi/qmp-event.h"
 #include "qapi/qapi-introspect.h"
@@ -230,58 +229,6 @@ static void hmp_info_help(Monitor *mon, const QDict *q=
dict)
     help_cmd(mon, "info");
 }
=20
-static void query_commands_cb(QmpCommand *cmd, void *opaque)
-{
-    CommandInfoList *info, **list =3D opaque;
-
-    if (!cmd->enabled) {
-        return;
-    }
-
-    info =3D g_malloc0(sizeof(*info));
-    info->value =3D g_malloc0(sizeof(*info->value));
-    info->value->name =3D g_strdup(cmd->name);
-    info->next =3D *list;
-    *list =3D info;
-}
-
-CommandInfoList *qmp_query_commands(Error **errp)
-{
-    CommandInfoList *list =3D NULL;
-    MonitorQMP *mon;
-
-    assert(monitor_is_qmp(cur_mon));
-    mon =3D container_of(cur_mon, MonitorQMP, common);
-
-    qmp_for_each_command(mon->commands, query_commands_cb, &list);
-
-    return list;
-}
-
-EventInfoList *qmp_query_events(Error **errp)
-{
-    /*
-     * TODO This deprecated command is the only user of
-     * QAPIEvent_str() and QAPIEvent_lookup[].  When the command goes,
-     * they should go, too.
-     */
-    EventInfoList *info, *ev_list =3D NULL;
-    QAPIEvent e;
-
-    for (e =3D 0 ; e < QAPI_EVENT__MAX ; e++) {
-        const char *event_name =3D QAPIEvent_str(e);
-        assert(event_name !=3D NULL);
-        info =3D g_malloc0(sizeof(*info));
-        info->value =3D g_malloc0(sizeof(*info->value));
-        info->value->name =3D g_strdup(event_name);
-
-        info->next =3D ev_list;
-        ev_list =3D info;
-    }
-
-    return ev_list;
-}
-
 /*
  * Minor hack: generated marshalling suppressed for this command
  * ('gen': false in the schema) so we can parse the JSON string
@@ -320,63 +267,6 @@ static void monitor_init_qmp_commands(void)
                          qmp_marshal_qmp_capabilities, QCO_ALLOW_PRECONFIG=
);
 }
=20
-/*
- * Accept QMP capabilities in @list for @mon.
- * On success, set mon->qmp.capab[], and return true.
- * On error, set @errp, and return false.
- */
-static bool qmp_caps_accept(MonitorQMP *mon, QMPCapabilityList *list,
-                            Error **errp)
-{
-    GString *unavailable =3D NULL;
-    bool capab[QMP_CAPABILITY__MAX];
-
-    memset(capab, 0, sizeof(capab));
-
-    for (; list; list =3D list->next) {
-        if (!mon->capab_offered[list->value]) {
-            if (!unavailable) {
-                unavailable =3D g_string_new(QMPCapability_str(list->value=
));
-            } else {
-                g_string_append_printf(unavailable, ", %s",
-                                      QMPCapability_str(list->value));
-            }
-        }
-        capab[list->value] =3D true;
-    }
-
-    if (unavailable) {
-        error_setg(errp, "Capability %s not available", unavailable->str);
-        g_string_free(unavailable, true);
-        return false;
-    }
-
-    memcpy(mon->capab, capab, sizeof(capab));
-    return true;
-}
-
-void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
-                          Error **errp)
-{
-    MonitorQMP *mon;
-
-    assert(monitor_is_qmp(cur_mon));
-    mon =3D container_of(cur_mon, MonitorQMP, common);
-
-    if (mon->commands =3D=3D &qmp_commands) {
-        error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
-                  "Capabilities negotiation is already complete, command "
-                  "ignored");
-        return;
-    }
-
-    if (!qmp_caps_accept(mon, enable, errp)) {
-        return;
-    }
-
-    mon->commands =3D &qmp_commands;
-}
-
 /* Set the current CPU defined by the user. Callers must hold BQL. */
 int monitor_set_cpu(int cpu_index)
 {
diff --git a/monitor/qmp-cmds-monitor.c b/monitor/qmp-cmds-monitor.c
new file mode 100644
index 0000000000..acebfd3716
--- /dev/null
+++ b/monitor/qmp-cmds-monitor.c
@@ -0,0 +1,153 @@
+/*
+ * QMP commands related to the monitor (common functions for sysemu and to=
ols)
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+
+#include "monitor-internal.h"
+#include "qemu-version.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-monitor.h"
+#include "qapi/qapi-emit-events.h"
+
+/*
+ * Accept QMP capabilities in @list for @mon.
+ * On success, set mon->qmp.capab[], and return true.
+ * On error, set @errp, and return false.
+ */
+static bool qmp_caps_accept(MonitorQMP *mon, QMPCapabilityList *list,
+                            Error **errp)
+{
+    GString *unavailable =3D NULL;
+    bool capab[QMP_CAPABILITY__MAX];
+
+    memset(capab, 0, sizeof(capab));
+
+    for (; list; list =3D list->next) {
+        if (!mon->capab_offered[list->value]) {
+            if (!unavailable) {
+                unavailable =3D g_string_new(QMPCapability_str(list->value=
));
+            } else {
+                g_string_append_printf(unavailable, ", %s",
+                                      QMPCapability_str(list->value));
+            }
+        }
+        capab[list->value] =3D true;
+    }
+
+    if (unavailable) {
+        error_setg(errp, "Capability %s not available", unavailable->str);
+        g_string_free(unavailable, true);
+        return false;
+    }
+
+    memcpy(mon->capab, capab, sizeof(capab));
+    return true;
+}
+
+void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
+                          Error **errp)
+{
+    MonitorQMP *mon;
+
+    assert(monitor_is_qmp(cur_mon));
+    mon =3D container_of(cur_mon, MonitorQMP, common);
+
+    if (mon->commands =3D=3D &qmp_commands) {
+        error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
+                  "Capabilities negotiation is already complete, command "
+                  "ignored");
+        return;
+    }
+
+    if (!qmp_caps_accept(mon, enable, errp)) {
+        return;
+    }
+
+    mon->commands =3D &qmp_commands;
+}
+
+VersionInfo *qmp_query_version(Error **errp)
+{
+    VersionInfo *info =3D g_new0(VersionInfo, 1);
+
+    info->qemu =3D g_new0(VersionTriple, 1);
+    info->qemu->major =3D QEMU_VERSION_MAJOR;
+    info->qemu->minor =3D QEMU_VERSION_MINOR;
+    info->qemu->micro =3D QEMU_VERSION_MICRO;
+    info->package =3D g_strdup(QEMU_PKGVERSION);
+
+    return info;
+}
+
+static void query_commands_cb(QmpCommand *cmd, void *opaque)
+{
+    CommandInfoList *info, **list =3D opaque;
+
+    if (!cmd->enabled) {
+        return;
+    }
+
+    info =3D g_malloc0(sizeof(*info));
+    info->value =3D g_malloc0(sizeof(*info->value));
+    info->value->name =3D g_strdup(cmd->name);
+    info->next =3D *list;
+    *list =3D info;
+}
+
+CommandInfoList *qmp_query_commands(Error **errp)
+{
+    CommandInfoList *list =3D NULL;
+    MonitorQMP *mon;
+
+    assert(monitor_is_qmp(cur_mon));
+    mon =3D container_of(cur_mon, MonitorQMP, common);
+
+    qmp_for_each_command(mon->commands, query_commands_cb, &list);
+
+    return list;
+}
+
+EventInfoList *qmp_query_events(Error **errp)
+{
+    /*
+     * TODO This deprecated command is the only user of
+     * QAPIEvent_str() and QAPIEvent_lookup[].  When the command goes,
+     * they should go, too.
+     */
+    EventInfoList *info, *ev_list =3D NULL;
+    QAPIEvent e;
+
+    for (e =3D 0 ; e < QAPI_EVENT__MAX ; e++) {
+        const char *event_name =3D QAPIEvent_str(e);
+        assert(event_name !=3D NULL);
+        info =3D g_malloc0(sizeof(*info));
+        info->value =3D g_malloc0(sizeof(*info->value));
+        info->value->name =3D g_strdup(event_name);
+
+        info->next =3D ev_list;
+        ev_list =3D info;
+    }
+
+    return ev_list;
+}
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index b40a9b74de..22a3375194 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -15,7 +15,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "qemu-version.h"
 #include "qemu/cutils.h"
 #include "qemu/option.h"
 #include "monitor/monitor.h"
@@ -52,19 +51,6 @@ NameInfo *qmp_query_name(Error **errp)
     return info;
 }
=20
-VersionInfo *qmp_query_version(Error **errp)
-{
-    VersionInfo *info =3D g_new0(VersionInfo, 1);
-
-    info->qemu =3D g_new0(VersionTriple, 1);
-    info->qemu->major =3D QEMU_VERSION_MAJOR;
-    info->qemu->minor =3D QEMU_VERSION_MINOR;
-    info->qemu->micro =3D QEMU_VERSION_MICRO;
-    info->package =3D g_strdup(QEMU_PKGVERSION);
-
-    return info;
-}
-
 KvmInfo *qmp_query_kvm(Error **errp)
 {
     KvmInfo *info =3D g_malloc0(sizeof(*info));
diff --git a/monitor/Makefile.objs b/monitor/Makefile.objs
index e91a8581cd..15eb6380c5 100644
--- a/monitor/Makefile.objs
+++ b/monitor/Makefile.objs
@@ -1,3 +1,4 @@
 obj-y +=3D misc.o
 common-obj-y +=3D monitor.o qmp.o hmp.o
-common-obj-y +=3D qmp-cmds.o hmp-cmds.o
+common-obj-y +=3D qmp-cmds.o qmp-cmds-monitor.o
+common-obj-y +=3D hmp-cmds.o
--=20
2.20.1


