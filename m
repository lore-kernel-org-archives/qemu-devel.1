Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC7AC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 11:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C0C212CC
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 11:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuH12lmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C0C212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT1tr-0007jo-8r
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 07:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kT1po-0003TS-Q7
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 07:54:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kT1pk-0003Ke-1z
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 07:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602762851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kMVMwCUPwIjBUEUO2/ANQICpZSE+/w+eh9kynvP9o8o=;
 b=AuH12lmChl+SOJ05+f/jLNBVahamw3C+M1e5FAypgECx/SkZ+ylyfaNOkyuDdlVQd4PSMz
 Xjg+VuCG5eQ6U5vyxA3/8z+TKsY06JTMmGViEBBAewXxHJszHuDvVnW3zrLLyBcBJ+QvuY
 w3LQF/qNg0DOz2ewXO17lN4d1UKvpQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-w0_ghJvFM62y6YrZO5EqaA-1; Thu, 15 Oct 2020 07:54:09 -0400
X-MC-Unique: w0_ghJvFM62y6YrZO5EqaA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8167018C89C0;
 Thu, 15 Oct 2020 11:54:08 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-210.ams2.redhat.com [10.36.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 214FF73661;
 Thu, 15 Oct 2020 11:54:05 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, stefanha@redhat.com, fam@euphon.net,
 philmd@redhat.com, alex.williamson@redhat.com
Subject: [RFC 5/5] block/nvme: Align iov's va and size on host page size
Date: Thu, 15 Oct 2020 13:52:52 +0200
Message-Id: <20201015115252.15582-6-eric.auger@redhat.com>
In-Reply-To: <20201015115252.15582-1-eric.auger@redhat.com>
References: <20201015115252.15582-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: kwolf@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make sure iov's va and size are properly aligned on the host page
size.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 block/nvme.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index be8ec48bf2..45807ed110 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -978,11 +978,12 @@ static coroutine_fn int nvme_cmd_map_qiov(BlockDriverState *bs, NvmeCmd *cmd,
     for (i = 0; i < qiov->niov; ++i) {
         bool retry = true;
         uint64_t iova;
+        size_t len = QEMU_ALIGN_UP(qiov->iov[i].iov_len,
+                                   qemu_real_host_page_size);
 try_map:
         r = qemu_vfio_dma_map(s->vfio,
                               qiov->iov[i].iov_base,
-                              qiov->iov[i].iov_len,
-                              true, &iova);
+                              len, true, &iova);
         if (r == -ENOMEM && retry) {
             retry = false;
             trace_nvme_dma_flush_queue_wait(s);
@@ -1126,8 +1127,8 @@ static inline bool nvme_qiov_aligned(BlockDriverState *bs,
     BDRVNVMeState *s = bs->opaque;
 
     for (i = 0; i < qiov->niov; ++i) {
-        if (!QEMU_PTR_IS_ALIGNED(qiov->iov[i].iov_base, s->page_size) ||
-            !QEMU_IS_ALIGNED(qiov->iov[i].iov_len, s->page_size)) {
+        if (!QEMU_PTR_IS_ALIGNED(qiov->iov[i].iov_base, qemu_real_host_page_size) ||
+            !QEMU_IS_ALIGNED(qiov->iov[i].iov_len, qemu_real_host_page_size)) {
             trace_nvme_qiov_unaligned(qiov, i, qiov->iov[i].iov_base,
                                       qiov->iov[i].iov_len, s->page_size);
             return false;
@@ -1143,7 +1144,7 @@ static int nvme_co_prw(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     int r;
     uint8_t *buf = NULL;
     QEMUIOVector local_qiov;
-
+    size_t len = QEMU_ALIGN_UP(bytes, qemu_real_host_page_size);
     assert(QEMU_IS_ALIGNED(offset, s->page_size));
     assert(QEMU_IS_ALIGNED(bytes, s->page_size));
     assert(bytes <= s->max_transfer);
@@ -1151,7 +1152,7 @@ static int nvme_co_prw(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
         return nvme_co_prw_aligned(bs, offset, bytes, qiov, is_write, flags);
     }
     trace_nvme_prw_buffered(s, offset, bytes, qiov->niov, is_write);
-    buf = qemu_try_memalign(s->page_size, bytes);
+    buf = qemu_try_memalign(qemu_real_host_page_size, len);
 
     if (!buf) {
         return -ENOMEM;
-- 
2.21.3


