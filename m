Received: from eggs.gnu.org ([2001:4830:134:3::10]:49141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fQeZe-0008BZ-Cp
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fQeZa-0002BB-WC
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:58:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46896
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fQeZa-0002As-Pw
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:58:22 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w56Jnt6q126568
	for <qemu-devel@nongnu.org>; Wed, 6 Jun 2018 15:58:22 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jenhj9m1e-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 15:58:21 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 6 Jun 2018 13:58:21 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed,  6 Jun 2018 15:58:04 -0400
In-Reply-To: <20180606195805.185833-1-stefanb@linux.vnet.ibm.com>
References: <20180606195805.185833-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180606195805.185833-4-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 3/4] test: Pass TPM interface model to
 functions creating command line
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

Pass the TPM interface model, such as 'tpm-crb', through to the functions
that create the command line for QEMU.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/tpm-crb-swtpm-test.c |  4 ++--
 tests/tpm-tests.c          | 13 ++++++++-----
 tests/tpm-tests.h          |  6 ++++--
 tests/tpm-util.c           | 11 ++++++-----
 tests/tpm-util.h           |  3 ++-
 5 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/tests/tpm-crb-swtpm-test.c b/tests/tpm-crb-swtpm-test.c
index 4acffff568..8c0a55f3ca 100644
--- a/tests/tpm-crb-swtpm-test.c
+++ b/tests/tpm-crb-swtpm-test.c
@@ -28,7 +28,7 @@ static void tpm_crb_swtpm_test(const void *data)
 {
     const TestState *ts =3D data;
=20
-    tpm_test_swtpm_test(ts->src_tpm_path, tpm_util_crb_transfer);
+    tpm_test_swtpm_test(ts->src_tpm_path, tpm_util_crb_transfer, "tpm-cr=
b");
 }
=20
 static void tpm_crb_swtpm_migration_test(const void *data)
@@ -36,7 +36,7 @@ static void tpm_crb_swtpm_migration_test(const void *da=
ta)
     const TestState *ts =3D data;
=20
     tpm_test_swtpm_migration_test(ts->src_tpm_path, ts->dst_tpm_path, ts=
->uri,
-                                  tpm_util_crb_transfer);
+                                  tpm_util_crb_transfer, "tpm-crb");
 }
=20
 int main(int argc, char **argv)
diff --git a/tests/tpm-tests.c b/tests/tpm-tests.c
index adf2c618c8..10c6592aac 100644
--- a/tests/tpm-tests.c
+++ b/tests/tpm-tests.c
@@ -18,7 +18,8 @@
 #include "libqtest.h"
 #include "tpm-tests.h"
=20
-void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx)
+void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx,
+                         const char *ifmodel)
 {
     char *args =3D NULL;
     QTestState *s;
@@ -36,8 +37,8 @@ void tpm_test_swtpm_test(const char *src_tpm_path, tx_f=
unc *tx)
     args =3D g_strdup_printf(
         "-chardev socket,id=3Dchr,path=3D%s "
         "-tpmdev emulator,id=3Ddev,chardev=3Dchr "
-        "-device tpm-crb,tpmdev=3Ddev",
-        addr->u.q_unix.path);
+        "-device %s,tpmdev=3Ddev",
+        addr->u.q_unix.path, ifmodel);
=20
     s =3D qtest_start(args);
     g_free(args);
@@ -64,7 +65,8 @@ void tpm_test_swtpm_test(const char *src_tpm_path, tx_f=
unc *tx)
=20
 void tpm_test_swtpm_migration_test(const char *src_tpm_path,
                                    const char *dst_tpm_path,
-                                   const char *uri, tx_func *tx)
+                                   const char *uri, tx_func *tx,
+                                   const char *ifmodel)
 {
     gboolean succ;
     GPid src_tpm_pid, dst_tpm_pid;
@@ -87,7 +89,8 @@ void tpm_test_swtpm_migration_test(const char *src_tpm_=
path,
     }
=20
     tpm_util_migration_start_qemu(&src_qemu, &dst_qemu,
-                                  src_tpm_addr, dst_tpm_addr, uri);
+                                  src_tpm_addr, dst_tpm_addr, uri,
+                                  ifmodel);
=20
     tpm_util_startup(src_qemu, tx);
     tpm_util_pcrextend(src_qemu, tx);
diff --git a/tests/tpm-tests.h b/tests/tpm-tests.h
index 377f184c77..b97688fe75 100644
--- a/tests/tpm-tests.h
+++ b/tests/tpm-tests.h
@@ -15,10 +15,12 @@
=20
 #include "tpm-util.h"
=20
-void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx);
+void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx,
+                         const char *ifmodel);
=20
 void tpm_test_swtpm_migration_test(const char *src_tpm_path,
                                    const char *dst_tpm_path,
-                                   const char *uri, tx_func *tx);
+                                   const char *uri, tx_func *tx,
+                                   const char *ifmodel);
=20
 #endif /* TESTS_TPM_TESTS_H */
diff --git a/tests/tpm-util.c b/tests/tpm-util.c
index e6e3b922fa..e1ac4d1bd5 100644
--- a/tests/tpm-util.c
+++ b/tests/tpm-util.c
@@ -248,25 +248,26 @@ void tpm_util_migration_start_qemu(QTestState **src=
_qemu,
                                    QTestState **dst_qemu,
                                    SocketAddress *src_tpm_addr,
                                    SocketAddress *dst_tpm_addr,
-                                   const char *miguri)
+                                   const char *miguri,
+                                   const char *ifmodel)
 {
     char *src_qemu_args, *dst_qemu_args;
=20
     src_qemu_args =3D g_strdup_printf(
         "-chardev socket,id=3Dchr,path=3D%s "
         "-tpmdev emulator,id=3Ddev,chardev=3Dchr "
-        "-device tpm-crb,tpmdev=3Ddev ",
-        src_tpm_addr->u.q_unix.path);
+        "-device %s,tpmdev=3Ddev ",
+        src_tpm_addr->u.q_unix.path, ifmodel);
=20
     *src_qemu =3D qtest_init(src_qemu_args);
=20
     dst_qemu_args =3D g_strdup_printf(
         "-chardev socket,id=3Dchr,path=3D%s "
         "-tpmdev emulator,id=3Ddev,chardev=3Dchr "
-        "-device tpm-crb,tpmdev=3Ddev "
+        "-device %s,tpmdev=3Ddev "
         "-incoming %s",
         dst_tpm_addr->u.q_unix.path,
-        miguri);
+        ifmodel, miguri);
=20
     *dst_qemu =3D qtest_init(dst_qemu_args);
=20
diff --git a/tests/tpm-util.h b/tests/tpm-util.h
index b6253106d9..bb128360dd 100644
--- a/tests/tpm-util.h
+++ b/tests/tpm-util.h
@@ -39,7 +39,8 @@ void tpm_util_migration_start_qemu(QTestState **src_qem=
u,
                                    QTestState **dst_qemu,
                                    SocketAddress *src_tpm_addr,
                                    SocketAddress *dst_tpm_addr,
-                                   const char *miguri);
+                                   const char *miguri,
+                                   const char *ifmodel);
=20
 void tpm_util_wait_for_migration_complete(QTestState *who);
=20
--=20
2.14.4
