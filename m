Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C9AC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:27:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0EA3206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MmnfHJH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EA3206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw4r5-00029h-1s
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 10:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jw4qB-0001Id-Qt
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:26:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31373
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jw4q8-0005bC-11
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594909583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6E9xU7LhkbbodOrHzPzfIt1jVa8hx/fUfxgN+TWD1KQ=;
 b=MmnfHJH1q969fxpVqA+IshL0lN+n2OJ613UHPt4k46SUkASNJqXxU6IWV5rRAj8vZ2t8Rl
 VypBPS4Iq2HuDV2RGoPAFlfX++KovTAcR8z//1BniI71WrL6R6ezYio0HtX0XPsQ09E5aD
 XAgS1iKnnYkFzLJPZb/yqRSfllaHYC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-4eHvQhAgOba9McxwHEfmVw-1; Thu, 16 Jul 2020 10:26:21 -0400
X-MC-Unique: 4eHvQhAgOba9McxwHEfmVw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97CE28014D7;
 Thu, 16 Jul 2020 14:26:20 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-172.ams2.redhat.com
 [10.36.114.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 751CB710A0;
 Thu, 16 Jul 2020 14:26:19 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.1 v2 1/2] block: Require aligned image size to avoid
 assertion failure
Date: Thu, 16 Jul 2020 16:26:00 +0200
Message-Id: <20200716142601.111237-2-kwolf@redhat.com>
In-Reply-To: <20200716142601.111237-1-kwolf@redhat.com>
References: <20200716142601.111237-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:25:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Unaligned requests will automatically be aligned to bl.request_alignment
and we can't extend write requests to access space beyond the end of the
image without resizing the image, so if we have the WRITE permission,
but not the RESIZE one, it's required that the image size is aligned.

Failing to meet this requirement could cause assertion failures like
this if RESIZE permissions weren't requested:

qemu-img: block/io.c:1910: bdrv_co_write_req_prepare: Assertion `end_sector <= bs->total_sectors || child->perm & BLK_PERM_RESIZE' failed.

This was e.g. triggered by qemu-img converting to a target image with 4k
request alignment when the image was only aligned to 512 bytes, but not
to 4k.

Turn this into a graceful error in bdrv_check_perm() so that WRITE
without RESIZE can only be taken if the image size is aligned. If a user
holds both permissions and drops only RESIZE, the function will return
an error, but bdrv_child_try_set_perm() will ignore the failure silently
if permissions are only requested to be relaxed and just keep both
permissions while returning success.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/block.c b/block.c
index 35a372df57..6371928edb 100644
--- a/block.c
+++ b/block.c
@@ -2025,6 +2025,22 @@ static int bdrv_check_perm(BlockDriverState *bs, BlockReopenQueue *q,
         return -EPERM;
     }
 
+    /*
+     * Unaligned requests will automatically be aligned to bl.request_alignment
+     * and without RESIZE we can't extend requests to write to space beyond the
+     * end of the image, so it's required that the image size is aligned.
+     */
+    if ((cumulative_perms & BLK_PERM_WRITE) &&
+        !(cumulative_perms & BLK_PERM_RESIZE))
+    {
+        if ((bs->total_sectors * BDRV_SECTOR_SIZE) % bs->bl.request_alignment) {
+            error_setg(errp, "Cannot get 'write' permission without 'resize': "
+                             "Image size is not a multiple of request "
+                             "alignment");
+            return -EPERM;
+        }
+    }
+
     /* Check this node */
     if (!drv) {
         return 0;
-- 
2.25.4


