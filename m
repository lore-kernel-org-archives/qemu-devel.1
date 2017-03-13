Received: from eggs.gnu.org ([2001:4830:134:3::10]:52198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJm-0007XQ-9B
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJj-0003Yc-SO
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnJJj-0003XO-Jb
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:51 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 13 Mar 2017 07:18:06 +0100
Message-Id: <1489385927-6735-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 06/47] qapi: Have each QAPI schema
 declare its name rule violations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

qapi.py has a hardcoded white-list of type names that may violate the
rule on use of upper and lower case.  Add a new pragma directive
'name-case-whitelist', and use it to replace the hard-coded
white-list.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/qapi-code-gen.txt                  |  6 ++++++
 qapi-schema.json                        | 11 ++++++++++-
 scripts/qapi.py                         | 22 ++++++++++------------
 tests/qapi-schema/enum-member-case.err  |  2 +-
 tests/qapi-schema/enum-member-case.json |  1 +
 5 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/docs/qapi-code-gen.txt b/docs/qapi-code-gen.txt
index e907e57..349dc02 100644
--- a/docs/qapi-code-gen.txt
+++ b/docs/qapi-code-gen.txt
@@ -252,6 +252,9 @@ Any name (command, event, type, member, or enum value) beginning with
 "x-" is marked experimental, and may be withdrawn or changed
 incompatibly in a future release.
 
+Pragma 'name-case-whitelist' lets you violate the rules on use of
+upper and lower case.  Use for new code is strongly discouraged.
+
 In the rest of this document, usage lines are given for each
 expression type, with literal strings written in lower case and
 placeholders written in capitals.  If a literal string includes a
@@ -318,6 +321,9 @@ is required.  Default is false.
 Pragma 'returns-whitelist' takes a list of command names that may
 violate the rules on permitted return types.  Default is none.
 
+Pragma 'name-case-whitelist' takes a list of names that may violate
+rules on use of upper- vs. lower-case letters.  Default is none.
+
 
 === Struct types ===
 
diff --git a/qapi-schema.json b/qapi-schema.json
index 93e9e98..17c766e 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -61,7 +61,16 @@
         'query-migrate-cache-size',
         'query-tpm-models',
         'query-tpm-types',
-        'ringbuf-read' ] } }
+        'ringbuf-read' ],
+    'name-case-whitelist': [
+        'ACPISlotType',         # DIMM, visible through query-acpi-ospm-status
+        'CpuInfoMIPS',          # PC, visible through query-cpu
+        'CpuInfoTricore',       # PC, visible through query-cpu
+        'QapiErrorClass',       # all members, visible through errors
+        'UuidInfo',             # UUID, visible through query-uuid
+        'X86CPURegister32',     # all members, visible indirectly through qom-get
+        'q_obj_CpuInfo-base'    # CPU, visible through query-cpu
+    ] } }
 
 # QAPI common definitions
 { 'include': 'qapi/common.json' }
diff --git a/scripts/qapi.py b/scripts/qapi.py
index a90b682..e98fd0c 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -44,16 +44,7 @@ doc_required = False
 returns_whitelist = []
 
 # Whitelist of entities allowed to violate case conventions
-case_whitelist = [
-    # From QMP:
-    'ACPISlotType',         # DIMM, visible through query-acpi-ospm-status
-    'CpuInfoMIPS',          # PC, visible through query-cpu
-    'CpuInfoTricore',       # PC, visible through query-cpu
-    'QapiErrorClass',       # all members, visible through errors
-    'UuidInfo',             # UUID, visible through query-uuid
-    'X86CPURegister32',     # all members, visible indirectly through qom-get
-    'q_obj_CpuInfo-base',   # CPU, visible through query-cpu
-]
+name_case_whitelist = []
 
 enum_types = []
 struct_types = []
@@ -298,7 +289,7 @@ class QAPISchemaParser(object):
         self.docs.extend(exprs_include.docs)
 
     def _pragma(self, name, value, info):
-        global doc_required, returns_whitelist
+        global doc_required, returns_whitelist, name_case_whitelist
         if name == 'doc-required':
             if not isinstance(value, bool):
                 raise QAPISemError(info,
@@ -311,6 +302,13 @@ class QAPISchemaParser(object):
                                    "Pragma returns-whitelist must be"
                                    " a list of strings")
             returns_whitelist = value
+        elif name == 'name-case-whitelist':
+            if (not isinstance(value, list)
+                    or any([not isinstance(elt, str) for elt in value])):
+                raise QAPISemError(info,
+                                   "Pragma name-case-whitelist must be"
+                                   " a list of strings")
+            name_case_whitelist = value
         else:
             raise QAPISemError(info, "Unknown pragma '%s'" % name)
 
@@ -1283,7 +1281,7 @@ class QAPISchemaMember(object):
 
     def check_clash(self, info, seen):
         cname = c_name(self.name)
-        if cname.lower() != cname and self.owner not in case_whitelist:
+        if cname.lower() != cname and self.owner not in name_case_whitelist:
             raise QAPISemError(info,
                                "%s should not use uppercase" % self.describe())
         if cname in seen:
diff --git a/tests/qapi-schema/enum-member-case.err b/tests/qapi-schema/enum-member-case.err
index b652e9a..3c67a3a 100644
--- a/tests/qapi-schema/enum-member-case.err
+++ b/tests/qapi-schema/enum-member-case.err
@@ -1 +1 @@
-tests/qapi-schema/enum-member-case.json:3: 'Value' (member of NoWayThisWillGetWhitelisted) should not use uppercase
+tests/qapi-schema/enum-member-case.json:4: 'Value' (member of NoWayThisWillGetWhitelisted) should not use uppercase
diff --git a/tests/qapi-schema/enum-member-case.json b/tests/qapi-schema/enum-member-case.json
index 2096b35..f8af3e4 100644
--- a/tests/qapi-schema/enum-member-case.json
+++ b/tests/qapi-schema/enum-member-case.json
@@ -1,3 +1,4 @@
 # Member names should be 'lower-case' unless the enum is whitelisted
+{ 'pragma': { 'name-case-whitelist': [ 'UuidInfo' ] } }
 { 'enum': 'UuidInfo', 'data': [ 'Value' ] } # UuidInfo is whitelisted
 { 'enum': 'NoWayThisWillGetWhitelisted', 'data': [ 'Value' ] }
-- 
2.7.4
