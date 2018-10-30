Received: from eggs.gnu.org ([2001:4830:134:3::10]:40715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gHcZ1-0003rG-N8
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 18:32:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gHcYw-00035x-5x
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 18:32:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1gHbsd-0006ZE-1f
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:48:55 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9ULi6C7048928
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 17:48:54 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2neun31ubw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 17:48:53 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 30 Oct 2018 15:48:53 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 30 Oct 2018 17:47:37 -0400
In-Reply-To: <20181030214740.2294043-1-stefanb@linux.vnet.ibm.com>
References: <20181030214740.2294043-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20181030214740.2294043-3-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 2/5] tests/tpm: Display if swtpm is not found
 or --tpm2 not supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

If swtpm is not found in $PATH or --tpm2 isn't supported, we display
this in the test log. We cannot mark the test as skipped due to a bug in
certain versions of the gtester environment that interprets a skipped tes=
t
as failure.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 tests/tpm-tests.c | 33 +++++++++++++++++++++------------
 tests/tpm-util.c  |  8 +-------
 tests/tpm-util.h  |  2 ++
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/tests/tpm-tests.c b/tests/tpm-tests.c
index 10c6592aac..93a5beba01 100644
--- a/tests/tpm-tests.c
+++ b/tests/tpm-tests.c
@@ -18,6 +18,17 @@
 #include "libqtest.h"
 #include "tpm-tests.h"
=20
+static bool
+tpm_test_swtpm_skip(void)
+{
+    if (!tpm_util_swtpm_has_tpm2()) {
+        fprintf(stderr, "swtpm not in PATH or missing --tpm2 support; ")=
;
+        return true;
+    }
+
+    return false;
+}
+
 void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx,
                          const char *ifmodel)
 {
@@ -28,12 +39,13 @@ void tpm_test_swtpm_test(const char *src_tpm_path, tx=
_func *tx,
     GPid swtpm_pid;
     GError *error =3D NULL;
=20
-    succ =3D tpm_util_swtpm_start(src_tpm_path, &swtpm_pid, &addr, &erro=
r);
-    /* succ may be false if swtpm is not available */
-    if (!succ) {
+    if (tpm_test_swtpm_skip()) {
         return;
     }
=20
+    succ =3D tpm_util_swtpm_start(src_tpm_path, &swtpm_pid, &addr, &erro=
r);
+    g_assert_true(succ);
+
     args =3D g_strdup_printf(
         "-chardev socket,id=3Dchr,path=3D%s "
         "-tpmdev emulator,id=3Ddev,chardev=3Dchr "
@@ -74,19 +86,17 @@ void tpm_test_swtpm_migration_test(const char *src_tp=
m_path,
     GError *error =3D NULL;
     QTestState *src_qemu, *dst_qemu;
=20
-    succ =3D tpm_util_swtpm_start(src_tpm_path, &src_tpm_pid,
-                                &src_tpm_addr, &error);
-    /* succ may be false if swtpm is not available */
-    if (!succ) {
+    if (tpm_test_swtpm_skip()) {
         return;
     }
=20
+    succ =3D tpm_util_swtpm_start(src_tpm_path, &src_tpm_pid,
+                                &src_tpm_addr, &error);
+    g_assert_true(succ);
+
     succ =3D tpm_util_swtpm_start(dst_tpm_path, &dst_tpm_pid,
                                 &dst_tpm_addr, &error);
-    /* succ may be false if swtpm is not available */
-    if (!succ) {
-        goto err_src_tpm_kill;
-    }
+    g_assert_true(succ);
=20
     tpm_util_migration_start_qemu(&src_qemu, &dst_qemu,
                                   src_tpm_addr, dst_tpm_addr, uri,
@@ -118,7 +128,6 @@ void tpm_test_swtpm_migration_test(const char *src_tp=
m_path,
         qapi_free_SocketAddress(dst_tpm_addr);
     }
=20
-err_src_tpm_kill:
     tpm_util_swtpm_kill(src_tpm_pid);
     if (src_tpm_addr) {
         g_unlink(src_tpm_addr->u.q_unix.path);
diff --git a/tests/tpm-util.c b/tests/tpm-util.c
index ae4aaf35ca..e08b137651 100644
--- a/tests/tpm-util.c
+++ b/tests/tpm-util.c
@@ -145,7 +145,7 @@ void tpm_util_pcrread(QTestState *s, tx_func *tx,
     g_assert_cmpmem(buffer, exp_resp_size, exp_resp, exp_resp_size);
 }
=20
-static bool tpm_util_swtpm_has_tpm2(void)
+bool tpm_util_swtpm_has_tpm2(void)
 {
     bool has_tpm2 =3D false;
     char *out =3D NULL;
@@ -190,11 +190,6 @@ gboolean tpm_util_swtpm_start(const char *path, GPid=
 *pid,
     gboolean succ;
     unsigned i;
=20
-    succ =3D tpm_util_swtpm_has_tpm2();
-    if (!succ) {
-        goto cleanup;
-    }
-
     *addr =3D g_new0(SocketAddress, 1);
     (*addr)->type =3D SOCKET_ADDRESS_TYPE_UNIX;
     (*addr)->u.q_unix.path =3D g_build_filename(path, "sock", NULL);
@@ -202,7 +197,6 @@ gboolean tpm_util_swtpm_start(const char *path, GPid =
*pid,
     succ =3D g_spawn_async(NULL, swtpm_argv, NULL, G_SPAWN_SEARCH_PATH,
                          NULL, NULL, pid, error);
=20
-cleanup:
     for (i =3D 0; swtpm_argv[i]; i++) {
         g_free(swtpm_argv[i]);
     }
diff --git a/tests/tpm-util.h b/tests/tpm-util.h
index 330b9657fe..9e98bc5124 100644
--- a/tests/tpm-util.h
+++ b/tests/tpm-util.h
@@ -32,6 +32,8 @@ void tpm_util_pcrextend(QTestState *s, tx_func *tx);
 void tpm_util_pcrread(QTestState *s, tx_func *tx,
                       const unsigned char *exp_resp, size_t exp_resp_siz=
e);
=20
+bool tpm_util_swtpm_has_tpm2(void);
+
 gboolean tpm_util_swtpm_start(const char *path, GPid *pid,
                               SocketAddress **addr, GError **error);
 void tpm_util_swtpm_kill(GPid pid);
--=20
2.17.1
