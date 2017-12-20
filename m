Received: from eggs.gnu.org ([2001:4830:134:3::10]:55659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjaX-00029Q-00
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjaS-00062c-Ub
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eRjaS-00061E-KS
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 80BB0624A8
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:59:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-74.ams2.redhat.com
	[10.36.116.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 50CCD5B809
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:59:27 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 20 Dec 2017 19:59:17 +0100
Message-Id: <20171220185924.32756-7-armbru@redhat.com>
In-Reply-To: <20171220185924.32756-1-armbru@redhat.com>
References: <20171220185924.32756-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/13] qapi2texi: Clean up texi_sections()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Repurposing the function parameter doc for stepping through
doc.sections.__str__() is not nice.  Use new variable @text instead.

While there, eliminate variables name and func.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20171002141341.24616-7-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi2texi.py | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index a317526e51..f876d9a174 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -180,16 +180,14 @@ def texi_sections(doc):
     """Format additional sections following arguments"""
     body =3D ''
     for section in doc.sections:
-        name, doc =3D (section.name, str(section))
-        func =3D texi_format
-        if name.startswith('Example'):
-            func =3D texi_example
-
-        if name:
+        if section.name:
             # prefer @b over @strong, so txt doesn't translate it to *Fo=
o:*
-            body +=3D '\n\n@b{%s:}\n' % name
-
-        body +=3D func(doc)
+            body +=3D '\n\n@b{%s:}\n' % section.name
+        text =3D str(section)
+        if section.name.startswith('Example'):
+            body +=3D texi_example(text)
+        else:
+            body +=3D texi_format(text)
     return body
=20
=20
--=20
2.13.6
