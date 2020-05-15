Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBB1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C25C20709
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMCwHWFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C25C20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZa4E-0001R4-DG
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 09:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZjK-0003BS-A2
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48138
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZjH-0002O3-F5
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U9+KdOV9yTQVEKgc0FKwq52v6OMnOO74fOmEyKdES9I=;
 b=JMCwHWFKpH9v7f1i84IOzZiZe9ExDJbmv3shJIDVcFct/yT3Qv8Yku/q6zN9jFW9alWxug
 99VkmOX0/VldTfHJHN09QoOn32BVPvqEWybASgvmN690WePf6n43ohuO8ZP4PLvEDDR4xZ
 IlxQ+qjKKBJ8Ry2q2a89G7nEUZ7h7DI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-0mXkFcOJP1-DosiQRkm7zw-1; Fri, 15 May 2020 08:46:16 -0400
X-MC-Unique: 0mXkFcOJP1-DosiQRkm7zw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74BF98018A7;
 Fri, 15 May 2020 12:46:15 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A7D02E166;
 Fri, 15 May 2020 12:46:14 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 31/51] block: Add bdrv_default_perms()
Date: Fri, 15 May 2020 14:45:01 +0200
Message-Id: <20200515124521.335403-32-kwolf@redhat.com>
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

This callback can be used by BDSs that use child_of_bds with the
appropriate BdrvChildRole for their children.

Also, make bdrv_format_default_perms() use it for child_of_bds children
(just a temporary solution until we can drop bdrv_format_default_perms()
altogether).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200513110544.176672-20-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h | 11 +++++++++++
 block.c                   | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 54df821d61..3a9dda9be7 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1288,6 +1288,17 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
 bool bdrv_recurse_can_replace(BlockDriverState *bs,
                               BlockDriverState *to_replace);
 
+/*
+ * Default implementation for BlockDriver.bdrv_child_perm() that can
+ * be used by block filters and image formats, as long as they use the
+ * child_of_bds child class and set an appropriate BdrvChildRole.
+ */
+void bdrv_default_perms(BlockDriverState *bs, BdrvChild *c,
+                        const BdrvChildClass *child_class, BdrvChildRole role,
+                        BlockReopenQueue *reopen_queue,
+                        uint64_t perm, uint64_t shared,
+                        uint64_t *nperm, uint64_t *nshared);
+
 /*
  * Default implementation for drivers to pass bdrv_co_block_status() to
  * their file.
diff --git a/block.c b/block.c
index 5ff6cbd796..088727fdbe 100644
--- a/block.c
+++ b/block.c
@@ -2596,6 +2596,13 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
                                uint64_t *nperm, uint64_t *nshared)
 {
     bool backing = (child_class == &child_backing);
+
+    if (child_class == &child_of_bds) {
+        bdrv_default_perms(bs, c, child_class, role, reopen_queue,
+                           perm, shared, nperm, nshared);
+        return;
+    }
+
     assert(child_class == &child_backing || child_class == &child_file);
 
     if (!backing) {
@@ -2607,6 +2614,31 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
     }
 }
 
+void bdrv_default_perms(BlockDriverState *bs, BdrvChild *c,
+                        const BdrvChildClass *child_class, BdrvChildRole role,
+                        BlockReopenQueue *reopen_queue,
+                        uint64_t perm, uint64_t shared,
+                        uint64_t *nperm, uint64_t *nshared)
+{
+    assert(child_class == &child_of_bds);
+
+    if (role & BDRV_CHILD_FILTERED) {
+        assert(!(role & (BDRV_CHILD_DATA | BDRV_CHILD_METADATA |
+                         BDRV_CHILD_COW)));
+        bdrv_filter_default_perms(bs, c, child_class, role, reopen_queue,
+                                  perm, shared, nperm, nshared);
+    } else if (role & BDRV_CHILD_COW) {
+        assert(!(role & (BDRV_CHILD_DATA | BDRV_CHILD_METADATA)));
+        bdrv_default_perms_for_cow(bs, c, child_class, role, reopen_queue,
+                                   perm, shared, nperm, nshared);
+    } else if (role & (BDRV_CHILD_METADATA | BDRV_CHILD_DATA)) {
+        bdrv_default_perms_for_storage(bs, c, child_class, role, reopen_queue,
+                                       perm, shared, nperm, nshared);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 uint64_t bdrv_qapi_perm_to_blk_perm(BlockPermission qapi_perm)
 {
     static const uint64_t permissions[] = {
-- 
2.25.4


