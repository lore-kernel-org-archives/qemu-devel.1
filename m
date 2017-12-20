Received: from eggs.gnu.org ([2001:4830:134:3::10]:56459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyQ-0004jR-E4
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyO-0007HI-N8
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:06 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:39 +0100
Message-Id: <1513790098-9815-28-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 27/46] block/iscsi: dont leave allocmap in an
 invalid state on UNMAP failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Lieven <pl@kamp.de>, qemu-stable@nongnu.org

From: Peter Lieven <pl@kamp.de>

we forgot to set the allocmap to invalid if an UNMAP call fails.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
Message-Id: <1512733868-9009-2-git-send-email-pl@kamp.de>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
1.8.3.1
