Received: from eggs.gnu.org ([2001:4830:134:3::10]:33629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Ux-0001aw-9O
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Us-0000Oj-4Z
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co8Ur-0000ME-S7
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:45 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Mar 2017 13:57:36 +0100
Message-Id: <1489582656-31133-48-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-1-git-send-email-armbru@redhat.com>
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.9 47/47] qapi: Fix a misleading parser
 error message
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

When choking on a token where an expression is expected, we report
'Expected "{", "[" or string'.  Close, but no cigar.  Fix it to
Expected '"{", "[", string, boolean or "null"'.

Missed in commit e53188a.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi.py                           | 3 ++-
 tests/qapi-schema/trailing-comma-list.err | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index d19300d..e88c047 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -519,7 +519,8 @@ class QAPISchemaParser(object):
             expr = self.val
             self.accept()
         else:
-            raise QAPIParseError(self, 'Expected "{", "[" or string')
+            raise QAPIParseError(self, 'Expected "{", "[", string, '
+                                 'boolean or "null"')
         return expr
 
     def get_doc(self, info):
diff --git a/tests/qapi-schema/trailing-comma-list.err b/tests/qapi-schema/trailing-comma-list.err
index 24c24b0..212e14a 100644
--- a/tests/qapi-schema/trailing-comma-list.err
+++ b/tests/qapi-schema/trailing-comma-list.err
@@ -1 +1 @@
-tests/qapi-schema/trailing-comma-list.json:2:36: Expected "{", "[" or string
+tests/qapi-schema/trailing-comma-list.json:2:36: Expected "{", "[", string, boolean or "null"
-- 
2.7.4
