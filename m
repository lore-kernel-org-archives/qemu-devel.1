Received: from eggs.gnu.org ([209.51.188.92]:41760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB45X-0002H3-PK
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB45W-00042k-Oj
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40600
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB45W-0003wG-Hd
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:26 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1ptj095688
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:03:16 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksweh0j5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:03:15 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:03:14 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 16:00:06 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-93-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 92/97] bitmap: Update count after a merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

From: Eric Blake <eblake@redhat.com>

We need an accurate count of the number of bits set in a bitmap
after a merge. In particular, since the merge operation short-circuits
a merge from an empty source, if you have bitmaps A, B, and C where
B started empty, then merge C into B, and B into A, an inaccurate
count meant that A did not get the contents of C.

In the worst case, we may falsely regard the bitmap as empty when
it has had new writes merged into it.

Fixes: be58721db
CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20181002233314.30159-1-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
(cherry picked from commit d1dde7149e376d72b422a529ec4bf3ed47f3ba30)
*drop functional dep. on fa000f2f
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 util/hbitmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/util/hbitmap.c b/util/hbitmap.c
index bcd304041a..f686e8015f 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -754,6 +754,9 @@ bool hbitmap_merge(HBitmap *a, const HBitmap *b)
         }
     }
 
+    /* Recompute the dirty count */
+    a->count = hb_count_between(a, 0, a->size - 1);
+
     return true;
 }
 
-- 
2.17.1
