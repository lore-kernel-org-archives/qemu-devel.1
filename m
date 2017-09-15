Received: from eggs.gnu.org ([2001:4830:134:3::10]:54790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dslaV-0007vg-4d
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dslaU-0000lU-2o
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:02:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dslaT-0000lL-TG
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:02:58 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 15 Sep 2017 10:02:27 +0200
Message-Id: <1505462549-27298-8-git-send-email-thuth@redhat.com>
In-Reply-To: <1505462549-27298-1-git-send-email-thuth@redhat.com>
References: <1505462549-27298-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/9] numa-test: Use hmp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, John Snow <jsnow@redhat.com>

From: Eric Blake <eblake@redhat.com>

Don't open-code something that has a convenient helper available.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/numa-test.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/tests/numa-test.c b/tests/numa-test.c
index 3f63684..e1b6152 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -17,21 +17,6 @@ static char *make_cli(const char *generic_cli, const c=
har *test_cli)
     return g_strdup_printf("%s %s", generic_cli ? generic_cli : "", test=
_cli);
 }
=20
-static char *hmp_info_numa(void)
-{
-    QDict *resp;
-    char *s;
-
-    resp =3D qmp("{ 'execute': 'human-monitor-command', 'arguments': "
-                      "{ 'command-line': 'info numa '} }");
-    g_assert(resp);
-    g_assert(qdict_haskey(resp, "return"));
-    s =3D g_strdup(qdict_get_str(resp, "return"));
-    g_assert(s);
-    QDECREF(resp);
-    return s;
-}
-
 static void test_mon_explicit(const void *data)
 {
     char *s;
@@ -42,7 +27,7 @@ static void test_mon_explicit(const void *data)
                    "-numa node,nodeid=3D1,cpus=3D4-7 ");
     qtest_start(cli);
=20
-    s =3D hmp_info_numa();
+    s =3D hmp("info numa");
     g_assert(strstr(s, "node 0 cpus: 0 1 2 3"));
     g_assert(strstr(s, "node 1 cpus: 4 5 6 7"));
     g_free(s);
@@ -59,7 +44,7 @@ static void test_mon_default(const void *data)
     cli =3D make_cli(data, "-smp 8 -numa node -numa node");
     qtest_start(cli);
=20
-    s =3D hmp_info_numa();
+    s =3D hmp("info numa");
     g_assert(strstr(s, "node 0 cpus: 0 2 4 6"));
     g_assert(strstr(s, "node 1 cpus: 1 3 5 7"));
     g_free(s);
@@ -78,7 +63,7 @@ static void test_mon_partial(const void *data)
                    "-numa node,nodeid=3D1,cpus=3D4-5 ");
     qtest_start(cli);
=20
-    s =3D hmp_info_numa();
+    s =3D hmp("info numa");
     g_assert(strstr(s, "node 0 cpus: 0 1 2 3 6 7"));
     g_assert(strstr(s, "node 1 cpus: 4 5"));
     g_free(s);
--=20
1.8.3.1
