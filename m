Received: from eggs.gnu.org ([2001:4830:134:3::10]:38633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bZ-0007x1-EW
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bV-0007rM-Te
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2bV-0007qh-LH
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:25:57 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:24 +0200
Message-Id: <20171002152552.27999-5-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 04/32] qapi2texi: Fix for '@' not followed
 by \w character
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi2texi.py            | 22 ++++++++++++----------
 tests/qapi-schema/doc-good.json |  2 +-
 tests/qapi-schema/doc-good.out  |  2 +-
 tests/qapi-schema/doc-good.texi |  2 +-
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 1500afc553..cfcd8a19f0 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -41,14 +41,17 @@ def subst_emph(doc):
     return re.sub(r'\b_([^_\n]+)_\b', r'@emph{\1}', doc)
 
 
-def subst_vars(doc):
-    """Replaces @var by @code{var}"""
-    return re.sub(r'@([\w-]+)', r'@code{\1}', doc)
-
-
-def subst_braces(doc):
-    """Replaces {} with @{ @}"""
-    return doc.replace('{', '@{').replace('}', '@}')
+def subst_special(doc):
+    ret = ''
+    for m in re.finditer(r'([^@{}]*)(@([-\w]*)|[{}])?', doc):
+        ret += m.group(1)
+        if m.group(3):
+            # format @NAME as @code{NAME}
+            ret += '@code{' + m.group(3) + '}'
+        elif m.group(2):
+            # escape Texinfo's special characters
+            ret += '@' + m.group(2)
+    return ret
 
 
 def texi_example(doc):
@@ -71,8 +74,7 @@ def texi_format(doc):
     - */-: generates an @itemize list
     """
     ret = ''
-    doc = subst_braces(doc)
-    doc = subst_vars(doc)
+    doc = subst_special(doc)
     doc = subst_emph(doc)
     doc = subst_strong(doc)
     inlist = ''
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index 54a0012d5f..274004a8b6 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -10,7 +10,7 @@
 #
 # *strong* _with emphasis_
 # @var {in braces}
-# lone @ BUG: gets passed to Texinfo unescaped
+# lone @
 # * List item one
 # - Two, multiple
 #   lines
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index a62d2d879c..46261d5010 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -38,7 +38,7 @@ doc freeform
 
 *strong* _with emphasis_
 @var {in braces}
-lone @ BUG: gets passed to Texinfo unescaped
+lone @
 * List item one
 - Two, multiple
 lines
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.texi
index 3b77f2f675..8777cbb7fb 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -4,7 +4,7 @@
 
 @strong{strong} @emph{with emphasis}
 @code{var} @{in braces@}
-lone @ BUG: gets passed to Texinfo unescaped
+lone @@
 @itemize @bullet
 @item
 List item one
-- 
2.13.6
