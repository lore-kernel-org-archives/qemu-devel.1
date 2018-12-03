Received: from eggs.gnu.org ([2001:4830:134:3::10]:60953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTqdO-0001tJ-BU
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:59:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTqdN-0004vo-G8
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:59:46 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon,  3 Dec 2018 09:59:34 -0600
Message-Id: <20181203155936.114526-2-eblake@redhat.com>
In-Reply-To: <20181203155936.114526-1-eblake@redhat.com>
References: <20181203155936.114526-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] nbd/server: Advertise all contexts in
 response to bare LIST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "open list:Network Block Dev..." <qemu-block@nongnu.org>

The NBD spec, and even our code comment, says that if the client
asks for NBD_OPT_LIST_META_CONTEXT with 0 queries, then we should
reply with (a possibly-compressed representation of) ALL contexts
that we are willing to let them try.  But commit 3d068aff forgot
to advertise qemu:dirty-bitmap:FOO.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20181130023232.3079982-2-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/nbd/server.c b/nbd/server.c
index dc04513de70..7af0ddffb20 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -978,6 +978,7 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
     if (client->opt == NBD_OPT_LIST_META_CONTEXT && !nb_queries) {
         /* enable all known contexts */
         meta->base_allocation = true;
+        meta->bitmap = !!meta->exp->export_bitmap;
     } else {
         for (i = 0; i < nb_queries; ++i) {
             ret = nbd_negotiate_meta_query(client, meta, errp);
-- 
2.17.2
