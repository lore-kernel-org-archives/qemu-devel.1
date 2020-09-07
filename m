Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C0FC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:25:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC08421473
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQYhxE+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC08421473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFFHK-0000qL-OX
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 07:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF31-0003py-Kc
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:10:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31136)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF2z-0008Fg-B5
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599477052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NsmFZphgwyTci64fE/i+1OR9SMQLt7mC8t8yo3Pulu8=;
 b=EQYhxE+A+7nxltE/W5sKGQcKoSuiMFJbCroY428mcOZIgl8F55Gqz0EucUUoXh5B17v/k+
 OZqRF/MnOUH6qyLO+u++qp0b5/NPOiZZXAsNOTtqUTAKMXtR6/PMqNjHpUKhQ+1zIQMgEh
 ZtuMqReFjctctkuG0MT1pZ5zgpfOtS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-icL5uEA0Mv2HOvgmTisjKA-1; Mon, 07 Sep 2020 07:10:50 -0400
X-MC-Unique: icL5uEA0Mv2HOvgmTisjKA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E85E80EF84;
 Mon,  7 Sep 2020 11:10:49 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-154.ams2.redhat.com
 [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 552369CBA;
 Mon,  7 Sep 2020 11:10:48 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 50/64] block: Drop backing_bs()
Date: Mon,  7 Sep 2020 13:09:22 +0200
Message-Id: <20200907110936.261684-51-kwolf@redhat.com>
In-Reply-To: <20200907110936.261684-1-kwolf@redhat.com>
References: <20200907110936.261684-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:52:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Max Reitz <mreitz@redhat.com>

We want to make it explicit where bs->backing is used, and we have done
so.  The old role of backing_bs() is now effectively taken by
bdrv_cow_bs().

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 8205ccaa62..bb3d1c8a8c 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1003,11 +1003,6 @@ typedef enum BlockMirrorBackingMode {
     MIRROR_LEAVE_BACKING_CHAIN,
 } BlockMirrorBackingMode;
 
-static inline BlockDriverState *backing_bs(BlockDriverState *bs)
-{
-    return bs->backing ? bs->backing->bs : NULL;
-}
-
 
 /* Essential block drivers which must always be statically linked into qemu, and
  * which therefore can be accessed without using bdrv_find_format() */
-- 
2.25.4


