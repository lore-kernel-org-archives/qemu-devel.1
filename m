Received: from eggs.gnu.org ([2001:4830:134:3::10]:48881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkxa7-0006T5-HB
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkxa5-0004Cc-NH
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:14:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dkxa5-0004BG-Fo
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:14:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 738D1C04B958
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 19:14:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Aug 2017 21:14:06 +0200
Message-Id: <1503602048-12268-15-git-send-email-armbru@redhat.com>
In-Reply-To: <1503602048-12268-1-git-send-email-armbru@redhat.com>
References: <1503602048-12268-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 14/16] qapi-schema: Make block-core.json
 self-contained
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

Except for block-core.json, the sub-schemas are self-contained: if
they use a symbol defined in another sub-schema, they include that
sub-schema.  To check, feed the sub-schema to qapi2texi (or any other
QAPI generator) along with the pragma from qapi-schema.json.

Fix up things to make block-core.json self-contained, too.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi-schema.json     | 14 --------------
 qapi/block-core.json |  1 +
 qapi/common.json     | 14 ++++++++++++++
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 4964d92..80c15da 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -2816,20 +2816,6 @@
      'data': { 'info': 'ACPIOSTInfo' } }
 
 ##
-# @IoOperationType:
-#
-# An enumeration of the I/O operation types
-#
-# @read: read operation
-#
-# @write: write operation
-#
-# Since: 2.1
-##
-{ 'enum': 'IoOperationType',
-  'data': [ 'read', 'write' ] }
-
-##
 # @rtc-reset-reinjection:
 #
 # This command will reset the RTC interrupt reinjection backlog.
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5379674..f4caa5c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5,6 +5,7 @@
 ##
 
 { 'include': 'common.json' }
+{ 'include': 'crypto.json' }
 { 'include': 'sockets.json' }
 
 ##
diff --git a/qapi/common.json b/qapi/common.json
index e2c5856..fc72d7e 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -132,6 +132,20 @@
 { 'command': 'query-commands', 'returns': ['CommandInfo'] }
 
 ##
+# @IoOperationType:
+#
+# An enumeration of the I/O operation types
+#
+# @read: read operation
+#
+# @write: write operation
+#
+# Since: 2.1
+##
+{ 'enum': 'IoOperationType',
+  'data': [ 'read', 'write' ] }
+
+##
 # @OnOffAuto:
 #
 # An enumeration of three options: on, off, and auto
-- 
2.7.5
