Received: from eggs.gnu.org ([2001:4830:134:3::10]:38987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFJtl-0000SE-Pu
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFJtj-0008Ie-4n
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:08:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eFJti-0008GU-Uh
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:08:03 -0500
From: Peter Xu <peterx@redhat.com>
Date: Thu, 16 Nov 2017 21:06:00 +0800
Message-Id: <20171116130610.23582-18-peterx@redhat.com>
In-Reply-To: <20171116130610.23582-1-peterx@redhat.com>
References: <20171116130610.23582-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v4 17/27] qmp: add new event "request-dropped"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This event will be emitted if one QMP request is dropped.  Along,
declare an enum for the reasons.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi-schema.json | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/qapi-schema.json b/qapi-schema.json
index 531fd4c0db..9d2625b6b3 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3222,3 +3222,37 @@
 # Since: 2.11
 ##
 { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
+
+##
+# @RequestDropReason:
+#
+# Reasons that caused one command to be dropped.
+#
+# @queue-full: the queue of request is full.
+#
+# Since: 2.12
+##
+{ 'enum': 'RequestDropReason',
+  'data': [ 'queue-full' ] }
+
+##
+# @REQUEST_DROPPED:
+#
+# Emitted when one QMP request is dropped due to some reason.
+# REQUEST_DROPPED is only emitted when the oob capability is enabled.
+#
+# @id: The dropped command's "id" field.
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
+  'data': { 'id': 'any', 'reason': 'RequestDropReason' } }
-- 
2.13.6
