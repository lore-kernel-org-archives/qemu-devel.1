Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4F7C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 18:47:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E59AF20BED
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 18:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LO4RiMX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59AF20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW26R-0004l0-QU
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 14:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kW1wU-0001PI-BE
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 14:37:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kW1wS-0001a0-CE
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 14:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603478251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VaZ7LF0H7peiK9lNrwSXJj5y011IaibJBHZpDDbRgSg=;
 b=LO4RiMX4/dAdU0TDR/DzpbY2/01ep7PywT/r1uL8iH+rxfOnMQ1DJex/CD8AnkMqzXgFmP
 kKUCoapHTVKaFuBlUlRWNBY1ifnqlrBudKv6llD7tVQu0Jy35iC0Qli4ZXDhVwwc3e0rV2
 YclP63ogsdJ16CzQkLD8TqHmyjzpAmc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-AFJeY82YMM-vMgxDNuOBuA-1; Fri, 23 Oct 2020 14:37:29 -0400
X-MC-Unique: AFJeY82YMM-vMgxDNuOBuA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF798640B1;
 Fri, 23 Oct 2020 18:37:27 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-7.phx2.redhat.com [10.3.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2945060BFA;
 Fri, 23 Oct 2020 18:37:24 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 10/12] block: Return depth level during
 bdrv_is_allocated_above
Date: Fri, 23 Oct 2020 13:36:50 -0500
Message-Id: <20201023183652.478921-11-eblake@redhat.com>
In-Reply-To: <20201023183652.478921-1-eblake@redhat.com>
References: <20201023183652.478921-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, rjones@redhat.com, Max Reitz <mreitz@redhat.com>,
 stefanha@redhat.com, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When checking for allocation across a chain, it's already easy to
count the depth within the chain at which the allocation is found.
Instead of throwing that information away, return it to the caller.
Existing callers only cared about allocated/non-allocated, but having
a depth available will be used by NBD in the next patch.

Note that the previous code (since commit 188a7bbf94 in 2012) was
lazy: for each layer deeper in the backing chain, it was issuing a
bdrv_is_allocated request on the original 'bytes' amount, rather than
on any smaller amount 'n' learned from an upper layer.  These
semantics happened to work, since if you have:

Base <- Active
XX--    -XX-

the consecutive results are offset 0: '11' with *pnum 2, followed by
offset 2: '1' with *pnum 1, followed by offset 3: '0' with *pnum 1;
the resulting sequence 1110 matches reality (the first three clusters
are indeed allocated somewhere in the given range).  But post-patch,
we correctly give the results offset 0: '2' with *pnum 1, followed by
offset 1: '11' with *pnum 2, followed by offset 3: '0' with *pnum 1
(2110), without over-reporting the length of contributions from the
backing layers.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/io.c     | 11 +++++++----
 block/commit.c |  2 +-
 block/mirror.c |  2 +-
 block/stream.c |  2 +-
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/block/io.c b/block/io.c
index 54f0968aee27..4a4fa1c9ab1b 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2414,8 +2414,9 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
 /*
  * Given an image chain: ... -> [BASE] -> [INTER1] -> [INTER2] -> [TOP]
  *
- * Return 1 if (a prefix of) the given range is allocated in any image
- * between BASE and TOP (BASE is only included if include_base is set).
+ * Return a positive depth if (a prefix of) the given range is allocated
+ * in any image between BASE and TOP (BASE is only included if include_base
+ * is set).  Depth 1 is TOP, 2 is the first backing layer, and so forth.
  * BASE can be NULL to check if the given offset is allocated in any
  * image of the chain.  Return 0 otherwise, or negative errno on
  * failure.
@@ -2435,6 +2436,7 @@ int bdrv_is_allocated_above(BlockDriverState *top,
 {
     BlockDriverState *intermediate;
     int ret;
+    int depth = 0;
     int64_t n = bytes;

     assert(base || !include_base);
@@ -2444,14 +2446,15 @@ int bdrv_is_allocated_above(BlockDriverState *top,
         int64_t pnum_inter;
         int64_t size_inter;

+        depth++;
         assert(intermediate);
-        ret = bdrv_is_allocated(intermediate, offset, bytes, &pnum_inter);
+        ret = bdrv_is_allocated(intermediate, offset, n, &pnum_inter);
         if (ret < 0) {
             return ret;
         }
         if (ret) {
             *pnum = pnum_inter;
-            return 1;
+            return depth;
         }

         size_inter = bdrv_getlength(intermediate);
diff --git a/block/commit.c b/block/commit.c
index 1e85c306cc41..71db7ba7472e 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -156,7 +156,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
         /* Copy if allocated above the base */
         ret = bdrv_is_allocated_above(blk_bs(s->top), s->base_overlay, true,
                                       offset, COMMIT_BUFFER_SIZE, &n);
-        copy = (ret == 1);
+        copy = (ret > 0);
         trace_commit_one_iteration(s, offset, n, ret);
         if (copy) {
             assert(n < SIZE_MAX);
diff --git a/block/mirror.c b/block/mirror.c
index 26acf4af6fb7..8e1ad6eceb57 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -846,7 +846,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
         }

         assert(count);
-        if (ret == 1) {
+        if (ret > 0) {
             bdrv_set_dirty_bitmap(s->dirty_bitmap, offset, count);
         }
         offset += count;
diff --git a/block/stream.c b/block/stream.c
index 8ce6729a33da..236384f2f739 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -167,7 +167,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
                 n = len - offset;
             }

-            copy = (ret == 1);
+            copy = (ret > 0);
         }
         trace_stream_one_iteration(s, offset, n, ret);
         if (copy) {
-- 
2.29.0


