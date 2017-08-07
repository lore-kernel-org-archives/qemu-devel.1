Received: from eggs.gnu.org ([2001:4830:134:3::10]:49207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJE-0007YG-Uj
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIz-00043I-Mb
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:08 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:56 +0200
Message-Id: <1502117160-24655-53-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 52/56] block/nfs: Reject negative
 readahead-size, page-cache-size
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

The nfs block driver uses QEMU_OPT_NUMBER for these sizes.  All other
block drivers use QEMU_OPT_SIZE.  Both are uint64_t, but QEMU_OPT_SIZE
rejects negative numbers, while QEMU_OPT_NUMBER interprets them modulo
2^64.  Switch the nfs block driver to QEMU_OPT_SIZE.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/nfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index 2776788..0ed3e7c 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -394,12 +394,12 @@ static QemuOptsList runtime_opts = {
         },
         {
             .name = "readahead-size",
-            .type = QEMU_OPT_NUMBER,
+            .type = QEMU_OPT_SIZE,
             .help = "Set the readahead size in bytes",
         },
         {
             .name = "page-cache-size",
-            .type = QEMU_OPT_NUMBER,
+            .type = QEMU_OPT_SIZE,
             .help = "Set the pagecache size in bytes",
         },
         {
@@ -557,7 +557,7 @@ static int64_t nfs_client_open(NFSClient *client, QDict *options,
                              "if cache.direct = on");
             goto fail;
         }
-        client->readahead = qemu_opt_get_number(opts, "readahead-size", 0);
+        client->readahead = qemu_opt_get_size(opts, "readahead-size", 0);
         if (client->readahead > QEMU_NFS_MAX_READAHEAD_SIZE) {
             warn_report("Truncating NFS readahead size to %d",
                         QEMU_NFS_MAX_READAHEAD_SIZE);
@@ -578,7 +578,7 @@ static int64_t nfs_client_open(NFSClient *client, QDict *options,
                              "if cache.direct = on");
             goto fail;
         }
-        client->pagecache = qemu_opt_get_number(opts, "page-cache-size", 0);
+        client->pagecache = qemu_opt_get_size(opts, "page-cache-size", 0);
         if (client->pagecache > QEMU_NFS_MAX_PAGECACHE_SIZE) {
             warn_report("Truncating NFS pagecache size to %d pages",
                         QEMU_NFS_MAX_PAGECACHE_SIZE);
-- 
2.7.5
