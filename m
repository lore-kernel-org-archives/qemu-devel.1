Received: from eggs.gnu.org ([2001:4830:134:3::10]:51930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fPkVm-0004f1-9z
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fPkVi-0003tB-Aa
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:06:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56068 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fPkVi-0003sl-5f
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:06:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 714DD401EF05
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 08:06:37 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon,  4 Jun 2018 16:06:30 +0800
Message-Id: <20180604080630.10946-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH] monitor: postpone monitor_qmp_cleanup_queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, peterx@redhat.com, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Previously we cleanup the queues when we got CLOSED event.  It was used
to make sure we won't leftover replies/events of a old client to a new
client.  Now this patch postpones that until OPENED.

In most cases, it does not really matter much since either way will make
sure that the new client won't receive unexpected old events/responses.
However there can be a very rare race condition with the old way when we
use QMP with stdio and pipelines (which is quite common in iotests).
The problem is that, we can easily have something like this in scripts:

  cat $QMP_COMMANDS | qemu -qmp stdio ... | filter_commands

In most cases, a QMP session will be based on a bidirectional
channel (read/write to a TCP port, for example), so IN and OUT are
sharing some fundamentally same thing.  However that's untrue for pipes
above - the IN is the "cat" program, while the "OUT" is directed to the
"filter_commands" which is actually another process.

Now when we received the CLOSED event, we cleanup the queues (including
the QMP response queue).  That means, if we kill/stop the "cat" process
faster than the filter_commands process, the filter_commands process is
possible to miss some responses/events that should belong to it.

In practise, I encountered a very strange SHUTDOWN event missing when
running test with iotest 087.  Without this patch, iotest 078 will have
~10% chance to miss the SHUTDOWN event and fail when with Out-Of-Band
enabled:

087 8s ... - output mismatch (see 087.out.bad)
--- /home/peterx/git/qemu/tests/qemu-iotests/087.out    2018-06-01 18:44:22.378982462 +0800
+++ /home/peterx/git/qemu/bin/tests/qemu-iotests/087.out.bad    2018-06-01 18:53:44.267840928 +0800
@@ -8,7 +8,6 @@
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "'node-name' must be specified for the root node"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}

 === Duplicate ID ===
@@ -53,7 +52,6 @@
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}

This patch fixes the problem.

Fixes: 6d2d563f8c ("qmp: cleanup qmp queues properly", 2018-03-27)
Signed-off-by: Peter Xu <peterx@redhat.com>

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index 46814af533..6f26108108 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4354,6 +4354,7 @@ static void monitor_qmp_event(void *opaque, int event)
 
     switch (event) {
     case CHR_EVENT_OPENED:
+        monitor_qmp_cleanup_queues(mon);
         mon->qmp.commands = &qmp_cap_negotiation_commands;
         monitor_qmp_caps_reset(mon);
         data = get_qmp_greeting(mon);
@@ -4362,7 +4363,6 @@ static void monitor_qmp_event(void *opaque, int event)
         mon_refcount++;
         break;
     case CHR_EVENT_CLOSED:
-        monitor_qmp_cleanup_queues(mon);
         json_message_parser_destroy(&mon->qmp.parser);
         json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
         mon_refcount--;
-- 
2.17.0
