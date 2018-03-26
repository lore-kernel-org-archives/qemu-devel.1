Received: from eggs.gnu.org ([2001:4830:134:3::10]:54856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tkm-0005EM-JJ
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tkg-0002kF-Sx
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57190 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0Tkg-0002jx-Ob
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:38 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:08:46 +0200
Message-Id: <20180326150916.9602-9-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 08/38] json-lexer: make it safe to call
 multiple times
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

We can easily avoid the burden of checking if the lexer was
initialized prior to calling destroy by the caller, let's do it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qobject/json-lexer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index 980ba159d6..0eaba43a2c 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -386,5 +386,8 @@ int json_lexer_flush(JSONLexer *lexer)
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
2.17.0.rc1.1.g4c4f2b46a3
