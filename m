Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EF7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:13:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6298F20657
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpN1er70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6298F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZa9Y-0004m2-Jr
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 09:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZjZ-0003mb-Tz
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28512
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZjY-0002Sn-1I
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IfX4VCGZDPU4PYs46rf6RBiW3prU7c4DsxlQ5f0f+rg=;
 b=UpN1er70rF01eKlcy/hoaGIXnZMAXtlEEAwi7BWgTDhxwYFytyJNfaMvBNViMeryBbA6wM
 eCzPmgP0dMVrlWxViQAqyqDV5stiFL27fk9DPRGRq2ECDXyj/p4mxr+CrKXT+Vq4O5P1T0
 V0y0nsr+FWCBAsqORRM0ogYLZ1XFtiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-jO9RFfsPPZyEhqbM2sMTQg-1; Fri, 15 May 2020 08:46:33 -0400
X-MC-Unique: jO9RFfsPPZyEhqbM2sMTQg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B1BF8014D7;
 Fri, 15 May 2020 12:46:32 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12B5A2E024;
 Fri, 15 May 2020 12:46:30 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 44/51] block: Drop child_file
Date: Fri, 15 May 2020 14:45:14 +0200
Message-Id: <20200515124521.335403-45-kwolf@redhat.com>
In-Reply-To: <20200515124521.335403-1-kwolf@redhat.com>
References: <20200515124521.335403-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200513110544.176672-33-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.25.4


