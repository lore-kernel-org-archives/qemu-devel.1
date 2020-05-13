Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3D1CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:22:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A1C20753
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LwBehgWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A1C20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYpSl-0002qb-8X
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpE7-0002om-CW
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:07:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25975
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpE5-0003cC-Gq
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589368020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PZc+T+XGEVZYLDFaxuyKyvZNmU/rD6WxqGH2Bz4OZSI=;
 b=LwBehgWxTKkWZpd3zaJLD9DaNSHW/UTKteMZrY3QESw/e+dSAhECUXueDh4IiqYI+nB3i1
 EvJ3daLsLhUvt7iweY8aYXQ3LoEfj1YTb2EEqdRS+6dWaiMUTCmDxFAZR9C+3I8rJZpTKg
 IcrTICqQPH4fg9sgNTHHJRPRo07I3LM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-UvC3SGYXPTyfCKJTN26HQw-1; Wed, 13 May 2020 07:06:59 -0400
X-MC-Unique: UvC3SGYXPTyfCKJTN26HQw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D55D107ACCD;
 Wed, 13 May 2020 11:06:58 +0000 (UTC)
Received: from localhost (unknown [10.40.193.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E41D038DE3;
 Wed, 13 May 2020 11:06:57 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 27/34] block: Use child_of_bds in remaining places
Date: Wed, 13 May 2020 13:05:37 +0200
Message-Id: <20200513110544.176672-28-mreitz@redhat.com>
In-Reply-To: <20200513110544.176672-1-mreitz@redhat.com>
References: <20200513110544.176672-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

Replace child_file by child_of_bds in all remaining places (excluding
tests).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c              |  3 ++-
 block/backup-top.c   |  4 ++--
 block/blklogwrites.c |  4 ++--
 block/raw-format.c   | 15 +++++++++++++--
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/block.c b/block.c
index d138a3c261..fb94adcca4 100644
--- a/block.c
+++ b/block.c
@@ -3406,7 +3406,8 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
         BlockDriverState *file_bs;
 
         file_bs = bdrv_open_child_bs(filename, options, "file", bs,
-                                     &child_file, 0, true, &local_err);
+                                     &child_of_bds, BDRV_CHILD_IMAGE,
+                                     true, &local_err);
         if (local_err) {
             goto fail;
         }
diff --git a/block/backup-top.c b/block/backup-top.c
index f059617095..8af2c5fe9b 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -215,8 +215,8 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
              source->supported_zero_flags);
 
     bdrv_ref(target);
-    state->target = bdrv_attach_child(top, target, "target", &child_file, 0,
-                                      errp);
+    state->target = bdrv_attach_child(top, target, "target", &child_of_bds,
+                                      BDRV_CHILD_DATA, errp);
     if (!state->target) {
         bdrv_unref(target);
         bdrv_unref(top);
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 78b0c49460..3a57b273fc 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -167,8 +167,8 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     /* Open the log file */
-    s->log_file = bdrv_open_child(NULL, options, "log", bs, &child_file, 0,
-                                  false, &local_err);
+    s->log_file = bdrv_open_child(NULL, options, "log", bs, &child_of_bds,
+                                  BDRV_CHILD_METADATA, false, &local_err);
     if (local_err) {
         ret = -EINVAL;
         error_propagate(errp, local_err);
diff --git a/block/raw-format.c b/block/raw-format.c
index 824fe70686..bfb4d7ddb7 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -441,6 +441,7 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
     BDRVRawState *s = bs->opaque;
     bool has_size;
     uint64_t offset, size;
+    BdrvChildRole file_role;
     int ret;
 
     ret = raw_read_options(options, &offset, &has_size, &size, errp);
@@ -448,8 +449,18 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
         return ret;
     }
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
-                               false, errp);
+    /*
+     * Without offset and a size limit, this driver behaves very much
+     * like a filter.  With any such limit, it does not.
+     */
+    if (offset || has_size) {
+        file_role = BDRV_CHILD_DATA | BDRV_CHILD_PRIMARY;
+    } else {
+        file_role = BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY;
+    }
+
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               file_role, false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
-- 
2.26.2


