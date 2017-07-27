Received: from eggs.gnu.org ([2001:4830:134:3::10]:55684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dal1W-0005AW-3C
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dal1V-0004PT-3e
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:48:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dal1U-0004Or-Tr
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:48:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA64919D4D1
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 15:42:33 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 27 Jul 2017 17:41:22 +0200
Message-Id: <20170727154126.11339-23-marcandre.lureau@redhat.com>
In-Reply-To: <20170727154126.11339-1-marcandre.lureau@redhat.com>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 22/26] qapi: make rtc-reset-reinjection depend
 on TARGET_I386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi-schema.json |  3 ++-
 monitor.c        | 10 ----------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 2f4528c769..2361c13fc8 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -6270,7 +6270,8 @@
 # <- { "return": {} }
 #
 ##
-{ 'command': 'rtc-reset-reinjection' }
+{ 'command': 'rtc-reset-reinjection',
+  'if': ['defined(NEED_CPU_H)', 'defined(TARGET_I386)'] }
=20
 # Rocker ethernet network switch
 { 'include': 'qapi/rocker.json' }
diff --git a/monitor.c b/monitor.c
index 383c84d162..f3dafafa22 100644
--- a/monitor.c
+++ b/monitor.c
@@ -970,9 +970,6 @@ static void qmp_query_qmp_schema(QDict *qdict, QObjec=
t **ret_data,
  */
 static void qmp_unregister_commands_hack(void)
 {
-#ifndef TARGET_I386
-    qmp_unregister_command(&qmp_commands, "rtc-reset-reinjection");
-#endif
 #ifndef TARGET_S390X
     qmp_unregister_command(&qmp_commands, "dump-skeys");
 #endif
@@ -4151,13 +4148,6 @@ QemuOptsList qemu_mon_opts =3D {
     },
 };
=20
-#ifndef TARGET_I386
-void qmp_rtc_reset_reinjection(Error **errp)
-{
-    error_setg(errp, QERR_FEATURE_DISABLED, "rtc-reset-reinjection");
-}
-#endif
-
 #ifndef TARGET_S390X
 void qmp_dump_skeys(const char *filename, Error **errp)
 {
--=20
2.14.0.rc0.1.g40ca67566
