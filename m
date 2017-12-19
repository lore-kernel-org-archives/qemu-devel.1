Received: from eggs.gnu.org ([2001:4830:134:3::10]:39403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRDbk-0003o8-SP
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:50:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRDbj-0002v0-EZ
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:50:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eRDbj-0002uL-5e
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:50:39 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue, 19 Dec 2017 16:45:55 +0800
Message-Id: <20171219084557.9801-26-peterx@redhat.com>
In-Reply-To: <20171219084557.9801-1-peterx@redhat.com>
References: <20171219084557.9801-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v6 25/27] docs: update QMP documents for OOB
 commands
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

Update both the developer and spec for the new QMP OOB (Out-Of-Band)
command.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 70 ++++++++++++++++++++++++++++++++++++++++----
 docs/interop/qmp-spec.txt    | 30 ++++++++++++++++---
 2 files changed, 91 insertions(+), 9 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index f04c63fe82..02cc1a4075 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -554,9 +554,12 @@ following example objects:
 
 === Commands ===
 
+--- General Command Layout ---
+
 Usage: { 'command': STRING, '*data': COMPLEX-TYPE-NAME-OR-DICT,
          '*returns': TYPE-NAME, '*boxed': true,
-         '*gen': false, '*success-response': false }
+         '*gen': false, '*success-response': false,
+         '*allow-oob': false }
 
 Commands are defined by using a dictionary containing several members,
 where three members are most common.  The 'command' member is a
@@ -636,6 +639,61 @@ possible, the command expression should include the optional key
 'success-response' with boolean value false.  So far, only QGA makes
 use of this member.
 
+A command can be declared to support Out-Of-Band (OOB) execution.  By
+default, commands do not support OOB.  To declare a command to support
+it, we need an extra 'allow-oob' field.  For example:
+
+ { 'command': 'migrate_recover',
+   'data': { 'uri': 'str' }, 'allow-oob': true }
+
+To execute a command in Out-Of-Band way, we need to specify the
+"control" field in the request, with "run-oob" set to true. Example:
+
+ => { "execute": "command-support-oob",
+      "arguments": { ... },
+      "control": { "run-oob": true } }
+ <= { "return": { } }
+
+Without it, even the commands that support out-of-band execution will
+still be run In-Band.
+
+Please read the "Out-Of-Band Command Execution" section below for more
+information on how OOB execution works.
+
+--- About Out-Of-Band (OOB) Command Execution ---
+
+Out-Of-Band does not mean a special kind of command. Instead, it's a
+special way to execute the command.  One normal command can be
+declared to support Out-Of-Band execution when 'allow-oob' field is
+set to true when defining the command.  With that, it can be run in an
+Out-Of-Band way if 'run-oob' is specified in 'control' field of
+command request.
+
+When we say normal QMP command executions, it means basically the
+following:
+
+- They are executed in order,
+- They run only in main thread of QEMU,
+- They have the BQL taken during execution.
+
+For OOB command executions, they differ in the following:
+
+- They can be executed before an existing command,
+- They run in a monitor dedicated thread,
+- They do not take the BQL during execution.
+
+To add OOB execution support for a command, we need to make sure the
+command handler satisfies at least the following:
+
+- It executes extremely fast,
+- It does not take any lock (or, it can take very small locks, but in
+  very predictable ways),
+- It does not invoke system calls that may block,
+- It does not access guest RAM that may block when userfaultfd is
+  enabled for postcopy live migration.
+
+If someone is unsure about whether a command handler can be run in OOB
+way, then it possibly means that it does not suite for OOB execution.
 
 === Events ===
 
@@ -739,10 +797,12 @@ references by name.
 QAPI schema definitions not reachable that way are omitted.
 
 The SchemaInfo for a command has meta-type "command", and variant
-members "arg-type" and "ret-type".  On the wire, the "arguments"
-member of a client's "execute" command must conform to the object type
-named by "arg-type".  The "return" member that the server passes in a
-success response conforms to the type named by "ret-type".
+members "arg-type", "ret-type" and "allow-oob".  On the wire, the
+"arguments" member of a client's "execute" command must conform to the
+object type named by "arg-type".  The "return" member that the server
+passes in a success response conforms to the type named by
+"ret-type".  When "allow-oob" is set, it means the command supports
+out-of-band execution.
 
 If the command takes no arguments, "arg-type" names an object type
 without members.  Likewise, if the command returns nothing, "ret-type"
diff --git a/docs/interop/qmp-spec.txt b/docs/interop/qmp-spec.txt
index f8b5356015..e20163c138 100644
--- a/docs/interop/qmp-spec.txt
+++ b/docs/interop/qmp-spec.txt
@@ -83,16 +83,27 @@ The greeting message format is:
 2.2.1 Capabilities
 ------------------
 
-As of the date this document was last revised, no server or client
-capability strings have been defined.
+Currently supported capabilities are:
 
+- "oob": it means the QMP server supports "Out-Of-Band" command
+  execution.  For more detail, please see "run-oob" parameter in
+  "Issuing Commands" section below.  Not all commands allow this "oob"
+  execution.  One can know whether one command supports "oob" by
+  "query-qmp-schema" command.
+
+QMP clients can get a list of supported QMP capabilities of the QMP
+server in the greeting message mentioned above.  By default, all the
+capabilities are off.  To enable a specific or multiple of QMP
+capabilities, QMP client needs to send "qmp_capabilities" command with
+extra parameter for the capabilities.
 
 2.3 Issuing Commands
 --------------------
 
 The format for command execution is:
 
-{ "execute": json-string, "arguments": json-object, "id": json-value }
+{ "execute": json-string, "arguments": json-object, "id": json-value,
+  "control": json-dict }
 
  Where,
 
@@ -102,10 +113,16 @@ The format for command execution is:
   required. Each command documents what contents will be considered
   valid when handling the json-argument
 - The "id" member is a transaction identification associated with the
-  command execution, it is optional and will be part of the response if
+  command execution.  It is required if OOB is enabled, and optional
+  if not.  The same "id" field will be part of the response if
   provided. The "id" member can be any json-value, although most
   clients merely use a json-number incremented for each successive
   command
+- The "control" member is optional, and currently only used for
+  "out-of-band" execution ("oob" as shortcut). The handling or
+  response of an "oob" command can overtake prior in-band commands.
+  To enable "oob" feature, just provide a control field with: {
+  "control": { "run-oob": true } }
 
 2.4 Commands Responses
 ----------------------
@@ -113,6 +130,11 @@ The format for command execution is:
 There are two possible responses which the Server will issue as the result
 of a command execution: success or error.
 
+As long as the commands were issued with a proper "id" field, then the
+same "id" field will be attached in the corresponding response message
+so that requests and responses can match.  Clients should drop all the
+responses that are with unknown "id" field.
+
 2.4.1 success
 -------------
 
-- 
2.14.3
