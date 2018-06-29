Received: from eggs.gnu.org ([2001:4830:134:3::10]:44859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYzUo-0000Mb-HQ
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYzUn-0004iq-JF
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:55:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32814 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fYzUn-0004iJ-DU
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:55:53 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 29 Jun 2018 14:55:44 -0500
Message-Id: <20180629195544.34263-3-eblake@redhat.com>
In-Reply-To: <20180629195544.34263-1-eblake@redhat.com>
References: <20180629195544.34263-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] qapi: Drop qapi-gen --unmask option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Now that we have useful access to the type name as a comment
in the generated qapi-introspect.c, we don't need to regenerate
code with a temporary -u option just to get at type names.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi-gen.py        |  5 +----
 scripts/qapi/introspect.py | 12 ++++--------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
index 3d98ca2e0c6..6ec7e481b1b 100755
--- a/scripts/qapi-gen.py
+++ b/scripts/qapi-gen.py
@@ -26,9 +26,6 @@ def main(argv):
                         help="write output to directory OUTPUT_DIR")
     parser.add_argument('-p', '--prefix', action='store', default='',
                         help="prefix for symbols")
-    parser.add_argument('-u', '--unmask-non-abi-names', action='store_true',
-                        dest='unmask',
-                        help="expose non-ABI names in introspection")
     parser.add_argument('schema', action='store')
     args = parser.parse_args()

@@ -49,7 +46,7 @@ def main(argv):
     gen_visit(schema, args.output_dir, args.prefix, args.builtins)
     gen_commands(schema, args.output_dir, args.prefix)
     gen_events(schema, args.output_dir, args.prefix)
-    gen_introspect(schema, args.output_dir, args.prefix, args.unmask)
+    gen_introspect(schema, args.output_dir, args.prefix)
     gen_doc(schema, args.output_dir, args.prefix)


diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index b37160292bc..8dd4136c0af 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -58,11 +58,10 @@ def to_c_string(string):

 class QAPISchemaGenIntrospectVisitor(QAPISchemaMonolithicCVisitor):

-    def __init__(self, prefix, unmask):
+    def __init__(self, prefix):
         QAPISchemaMonolithicCVisitor.__init__(
             self, prefix, 'qapi-introspect',
             ' * QAPI/QMP schema introspection', __doc__)
-        self._unmask = unmask
         self._schema = None
         self._qlits = []
         self._used_types = []
@@ -104,8 +103,6 @@ const QLitObject %(c_name)s = %(c_string)s;
         return not isinstance(entity, QAPISchemaType)

     def _name(self, name):
-        if self._unmask:
-            return name
         if name not in self._name_map:
             self._name_map[name] = '%d' % len(self._name_map)
         return self._name_map[name]
@@ -131,8 +128,7 @@ const QLitObject %(c_name)s = %(c_string)s;

     def _gen_qlit(self, name, mtype, obj):
         if mtype not in ('command', 'event', 'builtin', 'array'):
-            if not self._unmask:
-                obj['comment'] = name
+            obj['comment'] = name
             name = self._name(name)
         obj['name'] = name
         obj['meta-type'] = mtype
@@ -188,7 +184,7 @@ const QLitObject %(c_name)s = %(c_string)s;
         self._gen_qlit(name, 'event', {'arg-type': self._use_type(arg_type)})


-def gen_introspect(schema, output_dir, prefix, opt_unmask):
-    vis = QAPISchemaGenIntrospectVisitor(prefix, opt_unmask)
+def gen_introspect(schema, output_dir, prefix):
+    vis = QAPISchemaGenIntrospectVisitor(prefix)
     schema.visit(vis)
     vis.write(output_dir)
-- 
2.14.4
