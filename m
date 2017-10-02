Received: from eggs.gnu.org ([2001:4830:134:3::10]:38640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bZ-0007x9-MB
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bY-0007tV-Js
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49033)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2bY-0007sr-Bc
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:00 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:26 +0200
Message-Id: <20171002152552.27999-7-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 06/32] qapi2texi: Drop | example markup
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

Doc comment lines starting with '|' are examples.  qapi2texi.py puts
each line in its own @example environment, which is wrong.
Fortunately, this kind of example markup is used in just one place
outside tests.  Replace it by Texinfo markup, and drop the '|'
feature.

tests/qapi-schema/doc-good.texi changes, because unlike the '|'
markup, !texinfo terminates lists.  See the FIXME in texi_format().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt    | 10 ----------
 qapi-schema.json                |  8 ++++++--
 scripts/qapi2texi.py            |  9 +--------
 tests/qapi-schema/doc-good.json |  8 ++++++--
 tests/qapi-schema/doc-good.out  |  8 ++++++--
 tests/qapi-schema/doc-good.texi | 10 +++-------
 6 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 0334ef37ef..579807f6a5 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -65,11 +65,6 @@ Double the '=' for a subsection title:
 
     # == Subection title
 
-'|' denotes examples:
-
-    # | Text of the example, may span
-    # | multiple lines
-
 '*' starts an itemized list:
 
     # * First item, may span
@@ -110,11 +105,6 @@ Example:
 # 1. with a list
 # 2. like that
 #
-# And some code:
-# | $ echo foo
-# | -> do this
-# | <- get that
-#
 # Texinfo markup:
 # !texinfo
 # @table @samp
diff --git a/qapi-schema.json b/qapi-schema.json
index 3490a5edaf..a6ef550fd5 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -20,8 +20,12 @@
 #
 # Example:
 #
-# | -> data issued by the Client
-# | <- Server data response
+# !texinfo
+# @verbatim
+# -> data issued by the Client
+# <- Server data response
+# @end verbatim
+# !end texinfo
 #
 # Please, refer to the QMP specification (docs/interop/qmp-spec.txt) for
 # detailed information on the Server command and response formats.
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index e356f911bb..bfd1c676e1 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -25,11 +25,6 @@ TYPE_FMT = """
 
 """.format
 
-EXAMPLE_FMT = """@example
-{code}
-@end example
-""".format
-
 
 def subst_strong(doc):
     """Replaces *foo* by @strong{foo}"""
@@ -103,9 +98,7 @@ def texi_format(doc):
         #
         # Make sure to update section "Documentation markup" in
         # docs/devel/qapi-code-gen.txt when fixing this.
-        if line.startswith('| '):
-            line = EXAMPLE_FMT(code=line[2:])
-        elif line.startswith('= '):
+        if line.startswith('= '):
             line = '@section ' + line[2:]
         elif line.startswith('== '):
             line = '@subsection ' + line[3:]
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index 5fcca8dc85..d3ddf828ef 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -28,8 +28,12 @@
 #
 # - another item
 #
-# | example
-# | multiple lines
+# !texinfo
+# @verbatim
+# example
+# multiple lines
+# @end verbatim
+# !end texinfo
 #
 # !texinfo
 # @table @samp
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 7c4aecbaa2..f0ba51db4b 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -56,8 +56,12 @@ is numbered
 
 - another item
 
-| example
-| multiple lines
+!texinfo
+@verbatim
+example
+multiple lines
+@end verbatim
+!end texinfo
 
 !texinfo
 @table @samp
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.texi
index b7171ff6d1..4a9162c2a2 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -35,13 +35,11 @@ is numbered
 @item
 another item
 
-@example
+@verbatim
 example
-@end example
-
-@example
 multiple lines
-@end example
+@end verbatim
+@end enumerate
 
 
 @table @samp
@@ -52,8 +50,6 @@ This is the text for
 @item bar
 Text for @samp{bar}.
 @end table
-@end enumerate
-
 
 Returns: the King
 Since: the first age
-- 
2.13.6
