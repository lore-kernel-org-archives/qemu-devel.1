Received: from eggs.gnu.org ([2001:4830:134:3::10]:38867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bf-00080R-KT
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bd-0007zP-H6
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2bd-0007yk-A5
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:05 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:42 +0200
Message-Id: <20171002152552.27999-23-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 22/32] qapi: New helper c_string()
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

Use new c_string() to replace qapi-introspect's more limited
to_c_string().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi-introspect.py |  8 ++------
 scripts/qapi.py            | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 89365449b0..52404b07ab 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -35,10 +35,6 @@ def to_json(obj, level=0):
     return ret
 
 
-def to_c_string(string):
-    return '"' + string.replace('\\', r'\\').replace('"', r'\"') + '"'
-
-
 class QAPISchemaGenIntrospectVisitor(QAPISchemaVisitor):
     def __init__(self, unmask):
         self._unmask = unmask
@@ -70,12 +66,12 @@ extern const char %(c_name)s[];
 ''',
                           c_name=c_name(name))
         lines = to_json(jsons).split('\n')
-        c_string = '\n    '.join([to_c_string(line) for line in lines])
         self.defn = mcgen('''
 const char %(c_name)s[] = %(c_string)s;
 ''',
                           c_name=c_name(name),
-                          c_string=c_string)
+                          c_string='\n    '.join([c_string(line)
+                                                  for line in lines]))
         self._schema = None
         self._jsons = None
         self._used_types = None
diff --git a/scripts/qapi.py b/scripts/qapi.py
index efc128eee0..958249fbd8 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1915,6 +1915,21 @@ def c_name(name, protect=True):
         return 'q_' + name
     return name
 
+
+def c_string(string):
+    def escape_ch(match):
+        ch = match.group(0)
+        esc = {'\a': 'a', '\b': 'b', '\f': 'f', '\n': 'n', '\r': 'r',
+               '\t': 't', '\v': 'v', '"': r'"', '\\': '\\'}.get(ch)
+        if not esc:
+            esc = 'x%02x' % ord(ch)
+        return '\\' + esc
+
+    if string is None:
+        return "NULL"
+    return '"' + re.sub(r'[\0-\37"\\\177]', escape_ch, string) + '"'
+
+
 eatspace = '\033EATSPACE.'
 pointer_suffix = ' *' + eatspace
 
-- 
2.13.6
