Received: from eggs.gnu.org ([2001:4830:134:3::10]:48376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycIK-00052A-1a
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycII-0007md-Vv
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:52:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53198 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycII-0007mP-Ql
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:52:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F05E4040853
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:52:38 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:51:30 +0100
Message-Id: <20180321115211.17937-9-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 08/49] qapi: add #if/#endif helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add helpers to wrap generated code with #if/#endif lines.

Add QAPIGenCSnippet class to write C snippet code, make QAPIGenC
inherit from it, for full C files with copyright headers etc.

Add a 'with' statement context manager that will be used to wrap
generator visitor methods.  The manager will check if code was
generated before adding #if/#endif lines on QAPIGenCSnippet
objects. Used in the following patches.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py | 82 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 47efe79758..60c1d0a783 100644
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
@@ -1964,6 +1965,40 @@ def guardend(name):
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
@@ -2054,6 +2089,7 @@ class QAPIGen(object):
     def __init__(self):
         self._preamble =3D ''
         self._body =3D ''
+        self._ifcond =3D None
=20
     def preamble_add(self, text):
         self._preamble +=3D text
@@ -2061,6 +2097,23 @@ class QAPIGen(object):
     def add(self, text):
         self._body +=3D text
=20
+    def start_if(self, ifcond):
+        self._ifcond =3D ifcond
+        self._start_if_body =3D self._body
+        self._start_if_preamble =3D self._preamble
+
+    def _wrap_ifcond(self):
+        pass
+
+    def end_if(self):
+        self._wrap_ifcond()
+        self._ifcond =3D None
+
+    def get_content(self, fname=3DNone):
+        assert self._ifcond is None
+        return (self._top(fname) + self._preamble + self._body
+                + self._bottom(fname))
+
     def _top(self, fname):
         return ''
=20
@@ -2078,8 +2131,7 @@ class QAPIGen(object):
                     raise
         fd =3D os.open(pathname, os.O_RDWR | os.O_CREAT, 0o666)
         f =3D os.fdopen(fd, 'r+')
-        text =3D (self._top(fname) + self._preamble + self._body
-                + self._bottom(fname))
+        text =3D self.get_content(fname)
         oldtext =3D f.read(len(text) + 1)
         if text !=3D oldtext:
             f.seek(0)
@@ -2088,10 +2140,32 @@ class QAPIGen(object):
         f.close()
=20
=20
-class QAPIGenC(QAPIGen):
+@contextmanager
+def ifcontext(ifcond, *args):
+    saved =3D []
+    for arg in args:
+        arg.start_if(ifcond)
+    yield
+    for arg in args:
+        arg.end_if()
=20
-    def __init__(self, blurb, pydoc):
+
+class QAPIGenCSnippet(QAPIGen):
+
+    def __init__(self):
         QAPIGen.__init__(self)
+
+    def _wrap_ifcond(self):
+        self._body =3D wrap_ifcond(self._ifcond,
+                                 self._start_if_body, self._body)
+        self._preamble =3D wrap_ifcond(self._ifcond,
+                                     self._start_if_preamble, self._prea=
mble)
+
+
+class QAPIGenC(QAPIGenCSnippet):
+
+    def __init__(self, blurb, pydoc):
+        QAPIGenCSnippet.__init__(self)
         self._blurb =3D blurb
         self._copyright =3D '\n * '.join(re.findall(r'^Copyright .*', py=
doc,
                                                   re.MULTILINE))
--=20
2.16.2.521.g9aa15f885a
