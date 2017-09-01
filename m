Received: from eggs.gnu.org ([2001:4830:134:3::10]:53821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUi-0000F1-1W
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUd-0007IH-9X
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnlUd-0007Hr-0Q
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 01E147F3F9
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:56:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 14:55:25 +0200
Message-Id: <20170901125611.29295-2-armbru@redhat.com>
In-Reply-To: <20170901125611.29295-1-armbru@redhat.com>
References: <20170901125611.29295-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 01/47] qapi: Fix error handling code on
 alternate conflict
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>

From: Eduardo Habkost <ehabkost@redhat.com>

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
Message-Id: <20170717180926.14924-1-ehabkost@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
 10 files changed, 18 insertions(+), 4 deletions(-)
 create mode 100644 tests/qapi-schema/alternate-conflict-bool-string.err
 create mode 100644 tests/qapi-schema/alternate-conflict-bool-string.exit
 create mode 100644 tests/qapi-schema/alternate-conflict-bool-string.json
 create mode 100644 tests/qapi-schema/alternate-conflict-bool-string.out
 create mode 100644 tests/qapi-schema/alternate-conflict-num-string.err
 create mode 100644 tests/qapi-schema/alternate-conflict-num-string.exit
 create mode 100644 tests/qapi-schema/alternate-conflict-num-string.json
 create mode 100644 tests/qapi-schema/alternate-conflict-num-string.out

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 8aa2775f12..3693b520da 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -825,11 +825,11 @@ def check_alternate(expr, info):
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
index f08b7418f0..00af45ca85 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -376,6 +376,8 @@ qapi-schema += alternate-conflict-dict.json
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
index 0000000000..e52fee7620
--- /dev/null
+++ b/tests/qapi-schema/alternate-conflict-bool-string.err
@@ -0,0 +1 @@
+tests/qapi-schema/alternate-conflict-bool-string.json:2: Alternate 'Alt' member 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-bool-string.exit b/tests/qapi-schema/alternate-conflict-bool-string.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/alternate-conflict-bool-string.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/alternate-conflict-bool-string.json b/tests/qapi-schema/alternate-conflict-bool-string.json
new file mode 100644
index 0000000000..0544de10f3
--- /dev/null
+++ b/tests/qapi-schema/alternate-conflict-bool-string.json
@@ -0,0 +1,4 @@
+# alternate branches of 'str' type conflict with all scalar types
+{ 'alternate': 'Alt',
+  'data': { 'one': 'bool',
+            'two': 'str' } }
diff --git a/tests/qapi-schema/alternate-conflict-bool-string.out b/tests/qapi-schema/alternate-conflict-bool-string.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/alternate-conflict-num-string.err b/tests/qapi-schema/alternate-conflict-num-string.err
new file mode 100644
index 0000000000..5ba3827dd1
--- /dev/null
+++ b/tests/qapi-schema/alternate-conflict-num-string.err
@@ -0,0 +1 @@
+tests/qapi-schema/alternate-conflict-num-string.json:2: Alternate 'Alt' member 'two' can't be distinguished from member 'one'
diff --git a/tests/qapi-schema/alternate-conflict-num-string.exit b/tests/qapi-schema/alternate-conflict-num-string.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/alternate-conflict-num-string.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/alternate-conflict-num-string.json b/tests/qapi-schema/alternate-conflict-num-string.json
new file mode 100644
index 0000000000..ae901449af
--- /dev/null
+++ b/tests/qapi-schema/alternate-conflict-num-string.json
@@ -0,0 +1,4 @@
+# alternate branches of 'str' type conflict with all scalar types
+{ 'alternate': 'Alt',
+  'data': { 'one': 'number',
+            'two': 'str' } }
diff --git a/tests/qapi-schema/alternate-conflict-num-string.out b/tests/qapi-schema/alternate-conflict-num-string.out
new file mode 100644
index 0000000000..e69de29bb2
-- 
2.13.5
