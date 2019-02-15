Received: from eggs.gnu.org ([209.51.188.92]:44082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1guhYz-000647-DF
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:46:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1guhYy-0002H5-2l
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:46:13 -0500
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:55762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1guhYx-0002GI-NL
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:46:12 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
Date: Fri, 15 Feb 2019 20:45:47 +0300
Message-Id: <20190215174548.2630-5-yury-kotov@yandex-team.ru>
In-Reply-To: <20190215174548.2630-1-yury-kotov@yandex-team.ru>
References: <20190215174548.2630-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 4/5] tests/migration-test: Add a test for
 ignore-shared capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: wrfsh@yandex-team.ru, jiangshanlai@gmail.com, qemu-devel@lists.ewheeler.net, peter.maydell@linaro.org

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 tests/migration-test.c | 131 +++++++++++++++++++++++++++++++++--------
 1 file changed, 106 insertions(+), 25 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 8352612364..dd604c4f21 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -215,10 +215,10 @@ static gchar *migrate_query_status(QTestState *who)
  * events suddenly appearing confuse the qmp()/hmp() responses.
  */
=20
-static uint64_t get_migration_pass(QTestState *who)
+static int64_t read_ram_property_int(QTestState *who, const char *proper=
ty)
 {
     QDict *rsp_return, *rsp_ram;
-    uint64_t result;
+    int64_t result;
=20
     rsp_return =3D migrate_query(who);
     if (!qdict_haskey(rsp_return, "ram")) {
@@ -226,12 +226,17 @@ static uint64_t get_migration_pass(QTestState *who)
         result =3D 0;
     } else {
         rsp_ram =3D qdict_get_qdict(rsp_return, "ram");
-        result =3D qdict_get_try_int(rsp_ram, "dirty-sync-count", 0);
+        result =3D qdict_get_try_int(rsp_ram, property, 0);
     }
     qobject_unref(rsp_return);
     return result;
 }
=20
+static uint64_t get_migration_pass(QTestState *who)
+{
+    return read_ram_property_int(who, "dirty-sync-count");
+}
+
 static void read_blocktime(QTestState *who)
 {
     QDict *rsp_return;
@@ -332,6 +337,13 @@ static void cleanup(const char *filename)
     g_free(path);
 }
=20
+static char *get_shmem_opts(const char *mem_size, const char *shmem_path=
)
+{
+    return g_strdup_printf("-object memory-backend-file,id=3Dmem0,size=3D=
%s"
+                           ",mem-path=3D%s,share=3Don -numa node,memdev=3D=
mem0",
+                           mem_size, shmem_path);
+}
+
 static void migrate_check_parameter(QTestState *who, const char *paramet=
er,
                                     long long value)
 {
@@ -430,73 +442,95 @@ static void migrate_postcopy_start(QTestState *from=
, QTestState *to)
 }
=20
 static int test_migrate_start(QTestState **from, QTestState **to,
-                               const char *uri, bool hide_stderr)
+                               const char *uri, bool hide_stderr,
+                               bool use_shmem)
 {
     gchar *cmd_src, *cmd_dst;
-    char *bootpath =3D g_strdup_printf("%s/bootsect", tmpfs);
+    char *bootpath =3D NULL;
+    char *extra_opts =3D NULL;
+    char *shmem_path =3D NULL;
     const char *arch =3D qtest_get_arch();
     const char *accel =3D "kvm:tcg";
=20
-    got_stop =3D false;
+    if (use_shmem) {
+        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
+            g_test_skip("/dev/shm is not supported");
+            return -1;
+        }
+        shmem_path =3D g_strdup_printf("/dev/shm/qemu-%d", getpid());
+    }
=20
+    got_stop =3D false;
+    bootpath =3D g_strdup_printf("%s/bootsect", tmpfs);
     if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, "x86_64") =3D=3D 0=
) {
         init_bootfile(bootpath, x86_bootsect);
+        extra_opts =3D use_shmem ? get_shmem_opts("150M", shmem_path) : =
NULL;
         cmd_src =3D g_strdup_printf("-machine accel=3D%s -m 150M"
                                   " -name source,debug-threads=3Don"
                                   " -serial file:%s/src_serial"
-                                  " -drive file=3D%s,format=3Draw",
-                                  accel, tmpfs, bootpath);
+                                  " -drive file=3D%s,format=3Draw %s",
+                                  accel, tmpfs, bootpath,
+                                  extra_opts ? extra_opts : "");
         cmd_dst =3D g_strdup_printf("-machine accel=3D%s -m 150M"
                                   " -name target,debug-threads=3Don"
                                   " -serial file:%s/dest_serial"
                                   " -drive file=3D%s,format=3Draw"
-                                  " -incoming %s",
-                                  accel, tmpfs, bootpath, uri);
+                                  " -incoming %s %s",
+                                  accel, tmpfs, bootpath, uri,
+                                  extra_opts ? extra_opts : "");
         start_address =3D X86_TEST_MEM_START;
         end_address =3D X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
         init_bootfile_s390x(bootpath);
+        extra_opts =3D use_shmem ? get_shmem_opts("128M", shmem_path) : =
NULL;
         cmd_src =3D g_strdup_printf("-machine accel=3D%s -m 128M"
                                   " -name source,debug-threads=3Don"
-                                  " -serial file:%s/src_serial -bios %s"=
,
-                                  accel, tmpfs, bootpath);
+                                  " -serial file:%s/src_serial -bios %s =
%s",
+                                  accel, tmpfs, bootpath,
+                                  extra_opts ? extra_opts : "");
         cmd_dst =3D g_strdup_printf("-machine accel=3D%s -m 128M"
                                   " -name target,debug-threads=3Don"
                                   " -serial file:%s/dest_serial -bios %s=
"
-                                  " -incoming %s",
-                                  accel, tmpfs, bootpath, uri);
+                                  " -incoming %s %s",
+                                  accel, tmpfs, bootpath, uri,
+                                  extra_opts ? extra_opts : "");
         start_address =3D S390_TEST_MEM_START;
         end_address =3D S390_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") =3D=3D 0) {
+        extra_opts =3D use_shmem ? get_shmem_opts("256M", shmem_path) : =
NULL;
         cmd_src =3D g_strdup_printf("-machine accel=3D%s -m 256M -nodefa=
ults"
                                   " -name source,debug-threads=3Don"
                                   " -serial file:%s/src_serial"
                                   " -prom-env 'use-nvramrc?=3Dtrue' -pro=
m-env "
                                   "'nvramrc=3Dhex .\" _\" begin %x %x "
                                   "do i c@ 1 + i c! 1000 +loop .\" B\" 0=
 "
-                                  "until'",  accel, tmpfs, end_address,
-                                  start_address);
+                                  "until' %s",  accel, tmpfs, end_addres=
s,
+                                  start_address, extra_opts ? extra_opts=
 : "");
         cmd_dst =3D g_strdup_printf("-machine accel=3D%s -m 256M"
                                   " -name target,debug-threads=3Don"
                                   " -serial file:%s/dest_serial"
-                                  " -incoming %s",
-                                  accel, tmpfs, uri);
+                                  " -incoming %s %s",
+                                  accel, tmpfs, uri,
+                                  extra_opts ? extra_opts : "");
=20
         start_address =3D PPC_TEST_MEM_START;
         end_address =3D PPC_TEST_MEM_END;
     } else if (strcmp(arch, "aarch64") =3D=3D 0) {
         init_bootfile(bootpath, aarch64_kernel);
+        extra_opts =3D use_shmem ? get_shmem_opts("150M", shmem_path) : =
NULL;
         cmd_src =3D g_strdup_printf("-machine virt,accel=3D%s,gic-versio=
n=3Dmax "
                                   "-name vmsource,debug-threads=3Don -cp=
u max "
                                   "-m 150M -serial file:%s/src_serial "
-                                  "-kernel %s ",
-                                  accel, tmpfs, bootpath);
+                                  "-kernel %s %s",
+                                  accel, tmpfs, bootpath,
+                                  extra_opts ? extra_opts : "");
         cmd_dst =3D g_strdup_printf("-machine virt,accel=3D%s,gic-versio=
n=3Dmax "
                                   "-name vmdest,debug-threads=3Don -cpu =
max "
                                   "-m 150M -serial file:%s/dest_serial "
                                   "-kernel %s "
-                                  "-incoming %s ",
-                                  accel, tmpfs, bootpath, uri);
+                                  "-incoming %s %s",
+                                  accel, tmpfs, bootpath, uri,
+                                  extra_opts ? extra_opts : "");
=20
         start_address =3D ARM_TEST_MEM_START;
         end_address =3D ARM_TEST_MEM_END;
@@ -507,6 +541,7 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
     }
=20
     g_free(bootpath);
+    g_free(extra_opts);
=20
     if (hide_stderr) {
         gchar *tmp;
@@ -524,6 +559,16 @@ static int test_migrate_start(QTestState **from, QTe=
stState **to,
=20
     *to =3D qtest_init(cmd_dst);
     g_free(cmd_dst);
+
+    /*
+     * Remove shmem file immediately to avoid memory leak in test failed=
 case.
+     * It's valid becase QEMU has already opened this file
+     */
+    if (use_shmem) {
+        unlink(shmem_path);
+        g_free(shmem_path);
+    }
+
     return 0;
 }
=20
@@ -603,7 +648,7 @@ static int migrate_postcopy_prepare(QTestState **from=
_ptr,
     char *uri =3D g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
=20
-    if (test_migrate_start(&from, &to, uri, hide_error)) {
+    if (test_migrate_start(&from, &to, uri, hide_error, false)) {
         return -1;
     }
=20
@@ -720,7 +765,7 @@ static void test_baddest(void)
     char *status;
     bool failed;
=20
-    if (test_migrate_start(&from, &to, "tcp:0:0", true)) {
+    if (test_migrate_start(&from, &to, "tcp:0:0", true, false)) {
         return;
     }
     migrate(from, "tcp:0:0", "{}");
@@ -745,7 +790,7 @@ static void test_precopy_unix(void)
     char *uri =3D g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
=20
-    if (test_migrate_start(&from, &to, uri, false)) {
+    if (test_migrate_start(&from, &to, uri, false, false)) {
         return;
     }
=20
@@ -781,6 +826,41 @@ static void test_precopy_unix(void)
     g_free(uri);
 }
=20
+static void test_ignore_shared(void)
+{
+    char *uri =3D g_strdup_printf("unix:%s/migsocket", tmpfs);
+    QTestState *from, *to;
+
+    if (test_migrate_start(&from, &to, uri, false, true)) {
+        return;
+    }
+
+    migrate_set_capability(from, "x-ignore-shared", true);
+    migrate_set_capability(to, "x-ignore-shared", true);
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    migrate(from, uri, "{}");
+
+    wait_for_migration_pass(from);
+
+    if (!got_stop) {
+        qtest_qmp_eventwait(from, "STOP");
+    }
+
+    qtest_qmp_eventwait(to, "RESUME");
+
+    wait_for_serial("dest_serial");
+    wait_for_migration_complete(from);
+
+    /* Check whether shared RAM has been really skipped */
+    g_assert_cmpint(read_ram_property_int(from, "transferred"), <, 1024 =
* 1024);
+
+    test_migrate_end(from, to, true);
+    g_free(uri);
+}
+
 int main(int argc, char **argv)
 {
     char template[] =3D "/tmp/migration-test-XXXXXX";
@@ -832,6 +912,7 @@ int main(int argc, char **argv)
     qtest_add_func("/migration/deprecated", test_deprecated);
     qtest_add_func("/migration/bad_dest", test_baddest);
     qtest_add_func("/migration/precopy/unix", test_precopy_unix);
+    qtest_add_func("/migration/ignore_shared", test_ignore_shared);
=20
     ret =3D g_test_run();
=20
--=20
2.20.1
