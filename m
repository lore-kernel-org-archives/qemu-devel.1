Received: from eggs.gnu.org ([2001:4830:134:3::10]:38048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsj9-0003UQ-BH
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsj5-0007oy-Es
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cTsj5-0007oR-7Y
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:43 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 617837FB74
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:04:43 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Jan 2017 20:03:23 +0400
Message-Id: <20170118160332.13390-17-marcandre.lureau@redhat.com>
In-Reply-To: <20170118160332.13390-1-marcandre.lureau@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 16/25] qmp: update qmp-spec about async
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kraxel@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 docs/qmp-spec.txt | 48 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/docs/qmp-spec.txt b/docs/qmp-spec.txt
index f8b5356015..b45c0700b6 100644
--- a/docs/qmp-spec.txt
+++ b/docs/qmp-spec.txt
@@ -83,9 +83,41 @@ The greeting message format is:
 2.2.1 Capabilities
 ------------------
=20
-As of the date this document was last revised, no server or client
-capability strings have been defined.
+The "capabilities" member of the greeting message and qmp_capabilities
+is a json-array of json-string of the following values:
=20
+- "async"
+
+This capability indicates asynchronous commands support.
+
+An async command is a regular client message request with the "id"
+member mandatory (see 2.3), but the reply may be delivered
+asynchronously and out of order by the server if the client supports
+it too.
+
+If both the server and the client have the "async" capability, the
+client can make requests while previous async requests are being
+processed.
+
+If the client doesn't have the "async" capability, it may still call
+an async command, and make multiple outstanding calls. In this case,
+the commands are processed in order, so the replies will also be in
+order (this is sometime called 'pipelining'). The "id" member isn't
+mandatory in this case.
+
+The client should match the replies with the "id" member associated
+with the requests.
+
+When a client is disconnected, the pending commands are not
+necessarily canceled. But the future clients will not get replies from
+commands they didn't make (they might, however, receive side-effects
+events).
+
+Note that without "async" support, a client may still receive
+asynchronous messages (or events) from the server between the time a
+request is handled by the server and the reply is received. It must
+thus be prepared to handle dispatching both events and reply after
+sending a request.
=20
 2.3 Issuing Commands
 --------------------
@@ -102,10 +134,11 @@ The format for command execution is:
   required. Each command documents what contents will be considered
   valid when handling the json-argument
 - The "id" member is a transaction identification associated with the
-  command execution, it is optional and will be part of the response if
-  provided. The "id" member can be any json-value, although most
+  command execution and will be part of the response if provided.
+  If "async" is negotiated (see 2.2.1), it is mandatory, optional
+  otherwise. The "id" member can be any json-value, although most
   clients merely use a json-number incremented for each successive
-  command
+  command.
=20
 2.4 Commands Responses
 ----------------------
@@ -202,11 +235,12 @@ This section provides some examples of real QMP usa=
ge, in all of them
 -------------------
=20
 S: { "QMP": { "version": { "qemu": { "micro": 50, "minor": 6, "major": 1=
 },
-     "package": ""}, "capabilities": []}}
+     "package": ""}, "capabilities": [ "async" ]}}
=20
 3.2 Client QMP negotiation
 --------------------------
-C: { "execute": "qmp_capabilities" }
+C: { "execute": "qmp_capabilities",
+     "arguments": { "capabilities": [ "async" ] } }
 S: { "return": {}}
=20
 3.3 Simple 'stop' execution
--=20
2.11.0.295.gd7dffce1c
