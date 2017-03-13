Received: from eggs.gnu.org ([2001:4830:134:3::10]:52545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJu-0007d0-9V
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJn-0003gO-Gy
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:19:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnJJn-0003e3-4y
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:55 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 13 Mar 2017 07:18:44 +0100
Message-Id: <1489385927-6735-45-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 44/47] qapi: union_types is a list used
 like a dict, make it one
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index ab266db..870ff4e 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -48,7 +48,7 @@ name_case_whitelist = []
 
 enum_types = {}
 struct_types = {}
-union_types = []
+union_types = {}
 all_names = {}
 
 #
@@ -564,7 +564,7 @@ def find_alternate_member_qtype(qapi_type):
         return 'QTYPE_QDICT'
     elif qapi_type in enum_types:
         return 'QTYPE_QSTRING'
-    elif find_union(qapi_type):
+    elif qapi_type in union_types:
         return 'QTYPE_QDICT'
     return None
 
@@ -633,19 +633,6 @@ def add_name(name, info, meta, implicit=False):
     all_names[name] = meta
 
 
-def add_union(definition, info):
-    global union_types
-    union_types.append(definition)
-
-
-def find_union(name):
-    global union_types
-    for union in union_types:
-        if union['union'] == name:
-            return union
-    return None
-
-
 def check_type(info, source, value, allow_array=False,
                allow_dict=False, allow_optional=False,
                allow_metas=[]):
@@ -903,7 +890,7 @@ def check_exprs(exprs):
             meta = 'union'
             check_keys(expr_elem, 'union', ['data'],
                        ['base', 'discriminator'])
-            add_union(expr, info)
+            union_types[expr[meta]] = expr
         elif 'alternate' in expr:
             meta = 'alternate'
             check_keys(expr_elem, 'alternate', ['data'])
-- 
2.7.4
