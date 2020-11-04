Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E40FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C72EF20782
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N97TZwD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72EF20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaMhg-00070H-QE
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 12:36:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kaMeK-0002qs-DU
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:32:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47467)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kaMeG-0000eT-Vo
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604511160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2xSuC77k3yq5Xr0fSz+OMThLjn2jI/KvI5V3T68Sb1k=;
 b=N97TZwD0fpP4j14eFoPlot2Twkm8jAZJD9MHkwxi65dBK9Ewblq+JTl84EHPA6Gsvcf8uH
 TvKQXgpwVwIkMOtZJGEjSTFc7pSWRZwm+Bxhr0OIRZ8z0szkviNo81A9ndyxyxkSwXoItp
 eYYZzTE5tOL5ldClzaeHbPfuEcV+f3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-2a84hTLmPgmk9RixxarJjw-1; Wed, 04 Nov 2020 12:32:38 -0500
X-MC-Unique: 2a84hTLmPgmk9RixxarJjw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C4361009E23;
 Wed,  4 Nov 2020 17:32:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.207.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38FCA6266E;
 Wed,  4 Nov 2020 17:32:34 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] block: add max_ioctl_transfer to BlockLimits
Date: Wed,  4 Nov 2020 19:32:15 +0200
Message-Id: <20201104173217.417538-4-mlevitsk@redhat.com>
In-Reply-To: <20201104173217.417538-1-mlevitsk@redhat.com>
References: <20201104173217.417538-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Peter Lieven <pl@kamp.de>, Tom Yan <tom.ty89@gmail.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Maximum transfer size when accessing a kernel block device is only relevant
when using SCSI passthrough (SG_IO ioctl) since only in this case the requests
are passed directly to underlying hardware with no pre-processing.
Same is true when using /dev/sg* character devices (which only support SG_IO)

Therefore split the block driver's advertized max transfer size by
the regular max transfer size, and the max transfer size for SCSI passthrough
(the new max_ioctl_transfer field)

In the next patch, the qemu block drivers that support SCSI passthrough
will set the max_ioctl_transfer field, and simultaneously, the block devices
that implement scsi passthrough will switch to 'blk_get_max_ioctl_transfer' to
query and to pass it to the guest.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/block-backend.c          | 12 ++++++++++++
 block/io.c                     |  2 ++
 include/block/block_int.h      |  4 ++++
 include/sysemu/block-backend.h |  1 +
 4 files changed, 19 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index ce78d30794..c1d149a755 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1938,6 +1938,18 @@ uint32_t blk_get_max_transfer(BlockBackend *blk)
     return MIN_NON_ZERO(max, INT_MAX);
 }
 
+/* Returns the maximum transfer length, for SCSI passthrough */
+uint32_t blk_get_max_ioctl_transfer(BlockBackend *blk)
+{
+    BlockDriverState *bs = blk_bs(blk);
+    uint32_t max = 0;
+
+    if (bs) {
+        max = bs->bl.max_ioctl_transfer;
+    }
+    return MIN_NON_ZERO(max, INT_MAX);
+}
+
 int blk_get_max_iov(BlockBackend *blk)
 {
     return blk->root->bs->bl.max_iov;
diff --git a/block/io.c b/block/io.c
index ec5e152bb7..3eae176992 100644
--- a/block/io.c
+++ b/block/io.c
@@ -126,6 +126,8 @@ static void bdrv_merge_limits(BlockLimits *dst, const BlockLimits *src)
 {
     dst->opt_transfer = MAX(dst->opt_transfer, src->opt_transfer);
     dst->max_transfer = MIN_NON_ZERO(dst->max_transfer, src->max_transfer);
+    dst->max_ioctl_transfer = MIN_NON_ZERO(dst->max_ioctl_transfer,
+                                        src->max_ioctl_transfer);
     dst->opt_mem_alignment = MAX(dst->opt_mem_alignment,
                                  src->opt_mem_alignment);
     dst->min_mem_alignment = MAX(dst->min_mem_alignment,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 38cad9d15c..b198165114 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -678,6 +678,10 @@ typedef struct BlockLimits {
      * clamped down. */
     uint32_t max_transfer;
 
+    /* Maximal transfer length for SCSI passthrough (ioctl interface) */
+    uint32_t max_ioctl_transfer;
+
+
     /* memory alignment, in bytes so that no bounce buffer is needed */
     size_t min_mem_alignment;
 
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 8203d7f6f9..b019a37b7a 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -203,6 +203,7 @@ void blk_eject(BlockBackend *blk, bool eject_flag);
 int blk_get_flags(BlockBackend *blk);
 uint32_t blk_get_request_alignment(BlockBackend *blk);
 uint32_t blk_get_max_transfer(BlockBackend *blk);
+uint32_t blk_get_max_ioctl_transfer(BlockBackend *blk);
 int blk_get_max_iov(BlockBackend *blk);
 void blk_set_guest_block_size(BlockBackend *blk, int align);
 void *blk_try_blockalign(BlockBackend *blk, size_t size);
-- 
2.26.2


