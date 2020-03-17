Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0674C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:30:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E30420714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mxTOrUQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E30420714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGz6-00062l-Be
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jEGmv-0003Ql-T6
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:18:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jEGmu-00006h-DY
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:18:01 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:57918)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jEGmu-0005wH-41; Tue, 17 Mar 2020 14:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=yU0+mCKAyZ6lIvQHsAFwvNxk4bue3OrHxBOx+RuSq50=; 
 b=mxTOrUQFR19UbGg5mLcYZS30OI23nwzBqTrJpTD9Hdv9Qx8icZquwrTWPQDRF73Fxs6f+/wEHEsb/Vv22xk4NJ7M0wygw5TdX1edHqfkKu7jOKiawyMjLMmbtwd1xnxZSGitNE4rL8vymPen6q4t91YNABETOEucak1/KS3ObGpO/jZe65xLecPep6GDfVQsw0HUeN0TN0g7i77fu+kNqy1mVmeJ0dnT6fKUdQQl6mHb4DrZpQSdf71Une/grUEmDsoEYATBfKIjpGJpUjpl1G0xeMZv632Qy0tTD8Wn3AE0NiSvCwaN+8/NFZ9tII3kZnIAQ8f+mY23wo1y04ytiQ==;
Received: from [81.0.35.138] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jEGmD-00015a-0D; Tue, 17 Mar 2020 19:17:17 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jEGlw-0006On-Qy; Tue, 17 Mar 2020 19:17:00 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 23/30] qcow2: Update L2 bitmap in
 qcow2_alloc_cluster_link_l2()
Date: Tue, 17 Mar 2020 19:16:20 +0100
Message-Id: <6ffd3ee7ca1e53272705ad34d2ea7ac10b50ade0.1584468723.git.berto@igalia.com>
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

The L2 bitmap needs to be updated after each write to indicate what
new subclusters are now allocated.

This needs to happen even if the cluster was already allocated and the
L2 entry was otherwise valid.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index ceacd91ea3..dfd8b66958 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1006,6 +1006,23 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
         assert((offset & L2E_OFFSET_MASK) == offset);
 
         set_l2_entry(s, l2_slice, l2_index + i, offset | QCOW_OFLAG_COPIED);
+
+        /* Update bitmap with the subclusters that were just written */
+        if (has_subclusters(s)) {
+            unsigned written_from = m->cow_start.offset;
+            unsigned written_to = m->cow_end.offset + m->cow_end.nb_bytes ?:
+                m->nb_clusters << s->cluster_bits;
+            uint64_t l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index + i);
+            int sc;
+            for (sc = 0; sc < s->subclusters_per_cluster; sc++) {
+                int sc_off = i * s->cluster_size + sc * s->subcluster_size;
+                if (sc_off >= written_from && sc_off < written_to) {
+                    l2_bitmap |= QCOW_OFLAG_SUB_ALLOC(sc);
+                    l2_bitmap &= ~QCOW_OFLAG_SUB_ZERO(sc);
+                }
+            }
+            set_l2_bitmap(s, l2_slice, l2_index + i, l2_bitmap);
+        }
      }
 
 
-- 
2.20.1


