Received: from eggs.gnu.org ([2001:4830:134:3::10]:54842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tkl-0005B9-6P
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tkf-0002jE-GS
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47466 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0Tkf-0002j4-BZ
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:37 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:08:45 +0200
Message-Id: <20180326150916.9602-8-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 07/38] json-parser: always set an error if
 return NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Let's make json_parser_parse_err() suck less, and simplify caller
error handling.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 monitor.c             | 4 ----
 qobject/json-parser.c | 7 ++++++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/monitor.c b/monitor.c
index 5889a32231..e9d0c4d172 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4053,10 +4053,6 @@ static void handle_qmp_command(JSONMessageParser *=
parser, GQueue *tokens)
     QMPRequest *req_obj;
=20
     req =3D json_parser_parse_err(tokens, NULL, &err);
-    if (!req && !err) {
-        /* json_parser_parse_err() sucks: can fail without setting @err =
*/
-        error_setg(&err, QERR_JSON_PARSING);
-    }
     if (err) {
         goto err;
     }
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 769b960c9f..c39cd8e4d7 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -591,7 +591,12 @@ QObject *json_parser_parse_err(GQueue *tokens, va_li=
st *ap, Error **errp)
=20
     result =3D parse_value(ctxt, ap);
=20
-    error_propagate(errp, ctxt->err);
+    if (!result && !ctxt->err) {
+        /* TODO: improve error reporting */
+        error_setg(errp, "Failed to parse JSON");
+    } else {
+        error_propagate(errp, ctxt->err);
+    }
=20
     parser_context_free(ctxt);
=20
--=20
2.17.0.rc1.1.g4c4f2b46a3
