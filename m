Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68FBCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAC3721872
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC3721872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMtok-0001iB-Dj
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iMtkT-0006yo-8e
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 08:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iMtkS-0006Ol-6h
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 08:58:53 -0400
Received: from relay.sw.ru ([185.231.240.75]:55200)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iMtkL-0006KC-92; Tue, 22 Oct 2019 08:58:45 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iMtkH-0003xx-7b; Tue, 22 Oct 2019 15:58:41 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 01/10] hbitmap: assert that we don't create bitmap larger
 than INT64_MAX
Date: Tue, 22 Oct 2019 15:58:30 +0300
Message-Id: <20191022125839.12633-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191022125839.12633-1-vsementsov@virtuozzo.com>
References: <20191022125839.12633-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have APIs which returns signed int64_t, to be able to return error.
Therefore we can't handle bitmaps with absolute size larger than
(INT64_MAX+1). Still, keep maximum to be INT64_MAX which is a bit
safer.

Note, that bitmaps are used to represent disk images, which can't
exceed INT64_MAX anyway.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 util/hbitmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/util/hbitmap.c b/util/hbitmap.c
index 66db87c6ff..0a0e0f2b89 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -708,6 +708,7 @@ HBitmap *hbitmap_alloc(uint64_t size, int granularity)
     HBitmap *hb = g_new0(struct HBitmap, 1);
     unsigned i;
 
+    assert(size <= INT64_MAX);
     hb->orig_size = size;
 
     assert(granularity >= 0 && granularity < 64);
@@ -738,6 +739,7 @@ void hbitmap_truncate(HBitmap *hb, uint64_t size)
     uint64_t num_elements = size;
     uint64_t old;
 
+    assert(size <= INT64_MAX);
     hb->orig_size = size;
 
     /* Size comes in as logical elements, adjust for granularity. */
-- 
2.21.0


