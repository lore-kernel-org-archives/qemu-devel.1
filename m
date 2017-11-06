Received: from eggs.gnu.org ([2001:4830:134:3::10]:49291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eBe32-00069t-Ne
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:50:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eBe31-000515-TR
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:50:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eBe31-00050v-Mj
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:50:27 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon,  6 Nov 2017 17:46:34 +0800
Message-Id: <20171106094643.14881-19-peterx@redhat.com>
In-Reply-To: <20171106094643.14881-1-peterx@redhat.com>
References: <20171106094643.14881-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v3 18/27] qmp: add new event "request-dropped"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This event will be emitted if one QMP request is dropped.  Along,
declare an enum for the reasons.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi-schema.json | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/qapi-schema.json b/qapi-schema.json
index 531fd4c0db..650714da06 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3222,3 +3222,38 @@
 # Since: 2.11
 ##
 { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
+
+##
+# @RequestDropReason:
+#
+# Reasons that caused one request to be dropped.
+#
+# @queue-full: the queue of request is full.
+#
+# Since: 2.12
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
+# Since: 2.12
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
