Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B29CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:14:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3EC0206E5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0JDRWqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3EC0206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYpLX-00071B-T4
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpDm-000289-4K
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:06:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24286
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpDl-0003UH-5L
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589368000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/cCGNsrswKi9vVjAGIFQzbQxW0CTU8wPQL84rQ2/j4=;
 b=f0JDRWqoTaqhzHQHf7hFXfs9Hi+dEYHa+EDDSCfTfhwGT5TNl2QBJ7KeDI3+6w1b8iqXj9
 hVI4db5AP0jd2IYGJBO4CVA75xuCp1EWjw9yT0ZHBdoGV7tpLQoEXFC0Z2VU+1ExJwGm3+
 6+Z+jnMEPhBy+83lkBMpq+Zcy2Fg6Fo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-xYK52XIgNfOJSUZdt-BIiw-1; Wed, 13 May 2020 07:06:39 -0400
X-MC-Unique: xYK52XIgNfOJSUZdt-BIiw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16A88460;
 Wed, 13 May 2020 11:06:38 +0000 (UTC)
Received: from localhost (unknown [10.40.193.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C0BA1002382;
 Wed, 13 May 2020 11:06:37 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 19/34] block: Add bdrv_default_perms()
Date: Wed, 13 May 2020 13:05:29 +0200
Message-Id: <20200513110544.176672-20-mreitz@redhat.com>
In-Reply-To: <20200513110544.176672-1-mreitz@redhat.com>
References: <20200513110544.176672-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

This callback can be used by BDSs that use child_of_bds with the
appropriate BdrvChildRole for their children.

Also, make bdrv_format_default_perms() use it for child_of_bds children
(just a temporary solution until we can drop bdrv_format_default_perms()
altogether).

Signed-off-by: Max Reitz <mreitz@redhat.com>
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
2.26.2


