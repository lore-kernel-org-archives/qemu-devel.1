Received: from eggs.gnu.org ([2001:4830:134:3::10]:42669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1aw-0004UX-1g
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1as-0006gl-B0
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54944 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fa1ar-0006fB-SA
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4BC3840704BB
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 16:22:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Jul 2018 18:22:18 +0200
Message-Id: <20180702162218.13678-33-armbru@redhat.com>
In-Reply-To: <20180702162218.13678-1-armbru@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 32/32] qapi: Polish command flags documentation
 in qapi-code-gen.txt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, eblake@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 61 +++++++++++++++---------------------
 1 file changed, 25 insertions(+), 36 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index f020f6bab2..8decd6f17d 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -624,60 +624,48 @@ its return value.
 In rare cases, QAPI cannot express a type-safe representation of a
 corresponding Client JSON Protocol command.  You then have to suppress
 generation of a marshalling function by including a key 'gen' with
-boolean value false, and instead write your own function.  Please try
-to avoid adding new commands that rely on this, and instead use
-type-safe unions.  For an example of this usage:
+boolean value false, and instead write your own function.  For
+example:
 
  { 'command': 'netdev_add',
    'data': {'type': 'str', 'id': 'str'},
    'gen': false }
 
+Please try to avoid adding new commands that rely on this, and instead
+use type-safe unions.
+
 Normally, the QAPI schema is used to describe synchronous exchanges,
 where a response is expected.  But in some cases, the action of a
 command is expected to change state in a way that a successful
 response is not possible (although the command will still return a
 normal dictionary error on failure).  When a successful reply is not
-possible, the command expression should include the optional key
+possible, the command expression includes the optional key
 'success-response' with boolean value false.  So far, only QGA makes
 use of this member.
 
-A command can be declared to support out-of-band (OOB) execution.  By
-default, commands do not support OOB.  To declare a command that
-supports it, the schema includes an extra 'allow-oob' field.  For
-example:
+Key 'allow-oob' declares whether the command supports out-of-band
+(OOB) execution.  It defaults to false.  For example:
 
  { 'command': 'migrate_recover',
    'data': { 'uri': 'str' }, 'allow-oob': true }
 
-To execute a command with out-of-band priority, the client uses key
-"exec-oob" instead of "execute".  Example:
+See qmp-spec.txt for out-of-band execution syntax and semantics.
 
- => { "exec-oob": "migrate-recover",
-      "arguments": { "uri": "tcp:192.168.1.200:12345" } }
- <= { "return": { } }
+Commands supporting out-of-band execution can still be executed
+in-band.
 
-Without it, even the commands that support out-of-band execution will
-still be run in-band.
+When a command is executed in-band, its handler runs in the main
+thread with the BQL held.
 
-Under normal QMP command execution, the following apply to each
-command:
+When a command is executed out-of-band, its handler runs in a
+dedicated monitor I/O thread with the BQL *not* held.
 
-- They are executed in order,
-- They run only in main thread of QEMU,
-- They run with the BQL held.
+An OOB-capable command handler must satisfy the following conditions:
 
-When a command is executed with OOB, the following changes occur:
-
-- They can be completed before a pending in-band command,
-- They run in a dedicated monitor thread,
-- They run with the BQL not held.
-
-OOB command handlers must satisfy the following conditions:
-
-- It terminates quickly,
-- It does not invoke system calls that may block,
+- It terminates quickly.
+- It does not invoke system calls that may block.
 - It does not access guest RAM that may block when userfaultfd is
-  enabled for postcopy live migration,
+  enabled for postcopy live migration.
 - It takes only "fast" locks, i.e. all critical sections protected by
   any lock it takes also satisfy the conditions for OOB command
   handler code.
@@ -686,17 +674,18 @@ The restrictions on locking limit access to shared state.  Such access
 requires synchronization, but OOB commands can't take the BQL or any
 other "slow" lock.
 
-If in doubt, do not implement OOB execution support.
+When in doubt, do not implement OOB execution support.
 
-A command may use the optional 'allow-preconfig' key to permit its execution
-at early runtime configuration stage (preconfig runstate).
-If not specified then a command defaults to 'allow-preconfig': false.
+Key 'allow-preconfig' declares whether the command is available before
+the machine is built.  It defaults to false.  For example:
 
-An example of declaring a command that is enabled during preconfig:
  { 'command': 'qmp_capabilities',
    'data': { '*enable': [ 'QMPCapability' ] },
    'allow-preconfig': true }
 
+QMP is available before the machine is built only when QEMU was
+started with --preconfig.
+
 === Events ===
 
 Usage: { 'event': STRING, '*data': COMPLEX-TYPE-NAME-OR-DICT,
-- 
2.17.1
