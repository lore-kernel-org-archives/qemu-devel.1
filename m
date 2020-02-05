Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B41C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:22:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7FB42072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7FB42072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izIlB-00077L-VJ
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:22:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izIjw-0005G7-Rc
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:21:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izIjv-0001Nz-Ow
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:21:04 -0500
Received: from relay.sw.ru ([185.231.240.75]:41384)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1izIjs-00015e-Ky; Wed, 05 Feb 2020 06:21:00 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1izIjk-0006Jd-8S; Wed, 05 Feb 2020 14:20:52 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 01/10] hbitmap: assert that we don't create bitmap larger
 than INT64_MAX
Date: Wed,  5 Feb 2020 14:20:32 +0300
Message-Id: <20200205112041.6003-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200205112041.6003-1-vsementsov@virtuozzo.com>
References: <20200205112041.6003-1-vsementsov@virtuozzo.com>
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
 mreitz@redhat.com, jsnow@redhat.com
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
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 util/hbitmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/util/hbitmap.c b/util/hbitmap.c
index 242c6e519c..7f9b3e0cd7 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -716,6 +716,7 @@ HBitmap *hbitmap_alloc(uint64_t size, int granularity)
     HBitmap *hb = g_new0(struct HBitmap, 1);
     unsigned i;
 
+    assert(size <= INT64_MAX);
     hb->orig_size = size;
 
     assert(granularity >= 0 && granularity < 64);
@@ -746,6 +747,7 @@ void hbitmap_truncate(HBitmap *hb, uint64_t size)
     uint64_t num_elements = size;
     uint64_t old;
 
+    assert(size <= INT64_MAX);
     hb->orig_size = size;
 
     /* Size comes in as logical elements, adjust for granularity. */
-- 
2.21.0


