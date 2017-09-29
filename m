Received: from eggs.gnu.org ([2001:4830:134:3::10]:36160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxmA9-0006Vh-8A
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:40:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxmA8-0007Gy-Ht
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:40:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dxmA8-0007Eu-B9
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:40:28 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 29 Sep 2017 11:38:36 +0800
Message-Id: <20170929033844.26935-15-peterx@redhat.com>
In-Reply-To: <20170929033844.26935-1-peterx@redhat.com>
References: <20170929033844.26935-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 14/22] qmp: add new event "request-dropped"
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <qemu-devel.nongnu.org>

This event will be emitted if one QMP request is dropped.  Along,
declare an enum for the reasons.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi-schema.json | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/qapi-schema.json b/qapi-schema.json
index a3ba1c9a1c..0b04e06a4c 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3191,3 +3191,38 @@
 # Since 2.9
 ##
 { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
+
+##
+# @RequestDropReason:
+#
+# Reasons that caused one request to be dropped.
+#
+# @queue-full: the queue of request is full.
+#
+# Since: 2.11
+##
+{ 'enum': 'RequestDropReason',
+  'data': ['queue-full' ] }
+
+##
+# @REQUEST_DROPPED:
+#
+# Emitted when one QMP request is dropped due to some reason.
+#
+# @id:    If the original request contains an string-typed "id" field,
+#         it'll be put into this field.  Otherwise it'll be an empty
+#         string.
+#
+# @reason: The reason why the request is dropped.
+#
+# Since: 2.11
+#
+# Example:
+#
+# { "event": "REQUEST_DROPPED",
+#   "data": {"result": {"id": "libvirt-102",
+#                       "reason": "queue-full" } } }
+#
+##
+{ 'event': 'REQUEST_DROPPED' ,
+  'data': { 'id': 'str', 'reason': 'RequestDropReason' } }
-- 
2.13.5
