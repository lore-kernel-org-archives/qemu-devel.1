Received: from eggs.gnu.org ([2001:4830:134:3::10]:44853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYzUn-0000MD-U7
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYzUm-0004i4-U5
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:55:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32810 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fYzUm-0004hd-OC
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:55:52 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 29 Jun 2018 14:55:43 -0500
Message-Id: <20180629195544.34263-2-eblake@redhat.com>
In-Reply-To: <20180629195544.34263-1-eblake@redhat.com>
References: <20180629195544.34263-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] qapi: Add comments to aid debugging
 generated introspection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>

We consciously chose in commit 1a9a507b to hide QAPI type names
from the generated introspection output, but added a command line
option -u to unmask the type name when doing a debug build.  At
that time, we generated a monolithic C string, so there was no
better way to do things (we could not really inject comments).

Later, in commit 7d0f982b, we switched the generation to output
a QLit object, in part to make it easier for future addition of
conditional compilation.  But this switch has also made it easier
to interject strategic comments.  That commit also forgot to
delete some now-stale comments about long generated line lengths.

For now, type name debug aid comments are only output once per
meta-type, rather than at all uses of the number used to encode
the type to the introspection data.  But this is still a lot
more convenient than having to regenerate the file with the
unmask operation temporarily turned on.

The generated qapi-introspect.c changes only with the addition
of comments, such as:

| @@ -14927,6 +15410,7 @@
|          {}
|      })),
|      QLIT_QDICT(((QLitDictEntry[]) {
| +        /* QCryptoBlockInfoLUKSSlot */
|          { "members", QLIT_QLIST(((QLitObject[]) {
|              QLIT_QDICT(((QLitDictEntry[]) {
|                  { "name", QLIT_QSTR("active") },
|

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/introspect.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 6ad198ae5b5..b37160292bc 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -35,10 +35,14 @@ def to_qlit(obj, level=0, suppress_first_indent=False):
     elif isinstance(obj, dict):
         elts = []
         for key, value in sorted(obj.items()):
+            if key == 'comment':
+                continue
             elts.append(indent(level + 1) + '{ %s, %s }' %
                         (to_c_string(key), to_qlit(value, level + 1, True)))
         elts.append(indent(level + 1) + '{}')
         ret += 'QLIT_QDICT(((QLitDictEntry[]) {\n'
+        if obj.get('comment'):
+            ret += indent(level + 1) + '/* %s */\n' % obj['comment']
         ret += ',\n'.join(elts) + '\n'
         ret += indent(level) + '}))'
     elif isinstance(obj, bool):
@@ -78,7 +82,6 @@ class QAPISchemaGenIntrospectVisitor(QAPISchemaMonolithicCVisitor):
         for typ in self._used_types:
             typ.visit(self)
         # generate C
-        # TODO can generate awfully long lines
         name = c_name(self._prefix, protect=False) + 'qmp_schema_qlit'
         self._genh.add(mcgen('''
 #include "qapi/qmp/qlit.h"
@@ -118,8 +121,8 @@ const QLitObject %(c_name)s = %(c_string)s;
         if typ not in self._used_types:
             self._used_types.append(typ)
         # Clients should examine commands and events, not types.  Hide
-        # type names to reduce the temptation.  Also saves a few
-        # characters.
+        # type names as integers to reduce the temptation, but provide
+        # comments for debugging aid.
         if isinstance(typ, QAPISchemaBuiltinType):
             return typ.name
         if isinstance(typ, QAPISchemaArrayType):
@@ -128,6 +131,8 @@ const QLitObject %(c_name)s = %(c_string)s;

     def _gen_qlit(self, name, mtype, obj):
         if mtype not in ('command', 'event', 'builtin', 'array'):
+            if not self._unmask:
+                obj['comment'] = name
             name = self._name(name)
         obj['name'] = name
         obj['meta-type'] = mtype
-- 
2.14.4
