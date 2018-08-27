Received: from eggs.gnu.org ([2001:4830:134:3::10]:47209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fuPEi-0007PI-Bm
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 17:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fuPEg-0008JN-Ip
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 17:39:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49578 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fuPEg-0008Ip-Bm
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 17:39:46 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 27 Aug 2018 16:39:42 -0500
Message-Id: <20180827213943.33524-2-eblake@redhat.com>
In-Reply-To: <20180827213943.33524-1-eblake@redhat.com>
References: <20180827213943.33524-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] qapi: Minor introspect.py cleanups
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

Commit 7d0f982b changed generated introspection output to no longer
produce long lines in the generated .c file, but failed to adjust
comments to match.  Add some clarity that the shorter length that
matters most is the overall QMP response on the wire.

Commit 25b1ef31 triggers a pep8 formatting nit.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/introspect.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 189a4edabab..43e81a06938 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -89,7 +89,6 @@ class QAPISchemaGenIntrospectVisitor(QAPISchemaMonolithicCVisitor):
         for typ in self._used_types:
             typ.visit(self)
         # generate C
-        # TODO can generate awfully long lines
         name = c_name(self._prefix, protect=False) + 'qmp_schema_qlit'
         self._genh.add(mcgen('''
 #include "qapi/qmp/qlit.h"
@@ -129,8 +128,8 @@ const QLitObject %(c_name)s = %(c_string)s;
         if typ not in self._used_types:
             self._used_types.append(typ)
         # Clients should examine commands and events, not types.  Hide
-        # type names to reduce the temptation.  Also saves a few
-        # characters.
+        # type names as integers to reduce the temptation.  Also, it
+        # saves a few characters on the wire.
         if isinstance(typ, QAPISchemaBuiltinType):
             return typ.name
         if isinstance(typ, QAPISchemaArrayType):
@@ -185,7 +184,7 @@ const QLitObject %(c_name)s = %(c_string)s;
         arg_type = arg_type or self._schema.the_empty_object_type
         ret_type = ret_type or self._schema.the_empty_object_type
         obj = {'arg-type': self._use_type(arg_type),
-               'ret-type': self._use_type(ret_type) }
+               'ret-type': self._use_type(ret_type)}
         if allow_oob:
             obj['allow-oob'] = allow_oob
         self._gen_qlit(name, 'command', obj, ifcond)
-- 
2.17.1
