Received: from eggs.gnu.org ([2001:4830:134:3::10]:56362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Ic2-00025H-Gm
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Ic0-0008Jn-62
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d6Ibz-0008Ii-Ut
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 03324C04B950
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 15:24:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-149.ams2.redhat.com
	[10.36.116.149])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C1A9177E27
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 15:24:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  4 May 2017 17:23:57 +0200
Message-Id: <1493911445-19568-21-git-send-email-armbru@redhat.com>
In-Reply-To: <1493911445-19568-1-git-send-email-armbru@redhat.com>
References: <1493911445-19568-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/28] qmp: Improve QMP dispatch error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1493282486-28338-2-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 qapi/qmp-dispatch.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index dc50212..5ad36f8 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -30,7 +30,7 @@ static QDict *qmp_dispatch_check_obj(const QObject *req=
uest, Error **errp)
=20
     dict =3D qobject_to_qdict(request);
     if (!dict) {
-        error_setg(errp, "Expected '%s' in QMP input", "object");
+        error_setg(errp, "QMP input must be a JSON object");
         return NULL;
     }
=20
@@ -41,26 +41,26 @@ static QDict *qmp_dispatch_check_obj(const QObject *r=
equest, Error **errp)
=20
         if (!strcmp(arg_name, "execute")) {
             if (qobject_type(arg_obj) !=3D QTYPE_QSTRING) {
-                error_setg(errp, "QMP input object member '%s' expects '=
%s'",
-                           "execute", "string");
+                error_setg(errp,
+                           "QMP input member 'execute' must be a string"=
);
                 return NULL;
             }
             has_exec_key =3D true;
         } else if (!strcmp(arg_name, "arguments")) {
             if (qobject_type(arg_obj) !=3D QTYPE_QDICT) {
-                error_setg(errp, "QMP input object member '%s' expects '=
%s'",
-                           "arguments", "object");
+                error_setg(errp,
+                           "QMP input member 'arguments' must be an obje=
ct");
                 return NULL;
             }
         } else {
-            error_setg(errp, "QMP input object member '%s' is unexpected=
",
+            error_setg(errp, "QMP input member '%s' is unexpected",
                        arg_name);
             return NULL;
         }
     }
=20
     if (!has_exec_key) {
-        error_setg(errp, "Expected '%s' in QMP input", "execute");
+        error_setg(errp, "QMP input lacks member 'execute'");
         return NULL;
     }
=20
--=20
2.7.4
