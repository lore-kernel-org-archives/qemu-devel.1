Received: from eggs.gnu.org ([2001:4830:134:3::10]:52664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBt-0006om-BI
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBl-000077-A6
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51104 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnNBk-0008Vp-Ml
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:40 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Aug 2018 14:03:22 +0200
Message-Id: <20180808120334.10970-45-armbru@redhat.com>
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 44/56] json: Fix latent parser aborts at end of
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
---
 qobject/json-parser.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 350a9d267b..c2974d46b3 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -221,14 +221,12 @@ out:
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
