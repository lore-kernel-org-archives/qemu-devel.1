Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3618ACA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6683214DA
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="M3Xp2CXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6683214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOUd9-00018P-W0
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 18:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iOTZw-0000Wj-JO
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iOTZv-0005RL-Ew
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:32 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42518)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iOTZu-0005F9-UX; Sat, 26 Oct 2019 17:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=gM1HDHFjmOmPSS37VcAha72pwhGVFgdram6nRVFEymM=; 
 b=M3Xp2CXF+zmM75f7HHVsdPR+O0040gh5v4EjBeNvy3xz3qcpZF4YqHkHj3qn0hB2olR4sp2YwvOtRFAz4v02sOMpXFkYgppjqIQr7PXiEtOa9visE4UVKV83bIniR1GgC10miTOXpGZlQlbVvE7yeGFEf1wxTaqpbzhepZE2b96ZCdsOtnphvtNgMkxLFl1Ih7kT2+Jg1VAGPIFR+hQiZ3Cp6dKDSRT6rRrgUG0sTy/5/GAPVjZ+m6isuny4yeI1KEGY3DcSe9Id+03sNGCrsSp8Iqd/BHfEvFX8xJN1lvRD6WSDFST3ejGM7GBRYfCaN0Gkng6R1Wb2MzqYUqXdQg==;
Received: from 87-100-137-117.bb.dnainternet.fi ([87.100.137.117]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iOTZJ-00046B-9J; Sat, 26 Oct 2019 23:25:53 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iOTZ1-0001Pl-2h; Sun, 27 Oct 2019 00:25:35 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 23/26] qcow2: Restrict qcow2_co_pwrite_zeroes() to full
 clusters only
Date: Sun, 27 Oct 2019 00:25:25 +0300
Message-Id: <755edeae312aee4b1f06563484db1365272b430d.1572125022.git.berto@igalia.com>
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

Ideally it should be possible to zero individual subclusters using
this function, but this is currently not implemented.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 01322ca449..537569ce88 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3704,6 +3704,12 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
         bytes = s->cluster_size;
         nr = s->cluster_size;
         ret = qcow2_get_cluster_offset(bs, offset, &nr, &off);
+        /* TODO: allow zeroing separate subclusters, we only allow
+         * zeroing full clusters at the moment. */
+        if (nr != bytes) {
+            qemu_co_mutex_unlock(&s->lock);
+            return -ENOTSUP;
+        }
         if (ret != QCOW2_CLUSTER_UNALLOCATED &&
             ret != QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER &&
             ret != QCOW2_CLUSTER_ZERO_PLAIN &&
-- 
2.20.1


