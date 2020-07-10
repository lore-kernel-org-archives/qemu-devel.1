Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AD6C433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 14:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 286E6207D0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 14:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fdat+49w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286E6207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jttwd-0005OI-G2
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 10:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jttui-0002qw-0a
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 10:22:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27001
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jttuf-0004LO-B8
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 10:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594390924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rgBMF4rLOlQh9wroKSJAZ4DRUD3Yfbi2jLwdpSlmMG0=;
 b=Fdat+49w2K46NdeqEbbqfzQqFme1PeusfVdE4YcdX/6OoIV0jlCp8cIFJsiHiLa3V3TJNm
 2hYe2DswbtOnIeMDbpNWeh7YoALGdnzSWxSxRbzK96YSaZy7DO3QHrekGYQWa6+zKSeI4j
 34U/oZy5wKQK1Q7hYkL9LYjJmBuOlWY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-W5ccL0ZINTSt8tsDYgCktA-1; Fri, 10 Jul 2020 10:22:02 -0400
X-MC-Unique: W5ccL0ZINTSt8tsDYgCktA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8521EE924;
 Fri, 10 Jul 2020 14:22:01 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-57.ams2.redhat.com [10.36.114.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8EA5960C05;
 Fri, 10 Jul 2020 14:21:58 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.1 1/2] block: Require aligned image size to avoid
 assertion failure
Date: Fri, 10 Jul 2020 16:21:48 +0200
Message-Id: <20200710142149.40962-2-kwolf@redhat.com>
In-Reply-To: <20200710142149.40962-1-kwolf@redhat.com>
References: <20200710142149.40962-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:08:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, nsoffer@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Unaligned requests will automatically be aligned to bl.request_alignment
and we don't want to extend requests to access space beyond the end of
the image, so it's required that the image size is aligned.

With write requests, this could cause assertion failures like this if
RESIZE permissions weren't requested:

qemu-img: block/io.c:1910: bdrv_co_write_req_prepare: Assertion `end_sector <= bs->total_sectors || child->perm & BLK_PERM_RESIZE' failed.

This was e.g. triggered by qemu-img converting to a target image with 4k
request alignment when the image was only aligned to 512 bytes, but not
to 4k.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block.c b/block.c
index cc377d7ef3..c635777911 100644
--- a/block.c
+++ b/block.c
@@ -1489,6 +1489,16 @@ static int bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv,
         return -EINVAL;
     }
 
+    /*
+     * Unaligned requests will automatically be aligned to bl.request_alignment
+     * and we don't want to extend requests to access space beyond the end of
+     * the image, so it's required that the image size is aligned.
+     */
+    if ((bs->total_sectors * BDRV_SECTOR_SIZE) % bs->bl.request_alignment) {
+        error_setg(errp, "Image size is not a multiple of request alignment");
+        return -EINVAL;
+    }
+
     assert(bdrv_opt_mem_align(bs) != 0);
     assert(bdrv_min_mem_align(bs) != 0);
     assert(is_power_of_2(bs->bl.request_alignment));
-- 
2.25.4


