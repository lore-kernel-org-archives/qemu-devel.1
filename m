Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3719C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8523216C4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8523216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50263 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOeJE-0004l4-26
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 04:21:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hOeHN-0001tc-V1
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hOeHN-0000JE-1h
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:19:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hOeHM-0000Id-SE
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:19:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D78FC0601F2;
	Thu,  9 May 2019 08:19:48 +0000 (UTC)
Received: from thuth.com (ovpn-116-115.ams2.redhat.com [10.36.116.115])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 311D55B681;
	Thu,  9 May 2019 08:19:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Thu,  9 May 2019 10:19:20 +0200
Message-Id: <20190509081930.19081-5-thuth@redhat.com>
In-Reply-To: <20190509081930.19081-1-thuth@redhat.com>
References: <20190509081930.19081-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Thu, 09 May 2019 08:19:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/14] tests/qmp-cmd-test: Use qtest_init()
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
Cc: ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qtest_start() + qtest_end() should be avoided, since they use the
global_qtest variable that we want to get rid of in the long run
(since global_qtest can not be used in tests that have to track
multiple QEMU states, like migration tests). Use qtest_init() and
qtest_quit() instead.

Message-Id: <20190409085245.31548-4-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qmp-cmd-test.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tests/qmp-cmd-test.c b/tests/qmp-cmd-test.c
index d12cac539c..9f5228cd99 100644
--- a/tests/qmp-cmd-test.c
+++ b/tests/qmp-cmd-test.c
@@ -61,10 +61,11 @@ static void test_query(const void *data)
     int expected_error_class =3D query_error_class(cmd);
     QDict *resp, *error;
     const char *error_class;
+    QTestState *qts;
=20
-    qtest_start(common_args);
+    qts =3D qtest_init(common_args);
=20
-    resp =3D qmp("{ 'execute': %s }", cmd);
+    resp =3D qtest_qmp(qts, "{ 'execute': %s }", cmd);
     error =3D qdict_get_qdict(resp, "error");
     error_class =3D error ? qdict_get_str(error, "class") : NULL;
=20
@@ -78,7 +79,7 @@ static void test_query(const void *data)
     }
     qobject_unref(resp);
=20
-    qtest_end();
+    qtest_quit(qts);
 }
=20
 static bool query_is_blacklisted(const char *cmd)
@@ -118,16 +119,18 @@ static void qmp_schema_init(QmpSchema *schema)
     QDict *resp;
     Visitor *qiv;
     SchemaInfoList *tail;
+    QTestState *qts;
=20
-    qtest_start(common_args);
-    resp =3D qmp("{ 'execute': 'query-qmp-schema' }");
+    qts =3D qtest_init(common_args);
+
+    resp =3D qtest_qmp(qts, "{ 'execute': 'query-qmp-schema' }");
=20
     qiv =3D qobject_input_visitor_new(qdict_get(resp, "return"));
     visit_type_SchemaInfoList(qiv, NULL, &schema->list, &error_abort);
     visit_free(qiv);
=20
     qobject_unref(resp);
-    qtest_end();
+    qtest_quit(qts);
=20
     schema->hash =3D g_hash_table_new(g_str_hash, g_str_equal);
=20
--=20
2.21.0


