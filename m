Received: from eggs.gnu.org ([2001:4830:134:3::10]:43799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ffiPN-00045k-4t
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 05:06:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ffiPJ-0003ID-VH
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 05:06:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33814 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ffiPJ-0003Hb-Qb
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 05:06:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A53A540214E2
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 09:06:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 18 Jul 2018 11:05:57 +0200
Message-Id: <20180718090557.17248-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.0] qapi: Make 'allow-oob' optional in
 SchemaInfoCommand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, peterx@redhat.com

Making 'allow-oob' optional in SchemaInfoCommand permits omitting it
in the common case.  Shrinks query-qmp-schema's output from 122.1KiB
to 118.6KiB for me.

Note that out-of-band execution is still experimental (you have to
configure the monitor with x-oob=on to use it).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/introspect.json       |  6 +++---
 scripts/qapi/introspect.py | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/qapi/introspect.json b/qapi/introspect.json
index c7f67b7d78..137b39b992 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -259,8 +259,8 @@
 #
 # @ret-type: the name of the command's result type.
 #
-# @allow-oob: whether the command allows out-of-band execution.
-#             (Since: 2.12)
+# @allow-oob: whether the command allows out-of-band execution,
+#             defaults to false (Since: 2.12)
 #
 # TODO: @success-response (currently irrelevant, because it's QGA, not QMP)
 #
@@ -268,7 +268,7 @@
 ##
 { 'struct': 'SchemaInfoCommand',
   'data': { 'arg-type': 'str', 'ret-type': 'str',
-            'allow-oob': 'bool' } }
+            '*allow-oob': 'bool' } }
 
 ##
 # @SchemaInfoEvent:
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 70ca5dd876..189a4edaba 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -184,11 +184,11 @@ const QLitObject %(c_name)s = %(c_string)s;
                       success_response, boxed, allow_oob, allow_preconfig):
         arg_type = arg_type or self._schema.the_empty_object_type
         ret_type = ret_type or self._schema.the_empty_object_type
-        self._gen_qlit(name, 'command',
-                       {'arg-type': self._use_type(arg_type),
-                        'ret-type': self._use_type(ret_type),
-                        'allow-oob': allow_oob},
-                       ifcond)
+        obj = {'arg-type': self._use_type(arg_type),
+               'ret-type': self._use_type(ret_type) }
+        if allow_oob:
+            obj['allow-oob'] = allow_oob
+        self._gen_qlit(name, 'command', obj, ifcond)
 
     def visit_event(self, name, info, ifcond, arg_type, boxed):
         arg_type = arg_type or self._schema.the_empty_object_type
-- 
2.17.1
