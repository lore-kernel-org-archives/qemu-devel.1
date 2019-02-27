Received: from eggs.gnu.org ([209.51.188.92]:33640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gywyb-0005C6-0G
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:02:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gywyX-0005ls-8b
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:02:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gywyW-0005WY-MX
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:02:09 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC9F830B24F5
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 10:51:56 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 27 Feb 2019 11:51:28 +0100
Message-Id: <20190227105128.1655-4-quintela@redhat.com>
In-Reply-To: <20190227105128.1655-1-quintela@redhat.com>
References: <20190227105128.1655-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v14 3/3] tests: Add basic migration precopy tcp
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>

Not sharing code from precopy/unix because we have to read back the
tcp parameter.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>

---

Update SocketAddress_to_str definition to the same than hmp.c (thomas)
---
 tests/migration-test.c | 110 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 105 insertions(+), 5 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index b0670efde7..677ed9c8a3 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -20,6 +20,9 @@
 #include "qemu/sockets.h"
 #include "chardev/char.h"
 #include "sysemu/sysemu.h"
+#include "qapi/qapi-visit-sockets.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/qobject-output-visitor.h"
=20
 #include "migration/migration-test.h"
=20
@@ -332,15 +335,68 @@ static void cleanup(const char *filename)
     g_free(path);
 }
=20
+static char *SocketAddress_to_str(SocketAddress *addr)
+{
+    switch (addr->type) {
+    case SOCKET_ADDRESS_TYPE_INET:
+        return g_strdup_printf("tcp:%s:%s",
+                               addr->u.inet.host,
+                               addr->u.inet.port);
+    case SOCKET_ADDRESS_TYPE_UNIX:
+        return g_strdup_printf("unix:%s",
+                               addr->u.q_unix.path);
+    case SOCKET_ADDRESS_TYPE_FD:
+        return g_strdup_printf("fd:%s", addr->u.fd.str);
+    case SOCKET_ADDRESS_TYPE_VSOCK:
+        return g_strdup_printf("tcp:%s:%s",
+                               addr->u.vsock.cid,
+                               addr->u.vsock.port);
+    default:
+        return g_strdup("unknown address type");
+    }
+}
+
+static char *migrate_get_socket_address(QTestState *who, const char *par=
ameter)
+{
+    QDict *rsp;
+    char *result;
+    Error *local_err =3D NULL;
+    SocketAddressList *addrs;
+    Visitor *iv =3D NULL;
+    QObject *object;
+
+    rsp =3D migrate_query(who);
+    object =3D qdict_get(rsp, parameter);
+
+    iv =3D qobject_input_visitor_new(object);
+    visit_type_SocketAddressList(iv, NULL, &addrs, &local_err);
+
+    /* we are only using a single address */
+    result =3D g_strdup_printf("%s", SocketAddress_to_str(addrs->value))=
;
+
+    qapi_free_SocketAddressList(addrs);
+    qobject_unref(rsp);
+    return result;
+}
+
+static long long migrate_get_parameter(QTestState *who, const char *para=
meter)
+{
+    QDict *rsp;
+    long long result;
+
+    rsp =3D wait_command(who, "{ 'execute': 'query-migrate-parameters' }=
");
+    result =3D qdict_get_int(rsp, parameter);
+    qobject_unref(rsp);
+    return result;
+}
+
 static void migrate_check_parameter(QTestState *who, const char *paramet=
er,
                                     long long value)
 {
-    QDict *rsp_return;
+    long long result;
=20
-    rsp_return =3D wait_command(who,
-                              "{ 'execute': 'query-migrate-parameters' }=
");
-    g_assert_cmpint(qdict_get_int(rsp_return, parameter), =3D=3D, value)=
;
-    qobject_unref(rsp_return);
+    result =3D migrate_get_parameter(who, parameter);
+    g_assert_cmpint(result, =3D=3D, value);
 }
=20
 static void migrate_set_parameter(QTestState *who, const char *parameter=
,
@@ -844,6 +900,49 @@ static void test_xbzrle_unix(void)
     g_free(uri);
 }
=20
+static void test_precopy_tcp(void)
+{
+    char *uri;
+    QTestState *from, *to;
+
+    if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", false)) {
+        return;
+    }
+
+    /*
+     * We want to pick a speed slow enough that the test completes
+     * quickly, but that it doesn't complete precopy even on a slow
+     * machine, so also set the downtime.
+     */
+    /* 1 ms should make it not converge*/
+    migrate_set_parameter(from, "downtime-limit", 1);
+    /* 1GB/s */
+    migrate_set_parameter(from, "max-bandwidth", 1000000000);
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    uri =3D migrate_get_socket_address(to, "socket-address");
+
+    migrate(from, uri, "{}");
+
+    wait_for_migration_pass(from);
+
+    /* 300ms should converge */
+    migrate_set_parameter(from, "downtime-limit", 300);
+
+    if (!got_stop) {
+        qtest_qmp_eventwait(from, "STOP");
+    }
+    qtest_qmp_eventwait(to, "RESUME");
+
+    wait_for_serial("dest_serial");
+    wait_for_migration_complete(from);
+
+    test_migrate_end(from, to, true);
+    g_free(uri);
+}
+
 int main(int argc, char **argv)
 {
     char template[] =3D "/tmp/migration-test-XXXXXX";
@@ -895,6 +994,7 @@ int main(int argc, char **argv)
     qtest_add_func("/migration/deprecated", test_deprecated);
     qtest_add_func("/migration/bad_dest", test_baddest);
     qtest_add_func("/migration/precopy/unix", test_precopy_unix);
+    qtest_add_func("/migration/precopy/tcp", test_precopy_tcp);
     qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
=20
     ret =3D g_test_run();
--=20
2.20.1
