Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1685CC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:33:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFFC0229F3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFFC0229F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfkC-00089o-H8
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49224)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqfj9-00054B-4o
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqfj6-0002HF-RY
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:32:18 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:34087)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqfj3-00027j-8s
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:32:14 -0400
Received: by mail-qt1-f175.google.com with SMTP id k10so49553532qtq.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 08:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/hrcl/m7AfRfxAabgjr0nGL2uw+WOg+32XDf093oxBo=;
 b=iy1GiWlqOa9SOupkrJHyM40CVf4SvlXY6soE0zbPl1FBWS/QByn9n7vGP5WC3apD4u
 7j+Zef9ZOqCvDlyK/dXMvSLFdNBJ6NjNlU4c1W6pQUu8PSpfmO7wo66yee+9ggSPJhJC
 ycX4+FEHfV67OD7dEKISvJUIppixn3bxjcxLaYHzCq7cP8RD6L+iJkF8AgapG+IqdoNh
 ez2fYjApy0lC5/VRjBAQrW7cG4TXKvjzntF0RmtnNC6JNBSAXEDjcSMUnEJuWIXTvjJ+
 edBoI3G1S5RBe40dDSL2jVSpasJwuowS7tPvB6MYeRVqSYtQ02BVSpddCy+lbyrqVeJp
 a5xg==
X-Gm-Message-State: APjAAAX/rYn2XsM2cEwm+wZAQ1nwyJ3jN1/PDyNCPA4uihYTev0aUbqu
 4gLLUpvc6uuzNe0IY3wh3M5jtb/703Inaw==
X-Google-Smtp-Source: APXvYqzRq9g5v37UH6i9NTuyNepc7XCuaUkfipDFnkWEyW29Y5OwMxXnMyP9gcZHcMf22/a/R5K78w==
X-Received: by 2002:aed:22f2:: with SMTP id q47mr63734786qtc.106.1564068724236; 
 Thu, 25 Jul 2019 08:32:04 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 n5sm28211627qta.29.2019.07.25.08.32.02
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 08:32:03 -0700 (PDT)
Date: Thu, 25 Jul 2019 11:32:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190722134108.22151-4-david@redhat.com>
References: <20190725153059.7313-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190725153059.7313-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.175
Subject: [Qemu-devel] [PULL 07/12] virtio-balloon: Simplify deflate with pbp
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190725153200.NertaDcoBPgQu47aBB_ekDX62mzzjtcCRsREVlxDizU@z>

From: David Hildenbrand <david@redhat.com>

Let's simplify this - the case we are optimizing for is very hard to
trigger and not worth the effort. If we're switching from inflation to
deflation, let's reset the pbp.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190722134108.22151-4-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-balloon.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a78d2d2184..04a7e6c772 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -117,7 +117,7 @@ static void balloon_deflate_page(VirtIOBalloon *balloon,
     void *addr = memory_region_get_ram_ptr(mr) + offset;
     RAMBlock *rb;
     size_t rb_page_size;
-    ram_addr_t ram_offset, host_page_base;
+    ram_addr_t ram_offset;
     void *host_addr;
     int ret;
 
@@ -125,27 +125,11 @@ static void balloon_deflate_page(VirtIOBalloon *balloon,
      * host address? */
     rb = qemu_ram_block_from_host(addr, false, &ram_offset);
     rb_page_size = qemu_ram_pagesize(rb);
-    host_page_base = ram_offset & ~(rb_page_size - 1);
-
-    if (balloon->pbp
-        && rb == balloon->pbp->rb
-        && host_page_base == balloon->pbp->base) {
-        int subpages = rb_page_size / BALLOON_PAGE_SIZE;
 
-        /*
-         * This means the guest has asked to discard some of the 4kiB
-         * subpages of a host page, but then changed its mind and
-         * asked to keep them after all.  It's exceedingly unlikely
-         * for a guest to do this in practice, but handle it anyway,
-         * since getting it wrong could mean discarding memory the
-         * guest is still using. */
-        clear_bit((ram_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
-                  balloon->pbp->bitmap);
-
-        if (bitmap_empty(balloon->pbp->bitmap, subpages)) {
-            g_free(balloon->pbp);
-            balloon->pbp = NULL;
-        }
+    if (balloon->pbp) {
+        /* Let's play safe and always reset the pbp on deflation requests. */
+        g_free(balloon->pbp);
+        balloon->pbp = NULL;
     }
 
     host_addr = (void *)((uintptr_t)addr & ~(rb_page_size - 1));
-- 
MST


