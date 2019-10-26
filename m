Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5324CCA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 21:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B57E20863
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 21:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ppt3rDNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B57E20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOTnz-00067b-Rq
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 17:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iOTa3-0000cu-Hy
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iOTZz-0005Vt-QY
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:26:39 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42546)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iOTZy-0005Hd-T5; Sat, 26 Oct 2019 17:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=VdjJhielaO4MmNWcmgLkVdDn9oq6XrZTEwGFqa43dXw=; 
 b=ppt3rDNIrFMhLVpgrVGehl4AotXMom8ugDQZONE8SNuG+9rKu1Wtep2szKVuEgjeEYinoHn6kDL2Wn/a1sEwytFGg6qElodpEq1LWx0jGo/8mJjYXRyjgCnzZKwO8uZ0kqh2WYkXnILlkJrqlnxT5dxOpw1TO+4Fj+a2lY+ZqNqLsOSgnug0N17heYNYIgQeuxselA2LAq1SeJwklWD1YsxChDFnk+c4qmfNFEyQ5iqFOSNT8G6RVGO6u9Gjmyzo3ekEk1B/c6xpOXb56zhB7AAioiKy3HA/anZ3FtCv/bzn0tuEKdgR2jE+pQGD3xpObqHD1dh3V621dLRn63ektw==;
Received: from 87-100-137-117.bb.dnainternet.fi ([87.100.137.117]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iOTZJ-000466-2Y; Sat, 26 Oct 2019 23:25:53 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iOTZ0-0001Pd-St; Sun, 27 Oct 2019 00:25:34 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 19/26] qcow2: Fix offset calculation in
 handle_dependencies()
Date: Sun, 27 Oct 2019 00:25:21 +0300
Message-Id: <299818a13e48bb30ba27bd3afcd3d888c8e053a7.1572125022.git.berto@igalia.com>
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

l2meta_cow_start() and l2meta_cow_end() are not necessarily
cluster-aligned if the image has subclusters, so update the
calculation of old_start and old_end to guarantee that no two requests
try to write on the same cluster.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 62f2a9fcc0..fb6cf8df17 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1262,8 +1262,8 @@ static int handle_dependencies(BlockDriverState *bs, uint64_t guest_offset,
 
         uint64_t start = guest_offset;
         uint64_t end = start + bytes;
-        uint64_t old_start = l2meta_cow_start(old_alloc);
-        uint64_t old_end = l2meta_cow_end(old_alloc);
+        uint64_t old_start = start_of_cluster(s, l2meta_cow_start(old_alloc));
+        uint64_t old_end = ROUND_UP(l2meta_cow_end(old_alloc), s->cluster_size);
 
         if (end <= old_start || start >= old_end) {
             /* No intersection */
-- 
2.20.1


