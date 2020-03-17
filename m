Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C36C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0223B20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TEZBYmI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0223B20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGsI-0003a2-40
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jEGmb-0002oI-14
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jEGmZ-0007VS-2N
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:17:40 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:57721)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jEGmX-0005V8-AI; Tue, 17 Mar 2020 14:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=2dD5+fpTCs+s9KvpJKL8lqwrOb+2rBZz05GePv9EoMw=; 
 b=TEZBYmI0Tv5TNCV7Jr+W9K9pKfNbWmuMcr/i5fNIhaTPrF+dJx6dhDE9LRHwdxHdURqsAPHksfLaLQXbA7vtYQTPnL0a7r8QKYCXAUUJobxfwMvTlMS1Tabr9DrgPBsSOFZZEEdeF59Qa/hkrN2fQMv5qQf3ymUc7Ve1htasFrNaDwd3bPwEwIBc4NHs8m575NuuDQXsmsUEO7utIl5+II/FbBqq5Ol1ldiGEOGM1ZnTE5JutlZqxi6zKp62ub8jhaXzzXrkaquFVu7CO441xf0kWd1O9CjTFpgGnMiwOl6+TeC9YmWObLjDc5TqSWUlhOUhZVO3sfeagyr5VBAJow==;
Received: from [81.0.35.138] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jEGmC-00015U-Sz; Tue, 17 Mar 2020 19:17:16 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jEGlw-0006Ol-PT; Tue, 17 Mar 2020 19:17:00 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 22/30] qcow2: Fix offset calculation in
 handle_dependencies()
Date: Tue, 17 Mar 2020 19:16:19 +0100
Message-Id: <46d9ec6dca0b054a529ee776d1c04b002098c127.1584468723.git.berto@igalia.com>
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

l2meta_cow_start() and l2meta_cow_end() are not necessarily
cluster-aligned if the image has subclusters, so update the
calculation of old_start and old_end to guarantee that no two requests
try to write on the same cluster.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 824c710760..ceacd91ea3 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1306,8 +1306,8 @@ static int handle_dependencies(BlockDriverState *bs, uint64_t guest_offset,
 
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


