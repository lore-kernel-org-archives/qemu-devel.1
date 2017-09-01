Received: from eggs.gnu.org ([2001:4830:134:3::10]:51681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1S-0006hh-6v
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1M-0001jt-Qo
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dno1M-0001it-LP
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A81597EAA1
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 15:38:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-75.ams2.redhat.com
	[10.36.116.75])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 66432841DA
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 15:38:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 17:37:52 +0200
Message-Id: <20170901153758.8628-42-armbru@redhat.com>
In-Reply-To: <20170901153758.8628-1-armbru@redhat.com>
References: <20170901153758.8628-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 41/47] qapi: Use qapi_enum_parse() in
 input_type_enum()
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
Message-Id: <1503564371-26090-11-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/qapi-visit-core.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index ed6d2af462..ec83ff68f9 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -14,6 +14,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/util.h"
 #include "qemu-common.h"
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qerror.h"
@@ -353,7 +354,7 @@ static void input_type_enum(Visitor *v, const char *n=
ame, int *obj,
                             const char *const strings[], Error **errp)
 {
     Error *local_err =3D NULL;
-    int64_t value =3D 0;
+    int64_t value;
     char *enum_str;
=20
     visit_type_str(v, name, &enum_str, &local_err);
@@ -362,14 +363,8 @@ static void input_type_enum(Visitor *v, const char *=
name, int *obj,
         return;
     }
=20
-    while (strings[value] !=3D NULL) {
-        if (strcmp(strings[value], enum_str) =3D=3D 0) {
-            break;
-        }
-        value++;
-    }
-
-    if (strings[value] =3D=3D NULL) {
+    value =3D qapi_enum_parse(strings, enum_str, -1, NULL);
+    if (value < 0) {
         error_setg(errp, QERR_INVALID_PARAMETER, enum_str);
         g_free(enum_str);
         return;
--=20
2.13.5
