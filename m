Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372B0CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F247E2078C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d58F6ljS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F247E2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYpWH-0000gs-5L
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpEL-00034m-KS
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:07:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37199
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpEK-0003tV-Jm
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589368035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6sUwEnPvT050Wyhc2OgDTpzIaCgRW5xYHtmpShqAQsA=;
 b=d58F6ljSU67lYSNr6XWzDs4dRcsx4F2m0xjmfIjrVM1ROaqGfNO/4bBBrkn4h+B77i4qi0
 Wcu0c1QDrDblquV0IPl9qsLhD+y0KT5/3B2kAK9/8K8xZOZAXGzK0bf8v0ULy7nv2tTeON
 cFFjp3YOCSkAwZNwB6451XTlg56bIoM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-Jf_4RkRtMaGEWt96GQyHDQ-1; Wed, 13 May 2020 07:07:12 -0400
X-MC-Unique: Jf_4RkRtMaGEWt96GQyHDQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C71480183C;
 Wed, 13 May 2020 11:07:11 +0000 (UTC)
Received: from localhost (unknown [10.40.193.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2E911002382;
 Wed, 13 May 2020 11:07:10 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 32/34] block: Drop child_file
Date: Wed, 13 May 2020 13:05:42 +0200
Message-Id: <20200513110544.176672-33-mreitz@redhat.com>
In-Reply-To: <20200513110544.176672-1-mreitz@redhat.com>
References: <20200513110544.176672-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h |  1 -
 block.c                   | 39 ++-------------------------------------
 tests/test-bdrv-drain.c   |  8 +++-----
 3 files changed, 5 insertions(+), 43 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index e791c40496..7fbe3206b4 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -741,7 +741,6 @@ struct BdrvChildClass {
 };
 
 extern const BdrvChildClass child_of_bds;
-extern const BdrvChildClass child_file;
 
 struct BdrvChild {
     BlockDriverState *bs;
diff --git a/block.c b/block.c
index e79fe6e07e..6a24b23d51 100644
--- a/block.c
+++ b/block.c
@@ -80,13 +80,6 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
                                            BdrvChildRole child_role,
                                            Error **errp);
 
-/* TODO: Remove when no longer needed */
-static void bdrv_inherited_options(BdrvChildRole role, bool parent_is_format,
-                                   int *child_flags, QDict *child_options,
-                                   int parent_flags, QDict *parent_options);
-static void bdrv_child_cb_attach(BdrvChild *child);
-static void bdrv_child_cb_detach(BdrvChild *child);
-
 /* If non-zero, use only whitelisted block drivers */
 static int use_bdrv_whitelist;
 
@@ -1145,33 +1138,6 @@ static void bdrv_temp_snapshot_options(int *child_flags, QDict *child_options,
     *child_flags &= ~BDRV_O_NATIVE_AIO;
 }
 
-/*
- * Returns the options and flags that bs->file should get if a protocol driver
- * is expected, based on the given options and flags for the parent BDS
- */
-static void bdrv_protocol_options(BdrvChildRole role, bool parent_is_format,
-                                  int *child_flags, QDict *child_options,
-                                  int parent_flags, QDict *parent_options)
-{
-    bdrv_inherited_options(BDRV_CHILD_IMAGE, true,
-                           child_flags, child_options,
-                           parent_flags, parent_options);
-}
-
-const BdrvChildClass child_file = {
-    .parent_is_bds   = true,
-    .get_parent_desc = bdrv_child_get_parent_desc,
-    .inherit_options = bdrv_protocol_options,
-    .drained_begin   = bdrv_child_cb_drained_begin,
-    .drained_poll    = bdrv_child_cb_drained_poll,
-    .drained_end     = bdrv_child_cb_drained_end,
-    .attach          = bdrv_child_cb_attach,
-    .detach          = bdrv_child_cb_detach,
-    .inactivate      = bdrv_child_cb_inactivate,
-    .can_set_aio_ctx = bdrv_child_cb_can_set_aio_ctx,
-    .set_aio_ctx     = bdrv_child_cb_set_aio_ctx,
-};
-
 static void bdrv_backing_attach(BdrvChild *c)
 {
     BlockDriverState *parent = c->opaque;
@@ -2444,9 +2410,8 @@ static void bdrv_default_perms_for_storage(BlockDriverState *bs, BdrvChild *c,
 {
     int flags;
 
-    assert(child_class == &child_file ||
-           (child_class == &child_of_bds &&
-            (role & (BDRV_CHILD_METADATA | BDRV_CHILD_DATA))));
+    assert(child_class == &child_of_bds &&
+           (role & (BDRV_CHILD_METADATA | BDRV_CHILD_DATA)));
 
     flags = bdrv_reopen_get_flags(reopen_queue, bs);
 
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 0da5a3a6a1..655fd0d085 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -93,12 +93,10 @@ static void bdrv_test_child_perm(BlockDriverState *bs, BdrvChild *c,
                                  uint64_t *nperm, uint64_t *nshared)
 {
     /*
-     * bdrv_default_perms() accepts only these two, so disguise
-     * detach_by_driver_cb_parent as one of them.
+     * bdrv_default_perms() accepts nothing else, so disguise
+     * detach_by_driver_cb_parent.
      */
-    if (child_class != &child_file && child_class != &child_of_bds) {
-        child_class = &child_of_bds;
-    }
+    child_class = &child_of_bds;
 
     bdrv_default_perms(bs, c, child_class, role, reopen_queue,
                        perm, shared, nperm, nshared);
-- 
2.26.2


