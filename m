Received: from eggs.gnu.org ([2001:4830:134:3::10]:38776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bd-0007yQ-Kd
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bX-0007sh-Kr
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2bX-0007rz-Ce
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:25:59 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:23 +0200
Message-Id: <20171002152552.27999-4-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 03/32] qapi2texi: Fix for examples
 containing '@'
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

Instead of quoting example text so that the @example environment shows
it verbatim, simply use the @verbatim environment.

Examples are no longer indented in output, because makeinfo doesn't
indent @verbatim, unlike @example.
TODO keep indentation somehow?

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi2texi.py            | 12 +++++-------
 tests/qapi-schema/doc-good.json |  2 +-
 tests/qapi-schema/doc-good.out  |  2 +-
 tests/qapi-schema/doc-good.texi | 16 ++++++++--------
 4 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 92e2af2cd6..1500afc553 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -52,13 +52,11 @@ def subst_braces(doc):
 
 
 def texi_example(doc):
-    """Format @example"""
-    # TODO: Neglects to escape @ characters.
-    # We should probably escape them in subst_braces(), and rename the
-    # function to subst_special() or subs_texi_special().  If we do that, we
-    # need to delay it until after subst_vars() in texi_format().
-    doc = subst_braces(doc).strip('\n')
-    return EXAMPLE_FMT(code=doc)
+    """Format example text"""
+    return """@verbatim
+{code}
+@end verbatim
+""".format(code=doc.strip('\n'))
 
 
 def texi_format(doc):
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index 44098d7f1a..54a0012d5f 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -117,7 +117,7 @@
 # <- out
 # Examples:
 # - *verbatim*
-# - @at sign BUG: gets passed to Texinfo unescaped
+# - @at sign
 # - {braces}
 # Since: 2.10
 ##
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index b732b81119..a62d2d879c 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -138,7 +138,7 @@ Duis aute irure dolor
 <- out
     section=Examples
 - *verbatim*
-- @at sign BUG: gets passed to Texinfo unescaped
+- @at sign
 - {braces}
     section=Since
 2.10
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.texi
index 840a492249..3b77f2f675 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -201,17 +201,17 @@ Ut enim ad minim veniam
 Duis aute irure dolor
 
 @b{Example:}
-@example
+@verbatim
 -> in
 <- out
-@end example
+@end verbatim
 
 @b{Examples:}
-@example
+@verbatim
 - *verbatim*
-- @at sign BUG: gets passed to Texinfo unescaped
-- @{braces@}
-@end example
+- @at sign
+- {braces}
+@end verbatim
 
 @b{Since:}
 2.10
@@ -227,11 +227,11 @@ If you're bored enough to read this, go see a video of boxed cats
 @b{Arguments:} the members of @code{Object}
 
 @b{Example:}
-@example
+@verbatim
 -> in
 
 <- out
-@end example
+@end verbatim
 
 @end deftypefn
 
-- 
2.13.6
