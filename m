Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F242CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBECA2089D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZndKzlK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBECA2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUH2-0001oT-0C
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTjF-0006m4-Ut
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59030
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTjA-0001Qx-Ia
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXRCbxWHdhFdTk379StqcMbCRmexSIRMFz/qo0e8ItE=;
 b=AZndKzlKHmsaRcDHBBAGrwo3ZGVrkf0WUjcAMB61v5IlOC24GVkx3ZcJKUlAtkeCF8Scvw
 rl2URCAoLLOG1r/7FF3LNpaH2ic9YZFiRD5HejU+eicwV++vtTEl8ADFeYZBjxlskmcLwv
 tuTme2Bz7VcZUSwjjkA2zjlYFB918ls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-xFmB7LR-MeaySYcHJMWDHg-1; Thu, 25 Jun 2020 11:23:46 -0400
X-MC-Unique: xFmB7LR-MeaySYcHJMWDHg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2E1B800C60;
 Thu, 25 Jun 2020 15:23:44 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96A721A913;
 Thu, 25 Jun 2020 15:23:44 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 39/47] blockdev: Fix active commit choice
Date: Thu, 25 Jun 2020 17:22:07 +0200
Message-Id: <20200625152215.941773-40-mreitz@redhat.com>
In-Reply-To: <20200625152215.941773-1-mreitz@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 01:47:53
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

We have to perform an active commit whenever the top node has a parent
that has taken the WRITE permission on it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 blockdev.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 402f1d1df1..237fffbe53 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2589,6 +2589,7 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
     AioContext *aio_context;
     Error *local_err = NULL;
     int job_flags = JOB_DEFAULT;
+    uint64_t top_perm, top_shared;
 
     if (!has_speed) {
         speed = 0;
@@ -2704,14 +2705,31 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
         goto out;
     }
 
-    if (top_bs == bs) {
+    /*
+     * Active commit is required if and only if someone has taken a
+     * WRITE permission on the top node.  Historically, we have always
+     * used active commit for top nodes, so continue that practice.
+     * (Active commit is never really wrong.)
+     */
+    bdrv_get_cumulative_perm(top_bs, &top_perm, &top_shared);
+    if (top_perm & BLK_PERM_WRITE ||
+        bdrv_skip_filters(top_bs) == bdrv_skip_filters(bs))
+    {
         if (has_backing_file) {
             error_setg(errp, "'backing-file' specified,"
                              " but 'top' is the active layer");
             goto out;
         }
-        commit_active_start(has_job_id ? job_id : NULL, bs, base_bs,
-                            job_flags, speed, on_error,
+        if (!has_job_id) {
+            /*
+             * Emulate here what block_job_create() does, because it
+             * is possible that @bs != @top_bs (the block job should
+             * be named after @bs, even if @top_bs is the actual
+             * source)
+             */
+            job_id = bdrv_get_device_name(bs);
+        }
+        commit_active_start(job_id, top_bs, base_bs, job_flags, speed, on_error,
                             filter_node_name, NULL, NULL, false, &local_err);
     } else {
         BlockDriverState *overlay_bs = bdrv_find_overlay(bs, top_bs);
-- 
2.26.2


