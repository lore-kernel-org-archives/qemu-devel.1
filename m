Received: from eggs.gnu.org ([2001:4830:134:3::10]:42398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBo-0002dc-Sq
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBm-0001FT-BL
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59193
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBm-0001FG-54
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:26 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0jekl079776
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:25 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdm79085-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:25 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:24 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:20 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-27-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 26/67] qemu: use bdrv_flush_all for vm_stop et
 al
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>

From: John Snow <jsnow@redhat.com>

Reimplement bdrv_flush_all for vm_stop. In contrast to blk_flush_all,
bdrv_flush_all does not have device model restrictions. This allows
us to flush and halt unconditionally without error.

This allows us to do things like migrate when we have a device with
an open tray, but has a node that may need to be flushed, or nodes
that aren't currently attached to any device and need to be flushed.

Specifically, this allows us to migrate when we have a CDROM with
an open tray.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Acked-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 22af08eacf6b5aa0e6c0581e547380b3eb4f95e9)
Conflicts:
	cpus.c

* drop context dependancy on 6d0ceb80

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 cpus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cpus.c b/cpus.c
index 84c3520..7e73c03 100644
--- a/cpus.c
+++ b/cpus.c
@@ -745,7 +745,7 @@ static int do_vm_stop(RunState state)
     }
 
     bdrv_drain_all();
-    ret = blk_flush_all();
+    ret = bdrv_flush_all();
 
     return ret;
 }
@@ -1488,7 +1488,7 @@ int vm_stop_force_state(RunState state)
         bdrv_drain_all();
         /* Make sure to return an error if the flush in a previous vm_stop()
          * failed. */
-        return blk_flush_all();
+        return bdrv_flush_all();
     }
 }
 
-- 
1.9.1
