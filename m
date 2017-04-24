Received: from eggs.gnu.org ([2001:4830:134:3::10]:53557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d2YOo-0003wZ-Km
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d2YOn-0006vr-O1
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d2YOn-0006vJ-I0
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8487E23E6CF
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 07:27:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 24 Apr 2017 09:26:55 +0200
Message-Id: <1493018820-23445-11-git-send-email-armbru@redhat.com>
In-Reply-To: <1493018820-23445-1-git-send-email-armbru@redhat.com>
References: <1493018820-23445-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 10/15] nfs: Make errp the last parameter of
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
Cc: Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170421122710.15373-10-famz@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
2.7.4
