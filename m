Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5DCC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 11:01:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B0221773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 11:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B0221773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51415 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT2Wb-0006UE-Db
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 07:01:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hT2PL-00009E-91
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:54:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hT2PJ-0004k0-Te
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:54:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hT2PJ-0004jU-Li
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:54:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F31A7307D855;
	Tue, 21 May 2019 10:54:08 +0000 (UTC)
Received: from thuth.com (ovpn-116-22.ams2.redhat.com [10.36.116.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DE03B6085B;
	Tue, 21 May 2019 10:54:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Tue, 21 May 2019 12:53:38 +0200
Message-Id: <20190521105344.11637-8-thuth@redhat.com>
In-Reply-To: <20190521105344.11637-1-thuth@redhat.com>
References: <20190521105344.11637-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Tue, 21 May 2019 10:54:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 07/13] tests/device-introspect: Use qtest_init()
 instead of qtest_start()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, lvivier@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qtest_start() + qtest_end() should be avoided, since they use the
global_qtest variable that we want to get rid of in the long run.
Use qtest_init() and qtest_quit() instead.

Message-Id: <20190515174328.16361-6-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/device-introspect-test.c | 85 ++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 39 deletions(-)

diff --git a/tests/device-introspect-test.c b/tests/device-introspect-tes=
t.c
index a25092dfaa..04f22903b0 100644
--- a/tests/device-introspect-test.c
+++ b/tests/device-introspect-test.c
@@ -26,7 +26,8 @@
=20
 const char common_args[] =3D "-nodefaults -machine none";
=20
-static QList *qom_list_types(const char *implements, bool abstract)
+static QList *qom_list_types(QTestState * qts, const char *implements,
+                             bool abstract)
 {
     QDict *resp;
     QList *ret;
@@ -36,8 +37,8 @@ static QList *qom_list_types(const char *implements, bo=
ol abstract)
     if (implements) {
         qdict_put_str(args, "implements", implements);
     }
-    resp =3D qmp("{'execute': 'qom-list-types',"
-               " 'arguments': %p }", args);
+    resp =3D qtest_qmp(qts, "{'execute': 'qom-list-types', 'arguments': =
%p }",
+                     args);
     g_assert(qdict_haskey(resp, "return"));
     ret =3D qdict_get_qlist(resp, "return");
     qobject_ref(ret);
@@ -95,12 +96,12 @@ static QDict *type_list_find(QList *types, const char=
 *name)
     return NULL;
 }
=20
-static QList *device_type_list(bool abstract)
+static QList *device_type_list(QTestState *qts, bool abstract)
 {
-    return qom_list_types("device", abstract);
+    return qom_list_types(qts, "device", abstract);
 }
=20
-static void test_one_device(const char *type)
+static void test_one_device(QTestState *qts, const char *type)
 {
     QDict *resp;
     char *help;
@@ -109,15 +110,15 @@ static void test_one_device(const char *type)
=20
     g_test_message("Testing device '%s'", type);
=20
-    qom_tree_start =3D hmp("info qom-tree");
-    qtree_start =3D hmp("info qtree");
+    qom_tree_start =3D qtest_hmp(qts, "info qom-tree");
+    qtree_start =3D qtest_hmp(qts, "info qtree");
=20
-    resp =3D qmp("{'execute': 'device-list-properties',"
-               " 'arguments': {'typename': %s}}",
+    resp =3D qtest_qmp(qts, "{'execute': 'device-list-properties',"
+                          " 'arguments': {'typename': %s}}",
                type);
     qobject_unref(resp);
=20
-    help =3D hmp("device_add \"%s,help\"", type);
+    help =3D qtest_hmp(qts, "device_add \"%s,help\"", type);
     g_free(help);
=20
     /*
@@ -125,12 +126,12 @@ static void test_one_device(const char *type)
      * "info qom-tree" or "info qtree" have a good chance at crashing th=
en.
      * Also make sure that the tree did not change.
      */
-    qom_tree_end =3D hmp("info qom-tree");
+    qom_tree_end =3D qtest_hmp(qts, "info qom-tree");
     g_assert_cmpstr(qom_tree_start, =3D=3D, qom_tree_end);
     g_free(qom_tree_start);
     g_free(qom_tree_end);
=20
-    qtree_end =3D hmp("info qtree");
+    qtree_end =3D qtest_hmp(qts, "info qtree");
     g_assert_cmpstr(qtree_start, =3D=3D, qtree_end);
     g_free(qtree_start);
     g_free(qtree_end);
@@ -140,29 +141,30 @@ static void test_device_intro_list(void)
 {
     QList *types;
     char *help;
+    QTestState *qts;
=20
-    qtest_start(common_args);
+    qts =3D qtest_init(common_args);
=20
-    types =3D device_type_list(true);
+    types =3D device_type_list(qts, true);
     qobject_unref(types);
=20
-    help =3D hmp("device_add help");
+    help =3D qtest_hmp(qts, "device_add help");
     g_free(help);
=20
-    qtest_end();
+    qtest_quit(qts);
 }
=20
 /*
  * Ensure all entries returned by qom-list-types implements=3D<parent>
  * have <parent> as a parent.
  */
-static void test_qom_list_parents(const char *parent)
+static void test_qom_list_parents(QTestState *qts, const char *parent)
 {
     QList *types;
     QListEntry *e;
     QDict *index;
=20
-    types =3D qom_list_types(parent, true);
+    types =3D qom_list_types(qts, parent, true);
     index =3D qom_type_index(types);
=20
     QLIST_FOREACH_ENTRY(types, e) {
@@ -181,11 +183,12 @@ static void test_qom_list_fields(void)
     QList *all_types;
     QList *non_abstract;
     QListEntry *e;
+    QTestState *qts;
=20
-    qtest_start(common_args);
+    qts =3D qtest_init(common_args);
=20
-    all_types =3D qom_list_types(NULL, true);
-    non_abstract =3D qom_list_types(NULL, false);
+    all_types =3D qom_list_types(qts, NULL, true);
+    non_abstract =3D qom_list_types(qts, NULL, false);
=20
     QLIST_FOREACH_ENTRY(all_types, e) {
         QDict *d =3D qobject_to(QDict, qlist_entry_obj(e));
@@ -198,27 +201,29 @@ static void test_qom_list_fields(void)
         g_assert(abstract =3D=3D expected_abstract);
     }
=20
-    test_qom_list_parents("object");
-    test_qom_list_parents("device");
-    test_qom_list_parents("sys-bus-device");
+    test_qom_list_parents(qts, "object");
+    test_qom_list_parents(qts, "device");
+    test_qom_list_parents(qts, "sys-bus-device");
=20
     qobject_unref(all_types);
     qobject_unref(non_abstract);
-    qtest_end();
+    qtest_quit(qts);
 }
=20
 static void test_device_intro_none(void)
 {
-    qtest_start(common_args);
-    test_one_device("nonexistent");
-    qtest_end();
+    QTestState *qts =3D qtest_init(common_args);
+
+    test_one_device(qts, "nonexistent");
+    qtest_quit(qts);
 }
=20
 static void test_device_intro_abstract(void)
 {
-    qtest_start(common_args);
-    test_one_device("device");
-    qtest_end();
+    QTestState *qts =3D qtest_init(common_args);
+
+    test_one_device(qts, "device");
+    qtest_quit(qts);
 }
=20
 static void test_device_intro_concrete(const void *args)
@@ -226,19 +231,20 @@ static void test_device_intro_concrete(const void *=
args)
     QList *types;
     QListEntry *entry;
     const char *type;
+    QTestState *qts;
=20
-    qtest_start(args);
-    types =3D device_type_list(false);
+    qts =3D qtest_init(args);
+    types =3D device_type_list(qts, false);
=20
     QLIST_FOREACH_ENTRY(types, entry) {
         type =3D qdict_get_try_str(qobject_to(QDict, qlist_entry_obj(ent=
ry)),
                                  "name");
         g_assert(type);
-        test_one_device(type);
+        test_one_device(qts, type);
     }
=20
     qobject_unref(types);
-    qtest_end();
+    qtest_quit(qts);
     g_free((void *)args);
 }
=20
@@ -247,10 +253,11 @@ static void test_abstract_interfaces(void)
     QList *all_types;
     QListEntry *e;
     QDict *index;
+    QTestState *qts;
=20
-    qtest_start(common_args);
+    qts =3D qtest_init(common_args);
=20
-    all_types =3D qom_list_types("interface", true);
+    all_types =3D qom_list_types(qts, "interface", true);
     index =3D qom_type_index(all_types);
=20
     QLIST_FOREACH_ENTRY(all_types, e) {
@@ -273,7 +280,7 @@ static void test_abstract_interfaces(void)
=20
     qobject_unref(all_types);
     qobject_unref(index);
-    qtest_end();
+    qtest_quit(qts);
 }
=20
 static void add_machine_test_case(const char *mname)
--=20
2.21.0


