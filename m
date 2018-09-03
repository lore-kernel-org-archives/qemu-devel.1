Received: from eggs.gnu.org ([2001:4830:134:3::10]:53716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fwgXQ-00078a-0D
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:32:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fwgXM-0000Iz-CO
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:32:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33316 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fwgXL-0000In-QQ
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:32:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7914A40216E7
	for <qemu-devel@nongnu.org>; Mon,  3 Sep 2018 04:32:27 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon,  3 Sep 2018 12:31:46 +0800
Message-Id: <20180903043149.4076-5-peterx@redhat.com>
In-Reply-To: <20180903043149.4076-1-peterx@redhat.com>
References: <20180903043149.4076-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v7 4/7] qapi: remove COMMAND_DROPPED event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Now it was not used any more, drop it.  We can still do that since
out-of-band is still experimental, and this event is only used when
out-of-band is enabled.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/interop/qmp-spec.txt |  5 +++--
 qapi/misc.json            | 40 ---------------------------------------
 2 files changed, 3 insertions(+), 42 deletions(-)

diff --git a/docs/interop/qmp-spec.txt b/docs/interop/qmp-spec.txt
index 8f7da0245d..67e44a8120 100644
--- a/docs/interop/qmp-spec.txt
+++ b/docs/interop/qmp-spec.txt
@@ -130,8 +130,9 @@ to pass "id" with out-of-band commands.  Passing it with all commands
 is recommended for clients that accept capability "oob".
 
 If the client sends in-band commands faster than the server can
-execute them, the server will eventually drop commands to limit the
-queue length.  The sever sends event COMMAND_DROPPED then.
+execute them, the server will stop reading the requests from the QMP
+channel until the request queue length is reduced to an acceptable
+range.
 
 Only a few commands support out-of-band execution.  The ones that do
 have "allow-oob": true in output of query-qmp-schema.
diff --git a/qapi/misc.json b/qapi/misc.json
index d450cfef21..2c1a6119bf 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3432,46 +3432,6 @@
 ##
 { 'command': 'query-sev-capabilities', 'returns': 'SevCapability' }
 
-##
-# @CommandDropReason:
-#
-# Reasons that caused one command to be dropped.
-#
-# @queue-full: the command queue is full. This can only occur when
-#              the client sends a new non-oob command before the
-#              response to the previous non-oob command has been
-#              received.
-#
-# Since: 2.12
-##
-{ 'enum': 'CommandDropReason',
-  'data': [ 'queue-full' ] }
-
-##
-# @COMMAND_DROPPED:
-#
-# Emitted when a command is dropped due to some reason.  Commands can
-# only be dropped when the oob capability is enabled.
-#
-# @id: The dropped command's "id" field.
-# FIXME Broken by design.  Events are broadcast to all monitors.  If
-# another monitor's client has a command with the same ID in flight,
-# the event will incorrectly claim that command was dropped.
-#
-# @reason: The reason why the command is dropped.
-#
-# Since: 2.12
-#
-# Example:
-#
-# { "event": "COMMAND_DROPPED",
-#   "data": {"result": {"id": "libvirt-102",
-#                       "reason": "queue-full" } } }
-#
-##
-{ 'event': 'COMMAND_DROPPED' ,
-  'data': { 'id': 'any', 'reason': 'CommandDropReason' } }
-
 ##
 # @set-numa-node:
 #
-- 
2.17.1
