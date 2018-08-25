Received: from eggs.gnu.org ([2001:4830:134:3::10]:49442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ftZ4T-0001Gj-M2
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 09:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ftZ4S-0003A6-Td
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 09:57:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36242 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ftZ4S-00039y-Oy
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 09:57:44 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Aug 2018 15:57:20 +0200
Message-Id: <20180825135724.8981-6-marcandre.lureau@redhat.com>
In-Reply-To: <20180825135724.8981-1-marcandre.lureau@redhat.com>
References: <20180825135724.8981-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 5/9] json-lexer: make it safe to call
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

We can easily avoid the burden of checking if the lexer was
initialized prior to calling destroy by the caller, let's do it.

This allows simplification in state tracking in the qmp-async RFC
series, the patch "qmp: add QmpSession" can call qmp_session_destroy()
multiple time, which in turns calls json_lexer_destroy().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qobject/json-lexer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index e1745a3d95..39969047f4 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -351,5 +351,8 @@ void json_lexer_flush(JSONLexer *lexer)
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
2.18.0.547.g1d89318c48
