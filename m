Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35BEC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:44:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4BBA20706
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cg/M6SRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BBA20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAUZS-0000hO-Vz
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUPV-0005A0-PM
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:34:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31139
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUPN-0000hU-3g
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598344459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NUtvLLkXGhTxusC964Go6wAT3O8j7DO4y23dEg89/J8=;
 b=cg/M6SRypgCbAxq3cFytej4guA5BYXSkz30y4I48okzTs0Zh+QrIMoNOGQwxCMej2DUIyF
 m+8sE9wOhx453yMvp8clsGtkVE9FHGBKf7zhXq6RjaBKvKpU1tP9WRTCJxhtRJPa5hqP+P
 mqNn9hlu//akBmwzC3a/Arxsny6tXBE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-buIsJwQBO6KiVn10pGVvXQ-1; Tue, 25 Aug 2020 04:34:16 -0400
X-MC-Unique: buIsJwQBO6KiVn10pGVvXQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFFACE75F;
 Tue, 25 Aug 2020 08:34:15 +0000 (UTC)
Received: from localhost (ovpn-113-72.ams2.redhat.com [10.36.113.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F3CE60C15;
 Tue, 25 Aug 2020 08:34:15 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 27/34] qcow2: Add subcluster support to handle_alloc_space()
Date: Tue, 25 Aug 2020 10:33:04 +0200
Message-Id: <20200825083311.1098442-28-mreitz@redhat.com>
In-Reply-To: <20200825083311.1098442-1-mreitz@redhat.com>
References: <20200825083311.1098442-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:05:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Alberto Garcia <berto@igalia.com>

The bdrv_co_pwrite_zeroes() call here fills complete clusters with
zeroes, but it can happen that some subclusters are not part of the
write request or the copy-on-write. This patch makes sure that only
the affected subclusters are overwritten.

A potential improvement would be to also fill with zeroes the other
subclusters if we can guarantee that we are not overwriting existing
data. However this would waste more disk space, so we should first
evaluate if it's really worth doing.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <b3dc97e8e2240ddb5191a4f930e8fc9653f94621.1594396418.git.berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 60192f1be3..9990535c46 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2421,6 +2421,9 @@ static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
 
     for (m = l2meta; m != NULL; m = m->next) {
         int ret;
+        uint64_t start_offset = m->alloc_offset + m->cow_start.offset;
+        unsigned nb_bytes = m->cow_end.offset + m->cow_end.nb_bytes -
+            m->cow_start.offset;
 
         if (!m->cow_start.nb_bytes && !m->cow_end.nb_bytes) {
             continue;
@@ -2435,16 +2438,14 @@ static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
          * efficiently zero out the whole clusters
          */
 
-        ret = qcow2_pre_write_overlap_check(bs, 0, m->alloc_offset,
-                                            m->nb_clusters * s->cluster_size,
+        ret = qcow2_pre_write_overlap_check(bs, 0, start_offset, nb_bytes,
                                             true);
         if (ret < 0) {
             return ret;
         }
 
         BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC_SPACE);
-        ret = bdrv_co_pwrite_zeroes(s->data_file, m->alloc_offset,
-                                    m->nb_clusters * s->cluster_size,
+        ret = bdrv_co_pwrite_zeroes(s->data_file, start_offset, nb_bytes,
                                     BDRV_REQ_NO_FALLBACK);
         if (ret < 0) {
             if (ret != -ENOTSUP && ret != -EAGAIN) {
-- 
2.26.2


