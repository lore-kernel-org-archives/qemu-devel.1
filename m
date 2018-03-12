Received: from eggs.gnu.org ([2001:4830:134:3::10]:45409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJb-0000rO-Mp
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJa-00062o-AD
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59916 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evSJa-00062X-6s
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C8FF54023155
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:36:53 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:36:17 -0500
Message-Id: <20180312183628.394722-27-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 26/36] qmp: add new event "command-dropped"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Peter Xu <peterx@redhat.com>

This event will be emitted if one QMP command is dropped.  Also,
declare an enum for the reasons.

Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180309090006.10018-16-peterx@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/misc.json | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/qapi/misc.json b/qapi/misc.json
index b2f69eb4ece..b6ebf210ba8 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3242,3 +3242,40 @@
 # Since: 2.9
 ##
 { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
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
