Received: from eggs.gnu.org ([2001:4830:134:3::10]:49084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gX1Uh-0000vh-Pb
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:11:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gX1Ug-0003R2-Tb
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:11:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gX1Ug-0003QI-Ju
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:11:54 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F21352D7E0
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 10:11:53 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 12 Dec 2018 11:11:44 +0100
Message-Id: <20181212101145.3496-11-armbru@redhat.com>
In-Reply-To: <20181212101145.3496-1-armbru@redhat.com>
References: <20181212101145.3496-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/11] Revert "tests: Add parameter to
 qtest_init_without_qmp_handshake"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

This reverts commit ddee57e0176f6ab53b13c6c97605b62737a8fd7a.

Meanwhile, revert one line from fa198ad9bdef to make sure
qtest_init_without_qmp_handshake() will only pass in one parameter.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20181009062718.1914-5-peterx@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/libqtest.c | 9 ++++-----
 tests/libqtest.h | 4 +---
 tests/qmp-test.c | 4 ++--
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 225a123649..43be078518 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -187,8 +187,7 @@ static const char *qtest_qemu_binary(void)
     return qemu_bin;
 }
=20
-QTestState *qtest_init_without_qmp_handshake(bool use_oob,
-                                             const char *extra_args)
+QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
 {
     QTestState *s;
     int sock, qmpsock, i;
@@ -219,12 +218,12 @@ QTestState *qtest_init_without_qmp_handshake(bool u=
se_oob,
                               "-qtest unix:%s,nowait "
                               "-qtest-log %s "
                               "-chardev socket,path=3D%s,nowait,id=3Dcha=
r0 "
-                              "-mon chardev=3Dchar0,mode=3Dcontrol%s "
+                              "-mon chardev=3Dchar0,mode=3Dcontrol "
                               "-machine accel=3Dqtest "
                               "-display none "
                               "%s", qemu_binary, socket_path,
                               getenv("QTEST_LOG") ? "/dev/fd/2" : "/dev/=
null",
-                              qmp_socket_path, "",
+                              qmp_socket_path,
                               extra_args ?: "");
=20
     g_test_message("starting QEMU: %s", command);
@@ -266,7 +265,7 @@ QTestState *qtest_init_without_qmp_handshake(bool use=
_oob,
=20
 QTestState *qtest_init(const char *extra_args)
 {
-    QTestState *s =3D qtest_init_without_qmp_handshake(false, extra_args=
);
+    QTestState *s =3D qtest_init_without_qmp_handshake(extra_args);
     QDict *greeting;
=20
     /* Read the QMP greeting and then do the handshake */
diff --git a/tests/libqtest.h b/tests/libqtest.h
index ed88ff99d5..96a6c01352 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -55,14 +55,12 @@ QTestState *qtest_init(const char *extra_args);
=20
 /**
  * qtest_init_without_qmp_handshake:
- * @use_oob: true to have the server advertise OOB support
  * @extra_args: other arguments to pass to QEMU.  CAUTION: these
  * arguments are subject to word splitting and shell evaluation.
  *
  * Returns: #QTestState instance.
  */
-QTestState *qtest_init_without_qmp_handshake(bool use_oob,
-                                             const char *extra_args);
+QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
=20
 /**
  * qtest_quit:
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 5ba22af6a0..48a4fa791a 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -108,7 +108,7 @@ static void test_qmp_protocol(void)
     QList *capabilities;
     QTestState *qts;
=20
-    qts =3D qtest_init_without_qmp_handshake(false, common_args);
+    qts =3D qtest_init_without_qmp_handshake(common_args);
=20
     /* Test greeting */
     resp =3D qtest_qmp_receive(qts);
@@ -219,7 +219,7 @@ static void test_qmp_oob(void)
     QList *capabilities;
     QString *qstr;
=20
-    qts =3D qtest_init_without_qmp_handshake(true, common_args);
+    qts =3D qtest_init_without_qmp_handshake(common_args);
=20
     /* Check the greeting message. */
     resp =3D qtest_qmp_receive(qts);
--=20
2.17.2
