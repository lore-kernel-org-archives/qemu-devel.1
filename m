Received: from eggs.gnu.org ([2001:4830:134:3::10]:52985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4X-0001RX-7d
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4T-0007BV-6f
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51074 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faH4T-0007B8-1H
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:01 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 10:53:29 +0200
Message-Id: <20180703085358.13941-4-armbru@redhat.com>
In-Reply-To: <20180703085358.13941-1-armbru@redhat.com>
References: <20180703085358.13941-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 03/32] docs/interop/qmp: Improve OOB
 documentation
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

OOB documentation is spread over qmp-spec.txt sections 2.2.1
Capabilities and 2.3 Issuing Commands.  The amount of detail is a bit
distracting there.  Move the meat of the matter to new section 2.3.1
Out of band execution.

Throw in a few other improvements while there:

* 2.2 Server Greeting: Drop advice to search entire capabilities
  array; should be obvious.

* 3. QMP Examples

  - 3.1 Server Greeting: Update greeting to the one we expect for the
    release.  Now shows capability "oob".  Update qmp-intro.txt
    likewise.

  - 3.2 Capabilities negotiation: Show client accepting capability
    "oob".

  - 3.7 Out-of-band execution: New.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 docs/interop/qmp-intro.txt | 13 +++----
 docs/interop/qmp-spec.txt  | 74 +++++++++++++++++++++++++-------------
 2 files changed, 56 insertions(+), 31 deletions(-)

diff --git a/docs/interop/qmp-intro.txt b/docs/interop/qmp-intro.txt
index 900d69d612..af2124e3ec 100644
--- a/docs/interop/qmp-intro.txt
+++ b/docs/interop/qmp-intro.txt
@@ -52,13 +52,14 @@ Escape character is '^]'.
     "QMP": {
         "version": {
             "qemu": {
-                "micro": 50, 
-                "minor": 6, 
-                "major": 1
-            }, 
-            "package": ""
-        }, 
+                "micro": 0,
+                "minor": 0 ,
+                "major": 3
+            },
+            "package": "v3.0.0"
+        },
         "capabilities": [
+            "oob"
         ]
     }
 }
diff --git a/docs/interop/qmp-spec.txt b/docs/interop/qmp-spec.txt
index 2bb492d1ea..6b72b69cb1 100644
--- a/docs/interop/qmp-spec.txt
+++ b/docs/interop/qmp-spec.txt
@@ -77,8 +77,7 @@ The greeting message format is:
   is the same of the query-version command)
 - The "capabilities" member specify the availability of features beyond the
   baseline specification; the order of elements in this array has no
-  particular significance, so a client must search the entire array
-  when looking for a particular capability
+  particular significance.
 
 2.2.1 Capabilities
 ------------------
@@ -86,16 +85,7 @@ The greeting message format is:
 Currently supported capabilities are:
 
 - "oob": the QMP server supports "out-of-band" (OOB) command
-  execution.  For more details, please see the "run-oob" parameter in
-  the "Issuing Commands" section below.  Not all commands allow this
-  "oob" execution.  The "query-qmp-schema" command can be used to
-  inspect which commands support "oob" execution.
-
-QMP clients can get a list of supported QMP capabilities of the QMP
-server in the greeting message mentioned above.  By default, all the
-capabilities are off.  To enable any QMP capabilities, the QMP client
-needs to send the "qmp_capabilities" command with an extra parameter
-for the requested capabilities.
+  execution, as described in section "2.3.1 Out-of-band execution".
 
 2.3 Issuing Commands
 --------------------
@@ -115,14 +105,38 @@ The format for command execution is:
 - The "id" member is a transaction identification associated with the
   command execution.  It is required for all commands if the OOB -
   capability was enabled at startup, and optional otherwise.  The same
-  "id" field will be part of the response if provided. The "id" member
-  can be any json-value, although most clients merely use a
-  json-number incremented for each successive command
-- The "control" member is optional, and currently only used for
-  out-of-band execution. The handling or response of an "oob" command
-  can overtake prior in-band commands.  To enable "oob" handling of a
-  particular command, just provide a control field with: { "control":
-  { "run-oob": true } }
+  "id" field will be part of the response if provided.  The "id"
+  member can be any json-value.  A json-number incremented for each
+  successive command works fine.
+- The optional "control" member further specifies how the command is
+  to be executed.  Currently, its only member is optional "run-oob".
+  See section "2.3.1 Out-of-band execution" for details.
+
+
+2.3.1 Out-of-band execution
+---------------------------
+
+The server normally reads, executes and responds to one command after
+the other.  The client therefore receives command responses in issue
+order.
+
+With out-of-band execution enabled via capability negotiation (section
+4.), the server reads and queues commands as they arrive.  It executes
+commands from the queue one after the other.  Commands executed
+out-of-band jump the queue: the command get executed right away,
+possibly overtaking prior in-band commands.  The client may therefore
+receive such a command's response before responses from prior in-band
+commands.
+
+To execute a command out-of-band, the client puts "run-oob": true into
+execute's member "control".
+
+If the client sends in-band commands faster than the server can
+execute them, the server will eventually drop commands to limit the
+queue length.  The sever sends event COMMAND_DROPPED then.
+
+Only a few commands support out-of-band execution.  The ones that do
+have "allow-oob": true in output of query-qmp-schema.
 
 2.4 Commands Responses
 ----------------------
@@ -223,12 +237,13 @@ This section provides some examples of real QMP usage, in all of them
 3.1 Server greeting
 -------------------
 
-S: { "QMP": { "version": { "qemu": { "micro": 50, "minor": 6, "major": 1 },
-     "package": ""}, "capabilities": []}}
+S: { "QMP": {"version": {"qemu": {"micro": 0, "minor": 0, "major": 3},
+     "package": "v3.0.0"}, "capabilities": ["oob"] } }
 
-3.2 Client QMP negotiation
---------------------------
-C: { "execute": "qmp_capabilities" }
+3.2 Capabilities negotiation
+----------------------------
+
+C: { "execute": "qmp_capabilities", "arguments": { "enable": ["oob"] } }
 S: { "return": {}}
 
 3.3 Simple 'stop' execution
@@ -255,6 +270,15 @@ S: { "error": { "class": "GenericError", "desc": "Invalid JSON syntax" } }
 S: { "timestamp": { "seconds": 1258551470, "microseconds": 802384 },
     "event": "POWERDOWN" }
 
+3.7 Out-of-band execution
+-------------------------
+
+C: { "execute": "migrate-pause", "id": 42, "control": { "run-oob": true } }
+S: { "id": 42,
+     "error": { "class": "GenericError",
+      "desc": "migrate-pause is currently only supported during postcopy-active state" } }
+
+
 4. Capabilities Negotiation
 ===========================
 
-- 
2.17.1
