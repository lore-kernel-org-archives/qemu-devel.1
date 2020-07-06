Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712F5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:16:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B4732075B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmFP5HsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B4732075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsOAV-0007J6-EU
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 06:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jsO0J-0004I7-BC
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:05:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49285
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jsO0F-0004Ct-VL
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594029934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kI1zbjHnldHAj8UOQoPhhm9DhNupfZgrzUf+cR5juJ8=;
 b=VmFP5HsQkdYF8LzAw37lSlI3eeSPl2ggsIyGsU3lmNoMl+JHCFwmmRG8o/w6758Gq+Khc/
 2OTX+OsNeLD8WJWbutv99n9Z4l/crw2SQNqZKOzHo2IywUmDNYNGXWz5W0js8L6puXT7Mj
 CMR3uAT8GwjEPHdDkh9AgxzffhUzue4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-55lDmRRoPySxkpxzOdFNKA-1; Mon, 06 Jul 2020 06:05:32 -0400
X-MC-Unique: 55lDmRRoPySxkpxzOdFNKA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64DED107ACCA;
 Mon,  6 Jul 2020 10:05:31 +0000 (UTC)
Received: from localhost (ovpn-112-176.ams2.redhat.com [10.36.112.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08D75619C4;
 Mon,  6 Jul 2020 10:05:30 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 24/31] block/vdi: return ZERO block-status when appropriate
Date: Mon,  6 Jul 2020 12:04:25 +0200
Message-Id: <20200706100432.2301919-25-mreitz@redhat.com>
In-Reply-To: <20200706100432.2301919-1-mreitz@redhat.com>
References: <20200706100432.2301919-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:52:41
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

In case of !VDI_IS_ALLOCATED[], we do zero out the corresponding chunk
of qiov. So, this should be reported as ZERO.

Note that this changes visible output of "qemu-img map --output=json"
and "qemu-io -c map" commands. For qemu-img map, the change is obvious:
we just mark as zero what is really zero. For qemu-io it's less
obvious: what was unallocated now is allocated.

There is an inconsistency in understanding of unallocated regions in
Qemu: backing-supporting format-drivers return 0 block-status to report
go-to-backing logic for this area. Some protocol-drivers (iscsi) return
0 to report fs-unallocated-non-zero status (i.e., don't occupy space on
disk, read result is undefined).

BDRV_BLOCK_ALLOCATED is defined as something more close to
go-to-backing logic. Still it is calculated as ZERO | DATA, so 0 from
iscsi is treated as unallocated. It doesn't influence backing-chain
behavior, as iscsi can't have backing file. But it does influence
"qemu-io -c map".

We should solve this inconsistency at some future point. Now, let's
just make backing-not-supporting format drivers (vdi at this patch and
vpc with the following) to behave more like backing-supporting drivers
and not report 0 block-status. More over, returning ZERO status is
absolutely valid thing, and again, corresponds to how the other
format-drivers (backing-supporting) work.

After block-status update, it never reports 0, so setting
unallocated_blocks_are_zero doesn't make sense (as the only user of it
is bdrv_co_block_status and it checks unallocated_blocks_are_zero only
for unallocated areas). Drop it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200528094405.145708-4-vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/vdi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 2f506a01ba..c4527a9d8c 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -334,7 +334,6 @@ static int vdi_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     logout("\n");
     bdi->cluster_size = s->block_size;
     bdi->vm_state_offset = 0;
-    bdi->unallocated_blocks_are_zero = true;
     return 0;
 }
 
@@ -536,7 +535,7 @@ static int coroutine_fn vdi_co_block_status(BlockDriverState *bs,
     *pnum = MIN(s->block_size - index_in_block, bytes);
     result = VDI_IS_ALLOCATED(bmap_entry);
     if (!result) {
-        return 0;
+        return BDRV_BLOCK_ZERO;
     }
 
     *map = s->header.offset_data + (uint64_t)bmap_entry * s->block_size +
-- 
2.26.2


