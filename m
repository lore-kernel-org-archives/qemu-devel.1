Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A46FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:42:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F1920706
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWCCoDeU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F1920706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAUWw-0003pb-Vv
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUPZ-0005Fr-VE
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:34:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUPT-0000ic-1L
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598344465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dh4CQA6h8mG/EpoxISOj9pGTp+pPbsRzuSky9vESZtQ=;
 b=eWCCoDeU+DZBpEJKWDf9INtPoLMKWZgYSlOKSeXiBsXjXHr6VNSarSXwVgizrko1oaI4Yi
 IU77OO4/7NGNQ23BHkHSPJompCl2VWX3DnhsOl27IeRWGSRTzTfEXms6lDWWb5oQfOXo/7
 ZC2XKspH6lOF8lUh3jnQbE4u/s+SycA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-756Ys2YNN2uRignGhnH9XQ-1; Tue, 25 Aug 2020 04:34:23 -0400
X-MC-Unique: 756Ys2YNN2uRignGhnH9XQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75BF9E777;
 Tue, 25 Aug 2020 08:34:22 +0000 (UTC)
Received: from localhost (ovpn-113-72.ams2.redhat.com [10.36.113.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 17E581A92A;
 Tue, 25 Aug 2020 08:34:21 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 30/34] qcow2: Add prealloc field to QCowL2Meta
Date: Tue, 25 Aug 2020 10:33:07 +0200
Message-Id: <20200825083311.1098442-31-mreitz@redhat.com>
In-Reply-To: <20200825083311.1098442-1-mreitz@redhat.com>
References: <20200825083311.1098442-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:35:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

This field allows us to indicate that the L2 metadata update does not
come from a write request with actual data but from a preallocation
request.

For traditional images this does not make any difference, but for
images with extended L2 entries this means that the clusters are
allocated normally in the L2 table but individual subclusters are
marked as unallocated.

This will allow preallocating images that have a backing file.

There is one special case: when we resize an existing image we can
also request that the new clusters are preallocated. If the image
already had a backing file then we have to hide any possible stale
data and zero out the new clusters (see commit 955c7d6687 for more
details).

In this case the subclusters cannot be left as unallocated so the L2
bitmap must be updated.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <960d4c444a4f5a870e2b47e5da322a73cd9a2f5a.1594396418.git.berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h         | 8 ++++++++
 block/qcow2-cluster.c | 2 +-
 block/qcow2.c         | 6 ++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 4ef4ae4ab0..f3499e53bf 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -463,6 +463,14 @@ typedef struct QCowL2Meta
      */
     bool skip_cow;
 
+    /**
+     * Indicates that this is not a normal write request but a preallocation.
+     * If the image has extended L2 entries this means that no new individual
+     * subclusters will be marked as allocated in the L2 bitmap (but any
+     * existing contents of that bitmap will be kept).
+     */
+    bool prealloc;
+
     /**
      * The I/O vector with the data from the actual guest write request.
      * If non-NULL, this is meant to be merged together with the data
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 9d349d61c6..fd506b4cb3 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1067,7 +1067,7 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
         set_l2_entry(s, l2_slice, l2_index + i, offset | QCOW_OFLAG_COPIED);
 
         /* Update bitmap with the subclusters that were just written */
-        if (has_subclusters(s)) {
+        if (has_subclusters(s) && !m->prealloc) {
             uint64_t l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index + i);
             unsigned written_from = m->cow_start.offset;
             unsigned written_to = m->cow_end.offset + m->cow_end.nb_bytes ?:
diff --git a/block/qcow2.c b/block/qcow2.c
index 54c9b7c119..7c03d41170 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2096,6 +2096,7 @@ static coroutine_fn int qcow2_handle_l2meta(BlockDriverState *bs,
         QCowL2Meta *next;
 
         if (link_l2) {
+            assert(!l2meta->prealloc);
             ret = qcow2_alloc_cluster_link_l2(bs, l2meta);
             if (ret) {
                 goto out;
@@ -3130,6 +3131,7 @@ static int coroutine_fn preallocate_co(BlockDriverState *bs, uint64_t offset,
 
         while (meta) {
             QCowL2Meta *next = meta->next;
+            meta->prealloc = true;
 
             ret = qcow2_alloc_cluster_link_l2(bs, meta);
             if (ret < 0) {
@@ -4217,6 +4219,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
         int64_t clusters_allocated;
         int64_t old_file_size, last_cluster, new_file_size;
         uint64_t nb_new_data_clusters, nb_new_l2_tables;
+        bool subclusters_need_allocation = false;
 
         /* With a data file, preallocation means just allocating the metadata
          * and forwarding the truncate request to the data file */
@@ -4298,6 +4301,8 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
                                    BDRV_REQ_ZERO_WRITE, NULL);
             if (ret >= 0) {
                 flags &= ~BDRV_REQ_ZERO_WRITE;
+                /* Ensure that we read zeroes and not backing file data */
+                subclusters_need_allocation = true;
             }
         } else {
             ret = -1;
@@ -4336,6 +4341,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
                     .offset       = nb_clusters << s->cluster_bits,
                     .nb_bytes     = 0,
                 },
+                .prealloc     = !subclusters_need_allocation,
             };
             qemu_co_queue_init(&allocation.dependent_requests);
 
-- 
2.26.2


