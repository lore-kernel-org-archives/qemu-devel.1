Received: from eggs.gnu.org ([2001:4830:134:3::10]:44872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8jF-0005qS-GH
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8j4-0008Kf-1e
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47622
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8j3-0008K6-No
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:17 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JERwv019606
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:16:17 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fyhccjuj0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:16:16 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:16:16 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:29 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-9-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 08/54] block: Call .drain_begin only once in
 bdrv_drain_all_begin()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Kevin Wolf <kwolf@redhat.com>

From: Kevin Wolf <kwolf@redhat.com>

bdrv_drain_all_begin() used to call the .bdrv_co_drain_begin() driver
callback inside its polling loop. This means that how many times it got
called for each node depended on long it had to poll the event loop.

This is obviously not right and results in nodes that stay drained even
after bdrv_drain_all_end(), which calls .bdrv_co_drain_begin() once per
node.

Fix bdrv_drain_all_begin() to call the callback only once, too.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 2da9b7d456278bccc6ce889ae350f2867155d7e8)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/io.c b/block/io.c
index 096468b761..603f5b059e 100644
--- a/block/io.c
+++ b/block/io.c
@@ -355,6 +355,7 @@ void bdrv_drain_all_begin(void)
         aio_context_acquire(aio_context);
         bdrv_parent_drained_begin(bs);
         aio_disable_external(aio_context);
+        bdrv_drain_invoke(bs, true);
         aio_context_release(aio_context);
 
         if (!g_slist_find(aio_ctxs, aio_context)) {
@@ -377,8 +378,6 @@ void bdrv_drain_all_begin(void)
             aio_context_acquire(aio_context);
             for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
                 if (aio_context == bdrv_get_aio_context(bs)) {
-                    /* FIXME Calling this multiple times is wrong */
-                    bdrv_drain_invoke(bs, true);
                     waited |= bdrv_drain_recurse(bs, true);
                 }
             }
-- 
2.11.0
