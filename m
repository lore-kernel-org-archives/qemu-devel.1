Received: from eggs.gnu.org ([2001:4830:134:3::10]:33373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Ur-0001VN-Hl
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Up-0000IR-5z
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co8Uo-0000HE-Sa
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:43 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Mar 2017 13:57:00 +0100
Message-Id: <1489582656-31133-12-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-1-git-send-email-armbru@redhat.com>
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-2.9 11/47] qapi: Avoid unwanted blank
 lines in QAPIDoc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

We silently fix missing #optional tags for QAPIDoc by appending a line
"#optional" to the section's .content.  However, this interferes with
.__repr__ stripping trailing blank lines from .content.

Use new ArgSection instance variable .optional instead, and leave
.content alone.

To permit testing .optional in texi_body(), clean up texi_enum()'s
hack to add empty documentation for undocumented enum values: add an
ArgSection instead of ''.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py      | 5 +++--
 scripts/qapi2texi.py | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index f4c8210..fb10d93 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -107,6 +107,7 @@ class QAPIDoc(object):
             self.name =3D name
             # the list of lines for this section
             self.content =3D []
+            self.optional =3D False
=20
         def append(self, line):
             self.content.append(line)
@@ -982,15 +983,15 @@ def check_definition_doc(doc, expr, info):
             desc =3D doc.args.get(arg)
         if not desc:
             continue
+        desc.optional =3D opt
         desc_opt =3D "#optional" in str(desc)
         if desc_opt and not opt:
             raise QAPISemError(info, "Description has #optional, "
                                "but the declaration doesn't")
         if not desc_opt and opt:
-            # silently fix the doc
             # TODO either fix the schema and make this an error,
             # or drop #optional entirely
-            desc.append("#optional")
+            pass
=20
     doc_args =3D set(doc.args.keys())
     args =3D set([name.strip('*') for name in args])
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 0f3e573..0aaf45c 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -136,7 +136,7 @@ def texi_body(doc):
         for arg, section in doc.args.iteritems():
             desc =3D str(section)
             opt =3D ''
-            if "#optional" in desc:
+            if section.optional:
                 desc =3D re.sub(r'^ *#optional *\n?|\n? *#optional *$|#o=
ptional',
                               '', desc)
                 opt =3D ' (optional)'
@@ -185,7 +185,7 @@ def texi_enum(expr, doc):
     """Format an enum to texi"""
     for i in expr['data']:
         if i not in doc.args:
-            doc.args[i] =3D ''
+            doc.args[i] =3D qapi.QAPIDoc.ArgSection(i)
     body =3D texi_body(doc)
     return TYPE_FMT(type=3D"Enum",
                     name=3Ddoc.symbol,
--=20
2.7.4
