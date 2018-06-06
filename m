Received: from eggs.gnu.org ([2001:4830:134:3::10]:49078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fQeZb-00089N-CS
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fQeZY-00028d-7O
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:58:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fQeZX-000285-SX
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:58:20 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w56JmpVM056096
	for <qemu-devel@nongnu.org>; Wed, 6 Jun 2018 15:58:18 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jektx6hqb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 15:58:17 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 6 Jun 2018 13:58:17 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed,  6 Jun 2018 15:58:02 -0400
In-Reply-To: <20180606195805.185833-1-stefanb@linux.vnet.ibm.com>
References: <20180606195805.185833-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180606195805.185833-2-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 1/4] test: Move reusable code from
 tpm-crb-swtpm-test.c to tpm-util.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>

Move code we can reuse from tpm-crb-swtpm-test.c into tpm-util.c
and prefix functions with 'tpm_util_'.

Remove some unnecessary #include's.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/tpm-crb-swtpm-test.c | 100 +++------------------------------------=
------
 tests/tpm-util.c           |  89 +++++++++++++++++++++++++++++++++++++++=
+
 tests/tpm-util.h           |  10 +++++
 3 files changed, 104 insertions(+), 95 deletions(-)

diff --git a/tests/tpm-crb-swtpm-test.c b/tests/tpm-crb-swtpm-test.c
index c2bde0cbaa..2a22b032ca 100644
--- a/tests/tpm-crb-swtpm-test.c
+++ b/tests/tpm-crb-swtpm-test.c
@@ -15,12 +15,8 @@
 #include "qemu/osdep.h"
 #include <glib/gstdio.h>
=20
-#include "hw/acpi/tpm.h"
-#include "io/channel-socket.h"
 #include "libqtest.h"
 #include "tpm-util.h"
-#include "sysemu/tpm.h"
-#include "qapi/qmp/qdict.h"
=20
 typedef struct TestState {
     char *src_tpm_path;
@@ -28,93 +24,6 @@ typedef struct TestState {
     char *uri;
 } TestState;
=20
-bool got_stop;
-
-static void migrate(QTestState *who, const char *uri)
-{
-    QDict *rsp;
-    gchar *cmd;
-
-    cmd =3D g_strdup_printf("{ 'execute': 'migrate',"
-                          "'arguments': { 'uri': '%s' } }",
-                          uri);
-    rsp =3D qtest_qmp(who, cmd);
-    g_free(cmd);
-    g_assert(qdict_haskey(rsp, "return"));
-    qobject_unref(rsp);
-}
-
-/*
- * Events can get in the way of responses we are actually waiting for.
- */
-static QDict *wait_command(QTestState *who, const char *command)
-{
-    const char *event_string;
-    QDict *response;
-
-    response =3D qtest_qmp(who, command);
-
-    while (qdict_haskey(response, "event")) {
-        /* OK, it was an event */
-        event_string =3D qdict_get_str(response, "event");
-        if (!strcmp(event_string, "STOP")) {
-            got_stop =3D true;
-        }
-        qobject_unref(response);
-        response =3D qtest_qmp_receive(who);
-    }
-    return response;
-}
-
-static void wait_for_migration_complete(QTestState *who)
-{
-    while (true) {
-        QDict *rsp, *rsp_return;
-        bool completed;
-        const char *status;
-
-        rsp =3D wait_command(who, "{ 'execute': 'query-migrate' }");
-        rsp_return =3D qdict_get_qdict(rsp, "return");
-        status =3D qdict_get_str(rsp_return, "status");
-        completed =3D strcmp(status, "completed") =3D=3D 0;
-        g_assert_cmpstr(status, !=3D,  "failed");
-        qobject_unref(rsp);
-        if (completed) {
-            return;
-        }
-        usleep(1000);
-    }
-}
-
-static void migration_start_qemu(QTestState **src_qemu, QTestState **dst=
_qemu,
-                                 SocketAddress *src_tpm_addr,
-                                 SocketAddress *dst_tpm_addr,
-                                 const char *miguri)
-{
-    char *src_qemu_args, *dst_qemu_args;
-
-    src_qemu_args =3D g_strdup_printf(
-        "-chardev socket,id=3Dchr,path=3D%s "
-        "-tpmdev emulator,id=3Ddev,chardev=3Dchr "
-        "-device tpm-crb,tpmdev=3Ddev ",
-        src_tpm_addr->u.q_unix.path);
-
-    *src_qemu =3D qtest_init(src_qemu_args);
-
-    dst_qemu_args =3D g_strdup_printf(
-        "-chardev socket,id=3Dchr,path=3D%s "
-        "-tpmdev emulator,id=3Ddev,chardev=3Dchr "
-        "-device tpm-crb,tpmdev=3Ddev "
-        "-incoming %s",
-        dst_tpm_addr->u.q_unix.path,
-        miguri);
-
-    *dst_qemu =3D qtest_init(dst_qemu_args);
-
-    free(src_qemu_args);
-    free(dst_qemu_args);
-}
-
 static void tpm_crb_swtpm_test(const void *data)
 {
     char *args =3D NULL;
@@ -183,8 +92,9 @@ static void tpm_crb_swtpm_migration_test(const void *d=
ata)
         goto err_src_tpm_kill;
     }
=20
-    migration_start_qemu(&src_qemu, &dst_qemu, src_tpm_addr, dst_tpm_add=
r,
-                         ts->uri);
+    tpm_util_migration_start_qemu(&src_qemu, &dst_qemu,
+                                  src_tpm_addr, dst_tpm_addr,
+                                  ts->uri);
=20
     tpm_util_startup(src_qemu, tpm_util_crb_transfer);
     tpm_util_pcrextend(src_qemu, tpm_util_crb_transfer);
@@ -197,8 +107,8 @@ static void tpm_crb_swtpm_migration_test(const void *=
data)
     tpm_util_pcrread(src_qemu, tpm_util_crb_transfer, tpm_pcrread_resp,
                      sizeof(tpm_pcrread_resp));
=20
-    migrate(src_qemu, ts->uri);
-    wait_for_migration_complete(src_qemu);
+    tpm_util_migrate(src_qemu, ts->uri);
+    tpm_util_wait_for_migration_complete(src_qemu);
=20
     tpm_util_pcrread(dst_qemu, tpm_util_crb_transfer, tpm_pcrread_resp,
                      sizeof(tpm_pcrread_resp));
diff --git a/tests/tpm-util.c b/tests/tpm-util.c
index c9b3947c1c..e6e3b922fa 100644
--- a/tests/tpm-util.c
+++ b/tests/tpm-util.c
@@ -17,6 +17,9 @@
 #include "hw/acpi/tpm.h"
 #include "libqtest.h"
 #include "tpm-util.h"
+#include "qapi/qmp/qdict.h"
+
+static bool got_stop;
=20
 void tpm_util_crb_transfer(QTestState *s,
                            const unsigned char *req, size_t req_size,
@@ -184,3 +187,89 @@ void tpm_util_swtpm_kill(GPid pid)
=20
     kill(pid, SIGKILL);
 }
+
+void tpm_util_migrate(QTestState *who, const char *uri)
+{
+    QDict *rsp;
+    gchar *cmd;
+
+    cmd =3D g_strdup_printf("{ 'execute': 'migrate',"
+                          "'arguments': { 'uri': '%s' } }",
+                          uri);
+    rsp =3D qtest_qmp(who, cmd);
+    g_free(cmd);
+    g_assert(qdict_haskey(rsp, "return"));
+    qobject_unref(rsp);
+}
+
+/*
+ * Events can get in the way of responses we are actually waiting for.
+ */
+static QDict *tpm_util_wait_command(QTestState *who, const char *command=
)
+{
+    const char *event_string;
+    QDict *response;
+
+    response =3D qtest_qmp(who, command);
+
+    while (qdict_haskey(response, "event")) {
+        /* OK, it was an event */
+        event_string =3D qdict_get_str(response, "event");
+        if (!strcmp(event_string, "STOP")) {
+            got_stop =3D true;
+        }
+        qobject_unref(response);
+        response =3D qtest_qmp_receive(who);
+    }
+    return response;
+}
+
+void tpm_util_wait_for_migration_complete(QTestState *who)
+{
+    while (true) {
+        QDict *rsp, *rsp_return;
+        bool completed;
+        const char *status;
+
+        rsp =3D tpm_util_wait_command(who, "{ 'execute': 'query-migrate'=
 }");
+        rsp_return =3D qdict_get_qdict(rsp, "return");
+        status =3D qdict_get_str(rsp_return, "status");
+        completed =3D strcmp(status, "completed") =3D=3D 0;
+        g_assert_cmpstr(status, !=3D,  "failed");
+        qobject_unref(rsp);
+        if (completed) {
+            return;
+        }
+        usleep(1000);
+    }
+}
+
+void tpm_util_migration_start_qemu(QTestState **src_qemu,
+                                   QTestState **dst_qemu,
+                                   SocketAddress *src_tpm_addr,
+                                   SocketAddress *dst_tpm_addr,
+                                   const char *miguri)
+{
+    char *src_qemu_args, *dst_qemu_args;
+
+    src_qemu_args =3D g_strdup_printf(
+        "-chardev socket,id=3Dchr,path=3D%s "
+        "-tpmdev emulator,id=3Ddev,chardev=3Dchr "
+        "-device tpm-crb,tpmdev=3Ddev ",
+        src_tpm_addr->u.q_unix.path);
+
+    *src_qemu =3D qtest_init(src_qemu_args);
+
+    dst_qemu_args =3D g_strdup_printf(
+        "-chardev socket,id=3Dchr,path=3D%s "
+        "-tpmdev emulator,id=3Ddev,chardev=3Dchr "
+        "-device tpm-crb,tpmdev=3Ddev "
+        "-incoming %s",
+        dst_tpm_addr->u.q_unix.path,
+        miguri);
+
+    *dst_qemu =3D qtest_init(dst_qemu_args);
+
+    free(src_qemu_args);
+    free(dst_qemu_args);
+}
diff --git a/tests/tpm-util.h b/tests/tpm-util.h
index d155d99aea..b6253106d9 100644
--- a/tests/tpm-util.h
+++ b/tests/tpm-util.h
@@ -33,4 +33,14 @@ gboolean tpm_util_swtpm_start(const char *path, GPid *=
pid,
                               SocketAddress **addr, GError **error);
 void tpm_util_swtpm_kill(GPid pid);
=20
+void tpm_util_migrate(QTestState *who, const char *uri);
+
+void tpm_util_migration_start_qemu(QTestState **src_qemu,
+                                   QTestState **dst_qemu,
+                                   SocketAddress *src_tpm_addr,
+                                   SocketAddress *dst_tpm_addr,
+                                   const char *miguri);
+
+void tpm_util_wait_for_migration_complete(QTestState *who);
+
 #endif /* TESTS_TPM_UTIL_H */
--=20
2.14.4
