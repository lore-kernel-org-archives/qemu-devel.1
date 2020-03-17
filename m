Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD37C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0909B20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZiVVTZ3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0909B20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEH1e-0000Cg-1R
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jEGmx-0003Tt-GC
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:18:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jEGmu-00007x-Rx
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:18:03 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:58003)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jEGmu-0005xs-6U; Tue, 17 Mar 2020 14:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=kGMBm7CPcoxosu3rPPvnqWJexaU+hdFjFWtE5hsu+VA=; 
 b=ZiVVTZ3DpJTazl2RKHVl/Hx6Hgc0WX62GOaTJW9YPhU/U7N+PB5KObPNMTweEzagb83eGm4cqhH8/M6ju3vjEBLnwSZ7JYuAhAaeiN8vPAnTSg34ukKeV+tYLoAmZcp3eOWYPc4ux3q4Z1SAqQtpY6O09ks2dOgFIuMJ+TEsZCOlZ3oktsd4QiqXGtsUWjulMBbTEVFZo3UoePNpJRQoCybeSopyOnchPAMv5KSJmok+H1kiFe0AhmYn1GJpB/abb1HNEyvYJ8Q2nEl8zvspIG0djiN7K1iJhKlbHd25IXa50G3zwYQ81CCduMo3e1iJMJO9AeAE4id+lqx4VetfRQ==;
Received: from [81.0.35.138] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jEGmD-000155-4O; Tue, 17 Mar 2020 19:17:17 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jEGlw-0006OL-B9; Tue, 17 Mar 2020 19:17:00 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 09/30] qcow2: Add subcluster-related fields to
 BDRVQcow2State
Date: Tue, 17 Mar 2020 19:16:06 +0100
Message-Id: <eea31d0b30552e61f5921c6e693034cc75c724c6.1584468723.git.berto@igalia.com>
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

This patch adds the following new fields to BDRVQcow2State:

- subclusters_per_cluster: Number of subclusters in a cluster
- subcluster_size: The size of each subcluster, in bytes
- subcluster_bits: No. of bits so 1 << subcluster_bits = subcluster_size

Images without subclusters are treated as if they had exactly one,
with subcluster_size = cluster_size.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.h | 5 +++++
 block/qcow2.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/block/qcow2.h b/block/qcow2.h
index 55298750bd..3052b14dc0 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -78,6 +78,8 @@
 /* The cluster reads as all zeros */
 #define QCOW_OFLAG_ZERO (1ULL << 0)
 
+#define QCOW_EXTL2_SUBCLUSTERS_PER_CLUSTER 32
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
diff --git a/block/qcow2.c b/block/qcow2.c
index 5b6ceaa2fa..239e0ad3d9 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1380,6 +1380,11 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
         }
     }
 
+    s->subclusters_per_cluster =
+        has_subclusters(s) ? QCOW_EXTL2_SUBCLUSTERS_PER_CLUSTER : 1;
+    s->subcluster_size = s->cluster_size / s->subclusters_per_cluster;
+    s->subcluster_bits = ctz32(s->subcluster_size);
+
     /* Check support for various header values */
     if (header.refcount_order > 6) {
         error_setg(errp, "Reference count entry width too large; may not "
-- 
2.20.1


