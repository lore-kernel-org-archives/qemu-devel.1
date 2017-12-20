Received: from eggs.gnu.org ([2001:4830:134:3::10]:55749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjaY-0002BI-Oi
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRjaT-00063l-MP
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eRjaT-00062A-8e
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:59:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 426214E919
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:59:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-74.ams2.redhat.com
	[10.36.116.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E01A21B476
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:59:27 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 20 Dec 2017 19:59:21 +0100
Message-Id: <20171220185924.32756-11-armbru@redhat.com>
In-Reply-To: <20171220185924.32756-1-armbru@redhat.com>
References: <20171220185924.32756-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/13] qapi: Rename QAPIDoc.parser,
 .section to ._parser, ._section
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
Message-Id: <20171002141341.24616-11-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py | 52 ++++++++++++++++++++++++++-------------------------=
-
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index e338868a52..43a54bf40f 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -120,11 +120,11 @@ class QAPIDoc(object):
             self.member =3D member
=20
     def __init__(self, parser, info):
-        # self.parser is used to report errors with QAPIParseError.  The
+        # self._parser is used to report errors with QAPIParseError.  Th=
e
         # resulting error position depends on the state of the parser.
         # It happens to be the beginning of the comment.  More or less
         # servicable, but action at a distance.
-        self.parser =3D parser
+        self._parser =3D parser
         self.info =3D info
         self.symbol =3D None
         self.body =3D QAPIDoc.Section()
@@ -133,7 +133,7 @@ class QAPIDoc(object):
         # a list of Section
         self.sections =3D []
         # the current section
-        self.section =3D self.body
+        self._section =3D self.body
=20
     def has_section(self, name):
         """Return True if we have a section with this name."""
@@ -150,7 +150,7 @@ class QAPIDoc(object):
             return
=20
         if line[0] !=3D ' ':
-            raise QAPIParseError(self.parser, "Missing space after #")
+            raise QAPIParseError(self._parser, "Missing space after #")
         line =3D line[1:]
=20
         # FIXME not nice: things like '#  @foo:' and '# @foo: ' aren't
@@ -159,11 +159,11 @@ class QAPIDoc(object):
             self._append_symbol_line(line)
         elif not self.body.text and line.startswith('@'):
             if not line.endswith(':'):
-                raise QAPIParseError(self.parser, "Line should end with =
:")
+                raise QAPIParseError(self._parser, "Line should end with=
 :")
             self.symbol =3D line[1:-1]
             # FIXME invalid names other than the empty string aren't fla=
gged
             if not self.symbol:
-                raise QAPIParseError(self.parser, "Invalid name")
+                raise QAPIParseError(self._parser, "Invalid name")
         else:
             self._append_freeform(line)
=20
@@ -189,48 +189,48 @@ class QAPIDoc(object):
     def _start_args_section(self, name):
         # FIXME invalid names other than the empty string aren't flagged
         if not name:
-            raise QAPIParseError(self.parser, "Invalid parameter name")
+            raise QAPIParseError(self._parser, "Invalid parameter name")
         if name in self.args:
-            raise QAPIParseError(self.parser,
+            raise QAPIParseError(self._parser,
                                  "'%s' parameter name duplicated" % name=
)
         if self.sections:
-            raise QAPIParseError(self.parser,
+            raise QAPIParseError(self._parser,
                                  "'@%s:' can't follow '%s' section"
                                  % (name, self.sections[0].name))
         self._end_section()
-        self.section =3D QAPIDoc.ArgSection(name)
-        self.args[name] =3D self.section
+        self._section =3D QAPIDoc.ArgSection(name)
+        self.args[name] =3D self._section
=20
     def _start_section(self, name=3DNone):
         if name in ('Returns', 'Since') and self.has_section(name):
-            raise QAPIParseError(self.parser,
+            raise QAPIParseError(self._parser,
                                  "Duplicated '%s' section" % name)
         self._end_section()
-        self.section =3D QAPIDoc.Section(name)
-        self.sections.append(self.section)
+        self._section =3D QAPIDoc.Section(name)
+        self.sections.append(self._section)
=20
     def _end_section(self):
-        if self.section:
-            text =3D self.section.text =3D self.section.text.strip()
-            if self.section.name and (not text or text.isspace()):
-                raise QAPIParseError(self.parser, "Empty doc section '%s=
'"
-                                     % self.section.name)
-            self.section =3D None
+        if self._section:
+            text =3D self._section.text =3D self._section.text.strip()
+            if self._section.name and (not text or text.isspace()):
+                raise QAPIParseError(self._parser, "Empty doc section '%=
s'"
+                                     % self._section.name)
+            self._section =3D None
=20
     def _append_freeform(self, line):
-        in_arg =3D isinstance(self.section, QAPIDoc.ArgSection)
-        if (in_arg and self.section.text.endswith('\n\n')
+        in_arg =3D isinstance(self._section, QAPIDoc.ArgSection)
+        if (in_arg and self._section.text.endswith('\n\n')
                 and line and not line[0].isspace()):
             self._start_section()
-        if (in_arg or not self.section.name
-                or not self.section.name.startswith('Example')):
+        if (in_arg or not self._section.name
+                or not self._section.name.startswith('Example')):
             line =3D line.strip()
         match =3D re.match(r'(@\S+:)', line)
         if match:
-            raise QAPIParseError(self.parser,
+            raise QAPIParseError(self._parser,
                                  "'%s' not allowed in free-form document=
ation"
                                  % match.group(1))
-        self.section.append(line)
+        self._section.append(line)
=20
     def connect_member(self, member):
         if member.name not in self.args:
--=20
2.13.6
