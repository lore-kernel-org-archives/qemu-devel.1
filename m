Received: from eggs.gnu.org ([2001:4830:134:3::10]:48732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCn-0001eM-0l
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCj-000615-RU
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35092
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCj-0005zs-MG
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:29 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0EBKF017922
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:29 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmub2ww7j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:29 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:16:28 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:36 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-62-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 61/79] blkdebug: Catch bs->exact_filename
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
blkdebug node filename. In this case, we should not generate a filename
at all instead of an unusable one.

Cc: qemu-stable@nongnu.org
Reported-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170613172006.19685-2-mreitz@redhat.com
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit de81d72d3d13a19edf4d461be3b0f5a877be0234)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/blkdebug.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 5ccb9ce..63bc5d4 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -840,9 +840,13 @@ static void blkdebug_refresh_filename(BlockDriverState *bs, QDict *options)
     }
 
     if (!force_json && bs->file->bs->exact_filename[0]) {
-        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
-                 "blkdebug:%s:%s", s->config_file ?: "",
-                 bs->file->bs->exact_filename);
+        int ret = snprintf(bs->exact_filename, sizeof(bs->exact_filename),
+                           "blkdebug:%s:%s", s->config_file ?: "",
+                           bs->file->bs->exact_filename);
+        if (ret >= sizeof(bs->exact_filename)) {
+            /* An overflow makes the filename unusable, so do not report any */
+            bs->exact_filename[0] = 0;
+        }
     }
 
     opts = qdict_new();
-- 
2.7.4
