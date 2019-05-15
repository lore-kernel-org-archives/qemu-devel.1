Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F85C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 17:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB4F2084F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 17:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB4F2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40502 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQy22-0000WT-UJ
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 13:49:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hQxwJ-0004ZC-QN
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hQxwI-0004MU-IG
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:43:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hQxwI-0004M7-B6
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:43:38 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AF83F3092648
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 17:43:37 +0000 (UTC)
Received: from thuth.com (ovpn-117-96.ams2.redhat.com [10.36.117.96])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A7068166A9;
	Wed, 15 May 2019 17:43:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>,
	qemu-devel@nongnu.org
Date: Wed, 15 May 2019 19:43:25 +0200
Message-Id: <20190515174328.16361-4-thuth@redhat.com>
In-Reply-To: <20190515174328.16361-1-thuth@redhat.com>
References: <20190515174328.16361-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Wed, 15 May 2019 17:43:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/6] tests/numa-test: Use qtest_init() instead
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qtest_start() + qtest_end() should be avoided, since they use the
global_qtest variable that we want to get rid of in the long run.
Use qtest_init() and qtest_quit() instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/numa-test.c | 53 +++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/tests/numa-test.c b/tests/numa-test.c
index 9824fdd587..8de8581231 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -23,18 +23,19 @@ static void test_mon_explicit(const void *data)
 {
     char *s;
     char *cli;
+    QTestState *qts;
=20
     cli =3D make_cli(data, "-smp 8 "
                    "-numa node,nodeid=3D0,cpus=3D0-3 "
                    "-numa node,nodeid=3D1,cpus=3D4-7 ");
-    qtest_start(cli);
+    qts =3D qtest_init(cli);
=20
-    s =3D hmp("info numa");
+    s =3D qtest_hmp(qts, "info numa");
     g_assert(strstr(s, "node 0 cpus: 0 1 2 3"));
     g_assert(strstr(s, "node 1 cpus: 4 5 6 7"));
     g_free(s);
=20
-    qtest_end();
+    qtest_quit(qts);
     g_free(cli);
 }
=20
@@ -42,16 +43,17 @@ static void test_mon_default(const void *data)
 {
     char *s;
     char *cli;
+    QTestState *qts;
=20
     cli =3D make_cli(data, "-smp 8 -numa node -numa node");
-    qtest_start(cli);
+    qts =3D qtest_init(cli);
=20
-    s =3D hmp("info numa");
+    s =3D qtest_hmp(qts, "info numa");
     g_assert(strstr(s, "node 0 cpus: 0 2 4 6"));
     g_assert(strstr(s, "node 1 cpus: 1 3 5 7"));
     g_free(s);
=20
-    qtest_end();
+    qtest_quit(qts);
     g_free(cli);
 }
=20
@@ -59,24 +61,25 @@ static void test_mon_partial(const void *data)
 {
     char *s;
     char *cli;
+    QTestState *qts;
=20
     cli =3D make_cli(data, "-smp 8 "
                    "-numa node,nodeid=3D0,cpus=3D0-1 "
                    "-numa node,nodeid=3D1,cpus=3D4-5 ");
-    qtest_start(cli);
+    qts =3D qtest_init(cli);
=20
-    s =3D hmp("info numa");
+    s =3D qtest_hmp(qts, "info numa");
     g_assert(strstr(s, "node 0 cpus: 0 1 2 3 6 7"));
     g_assert(strstr(s, "node 1 cpus: 4 5"));
     g_free(s);
=20
-    qtest_end();
+    qtest_quit(qts);
     g_free(cli);
 }
=20
-static QList *get_cpus(QDict **resp)
+static QList *get_cpus(QTestState *qts, QDict **resp)
 {
-    *resp =3D qmp("{ 'execute': 'query-cpus' }");
+    *resp =3D qtest_qmp(qts, "{ 'execute': 'query-cpus' }");
     g_assert(*resp);
     g_assert(qdict_haskey(*resp, "return"));
     return qdict_get_qlist(*resp, "return");
@@ -88,10 +91,11 @@ static void test_query_cpus(const void *data)
     QDict *resp;
     QList *cpus;
     QObject *e;
+    QTestState *qts;
=20
     cli =3D make_cli(data, "-smp 8 -numa node,cpus=3D0-3 -numa node,cpus=
=3D4-7");
-    qtest_start(cli);
-    cpus =3D get_cpus(&resp);
+    qts =3D qtest_init(cli);
+    cpus =3D get_cpus(qts, &resp);
     g_assert(cpus);
=20
     while ((e =3D qlist_pop(cpus))) {
@@ -115,7 +119,7 @@ static void test_query_cpus(const void *data)
     }
=20
     qobject_unref(resp);
-    qtest_end();
+    qtest_quit(qts);
     g_free(cli);
 }
=20
@@ -125,6 +129,7 @@ static void pc_numa_cpu(const void *data)
     QDict *resp;
     QList *cpus;
     QObject *e;
+    QTestState *qts;
=20
     cli =3D make_cli(data, "-cpu pentium -smp 8,sockets=3D2,cores=3D2,th=
reads=3D2 "
         "-numa node,nodeid=3D0 -numa node,nodeid=3D1 "
@@ -132,8 +137,8 @@ static void pc_numa_cpu(const void *data)
         "-numa cpu,node-id=3D0,socket-id=3D1,core-id=3D0 "
         "-numa cpu,node-id=3D0,socket-id=3D1,core-id=3D1,thread-id=3D0 "
         "-numa cpu,node-id=3D1,socket-id=3D1,core-id=3D1,thread-id=3D1")=
;
-    qtest_start(cli);
-    cpus =3D get_cpus(&resp);
+    qts =3D qtest_init(cli);
+    cpus =3D get_cpus(qts, &resp);
     g_assert(cpus);
=20
     while ((e =3D qlist_pop(cpus))) {
@@ -168,7 +173,7 @@ static void pc_numa_cpu(const void *data)
     }
=20
     qobject_unref(resp);
-    qtest_end();
+    qtest_quit(qts);
     g_free(cli);
 }
=20
@@ -178,6 +183,7 @@ static void spapr_numa_cpu(const void *data)
     QDict *resp;
     QList *cpus;
     QObject *e;
+    QTestState *qts;
=20
     cli =3D make_cli(data, "-smp 4,cores=3D4 "
         "-numa node,nodeid=3D0 -numa node,nodeid=3D1 "
@@ -185,8 +191,8 @@ static void spapr_numa_cpu(const void *data)
         "-numa cpu,node-id=3D0,core-id=3D1 "
         "-numa cpu,node-id=3D0,core-id=3D2 "
         "-numa cpu,node-id=3D1,core-id=3D3");
-    qtest_start(cli);
-    cpus =3D get_cpus(&resp);
+    qts =3D qtest_init(cli);
+    cpus =3D get_cpus(qts, &resp);
     g_assert(cpus);
=20
     while ((e =3D qlist_pop(cpus))) {
@@ -213,7 +219,7 @@ static void spapr_numa_cpu(const void *data)
     }
=20
     qobject_unref(resp);
-    qtest_end();
+    qtest_quit(qts);
     g_free(cli);
 }
=20
@@ -223,13 +229,14 @@ static void aarch64_numa_cpu(const void *data)
     QDict *resp;
     QList *cpus;
     QObject *e;
+    QTestState *qts;
=20
     cli =3D make_cli(data, "-smp 2 "
         "-numa node,nodeid=3D0 -numa node,nodeid=3D1 "
         "-numa cpu,node-id=3D1,thread-id=3D0 "
         "-numa cpu,node-id=3D0,thread-id=3D1");
-    qtest_start(cli);
-    cpus =3D get_cpus(&resp);
+    qts =3D qtest_init(cli);
+    cpus =3D get_cpus(qts, &resp);
     g_assert(cpus);
=20
     while ((e =3D qlist_pop(cpus))) {
@@ -256,7 +263,7 @@ static void aarch64_numa_cpu(const void *data)
     }
=20
     qobject_unref(resp);
-    qtest_end();
+    qtest_quit(qts);
     g_free(cli);
 }
=20
--=20
2.21.0


