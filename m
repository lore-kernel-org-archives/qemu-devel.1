Received: from eggs.gnu.org ([2001:4830:134:3::10]:58771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dW7H8-000757-Qm
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 16:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dW7H5-0002zG-GU
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 16:33:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dW7H5-0002ys-7H
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 16:33:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C862120FD
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 20:33:18 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 14 Jul 2017 17:33:13 -0300
Message-Id: <20170714203313.31041-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] qapi: Fix error handling code on alternate
 conflict
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The conflict check added by commit c0644771 ("qapi: Reject
alternates that can't work with keyval_parse()") doesn't work
with the following declaration:

  { 'alternate': 'Alt',
    'data': { 'one': 'bool',
              'two': 'str' } }

It crashes with:

  Traceback (most recent call last):
    File "./scripts/qapi-types.py", line 295, in <module>
      schema = QAPISchema(input_file)
    File "/home/ehabkost/rh/proj/virt/qemu/scripts/qapi.py", line 1468, in __init__
      self.exprs = check_exprs(parser.exprs)
    File "/home/ehabkost/rh/proj/virt/qemu/scripts/qapi.py", line 958, in check_exprs
      check_alternate(expr, info)
    File "/home/ehabkost/rh/proj/virt/qemu/scripts/qapi.py", line 830, in check_alternate
      % (name, key, types_seen[qtype]))
  KeyError: 'QTYPE_QSTRING'

This happens because the previously-seen conflicting member
('one') can't be found at types_seen[qtype], but at
types_seen['QTYPE_BOOL'].

Fix the bug by moving the error check to the same loop that adds
new items to types_seen, raising an exception if types_seen[qt]
is already set.

Add two additional test cases that can detect the bug.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qapi.py                                       | 8 ++++----
 tests/Makefile.include                                | 2 ++
 tests/qapi-schema/alternate-conflict-bool-string.err  | 1 +
 tests/qapi-schema/alternate-conflict-bool-string.exit | 1 +
 tests/qapi-schema/alternate-conflict-bool-string.json | 4 ++++
 tests/qapi-schema/alternate-conflict-bool-string.out  | 0
 tests/qapi-schema/alternate-conflict-num-string.err   | 1 +
 tests/qapi-schema/alternate-conflict-num-string.exit  | 1 +
 tests/qapi-schema/alternate-conflict-num-string.json  | 4 ++++
 tests/qapi-schema/alternate-conflict-num-string.out   | 0
 tests/qapi-schema/alternate-multi-conflict.json       | 0
 11 files changed, 18 insertions(+), 4 deletions(-)
 create mode 100644 tests/qapi-schema/alternate-conflict-bool-string.err
 create mode 100644 tests/qapi-schema/alternate-conflict-bool-string.exit
 create mode 100644 tests/qapi-schema/alternate-conflict-bool-string.json
 create mode 100644 tests/qapi-schema/alternate-conflict-bool-string.out
 create mode 100644 tests/qapi-schema/alternate-conflict-num-string.err
 create mode 100644 tests/qapi-schema/alternate-conflict-num-string.exit
 create mode 100644 tests/qapi-schema/alternate-conflict-num-string.json
 create mode 100644 tests/qapi-schema/alternate-conflict-num-string.out
 create mode 100644 tests/qapi-schema/alternate-multi-conflict.json

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 84e2eb4..a9c12e5 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -824,11 +824,11 @@ def check_alternate(expr, info):
             else:
                 conflicting.add('QTYPE_QNUM')
                 conflicting.add('QTYPE_QBOOL')
-        if conflicting & set(types_seen):
-            raise QAPISemError(info, "Alternate '%s' member '%s' can't "
-                               "be distinguished from member '%s'"
-                               % (name, key, types_seen[qtype]))
         for qt in conflicting:
+            if qt in types_seen:
+                raise QAPISemError(info, "Alternate '%s' member '%s' can't "
+                                   "be distinguished from member '%s'"
+                                   % (name, key, types_seen[qt]))
             types_seen[qt] = key
 
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 42e17e2..40cf1dd 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -346,6 +346,8 @@ qapi-schema += alternate-conflict-dict.json
 qapi-schema += alternate-conflict-enum-bool.json
 qapi-schema += alternate-conflict-enum-int.json
 qapi-schema += alternate-conflict-string.json
+qapi-schema += alternate-conflict-bool-string.json
+qapi-schema += alternate-conflict-num-string.json
 qapi-schema += alternate-empty.json
 qapi-schema += alternate-nested.json
 qapi-schema += alternate-unknown.json
diff --git a/tests/qapi-schema/alternate-conflict-bool-string.err b/tests/qapi-schema/alternate-conflict-bool-string.err
new file mode 100644
index 0000000..5c9af91
--- /dev/null
+++ b/tests/qapi-schema/alternate-conflict-bool-string.err
@@ -0,0 +1 @@
+tests/qapi-schema/alternate-conflict-bool-string.json:3: Alternate 'Alt' member 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-bool-string.exit b/tests/qapi-schema/alternate-conflict-bool-string.exit
new file mode 100644
index 0000000..d00491f
--- /dev/null
+++ b/tests/qapi-schema/alternate-conflict-bool-string.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/alternate-conflict-bool-string.json b/tests/qapi-schema/alternate-conflict-bool-string.json
new file mode 100644
index 0000000..0544de1
--- /dev/null
+++ b/tests/qapi-schema/alternate-conflict-bool-string.json
@@ -0,0 +1,4 @@
+# alternate branches of 'str' type conflict with all scalar types
+{ 'alternate': 'Alt',
+  'data': { 'one': 'bool',
+            'two': 'str' } }
diff --git a/tests/qapi-schema/alternate-conflict-bool-string.out b/tests/qapi-schema/alternate-conflict-bool-string.out
new file mode 100644
index 0000000..e69de29
diff --git a/tests/qapi-schema/alternate-conflict-num-string.err b/tests/qapi-schema/alternate-conflict-num-string.err
new file mode 100644
index 0000000..d8c6a88
--- /dev/null
+++ b/tests/qapi-schema/alternate-conflict-num-string.err
@@ -0,0 +1 @@
+tests/qapi-schema/alternate-conflict-num-string.json:3: Alternate 'Alt' member 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-num-string.exit b/tests/qapi-schema/alternate-conflict-num-string.exit
new file mode 100644
index 0000000..d00491f
--- /dev/null
+++ b/tests/qapi-schema/alternate-conflict-num-string.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/alternate-conflict-num-string.json b/tests/qapi-schema/alternate-conflict-num-string.json
new file mode 100644
index 0000000..ae90144
--- /dev/null
+++ b/tests/qapi-schema/alternate-conflict-num-string.json
@@ -0,0 +1,4 @@
+# alternate branches of 'str' type conflict with all scalar types
+{ 'alternate': 'Alt',
+  'data': { 'one': 'number',
+            'two': 'str' } }
diff --git a/tests/qapi-schema/alternate-conflict-num-string.out b/tests/qapi-schema/alternate-conflict-num-string.out
new file mode 100644
index 0000000..e69de29
diff --git a/tests/qapi-schema/alternate-multi-conflict.json b/tests/qapi-schema/alternate-multi-conflict.json
new file mode 100644
index 0000000..e69de29
-- 
2.9.4
