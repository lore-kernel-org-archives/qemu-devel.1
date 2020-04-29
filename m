Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71C7C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:38:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04452073E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SW2iM6P3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04452073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThIm-0002FM-Oj
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh25-0007uC-EY
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh1i-0003yx-RH
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:21:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23700
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTh1h-0003vP-MQ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588144858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=stLAzBapgXwNnV94BzcEBwLvTMWzLIGo8fDX7N3683c=;
 b=SW2iM6P3VfQElpFm+v3z0PXPjr3IwzkgKCIFdc3ZeRTUfxPsEL8fgTYOSSWG9h3/J/+V48
 y6Lj+eBx71MSnAHiXQOiet/L7TbQNTMsNZ/nY+LtnYcmCQO7SrpimFaauNN4C/p4zDPSE6
 ZYgaZSVNKktzNPFP2f6/JlAy/NUXLMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-qiJ3GMpDMiuST-s1NrR-_A-1; Wed, 29 Apr 2020 03:20:56 -0400
X-MC-Unique: qiJ3GMpDMiuST-s1NrR-_A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5602D1895A33;
 Wed, 29 Apr 2020 07:20:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F05135D9F3;
 Wed, 29 Apr 2020 07:20:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8054111358DB; Wed, 29 Apr 2020 09:20:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 30/32] fuzz: Simplify how we compute available machines and
 types
Date: Wed, 29 Apr 2020 09:20:46 +0200
Message-Id: <20200429072048.29963-31-armbru@redhat.com>
In-Reply-To: <20200429072048.29963-1-armbru@redhat.com>
References: <20200429072048.29963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

apply_to_qlist(), apply_to_node() work with QObjects.  This is
designed for use by tests/qtest/qos-test.c, which gets the data in
that form via QMP.  Goes back to commit fc281c8020 "tests: qgraph API
for the qtest driver framework".

Commit 275ab39d86 "fuzz: add support for qos-assisted fuzz targets"
added another user: qtest/fuzz/qos_fuzz.c.  To get the data as
QObjects, it uses qmp_marshal_query_machines() and
qmp_marshal_qom_list_types().

All this code is rather cumbersome.  Switch to working with generated
QAPI types instead:

* Replace apply_to_qlist() & friends by machines_apply_to_node() and
  types_apply_to_node().

* Have qos_fuzz.c use qmp_query_machines() and qmp_qom_list_types()
  instead.

* Have qos_test.c convert from QObject to the QAPI types.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200424071142.3525-3-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/libqos/qos_external.h |  8 +++-
 tests/qtest/fuzz/qos_fuzz.c       | 34 ++++-----------
 tests/qtest/libqos/qos_external.c | 70 +++++++++++--------------------
 tests/qtest/qos-test.c            | 29 +++++++++----
 4 files changed, 59 insertions(+), 82 deletions(-)

diff --git a/tests/qtest/libqos/qos_external.h b/tests/qtest/libqos/qos_ext=
ernal.h
index 7b44930c55..f63388cb30 100644
--- a/tests/qtest/libqos/qos_external.h
+++ b/tests/qtest/libqos/qos_external.h
@@ -20,8 +20,12 @@
 #define QOS_EXTERNAL_H
 #include "libqos/qgraph.h"
=20
-void apply_to_node(const char *name, bool is_machine, bool is_abstract);
-void apply_to_qlist(QList *list, bool is_machine);
+#include "libqos/malloc.h"
+#include "qapi/qapi-types-machine.h"
+#include "qapi/qapi-types-qom.h"
+
+void machines_apply_to_node(MachineInfoList *mach_info);
+void types_apply_to_node(ObjectTypeInfoList *type_info);
 QGuestAllocator *get_machine_allocator(QOSGraphObject *obj);
 void *allocate_objects(QTestState *qts, char **path, QGuestAllocator **p_a=
lloc);
=20
diff --git a/tests/qtest/fuzz/qos_fuzz.c b/tests/qtest/fuzz/qos_fuzz.c
index af28c92866..87eadb0889 100644
--- a/tests/qtest/fuzz/qos_fuzz.c
+++ b/tests/qtest/fuzz/qos_fuzz.c
@@ -36,7 +36,6 @@
=20
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-qom.h"
-#include "qapi/qmp/qlist.h"
=20
=20
 void *fuzz_qos_obj;
@@ -45,34 +44,19 @@ QGuestAllocator *fuzz_qos_alloc;
 static const char *fuzz_target_name;
 static char **fuzz_path_vec;
=20
-/*
- * Replaced the qmp commands with direct qmp_marshal calls.
- * Probably there is a better way to do this
- */
 static void qos_set_machines_devices_available(void)
 {
-    QDict *req =3D qdict_new();
-    QObject *response;
-    QDict *args =3D qdict_new();
-    QList *lst;
+    MachineInfoList *mach_info;
+    ObjectTypeInfoList *type_info;
=20
-    qmp_marshal_query_machines(NULL, &response, &error_abort);
-    lst =3D qobject_to(QList, response);
-    apply_to_qlist(lst, true);
+    mach_info =3D qmp_query_machines(&error_abort);
+    machines_apply_to_node(mach_info);
+    qapi_free_MachineInfoList(mach_info);
=20
-    qobject_unref(response);
-
-
-    qdict_put_str(req, "execute", "qom-list-types");
-    qdict_put_str(args, "implements", "device");
-    qdict_put_bool(args, "abstract", true);
-    qdict_put_obj(req, "arguments", (QObject *) args);
-
-    qmp_marshal_qom_list_types(args, &response, &error_abort);
-    lst =3D qobject_to(QList, response);
-    apply_to_qlist(lst, false);
-    qobject_unref(response);
-    qobject_unref(req);
+    type_info =3D qmp_qom_list_types(true, "device", true, true,
+                                   &error_abort);
+    types_apply_to_node(type_info);
+    qapi_free_ObjectTypeInfoList(type_info);
 }
=20
 static char **current_path;
diff --git a/tests/qtest/libqos/qos_external.c b/tests/qtest/libqos/qos_ext=
ernal.c
index 398556dde0..c707dac3b9 100644
--- a/tests/qtest/libqos/qos_external.c
+++ b/tests/qtest/libqos/qos_external.c
@@ -29,62 +29,40 @@
 #include "libqos/qgraph_internal.h"
 #include "libqos/qos_external.h"
=20
-
-
-void apply_to_node(const char *name, bool is_machine, bool is_abstract)
+static void machine_apply_to_node(const char *name)
 {
-    char *machine_name =3D NULL;
-    if (is_machine) {
-        const char *arch =3D qtest_get_arch();
-        machine_name =3D g_strconcat(arch, "/", name, NULL);
-        name =3D machine_name;
+    char *machine_name =3D g_strconcat(qtest_get_arch(), "/", name, NULL);
+
+    qos_graph_node_set_availability(machine_name, true);
+    g_free(machine_name);
+}
+
+void machines_apply_to_node(MachineInfoList *mach_info)
+{
+    MachineInfoList *tail;
+
+    for (tail =3D mach_info; tail; tail =3D tail->next) {
+        machine_apply_to_node(tail->value->name);
+        if (tail->value->alias) {
+            machine_apply_to_node(tail->value->alias);
+        }
     }
+}
+
+static void type_apply_to_node(const char *name, bool is_abstract)
+{
     qos_graph_node_set_availability(name, true);
     if (is_abstract) {
         qos_delete_cmd_line(name);
     }
-    g_free(machine_name);
 }
=20
-/**
- * apply_to_qlist(): using QMP queries QEMU for a list of
- * machines and devices available, and sets the respective node
- * as true. If a node is found, also all its produced and contained
- * child are marked available.
- *
- * See qos_graph_node_set_availability() for more info
- */
-void apply_to_qlist(QList *list, bool is_machine)
+void types_apply_to_node(ObjectTypeInfoList *type_info)
 {
-    const QListEntry *p;
-    const char *name;
-    bool abstract;
-    QDict *minfo;
-    QObject *qobj;
-    QString *qstr;
-    QBool *qbool;
+    ObjectTypeInfoList *tail;
=20
-    for (p =3D qlist_first(list); p; p =3D qlist_next(p)) {
-        minfo =3D qobject_to(QDict, qlist_entry_obj(p));
-        qobj =3D qdict_get(minfo, "name");
-        qstr =3D qobject_to(QString, qobj);
-        name =3D qstring_get_str(qstr);
-
-        qobj =3D qdict_get(minfo, "abstract");
-        if (qobj) {
-            qbool =3D qobject_to(QBool, qobj);
-            abstract =3D qbool_get_bool(qbool);
-        } else {
-            abstract =3D false;
-        }
-
-        apply_to_node(name, is_machine, abstract);
-        qobj =3D qdict_get(minfo, "alias");
-        if (qobj) {
-            qstr =3D qobject_to(QString, qobj);
-            name =3D qstring_get_str(qstr);
-            apply_to_node(name, is_machine, abstract);
-        }
+    for (tail =3D type_info; tail; tail =3D tail->next) {
+        type_apply_to_node(tail->value->name, tail->value->abstract);
     }
 }
=20
diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
index ad193f43a5..3062a13557 100644
--- a/tests/qtest/qos-test.c
+++ b/tests/qtest/qos-test.c
@@ -19,11 +19,12 @@
 #include "qemu/osdep.h"
 #include <getopt.h>
 #include "libqtest-single.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qstring.h"
 #include "qemu/module.h"
-#include "qapi/qmp/qlist.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/qapi-visit-machine.h"
+#include "qapi/qapi-visit-qom.h"
 #include "libqos/malloc.h"
 #include "libqos/qgraph.h"
 #include "libqos/qgraph_internal.h"
@@ -51,13 +52,20 @@ static void qos_set_machines_devices_available(void)
 {
     QDict *response;
     QDict *args =3D qdict_new();
-    QList *list;
+    QObject *ret;
+    Visitor *v;
+    MachineInfoList *mach_info;
+    ObjectTypeInfoList *type_info;
=20
     qtest_start("-machine none");
     response =3D qmp("{ 'execute': 'query-machines' }");
-    list =3D qdict_get_qlist(response, "return");
+    ret =3D qdict_get(response, "return");
=20
-    apply_to_qlist(list, true);
+    v =3D qobject_input_visitor_new(ret);
+    visit_type_MachineInfoList(v, NULL, &mach_info, &error_abort);
+    visit_free(v);
+    machines_apply_to_node(mach_info);
+    qapi_free_MachineInfoList(mach_info);
=20
     qobject_unref(response);
=20
@@ -66,10 +74,13 @@ static void qos_set_machines_devices_available(void)
=20
     response =3D qmp("{'execute': 'qom-list-types',"
                    " 'arguments': %p }", args);
-    g_assert(qdict_haskey(response, "return"));
-    list =3D qdict_get_qlist(response, "return");
+    ret =3D qdict_get(response, "return");
=20
-    apply_to_qlist(list, false);
+    v =3D qobject_input_visitor_new(ret);
+    visit_type_ObjectTypeInfoList(v, NULL, &type_info, &error_abort);
+    visit_free(v);
+    types_apply_to_node(type_info);
+    qapi_free_ObjectTypeInfoList(type_info);
=20
     qtest_end();
     qobject_unref(response);
--=20
2.21.1


