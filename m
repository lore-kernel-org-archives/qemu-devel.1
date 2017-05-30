Received: from eggs.gnu.org ([2001:4830:134:3::10]:54563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dFmYD-0003VU-QV
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dFmYC-0005k8-Eh
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:11:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dFmYC-0005ji-6I
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:11:28 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 30 May 2017 16:11:20 -0300
Message-Id: <20170530191121.1920-2-ehabkost@redhat.com>
In-Reply-To: <20170530191121.1920-1-ehabkost@redhat.com>
References: <20170530191121.1920-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] numa-test: fix query-cpus leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Fix test leaks introduced in commit 2941020a476.

(and small extra space removed)

Spotted by ASAN.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170526110456.32004-1-marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/numa-test.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tests/numa-test.c b/tests/numa-test.c
index c3475d6d5e..3f636840b1 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -92,7 +92,7 @@ static QList *get_cpus(QDict **resp)
     *resp =3D qmp("{ 'execute': 'query-cpus' }");
     g_assert(*resp);
     g_assert(qdict_haskey(*resp, "return"));
-    return  qdict_get_qlist(*resp, "return");
+    return qdict_get_qlist(*resp, "return");
 }
=20
 static void test_query_cpus(const void *data)
@@ -100,7 +100,7 @@ static void test_query_cpus(const void *data)
     char *cli;
     QDict *resp;
     QList *cpus;
-    const QObject *e;
+    QObject *e;
=20
     cli =3D make_cli(data, "-smp 8 -numa node,cpus=3D0-3 -numa node,cpus=
=3D4-7");
     qtest_start(cli);
@@ -124,6 +124,7 @@ static void test_query_cpus(const void *data)
         } else {
             g_assert_cmpint(node, =3D=3D, 1);
         }
+        qobject_decref(e);
     }
=20
     QDECREF(resp);
@@ -136,7 +137,7 @@ static void pc_numa_cpu(const void *data)
     char *cli;
     QDict *resp;
     QList *cpus;
-    const QObject *e;
+    QObject *e;
=20
     cli =3D make_cli(data, "-cpu pentium -smp 8,sockets=3D2,cores=3D2,th=
reads=3D2 "
         "-numa node,nodeid=3D0 -numa node,nodeid=3D1 "
@@ -176,6 +177,7 @@ static void pc_numa_cpu(const void *data)
         } else {
             g_assert(false);
         }
+        qobject_decref(e);
     }
=20
     QDECREF(resp);
@@ -188,7 +190,7 @@ static void spapr_numa_cpu(const void *data)
     char *cli;
     QDict *resp;
     QList *cpus;
-    const QObject *e;
+    QObject *e;
=20
     cli =3D make_cli(data, "-smp 4,cores=3D4 "
         "-numa node,nodeid=3D0 -numa node,nodeid=3D1 "
@@ -220,6 +222,7 @@ static void spapr_numa_cpu(const void *data)
         } else {
             g_assert(false);
         }
+        qobject_decref(e);
     }
=20
     QDECREF(resp);
@@ -232,7 +235,7 @@ static void aarch64_numa_cpu(const void *data)
     char *cli;
     QDict *resp;
     QList *cpus;
-    const QObject *e;
+    QObject *e;
=20
     cli =3D make_cli(data, "-smp 2 "
         "-numa node,nodeid=3D0 -numa node,nodeid=3D1 "
@@ -262,6 +265,7 @@ static void aarch64_numa_cpu(const void *data)
         } else {
             g_assert(false);
         }
+        qobject_decref(e);
     }
=20
     QDECREF(resp);
--=20
2.11.0.259.g40922b1
