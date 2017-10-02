Received: from eggs.gnu.org ([2001:4830:134:3::10]:38667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2ba-0007xa-Dl
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bW-0007rV-4q
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2bV-0007r6-UX
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:25:58 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:21 +0200
Message-Id: <20171002152552.27999-2-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 01/32] tests/qapi-schema: Improve coverage
 of '@'
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

Demonstrates a qapi2texi.py bug: it can fail to escape '@'.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qapi-schema/doc-good.json | 3 +++
 tests/qapi-schema/doc-good.out  | 3 +++
 tests/qapi-schema/doc-good.texi | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index 97ab4625ff..44098d7f1a 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -10,6 +10,7 @@
 #
 # *strong* _with emphasis_
 # @var {in braces}
+# lone @ BUG: gets passed to Texinfo unescaped
 # * List item one
 # - Two, multiple
 #   lines
@@ -46,6 +47,7 @@
 # <- out
 # Examples:
 # - *verbatim*
+# - @at sign
 # - {braces}
 ##
 
@@ -115,6 +117,7 @@
 # <- out
 # Examples:
 # - *verbatim*
+# - @at sign BUG: gets passed to Texinfo unescaped
 # - {braces}
 # Since: 2.10
 ##
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 1d2c250527..b732b81119 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -38,6 +38,7 @@ doc freeform
 
 *strong* _with emphasis_
 @var {in braces}
+lone @ BUG: gets passed to Texinfo unescaped
 * List item one
 - Two, multiple
 lines
@@ -74,6 +75,7 @@ Example:
 <- out
 Examples:
 - *verbatim*
+- @at sign
 - {braces}
 doc symbol=Enum
     body=
@@ -136,6 +138,7 @@ Duis aute irure dolor
 <- out
     section=Examples
 - *verbatim*
+- @at sign BUG: gets passed to Texinfo unescaped
 - {braces}
     section=Since
 2.10
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.texi
index 1778312581..840a492249 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -4,6 +4,7 @@
 
 @strong{strong} @emph{with emphasis}
 @code{var} @{in braces@}
+lone @ BUG: gets passed to Texinfo unescaped
 @itemize @bullet
 @item
 List item one
@@ -69,6 +70,8 @@ Examples:
 @item
 @strong{verbatim}
 @item
+@code{at} sign
+@item
 @{braces@}
 @end itemize
 
@@ -206,6 +209,7 @@ Duis aute irure dolor
 @b{Examples:}
 @example
 - *verbatim*
+- @at sign BUG: gets passed to Texinfo unescaped
 - @{braces@}
 @end example
 
-- 
2.13.6
