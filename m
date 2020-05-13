Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266A4CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E533620740
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4wKJoCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E533620740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYpEg-0003He-1w
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpD0-0000yY-Pl
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:05:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36286
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpCz-0003I4-5A
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589367951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=my4kt+U50ad7s30ensr94+YA2VstW7XtrD54gJvaQKM=;
 b=g4wKJoCfUj5KIfB6vmZjN8EZtSpV3wdOgxiKA8SbRntzUOS5MFdlJkmZpFhKi3fPfi4hmV
 No+8h1sVVn+xC20oBEOttEEvd154pP3nCVblIf4ZBk3sAg5X2Jt35TXSSG4Q1J0KtLi4DR
 b5AmY9i9EAgMSn3D581cSVI9pqNYj3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-0Zb5H8iMODGCuncwn7pu7Q-1; Wed, 13 May 2020 07:05:50 -0400
X-MC-Unique: 0Zb5H8iMODGCuncwn7pu7Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F18988014C0;
 Wed, 13 May 2020 11:05:48 +0000 (UTC)
Received: from localhost (unknown [10.40.193.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 887116E6FF;
 Wed, 13 May 2020 11:05:48 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 01/34] block: Mark commit, mirror, blkreplay as filters
Date: Wed, 13 May 2020 13:05:11 +0200
Message-Id: <20200513110544.176672-2-mreitz@redhat.com>
In-Reply-To: <20200513110544.176672-1-mreitz@redhat.com>
References: <20200513110544.176672-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 04:17:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The commit, mirror, and blkreplay block nodes are filters, so they should
be marked as such.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/blkreplay.c | 1 +
 block/commit.c    | 2 ++
 block/mirror.c    | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/block/blkreplay.c b/block/blkreplay.c
index c96ac8f4bc..131c9e8477 100644
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -135,6 +135,7 @@ static int blkreplay_snapshot_goto(BlockDriverState *bs,
 static BlockDriver bdrv_blkreplay = {
     .format_name            = "blkreplay",
     .instance_size          = 0,
+    .is_filter              = true,
 
     .bdrv_open              = blkreplay_open,
     .bdrv_child_perm        = bdrv_filter_default_perms,
diff --git a/block/commit.c b/block/commit.c
index ba60fb7955..b0a8a793cd 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -240,6 +240,8 @@ static BlockDriver bdrv_commit_top = {
     .bdrv_co_block_status       = bdrv_co_block_status_from_backing,
     .bdrv_refresh_filename      = bdrv_commit_top_refresh_filename,
     .bdrv_child_perm            = bdrv_commit_top_child_perm,
+
+    .is_filter                  = true,
 };
 
 void commit_start(const char *job_id, BlockDriverState *bs,
diff --git a/block/mirror.c b/block/mirror.c
index 201ffa26f9..55e992670a 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1530,6 +1530,8 @@ static BlockDriver bdrv_mirror_top = {
     .bdrv_co_block_status       = bdrv_co_block_status_from_backing,
     .bdrv_refresh_filename      = bdrv_mirror_top_refresh_filename,
     .bdrv_child_perm            = bdrv_mirror_top_child_perm,
+
+    .is_filter                  = true,
 };
 
 static BlockJob *mirror_start_job(
-- 
2.26.2


