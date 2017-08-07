Received: from eggs.gnu.org ([2001:4830:134:3::10]:49316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJJ-0007fj-QP
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJ4-00047P-C9
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:13 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:55 +0200
Message-Id: <1502117160-24655-52-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 51/56] block/nfs: Fix for readahead-size,
 page-cache-size > INT64_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

nfs_client_open() implicitly converts the uint64_t value of
qemu_opt_get_number() to int64_t, then clamps it to range.  The
clamping is broken for negative values.

Fix by making NFSClient members @readahead and @pagecache uint64_t.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/nfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index d8db419..2776788 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -58,7 +58,8 @@ typedef struct NFSClient {
     bool cache_used;
     NFSServer *server;
     char *path;
-    int64_t uid, gid, tcp_syncnt, readahead, pagecache, debug;
+    int64_t uid, gid, tcp_syncnt, debug;
+    uint64_t readahead, pagecache;
 } NFSClient;
 
 typedef struct NFSRPC {
@@ -856,10 +857,10 @@ static void nfs_refresh_filename(BlockDriverState *bs, QDict *options)
         qdict_put_int(opts, "tcp-syn-cnt", client->tcp_syncnt);
     }
     if (client->readahead) {
-        qdict_put_int(opts, "readahead-size", client->readahead);
+        qdict_put_uint(opts, "readahead-size", client->readahead);
     }
     if (client->pagecache) {
-        qdict_put_int(opts, "page-cache-size", client->pagecache);
+        qdict_put_uint(opts, "page-cache-size", client->pagecache);
     }
     if (client->debug) {
         qdict_put_int(opts, "debug", client->debug);
-- 
2.7.5
