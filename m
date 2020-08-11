Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1814C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:36:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C49720756
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QjMY3ado"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C49720756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Qhp-0001KU-TB
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 05:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k5Qge-000094-0p
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 05:35:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57421
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k5Qgb-0001Dn-Hw
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 05:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597138512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QcQViF1bFKP2ex+fLMMInijtnVjDUfdtfdB75Zbi7ic=;
 b=QjMY3adoT8aEAKI94X1enDPMZxlmjPAxJdGwxBfZc/dgysN0zh97Hbk0Pe/TNPCHaQavl/
 HzoL9j8jn3lPL9wiPJpaxoQ4dq64EZiO/IAX3STTFsVY7lAo2cWjbs51ncCbih2JITGdfa
 ivzNOoc1dvib5nIOxR51yZs69d3oXxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-ig_l7z5kPIqEA0AGDM-sPg-1; Tue, 11 Aug 2020 05:35:10 -0400
X-MC-Unique: ig_l7z5kPIqEA0AGDM-sPg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B41779EC0;
 Tue, 11 Aug 2020 09:35:09 +0000 (UTC)
Received: from localhost (ovpn-113-152.ams2.redhat.com [10.36.113.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EDAC35D992;
 Tue, 11 Aug 2020 09:35:08 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 1/2] block/block-copy: always align copied region to cluster
 size
Date: Tue, 11 Aug 2020 11:35:04 +0200
Message-Id: <20200811093505.972894-2-mreitz@redhat.com>
In-Reply-To: <20200811093505.972894-1-mreitz@redhat.com>
References: <20200811093505.972894-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 04:41:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Reiter <s.reiter@proxmox.com>

Since commit 42ac214406e0 (block/block-copy: refactor task creation)
block_copy_task_create calculates the area to be copied via
bdrv_dirty_bitmap_next_dirty_area, but that can return an unaligned byte
count if the image's last cluster end is not aligned to the bitmap's
granularity.

Always ALIGN_UP the resulting bytes value to satisfy block_copy_do_copy,
which requires the 'bytes' parameter to be aligned to cluster size.

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
Message-Id: <20200810095523.15071-1-s.reiter@proxmox.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/block-copy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/block-copy.c b/block/block-copy.c
index f7428a7c08..a30b9097ef 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -142,6 +142,9 @@ static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
         return NULL;
     }
 
+    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
+    bytes = QEMU_ALIGN_UP(bytes, s->cluster_size);
+
     /* region is dirty, so no existent tasks possible in it */
     assert(!find_conflicting_task(s, offset, bytes));
 
-- 
2.26.2


