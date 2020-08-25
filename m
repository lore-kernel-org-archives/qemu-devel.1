Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988C9C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60B962065F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7BlKys3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B962065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAUcY-00083K-ES
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUPS-00054w-5l
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:34:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40739
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUPG-0000gg-2G
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598344453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=klujxK9D+Mr9JXLoXGjW0jniQVNLJUlgofzq09zndso=;
 b=K7BlKys3xlanOjj93GHUMJE+PctyKTm15VDee1HLb+nTiPrLxN//FaHQD8wu63iHlC6mlz
 OqnlPKmD1y4zHJyddQC8nZ+Xg+MLZt4hSudBjmL7OMe3Vtukq1p2T2s7RNjAe+Ckk9QtaE
 bUgznIRNfIS9WPytbsnNMOsANyxUlxo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-3gLsUHOZMkCW3IsQcm6kVQ-1; Tue, 25 Aug 2020 04:34:09 -0400
X-MC-Unique: 3gLsUHOZMkCW3IsQcm6kVQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E06B780732F;
 Tue, 25 Aug 2020 08:34:06 +0000 (UTC)
Received: from localhost (ovpn-113-72.ams2.redhat.com [10.36.113.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 801457D939;
 Tue, 25 Aug 2020 08:34:06 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 23/34] qcow2: Add subcluster support to discard_in_l2_slice()
Date: Tue, 25 Aug 2020 10:33:00 +0200
Message-Id: <20200825083311.1098442-24-mreitz@redhat.com>
In-Reply-To: <20200825083311.1098442-1-mreitz@redhat.com>
References: <20200825083311.1098442-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:36:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

Two things need to be taken into account here:

1) With full_discard == true the L2 entry must be cleared completely.
   This also includes the L2 bitmap if the image has extended L2
   entries.

2) With full_discard == false we have to make the discarded cluster
   read back as zeroes. With normal L2 entries this is done with the
   QCOW_OFLAG_ZERO bit, whereas with extended L2 entries this is done
   with the individual 'all zeroes' bits for each subcluster.

   Note however that QCOW_OFLAG_ZERO is not supported in v2 qcow2
   images so, if there is a backing file, discard cannot guarantee
   that the image will read back as zeroes. If this is important for
   the caller it should forbid it as qcow2_co_pdiscard() does (see
   80f5c01183 for more details).

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <5ef8274e628aa3ab559bfac467abf488534f2b76.1594396418.git.berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 52 +++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 5afcd72f5a..a41351aba5 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1848,11 +1848,17 @@ static int discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
     assert(nb_clusters <= INT_MAX);
 
     for (i = 0; i < nb_clusters; i++) {
-        uint64_t old_l2_entry;
-
-        old_l2_entry = get_l2_entry(s, l2_slice, l2_index + i);
+        uint64_t old_l2_entry = get_l2_entry(s, l2_slice, l2_index + i);
+        uint64_t old_l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index + i);
+        uint64_t new_l2_entry = old_l2_entry;
+        uint64_t new_l2_bitmap = old_l2_bitmap;
+        QCow2ClusterType cluster_type =
+            qcow2_get_cluster_type(bs, old_l2_entry);
 
         /*
+         * If full_discard is true, the cluster should not read back as zeroes,
+         * but rather fall through to the backing file.
+         *
          * If full_discard is false, make sure that a discarded area reads back
          * as zeroes for v3 images (we cannot do it for v2 without actually
          * writing a zero-filled buffer). We can skip the operation if the
@@ -1861,40 +1867,28 @@ static int discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
          *
          * TODO We might want to use bdrv_block_status(bs) here, but we're
          * holding s->lock, so that doesn't work today.
-         *
-         * If full_discard is true, the sector should not read back as zeroes,
-         * but rather fall through to the backing file.
          */
-        switch (qcow2_get_cluster_type(bs, old_l2_entry)) {
-        case QCOW2_CLUSTER_UNALLOCATED:
-            if (full_discard || !bs->backing) {
-                continue;
-            }
-            break;
-
-        case QCOW2_CLUSTER_ZERO_PLAIN:
-            if (!full_discard) {
-                continue;
+        if (full_discard) {
+            new_l2_entry = new_l2_bitmap = 0;
+        } else if (bs->backing || qcow2_cluster_is_allocated(cluster_type)) {
+            if (has_subclusters(s)) {
+                new_l2_entry = 0;
+                new_l2_bitmap = QCOW_L2_BITMAP_ALL_ZEROES;
+            } else {
+                new_l2_entry = s->qcow_version >= 3 ? QCOW_OFLAG_ZERO : 0;
             }
-            break;
-
-        case QCOW2_CLUSTER_ZERO_ALLOC:
-        case QCOW2_CLUSTER_NORMAL:
-        case QCOW2_CLUSTER_COMPRESSED:
-            break;
+        }
 
-        default:
-            abort();
+        if (old_l2_entry == new_l2_entry && old_l2_bitmap == new_l2_bitmap) {
+            continue;
         }
 
         /* First remove L2 entries */
         qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
-        if (!full_discard && s->qcow_version >= 3) {
-            set_l2_entry(s, l2_slice, l2_index + i, QCOW_OFLAG_ZERO);
-        } else {
-            set_l2_entry(s, l2_slice, l2_index + i, 0);
+        set_l2_entry(s, l2_slice, l2_index + i, new_l2_entry);
+        if (has_subclusters(s)) {
+            set_l2_bitmap(s, l2_slice, l2_index + i, new_l2_bitmap);
         }
-
         /* Then decrease the refcount */
         qcow2_free_any_clusters(bs, old_l2_entry, 1, type);
     }
-- 
2.26.2


