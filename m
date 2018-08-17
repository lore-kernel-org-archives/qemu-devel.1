Received: from eggs.gnu.org ([2001:4830:134:3::10]:46386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKL-00038v-Cc
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKG-0001nw-AA
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57114 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqgKF-0001l1-Gp
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:07 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Aug 2018 17:05:43 +0200
Message-Id: <20180817150559.16243-45-armbru@redhat.com>
In-Reply-To: <20180817150559.16243-1-armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 44/60] json: Fix latent parser aborts at end
 of input
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
---
 qobject/json-parser.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index c367dfc420..247946e7c7 100644
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
