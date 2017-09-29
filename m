Received: from eggs.gnu.org ([2001:4830:134:3::10]:36391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxmAv-0007BQ-Eq
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxmAu-0007t4-3p
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:41:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dxmAt-0007rZ-RX
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:41:16 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 29 Sep 2017 11:38:44 +0800
Message-Id: <20170929033844.26935-23-peterx@redhat.com>
In-Reply-To: <20170929033844.26935-1-peterx@redhat.com>
References: <20170929033844.26935-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 22/22] docs: update QMP documents for OOB
 commands
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

Update both the developer and spec for the new QMP OOB (Out-Of-Band)
command.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 51 +++++++++++++++++++++++++++++++++++++++-----
 docs/interop/qmp-spec.txt    | 24 ++++++++++++++++++---
 2 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index f04c63fe82..8597fdb087 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -556,7 +556,8 @@ following example objects:
 
 Usage: { 'command': STRING, '*data': COMPLEX-TYPE-NAME-OR-DICT,
          '*returns': TYPE-NAME, '*boxed': true,
-         '*gen': false, '*success-response': false }
+         '*gen': false, '*success-response': false,
+         '*allow-oob': false }
 
 Commands are defined by using a dictionary containing several members,
 where three members are most common.  The 'command' member is a
@@ -636,6 +637,44 @@ possible, the command expression should include the optional key
 'success-response' with boolean value false.  So far, only QGA makes
 use of this member.
 
+Most of the QMP commands are handled sequentially in such a order:
+Firstly, the JSON Parser parses the command request into some internal
+message, delivers the message to QMP dispatchers. Secondly, the QMP
+dispatchers will handle the commands one by one in time order, respond
+when necessary.  For some commands that always complete "quickly" can
+instead be executed directly during parsing, at the QMP client's
+request.  This kind of commands that allow direct execution is called
+"out-of-band" ("oob" as shortcut) commands. The response can overtake
+prior in-band commands' responses.  By default, commands are always
+in-band.  We need to explicitly specify "allow-oob" to "True" to show
+that one command can be run out-of-band.
+
+One thing to mention for developers is that, although out-of-band
+execution of commands benefit from quick and asynchronous execution,
+it need to satisfy at least the following:
+
+(1) It is extremely quick and never blocks, so that its execution will
+    not block parsing routine of any other monitors.
+
+(2) It does not need BQL, since the parser can be run without BQL,
+    while the dispatcher is always with BQL held.
+
+If not, the command is not suitable to be allowed to run out-of-band,
+and it should set its "allow-oob" to "False".  Whether a command is
+allowed to run out-of-band can also be introspected using
+query-qmp-schema command.  Please see the section "Client JSON
+Protocol introspection" for more information.
+
+To execute a command in out-of-band way, we need to specify the
+"control" field in the request, with "run-oob" set to true. Example:
+
+ => { "execute": "command-support-oob",
+      "arguments": { ... },
+      "control": { "run-oob": true } }
+ <= { "return": { } }
+
+Without it, even the commands that supports out-of-band execution will
+still be run in-band.
 
 === Events ===
 
@@ -739,10 +778,12 @@ references by name.
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
index f8b5356015..c345f235a7 100644
--- a/docs/interop/qmp-spec.txt
+++ b/docs/interop/qmp-spec.txt
@@ -83,16 +83,21 @@ The greeting message format is:
 2.2.1 Capabilities
 ------------------
 
-As of the date this document was last revised, no server or client
-capability strings have been defined.
+Currently supported capabilities:
 
+- "oob": it means the QMP server supports "Out-Of-Band" command
+  execution.  For more detail, please see "run-oob" parameter in
+  "Issuing Commands" section below.  Not all commands allow this "oob"
+  execution.  One can know whether one command supports "oob" by
+  "query-qmp-schema" command.
 
 2.3 Issuing Commands
 --------------------
 
 The format for command execution is:
 
-{ "execute": json-string, "arguments": json-object, "id": json-value }
+{ "execute": json-string, "arguments": json-object, "id": json-value,
+  "control": json-dict }
 
  Where,
 
@@ -106,6 +111,14 @@ The format for command execution is:
   provided. The "id" member can be any json-value, although most
   clients merely use a json-number incremented for each successive
   command
+- The "control" member is optionally, and currently only used for
+  "out-of-band" execution.  For some commands that always complete
+  "quickly" can be executed directly during parsing at the QMP
+  client's request.  This kind of commands that allow direct execution
+  is called "out-of-band" ("oob" as shortcut) commands. The response
+  of "oob" commands can overtake prior in-band commands' responses.
+  To enable "oob" feature, just provide a control field with:
+  { "control": { "run-oob": true } }
 
 2.4 Commands Responses
 ----------------------
@@ -113,6 +126,11 @@ The format for command execution is:
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
2.13.5
