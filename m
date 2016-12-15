Received: from eggs.gnu.org ([2001:4830:134:3::10]:43235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCH-0004Uv-LQ
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCE-0001bc-Nx
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54885
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKCE-0001b5-Hi
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:54 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hbsg084826
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:53 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdme91pq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:53 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:53 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:48 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-55-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 54/67] block/curl: Use BDRV_SECTOR_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>

From: Max Reitz <mreitz@redhat.com>

Currently, curl defines its own constant SECTOR_SIZE. There is no
advantage over using the global BDRV_SECTOR_SIZE, so drop it.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20161025025431.24714-2-mreitz@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
(cherry picked from commit 9054d9f6b00a3f0576b1a7310a3886d1783ad382)

Conflicts:
	block/curl.c

* drop context dep on fffb6e1 / aio_bh_schedule_oneshot

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/curl.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 426fb4d..a764e32 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -73,7 +73,6 @@ static CURLMcode __curl_multi_socket_action(CURLM *multi_handle,
 
 #define CURL_NUM_STATES 8
 #define CURL_NUM_ACB    8
-#define SECTOR_SIZE     512
 #define READ_AHEAD_DEFAULT (256 * 1024)
 #define CURL_TIMEOUT_DEFAULT 5
 #define CURL_TIMEOUT_MAX 10000
@@ -725,12 +724,12 @@ static void curl_readv_bh_cb(void *p)
     qemu_bh_delete(acb->bh);
     acb->bh = NULL;
 
-    size_t start = acb->sector_num * SECTOR_SIZE;
+    size_t start = acb->sector_num * BDRV_SECTOR_SIZE;
     size_t end;
 
     // In case we have the requested data already (e.g. read-ahead),
     // we can just call the callback and be done.
-    switch (curl_find_buf(s, start, acb->nb_sectors * SECTOR_SIZE, acb)) {
+    switch (curl_find_buf(s, start, acb->nb_sectors * BDRV_SECTOR_SIZE, acb)) {
         case FIND_RET_OK:
             qemu_aio_unref(acb);
             // fall through
@@ -749,7 +748,7 @@ static void curl_readv_bh_cb(void *p)
     }
 
     acb->start = 0;
-    acb->end = (acb->nb_sectors * SECTOR_SIZE);
+    acb->end = (acb->nb_sectors * BDRV_SECTOR_SIZE);
 
     state->buf_off = 0;
     g_free(state->orig_buf);
@@ -766,8 +765,8 @@ static void curl_readv_bh_cb(void *p)
     state->acb[0] = acb;
 
     snprintf(state->range, 127, "%zd-%zd", start, end);
-    DPRINTF("CURL (AIO): Reading %d at %zd (%s)\n",
-            (acb->nb_sectors * SECTOR_SIZE), start, state->range);
+    DPRINTF("CURL (AIO): Reading %llu at %zd (%s)\n",
+            (acb->nb_sectors * BDRV_SECTOR_SIZE), start, state->range);
     curl_easy_setopt(state->curl, CURLOPT_RANGE, state->range);
 
     curl_multi_add_handle(s->multi, state->curl);
-- 
1.9.1
