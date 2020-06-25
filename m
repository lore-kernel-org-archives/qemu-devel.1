Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB118C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3DA7207D8
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6KS6wJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3DA7207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTxp-0003mP-SW
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTit-0006J0-1c
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25800
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTio-0001Eb-4f
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=seVMBTfbgS6bXS9g7xb1XnqpuEC3VigQJIdmNrRL7xo=;
 b=i6KS6wJ/lv0KsalBH3i79QgHfg215ssawNnvPYyWEnngXclvUnqlfHGdgWHGy/DQJAM7Zp
 EwUn1fJS3j3gX5gtBXouDceQ0aGR0aB0sGO8aG/iHgEdLTHf1GuKvA/XM0EDFw6Ka9Tag7
 BS6Df7zO0vbU8EhLOm/MV26rj3sHjSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-wABsiDm6MYuuA5FFb8YI9w-1; Thu, 25 Jun 2020 11:23:19 -0400
X-MC-Unique: wABsiDm6MYuuA5FFb8YI9w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91D651009600;
 Thu, 25 Jun 2020 15:23:18 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38A12579A3;
 Thu, 25 Jun 2020 15:23:18 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 27/47] blkverify: Use bdrv_sum_allocated_file_size()
Date: Thu, 25 Jun 2020 17:21:55 +0200
Message-Id: <20200625152215.941773-28-mreitz@redhat.com>
In-Reply-To: <20200625152215.941773-1-mreitz@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

blkverify is a filter, so bdrv_get_allocated_file_size()'s default
implementation will return only the size of its filtered child.
However, because both of its children are disk images, it makes more
sense to sum both of their allocated sizes.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/blkverify.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blkverify.c b/block/blkverify.c
index 2f261de24b..64858c8df0 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -323,6 +323,7 @@ static BlockDriver bdrv_blkverify = {
     .bdrv_getlength                   = blkverify_getlength,
     .bdrv_refresh_filename            = blkverify_refresh_filename,
     .bdrv_dirname                     = blkverify_dirname,
+    .bdrv_get_allocated_file_size     = bdrv_sum_allocated_file_size,
 
     .bdrv_co_preadv                   = blkverify_co_preadv,
     .bdrv_co_pwritev                  = blkverify_co_pwritev,
-- 
2.26.2


