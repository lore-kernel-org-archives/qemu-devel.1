Received: from eggs.gnu.org ([2001:4830:134:3::10]:57811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuBVv-0005tk-5f
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuBVr-00067Q-T6
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:00:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54312 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fuBVr-00066z-LE
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:00:35 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Aug 2018 09:00:19 +0200
Message-Id: <20180827070021.11931-5-armbru@redhat.com>
In-Reply-To: <20180827070021.11931-1-armbru@redhat.com>
References: <20180827070021.11931-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 4/6] json: Nicer recovery from lexical errors
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

When the lexer chokes on an input character, it consumes the
character, emits a JSON error token, and enters its start state.  This
can lead to suboptimal error recovery.  For instance, input

    0123 ,

produces the tokens

    JSON_ERROR    01
    JSON_INTEGER  23
    JSON_COMMA    ,

Make the lexer skip characters after a lexical error until a
structural character ('[', ']', '{', '}', ':', ','), an ASCII control
character, or '\xFE', or '\xFF'.

Note that we must not skip ASCII control characters, '\xFE', '\xFF',
because those are documented to force the JSON parser into known-good
state, by docs/interop/qmp-spec.txt.

The lexer now produces

    JSON_ERROR    01
    JSON_COMMA    ,

Update qmp-test for the nicer error recovery: QMP now report just one
error for input %p instead of two.  Also drop the newline after %p; it
was needed to tease out the second error.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/json-lexer.c | 43 +++++++++++++++++++++++++++++--------------
 tests/qmp-test.c     |  6 +-----
 2 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index 28582e17d9..39c7ce7adc 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -101,6 +101,7 @@
 
 enum json_lexer_state {
     IN_ERROR = 0,               /* must really be 0, see json_lexer[] */
+    IN_RECOVERY,
     IN_DQ_STRING_ESCAPE,
     IN_DQ_STRING,
     IN_SQ_STRING_ESCAPE,
@@ -130,6 +131,28 @@ QEMU_BUILD_BUG_ON(IN_START_INTERP != IN_START + 1);
 static const uint8_t json_lexer[][256] =  {
     /* Relies on default initialization to IN_ERROR! */
 
+    /* error recovery */
+    [IN_RECOVERY] = {
+        /*
+         * Skip characters until a structural character, an ASCII
+         * control character other than '\t', or impossible UTF-8
+         * bytes '\xFE', '\xFF'.  Structural characters and line
+         * endings are promising resynchronization points.  Clients
+         * may use the others to force the JSON parser into known-good
+         * state; see docs/interop/qmp-spec.txt.
+         */
+        [0 ... 0x1F] = IN_START | LOOKAHEAD,
+        [0x20 ... 0xFD] = IN_RECOVERY,
+        [0xFE ... 0xFF] = IN_START | LOOKAHEAD,
+        ['\t'] = IN_RECOVERY,
+        ['['] = IN_START | LOOKAHEAD,
+        [']'] = IN_START | LOOKAHEAD,
+        ['{'] = IN_START | LOOKAHEAD,
+        ['}'] = IN_START | LOOKAHEAD,
+        [':'] = IN_START | LOOKAHEAD,
+        [','] = IN_START | LOOKAHEAD,
+    },
+
     /* double quote string */
     [IN_DQ_STRING_ESCAPE] = {
         [0x20 ... 0xFD] = IN_DQ_STRING,
@@ -301,26 +324,18 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
             /* fall through */
         case JSON_SKIP:
             g_string_truncate(lexer->token, 0);
+            /* fall through */
+        case IN_START:
             new_state = lexer->start_state;
             break;
         case IN_ERROR:
-            /* XXX: To avoid having previous bad input leaving the parser in an
-             * unresponsive state where we consume unpredictable amounts of
-             * subsequent "good" input, percolate this error state up to the
-             * parser by emitting a JSON_ERROR token, then reset lexer state.
-             *
-             * Also note that this handling is required for reliable channel
-             * negotiation between QMP and the guest agent, since chr(0xFF)
-             * is placed at the beginning of certain events to ensure proper
-             * delivery when the channel is in an unknown state. chr(0xFF) is
-             * never a valid ASCII/UTF-8 sequence, so this should reliably
-             * induce an error/flush state.
-             */
             json_message_process_token(lexer, lexer->token, JSON_ERROR,
                                        lexer->x, lexer->y);
+            new_state = IN_RECOVERY;
+            /* fall through */
+        case IN_RECOVERY:
             g_string_truncate(lexer->token, 0);
-            lexer->state = lexer->start_state;
-            return;
+            break;
         default:
             break;
         }
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 4ae2245484..04ad7648d2 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -93,11 +93,7 @@ static void test_malformed(QTestState *qts)
     g_assert(recovered(qts));
 
     /* lexical error: interpolation */
-    qtest_qmp_send_raw(qts, "%%p\n");
-    /* two errors, one for "%", one for "p" */
-    resp = qtest_qmp_receive(qts);
-    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
-    qobject_unref(resp);
+    qtest_qmp_send_raw(qts, "%%p");
     resp = qtest_qmp_receive(qts);
     g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
     qobject_unref(resp);
-- 
2.17.1
