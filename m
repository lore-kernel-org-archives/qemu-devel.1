Received: from eggs.gnu.org ([209.51.188.92]:55404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtKU-0001wz-3c
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:10:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtKS-0004Qc-6v
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:10:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hDtKQ-0004Oq-JN
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:10:30 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 Apr 2019 18:09:51 +0200
Message-Id: <20190409161009.6322-3-marcandre.lureau@redhat.com>
In-Reply-To: <20190409161009.6322-1-marcandre.lureau@redhat.com>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 02/20] json-lexer: make it safe to call
 destroy multiple times
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

We can easily avoid the burden of checking if the lexer was
initialized prior to calling destroy by the caller, let's do it.

This allows simplification in state tracking with the following patch,
"qmp: add QmpSession" can call qmp_session_destroy() multiple times,
which in turns calls json_lexer_destroy().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qobject/json-lexer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index 632320d72d..fa7a2c43a8 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -361,5 +361,8 @@ void json_lexer_flush(JSONLexer *lexer)
=20
 void json_lexer_destroy(JSONLexer *lexer)
 {
-    g_string_free(lexer->token, true);
+    if (lexer->token) {
+        g_string_free(lexer->token, true);
+        lexer->token =3D NULL;
+    }
 }
--=20
2.21.0.196.g041f5ea1cf
