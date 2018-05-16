Received: from eggs.gnu.org ([2001:4830:134:3::10]:33487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fJ0S7-00078O-D2
	for qemu-devel@nongnu.org; Wed, 16 May 2018 13:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fJ0S6-0006sn-EB
	for qemu-devel@nongnu.org; Wed, 16 May 2018 13:43:03 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 16 May 2018 13:42:34 -0400
Message-Id: <20180516174234.311-5-jcody@redhat.com>
In-Reply-To: <20180516174234.311-1-jcody@redhat.com>
References: <20180516174234.311-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] nfs: Remove processed options from QDict
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org

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
---
 block/nfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/nfs.c b/block/nfs.c
index 4ee2ad59d9..3349b67a76 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -557,6 +557,7 @@ static BlockdevOptionsNfs *nfs_options_qdict_to_qapi(QDict *options,
     BlockdevOptionsNfs *opts = NULL;
     QObject *crumpled = NULL;
     Visitor *v;
+    const QDictEntry *e;
     Error *local_err = NULL;
 
     crumpled = qdict_crumple(options, errp);
@@ -574,6 +575,12 @@ static BlockdevOptionsNfs *nfs_options_qdict_to_qapi(QDict *options,
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
2.13.6
