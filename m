Received: from eggs.gnu.org ([2001:4830:134:3::10]:54211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Xev-0002Lm-5P
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Xeu-0000ln-GV
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d1Xeu-0000lX-Az
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 582A6C00C0ED
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 12:27:31 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Fri, 21 Apr 2017 20:27:05 +0800
Message-Id: <20170421122710.15373-10-famz@redhat.com>
In-Reply-To: <20170421122710.15373-1-famz@redhat.com>
References: <20170421122710.15373-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 09/14] nfs: Make errp the last parameter of
 nfs_client_open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/nfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index 0816678..6541dec 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -497,7 +497,7 @@ out:
 
 
 static int64_t nfs_client_open(NFSClient *client, QDict *options,
-                               int flags, Error **errp, int open_flags)
+                               int flags, int open_flags, Error **errp)
 {
     int ret = -EINVAL;
     QemuOpts *opts = NULL;
@@ -663,7 +663,7 @@ static int nfs_file_open(BlockDriverState *bs, QDict *options, int flags,
 
     ret = nfs_client_open(client, options,
                           (flags & BDRV_O_RDWR) ? O_RDWR : O_RDONLY,
-                          errp, bs->open_flags);
+                          bs->open_flags, errp);
     if (ret < 0) {
         return ret;
     }
@@ -705,7 +705,7 @@ static int nfs_file_create(const char *url, QemuOpts *opts, Error **errp)
         goto out;
     }
 
-    ret = nfs_client_open(client, options, O_CREAT, errp, 0);
+    ret = nfs_client_open(client, options, O_CREAT, 0, errp);
     if (ret < 0) {
         goto out;
     }
-- 
2.9.3
