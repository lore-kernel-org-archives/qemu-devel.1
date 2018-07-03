Received: from eggs.gnu.org ([2001:4830:134:3::10]:44119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSVA-0000yH-3l
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSV7-0000OP-Aw
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:06:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33642 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faSV7-0000Nq-5o
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:06:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB659401CC41
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:06:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 23:06:05 +0200
Message-Id: <20180703210613.25619-7-armbru@redhat.com>
In-Reply-To: <20180703210613.25619-1-armbru@redhat.com>
References: <20180703210613.25619-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/14] qapi: add #if/#endif helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Add helpers to wrap generated code with #if/#endif lines.

A later patch wants to use QAPIGen for generating C snippets rather
than full C files with copyright headers etc.  Splice in class
QAPIGenCCode between QAPIGen and QAPIGenC.

Add a 'with' statement context manager that will be used to wrap
generator visitor methods.  The manager will check if code was
generated before adding #if/#endif lines on QAPIGenCSnippet
objects. Used in the following patches.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180703155648.11933-7-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py | 98 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 94 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 1b56065a80..9230a2a3e8 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -12,6 +12,7 @@
 # See the COPYING file in the top-level directory.
=20
 from __future__ import print_function
+from contextlib import contextmanager
 import errno
 import os
 import re
@@ -1974,6 +1975,40 @@ def guardend(name):
                  name=3Dguardname(name))
=20
=20
+def gen_if(ifcond):
+    ret =3D ''
+    for ifc in ifcond:
+        ret +=3D mcgen('''
+#if %(cond)s
+''', cond=3Difc)
+    return ret
+
+
+def gen_endif(ifcond):
+    ret =3D ''
+    for ifc in reversed(ifcond):
+        ret +=3D mcgen('''
+#endif /* %(cond)s */
+''', cond=3Difc)
+    return ret
+
+
+def _wrap_ifcond(ifcond, before, after):
+    if before =3D=3D after:
+        return after   # suppress empty #if ... #endif
+
+    assert after.startswith(before)
+    out =3D before
+    added =3D after[len(before):]
+    if added[0] =3D=3D '\n':
+        out +=3D '\n'
+        added =3D added[1:]
+    out +=3D gen_if(ifcond)
+    out +=3D added
+    out +=3D gen_endif(ifcond)
+    return out
+
+
 def gen_enum_lookup(name, values, prefix=3DNone):
     ret =3D mcgen('''
=20
@@ -2071,6 +2106,10 @@ class QAPIGen(object):
     def add(self, text):
         self._body +=3D text
=20
+    def get_content(self, fname=3DNone):
+        return (self._top(fname) + self._preamble + self._body
+                + self._bottom(fname))
+
     def _top(self, fname):
         return ''
=20
@@ -2091,8 +2130,7 @@ class QAPIGen(object):
             f =3D open(fd, 'r+', encoding=3D'utf-8')
         else:
             f =3D os.fdopen(fd, 'r+')
-        text =3D (self._top(fname) + self._preamble + self._body
-                + self._bottom(fname))
+        text =3D self.get_content(fname)
         oldtext =3D f.read(len(text) + 1)
         if text !=3D oldtext:
             f.seek(0)
@@ -2101,10 +2139,62 @@ class QAPIGen(object):
         f.close()
=20
=20
-class QAPIGenC(QAPIGen):
+@contextmanager
+def ifcontext(ifcond, *args):
+    """A 'with' statement context manager to wrap with start_if()/end_if=
()
=20
-    def __init__(self, blurb, pydoc):
+    *args: any number of QAPIGenCCode
+
+    Example::
+
+        with ifcontext(ifcond, self._genh, self._genc):
+            modify self._genh and self._genc ...
+
+    Is equivalent to calling::
+
+        self._genh.start_if(ifcond)
+        self._genc.start_if(ifcond)
+        modify self._genh and self._genc ...
+        self._genh.end_if()
+        self._genc.end_if()
+    """
+    for arg in args:
+        arg.start_if(ifcond)
+    yield
+    for arg in args:
+        arg.end_if()
+
+
+class QAPIGenCCode(QAPIGen):
+
+    def __init__(self):
         QAPIGen.__init__(self)
+        self._start_if =3D None
+
+    def start_if(self, ifcond):
+        assert self._start_if is None
+        self._start_if =3D (ifcond, self._body, self._preamble)
+
+    def end_if(self):
+        assert self._start_if
+        self._wrap_ifcond()
+        self._start_if =3D None
+
+    def _wrap_ifcond(self):
+        self._body =3D _wrap_ifcond(self._start_if[0],
+                                  self._start_if[1], self._body)
+        self._preamble =3D _wrap_ifcond(self._start_if[0],
+                                      self._start_if[2], self._preamble)
+
+    def get_content(self, fname=3DNone):
+        assert self._start_if is None
+        return QAPIGen.get_content(self, fname)
+
+
+class QAPIGenC(QAPIGenCCode):
+
+    def __init__(self, blurb, pydoc):
+        QAPIGenCCode.__init__(self)
         self._blurb =3D blurb
         self._copyright =3D '\n * '.join(re.findall(r'^Copyright .*', py=
doc,
                                                   re.MULTILINE))
--=20
2.17.1
