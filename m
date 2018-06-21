Received: from eggs.gnu.org ([2001:4830:134:3::10]:55549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVv4Q-0006m2-2g
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 04:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVv4L-0002Li-2B
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 04:35:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40558 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fVv4K-0002L1-TF
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 04:35:53 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 21 Jun 2018 10:35:51 +0200
Message-Id: <20180621083551.775-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH] qapi: Fix some pycodestyle-3 complaints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

Fix the following issues:

    common.py:873:13: E129 visually indented line with same indent as next logical line
    common.py:1766:5: E741 ambiguous variable name 'l'
    common.py:1784:1: E305 expected 2 blank lines after class or function definition, found 1
    common.py:1833:1: E305 expected 2 blank lines after class or function definition, found 1
    common.py:1843:1: E305 expected 2 blank lines after class or function definition, found 1
    visit.py:181:18: E127 continuation line over-indented for visual indent

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py | 15 +++++++++------
 scripts/qapi/visit.py  |  2 +-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 2462fc0291..e51767d44d 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -865,12 +865,12 @@ def check_keys(expr_elem, meta, required, optional=[]):
         if key not in required and key not in optional:
             raise QAPISemError(info, "Unknown key '%s' in %s '%s'"
                                % (key, meta, name))
-        if (key == 'gen' or key == 'success-response') and value is not False:
+        if key in ['gen', 'success-response'] and value is not False:
             raise QAPISemError(info,
                                "'%s' of %s '%s' should only use false value"
                                % (key, meta, name))
-        if (key == 'boxed' or key == 'allow-oob' or
-            key == 'allow-preconfig') and value is not True:
+        if (key in ['boxed', 'allow-oob', 'allow-preconfig']
+                and value is not True):
             raise QAPISemError(info,
                                "'%s' of %s '%s' should only use true value"
                                % (key, meta, name))
@@ -1763,12 +1763,12 @@ def camel_to_upper(value):
         return c_fun_str
 
     new_name = ''
-    l = len(c_fun_str)
-    for i in range(l):
+    length = len(c_fun_str)
+    for i in range(length):
         c = c_fun_str[i]
         # When c is upper and no '_' appears before, do more checks
         if c.isupper() and (i > 0) and c_fun_str[i - 1] != '_':
-            if i < l - 1 and c_fun_str[i + 1].islower():
+            if i < length - 1 and c_fun_str[i + 1].islower():
                 new_name += '_'
             elif c_fun_str[i - 1].isdigit():
                 new_name += '_'
@@ -1781,6 +1781,7 @@ def c_enum_const(type_name, const_name, prefix=None):
         type_name = prefix
     return camel_to_upper(type_name) + '_' + c_name(const_name, False).upper()
 
+
 if hasattr(str, 'maketrans'):
     c_name_trans = str.maketrans('.-', '__')
 else:
@@ -1830,6 +1831,7 @@ def c_name(name, protect=True):
         return 'q_' + name
     return name
 
+
 eatspace = '\033EATSPACE.'
 pointer_suffix = ' *' + eatspace
 
@@ -1840,6 +1842,7 @@ def genindent(count):
         ret += ' '
     return ret
 
+
 indent_level = 0
 
 
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 5d72d8936c..1827c2a094 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -178,7 +178,7 @@ void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error
     }
     switch ((*obj)->type) {
 ''',
-                 c_name=c_name(name))
+                c_name=c_name(name))
 
     for var in variants.variants:
         ret += mcgen('''
-- 
2.17.1
