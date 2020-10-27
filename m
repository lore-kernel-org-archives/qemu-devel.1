Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CD0C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:21:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 758F12225E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PcucY642"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758F12225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQmn-0004Wh-BE
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 11:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kXQhJ-0006Be-2r
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 11:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50960)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kXQh9-0007gW-Vu
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 11:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603811730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8FoKmOI+ZM0AYLai4a9b64j3EZrSD9fz+C9ZGZMocBI=;
 b=PcucY642jWmI1fB5e45E2maONC93ANBptbmg4FefDsJ5SebzJg3CHo7mchYahZxnO5pJgy
 m54j7ZXmTOSthMMmUYwLb37epWjvXfqy1eKXDjPIxtdMDminQYng+I+kViwGJ3OtYvfKOI
 bC8HoyN0mkJNH53Wp+FxocL0qjPP0lM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-3UCF1AtiNwOpu5Oc-hWUrQ-1; Tue, 27 Oct 2020 11:15:24 -0400
X-MC-Unique: 3UCF1AtiNwOpu5Oc-hWUrQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBB80EC506;
 Tue, 27 Oct 2020 15:15:23 +0000 (UTC)
Received: from merkur.redhat.com (ovpn-114-16.ams2.redhat.com [10.36.114.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CBC5C55762;
 Tue, 27 Oct 2020 15:15:22 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 4/5] qcow2: Skip copy-on-write when allocating a zero cluster
Date: Tue, 27 Oct 2020 16:15:14 +0100
Message-Id: <20201027151515.213565-5-kwolf@redhat.com>
In-Reply-To: <20201027151515.213565-1-kwolf@redhat.com>
References: <20201027151515.213565-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

Since commit c8bb23cbdbe32f5c326365e0a82e1b0e68cdcd8a when a write
request results in a new allocation QEMU first tries to see if the
rest of the cluster outside the written area contains only zeroes.

In that case, instead of doing a normal copy-on-write operation and
writing explicit zero buffers to disk, the code zeroes the whole
cluster efficiently using pwrite_zeroes() with BDRV_REQ_NO_FALLBACK.

This improves performance very significantly but it only happens when
we are writing to an area that was completely unallocated before. Zero
clusters (QCOW2_CLUSTER_ZERO_*) are treated like normal clusters and
are therefore slower to allocate.

This happens because the code uses bdrv_is_allocated_above() rather
bdrv_block_status_above(). The former is not as accurate for this
purpose but it is faster. However in the case of qcow2 the underlying
call does already report zero clusters just fine so there is no reason
why we cannot use that information.

After testing 4KB writes on an image that only contains zero clusters
this patch results in almost five times more IOPS.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <6d77cab968c501c44d6e1089b9bc91b04170b49e.1603731354.git.berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h |  2 ++
 block/io.c            | 27 +++++++++++++++++++++++++++
 block/qcow2.c         | 35 +++++++++++++++++++----------------
 3 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index d16c401cb4..c9d7c58765 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -508,6 +508,8 @@ int bdrv_is_allocated(BlockDriverState *bs, int64_t offset, int64_t bytes,
 int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
                             bool include_base, int64_t offset, int64_t bytes,
                             int64_t *pnum);
+int coroutine_fn bdrv_co_is_zero_fast(BlockDriverState *bs, int64_t offset,
+                                      int64_t bytes);
 
 bool bdrv_is_read_only(BlockDriverState *bs);
 int bdrv_can_set_read_only(BlockDriverState *bs, bool read_only,
diff --git a/block/io.c b/block/io.c
index 6fe1b275b6..c33cecd58d 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2447,6 +2447,33 @@ int bdrv_block_status(BlockDriverState *bs, int64_t offset, int64_t bytes,
                                    offset, bytes, pnum, map, file);
 }
 
+/*
+ * Check @bs (and its backing chain) to see if the range defined
+ * by @offset and @bytes is known to read as zeroes.
+ * Return 1 if that is the case, 0 otherwise and -errno on error.
+ * This test is meant to be fast rather than accurate so returning 0
+ * does not guarantee non-zero data.
+ */
+int coroutine_fn bdrv_co_is_zero_fast(BlockDriverState *bs, int64_t offset,
+                                      int64_t bytes)
+{
+    int ret;
+    int64_t pnum = bytes;
+
+    if (!bytes) {
+        return 1;
+    }
+
+    ret = bdrv_common_block_status_above(bs, NULL, false, false, offset,
+                                         bytes, &pnum, NULL, NULL);
+
+    if (ret < 0) {
+        return ret;
+    }
+
+    return (pnum == bytes) && (ret & BDRV_BLOCK_ZERO);
+}
+
 int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
                                    int64_t bytes, int64_t *pnum)
 {
diff --git a/block/qcow2.c b/block/qcow2.c
index b6cb4db8bb..4274806a2a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2387,26 +2387,26 @@ static bool merge_cow(uint64_t offset, unsigned bytes,
     return false;
 }
 
-static bool is_unallocated(BlockDriverState *bs, int64_t offset, int64_t bytes)
-{
-    int64_t nr;
-    return !bytes ||
-        (!bdrv_is_allocated_above(bs, NULL, false, offset, bytes, &nr) &&
-         nr == bytes);
-}
-
-static bool is_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
+/*
+ * Return 1 if the COW regions read as zeroes, 0 if not, < 0 on error.
+ * Note that returning 0 does not guarantee non-zero data.
+ */
+static int is_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
 {
     /*
      * This check is designed for optimization shortcut so it must be
      * efficient.
-     * Instead of is_zero(), use is_unallocated() as it is faster (but not
-     * as accurate and can result in false negatives).
+     * Instead of is_zero(), use bdrv_co_is_zero_fast() as it is
+     * faster (but not as accurate and can result in false negatives).
      */
-    return is_unallocated(bs, m->offset + m->cow_start.offset,
-                          m->cow_start.nb_bytes) &&
-           is_unallocated(bs, m->offset + m->cow_end.offset,
-                          m->cow_end.nb_bytes);
+    int ret = bdrv_co_is_zero_fast(bs, m->offset + m->cow_start.offset,
+                                   m->cow_start.nb_bytes);
+    if (ret <= 0) {
+        return ret;
+    }
+
+    return bdrv_co_is_zero_fast(bs, m->offset + m->cow_end.offset,
+                                m->cow_end.nb_bytes);
 }
 
 static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
@@ -2432,7 +2432,10 @@ static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
             continue;
         }
 
-        if (!is_zero_cow(bs, m)) {
+        ret = is_zero_cow(bs, m);
+        if (ret < 0) {
+            return ret;
+        } else if (ret == 0) {
             continue;
         }
 
-- 
2.28.0


