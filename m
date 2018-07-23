Received: from eggs.gnu.org ([2001:4830:134:3::10]:43399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhL5-0004HV-8j
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhL4-0005Yg-Bm
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:51 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:37 -0500
Message-Id: <20180723201748.25573-89-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 88/99] nfs: Remove processed options from QDict
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>

From: Kevin Wolf <kwolf@redhat.com>

Commit c22a03454 QAPIfied option parsing in the NFS block driver, but
forgot to remove all the options we processed. Therefore, we get an
error in bdrv_open_inherit(), which thinks the remaining options are
invalid. Trying to open an NFS image will result in an error like this:

    Block protocol 'nfs' doesn't support the option 'server.host'

Remove all options from the QDict to make the NFS driver work again.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-id: 20180516160816.26259-1-kwolf@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
(cherry picked from commit c82be42cc803b36fd7aed5dceec68312c7056fd5)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/nfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/nfs.c b/block/nfs.c
index 2577df4b26..dc12d5000d 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -557,6 +557,7 @@ static BlockdevOptionsNfs *nfs_options_qdict_to_qapi(QDict *options,
     BlockdevOptionsNfs *opts = NULL;
     QObject *crumpled = NULL;
     Visitor *v;
+    const QDictEntry *e;
     Error *local_err = NULL;
 
     crumpled = qdict_crumple(options, errp);
@@ -573,6 +574,12 @@ static BlockdevOptionsNfs *nfs_options_qdict_to_qapi(QDict *options,
         return NULL;
     }
 
+    /* Remove the processed options from the QDict (the visitor processes
+     * _all_ options in the QDict) */
+    while ((e = qdict_first(options))) {
+        qdict_del(options, e->key);
+    }
+
     return opts;
 }
 
-- 
2.17.1
