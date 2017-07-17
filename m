Received: from eggs.gnu.org ([2001:4830:134:3::10]:57291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX8O2-0002os-M6
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX8O1-0007Ys-RK
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:56:42 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 17 Jul 2017 10:56:29 -0500
Message-Id: <20170717155632.12754-3-eblake@redhat.com>
In-Reply-To: <20170717155632.12754-1-eblake@redhat.com>
References: <20170717155632.12754-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] nbd: Use simpler QAPI_TO_QOBJECT()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

Use the new macro to avoid some boilerplate.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index a50d24b50a..f90ac76d1f 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -519,7 +519,6 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
     BDRVNBDState *s = bs->opaque;
     QDict *opts = qdict_new();
     QObject *saddr_qdict;
-    Visitor *ov;
     const char *host = NULL, *port = NULL, *path = NULL;

     if (s->saddr->type == SOCKET_ADDRESS_TYPE_INET) {
@@ -548,10 +547,9 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
                  "nbd://%s:%s", host, port);
     }

-    ov = qobject_output_visitor_new(&saddr_qdict);
-    visit_type_SocketAddress(ov, NULL, &s->saddr, &error_abort);
-    visit_complete(ov, &saddr_qdict);
-    visit_free(ov);
+    saddr_qdict = QAPI_TO_QOBJECT(SocketAddress, s->saddr, &error_abort);
+    assert(qobject_type(saddr_qdict) == QTYPE_QDICT);
+
     qdict_put_obj(opts, "server", saddr_qdict);

     if (s->export) {
-- 
2.13.3
