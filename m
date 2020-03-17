Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502FAC5ACD6
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:24:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21FB320674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="X6ZB2zog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FB320674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGtL-0005XR-7k
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jEGmw-0003Ry-Jv
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:18:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jEGmu-00007Y-Ml
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:18:02 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:57914)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jEGmu-0005wQ-4V; Tue, 17 Mar 2020 14:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=h/8dxf0/wFbCMRFGzRbk9d/sTeWsYzZatnL8082IbGI=; 
 b=X6ZB2zogZAWbgFITulhlxt1UEUD6NSYdgUeyIPyZahU1zm+22Qvzx9+ECWa8RJUcsBPISl2vvuhd9HsbzLLVZZ+ZuiwoFBHRrLYrUxlqh2N9i5fekcrTsn8oY6heszG/6cUr7O+W5VhE3D0qCjBgJp5XlevaogEnGayoThsWanJWkfhxQiEUDx7jGqcVQ1vgnRHI61iistBQcZi5WfWfRfcOGOQX7hBMHCB9LVse+cXxJNKynE7FBugA2PS/1JRnVrKORdbHixg1tFd4NIvKDDKFh5WxvDuKP1clpOt7uM87HUgkm+duGFb6W7iyV/D9vEGAf02WZaDHdc03DiFm0A==;
Received: from [81.0.35.138] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jEGmC-00015O-W5; Tue, 17 Mar 2020 19:17:17 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jEGlw-0006Oh-NA; Tue, 17 Mar 2020 19:17:00 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 20/30] qcow2: Add subcluster support to
 discard_in_l2_slice()
Date: Tue, 17 Mar 2020 19:16:17 +0100
Message-Id: <99b45e3beb4a38b17eb50fcde1e09cdefdb99724.1584468723.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1584468723.git.berto@igalia.com>
References: <cover.1584468723.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Two changes are needed in this function:

1) A full discard deallocates a cluster so we can skip the operation if
   it is already unallocated. With extended L2 entries however if any
   of the subclusters has the 'all zeroes' bit set then we have to
   clear it.

2) Setting the QCOW_OFLAG_ZERO bit of the L2 entry is forbidden if an
   image has extended L2 entries. Instead, the individual 'all zeroes'
   bits must be used.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 746006a117..824c710760 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1790,12 +1790,20 @@ static int discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
          * TODO We might want to use bdrv_block_status(bs) here, but we're
          * holding s->lock, so that doesn't work today.
          *
-         * If full_discard is true, the sector should not read back as zeroes,
+         * If full_discard is true, the cluster should not read back as zeroes,
          * but rather fall through to the backing file.
          */
         switch (qcow2_get_cluster_type(bs, old_l2_entry)) {
         case QCOW2_CLUSTER_UNALLOCATED:
-            if (full_discard || !bs->backing) {
+            if (full_discard) {
+                /* If the image has extended L2 entries we can only
+                 * skip this operation if the L2 bitmap is zero. */
+                uint64_t bitmap = has_subclusters(s) ?
+                    get_l2_bitmap(s, l2_slice, l2_index + i) : 0;
+                if (bitmap == 0) {
+                    continue;
+                }
+            } else if (!bs->backing) {
                 continue;
             }
             break;
@@ -1817,7 +1825,11 @@ static int discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
 
         /* First remove L2 entries */
         qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
-        if (!full_discard && s->qcow_version >= 3) {
+        if (has_subclusters(s)) {
+            set_l2_entry(s, l2_slice, l2_index + i, 0);
+            set_l2_bitmap(s, l2_slice, l2_index + i,
+                          full_discard ? 0 : QCOW_L2_BITMAP_ALL_ZEROES);
+        } else if (!full_discard && s->qcow_version >= 3) {
             set_l2_entry(s, l2_slice, l2_index + i, QCOW_OFLAG_ZERO);
         } else {
             set_l2_entry(s, l2_slice, l2_index + i, 0);
-- 
2.20.1


