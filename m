Received: from eggs.gnu.org ([2001:4830:134:3::10]:48775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCo-0001fm-4Q
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCk-00064C-NF
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35113
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCk-000632-G4
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:30 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E8qK017779
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:30 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmub2ww7t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:29 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:16:29 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:37 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-63-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 62/79] blkverify: Catch bs->exact_filename
 overflow
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

The bs->exact_filename field may not be sufficient to store the full
blkverify node filename. In this case, we should not generate a filename
at all instead of an unusable one.

Cc: qemu-stable@nongnu.org
Reported-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170613172006.19685-3-mreitz@redhat.com
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit 05cc758a3dfc79488d0a8eb7f5830a41871e78d0)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/blkverify.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/blkverify.c b/block/blkverify.c
index 6b0a603..06369f9 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -301,10 +301,14 @@ static void blkverify_refresh_filename(BlockDriverState *bs, QDict *options)
     if (bs->file->bs->exact_filename[0]
         && s->test_file->bs->exact_filename[0])
     {
-        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
-                 "blkverify:%s:%s",
-                 bs->file->bs->exact_filename,
-                 s->test_file->bs->exact_filename);
+        int ret = snprintf(bs->exact_filename, sizeof(bs->exact_filename),
+                           "blkverify:%s:%s",
+                           bs->file->bs->exact_filename,
+                           s->test_file->bs->exact_filename);
+        if (ret >= sizeof(bs->exact_filename)) {
+            /* An overflow makes the filename unusable, so do not report any */
+            bs->exact_filename[0] = 0;
+        }
     }
 }
 
-- 
2.7.4
