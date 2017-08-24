Received: from eggs.gnu.org ([2001:4830:134:3::10]:37164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dknmP-0003PU-6w
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dknmN-0000PC-LJ
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dknmN-0000OZ-Ej
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:19 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Aug 2017 10:46:00 +0200
Message-Id: <1503564371-26090-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1503564371-26090-1-git-send-email-armbru@redhat.com>
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 05/16] hmp: Use qapi_enum_parse() in
 hmp_migrate_set_capability()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The error message on invalid capability name changes from

    Invalid parameter "NAME"

to

    invalid parameter value: NAME

No worse than before.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170822132255.23945-9-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Rebased, commit message rewritten]
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hmp.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/hmp.c b/hmp.c
index 03c1a78..7e0bd3d 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1527,23 +1527,20 @@ void hmp_migrate_set_capability(Monitor *mon, con=
st QDict *qdict)
     bool state =3D qdict_get_bool(qdict, "state");
     Error *err =3D NULL;
     MigrationCapabilityStatusList *caps =3D g_malloc0(sizeof(*caps));
-    int i;
+    int val;
=20
-    for (i =3D 0; i < MIGRATION_CAPABILITY__MAX; i++) {
-        if (strcmp(cap, MigrationCapability_lookup[i]) =3D=3D 0) {
-            caps->value =3D g_malloc0(sizeof(*caps->value));
-            caps->value->capability =3D i;
-            caps->value->state =3D state;
-            caps->next =3D NULL;
-            qmp_migrate_set_capabilities(caps, &err);
-            break;
-        }
+    val =3D qapi_enum_parse(MigrationCapability_lookup, cap, -1, &err);
+    if (val < 0) {
+        goto end;
     }
=20
-    if (i =3D=3D MIGRATION_CAPABILITY__MAX) {
-        error_setg(&err, QERR_INVALID_PARAMETER, cap);
-    }
+    caps->value =3D g_malloc0(sizeof(*caps->value));
+    caps->value->capability =3D val;
+    caps->value->state =3D state;
+    caps->next =3D NULL;
+    qmp_migrate_set_capabilities(caps, &err);
=20
+end:
     qapi_free_MigrationCapabilityStatusList(caps);
=20
     if (err) {
--=20
2.7.5
