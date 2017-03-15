Received: from eggs.gnu.org ([2001:4830:134:3::10]:33335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Uq-0001VE-MB
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Un-0000Gp-UT
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co8Un-0000GD-LR
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:41 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Mar 2017 13:56:55 +0100
Message-Id: <1489582656-31133-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-1-git-send-email-armbru@redhat.com>
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.9 06/47] qapi: Have each QAPI schema
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
 docs/qapi-code-gen.txt                             |  6 ++++++
 qapi-schema.json                                   | 11 ++++++++++-
 scripts/qapi.py                                    | 22 ++++++++++------------
 tests/Makefile.include                             |  1 +
 tests/qapi-schema/enum-member-case.err             |  2 +-
 tests/qapi-schema/enum-member-case.json            |  1 +
 .../pragma-name-case-whitelist-crap.err            |  1 +
 .../pragma-name-case-whitelist-crap.exit           |  1 +
 .../pragma-name-case-whitelist-crap.json           |  3 +++
 .../pragma-name-case-whitelist-crap.out            |  0
 10 files changed, 34 insertions(+), 14 deletions(-)
 create mode 100644 tests/qapi-schema/pragma-name-case-whitelist-crap.err
 create mode 100644 tests/qapi-schema/pragma-name-case-whitelist-crap.exit
 create mode 100644 tests/qapi-schema/pragma-name-case-whitelist-crap.json
 create mode 100644 tests/qapi-schema/pragma-name-case-whitelist-crap.out

diff --git a/docs/qapi-code-gen.txt b/docs/qapi-code-gen.txt
index 0a04419..03ab2a8 100644
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
@@ -321,6 +324,9 @@ is required.  Default is false.
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
index 1d86d85..78db319 100644
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
@@ -302,7 +293,7 @@ class QAPISchemaParser(object):
         self.docs.extend(exprs_include.docs)
 
     def _pragma(self, name, value, info):
-        global doc_required, returns_whitelist
+        global doc_required, returns_whitelist, name_case_whitelist
         if name == 'doc-required':
             if not isinstance(value, bool):
                 raise QAPISemError(info,
@@ -315,6 +306,13 @@ class QAPISchemaParser(object):
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
 
@@ -1287,7 +1285,7 @@ class QAPISchemaMember(object):
 
     def check_clash(self, info, seen):
         cname = c_name(self.name)
-        if cname.lower() != cname and self.owner not in case_whitelist:
+        if cname.lower() != cname and self.owner not in name_case_whitelist:
             raise QAPISemError(info,
                                "%s should not use uppercase" % self.describe())
         if cname in seen:
diff --git a/tests/Makefile.include b/tests/Makefile.include
index f9da3aa..16e0a9f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -443,6 +443,7 @@ qapi-schema += nested-struct-data.json
 qapi-schema += non-objects.json
 qapi-schema += pragma-doc-required-crap.json
 qapi-schema += pragma-extra-junk.json
+qapi-schema += pragma-name-case-whitelist-crap.json
 qapi-schema += pragma-non-dict.json
 qapi-schema += pragma-returns-whitelist-crap.json
 qapi-schema += qapi-schema-test.json
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
diff --git a/tests/qapi-schema/pragma-name-case-whitelist-crap.err b/tests/qapi-schema/pragma-name-case-whitelist-crap.err
new file mode 100644
index 0000000..f83b97e
--- /dev/null
+++ b/tests/qapi-schema/pragma-name-case-whitelist-crap.err
@@ -0,0 +1 @@
+tests/qapi-schema/pragma-name-case-whitelist-crap.json:3: Pragma name-case-whitelist must be a list of strings
diff --git a/tests/qapi-schema/pragma-name-case-whitelist-crap.exit b/tests/qapi-schema/pragma-name-case-whitelist-crap.exit
new file mode 100644
index 0000000..d00491f
--- /dev/null
+++ b/tests/qapi-schema/pragma-name-case-whitelist-crap.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/pragma-name-case-whitelist-crap.json b/tests/qapi-schema/pragma-name-case-whitelist-crap.json
new file mode 100644
index 0000000..58382bf
--- /dev/null
+++ b/tests/qapi-schema/pragma-name-case-whitelist-crap.json
@@ -0,0 +1,3 @@
+# 'name-case-whitelist' must be list of strings
+
+{ 'pragma': { 'name-case-whitelist': null } }
diff --git a/tests/qapi-schema/pragma-name-case-whitelist-crap.out b/tests/qapi-schema/pragma-name-case-whitelist-crap.out
new file mode 100644
index 0000000..e69de29
-- 
2.7.4
