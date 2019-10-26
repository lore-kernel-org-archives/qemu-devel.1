Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A05CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:32:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F8D420684
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="r3VJehp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8D420684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOUbM-0004Z9-Fp
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 18:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iOTZw-0000Vc-By
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iOTZv-0005Qt-4v
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:32 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42495)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iOTZu-0005Es-Sr; Sat, 26 Oct 2019 17:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=xwaAM/d5xwG96LuTjF/2zt7GMq/uOL/UjAXAavz3Mr0=; 
 b=r3VJehp7i+DMP29o4IkPyGyYjX93RT50s7M4ZkxDKY5AAdN5B2jqMgFaPkOGgSML8wlV4CPUcaKnWxd8RlyYGNSlZ0N+IL0OP8MYXaJdy/TLIjvgAa655KZ7beifdZC/HXngsqg0HwmiHLeOTTfgsE6quCRzSq+tuZxcnPu5f6sjlBsL/6zOllzffur7yY6QOq3d99dM36H8+gFxUIF25EH7AE9kOhJZuiQh/tc7LY5uXbaXVEX1kLUoYU85nvZ51QEyvRDK5rGqYGDEi4TKJFXjGGlU0Sz4wo9fbl3A1BRbA0nrmtHICUDOPH1hkokSb94iwrNWZvT0CrcW/5aJ9Q==;
Received: from 87-100-137-117.bb.dnainternet.fi ([87.100.137.117]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iOTZI-00045s-MH; Sat, 26 Oct 2019 23:25:52 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iOTZ0-0001PE-AU; Sun, 27 Oct 2019 00:25:34 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 07/26] qcow2: Add subcluster-related fields to
 BDRVQcow2State
Date: Sun, 27 Oct 2019 00:25:09 +0300
Message-Id: <628a9a1220bf648ebe0b7570a1e630abb09c4abf.1572125022.git.berto@igalia.com>
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
index 0bc69e6996..ed8b81c7b7 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1342,6 +1342,11 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
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
index b3826b37c1..278ca41314 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -75,6 +75,8 @@
 /* The cluster reads as all zeros */
 #define QCOW_OFLAG_ZERO (1ULL << 0)
 
+#define QCOW_MAX_SUBCLUSTERS_PER_CLUSTER 32
+
 #define MIN_CLUSTER_BITS 9
 #define MAX_CLUSTER_BITS 21
 
@@ -277,6 +279,9 @@ typedef struct BDRVQcow2State {
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


