Received: from eggs.gnu.org ([2001:4830:134:3::10]:56290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eeDpH-0002RX-A5
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 00:42:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eeDpG-0000Q8-E7
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 00:42:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eeDpG-0000PZ-8T
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 00:42:22 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed, 24 Jan 2018 13:39:49 +0800
Message-Id: <20180124053957.29145-16-peterx@redhat.com>
In-Reply-To: <20180124053957.29145-1-peterx@redhat.com>
References: <20180124053957.29145-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v7 15/23] qmp: add new event "command-dropped"
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

This event will be emitted if one QMP command is dropped.  Along,
declare an enum for the reasons.

Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi-schema.json | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/qapi-schema.json b/qapi-schema.json
index 2490d5188e..d6c89efc0d 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3215,3 +3215,40 @@
 # Since: 2.11
 ##
 { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
+
+##
+# @CommandDropReason:
+#
+# Reasons that caused one command to be dropped.
+#
+# @queue-full: the command queue is full. This can only occur when
+#              the client sends a new non-oob command before the
+#              response to the previous non-oob command has been
+#              received.
+#
+# Since: 2.12
+##
+{ 'enum': 'CommandDropReason',
+  'data': [ 'queue-full' ] }
+
+##
+# @COMMAND_DROPPED:
+#
+# Emitted when a command is dropped due to some reason.  Commands can
+# only be dropped when the oob capability is enabled.
+#
+# @id: The dropped command's "id" field.
+#
+# @reason: The reason why the command is dropped.
+#
+# Since: 2.12
+#
+# Example:
+#
+# { "event": "COMMAND_DROPPED",
+#   "data": {"result": {"id": "libvirt-102",
+#                       "reason": "queue-full" } } }
+#
+##
+{ 'event': 'COMMAND_DROPPED' ,
+  'data': { 'id': 'any', 'reason': 'CommandDropReason' } }
-- 
2.14.3
