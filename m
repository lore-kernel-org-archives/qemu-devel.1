Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3336FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:12:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3BB020657
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyH/YsYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BB020657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZa8B-00012A-4T
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 09:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZjR-0003UE-HS
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22192
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZjP-0002R0-Fn
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WO1RmzvUGN7QwMZ7IB3cZAT2Hj4r6SJ5n0/HFJEnUmk=;
 b=OyH/YsYQEB9epxlNbybcqf2nGXfzG0VmqfexQ8H0vspAhjv3irB1oMl9j3UcxhuInMJaxP
 tacxPMsD7FUFESrQa0ldMwqneJElWhKNkYFPZc4GAi5lcpFmcHuxy1/v0XXNXxHSreZw4T
 3+huvI2Ab9/FlAl0e2pctrVAeb8aYl4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-YVdfH5uNPgCr0TYvt1k2qg-1; Fri, 15 May 2020 08:46:22 -0400
X-MC-Unique: YVdfH5uNPgCr0TYvt1k2qg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2408835B5E;
 Fri, 15 May 2020 12:46:21 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D70422E024;
 Fri, 15 May 2020 12:46:20 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 36/51] block: Drop child_backing
Date: Fri, 15 May 2020 14:45:06 +0200
Message-Id: <20200515124521.335403-37-kwolf@redhat.com>
In-Reply-To: <20200515124521.335403-1-kwolf@redhat.com>
References: <20200515124521.335403-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200513110544.176672-25-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h |  1 -
 block.c                   | 60 ++-------------------------------------
 2 files changed, 3 insertions(+), 58 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 4b09fa1124..0781d43af5 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -742,7 +742,6 @@ struct BdrvChildClass {
 
 extern const BdrvChildClass child_of_bds;
 extern const BdrvChildClass child_file;
-extern const BdrvChildClass child_backing;
 
 struct BdrvChild {
     BlockDriverState *bs;
diff --git a/block.c b/block.c
index 131ae20ffc..d138a3c261 100644
--- a/block.c
+++ b/block.c
@@ -1215,15 +1215,6 @@ static void bdrv_backing_attach(BdrvChild *c)
                     parent->backing_blocker);
 }
 
-/* XXX: Will be removed along with child_backing */
-static void bdrv_child_cb_attach_backing(BdrvChild *c)
-{
-    if (!(c->role & BDRV_CHILD_COW)) {
-        bdrv_backing_attach(c);
-    }
-    bdrv_child_cb_attach(c);
-}
-
 static void bdrv_backing_detach(BdrvChild *c)
 {
     BlockDriverState *parent = c->opaque;
@@ -1234,28 +1225,6 @@ static void bdrv_backing_detach(BdrvChild *c)
     parent->backing_blocker = NULL;
 }
 
-/* XXX: Will be removed along with child_backing */
-static void bdrv_child_cb_detach_backing(BdrvChild *c)
-{
-    if (!(c->role & BDRV_CHILD_COW)) {
-        bdrv_backing_detach(c);
-    }
-    bdrv_child_cb_detach(c);
-}
-
-/*
- * Returns the options and flags that bs->backing should get, based on the
- * given options and flags for the parent BDS
- */
-static void bdrv_backing_options(BdrvChildRole role, bool parent_is_format,
-                                 int *child_flags, QDict *child_options,
-                                 int parent_flags, QDict *parent_options)
-{
-    bdrv_inherited_options(BDRV_CHILD_COW, true,
-                           child_flags, child_options,
-                           parent_flags, parent_options);
-}
-
 static int bdrv_backing_update_filename(BdrvChild *c, BlockDriverState *base,
                                         const char *filename, Error **errp)
 {
@@ -1283,21 +1252,6 @@ static int bdrv_backing_update_filename(BdrvChild *c, BlockDriverState *base,
     return ret;
 }
 
-const BdrvChildClass child_backing = {
-    .parent_is_bds   = true,
-    .get_parent_desc = bdrv_child_get_parent_desc,
-    .attach          = bdrv_child_cb_attach_backing,
-    .detach          = bdrv_child_cb_detach_backing,
-    .inherit_options = bdrv_backing_options,
-    .drained_begin   = bdrv_child_cb_drained_begin,
-    .drained_poll    = bdrv_child_cb_drained_poll,
-    .drained_end     = bdrv_child_cb_drained_end,
-    .inactivate      = bdrv_child_cb_inactivate,
-    .update_filename = bdrv_backing_update_filename,
-    .can_set_aio_ctx = bdrv_child_cb_can_set_aio_ctx,
-    .set_aio_ctx     = bdrv_child_cb_set_aio_ctx,
-};
-
 /*
  * Returns the options and flags that a generic child of a BDS should
  * get, based on the given options and flags for the parent BDS.
@@ -2446,8 +2400,7 @@ static void bdrv_default_perms_for_cow(BlockDriverState *bs, BdrvChild *c,
                                        uint64_t perm, uint64_t shared,
                                        uint64_t *nperm, uint64_t *nshared)
 {
-    assert(child_class == &child_backing ||
-           (child_class == &child_of_bds && (role & BDRV_CHILD_COW)));
+    assert(child_class == &child_of_bds && (role & BDRV_CHILD_COW));
 
     /*
      * We want consistent read from backing files if the parent needs it.
@@ -2566,23 +2519,16 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared)
 {
-    bool backing = (child_class == &child_backing);
-
     if (child_class == &child_of_bds) {
         bdrv_default_perms(bs, c, child_class, role, reopen_queue,
                            perm, shared, nperm, nshared);
         return;
     }
 
-    assert(child_class == &child_backing || child_class == &child_file);
+    assert(child_class == &child_file);
 
-    if (!backing) {
-        bdrv_default_perms_for_storage(bs, c, child_class, role, reopen_queue,
-                                       perm, shared, nperm, nshared);
-    } else {
-        bdrv_default_perms_for_cow(bs, c, child_class, role, reopen_queue,
+    bdrv_default_perms_for_storage(bs, c, child_class, role, reopen_queue,
                                    perm, shared, nperm, nshared);
-    }
 }
 
 void bdrv_default_perms(BlockDriverState *bs, BdrvChild *c,
-- 
2.25.4


