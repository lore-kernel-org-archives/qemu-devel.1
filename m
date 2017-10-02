Received: from eggs.gnu.org ([2001:4830:134:3::10]:44046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Th-0006xR-Hl
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Tg-0003cB-Aa
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz1Tg-0003bW-4n
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4DEEEC059B60
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 14:13:47 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 16:13:36 +0200
Message-Id: <20171002141341.24616-7-armbru@redhat.com>
In-Reply-To: <20171002141341.24616-1-armbru@redhat.com>
References: <20171002141341.24616-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 06/11] qapi2texi: Clean up texi_sections()
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

Repurposing the function parameter doc for stepping through
doc.sections.__str__() is not nice.  Use new variable @text instead.

While there, eliminate variables name and func.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi2texi.py | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index a317526e51..f876d9a174 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -180,16 +180,14 @@ def texi_sections(doc):
     """Format additional sections following arguments"""
     body = ''
     for section in doc.sections:
-        name, doc = (section.name, str(section))
-        func = texi_format
-        if name.startswith('Example'):
-            func = texi_example
-
-        if name:
+        if section.name:
             # prefer @b over @strong, so txt doesn't translate it to *Foo:*
-            body += '\n\n@b{%s:}\n' % name
-
-        body += func(doc)
+            body += '\n\n@b{%s:}\n' % section.name
+        text = str(section)
+        if section.name.startswith('Example'):
+            body += texi_example(text)
+        else:
+            body += texi_format(text)
     return body
 
 
-- 
2.13.6
