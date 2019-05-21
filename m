Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A55DC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:56:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22EE121773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22EE121773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51336 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT2R7-0001LP-A4
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 06:56:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hT2PH-00006E-H2
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:54:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hT2PG-0004hm-I1
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:54:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hT2PG-0004hD-9e
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:54:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 92DA830832E9;
	Tue, 21 May 2019 10:54:05 +0000 (UTC)
Received: from thuth.com (ovpn-116-22.ams2.redhat.com [10.36.116.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6239C6085B;
	Tue, 21 May 2019 10:54:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Tue, 21 May 2019 12:53:37 +0200
Message-Id: <20190521105344.11637-7-thuth@redhat.com>
In-Reply-To: <20190521105344.11637-1-thuth@redhat.com>
References: <20190521105344.11637-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Tue, 21 May 2019 10:54:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 06/13] tests/qom-test: Use qtest_init() instead
 of qtest_start()
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

Message-Id: <20190515174328.16361-5-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qom-test.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/tests/qom-test.c b/tests/qom-test.c
index 73c52af3bb..4f94cc678c 100644
--- a/tests/qom-test.c
+++ b/tests/qom-test.c
@@ -44,7 +44,7 @@ static bool is_blacklisted(const char *arch, const char=
 *mach)
     return false;
 }
=20
-static void test_properties(const char *path, bool recurse)
+static void test_properties(QTestState *qts, const char *path, bool recu=
rse)
 {
     char *child_path;
     QDict *response, *tuple, *tmp;
@@ -52,8 +52,8 @@ static void test_properties(const char *path, bool recu=
rse)
     QListEntry *entry;
=20
     g_test_message("Obtaining properties of %s", path);
-    response =3D qmp("{ 'execute': 'qom-list',"
-                   "  'arguments': { 'path': %s } }", path);
+    response =3D qtest_qmp(qts, "{ 'execute': 'qom-list',"
+                              "  'arguments': { 'path': %s } }", path);
     g_assert(response);
=20
     if (!recurse) {
@@ -71,15 +71,15 @@ static void test_properties(const char *path, bool re=
curse)
         if (is_child || is_link) {
             child_path =3D g_strdup_printf("%s/%s",
                                          path, qdict_get_str(tuple, "nam=
e"));
-            test_properties(child_path, is_child);
+            test_properties(qts, child_path, is_child);
             g_free(child_path);
         } else {
             const char *prop =3D qdict_get_str(tuple, "name");
             g_test_message("Testing property %s.%s", path, prop);
-            tmp =3D qmp("{ 'execute': 'qom-get',"
-                      "  'arguments': { 'path': %s,"
-                      "                 'property': %s } }",
-                      path, prop);
+            tmp =3D qtest_qmp(qts,
+                            "{ 'execute': 'qom-get',"
+                            "  'arguments': { 'path': %s, 'property': %s=
 } }",
+                            path, prop);
             /* qom-get may fail but should not, e.g., segfault. */
             g_assert(tmp);
             qobject_unref(tmp);
@@ -91,20 +91,18 @@ static void test_properties(const char *path, bool re=
curse)
 static void test_machine(gconstpointer data)
 {
     const char *machine =3D data;
-    char *args;
     QDict *response;
+    QTestState *qts;
=20
-    args =3D g_strdup_printf("-machine %s", machine);
-    qtest_start(args);
+    qts =3D qtest_initf("-machine %s", machine);
=20
-    test_properties("/machine", true);
+    test_properties(qts, "/machine", true);
=20
-    response =3D qmp("{ 'execute': 'quit' }");
+    response =3D qtest_qmp(qts, "{ 'execute': 'quit' }");
     g_assert(qdict_haskey(response, "return"));
     qobject_unref(response);
=20
-    qtest_end();
-    g_free(args);
+    qtest_quit(qts);
     g_free((void *)machine);
 }
=20
--=20
2.21.0


