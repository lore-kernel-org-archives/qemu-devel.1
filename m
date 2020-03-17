Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A1AC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:11:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F4D22073C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qb8hOBA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4D22073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEB3n-0001sf-Od
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56973)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEAod-0008Is-Q3
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEAoa-00070P-RK
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:24185)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEAoa-0006xf-Jp
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584446120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oYE3kivzTU/MHGBvZenoCiESySyZ9Mfy3dijo0V7Q1w=;
 b=Qb8hOBA07lV//6pswMhmbFduqq2tmm5sTcNJmHrunye3VAZ/S0WCspZjACqbaYtbgao8Vf
 jJEZi0rD8Z3vGI6zoNe2JI/IcA4aEDyH4B2+NKeI7qZCeOMsP7AA3XRIitINub6oMfvJZm
 rpJYifen8kWDQY6cRQ/2cgeW4Fik5dI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-vOStGJGVMlO1EPGFmkNMxw-1; Tue, 17 Mar 2020 07:55:16 -0400
X-MC-Unique: vOStGJGVMlO1EPGFmkNMxw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E54A19251AD;
 Tue, 17 Mar 2020 11:55:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BAE528981;
 Tue, 17 Mar 2020 11:55:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 93A26113525E; Tue, 17 Mar 2020 12:55:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 31/34] qapi: Implement deprecated-output=hide for QMP
 introspection
Date: Tue, 17 Mar 2020 12:54:56 +0100
Message-Id: <20200317115459.31821-32-armbru@redhat.com>
In-Reply-To: <20200317115459.31821-1-armbru@redhat.com>
References: <20200317115459.31821-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This policy suppresses deprecated bits in output, and thus permits
"testing the future".  Implement it for QMP command query-qmp-schema:
suppress information on deprecated commands, events and object type
members, i.e. anything that has the special feature flag "deprecated".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/introspect.json       |   2 +-
 monitor/monitor-internal.h |   3 --
 monitor/misc.c             |   2 -
 monitor/qmp-cmds-control.c | 102 ++++++++++++++++++++++++++++++++-----
 qemu-storage-daemon.c      |   2 -
 5 files changed, 90 insertions(+), 21 deletions(-)

diff --git a/qapi/introspect.json b/qapi/introspect.json
index b1aabd4cfd..3ebd817866 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -48,7 +48,7 @@
 ##
 { 'command': 'query-qmp-schema',
   'returns': [ 'SchemaInfo' ],
-  'gen': false }                # just to simplify qmp_query_json()
+  'allow-preconfig': true }
=20
 ##
 # @SchemaMetaType:
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 3e6baba88f..4d402ded85 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -180,7 +180,4 @@ void help_cmd(Monitor *mon, const char *name);
 void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
 int hmp_compare_cmd(const char *name, const char *list);
=20
-void qmp_query_qmp_schema(QDict *qdict, QObject **ret_data,
-                                 Error **errp);
-
 #endif
diff --git a/monitor/misc.c b/monitor/misc.c
index c3bc34c099..0237c71140 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -243,8 +243,6 @@ static void monitor_init_qmp_commands(void)
=20
     qmp_init_marshal(&qmp_commands);
=20
-    qmp_register_command(&qmp_commands, "query-qmp-schema",
-                         qmp_query_qmp_schema, QCO_ALLOW_PRECONFIG);
     qmp_register_command(&qmp_commands, "device_add", qmp_device_add,
                          QCO_NO_OPTIONS);
     qmp_register_command(&qmp_commands, "netdev_add", qmp_netdev_add,
diff --git a/monitor/qmp-cmds-control.c b/monitor/qmp-cmds-control.c
index 5cd9bb817c..bf5b711a7b 100644
--- a/monitor/qmp-cmds-control.c
+++ b/monitor/qmp-cmds-control.c
@@ -26,10 +26,14 @@
=20
 #include "monitor-internal.h"
 #include "qemu-version.h"
+#include "qapi/compat-policy.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-control.h"
+#include "qapi/qapi-commands-introspect.h"
 #include "qapi/qapi-emit-events.h"
 #include "qapi/qapi-introspect.h"
+#include "qapi/qapi-visit-introspect.h"
+#include "qapi/qobject-input-visitor.h"
=20
 /*
  * Accept QMP capabilities in @list for @mon.
@@ -153,17 +157,89 @@ EventInfoList *qmp_query_events(Error **errp)
     return ev_list;
 }
=20
-/*
- * Minor hack: generated marshalling suppressed for this command
- * ('gen': false in the schema) so we can parse the JSON string
- * directly into QObject instead of first parsing it with
- * visit_type_SchemaInfoList() into a SchemaInfoList, then marshal it
- * to QObject with generated output marshallers, every time.  Instead,
- * we do it in test-qobject-input-visitor.c, just to make sure
- * qapi-gen.py's output actually conforms to the schema.
- */
-void qmp_query_qmp_schema(QDict *qdict, QObject **ret_data,
-                                 Error **errp)
-{
-    *ret_data =3D qobject_from_qlit(&qmp_schema_qlit);
+static void *split_off_generic_list(void *list,
+                                    bool (*splitp)(void *elt),
+                                    void **part)
+{
+    GenericList *keep =3D NULL, **keep_tailp =3D &keep;
+    GenericList *split =3D NULL, **split_tailp =3D &split;
+    GenericList *tail;
+
+    for (tail =3D list; tail; tail =3D tail->next) {
+        if (splitp(tail)) {
+            *split_tailp =3D tail;
+            split_tailp =3D &tail->next;
+        } else {
+            *keep_tailp =3D tail;
+            keep_tailp =3D &tail->next;
+        }
+    }
+
+    *keep_tailp =3D *split_tailp =3D NULL;
+    *part =3D split;
+    return keep;
+}
+
+static bool is_in(const char *s, strList *list)
+{
+    strList *tail;
+
+    for (tail =3D list; tail; tail =3D tail->next) {
+        if (!strcmp(tail->value, s)) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static bool is_entity_deprecated(void *link)
+{
+    return is_in("deprecated", ((SchemaInfoList *)link)->value->features);
+}
+
+static bool is_member_deprecated(void *link)
+{
+    return is_in("deprecated",
+                 ((SchemaInfoObjectMemberList *)link)->value->features);
+}
+
+static SchemaInfoList *zap_deprecated(SchemaInfoList *schema)
+{
+    void *to_zap;
+    SchemaInfoList *tail;
+    SchemaInfo *ent;
+
+    schema =3D split_off_generic_list(schema, is_entity_deprecated, &to_za=
p);
+    qapi_free_SchemaInfoList(to_zap);
+
+    for (tail =3D schema; tail; tail =3D tail->next) {
+        ent =3D tail->value;
+        if (ent->meta_type =3D=3D SCHEMA_META_TYPE_OBJECT) {
+            ent->u.object.members
+                =3D split_off_generic_list(ent->u.object.members,
+                                         is_member_deprecated, &to_zap);
+            qapi_free_SchemaInfoObjectMemberList(to_zap);
+        }
+    }
+
+    return schema;
+}
+
+SchemaInfoList *qmp_query_qmp_schema(Error **errp)
+{
+    QObject *obj =3D qobject_from_qlit(&qmp_schema_qlit);
+    Visitor *v =3D qobject_input_visitor_new(obj);
+    SchemaInfoList *schema =3D NULL;
+
+    /* test_visitor_in_qmp_introspect() ensures this can't fail */
+    visit_type_SchemaInfoList(v, NULL, &schema, &error_abort);
+    g_assert(schema);
+
+    qobject_unref(obj);
+    visit_free(v);
+
+    if (compat_policy.deprecated_output =3D=3D COMPAT_POLICY_OUTPUT_HIDE) =
{
+        return zap_deprecated(schema);
+    }
+    return schema;
 }
diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
index dd128978cc..23433090a8 100644
--- a/qemu-storage-daemon.c
+++ b/qemu-storage-daemon.c
@@ -142,8 +142,6 @@ static QemuOptsList qemu_object_opts =3D {
 static void init_qmp_commands(void)
 {
     qmp_init_marshal(&qmp_commands);
-    qmp_register_command(&qmp_commands, "query-qmp-schema",
-                         qmp_query_qmp_schema, QCO_ALLOW_PRECONFIG);
=20
     QTAILQ_INIT(&qmp_cap_negotiation_commands);
     qmp_register_command(&qmp_cap_negotiation_commands, "qmp_capabilities"=
,
--=20
2.21.1


