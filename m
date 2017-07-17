Received: from eggs.gnu.org ([2001:4830:134:3::10]:57366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX8O8-0002sC-PS
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX8O8-0007at-2j
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:56:48 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 17 Jul 2017 10:56:30 -0500
Message-Id: <20170717155632.12754-4-eblake@redhat.com>
In-Reply-To: <20170717155632.12754-1-eblake@redhat.com>
References: <20170717155632.12754-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] nfs: Use simpler QAPI_TO_QOBJECT()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, Jeff Cody <jcody@redhat.com>, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:NFS" <qemu-block@nongnu.org>

Use the new macro to avoid some boilerplate.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nfs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index d8db419957..5f3045c1af 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -819,7 +819,6 @@ static void nfs_refresh_filename(BlockDriverState *bs, QDict *options)
     NFSClient *client = bs->opaque;
     QDict *opts = qdict_new();
     QObject *server_qdict;
-    Visitor *ov;

     qdict_put_str(opts, "driver", "nfs");

@@ -840,9 +839,9 @@ static void nfs_refresh_filename(BlockDriverState *bs, QDict *options)
                  "nfs://%s%s", client->server->host, client->path);
     }

-    ov = qobject_output_visitor_new(&server_qdict);
-    visit_type_NFSServer(ov, NULL, &client->server, &error_abort);
-    visit_complete(ov, &server_qdict);
+    server_qdict = QAPI_TO_QOBJECT(NFSServer, client->server, &error_abort);
+    assert(qobject_type(server_qdict) == QTYPE_QDICT);
+
     qdict_put_obj(opts, "server", server_qdict);
     qdict_put_str(opts, "path", client->path);

@@ -865,7 +864,6 @@ static void nfs_refresh_filename(BlockDriverState *bs, QDict *options)
         qdict_put_int(opts, "debug", client->debug);
     }

-    visit_free(ov);
     qdict_flatten(opts);
     bs->full_open_options = opts;
 }
-- 
2.13.3
