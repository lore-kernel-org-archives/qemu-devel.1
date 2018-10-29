Received: from eggs.gnu.org ([2001:4830:134:3::10]:34007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gH9Kv-0007ry-Pm
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gH9Kq-00032o-JP
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gH9Kq-000311-50
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:08 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9TFJGVb037595
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 11:20:05 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ne3asd11d-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 11:20:04 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Mon, 29 Oct 2018 11:20:03 -0400
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Mon, 29 Oct 2018 11:19:52 -0400
In-Reply-To: <20181029151956.2164336-1-stefanb@linux.ibm.com>
References: <20181029151956.2164336-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20181029151956.2164336-2-stefanb@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 1/5] tests/tpm: fix tpm_util_swtpm_has_tpm2()
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

Using g_spawn_async_with_pipes() is more complicated than running the
sync version. The async version returns a file descriptor for stdout, whi=
ch may
not be fully read. Sometime "--tpm2" will failed to be read, and will
cause the related test to be silently skipped.

Use g_spawn_sync() instead, simplifying the code and fixing the race.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 tests/tpm-util.c | 46 ++++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/tests/tpm-util.c b/tests/tpm-util.c
index 9f3f156e42..ae4aaf35ca 100644
--- a/tests/tpm-util.c
+++ b/tests/tpm-util.c
@@ -145,39 +145,33 @@ void tpm_util_pcrread(QTestState *s, tx_func *tx,
     g_assert_cmpmem(buffer, exp_resp_size, exp_resp, exp_resp_size);
 }
=20
-static gboolean tpm_util_swtpm_has_tpm2(void)
+static bool tpm_util_swtpm_has_tpm2(void)
 {
-    gint mystdout;
-    gboolean succ;
-    unsigned i;
-    char buffer[10240];
-    ssize_t n;
-    gchar *swtpm_argv[] =3D {
-        g_strdup("swtpm"), g_strdup("socket"), g_strdup("--help"), NULL
+    bool has_tpm2 =3D false;
+    char *out =3D NULL;
+    static const char *argv[] =3D {
+        "swtpm", "socket", "--help", NULL
     };
=20
-    succ =3D g_spawn_async_with_pipes(NULL, swtpm_argv, NULL,
-                                    G_SPAWN_SEARCH_PATH, NULL, NULL, NUL=
L,
-                                    NULL, &mystdout, NULL, NULL);
-    if (!succ) {
-        goto cleanup;
+    if (!g_spawn_sync(NULL /* working_dir */,
+                      (char **)argv,
+                      NULL /* envp */,
+                      G_SPAWN_SEARCH_PATH,
+                      NULL /* child_setup */,
+                      NULL /* user_data */,
+                      &out,
+                      NULL /* err */,
+                      NULL /* exit_status */,
+                      NULL)) {
+        return false;
     }
=20
-    n =3D read(mystdout, buffer, sizeof(buffer) - 1);
-    if (n < 0) {
-        goto cleanup;
-    }
-    buffer[n] =3D 0;
-    if (!strstr(buffer, "--tpm2")) {
-        succ =3D false;
-    }
-
- cleanup:
-    for (i =3D 0; swtpm_argv[i]; i++) {
-        g_free(swtpm_argv[i]);
+    if (strstr(out, "--tpm2")) {
+        has_tpm2 =3D true;
     }
=20
-    return succ;
+    g_free(out);
+    return has_tpm2;
 }
=20
 gboolean tpm_util_swtpm_start(const char *path, GPid *pid,
--=20
2.17.1
