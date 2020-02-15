Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42A7C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 13:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB4F2067D
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 13:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPpDx62+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB4F2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2xAU-0003DX-OB
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 08:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2x8c-0000A4-2t
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 08:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2x8Z-0002h7-FA
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 08:05:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30185
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2x8Z-0002fv-06
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 08:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581771933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=41FcP4x2ytSyRf+bb3WRHdxlaC7aOONcpuzwqMnMcqs=;
 b=MPpDx62+tIyOhO6y8ubB9YkV5A+IjKsvAcIal+gJ+TjI0BbjZd43bfrorPgVo6MH2hvWsi
 WTud5Ocg74NurifUvuczqY7ksQ7L7DeWsH1Vuol2lluDva8YGNByFHCrt9MgLxCQEw+7L3
 VDrlZ8zPBhj8leeUaVIqiCdkDF4j43g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-1fY1lFJlMi6L3GEQ1dOWxQ-1; Sat, 15 Feb 2020 08:05:30 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EE6513E5
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 13:05:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 074C25D9C5;
 Sat, 15 Feb 2020 13:05:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6FA8311366C5; Sat, 15 Feb 2020 14:05:27 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] monitor: Collect "control" command handlers in
 qmp-cmds.control.c
Date: Sat, 15 Feb 2020 14:05:25 +0100
Message-Id: <20200215130527.28861-4-armbru@redhat.com>
In-Reply-To: <20200215130527.28861-1-armbru@redhat.com>
References: <20200215130527.28861-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 1fY1lFJlMi6L3GEQ1dOWxQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

Move all of the QMP commands handlers to implement the 'control' module
(qapi/control.json) that can be shared between the system emulator and
tools such as a storage daemon to a new file monitor/qmp-cmds-control.c.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200129102239.31435-4-kwolf@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor/misc.c             | 110 --------------------------
 monitor/qmp-cmds-control.c | 153 +++++++++++++++++++++++++++++++++++++
 monitor/qmp-cmds.c         |  14 ----
 monitor/Makefile.objs      |   3 +-
 4 files changed, 155 insertions(+), 125 deletions(-)
 create mode 100644 monitor/qmp-cmds-control.c

diff --git a/monitor/misc.c b/monitor/misc.c
index b4303d42d0..4c4e47fdc4 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -72,7 +72,6 @@
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-commands-qom.h"
 #include "qapi/qapi-commands-trace.h"
-#include "qapi/qapi-emit-events.h"
 #include "qapi/qapi-init-commands.h"
 #include "qapi/error.h"
 #include "qapi/qmp-event.h"
@@ -233,58 +232,6 @@ static void hmp_info_help(Monitor *mon, const QDict *q=
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
@@ -323,63 +270,6 @@ static void monitor_init_qmp_commands(void)
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
diff --git a/monitor/qmp-cmds-control.c b/monitor/qmp-cmds-control.c
new file mode 100644
index 0000000000..d5f21f90e6
--- /dev/null
+++ b/monitor/qmp-cmds-control.c
@@ -0,0 +1,153 @@
+/*
+ * QMP commands related to the monitor (common to sysemu and tools)
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
+#include "qapi/qapi-commands-control.h"
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
index a55d2dffc2..da7083087e 100644
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
index e91a8581cd..9244d90859 100644
--- a/monitor/Makefile.objs
+++ b/monitor/Makefile.objs
@@ -1,3 +1,4 @@
 obj-y +=3D misc.o
 common-obj-y +=3D monitor.o qmp.o hmp.o
-common-obj-y +=3D qmp-cmds.o hmp-cmds.o
+common-obj-y +=3D qmp-cmds.o qmp-cmds-control.o
+common-obj-y +=3D hmp-cmds.o
--=20
2.21.1


