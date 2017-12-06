Received: from eggs.gnu.org ([2001:4830:134:3::10]:49889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCg-0000wo-Nc
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCd-0000yq-It
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50628
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCd-0000yC-DU
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:55 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JFgkv021760
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:54 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2epn0ac1sf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:54 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:17:54 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:39 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-47-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 46/55] block/nfs: fix nfs_client_open for
 filesize greater than 1TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>

From: Peter Lieven <pl@kamp.de>

DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE) was overflowing ret (int) if
st.st_size is greater than 1TB.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
Message-id: 1511798407-31129-1-git-send-email-pl@kamp.de
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit f1a7ff770f7d71ee7833ff019aac9d6cc3d13f71)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/nfs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index bec16b72a6..addea26d56 100644
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
2.11.0
