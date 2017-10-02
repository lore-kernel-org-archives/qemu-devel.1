Received: from eggs.gnu.org ([2001:4830:134:3::10]:38916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bh-00082O-9f
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bb-0007xl-Sz
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2bb-0007wM-HE
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:03 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:45 +0200
Message-Id: <20171002152552.27999-26-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 25/32] qapi-introspect: Include command
 line options information
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com
List-ID: <qemu-devel.nongnu.org>

Make query-qmp-schema describe command line options in addition to QMP
commands and events.  Simple, but it pushes query-qmp-schema beyond
QMP.  Perhaps options introspection should be separate.  Perhaps not
for the same reason QMP and command line are defined in the same
schema: they share many types.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/introspect.json       | 22 ++++++++++++++++++++--
 scripts/qapi-introspect.py | 10 +++++++++-
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/qapi/introspect.json b/qapi/introspect.json
index 5b3e6e9d78..0b6be5b19c 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -70,11 +70,13 @@
 #
 # @event: a QMP event
 #
+# @option: a command line option (since 2.11)
+#
 # Since: 2.5
 ##
 { 'enum': 'SchemaMetaType',
   'data': [ 'builtin', 'enum', 'array', 'object', 'alternate',
-            'command', 'event' ] }
+            'command', 'event', 'option' ] }
 
 ##
 # @SchemaInfo:
@@ -103,7 +105,8 @@
       'object': 'SchemaInfoObject',
       'alternate': 'SchemaInfoAlternate',
       'command': 'SchemaInfoCommand',
-      'event': 'SchemaInfoEvent' } }
+      'event': 'SchemaInfoEvent',
+      'option': 'SchemaInfoOption' } }
 
 ##
 # @SchemaInfoBuiltin:
@@ -278,3 +281,18 @@
 ##
 { 'struct': 'SchemaInfoEvent',
   'data': { 'arg-type': 'str' } }
+
+##
+# @SchemaInfoOption:
+#
+# Additional SchemaInfo members for meta-type 'option'.
+#
+# @arg-type: the name of the object type that provides the option's
+#            parameters.
+#
+# @short: the option character, if any.
+#
+# Since: 2.11
+##
+{ 'struct': 'SchemaInfoOption',
+  'data': { 'arg-type': 'str', '*short': 'str' } }
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 52404b07ab..650e5597b0 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -108,7 +108,7 @@ const char %(c_name)s[] = %(c_string)s;
         return self._name(typ.name)
 
     def _gen_json(self, name, mtype, obj):
-        if mtype not in ('command', 'event', 'builtin', 'array'):
+        if mtype not in ('command', 'event', 'option', 'builtin', 'array'):
             name = self._name(name)
         obj['name'] = name
         obj['meta-type'] = mtype
@@ -161,6 +161,14 @@ const char %(c_name)s[] = %(c_string)s;
         arg_type = arg_type or self._schema.the_empty_object_type
         self._gen_json(name, 'event', {'arg-type': self._use_type(arg_type)})
 
+    def visit_option(self, name, info, arg_type, short, implied_key,
+                     boxed, help_):
+        arg_type = arg_type or self._schema.the_empty_object_type
+        obj = {'arg-type': self._use_type(arg_type)}
+        if short:
+            obj['short'] = short
+        self._gen_json(name, 'option', obj)
+
 parser = common_argument_parser()
 # Debugging aid: unmask QAPI schema's type names
 # We normally mask them, because they're not QMP wire ABI
-- 
2.13.6
