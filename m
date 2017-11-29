Received: from eggs.gnu.org ([2001:4830:134:3::10]:54607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eK4Gf-0003Ei-LY
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:27:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eK4Gc-0007kJ-CE
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:27:21 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 29 Nov 2017 16:26:28 +0100
Message-Id: <20171129152628.14906-11-kwolf@redhat.com>
In-Reply-To: <20171129152628.14906-1-kwolf@redhat.com>
References: <20171129152628.14906-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 10/10] block/nfs: fix nfs_client_open for
 filesize greater than 1TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Peter Lieven <pl@kamp.de>

DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE) was overflowing ret (int) if
st.st_size is greater than 1TB.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
Message-id: 1511798407-31129-1-git-send-email-pl@kamp.de
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/nfs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index 337fcd9c84..effc8719b5 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -1,7 +1,7 @@
 /*
  * QEMU Block driver for native access to files on NFS shares
  *
- * Copyright (c) 2014-2016 Peter Lieven <pl@kamp.de>
+ * Copyright (c) 2014-2017 Peter Lieven <pl@kamp.de>
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -496,7 +496,7 @@ out:
 static int64_t nfs_client_open(NFSClient *client, QDict *options,
                                int flags, int open_flags, Error **errp)
 {
-    int ret = -EINVAL;
+    int64_t ret = -EINVAL;
     QemuOpts *opts = NULL;
     Error *local_err = NULL;
     struct stat st;
@@ -686,8 +686,7 @@ static QemuOptsList nfs_create_opts = {
 
 static int nfs_file_create(const char *url, QemuOpts *opts, Error **errp)
 {
-    int ret = 0;
-    int64_t total_size = 0;
+    int64_t ret, total_size;
     NFSClient *client = g_new0(NFSClient, 1);
     QDict *options = NULL;
 
-- 
2.13.6
