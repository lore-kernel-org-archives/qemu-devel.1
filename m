Received: from eggs.gnu.org ([2001:4830:134:3::10]:56558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Mt-0002dr-G2
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:37:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Mo-00013T-1r
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:37:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47391)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9Mn-00013B-S2
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:37:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A3FD267C4
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 13:27:51 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:53 +0200
Message-Id: <20170822132255.23945-53-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 52/54] qapi: make query-gic-capabilities
 depend on TARGET_ARM
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
 monitor.c        | 11 -----------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index d4e1552ddc..6c1adb35b5 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -6461,7 +6461,8 @@
 #                 { "version": 3, "emulated": false, "kernel": true } ] =
}
 #
 ##
-{ 'command': 'query-gic-capabilities', 'returns': ['GICCapability'] }
+{ 'command': 'query-gic-capabilities', 'returns': ['GICCapability'],
+  'if': ['defined(NEED_CPU_H)', 'defined(TARGET_ARM)']}
=20
 ##
 # @CpuInstanceProperties:
diff --git a/monitor.c b/monitor.c
index c9f04652b4..6ddc3c7ff7 100644
--- a/monitor.c
+++ b/monitor.c
@@ -971,9 +971,6 @@ static void qmp_query_qmp_schema(QDict *qdict, QObjec=
t **ret_data,
  */
 static void qmp_unregister_commands_hack(void)
 {
-#ifndef TARGET_ARM
-    qmp_unregister_command(&qmp_commands, "query-gic-capabilities");
-#endif
 #if !defined(TARGET_S390X) && !defined(TARGET_I386)
     qmp_unregister_command(&qmp_commands, "query-cpu-model-expansion");
 #endif
@@ -4146,14 +4143,6 @@ QemuOptsList qemu_mon_opts =3D {
     },
 };
=20
-#ifndef TARGET_ARM
-GICCapabilityList *qmp_query_gic_capabilities(Error **errp)
-{
-    error_setg(errp, QERR_FEATURE_DISABLED, "query-gic-capabilities");
-    return NULL;
-}
-#endif
-
 HotpluggableCPUList *qmp_query_hotpluggable_cpus(Error **errp)
 {
     MachineState *ms =3D MACHINE(qdev_get_machine());
--=20
2.14.1.146.gd35faa819
