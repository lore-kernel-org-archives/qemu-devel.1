Received: from eggs.gnu.org ([2001:4830:134:3::10]:37522)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1eJLpV-0002KW-1w
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:00:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1eJLpQ-00014t-92
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:00:21 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:47203 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1eJLpP-000127-Vg
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:00:16 -0500
From: Peter Lieven <pl@kamp.de>
Date: Mon, 27 Nov 2017 17:00:07 +0100
Message-Id: <1511798407-31129-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH for-2.11] block/nfs: fix nfs_client_open for
 filesize greater than 1TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, Peter Lieven <pl@kamp.de>, qemu-stable@nongnu.org

DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE) was overflowing ret (int) if
st.st_size is greater than 1TB.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
---
 block/nfs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index 337fcd9..effc871 100644
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
1.9.1
