Received: from eggs.gnu.org ([2001:4830:134:3::10]:33804)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1eNHBi-0003Wz-UZ
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:51:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1eNHBe-0006cJ-Vg
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:51:30 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:60443 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1eNHBe-0006bT-Ln
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:51:26 -0500
From: Peter Lieven <pl@kamp.de>
Date: Fri,  8 Dec 2017 12:51:07 +0100
Message-Id: <1512733868-9009-2-git-send-email-pl@kamp.de>
In-Reply-To: <1512733868-9009-1-git-send-email-pl@kamp.de>
References: <1512733868-9009-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH 1/2] block/iscsi: dont leave allocmap in an
 invalid state on UNMAP failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, ronniesahlberg@gmail.com, pbonzini@redhat.com, Peter Lieven <pl@kamp.de>, qemu-stable@nongnu.org

we forgot to set the allocmap to invalid if an UNMAP call fails.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
---
 block/iscsi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 4683f3b..c532ec7 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2,7 +2,7 @@
  * QEMU Block driver for iSCSI images
  *
  * Copyright (c) 2010-2011 Ronnie Sahlberg <ronniesahlberg@gmail.com>
- * Copyright (c) 2012-2016 Peter Lieven <pl@kamp.de>
+ * Copyright (c) 2012-2017 Peter Lieven <pl@kamp.de>
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -1128,6 +1128,9 @@ retry:
         goto retry;
     }
 
+    iscsi_allocmap_set_invalid(iscsilun, offset >> BDRV_SECTOR_BITS,
+                               bytes >> BDRV_SECTOR_BITS);
+
     if (iTask.status == SCSI_STATUS_CHECK_CONDITION) {
         /* the target might fail with a check condition if it
            is not happy with the alignment of the UNMAP request
@@ -1140,9 +1143,6 @@ retry:
         goto out_unlock;
     }
 
-    iscsi_allocmap_set_invalid(iscsilun, offset >> BDRV_SECTOR_BITS,
-                               bytes >> BDRV_SECTOR_BITS);
-
 out_unlock:
     qemu_mutex_unlock(&iscsilun->mutex);
     return r;
-- 
1.9.1
