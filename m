Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2753DC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 12:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEAD32086D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 12:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAD32086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hubgj-0002ht-8R
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 08:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40180)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hubgC-0002Dh-Um
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 08:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hubgB-0008PS-Fv
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 08:01:32 -0400
Received: from relay.sw.ru ([185.231.240.75]:50848)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hubg5-0008Iv-75; Mon, 05 Aug 2019 08:01:25 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hubg0-0006Fe-Nw; Mon, 05 Aug 2019 15:01:21 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Mon,  5 Aug 2019 15:01:20 +0300
Message-Id: <20190805120120.23585-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH for-4.1] util/hbitmap: update orig_size on
 truncate
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Without this, hbitmap_next_zero and hbitmap_next_dirty_area are broken
after truncate. So, orig_size is broken since it's introduction in
76d570dc495c56bb.

Fixes: 76d570dc495c56bb
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Hi!

Here is one more hbitmap bug I noticed. It's my fault, I'm sorry :(
Broken in 4.0, but if we are already going to fix in 4.1 some things
around it, it's a small meaningful addition.

Users of broken API are incremental backup, sync mirror (but it may not
be broken, if truncates not allowed during mirror, are they?), bitmap
export through NBD.

 util/hbitmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/util/hbitmap.c b/util/hbitmap.c
index 7905212a8b..bcc0acdc6a 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -53,7 +53,9 @@
  */
 
 struct HBitmap {
-    /* Size of the bitmap, as requested in hbitmap_alloc. */
+    /*
+     * Size of the bitmap, as requested in hbitmap_alloc or in hbitmap_truncate.
+     */
     uint64_t orig_size;
 
     /* Number of total bits in the bottom level.  */
@@ -732,6 +734,8 @@ void hbitmap_truncate(HBitmap *hb, uint64_t size)
     uint64_t num_elements = size;
     uint64_t old;
 
+    hb->orig_size = size;
+
     /* Size comes in as logical elements, adjust for granularity. */
     size = (size + (1ULL << hb->granularity) - 1) >> hb->granularity;
     assert(size <= ((uint64_t)1 << HBITMAP_LOG_MAX_SIZE));
-- 
2.18.0


