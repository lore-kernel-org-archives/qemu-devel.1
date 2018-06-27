Received: from eggs.gnu.org ([2001:4830:134:3::10]:58355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fYDQQ-0003Nd-C1
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fYDQP-000393-9F
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:36:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57140 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fYDQP-00038M-1E
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:36:09 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 27 Jun 2018 18:35:43 +0200
Message-Id: <20180627163551.31610-8-marcandre.lureau@redhat.com>
In-Reply-To: <20180627163551.31610-1-marcandre.lureau@redhat.com>
References: <20180627163551.31610-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 07/15] qapi: add #if/#endif helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, eblake@redhat.com, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Add helpers to wrap generated code with #if/#endif lines.

Add QAPIGenCSnippet class to write C snippet code, make QAPIGenC
inherit from it, for full C files with copyright headers etc.

Add a 'with' statement context manager that will be used to wrap
generator visitor methods.  The manager will check if code was
generated before adding #if/#endif lines on QAPIGenCSnippet
objects. Used in the following patches.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py | 101 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 97 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 1b56065a80..44eaf25850 100644
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
+def wrap_ifcond(ifcond, before, after):
+    if ifcond is None or before =3D=3D after:
+        return after
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
@@ -2064,6 +2099,7 @@ class QAPIGen(object):
     def __init__(self):
         self._preamble =3D ''
         self._body =3D ''
+        self._start_if =3D None
=20
     def preamble_add(self, text):
         self._preamble +=3D text
@@ -2071,6 +2107,25 @@ class QAPIGen(object):
     def add(self, text):
         self._body +=3D text
=20
+    def start_if(self, ifcond):
+        assert self._start_if is None
+
+        self._start_if =3D (ifcond, self._body, self._preamble)
+
+    def _wrap_ifcond(self):
+        pass
+
+    def end_if(self):
+        assert self._start_if
+
+        self._wrap_ifcond()
+        self._start_if =3D None
+
+    def get_content(self, fname=3DNone):
+        assert self._start_if is None
+        return (self._top(fname) + self._preamble + self._body
+                + self._bottom(fname))
+
     def _top(self, fname):
         return ''
=20
@@ -2091,8 +2146,7 @@ class QAPIGen(object):
             f =3D open(fd, 'r+', encoding=3D'utf-8')
         else:
             f =3D os.fdopen(fd, 'r+')
-        text =3D (self._top(fname) + self._preamble + self._body
-                + self._bottom(fname))
+        text =3D self.get_content(fname)
         oldtext =3D f.read(len(text) + 1)
         if text !=3D oldtext:
             f.seek(0)
@@ -2101,10 +2155,49 @@ class QAPIGen(object):
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
+    *args: variable length argument list of QAPIGen
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
+
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
+
+    def _wrap_ifcond(self):
+        self._body =3D wrap_ifcond(self._start_if[0],
+                                 self._start_if[1], self._body)
+        self._preamble =3D wrap_ifcond(self._start_if[0],
+                                     self._start_if[2], self._preamble)
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
2.18.0.rc1
