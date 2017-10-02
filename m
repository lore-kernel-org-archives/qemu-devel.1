Received: from eggs.gnu.org ([2001:4830:134:3::10]:44047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Th-0006xS-Hg
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Tg-0003cQ-HF
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz1Tg-0003bt-C0
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 814CD4A6E8
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 14:13:47 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 16:13:37 +0200
Message-Id: <20171002141341.24616-8-armbru@redhat.com>
In-Reply-To: <20171002141341.24616-1-armbru@redhat.com>
References: <20171002141341.24616-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 07/11] qapi: Unify representation of doc
 section without name
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
List-ID: <qemu-devel.nongnu.org>

We have two representations of sections without a name: the main
section uses name=None, the others name=''.  Standardize on name=None.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py                       | 2 +-
 scripts/qapi2texi.py                  | 2 +-
 tests/qapi-schema/doc-bad-section.out | 2 +-
 tests/qapi-schema/doc-good.out        | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 2f2738f562..2137067b48 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -204,7 +204,7 @@ class QAPIDoc(object):
         self.section = QAPIDoc.ArgSection(name)
         self.args[name] = self.section
 
-    def _start_section(self, name=''):
+    def _start_section(self, name=None):
         if name in ('Returns', 'Since') and self.has_section(name):
             raise QAPIParseError(self.parser,
                                  "Duplicated '%s' section" % name)
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index f876d9a174..f16fa1ba53 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -184,7 +184,7 @@ def texi_sections(doc):
             # prefer @b over @strong, so txt doesn't translate it to *Foo:*
             body += '\n\n@b{%s:}\n' % section.name
         text = str(section)
-        if section.name.startswith('Example'):
+        if section.name and section.name.startswith('Example'):
             body += texi_example(text)
         else:
             body += texi_format(text)
diff --git a/tests/qapi-schema/doc-bad-section.out b/tests/qapi-schema/doc-bad-section.out
index 6fce84dd34..089bde1381 100644
--- a/tests/qapi-schema/doc-bad-section.out
+++ b/tests/qapi-schema/doc-bad-section.out
@@ -9,5 +9,5 @@ doc symbol=Enum
 The _one_ {and only}
     arg=two
 
-    section=
+    section=None
 @two is undocumented
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index c55e394e8a..1d2c250527 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -82,7 +82,7 @@ doc symbol=Enum
 The _one_ {and only}
     arg=two
 
-    section=
+    section=None
 @two is undocumented
 doc symbol=Base
     body=
-- 
2.13.6
