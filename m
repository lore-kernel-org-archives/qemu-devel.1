Received: from eggs.gnu.org ([2001:4830:134:3::10]:55708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjaX-0002AM-RM
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjaT-00063S-8x
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eRjaT-00061w-1w
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 134614DD7C
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:59:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-74.ams2.redhat.com
	[10.36.116.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D8DB91B46E
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:59:27 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 20 Dec 2017 19:59:18 +0100
Message-Id: <20171220185924.32756-8-armbru@redhat.com>
In-Reply-To: <20171220185924.32756-1-armbru@redhat.com>
References: <20171220185924.32756-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/13] qapi: Unify representation of doc section
 without name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We have two representations of sections without a name: the main
section uses name=3DNone, the others name=3D''.  Standardize on name=3DNo=
ne.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20171002141341.24616-8-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py                       | 2 +-
 scripts/qapi2texi.py                  | 2 +-
 tests/qapi-schema/doc-bad-section.out | 2 +-
 tests/qapi-schema/doc-good.out        | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 2f2738f562..2137067b48 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -204,7 +204,7 @@ class QAPIDoc(object):
         self.section =3D QAPIDoc.ArgSection(name)
         self.args[name] =3D self.section
=20
-    def _start_section(self, name=3D''):
+    def _start_section(self, name=3DNone):
         if name in ('Returns', 'Since') and self.has_section(name):
             raise QAPIParseError(self.parser,
                                  "Duplicated '%s' section" % name)
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index f876d9a174..f16fa1ba53 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -184,7 +184,7 @@ def texi_sections(doc):
             # prefer @b over @strong, so txt doesn't translate it to *Fo=
o:*
             body +=3D '\n\n@b{%s:}\n' % section.name
         text =3D str(section)
-        if section.name.startswith('Example'):
+        if section.name and section.name.startswith('Example'):
             body +=3D texi_example(text)
         else:
             body +=3D texi_format(text)
diff --git a/tests/qapi-schema/doc-bad-section.out b/tests/qapi-schema/do=
c-bad-section.out
index 6fce84dd34..089bde1381 100644
--- a/tests/qapi-schema/doc-bad-section.out
+++ b/tests/qapi-schema/doc-bad-section.out
@@ -9,5 +9,5 @@ doc symbol=3DEnum
 The _one_ {and only}
     arg=3Dtwo
=20
-    section=3D
+    section=3DNone
 @two is undocumented
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.=
out
index c55e394e8a..1d2c250527 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -82,7 +82,7 @@ doc symbol=3DEnum
 The _one_ {and only}
     arg=3Dtwo
=20
-    section=3D
+    section=3DNone
 @two is undocumented
 doc symbol=3DBase
     body=3D
--=20
2.13.6
