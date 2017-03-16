Received: from eggs.gnu.org ([2001:4830:134:3::10]:55004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtZ-0006CZ-KS
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtS-0007B8-OE
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coOtS-00078K-DY
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D3CD80467
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A41217BBD
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Mar 2017 07:28:05 +0100
Message-Id: <1489645685-4750-50-git-send-email-armbru@redhat.com>
In-Reply-To: <1489645685-4750-1-git-send-email-armbru@redhat.com>
References: <1489645685-4750-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for 2.9 49/49] qapi: Fix a misleading parser
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

When choking on a token where an expression is expected, we report
'Expected "{", "[" or string'.  Close, but no cigar.  Fix it to
Expected '"{", "[", string, boolean or "null"'.

Missed in commit e53188a.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1489582656-31133-48-git-send-email-armbru@redhat.com>
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
