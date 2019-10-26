Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE430CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 21:37:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E6020863
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 21:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="b4zoCeGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E6020863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOTkm-00006S-EJ
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 17:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iOTZw-0000Xf-R4
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iOTZv-0005RG-EX
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:32 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42493)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iOTZu-0005F1-VI; Sat, 26 Oct 2019 17:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=KNvEic0lP8ruWMnEMEuIGNQ67obFk+Zkwqmzfxp6gz8=; 
 b=b4zoCeGqb9EGw75E5VGfQDTyEJxPhcPYKhrJZMh6Pz8NgnDLfETIa8sAiPmGordt3zcR4mSKsntFlqitpDxllIMrysn1g0UZCVrT/L87feBRMg71Audk+DslWe3JZtYPinOSoEr3LpWoB2UrCbZbBFshYFngpZCsZmgtbD8rUvAfpzkjOeLs00hJjbvmOKD2PmHGTFMGkVEGvPpdMxRf2fgAbmzrISQPDcvDOM2IZbBGlwiY9jFioy06Qm7+aVxFKfOWohnpx0eeYeAKAJ2EPANtVLTIU1npC+zEOUhahZiPKR+j4zjizvN8Jq7wEAiFzYEk2klE2mWgz6oL7GvB5Q==;
Received: from 87-100-137-117.bb.dnainternet.fi ([87.100.137.117]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iOTZJ-000469-7G; Sat, 26 Oct 2019 23:25:53 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iOTZ0-0001Pf-Ui; Sun, 27 Oct 2019 00:25:34 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 20/26] qcow2: Update L2 bitmap in
 qcow2_alloc_cluster_link_l2()
Date: Sun, 27 Oct 2019 00:25:22 +0300
Message-Id: <289ea5edc3f1530787c8fe905b1a524cc48945a9.1572125022.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1572125022.git.berto@igalia.com>
References: <cover.1572125022.git.berto@igalia.com>
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
---
 block/qcow2-cluster.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index fb6cf8df17..acb7226e03 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -980,6 +980,22 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
 
         set_l2_entry(s, l2_slice, l2_index + i, QCOW_OFLAG_COPIED |
                      (cluster_offset + (i << s->cluster_bits)));
+
+        /* Update bitmap with the subclusters that were just written */
+        if (has_subclusters(s)) {
+            uint64_t written_from = m->cow_start.offset;
+            uint64_t written_to = m->cow_end.offset + m->cow_end.nb_bytes;
+            uint64_t l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index + i);
+            int sc;
+            for (sc = 0; sc < s->subclusters_per_cluster; sc++) {
+                uint64_t sc_off = i * s->cluster_size + sc * s->subcluster_size;
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


