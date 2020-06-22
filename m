Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A7FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3899206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWjYTA3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3899206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnOHK-0002Vg-4N
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 11:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jnO7K-0000y5-TG
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:12:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27852
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jnO7I-00066M-9s
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592838731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BNvSGC9nTqGGUEXPC0RjFmoV3QN006CFzuU+WpDEcQc=;
 b=cWjYTA3UOUbqoSjTDmI9R7TyksS35lhHJ7v02/MMKS3wyoHi740Ns8jClBmyHt/NyYY0M6
 o03Gq8yrxghORpodi9izduMqOX6KRV0aqkFmwwusqZ+HVPx74B/cb/oDYMogDrZgORdaB1
 xDs8BRBquDvPCjbsx/fzpEuWWNFw9EI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-wjSteQknO2OK6vy50U3u1A-1; Mon, 22 Jun 2020 11:12:10 -0400
X-MC-Unique: wjSteQknO2OK6vy50U3u1A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04A52A0BEB;
 Mon, 22 Jun 2020 15:12:09 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-179.ams2.redhat.com
 [10.36.113.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5775471676;
 Mon, 22 Jun 2020 15:12:07 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH] qemu-img convert: Don't pre-zero images
Date: Mon, 22 Jun 2020 17:12:03 +0200
Message-Id: <20200622151203.35624-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, pl@kamp.de, qemu-devel@nongnu.org, mreitz@redhat.com,
 nsoffer@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 5a37b60a61c, qemu-img create will pre-zero the target image
if it isn't already zero-initialised (most importantly, for host block
devices, but also iscsi etc.), so that writing explicit zeros wouldn't
be necessary later.

This could speed up the operation significantly, in particular when the
source image file was only sparsely populated. However, it also means
that some block are written twice: Once when pre-zeroing them, and then
when they are overwritten with actual data. On a full image, the
pre-zeroing is wasted work because everything will be overwritten.

In practice, write_zeroes typically turns out faster than writing
explicit zero buffers, but slow enough that first zeroing everything and
then overwriting parts can be a significant net loss.

Meanwhile, qemu-img convert was rewritten in 690c7301600 and zero blocks
are now written to the target using bdrv_co_pwrite_zeroes() if the
target could be pre-zeroed. This way we already make use of the faster
write_zeroes operation, but avoid writing any blocks twice.

Remove the pre-zeroing because these days this former optimisation has
actually turned into a pessimisation in the common case.

Reported-by: Nir Soffer <nsoffer@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index d7e846e607..bdb9f6aa46 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2084,15 +2084,6 @@ static int convert_do_copy(ImgConvertState *s)
         s->has_zero_init = bdrv_has_zero_init(blk_bs(s->target));
     }
 
-    if (!s->has_zero_init && !s->target_has_backing &&
-        bdrv_can_write_zeroes_with_unmap(blk_bs(s->target)))
-    {
-        ret = blk_make_zero(s->target, BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK);
-        if (ret == 0) {
-            s->has_zero_init = true;
-        }
-    }
-
     /* Allocate buffer for copied data. For compressed images, only one cluster
      * can be copied at a time. */
     if (s->compressed) {
-- 
2.25.4


