Received: from eggs.gnu.org ([2001:4830:134:3::10]:44170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8ir-0005Qq-CZ
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8im-00082k-3O
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8il-00081p-Qs
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:00 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JEKFP112135
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:15:59 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fygkucwfb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:15:58 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:15:57 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:23 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-3-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 02/54] block/iscsi: dont leave allocmap in an
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
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Peter Lieven <pl@kamp.de>, Paolo Bonzini <pbonzini@redhat.com>

From: Peter Lieven <pl@kamp.de>

we forgot to set the allocmap to invalid if an UNMAP call fails.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
Message-Id: <1512733868-9009-2-git-send-email-pl@kamp.de>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit aef172ffdc2f9c41d9cc043a55f1259e7c07e587)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/iscsi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 4683f3b244..c532ec79d1 100644
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
2.11.0
