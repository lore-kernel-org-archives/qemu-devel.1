Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03C2C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:52:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA5420782
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4gesbGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA5420782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kahZJ-00017c-5x
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 10:52:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kahXx-0008M2-Jz
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 10:51:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kahXw-0008Ht-2E
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 10:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604591491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9wx9PY+GRkImCX9zjnpszUPN/ErsdlC5rR7ZwlPk4fI=;
 b=h4gesbGCpPEObN2eRzgPirDJh8UdV6quu1VpMZhoS5B6hFy3iSvaqmM9O5n7+0kLw2in+m
 W+HpE927MWLmwxc3i1laan5IYovOJ6Q4OYgWkzeMpSRw4u/JMTWMMz++Wew1Vzfp/gBml6
 nOXa+Be2DN4+V6mS1zLe40YiNPt8CrI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-43b9Id0tP5uwdp3vwg8_0Q-1; Thu, 05 Nov 2020 10:51:29 -0500
X-MC-Unique: 43b9Id0tP5uwdp3vwg8_0Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABA0242380;
 Thu,  5 Nov 2020 15:51:27 +0000 (UTC)
Received: from blue.redhat.com (ovpn-114-103.phx2.redhat.com [10.3.114.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CAE811002382;
 Thu,  5 Nov 2020 15:51:26 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4] block: Fix integer promotion error in bdrv_getlength()
Date: Thu,  5 Nov 2020 09:51:22 -0600
Message-Id: <20201105155122.60943-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, chengchiwen@h3c.com, berto@igalia.com, tu.guoyi@h3c.com,
 "open list:Block layer core" <qemu-block@nongnu.org>, armbru@redhat.com,
 mreitz@redhat.com, wang.yongD@h3c.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Back in 2015, we attempted to fix error reporting for images that
claimed to have more than INT64_MAX/512 sectors, but due to the type
promotions caused by BDRV_SECTOR_SIZE being unsigned, this
inadvertently forces all negative ret values to be slammed into -EFBIG
rather than the original error.  While we're at it, we can avoid the
confusing ?: by spelling the logic more directly.

Fixes: 4a9c9ea0d3
Reported-by: Guoyi Tu <tu.guoyi@h3c.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 56bacc9e9f13..2fd932154e12 100644
--- a/block.c
+++ b/block.c
@@ -5091,8 +5091,13 @@ int64_t bdrv_getlength(BlockDriverState *bs)
 {
     int64_t ret = bdrv_nb_sectors(bs);

-    ret = ret > INT64_MAX / BDRV_SECTOR_SIZE ? -EFBIG : ret;
-    return ret < 0 ? ret : ret * BDRV_SECTOR_SIZE;
+    if (ret < 0) {
+        return ret;
+    }
+    if (ret > INT64_MAX / BDRV_SECTOR_SIZE) {
+        return -EFBIG;
+    }
+    return ret * BDRV_SECTOR_SIZE;
 }

 /* return 0 as number of sectors if no device present or error */
-- 
2.28.0


