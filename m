Received: from eggs.gnu.org ([2001:4830:134:3::10]:39137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHxR-0003N0-Ap
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHxN-0001CZ-PG
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41892 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHxN-0001Bv-JB
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 44C3A804BAAD
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:41:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 21B1A10075E7
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:41:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:31:57 +0200
Message-Id: <20180824193206.25475-50-armbru@redhat.com>
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 49/58] json: Streamline
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180823164025.12553-50-armbru@redhat.com>
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
