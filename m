Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7BCC282CE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 17:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD12E2184B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 17:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD12E2184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44882 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCSZj-0003o8-6s
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 13:24:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hCSZ0-0003Wt-Dn
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 13:23:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hCSYy-00084U-Ng
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 13:23:38 -0400
Received: from relay.sw.ru ([185.231.240.75]:33032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hCSXi-00031q-Kr; Fri, 05 Apr 2019 13:23:33 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hCS8a-0008Mk-3c; Fri, 05 Apr 2019 19:56:20 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri,  5 Apr 2019 19:56:17 +0300
Message-Id:
 <1554483379-682051-2-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v3 1/3] block: include base when checking image
 chain for block allocation
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
	berto@igalia.com, mreitz@redhat.com, stefanha@redhat.com,
	andrey.shinkevich@virtuozzo.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190405165617._gFzWWFb2hjRDYTNRFK6tzw6gLWd7zZF2lxzOW0K72o@z>

This patch is used in the 'block/stream: introduce a bottom node'
that is following. Instead of the base node, the caller may pass
the node that has the base as its backing image to the new function
bdrv_is_allocated_above_inclusive() and get rid of the dependency
on the base that may change during commit/stream parallel jobs.
Now, if the specified base is not found in the backing image chain,
the QEMU will crash.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c            | 33 ++++++++++++++++++++++++++++-----
 include/block/block.h |  4 ++++
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/block/io.c b/block/io.c
index dfc153b..7e6019f 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2317,7 +2317,8 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
  * Given an image chain: ... -> [BASE] -> [INTER1] -> [INTER2] -> [TOP]
  *
  * Return true if (a prefix of) the given range is allocated in any image
- * between BASE and TOP (inclusive).  BASE can be NULL to check if the given
+ * between BASE and TOP (TOP included). To check the BASE image, set the
+ * 'base_included' to 'true'. The BASE can be NULL to check if the given
  * offset is allocated in any image of the chain.  Return false otherwise,
  * or negative errno on failure.
  *
@@ -2329,16 +2330,19 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
  * but 'pnum' will only be 0 when end of file is reached.
  *
  */
-int bdrv_is_allocated_above(BlockDriverState *top,
-                            BlockDriverState *base,
-                            int64_t offset, int64_t bytes, int64_t *pnum)
+static int bdrv_do_is_allocated_above(BlockDriverState *top,
+                                      BlockDriverState *base,
+                                      bool base_included, int64_t offset,
+                                      int64_t bytes, int64_t *pnum)
 {
     BlockDriverState *intermediate;
     int ret;
     int64_t n = bytes;
 
+    assert(base || !base_included);
+
     intermediate = top;
-    while (intermediate && intermediate != base) {
+    while (base_included || intermediate != base) {
         int64_t pnum_inter;
         int64_t size_inter;
 
@@ -2360,6 +2364,10 @@ int bdrv_is_allocated_above(BlockDriverState *top,
             n = pnum_inter;
         }
 
+        if (intermediate == base) {
+            break;
+        }
+
         intermediate = backing_bs(intermediate);
     }
 
@@ -2367,6 +2375,21 @@ int bdrv_is_allocated_above(BlockDriverState *top,
     return 0;
 }
 
+int bdrv_is_allocated_above(BlockDriverState *top,
+                            BlockDriverState *base,
+                            int64_t offset, int64_t bytes, int64_t *pnum)
+{
+    return bdrv_do_is_allocated_above(top, base, false, offset, bytes, pnum);
+}
+
+int bdrv_is_allocated_above_inclusive(BlockDriverState *top,
+                                      BlockDriverState *base,
+                                      int64_t offset, int64_t bytes,
+                                      int64_t *pnum)
+{
+    return bdrv_do_is_allocated_above(top, base, true, offset, bytes, pnum);
+}
+
 typedef struct BdrvVmstateCo {
     BlockDriverState    *bs;
     QEMUIOVector        *qiov;
diff --git a/include/block/block.h b/include/block/block.h
index c7a2619..be1e9a0 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -449,6 +449,10 @@ int bdrv_is_allocated(BlockDriverState *bs, int64_t offset, int64_t bytes,
 int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
                             int64_t offset, int64_t bytes, int64_t *pnum);
 
+int bdrv_is_allocated_above_inclusive(BlockDriverState *top,
+                                      BlockDriverState *base,
+                                      int64_t offset, int64_t bytes,
+                                      int64_t *pnum);
 bool bdrv_is_read_only(BlockDriverState *bs);
 int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only,
                            bool ignore_allow_rdw, Error **errp);
-- 
1.8.3.1


