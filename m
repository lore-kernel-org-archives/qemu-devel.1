Received: from eggs.gnu.org ([209.51.188.92]:50900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gzkNF-0004uY-KY
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:46:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gzkHP-0005o2-RM
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:40:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gzkHP-0005mp-IB
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:40:55 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Mar 2019 16:40:47 +0100
Message-Id: <20190301154051.23317-4-armbru@redhat.com>
In-Reply-To: <20190301154051.23317-1-armbru@redhat.com>
References: <20190301154051.23317-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 3/7] qapi: Pass file name to QAPIGen
 constructor instead of methods
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, eblake@redhat.com, quintela@redhat.com

Not much of an improvement now, but the next commit will profit.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/commands.py |  2 +-
 scripts/qapi/common.py   | 68 +++++++++++++++++++++-------------------
 scripts/qapi/doc.py      |  4 +--
 3 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index ebf488953d..6d66bf6aa3 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -239,7 +239,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModularCVisitor):
         QAPISchemaModularCVisitor.__init__(
             self, prefix, 'qapi-commands',
             ' * Schema-defined QAPI/QMP commands', __doc__)
-        self._regy = QAPIGenCCode()
+        self._regy = QAPIGenCCode(None)
         self._visited_ret_types = {}
 
     def _begin_user_module(self, name):
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index c327ae5036..8512cac427 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -2158,7 +2158,8 @@ def build_params(arg_type, boxed, extra=None):
 
 class QAPIGen(object):
 
-    def __init__(self):
+    def __init__(self, fname):
+        self.fname = fname
         self._preamble = ''
         self._body = ''
 
@@ -2168,18 +2169,17 @@ class QAPIGen(object):
     def add(self, text):
         self._body += text
 
-    def get_content(self, fname=None):
-        return (self._top(fname) + self._preamble + self._body
-                + self._bottom(fname))
+    def get_content(self):
+        return self._top() + self._preamble + self._body + self._bottom()
 
-    def _top(self, fname):
+    def _top(self):
         return ''
 
-    def _bottom(self, fname):
+    def _bottom(self):
         return ''
 
-    def write(self, output_dir, fname):
-        pathname = os.path.join(output_dir, fname)
+    def write(self, output_dir):
+        pathname = os.path.join(output_dir, self.fname)
         dir = os.path.dirname(pathname)
         if dir:
             try:
@@ -2192,7 +2192,7 @@ class QAPIGen(object):
             f = open(fd, 'r+', encoding='utf-8')
         else:
             f = os.fdopen(fd, 'r+')
-        text = self.get_content(fname)
+        text = self.get_content()
         oldtext = f.read(len(text) + 1)
         if text != oldtext:
             f.seek(0)
@@ -2229,8 +2229,8 @@ def ifcontext(ifcond, *args):
 
 class QAPIGenCCode(QAPIGen):
 
-    def __init__(self):
-        QAPIGen.__init__(self)
+    def __init__(self, fname):
+        QAPIGen.__init__(self, fname)
         self._start_if = None
 
     def start_if(self, ifcond):
@@ -2248,20 +2248,20 @@ class QAPIGenCCode(QAPIGen):
         self._preamble = _wrap_ifcond(self._start_if[0],
                                       self._start_if[2], self._preamble)
 
-    def get_content(self, fname=None):
+    def get_content(self):
         assert self._start_if is None
-        return QAPIGen.get_content(self, fname)
+        return QAPIGen.get_content(self)
 
 
 class QAPIGenC(QAPIGenCCode):
 
-    def __init__(self, blurb, pydoc):
-        QAPIGenCCode.__init__(self)
+    def __init__(self, fname, blurb, pydoc):
+        QAPIGenCCode.__init__(self, fname)
         self._blurb = blurb
         self._copyright = '\n * '.join(re.findall(r'^Copyright .*', pydoc,
                                                   re.MULTILINE))
 
-    def _top(self, fname):
+    def _top(self):
         return mcgen('''
 /* AUTOMATICALLY GENERATED, DO NOT MODIFY */
 
@@ -2277,28 +2277,28 @@ class QAPIGenC(QAPIGenCCode):
 ''',
                      blurb=self._blurb, copyright=self._copyright)
 
-    def _bottom(self, fname):
+    def _bottom(self):
         return mcgen('''
 
 /* Dummy declaration to prevent empty .o file */
 char dummy_%(name)s;
 ''',
-                     name=c_name(fname))
+                     name=c_name(self.fname))
 
 
 class QAPIGenH(QAPIGenC):
 
-    def _top(self, fname):
-        return QAPIGenC._top(self, fname) + guardstart(fname)
+    def _top(self):
+        return QAPIGenC._top(self) + guardstart(self.fname)
 
-    def _bottom(self, fname):
-        return guardend(fname)
+    def _bottom(self):
+        return guardend(self.fname)
 
 
 class QAPIGenDoc(QAPIGen):
 
-    def _top(self, fname):
-        return (QAPIGen._top(self, fname)
+    def _top(self):
+        return (QAPIGen._top(self)
                 + '@c AUTOMATICALLY GENERATED, DO NOT MODIFY\n\n')
 
 
@@ -2307,12 +2307,14 @@ class QAPISchemaMonolithicCVisitor(QAPISchemaVisitor):
     def __init__(self, prefix, what, blurb, pydoc):
         self._prefix = prefix
         self._what = what
-        self._genc = QAPIGenC(blurb, pydoc)
-        self._genh = QAPIGenH(blurb, pydoc)
+        self._genc = QAPIGenC(self._prefix + self._what + '.c',
+                              blurb, pydoc)
+        self._genh = QAPIGenH(self._prefix + self._what + '.h',
+                              blurb, pydoc)
 
     def write(self, output_dir):
-        self._genc.write(output_dir, self._prefix + self._what + '.c')
-        self._genh.write(output_dir, self._prefix + self._what + '.h')
+        self._genc.write(output_dir)
+        self._genh.write(output_dir)
 
 
 class QAPISchemaModularCVisitor(QAPISchemaVisitor):
@@ -2349,8 +2351,9 @@ class QAPISchemaModularCVisitor(QAPISchemaVisitor):
         return ret
 
     def _add_module(self, name, blurb):
-        genc = QAPIGenC(blurb, self._pydoc)
-        genh = QAPIGenH(blurb, self._pydoc)
+        basename = self._module_basename(self._what, name)
+        genc = QAPIGenC(basename + '.c', blurb, self._pydoc)
+        genh = QAPIGenH(basename + '.h', blurb, self._pydoc)
         self._module[name] = (genc, genh)
         self._set_module(name)
 
@@ -2370,10 +2373,9 @@ class QAPISchemaModularCVisitor(QAPISchemaVisitor):
         for name in self._module:
             if self._is_builtin_module(name) and not opt_builtins:
                 continue
-            basename = self._module_basename(self._what, name)
             (genc, genh) = self._module[name]
-            genc.write(output_dir, basename + '.c')
-            genh.write(output_dir, basename + '.h')
+            genc.write(output_dir)
+            genh.write(output_dir)
 
     def _begin_user_module(self, name):
         pass
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index c03b690161..5c8c136899 100755
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -207,11 +207,11 @@ def texi_entity(doc, what, ifcond, base=None, variants=None,
 class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaVisitor):
     def __init__(self, prefix):
         self._prefix = prefix
-        self._gen = qapi.common.QAPIGenDoc()
+        self._gen = qapi.common.QAPIGenDoc(self._prefix + 'qapi-doc.texi')
         self.cur_doc = None
 
     def write(self, output_dir):
-        self._gen.write(output_dir, self._prefix + 'qapi-doc.texi')
+        self._gen.write(output_dir)
 
     def visit_enum_type(self, name, info, ifcond, members, prefix):
         doc = self.cur_doc
-- 
2.17.2
