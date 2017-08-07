Received: from eggs.gnu.org ([2001:4830:134:3::10]:34583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dverma@redhat.com>) id 1delPu-0005uP-Sn
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 13:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dverma@redhat.com>) id 1delPp-0005Wt-9I
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 13:02:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6379)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dverma@redhat.com>) id 1delPo-0005Sw-W2
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 13:02:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A89488125F
	for <qemu-devel@nongnu.org>; Mon,  7 Aug 2017 16:53:49 +0000 (UTC)
From: dverma <dverma@redhat.com>
Date: Mon,  7 Aug 2017 12:53:28 -0400
Message-Id: <1502124810-6930-2-git-send-email-dverma@redhat.com>
In-Reply-To: <1502124810-6930-1-git-send-email-dverma@redhat.com>
References: <1502124810-6930-1-git-send-email-dverma@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/3] Fix format and styles;
 make code more pythonic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jen@redhat.com, dgilbert@redhat.com, quintela@redhat.com, dverma <dverma@redhat.com>

- Format fixes, cleaned up the print statement
- Style fixes, e.g. changed "if not x in y" to "if x not in y"
- Improved variable names
---
 scripts/vmstate-static-checker.py | 111 +++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 49 deletions(-)

diff --git a/scripts/vmstate-static-checker.py b/scripts/vmstate-static-checker.py
index bcef7ee..b416b66 100755
--- a/scripts/vmstate-static-checker.py
+++ b/scripts/vmstate-static-checker.py
@@ -19,6 +19,11 @@
 # You should have received a copy of the GNU General Public License along
 # with this program; if not, see <http://www.gnu.org/licenses/>.
 
+#
+# 2017 Deepak Verma <dverma@redhat.com>
+# Added few functions and fields for whitelisting
+#
+
 import argparse
 import json
 import sys
@@ -26,6 +31,7 @@ import sys
 # Count the number of errors found
 taint = 0
 
+
 def bump_taint():
     global taint
 
@@ -92,7 +98,7 @@ def check_fields_match(name, s_field, d_field):
                       'io_win_size', 'mig_io_win_size'],
     }
 
-    if not name in changed_names:
+    if name not in changed_names:
         return False
 
     if s_field in changed_names[name] and d_field in changed_names[name]:
@@ -100,6 +106,7 @@ def check_fields_match(name, s_field, d_field):
 
     return False
 
+
 def get_changed_sec_name(sec):
     # Section names can change -- see commit 292b1634 for an example.
     changes = {
@@ -114,16 +121,17 @@ def get_changed_sec_name(sec):
             return item
     return ""
 
+
 def exists_in_substruct(fields, item):
     # Some QEMU versions moved a few fields inside a substruct.  This
     # kept the on-wire format the same.  This function checks if
     # something got shifted inside a substruct.  For example, the
     # change in commit 1f42d22233b4f3d1a2933ff30e8d6a6d9ee2d08f
 
-    if not "Description" in fields:
+    if "Description" not in fields:
         return False
 
-    if not "Fields" in fields["Description"]:
+    if "Fields" not in fields["Description"]:
         return False
 
     substruct_fields = fields["Description"]["Fields"]
@@ -176,10 +184,10 @@ def check_fields(src_fields, dest_fields, desc, sec):
             except StopIteration:
                 if d_iter_list == []:
                     # We were not in a substruct
-                    print "Section \"" + sec + "\",",
-                    print "Description " + "\"" + desc + "\":",
-                    print "expected field \"" + s_item["field"] + "\",",
-                    print "while dest has no further fields"
+                    print('Section "' + sec + '", '
+                          'Description "' + desc + '": '
+                          'expected field "' + s_item["field"] + '", '
+                          'while dest has no further fields')
                     bump_taint()
                     break
 
@@ -191,30 +199,28 @@ def check_fields(src_fields, dest_fields, desc, sec):
                 advance_dest = True
 
         if unused_count != 0:
-            if advance_dest == False:
+            if not advance_dest:
                 unused_count = unused_count - s_item["size"]
                 if unused_count == 0:
                     advance_dest = True
                     continue
                 if unused_count < 0:
-                    print "Section \"" + sec + "\",",
-                    print "Description \"" + desc + "\":",
-                    print "unused size mismatch near \"",
-                    print s_item["field"] + "\""
+                    print('Section "' + sec + '", '
+                          'Description "' + desc + '": '
+                          'unused size mismatch near "' + s_item["field"] + '"')
                     bump_taint()
                     break
                 continue
 
-            if advance_src == False:
+            if not advance_src:
                 unused_count = unused_count - d_item["size"]
                 if unused_count == 0:
                     advance_src = True
                     continue
                 if unused_count < 0:
-                    print "Section \"" + sec + "\",",
-                    print "Description \"" + desc + "\":",
-                    print "unused size mismatch near \"",
-                    print d_item["field"] + "\""
+                    print('Section "' + sec + '", '
+                          'Description "' + desc + '": '
+                          'unused size mismatch near "' + d_item["field"] + '"')
                     bump_taint()
                     break
                 continue
@@ -262,16 +268,16 @@ def check_fields(src_fields, dest_fields, desc, sec):
                     unused_count = s_item["size"] - d_item["size"]
                     continue
 
-            print "Section \"" + sec + "\",",
-            print "Description \"" + desc + "\":",
-            print "expected field \"" + s_item["field"] + "\",",
-            print "got \"" + d_item["field"] + "\"; skipping rest"
+            print('Section "' + sec + '", '
+                  'Description "' + desc + '": '
+                  'expected field "' + s_item["field"] + '", '
+                  'got "' + d_item["field"] + '"; skipping rest')
             bump_taint()
             break
 
         check_version(s_item, d_item, sec, desc)
 
-        if not "Description" in s_item:
+        if "Description" not in s_item:
             # Check size of this field only if it's not a VMSTRUCT entry
             check_size(s_item, d_item, sec, desc, s_item["field"])
 
@@ -289,18 +295,20 @@ def check_subsections(src_sub, dest_sub, desc, sec):
             check_descriptions(s_item, d_item, sec)
 
         if not found:
-            print "Section \"" + sec + "\", Description \"" + desc + "\":",
-            print "Subsection \"" + s_item["name"] + "\" not found"
+            print('Section "' + sec + '", '
+                  'Description "' + desc + '": '
+                  'Subsection "' + s_item["name"] + '" not found')
             bump_taint()
 
 
 def check_description_in_list(s_item, d_item, sec, desc):
-    if not "Description" in s_item:
+    if "Description" not in s_item:
         return
 
-    if not "Description" in d_item:
-        print "Section \"" + sec + "\", Description \"" + desc + "\",",
-        print "Field \"" + s_item["field"] + "\": missing description"
+    if "Description" not in d_item:
+        print('Section "' + sec + '", '
+              'Description "' + desc + '", '
+              'Field "' + s_item["field"] + '": missing description')
         bump_taint()
         return
 
@@ -311,17 +319,17 @@ def check_descriptions(src_desc, dest_desc, sec):
     check_version(src_desc, dest_desc, sec, src_desc["name"])
 
     if not check_fields_match(sec, src_desc["name"], dest_desc["name"]):
-        print "Section \"" + sec + "\":",
-        print "Description \"" + src_desc["name"] + "\"",
-        print "missing, got \"" + dest_desc["name"] + "\" instead; skipping"
+        print('Section "' + sec + '": '
+              'Description "' + src_desc["name"] + '" '
+              'missing, got "' + dest_desc["name"] + '" instead; skipping')
         bump_taint()
         return
 
     for f in src_desc:
         if not f in dest_desc:
-            print "Section \"" + sec + "\"",
-            print "Description \"" + src_desc["name"] + "\":",
-            print "Entry \"" + f + "\" missing"
+            print('Section "' + sec + '" '
+                  'Description "' + src_desc["name"] + '": '
+                  'Entry "' + field + '" missing')
             bump_taint()
             continue
 
@@ -340,15 +348,15 @@ def check_version(s, d, sec, desc=None):
         print "version error:", s["version_id"], ">", d["version_id"]
         bump_taint()
 
-    if not "minimum_version_id" in d:
+    if "minimum_version_id" not in dest_ver:
         return
 
     if s["version_id"] < d["minimum_version_id"]:
         print "Section \"" + sec + "\"",
         if desc:
-            print "Description \"" + desc + "\":",
-            print "minimum version error:", s["version_id"], "<",
-            print d["minimum_version_id"]
+            print('Description "' + desc + '": ' +
+                  'minimum version error: ' + str(src_ver["version_id"]) + ' < ' +
+                  str(dest_ver["minimum_version_id"]))
             bump_taint()
 
 
@@ -363,15 +371,21 @@ def check_size(s, d, sec, desc=None, field=None):
         bump_taint()
 
 
-def check_machine_type(s, d):
-    if s["Name"] != d["Name"]:
-        print "Warning: checking incompatible machine types:",
-        print "\"" + s["Name"] + "\", \"" + d["Name"] + "\""
+
+def check_machine_type(src, dest):
+    if src["Name"] != dest["Name"]:
+        print('Warning: checking incompatible machine types: '
+              '"' + src["Name"] + '", "' + dest["Name"] + '"')
     return
 
 
 def main():
-    help_text = "Parse JSON-formatted vmstate dumps from QEMU in files SRC and DEST.  Checks whether migration from SRC to DEST QEMU versions would break based on the VMSTATE information contained within the JSON outputs.  The JSON output is created from a QEMU invocation with the -dump-vmstate parameter and a filename argument to it.  Other parameters to QEMU do not matter, except the -M (machine type) parameter."
+    help_text = ("Parse JSON-formatted vmstate dumps from QEMU in files "
+    "SRC and DEST.  Checks whether migration from SRC to DEST QEMU versions "
+    "would break based on the VMSTATE information contained within the JSON "
+    "outputs. The JSON output is created from a QEMU invocation with the "
+    "-dump-vmstate parameter and a filename argument to it. Other parameters to "
+    "QEMU do not matter, except the -M (machine type) parameter.")
 
     parser = argparse.ArgumentParser(description=help_text)
     parser.add_argument('-s', '--src', type=file, required=True,
@@ -395,12 +409,12 @@ def main():
 
     for sec in src_data:
         dest_sec = sec
-        if not dest_sec in dest_data:
+        if dest_sec not in dest_data:
             # Either the section name got changed, or the section
             # doesn't exist in dest.
             dest_sec = get_changed_sec_name(sec)
-            if not dest_sec in dest_data:
-                print "Section \"" + sec + "\" does not exist in dest"
+            if dest_sec not in dest_data:
+                print('Section "' + sec + '" does not exist in dest')
                 bump_taint()
                 continue
 
@@ -414,9 +428,8 @@ def main():
         check_version(s, d, sec)
 
         for entry in s:
-            if not entry in d:
-                print "Section \"" + sec + "\": Entry \"" + entry + "\"",
-                print "missing"
+            if entry not in d:
+                print('Section "' + sec + '": Entry "' + entry + '" missing')
                 bump_taint()
                 continue
 
-- 
1.8.3.1
