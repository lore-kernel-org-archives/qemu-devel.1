Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CFCC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:56:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7AAA2065F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVvMEkPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7AAA2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqtt-00060d-0h
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jsqZR-0007ZC-3g
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:35:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23227
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jsqZP-000453-JO
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594139746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wNdWeigsQ2eXYqWmSK4M0/4+t4vUL0zE6PnqvXT8QtI=;
 b=FVvMEkPm3Ub+weVijkNDee0bqRTE1F+bKGp+pazsmTbkJdf+O2BYQTPqbiMWNHt+oDwFlk
 MkneeBX90ycuDWshoqu89J93d4ystQpEENj4g6rlWJaYmxvLEFmsp3Q3UPDS5SsBiwP9ac
 kbNEtRsVTwm319WophiJIN5IyPIf9ko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-BrUp9KKzOnyv7VSbHPwuoA-1; Tue, 07 Jul 2020 12:35:42 -0400
X-MC-Unique: BrUp9KKzOnyv7VSbHPwuoA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75F27EC1BD;
 Tue,  7 Jul 2020 16:35:41 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-113.ams2.redhat.com
 [10.36.114.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A89E471684;
 Tue,  7 Jul 2020 16:35:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 01/12] qemu-img map: Don't limit block status request size
Date: Tue,  7 Jul 2020 18:34:53 +0200
Message-Id: <20200707163504.194740-2-kwolf@redhat.com>
In-Reply-To: <20200707163504.194740-1-kwolf@redhat.com>
References: <20200707163504.194740-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:31:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Limiting each loop iteration of qemu-img map to 1 GB was arbitrary from
the beginning, though it only cut the maximum in half then because the
interface was a signed 32 bit byte count. These days, bdrv_block_status
supports a 64 bit byte count, so the arbitrary limit is even worse.

On file-posix, bdrv_block_status() eventually maps to SEEK_HOLE and
SEEK_DATA, which don't support a limit, but always do all of the work
necessary to find the start of the next hole/data. Much of this work may
be repeated if we don't use this information fully, but query with an
only slightly larger offset in the next loop iteration. Therefore, if
bdrv_block_status() is called in a loop, it should always pass the
full number of bytes that the whole loop is interested in.

This removes the arbitrary limit and speeds up 'qemu-img map'
significantly on heavily fragmented images.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200707144629.51235-1-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index bdb9f6aa46..74946f81ca 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3217,12 +3217,9 @@ static int img_map(int argc, char **argv)
     curr.start = start_offset;
     while (curr.start + curr.length < length) {
         int64_t offset = curr.start + curr.length;
-        int64_t n;
+        int64_t n = length - offset;
 
-        /* Probe up to 1 GiB at a time.  */
-        n = MIN(1 * GiB, length - offset);
         ret = get_block_status(bs, offset, n, &next);
-
         if (ret < 0) {
             error_report("Could not read file metadata: %s", strerror(-ret));
             goto out;
-- 
2.25.4


