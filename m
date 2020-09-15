Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A7DC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:48:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C88821D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MioPubEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C88821D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8W7-0003Eb-1O
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 06:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8UR-0000vr-9P
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:47:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28278
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8UP-0004da-GW
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600166828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r7bomLHOqMKUeU1AC9hPJC8dPd2D9Dctugd/c7FolZg=;
 b=MioPubEKTGE8WyWUgN3XqF6rd9qdVr2ET7YheDtykgFjlzG8AB2nOjtRnl62PnN3xRpdK6
 3G3vRMWK8boje7sjsM4N8cs2TmUY3CXWbvFxW9MElFnyJBxma3wkbo24IbNwYd119FmyE3
 /9Db8TxtoVXJv5ufh/2iQHvzj9WGwU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-1bSZL-GsPBK2xlnuVADHRw-1; Tue, 15 Sep 2020 06:47:06 -0400
X-MC-Unique: 1bSZL-GsPBK2xlnuVADHRw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 682B01005E65;
 Tue, 15 Sep 2020 10:47:05 +0000 (UTC)
Received: from localhost (ovpn-113-7.ams2.redhat.com [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E24D275143;
 Tue, 15 Sep 2020 10:47:04 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 16/22] qcow2: Make qcow2_free_any_clusters() free only one
 cluster
Date: Tue, 15 Sep 2020 12:46:21 +0200
Message-Id: <20200915104627.699552-17-mreitz@redhat.com>
In-Reply-To: <20200915104627.699552-1-mreitz@redhat.com>
References: <20200915104627.699552-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:29:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

This function takes an L2 entry and a number of clusters to free.
Although in principle it can free any type of cluster (using the L2
entry to determine its type) in practice the API is broken because
compressed clusters have a variable size and there is no way to free
more than one without having the L2 entry of each one of them.

The good news all callers are passing nb_clusters=1 so we can simply
get rid of that parameter.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-Id: <77cea0f4616f921d37e971b3c5b18a2faa24b173.1599573989.git.berto@igalia.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h          | 4 ++--
 block/qcow2-cluster.c  | 6 +++---
 block/qcow2-refcount.c | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 83cfa0c391..b73a4cf1f8 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -861,8 +861,8 @@ int64_t qcow2_alloc_bytes(BlockDriverState *bs, int size);
 void qcow2_free_clusters(BlockDriverState *bs,
                           int64_t offset, int64_t size,
                           enum qcow2_discard_type type);
-void qcow2_free_any_clusters(BlockDriverState *bs, uint64_t l2_entry,
-                             int nb_clusters, enum qcow2_discard_type type);
+void qcow2_free_any_cluster(BlockDriverState *bs, uint64_t l2_entry,
+                            enum qcow2_discard_type type);
 
 int qcow2_update_snapshot_refcount(BlockDriverState *bs,
     int64_t l1_table_offset, int l1_size, int addend);
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index ce1260e746..1a67b2d928 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1096,7 +1096,7 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
      */
     if (!m->keep_old_clusters && j != 0) {
         for (i = 0; i < j; i++) {
-            qcow2_free_any_clusters(bs, old_cluster[i], 1, QCOW2_DISCARD_NEVER);
+            qcow2_free_any_cluster(bs, old_cluster[i], QCOW2_DISCARD_NEVER);
         }
     }
 
@@ -1913,7 +1913,7 @@ static int discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
             set_l2_bitmap(s, l2_slice, l2_index + i, new_l2_bitmap);
         }
         /* Then decrease the refcount */
-        qcow2_free_any_clusters(bs, old_l2_entry, 1, type);
+        qcow2_free_any_cluster(bs, old_l2_entry, type);
     }
 
     qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
@@ -2005,7 +2005,7 @@ static int zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
 
         qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
         if (unmap) {
-            qcow2_free_any_clusters(bs, old_l2_entry, 1, QCOW2_DISCARD_REQUEST);
+            qcow2_free_any_cluster(bs, old_l2_entry, QCOW2_DISCARD_REQUEST);
         }
         set_l2_entry(s, l2_slice, l2_index + i, new_l2_entry);
         if (has_subclusters(s)) {
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 51e9778ed8..8e649b008e 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1157,8 +1157,8 @@ void qcow2_free_clusters(BlockDriverState *bs,
  * Free a cluster using its L2 entry (handles clusters of all types, e.g.
  * normal cluster, compressed cluster, etc.)
  */
-void qcow2_free_any_clusters(BlockDriverState *bs, uint64_t l2_entry,
-                             int nb_clusters, enum qcow2_discard_type type)
+void qcow2_free_any_cluster(BlockDriverState *bs, uint64_t l2_entry,
+                            enum qcow2_discard_type type)
 {
     BDRVQcow2State *s = bs->opaque;
     QCow2ClusterType ctype = qcow2_get_cluster_type(bs, l2_entry);
@@ -1169,7 +1169,7 @@ void qcow2_free_any_clusters(BlockDriverState *bs, uint64_t l2_entry,
              ctype == QCOW2_CLUSTER_ZERO_ALLOC))
         {
             bdrv_pdiscard(s->data_file, l2_entry & L2E_OFFSET_MASK,
-                          nb_clusters << s->cluster_bits);
+                          s->cluster_size);
         }
         return;
     }
@@ -1192,7 +1192,7 @@ void qcow2_free_any_clusters(BlockDriverState *bs, uint64_t l2_entry,
                                     l2_entry & L2E_OFFSET_MASK);
         } else {
             qcow2_free_clusters(bs, l2_entry & L2E_OFFSET_MASK,
-                                nb_clusters << s->cluster_bits, type);
+                                s->cluster_size, type);
         }
         break;
     case QCOW2_CLUSTER_ZERO_PLAIN:
-- 
2.26.2


