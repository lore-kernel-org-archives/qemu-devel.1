Return-Path: <SRS0=nsQZ=2M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFFEC2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 11:45:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6DCD20665
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 11:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="je/j4XVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6DCD20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iizg6-0003J4-P6
	for qemu-devel@archiver.kernel.org; Sun, 22 Dec 2019 06:45:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iizYp-0002nu-5t
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 06:38:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iizYn-0005b8-QI
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 06:38:10 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:34950)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iizYn-0004Ol-24; Sun, 22 Dec 2019 06:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=flXGfZhQJSs04qAtnGSSBaswVOGe2VgIccmH2UkpbYk=; 
 b=je/j4XVdtVvdzmKBrFcgE4znmE0Z65JNYPayialAGpHAURG2h6iebYZsyMzAOjSUkuP+rl4R0GLRmMLJTrgbZcTsnhTuYUw+xbtcRKhTUJ4IhzjnrqQkZpqzsK1vfDylJ3NCnMqvZCt9zlHl1S7ppnZHTr/M0KESvQ+d+Iks/BQz2cZwvKQ3phg+5i++5PH3kAerR0HT3jHkwTsB+fMAs4JC9OTOVwDoiFOR60vgXnAvd+9vSD7Ph1LRdQ0odM0hlewQkwm9er/+EzI6CcQHV8NWYbG6+Gu4zzuDvV/lhpFsf++JiLl5RC/LxtMwJy+yhzNIneyz5ZxD0os272eOSA==;
Received: from [80.30.182.172] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iizYU-0005d9-I6; Sun, 22 Dec 2019 12:37:51 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iizXu-0001Vg-Dy; Sun, 22 Dec 2019 12:37:14 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 07/27] qcow2: Add subcluster-related fields to
 BDRVQcow2State
Date: Sun, 22 Dec 2019 12:36:48 +0100
Message-Id: <b04e7e26cea16892a7f209b37d931c489ef17bd9.1577014346.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1577014346.git.berto@igalia.com>
References: <cover.1577014346.git.berto@igalia.com>
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

This patch adds the following new fields to BDRVQcow2State:

- subclusters_per_cluster: Number of subclusters in a cluster
- subcluster_size: The size of each subcluster, in bytes
- subcluster_bits: No. of bits so 1 << subcluster_bits = subcluster_size

Images without subclusters are treated as if they had exactly one,
with subcluster_size = cluster_size.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 5 +++++
 block/qcow2.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 3866b47946..cbd857e9c7 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1378,6 +1378,11 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
         }
     }
 
+    s->subclusters_per_cluster =
+        has_subclusters(s) ? QCOW_MAX_SUBCLUSTERS_PER_CLUSTER : 1;
+    s->subcluster_size = s->cluster_size / s->subclusters_per_cluster;
+    s->subcluster_bits = ctz32(s->subcluster_size);
+
     /* Check support for various header values */
     if (header.refcount_order > 6) {
         error_setg(errp, "Reference count entry width too large; may not "
diff --git a/block/qcow2.h b/block/qcow2.h
index 1db3fc5dbc..941330cfc9 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -78,6 +78,8 @@
 /* The cluster reads as all zeros */
 #define QCOW_OFLAG_ZERO (1ULL << 0)
 
+#define QCOW_MAX_SUBCLUSTERS_PER_CLUSTER 32
+
 #define MIN_CLUSTER_BITS 9
 #define MAX_CLUSTER_BITS 21
 
@@ -284,6 +286,9 @@ typedef struct BDRVQcow2State {
     int cluster_bits;
     int cluster_size;
     int l2_slice_size;
+    int subcluster_bits;
+    int subcluster_size;
+    int subclusters_per_cluster;
     int l2_bits;
     int l2_size;
     int l1_size;
-- 
2.20.1


