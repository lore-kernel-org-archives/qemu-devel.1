Received: from eggs.gnu.org ([2001:4830:134:3::10]:53066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4Z-0001Rm-4B
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4X-0007G6-1y
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51412 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faH4W-0007FY-Ss
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:04 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 10:53:33 +0200
Message-Id: <20180703085358.13941-8-armbru@redhat.com>
In-Reply-To: <20180703085358.13941-1-armbru@redhat.com>
References: <20180703085358.13941-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/32] qmp: Make "id" optional again even in
 "oob" monitors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, eblake@redhat.com, stefanha@redhat.com, dgilbert@redhat.com, mdroth@linux.vnet.ibm.com

Commit cf869d53172 "qmp: support out-of-band (oob) execution" made
"id" mandatory for all commands when the client accepted capability
"oob".  This is rather onerous when you play with QMP by hand, and
unnecessarily so: only out-of-band commands need an ID for reliable
matching of response to command.

Revert that part of commit cf869d53172 for now, but have documentation
advise on the need to use "id" with out-of-band commands.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/interop/qmp-spec.txt | 13 +++++++------
 monitor.c                 |  7 -------
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/docs/interop/qmp-spec.txt b/docs/interop/qmp-spec.txt
index 6b72b69cb1..a1d6f9ee06 100644
--- a/docs/interop/qmp-spec.txt
+++ b/docs/interop/qmp-spec.txt
@@ -103,16 +103,13 @@ The format for command execution is:
   required. Each command documents what contents will be considered
   valid when handling the json-argument
 - The "id" member is a transaction identification associated with the
-  command execution.  It is required for all commands if the OOB -
-  capability was enabled at startup, and optional otherwise.  The same
-  "id" field will be part of the response if provided.  The "id"
-  member can be any json-value.  A json-number incremented for each
-  successive command works fine.
+  command execution, it is optional and will be part of the response
+  if provided.  The "id" member can be any json-value.  A json-number
+  incremented for each successive command works fine.
 - The optional "control" member further specifies how the command is
   to be executed.  Currently, its only member is optional "run-oob".
   See section "2.3.1 Out-of-band execution" for details.
 
-
 2.3.1 Out-of-band execution
 ---------------------------
 
@@ -128,6 +125,10 @@ possibly overtaking prior in-band commands.  The client may therefore
 receive such a command's response before responses from prior in-band
 commands.
 
+To be able to match responses back to their commands, the client needs
+to pass "id" with out-of-band commands.  Passing it with all commands
+is recommended for clients that accept capability "oob".
+
 To execute a command out-of-band, the client puts "run-oob": true into
 execute's member "control".
 
diff --git a/monitor.c b/monitor.c
index 96e87d8664..b7d74b01b4 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4291,13 +4291,6 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
 
     id = qdict_get(qdict, "id");
 
-    /* When OOB is enabled, the "id" field is mandatory. */
-    if (qmp_oob_enabled(mon) && !id) {
-        error_setg(&err, "Out-of-band capability requires that "
-                   "every command contains an 'id' field");
-        goto err;
-    }
-
     req_obj = g_new0(QMPRequest, 1);
     req_obj->mon = mon;
     req_obj->id = qobject_ref(id);
-- 
2.17.1
