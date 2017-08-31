Received: from eggs.gnu.org ([2001:4830:134:3::10]:43441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnQOi-0007tO-Mp
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnQOh-0007bh-Hn
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:24:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dnQOh-0007bP-8h
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:24:43 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 31 Aug 2017 15:24:27 +0100
Message-Id: <20170831142430.16665-3-berrange@redhat.com>
In-Reply-To: <20170831142430.16665-1-berrange@redhat.com>
References: <20170831142430.16665-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/5] qapi: use items()/values() intead of
 iteritems()/itervalues()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Daniel P. Berrange" <berrange@redhat.com>

The iteritems()/itervalues() methods are gone in py3, but the
items()/values() methods are still around. The latter are less
efficient than the former in py2, but this has unmeasurably
small impact on QEMU build time, so taking portability over
efficiency is a net win

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 scripts/qapi.py      | 12 ++++++------
 scripts/qapi2texi.py |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index a60b79c126..d89af7d6c6 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -253,7 +253,7 @@ class QAPIDoc(object):
                                "'Returns:' is only valid for commands")
 
     def check(self):
-        bogus = [name for name, section in self.args.iteritems()
+        bogus = [name for name, section in self.args.items()
                  if not section.member]
         if bogus:
             raise QAPISemError(
@@ -309,7 +309,7 @@ class QAPISchemaParser(object):
                 if not isinstance(pragma, dict):
                     raise QAPISemError(
                         info, "Value of 'pragma' must be a dictionary")
-                for name, value in pragma.iteritems():
+                for name, value in pragma.items():
                     self._pragma(name, value, info)
             else:
                 expr_elem = {'expr': expr,
@@ -1575,7 +1575,7 @@ class QAPISchema(object):
 
     def _make_members(self, data, info):
         return [self._make_member(key, value, info)
-                for (key, value) in data.iteritems()]
+                for (key, value) in data.items()]
 
     def _def_struct_type(self, expr, info, doc):
         name = expr['struct']
@@ -1607,11 +1607,11 @@ class QAPISchema(object):
                 name, info, doc, 'base', self._make_members(base, info)))
         if tag_name:
             variants = [self._make_variant(key, value)
-                        for (key, value) in data.iteritems()]
+                        for (key, value) in data.items()]
             members = []
         else:
             variants = [self._make_simple_variant(key, value, info)
-                        for (key, value) in data.iteritems()]
+                        for (key, value) in data.items()]
             typ = self._make_implicit_enum_type(name, info,
                                                 [v.name for v in variants])
             tag_member = QAPISchemaObjectTypeMember('type', typ, False)
@@ -1626,7 +1626,7 @@ class QAPISchema(object):
         name = expr['alternate']
         data = expr['data']
         variants = [self._make_variant(key, value)
-                    for (key, value) in data.iteritems()]
+                    for (key, value) in data.items()]
         tag_member = QAPISchemaObjectTypeMember('type', 'QType', False)
         self._def_entity(
             QAPISchemaAlternateType(name, info, doc,
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 9c57b01bb4..bc43edabd7 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -148,7 +148,7 @@ def texi_member(member, suffix=''):
 def texi_members(doc, what, base, variants, member_func):
     """Format the table of members"""
     items = ''
-    for section in doc.args.itervalues():
+    for section in doc.args.values():
         # TODO Drop fallbacks when undocumented members are outlawed
         if section.content:
             desc = texi_format(str(section))
-- 
2.13.5
