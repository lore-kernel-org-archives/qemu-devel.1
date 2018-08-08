Received: from eggs.gnu.org ([2001:4830:134:3::10]:52683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBu-0006ov-1I
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBl-00007y-MU
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51752 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnNBl-00005k-7Z
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:41 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Aug 2018 14:03:27 +0200
Message-Id: <20180808120334.10970-50-armbru@redhat.com>
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 49/56] json: Streamline
 json_message_process_token()
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/json-streamer.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index 810aae521f..954bf9d468 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -99,16 +99,13 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
 
     g_queue_push_tail(parser->tokens, token);
 
-    if (parser->brace_count < 0 ||
-        parser->bracket_count < 0 ||
-        (parser->brace_count == 0 &&
-         parser->bracket_count == 0)) {
-        json = json_parser_parse(parser->tokens, parser->ap, &err);
-        parser->tokens = NULL;
-        goto out_emit;
+    if ((parser->brace_count > 0 || parser->bracket_count > 0)
+        && parser->bracket_count >= 0 && parser->bracket_count >= 0) {
+        return;
     }
 
-    return;
+    json = json_parser_parse(parser->tokens, parser->ap, &err);
+    parser->tokens = NULL;
 
 out_emit:
     parser->brace_count = 0;
-- 
2.17.1
