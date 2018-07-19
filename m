Received: from eggs.gnu.org ([2001:4830:134:3::10]:48869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fgDrs-0001iW-I4
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fgDrp-0007rK-SI
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54790 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fgDro-0007qs-UX
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E6CD8182D0F
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 18:41:32 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 19 Jul 2018 20:41:02 +0200
Message-Id: <20180719184111.5129-10-marcandre.lureau@redhat.com>
In-Reply-To: <20180719184111.5129-1-marcandre.lureau@redhat.com>
References: <20180719184111.5129-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 09/18] json-parser: further simplify freeing
 JSONParserContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Use g_queue_free_full() directly.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qobject/json-parser.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 6baf73b4b9..0c0b478149 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -561,11 +561,8 @@ QObject *json_parser_parse(GQueue *tokens, va_list *=
ap, Error **errp)
=20
     error_propagate(errp, ctxt.err);
=20
-    while (!g_queue_is_empty(ctxt.buf)) {
-        parser_context_pop_token(&ctxt);
-    }
+    g_queue_free_full(ctxt.buf, g_free);
     g_free(ctxt.current);
-    g_queue_free(ctxt.buf);
=20
     return result;
 }
--=20
2.18.0.129.ge3331758f1
