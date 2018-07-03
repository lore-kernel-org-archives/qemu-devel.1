Received: from eggs.gnu.org ([2001:4830:134:3::10]:39548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1faNfv-0002AC-CF
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1faNfr-0003UY-Cb
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:57:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51158 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1faNfr-0003UG-7I
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:57:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B82D2818BAFD
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 15:57:02 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  3 Jul 2018 17:56:41 +0200
Message-Id: <20180703155648.11933-8-marcandre.lureau@redhat.com>
In-Reply-To: <20180703155648.11933-1-marcandre.lureau@redhat.com>
References: <20180703155648.11933-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 07/14] qapi-introspect: modify to_qlit() to
 append ', ' on level > 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The following patch is going to break list entries with #if/#endif, so
they should have the trailing ',' as suffix.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/introspect.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 245cfdfb65..bd7e1219be 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -30,7 +30,7 @@ def to_qlit(obj, level=3D0, suppress_first_indent=3DFal=
se):
                 for elt in obj]
         elts.append(indent(level + 1) + "{}")
         ret +=3D 'QLIT_QLIST(((QLitObject[]) {\n'
-        ret +=3D ',\n'.join(elts) + '\n'
+        ret +=3D '\n'.join(elts) + '\n'
         ret +=3D indent(level) + '}))'
     elif isinstance(obj, dict):
         elts =3D []
@@ -45,6 +45,8 @@ def to_qlit(obj, level=3D0, suppress_first_indent=3DFal=
se):
         ret +=3D 'QLIT_QBOOL(%s)' % ('true' if obj else 'false')
     else:
         assert False                # not implemented
+    if level > 0:
+        ret +=3D ','
     return ret
=20
=20
--=20
2.18.0.rc1
