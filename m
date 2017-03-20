Received: from eggs.gnu.org ([2001:4830:134:3::10]:42088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6RC-0002Ds-9Y
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6R0-0005NW-Vl
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6R0-0005MX-Mv
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:54 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8g19020995
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:53 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 299yqc6yyr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:53 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:52 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:45 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-82-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 81/81] thread-pool: add missing qemu_bh_cancel
 in completion function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>

From: Peter Lieven <pl@kamp.de>

commit 3c80ca15 fixed a deadlock scenarion with nested aio_poll invocations.

However, the rescheduling of the completion BH introcuded unnecessary spinning
in the main-loop. On very fast file backends this can even lead to the
"WARNING: I/O thread spun for 1000 iterations" message popping up.

Callgrind reports about 3-4% less instructions with this patch running
qemu-img bench on a ramdisk based VMDK file.

Fixes: 3c80ca158c96ff902a30883a8933e755988948b1
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit b7a745dc33a18377bb4a8dfe54d1df01ea60bf66)
* drop context dep on b9e413d
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 thread-pool.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/thread-pool.c b/thread-pool.c
index 6fba913..4157210 100644
--- a/thread-pool.c
+++ b/thread-pool.c
@@ -185,6 +185,13 @@ restart:
             qemu_bh_schedule(pool->completion_bh);
 
             elem->common.cb(elem->common.opaque, elem->ret);
+
+            /* We can safely cancel the completion_bh here regardless of someone
+             * else having scheduled it meanwhile because we reenter the
+             * completion function anyway (goto restart).
+             */
+            qemu_bh_cancel(pool->completion_bh);
+
             qemu_aio_unref(elem);
             goto restart;
         } else {
-- 
2.7.4
