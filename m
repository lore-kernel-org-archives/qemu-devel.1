Received: from eggs.gnu.org ([2001:4830:134:3::10]:52264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d3NRX-0000J2-6c
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d3NRV-0006la-NW
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:57:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d3NRV-0006lO-F1
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:57:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 585C785541
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 13:57:16 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 26 Apr 2017 14:57:06 +0100
Message-Id: <20170426135707.5261-5-dgilbert@redhat.com>
In-Reply-To: <20170426135707.5261-1-dgilbert@redhat.com>
References: <20170426135707.5261-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/5] libqtest: Add a generic function to run a
 callback function for every machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com

From: Thomas Huth <thuth@redhat.com>

Some tests need to run single tests for every available machine of the
current QEMU binary. To avoid code duplication, let's extract this
code that deals with 'query-machines' into a separate function.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1490860207-8302-3-git-send-email-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/libqtest.c    | 30 +++++++++++++++++
 tests/libqtest.h    |  8 +++++
 tests/pc-cpu-test.c | 95 ++++++++++++++++++++---------------------------=
------
 tests/qom-test.c    | 36 ++++----------------
 4 files changed, 80 insertions(+), 89 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 0b0bf1d460..512c150266 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -946,3 +946,33 @@ bool qtest_big_endian(QTestState *s)
 {
     return s->big_endian;
 }
+
+void qtest_cb_for_every_machine(void (*cb)(const char *machine))
+{
+    QDict *response, *minfo;
+    QList *list;
+    const QListEntry *p;
+    QObject *qobj;
+    QString *qstr;
+    const char *mname;
+
+    qtest_start("-machine none");
+    response =3D qmp("{ 'execute': 'query-machines' }");
+    g_assert(response);
+    list =3D qdict_get_qlist(response, "return");
+    g_assert(list);
+
+    for (p =3D qlist_first(list); p; p =3D qlist_next(p)) {
+        minfo =3D qobject_to_qdict(qlist_entry_obj(p));
+        g_assert(minfo);
+        qobj =3D qdict_get(minfo, "name");
+        g_assert(qobj);
+        qstr =3D qobject_to_qstring(qobj);
+        g_assert(qstr);
+        mname =3D qstring_get_str(qstr);
+        cb(mname);
+    }
+
+    qtest_end();
+    QDECREF(response);
+}
diff --git a/tests/libqtest.h b/tests/libqtest.h
index ee237448da..38bc1e9953 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -919,4 +919,12 @@ void qmp_fd_send(int fd, const char *fmt, ...);
 QDict *qmp_fdv(int fd, const char *fmt, va_list ap);
 QDict *qmp_fd(int fd, const char *fmt, ...);
=20
+/**
+ * qtest_cb_for_every_machine:
+ * @cb: Pointer to the callback function
+ *
+ *  Call a callback function for every name of all available machines.
+ */
+void qtest_cb_for_every_machine(void (*cb)(const char *machine));
+
 #endif
diff --git a/tests/pc-cpu-test.c b/tests/pc-cpu-test.c
index c3a2633d3c..c4211a4e85 100644
--- a/tests/pc-cpu-test.c
+++ b/tests/pc-cpu-test.c
@@ -79,69 +79,46 @@ static void test_data_free(gpointer data)
     g_free(pc);
 }
=20
-static void add_pc_test_cases(void)
+static void add_pc_test_case(const char *mname)
 {
-    QDict *response, *minfo;
-    QList *list;
-    const QListEntry *p;
-    QObject *qobj;
-    QString *qstr;
-    const char *mname;
     char *path;
     PCTestData *data;
=20
-    qtest_start("-machine none");
-    response =3D qmp("{ 'execute': 'query-machines' }");
-    g_assert(response);
-    list =3D qdict_get_qlist(response, "return");
-    g_assert(list);
-
-    for (p =3D qlist_first(list); p; p =3D qlist_next(p)) {
-        minfo =3D qobject_to_qdict(qlist_entry_obj(p));
-        g_assert(minfo);
-        qobj =3D qdict_get(minfo, "name");
-        g_assert(qobj);
-        qstr =3D qobject_to_qstring(qobj);
-        g_assert(qstr);
-        mname =3D qstring_get_str(qstr);
-        if (!g_str_has_prefix(mname, "pc-")) {
-            continue;
-        }
-        data =3D g_malloc(sizeof(PCTestData));
-        data->machine =3D g_strdup(mname);
-        data->cpu_model =3D "Haswell"; /* 1.3+ theoretically */
-        data->sockets =3D 1;
-        data->cores =3D 3;
-        data->threads =3D 2;
-        data->maxcpus =3D data->sockets * data->cores * data->threads * =
2;
-        if (g_str_has_suffix(mname, "-1.4") ||
-            (strcmp(mname, "pc-1.3") =3D=3D 0) ||
-            (strcmp(mname, "pc-1.2") =3D=3D 0) ||
-            (strcmp(mname, "pc-1.1") =3D=3D 0) ||
-            (strcmp(mname, "pc-1.0") =3D=3D 0) ||
-            (strcmp(mname, "pc-0.15") =3D=3D 0) ||
-            (strcmp(mname, "pc-0.14") =3D=3D 0) ||
-            (strcmp(mname, "pc-0.13") =3D=3D 0) ||
-            (strcmp(mname, "pc-0.12") =3D=3D 0) ||
-            (strcmp(mname, "pc-0.11") =3D=3D 0) ||
-            (strcmp(mname, "pc-0.10") =3D=3D 0)) {
-            path =3D g_strdup_printf("cpu/%s/init/%ux%ux%u&maxcpus=3D%u"=
,
-                                   mname, data->sockets, data->cores,
-                                   data->threads, data->maxcpus);
-            qtest_add_data_func_full(path, data, test_pc_without_cpu_add=
,
-                                     test_data_free);
-            g_free(path);
-        } else {
-            path =3D g_strdup_printf("cpu/%s/add/%ux%ux%u&maxcpus=3D%u",
-                                   mname, data->sockets, data->cores,
-                                   data->threads, data->maxcpus);
-            qtest_add_data_func_full(path, data, test_pc_with_cpu_add,
-                                     test_data_free);
-            g_free(path);
-        }
+    if (!g_str_has_prefix(mname, "pc-")) {
+        return;
+    }
+    data =3D g_malloc(sizeof(PCTestData));
+    data->machine =3D g_strdup(mname);
+    data->cpu_model =3D "Haswell"; /* 1.3+ theoretically */
+    data->sockets =3D 1;
+    data->cores =3D 3;
+    data->threads =3D 2;
+    data->maxcpus =3D data->sockets * data->cores * data->threads * 2;
+    if (g_str_has_suffix(mname, "-1.4") ||
+        (strcmp(mname, "pc-1.3") =3D=3D 0) ||
+        (strcmp(mname, "pc-1.2") =3D=3D 0) ||
+        (strcmp(mname, "pc-1.1") =3D=3D 0) ||
+        (strcmp(mname, "pc-1.0") =3D=3D 0) ||
+        (strcmp(mname, "pc-0.15") =3D=3D 0) ||
+        (strcmp(mname, "pc-0.14") =3D=3D 0) ||
+        (strcmp(mname, "pc-0.13") =3D=3D 0) ||
+        (strcmp(mname, "pc-0.12") =3D=3D 0) ||
+        (strcmp(mname, "pc-0.11") =3D=3D 0) ||
+        (strcmp(mname, "pc-0.10") =3D=3D 0)) {
+        path =3D g_strdup_printf("cpu/%s/init/%ux%ux%u&maxcpus=3D%u",
+                               mname, data->sockets, data->cores,
+                               data->threads, data->maxcpus);
+        qtest_add_data_func_full(path, data, test_pc_without_cpu_add,
+                                 test_data_free);
+        g_free(path);
+    } else {
+        path =3D g_strdup_printf("cpu/%s/add/%ux%ux%u&maxcpus=3D%u",
+                               mname, data->sockets, data->cores,
+                               data->threads, data->maxcpus);
+        qtest_add_data_func_full(path, data, test_pc_with_cpu_add,
+                                 test_data_free);
+        g_free(path);
     }
-    QDECREF(response);
-    qtest_end();
 }
=20
 int main(int argc, char **argv)
@@ -151,7 +128,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
=20
     if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, "x86_64") =3D=3D 0=
) {
-        add_pc_test_cases();
+        qtest_cb_for_every_machine(add_pc_test_case);
     }
=20
     return g_test_run();
diff --git a/tests/qom-test.c b/tests/qom-test.c
index d48f890e84..ab0595dc75 100644
--- a/tests/qom-test.c
+++ b/tests/qom-test.c
@@ -107,46 +107,22 @@ static void test_machine(gconstpointer data)
     g_free((void *)machine);
 }
=20
-static void add_machine_test_cases(void)
+static void add_machine_test_case(const char *mname)
 {
     const char *arch =3D qtest_get_arch();
-    QDict *response, *minfo;
-    QList *list;
-    const QListEntry *p;
-    QObject *qobj;
-    QString *qstr;
-    const char *mname;
=20
-    qtest_start("-machine none");
-    response =3D qmp("{ 'execute': 'query-machines' }");
-    g_assert(response);
-    list =3D qdict_get_qlist(response, "return");
-    g_assert(list);
-
-    for (p =3D qlist_first(list); p; p =3D qlist_next(p)) {
-        minfo =3D qobject_to_qdict(qlist_entry_obj(p));
-        g_assert(minfo);
-        qobj =3D qdict_get(minfo, "name");
-        g_assert(qobj);
-        qstr =3D qobject_to_qstring(qobj);
-        g_assert(qstr);
-        mname =3D qstring_get_str(qstr);
-        if (!is_blacklisted(arch, mname)) {
-            char *path =3D g_strdup_printf("qom/%s", mname);
-            qtest_add_data_func(path, g_strdup(mname), test_machine);
-            g_free(path);
-        }
+    if (!is_blacklisted(arch, mname)) {
+        char *path =3D g_strdup_printf("qom/%s", mname);
+        qtest_add_data_func(path, g_strdup(mname), test_machine);
+        g_free(path);
     }
-
-    qtest_end();
-    QDECREF(response);
 }
=20
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
=20
-    add_machine_test_cases();
+    qtest_cb_for_every_machine(add_machine_test_case);
=20
     return g_test_run();
 }
--=20
2.12.2
