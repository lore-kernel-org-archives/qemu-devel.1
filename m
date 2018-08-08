Received: from eggs.gnu.org ([2001:4830:134:3::10]:52541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBp-0006ix-Bq
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBk-00004y-FN
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51086 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnNBj-0008Us-Uk
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:40 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Aug 2018 14:03:08 +0200
Message-Id: <20180808120334.10970-31-armbru@redhat.com>
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 30/56] json: remove useless return value from
 lexer/parser
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com, eblake@redhat.com

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The lexer always returns 0 when char feeding. Furthermore, none of the
caller care about the return value.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180326150916.9602-10-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/json-lexer.h    |  4 ++--
 include/qapi/qmp/json-streamer.h |  4 ++--
 qobject/json-lexer.c             | 23 ++++++++---------------
 qobject/json-streamer.c          |  8 ++++----
 4 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/include/qapi/qmp/json-lexer.h b/include/qapi/qmp/json-lexer.=
h
index afee7828cd..66ccf0357c 100644
--- a/include/qapi/qmp/json-lexer.h
+++ b/include/qapi/qmp/json-lexer.h
@@ -47,9 +47,9 @@ struct JSONLexer
=20
 void json_lexer_init(JSONLexer *lexer, JSONLexerEmitter func);
=20
-int json_lexer_feed(JSONLexer *lexer, const char *buffer, size_t size);
+void json_lexer_feed(JSONLexer *lexer, const char *buffer, size_t size);
=20
-int json_lexer_flush(JSONLexer *lexer);
+void json_lexer_flush(JSONLexer *lexer);
=20
 void json_lexer_destroy(JSONLexer *lexer);
=20
diff --git a/include/qapi/qmp/json-streamer.h b/include/qapi/qmp/json-str=
eamer.h
index 00d8a23af8..cb808cf27d 100644
--- a/include/qapi/qmp/json-streamer.h
+++ b/include/qapi/qmp/json-streamer.h
@@ -36,10 +36,10 @@ typedef struct JSONMessageParser
 void json_message_parser_init(JSONMessageParser *parser,
                               void (*func)(JSONMessageParser *, GQueue *=
));
=20
-int json_message_parser_feed(JSONMessageParser *parser,
+void json_message_parser_feed(JSONMessageParser *parser,
                              const char *buffer, size_t size);
=20
-int json_message_parser_flush(JSONMessageParser *parser);
+void json_message_parser_flush(JSONMessageParser *parser);
=20
 void json_message_parser_destroy(JSONMessageParser *parser);
=20
diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index af0a7fdb8a..87cdd41f29 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -286,7 +286,7 @@ void json_lexer_init(JSONLexer *lexer, JSONLexerEmitt=
er func)
     lexer->x =3D lexer->y =3D 0;
 }
=20
-static int json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
+static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
 {
     int char_consumed, new_state;
=20
@@ -340,7 +340,7 @@ static int json_lexer_feed_char(JSONLexer *lexer, cha=
r ch, bool flush)
             g_string_truncate(lexer->token, 0);
             new_state =3D IN_START;
             lexer->state =3D new_state;
-            return 0;
+            return;
         default:
             break;
         }
@@ -355,29 +355,22 @@ static int json_lexer_feed_char(JSONLexer *lexer, c=
har ch, bool flush)
         g_string_truncate(lexer->token, 0);
         lexer->state =3D IN_START;
     }
-
-    return 0;
 }
=20
-int json_lexer_feed(JSONLexer *lexer, const char *buffer, size_t size)
+void json_lexer_feed(JSONLexer *lexer, const char *buffer, size_t size)
 {
     size_t i;
=20
     for (i =3D 0; i < size; i++) {
-        int err;
-
-        err =3D json_lexer_feed_char(lexer, buffer[i], false);
-        if (err < 0) {
-            return err;
-        }
+        json_lexer_feed_char(lexer, buffer[i], false);
     }
-
-    return 0;
 }
=20
-int json_lexer_flush(JSONLexer *lexer)
+void json_lexer_flush(JSONLexer *lexer)
 {
-    return lexer->state =3D=3D IN_START ? 0 : json_lexer_feed_char(lexer=
, 0, true);
+    if (lexer->state !=3D IN_START) {
+        json_lexer_feed_char(lexer, 0, true);
+    }
 }
=20
 void json_lexer_destroy(JSONLexer *lexer)
diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index c51c2021f9..78dfff2aa0 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -118,15 +118,15 @@ void json_message_parser_init(JSONMessageParser *pa=
rser,
     json_lexer_init(&parser->lexer, json_message_process_token);
 }
=20
-int json_message_parser_feed(JSONMessageParser *parser,
+void json_message_parser_feed(JSONMessageParser *parser,
                              const char *buffer, size_t size)
 {
-    return json_lexer_feed(&parser->lexer, buffer, size);
+    json_lexer_feed(&parser->lexer, buffer, size);
 }
=20
-int json_message_parser_flush(JSONMessageParser *parser)
+void json_message_parser_flush(JSONMessageParser *parser)
 {
-    return json_lexer_flush(&parser->lexer);
+    json_lexer_flush(&parser->lexer);
 }
=20
 void json_message_parser_destroy(JSONMessageParser *parser)
--=20
2.17.1
