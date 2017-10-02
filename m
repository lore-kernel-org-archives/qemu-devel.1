Received: from eggs.gnu.org ([2001:4830:134:3::10]:38927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bh-00083B-UG
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2ba-0007vr-H1
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2ba-0007ul-6O
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:02 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:25 +0200
Message-Id: <20171002152552.27999-6-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 05/32] qapi2texi: Provide access to Texinfo
 markup
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

qapi2texi supports very limited formatting markup reminiscent of
MarkDown, which it translates to Texinfo.  It's basically defined by
example, and has multiple issues, in particular with lists.
Nevertheless, it has served our (modest) needs so far.

However, our needs are about to grow: I'm going to move command line
documentation from qemu-options.hx into schema doc comments, similar
to how we moved QMP documentation in merge commit 23eb9e6.  The QMP
documentation was plain text, and the markup was created to make it
look decent in generated Texinfo with minimal change.  The command
line documentation is already in Texinfo.  Dumbing it down to what
qapi2texi supports would be a lot of work, for a sad result.  Making
qapi2texi sufficiently powerful for a non-sad result would also be a
lot of work, and stupid; the world doesn't need more text markup
languages.  Not even more text markup language implementations.

Supporting Texinfo in doc comments would be ideal.  Can't do, since we
blew the '@' character on schema name references.  Instead, let's try
the stupidest solution that could possibly work: provide an escape to
Texinfo.  Looks like this:

    # !texinfo
    # @c This is Texinfo
    # @appendix Tips and Tricks
    # !end texinfo

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt    | 13 +++++++++++++
 scripts/qapi2texi.py            | 19 ++++++++++++++++---
 tests/qapi-schema/doc-good.json | 11 +++++++++++
 tests/qapi-schema/doc-good.out  | 11 +++++++++++
 tests/qapi-schema/doc-good.texi |  9 +++++++++
 5 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index f04c63fe82..0334ef37ef 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -97,6 +97,9 @@ permitted.
 do not work over multiple lines). @foo is used to reference a name in
 the schema.
 
+You can also embed Texinfo markup.  '!texinfo' switches to Texinfo,
+and '!end texinfo' switches back.
+
 Example:
 
 ##
@@ -112,6 +115,16 @@ Example:
 # | -> do this
 # | <- get that
 #
+# Texinfo markup:
+# !texinfo
+# @table @samp
+# @item foo
+# This is the text for
+# @samp{foo}.
+# @item bar
+# Text for @samp{bar}.
+# @end table
+# !end texinfo
 ##
 
 
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index cfcd8a19f0..e356f911bb 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -74,14 +74,27 @@ def texi_format(doc):
     - */-: generates an @itemize list
     """
     ret = ''
-    doc = subst_special(doc)
-    doc = subst_emph(doc)
-    doc = subst_strong(doc)
     inlist = ''
+    intexi = False
     lastempty = False
+
     for line in doc.split('\n'):
         empty = line == ''
 
+        if not intexi and line == '!texinfo':
+            intexi = True
+            continue
+        if intexi and line == '!end texinfo':
+            intexi = False
+            continue
+        if intexi:
+            ret += line + '\n'
+            continue
+
+        line = subst_special(line)
+        line = subst_emph(line)
+        line = subst_strong(line)
+
         # FIXME: Doing this in a single if / elif chain is
         # problematic.  For instance, a line without markup terminates
         # a list if it follows a blank line (reaches the final elif),
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index 274004a8b6..5fcca8dc85 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -31,6 +31,17 @@
 # | example
 # | multiple lines
 #
+# !texinfo
+# @table @samp
+# @item foo
+# This is the text for
+# @samp{foo}.
+#
+# @item bar
+# Text for @samp{bar}.
+# @end table
+# !end texinfo
+#
 # Returns: the King
 # Since: the first age
 # Notes:
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 46261d5010..7c4aecbaa2 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -59,6 +59,17 @@ is numbered
 | example
 | multiple lines
 
+!texinfo
+@table @samp
+@item foo
+This is the text for
+@samp{foo}.
+
+@item bar
+Text for @samp{bar}.
+@end table
+!end texinfo
+
 Returns: the King
 Since: the first age
 Notes:
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.texi
index 8777cbb7fb..b7171ff6d1 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -44,8 +44,17 @@ multiple lines
 @end example
 
 
+@table @samp
+@item foo
+This is the text for
+@samp{foo}.
+
+@item bar
+Text for @samp{bar}.
+@end table
 @end enumerate
 
+
 Returns: the King
 Since: the first age
 Notes:
-- 
2.13.6
