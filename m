Received: from eggs.gnu.org ([2001:4830:134:3::10]:49177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCJ-0000ZR-Tb
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCG-0000TT-MP
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43954
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCG-0000Sz-Ga
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:32 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JE20K112303
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:32 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2epm58y16r-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:31 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 12:17:31 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:22 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-30-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 29/55] qcow2: Fix unaligned preallocated
 truncation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Max Reitz <mreitz@redhat.com>

A qcow2 image file's length is not required to have a length that is a
multiple of the cluster size.  However, qcow2_refcount_area() expects an
aligned value for its @start_offset parameter, so we need to round
@old_file_size up to the next cluster boundary.

Reported-by: Ping Li <pingl@redhat.com>
Bug: https://bugzilla.redhat.com/show_bug.cgi?id=1414049
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20171009215533.12530-2-mreitz@redhat.com
Cc: qemu-stable@nongnu.org
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit e400ad1e1f0127b4fdabcb1c8de1e99be91788df)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/qcow2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index a756bf9541..10e38074ad 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3161,6 +3161,7 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
                              "Failed to inquire current file length");
             return ret;
         }
+        old_file_size = ROUND_UP(old_file_size, s->cluster_size);
 
         nb_new_data_clusters = DIV_ROUND_UP(offset - old_length,
                                             s->cluster_size);
-- 
2.11.0
