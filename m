Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B1DC2D0E3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E545206DC
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hufimOgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E545206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHkAq-0008KQ-Ky
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 04:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kHk9m-0006bp-El
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:48:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26042
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kHk9j-0005Ds-M1
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600073290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1u9NWIU9e+h4x1Ho41s0GHWSR48hakGDdp22Egnawiw=;
 b=hufimOgpFv+jGqv3ntE1ihdoUV0mTCqtm81Ylrtm3URU0w49KRAZYeXuoYAxbtK1LU9QK+
 pB4rTj7HJ6xgrFuuGsLPId3xYauxqKcmu4PkwkmN6e/dkTWQiMpSRBZM5CTosVz3odmZuc
 kKQFKKlfcIgNX71eMXG4vps5WqlcfyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-kiyrIyJtPCq0SUCrzEbJQQ-1; Mon, 14 Sep 2020 04:48:07 -0400
X-MC-Unique: kiyrIyJtPCq0SUCrzEbJQQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F223E5705D;
 Mon, 14 Sep 2020 08:48:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 997CC6886B;
 Mon, 14 Sep 2020 08:48:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 84078113275D; Mon, 14 Sep 2020 10:48:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 5/8] qapi: Implement deprecated-output=hide for QMP
 introspection
Date: Mon, 14 Sep 2020 10:47:59 +0200
Message-Id: <20200914084802.4185028-6-armbru@redhat.com>
In-Reply-To: <20200914084802.4185028-1-armbru@redhat.com>
References: <20200914084802.4185028-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:33:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 qapi/introspect.json                 |   2 +-
 monitor/monitor-internal.h           |   3 -
 monitor/misc.c                       |   2 -
 monitor/qmp-cmds-control.c           | 100 +++++++++++++++++++++++----
 storage-daemon/qemu-storage-daemon.c |   2 -
 5 files changed, 89 insertions(+), 20 deletions(-)

diff --git a/qapi/introspect.json b/qapi/introspect.json
index 944bb87a20..39bd303778 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -49,7 +49,7 @@
 ##
 { 'command': 'query-qmp-schema',
   'returns': [ 'SchemaInfo' ],
-  'gen': false }                # just to simplify qmp_query_json()
+  'allow-preconfig': true }
 
 ##
 # @SchemaMetaType:
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index b39e03b744..8833afaa65 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -180,7 +180,4 @@ void help_cmd(Monitor *mon, const char *name);
 void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
 int hmp_compare_cmd(const char *name, const char *list);
 
-void qmp_query_qmp_schema(QDict *qdict, QObject **ret_data,
-                                 Error **errp);
-
 #endif
diff --git a/monitor/misc.c b/monitor/misc.c
index e847b58a8c..3fd335e737 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -242,8 +242,6 @@ static void monitor_init_qmp_commands(void)
 
     qmp_init_marshal(&qmp_commands);
 
-    qmp_register_command(&qmp_commands, "query-qmp-schema",
-                         qmp_query_qmp_schema, QCO_ALLOW_PRECONFIG);
     qmp_register_command(&qmp_commands, "device_add", qmp_device_add,
                          QCO_NO_OPTIONS);
     qmp_register_command(&qmp_commands, "object-add", qmp_object_add,
diff --git a/monitor/qmp-cmds-control.c b/monitor/qmp-cmds-control.c
index 8f04cfa6e6..5b07c7e765 100644
--- a/monitor/qmp-cmds-control.c
+++ b/monitor/qmp-cmds-control.c
@@ -26,10 +26,14 @@
 
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
 
 /*
  * Accept QMP capabilities in @list for @mon.
@@ -153,17 +157,89 @@ EventInfoList *qmp_query_events(Error **errp)
     return ev_list;
 }
 
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
+static void *split_off_generic_list(void *list,
+                                    bool (*splitp)(void *elt),
+                                    void **part)
 {
-    *ret_data = qobject_from_qlit(&qmp_schema_qlit);
+    GenericList *keep = NULL, **keep_tailp = &keep;
+    GenericList *split = NULL, **split_tailp = &split;
+    GenericList *tail;
+
+    for (tail = list; tail; tail = tail->next) {
+        if (splitp(tail)) {
+            *split_tailp = tail;
+            split_tailp = &tail->next;
+        } else {
+            *keep_tailp = tail;
+            keep_tailp = &tail->next;
+        }
+    }
+
+    *keep_tailp = *split_tailp = NULL;
+    *part = split;
+    return keep;
+}
+
+static bool is_in(const char *s, strList *list)
+{
+    strList *tail;
+
+    for (tail = list; tail; tail = tail->next) {
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
+    schema = split_off_generic_list(schema, is_entity_deprecated, &to_zap);
+    qapi_free_SchemaInfoList(to_zap);
+
+    for (tail = schema; tail; tail = tail->next) {
+        ent = tail->value;
+        if (ent->meta_type == SCHEMA_META_TYPE_OBJECT) {
+            ent->u.object.members
+                = split_off_generic_list(ent->u.object.members,
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
+    QObject *obj = qobject_from_qlit(&qmp_schema_qlit);
+    Visitor *v = qobject_input_visitor_new(obj);
+    SchemaInfoList *schema = NULL;
+
+    /* test_visitor_in_qmp_introspect() ensures this can't fail */
+    visit_type_SchemaInfoList(v, NULL, &schema, &error_abort);
+    g_assert(schema);
+
+    qobject_unref(obj);
+    visit_free(v);
+
+    if (compat_policy.deprecated_output == COMPAT_POLICY_OUTPUT_HIDE) {
+        return zap_deprecated(schema);
+    }
+    return schema;
 }
diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
index 7e9b0e0d3f..9490099036 100644
--- a/storage-daemon/qemu-storage-daemon.c
+++ b/storage-daemon/qemu-storage-daemon.c
@@ -142,8 +142,6 @@ static QemuOptsList qemu_object_opts = {
 static void init_qmp_commands(void)
 {
     qmp_init_marshal(&qmp_commands);
-    qmp_register_command(&qmp_commands, "query-qmp-schema",
-                         qmp_query_qmp_schema, QCO_ALLOW_PRECONFIG);
 
     QTAILQ_INIT(&qmp_cap_negotiation_commands);
     qmp_register_command(&qmp_cap_negotiation_commands, "qmp_capabilities",
-- 
2.26.2


