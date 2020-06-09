Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAD5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:10:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58B2D2064C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPjLollD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B2D2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiexR-0004lC-B7
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 10:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jiewC-0003bh-Gd
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 10:09:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32995
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jiewB-0006ni-QR
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 10:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591711750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OSRdD0d6Yp4nIUq+zTQOlRcs3Bdzt2jY+nd3Dosbis8=;
 b=bPjLollDIPpJwik7cLMYJBcZiqMZmBsojl8R+62Ri84OlBrMw8gyI3e0t0DLfmwONCXIio
 dp1IykRHsgT2dYubN4ctrs4u+IP5EUcVwnxHQfeWqi7LU565CGvxZQ21sqScDLqj/LN9HM
 bOMk/OTYf+q5ZNkIFucLxcD/EP8o/oE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-052ZW6kvPWuqWUfYoRBPUg-1; Tue, 09 Jun 2020 10:09:07 -0400
X-MC-Unique: 052ZW6kvPWuqWUfYoRBPUg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBD6018A8223;
 Tue,  9 Jun 2020 14:09:05 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-124.ams2.redhat.com
 [10.36.114.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 735F79F77;
 Tue,  9 Jun 2020 14:09:04 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH] qcow2: Reduce write_zeroes size in handle_alloc_space()
Date: Tue,  9 Jun 2020 16:08:59 +0200
Message-Id: <20200609140859.142230-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, anton.nefedov@virtuozzo.com, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit c8bb23cbdbe, handle_alloc_space() is called for newly
allocated clusters to efficiently initialise the COW areas with zeros if
necessary. It skips the whole operation if both start_cow nor end_cow
are empty. However, it requests zeroing the whole request size (possibly
multiple megabytes) even if only one end of the request actually needs
this.

This patch reduces the write_zeroes request size in this case so that we
don't unnecessarily zero-initialise a region that we're going to
overwrite immediately.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 0cd2e6757e..77742877fb 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2403,6 +2403,8 @@ static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
     }
 
     for (m = l2meta; m != NULL; m = m->next) {
+        uint64_t start = m->alloc_offset;
+        uint64_t len = m->nb_clusters * s->cluster_size;
         int ret;
 
         if (!m->cow_start.nb_bytes && !m->cow_end.nb_bytes) {
@@ -2413,21 +2415,25 @@ static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
             continue;
         }
 
+        if (!m->cow_start.nb_bytes) {
+            start += m->cow_end.offset;
+            len -= m->cow_end.offset;
+        } else if (!m->cow_end.nb_bytes) {
+            len = m->cow_start.nb_bytes;
+        }
+
         /*
          * instead of writing zero COW buffers,
          * efficiently zero out the whole clusters
          */
 
-        ret = qcow2_pre_write_overlap_check(bs, 0, m->alloc_offset,
-                                            m->nb_clusters * s->cluster_size,
-                                            true);
+        ret = qcow2_pre_write_overlap_check(bs, 0, start, len, true);
         if (ret < 0) {
             return ret;
         }
 
         BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC_SPACE);
-        ret = bdrv_co_pwrite_zeroes(s->data_file, m->alloc_offset,
-                                    m->nb_clusters * s->cluster_size,
+        ret = bdrv_co_pwrite_zeroes(s->data_file, start, len,
                                     BDRV_REQ_NO_FALLBACK);
         if (ret < 0) {
             if (ret != -ENOTSUP && ret != -EAGAIN) {
-- 
2.25.4


