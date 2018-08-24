Received: from eggs.gnu.org ([2001:4830:134:3::10]:39125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHxR-0003Mu-95
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHxM-0001Ap-Rl
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56904 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHxM-0001A4-Iz
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2F1468780F
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:41:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AD8C621BE
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:41:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:31:52 +0200
Message-Id: <20180824193206.25475-45-armbru@redhat.com>
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 44/58] json: Fix latent parser aborts at end of
 input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

json-parser.c carefully reports end of input like this:

    token = parser_context_pop_token(ctxt);
    if (token == NULL) {
        parse_error(ctxt, NULL, "premature EOI");
        goto out;
    }

Except parser_context_pop_token() can't return null, it fails its
assertion instead.  Same for parser_context_peek_token().  Broken in
commit 65c0f1e9558, and faithfully preserved in commit 95385fe9ace.
Only a latent bug, because the streamer throws away any input that
could trigger it.

Drop the assertions, so we can fix the streamer in the next commit.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180823164025.12553-45-armbru@redhat.com>
---
 qobject/json-parser.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 27e873ad3b..e3ee2a273a 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -226,14 +226,12 @@ out:
 static JSONToken *parser_context_pop_token(JSONParserContext *ctxt)
 {
     g_free(ctxt->current);
-    assert(!g_queue_is_empty(ctxt->buf));
     ctxt->current = g_queue_pop_head(ctxt->buf);
     return ctxt->current;
 }
 
 static JSONToken *parser_context_peek_token(JSONParserContext *ctxt)
 {
-    assert(!g_queue_is_empty(ctxt->buf));
     return g_queue_peek_head(ctxt->buf);
 }
 
-- 
2.17.1
