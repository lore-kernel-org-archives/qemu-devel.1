Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90FAC10F00
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:25:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B69E320658
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3WvqRlr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69E320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGjJ-00038L-T8
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:25:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jAGZR-0004t3-UC
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jAGZP-0007oJ-7u
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57790
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jAGZN-0007X5-Ay
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583514925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dqnc346HqlnqHNEp+8nPvlZbj9jt6DxSpLKb2Jb7Bh8=;
 b=O3WvqRlreCK0h9EZZyYb4r2eQ2DnLAGqVm7wVuKzzAojfYJOOgfn5iSWAYo2/vzuFtYvLN
 /7x4rVQTQ7SpohVfj56BSeGWCvD2BjzAw7Xjs5l8tq5N/nZyJz0R6xCR67eXmdHKEMbzvQ
 FW52aUdz+lm8gLusxS3k36TV/fHlo98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-oeivGJmxOEGlSQPeaQKMeQ-1; Fri, 06 Mar 2020 12:15:23 -0500
X-MC-Unique: oeivGJmxOEGlSQPeaQKMeQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0C3913F8;
 Fri,  6 Mar 2020 17:15:22 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C78DE73892;
 Fri,  6 Mar 2020 17:15:21 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 13/29] qapi: Flatten object-add
Date: Fri,  6 Mar 2020 18:14:42 +0100
Message-Id: <20200306171458.1848-14-kwolf@redhat.com>
In-Reply-To: <20200306171458.1848-1-kwolf@redhat.com>
References: <20200306171458.1848-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mapping object-add to the command line as is doesn't result in nice
syntax because of the nesting introduced with 'props'. This becomes
nicer and more consistent with device_add and netdev_add when we accept
properties for the object on the top level instead.

'props' is still accepted after this patch, but marked as deprecated.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200224143008.13362-8-kwolf@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/qom.json                   | 12 +++++++---
 docs/system/deprecated.rst      |  5 ++++
 include/qom/object_interfaces.h |  7 ++++++
 hw/block/xen-block.c            | 11 ++++++++-
 monitor/misc.c                  |  2 ++
 qom/qom-qmp-cmds.c              | 42 +++++++++++++++++++++++++++------
 6 files changed, 68 insertions(+), 11 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index ecc60c4401..8abe998962 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -210,7 +210,12 @@
 #
 # @id: the name of the new object
 #
-# @props: a dictionary of properties to be passed to the backend
+# @props: a dictionary of properties to be passed to the backend. Deprecat=
ed
+#         since 5.0, specify the properties on the top level instead. It i=
s an
+#         error to specify the same option both on the top level and in @p=
rops.
+#
+# Additional arguments depend on qom-type and are passed to the backend
+# unchanged.
 #
 # Returns: Nothing on success
 #          Error if @qom-type is not a valid class name
@@ -221,12 +226,13 @@
 #
 # -> { "execute": "object-add",
 #      "arguments": { "qom-type": "rng-random", "id": "rng1",
-#                     "props": { "filename": "/dev/hwrng" } } }
+#                     "filename": "/dev/hwrng" } }
 # <- { "return": {} }
 #
 ##
 { 'command': 'object-add',
-  'data': {'qom-type': 'str', 'id': 'str', '*props': 'any'} }
+  'data': {'qom-type': 'str', 'id': 'str', '*props': 'any'},
+  'gen': false } # so we can get the additional arguments
=20
 ##
 # @object-del:
diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 1eaa559079..6c1d9034d9 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -190,6 +190,11 @@ Use ``migrate-set-parameters`` instead.
=20
 Use ``migrate-set-parameters`` and ``query-migrate-parameters`` instead.
=20
+``object-add`` option ``props`` (since 5.0)
+'''''''''''''''''''''''''''''''''''''''''''
+
+Specify the properties for the object as top-level arguments instead.
+
 ``query-block`` result field ``dirty-bitmaps[i].status`` (since 4.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
=20
diff --git a/include/qom/object_interfaces.h b/include/qom/object_interface=
s.h
index 3e4e1d928b..6f92f3cebb 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -162,4 +162,11 @@ void user_creatable_del(const char *id, Error **errp);
  */
 void user_creatable_cleanup(void);
=20
+/**
+ * qmp_object_add:
+ *
+ * QMP command handler for object-add. See the QAPI schema for documentati=
on.
+ */
+void qmp_object_add(QDict *qdict, QObject **ret_data, Error **errp);
+
 #endif
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 686bbc3f0d..3885464513 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -18,6 +18,7 @@
 #include "qapi/visitor.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
+#include "qom/object_interfaces.h"
 #include "hw/xen/xen_common.h"
 #include "hw/block/xen_blkif.h"
 #include "hw/qdev-properties.h"
@@ -858,10 +859,18 @@ static XenBlockIOThread *xen_block_iothread_create(co=
nst char *id,
 {
     XenBlockIOThread *iothread =3D g_new(XenBlockIOThread, 1);
     Error *local_err =3D NULL;
+    QDict *opts;
+    QObject *ret_data;
=20
     iothread->id =3D g_strdup(id);
=20
-    qmp_object_add(TYPE_IOTHREAD, id, false, NULL, &local_err);
+    opts =3D qdict_new();
+    qdict_put_str(opts, "qom-type", TYPE_IOTHREAD);
+    qdict_put_str(opts, "id", id);
+    qmp_object_add(opts, &ret_data, &local_err);
+    qobject_unref(opts);
+    qobject_unref(ret_data);
+
     if (local_err) {
         error_propagate(errp, local_err);
=20
diff --git a/monitor/misc.c b/monitor/misc.c
index 6c41293102..1748ab3911 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -248,6 +248,8 @@ static void monitor_init_qmp_commands(void)
                          QCO_NO_OPTIONS);
     qmp_register_command(&qmp_commands, "netdev_add", qmp_netdev_add,
                          QCO_NO_OPTIONS);
+    qmp_register_command(&qmp_commands, "object-add", qmp_object_add,
+                         QCO_NO_OPTIONS);
=20
     QTAILQ_INIT(&qmp_cap_negotiation_commands);
     qmp_register_command(&qmp_cap_negotiation_commands, "qmp_capabilities"=
,
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 6136efec16..49db926fcc 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -14,6 +14,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "block/qdict.h"
 #include "hw/qdev-core.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-qdev.h"
@@ -240,13 +241,34 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const=
 char *typename,
     return prop_list;
 }
=20
-void qmp_object_add(const char *type, const char *id,
-                    bool has_props, QObject *props, Error **errp)
+void qmp_object_add(QDict *qdict, QObject **ret_data, Error **errp)
 {
+    QObject *props;
     QDict *pdict;
     Visitor *v;
     Object *obj;
+    const char *type;
+    const char *id;
=20
+    type =3D qdict_get_try_str(qdict, "qom-type");
+    if (!type) {
+        error_setg(errp, QERR_MISSING_PARAMETER, "qom-type");
+        return;
+    } else {
+        type =3D g_strdup(type);
+        qdict_del(qdict, "qom-type");
+    }
+
+    id =3D qdict_get_try_str(qdict, "id");
+    if (!id) {
+        error_setg(errp, QERR_MISSING_PARAMETER, "id");
+        return;
+    } else {
+        id =3D g_strdup(id);
+        qdict_del(qdict, "id");
+    }
+
+    props =3D qdict_get(qdict, "props");
     if (props) {
         pdict =3D qobject_to(QDict, props);
         if (!pdict) {
@@ -254,17 +276,23 @@ void qmp_object_add(const char *type, const char *id,
             return;
         }
         qobject_ref(pdict);
-    } else {
-        pdict =3D qdict_new();
+        qdict_del(qdict, "props");
+        qdict_join(qdict, pdict, false);
+        if (qdict_size(pdict) !=3D 0) {
+            error_setg(errp, "Option in 'props' conflicts with top level")=
;
+            qobject_unref(pdict);
+            return;
+        }
+        qobject_unref(pdict);
     }
=20
-    v =3D qobject_input_visitor_new(QOBJECT(pdict));
-    obj =3D user_creatable_add_type(type, id, pdict, v, errp);
+    v =3D qobject_input_visitor_new(QOBJECT(qdict));
+    obj =3D user_creatable_add_type(type, id, qdict, v, errp);
     visit_free(v);
     if (obj) {
         object_unref(obj);
     }
-    qobject_unref(pdict);
+    *ret_data =3D QOBJECT(qdict_new());
 }
=20
 void qmp_object_del(const char *id, Error **errp)
--=20
2.20.1


