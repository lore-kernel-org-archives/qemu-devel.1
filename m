Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B89C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 11:16:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4201320B80
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 11:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NVnJgPxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4201320B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpVI7-0002rM-Ez
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 07:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jpV6R-0007UQ-Kf; Sun, 28 Jun 2020 07:04:03 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jpV6K-0000XL-9f; Sun, 28 Jun 2020 07:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=cG/kSuGs/5TWLvRsT9afV2CDEwmEMC+5Mg1THYxNdFE=; 
 b=NVnJgPxXJrVu+QquMYjOZlcLaK8zq1idNvJxG99T5HIpcwIokzsffic6M0I5q55EFInuvjhydokEPqByzw1DtlgwTkkTpWNwxtp7Lz10CPj535faFNVEXIej5+gSn13Ib5kG4VbDQTzxlTPbmJ7JyCPlOv7EvX6REt7pr4wUMKpKpa/enfYEg0DwIcPaY+tIaLmcu9P4uAG2ahqI5vXjkaSIhDrtwyQ3zB7zU5tX9nP76kkfhyQLQX+uPA+sVubRt9l5c0u6NLgMnstXA/srFk/bPKqOvPPHnXIHNDWG1aFr2582tGd86yr0kQreSsYGFKbGk9YZt7QgqaIYiLsUjQ==;
Received: from 26.red-79-158-236.dynamicip.rima-tde.net ([79.158.236.26]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jpV5Y-0002gp-CW; Sun, 28 Jun 2020 13:03:09 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jpV5I-000399-7Z; Sun, 28 Jun 2020 13:02:52 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 25/34] qcow2: Update L2 bitmap in
 qcow2_alloc_cluster_link_l2()
Date: Sun, 28 Jun 2020 13:02:34 +0200
Message-Id: <bdd6cca475832860905ccc4150af5cf8169c68be.1593342067.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1593342067.git.berto@igalia.com>
References: <cover.1593342067.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/28 07:03:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Derek Su <dereksu@qnap.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The L2 bitmap needs to be updated after each write to indicate what
new subclusters are now allocated. This needs to happen even if the
cluster was already allocated and the L2 entry was otherwise valid.

In some cases however a write operation doesn't need change the L2
bitmap (because all affected subclusters were already allocated). This
is detected in calculate_l2_meta(), and qcow2_alloc_cluster_link_l2()
is never called in those cases.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2-cluster.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index edfc8ea91c..2276cee6d6 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1061,6 +1061,24 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
         assert((offset & L2E_OFFSET_MASK) == offset);
 
         set_l2_entry(s, l2_slice, l2_index + i, offset | QCOW_OFLAG_COPIED);
+
+        /* Update bitmap with the subclusters that were just written */
+        if (has_subclusters(s)) {
+            uint64_t l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index + i);
+            unsigned written_from = m->cow_start.offset;
+            unsigned written_to = m->cow_end.offset + m->cow_end.nb_bytes ?:
+                m->nb_clusters << s->cluster_bits;
+            int first_sc, last_sc;
+            /* Narrow written_from and written_to down to the current cluster */
+            written_from = MAX(written_from, i << s->cluster_bits);
+            written_to   = MIN(written_to, (i + 1) << s->cluster_bits);
+            assert(written_from < written_to);
+            first_sc = offset_to_sc_index(s, written_from);
+            last_sc  = offset_to_sc_index(s, written_to - 1);
+            l2_bitmap |= QCOW_OFLAG_SUB_ALLOC_RANGE(first_sc, last_sc + 1);
+            l2_bitmap &= ~QCOW_OFLAG_SUB_ZERO_RANGE(first_sc, last_sc + 1);
+            set_l2_bitmap(s, l2_slice, l2_index + i, l2_bitmap);
+        }
      }
 
 
-- 
2.20.1


