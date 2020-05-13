Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020CDC2D0FA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:19:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0D2E206E5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKzE0WXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D2E206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYpQ0-00070u-TB
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpEA-0002rB-3d
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:07:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32909
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpE8-0003el-1i
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589368023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fEL3k9dm+4F5cWdHNM717uGXC7EmxEqmw2Jwdgt49xc=;
 b=SKzE0WXpPW1XeyGBLRgUPIU4h4spJU0MBx3ttHDmU3dYBupRV8qvNR0H36WIYCbIk4AcuF
 w/ZPq2ZHtKgMGjx8GkxnZdt3qn7r27s/NFn5GrjRDFfOPGQM2WZc45JLUm8zYfbbC9s9j+
 iqsDLdKnU1PfQidm0PtwCbv/da+9Q6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-uxJIcaBXM0GOxAovbq6WsQ-1; Wed, 13 May 2020 07:07:01 -0400
X-MC-Unique: uxJIcaBXM0GOxAovbq6WsQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C638C1009600;
 Wed, 13 May 2020 11:07:00 +0000 (UTC)
Received: from localhost (unknown [10.40.193.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CC8E60C05;
 Wed, 13 May 2020 11:07:00 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 28/34] tests: Use child_of_bds instead of child_file
Date: Wed, 13 May 2020 13:05:38 +0200
Message-Id: <20200513110544.176672-29-mreitz@redhat.com>
In-Reply-To: <20200513110544.176672-1-mreitz@redhat.com>
References: <20200513110544.176672-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/test-bdrv-drain.c     | 29 +++++++++++++++++------------
 tests/test-bdrv-graph-mod.c |  6 ++++--
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 15393a0140..91567ca97d 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -97,7 +97,7 @@ static void bdrv_test_child_perm(BlockDriverState *bs, BdrvChild *c,
      * detach_by_driver_cb_parent as one of them.
      */
     if (child_class != &child_file && child_class != &child_of_bds) {
-        child_class = &child_file;
+        child_class = &child_of_bds;
     }
 
     bdrv_format_default_perms(bs, c, child_class, role, reopen_queue,
@@ -1203,7 +1203,8 @@ static void do_test_delete_by_drain(bool detach_instead_of_delete,
 
     null_bs = bdrv_open("null-co://", NULL, NULL, BDRV_O_RDWR | BDRV_O_PROTOCOL,
                         &error_abort);
-    bdrv_attach_child(bs, null_bs, "null-child", &child_file, 0, &error_abort);
+    bdrv_attach_child(bs, null_bs, "null-child", &child_of_bds,
+                      BDRV_CHILD_DATA, &error_abort);
 
     /* This child will be the one to pass to requests through to, and
      * it will stall until a drain occurs */
@@ -1211,14 +1212,17 @@ static void do_test_delete_by_drain(bool detach_instead_of_delete,
                                     &error_abort);
     child_bs->total_sectors = 65536 >> BDRV_SECTOR_BITS;
     /* Takes our reference to child_bs */
-    tts->wait_child = bdrv_attach_child(bs, child_bs, "wait-child", &child_file,
-                                        0, &error_abort);
+    tts->wait_child = bdrv_attach_child(bs, child_bs, "wait-child",
+                                        &child_of_bds,
+                                        BDRV_CHILD_DATA | BDRV_CHILD_PRIMARY,
+                                        &error_abort);
 
     /* This child is just there to be deleted
      * (for detach_instead_of_delete == true) */
     null_bs = bdrv_open("null-co://", NULL, NULL, BDRV_O_RDWR | BDRV_O_PROTOCOL,
                         &error_abort);
-    bdrv_attach_child(bs, null_bs, "null-child", &child_file, 0, &error_abort);
+    bdrv_attach_child(bs, null_bs, "null-child", &child_of_bds, BDRV_CHILD_DATA,
+                      &error_abort);
 
     blk = blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL);
     blk_insert_bs(blk, bs, &error_abort);
@@ -1315,7 +1319,8 @@ static void detach_indirect_bh(void *opaque)
 
     bdrv_ref(data->c);
     data->child_c = bdrv_attach_child(data->parent_b, data->c, "PB-C",
-                                      &child_file, 0, &error_abort);
+                                      &child_of_bds, BDRV_CHILD_DATA,
+                                      &error_abort);
 }
 
 static void detach_by_parent_aio_cb(void *opaque, int ret)
@@ -1332,7 +1337,7 @@ static void detach_by_driver_cb_drained_begin(BdrvChild *child)
 {
     aio_bh_schedule_oneshot(qemu_get_current_aio_context(),
                             detach_indirect_bh, &detach_by_parent_data);
-    child_file.drained_begin(child);
+    child_of_bds.drained_begin(child);
 }
 
 static BdrvChildClass detach_by_driver_cb_class;
@@ -1367,7 +1372,7 @@ static void test_detach_indirect(bool by_parent_cb)
     QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, NULL, 0);
 
     if (!by_parent_cb) {
-        detach_by_driver_cb_class = child_file;
+        detach_by_driver_cb_class = child_of_bds;
         detach_by_driver_cb_class.drained_begin =
             detach_by_driver_cb_drained_begin;
     }
@@ -1397,15 +1402,15 @@ static void test_detach_indirect(bool by_parent_cb)
     /* Set child relationships */
     bdrv_ref(b);
     bdrv_ref(a);
-    child_b = bdrv_attach_child(parent_b, b, "PB-B", &child_file, 0,
-                                &error_abort);
+    child_b = bdrv_attach_child(parent_b, b, "PB-B", &child_of_bds,
+                                BDRV_CHILD_DATA, &error_abort);
     child_a = bdrv_attach_child(parent_b, a, "PB-A", &child_of_bds,
                                 BDRV_CHILD_COW, &error_abort);
 
     bdrv_ref(a);
     bdrv_attach_child(parent_a, a, "PA-A",
-                      by_parent_cb ? &child_file : &detach_by_driver_cb_class,
-                      0, &error_abort);
+                      by_parent_cb ? &child_of_bds : &detach_by_driver_cb_class,
+                      BDRV_CHILD_DATA, &error_abort);
 
     g_assert_cmpint(parent_a->refcnt, ==, 1);
     g_assert_cmpint(parent_b->refcnt, ==, 1);
diff --git a/tests/test-bdrv-graph-mod.c b/tests/test-bdrv-graph-mod.c
index 3707e2533c..6ae91ff171 100644
--- a/tests/test-bdrv-graph-mod.c
+++ b/tests/test-bdrv-graph-mod.c
@@ -112,7 +112,8 @@ static void test_update_perm_tree(void)
 
     blk_insert_bs(root, bs, &error_abort);
 
-    bdrv_attach_child(filter, bs, "child", &child_file, 0, &error_abort);
+    bdrv_attach_child(filter, bs, "child", &child_of_bds,
+                      BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY, &error_abort);
 
     bdrv_append(filter, bs, &local_err);
 
@@ -178,7 +179,8 @@ static void test_should_update_child(void)
     bdrv_set_backing_hd(target, bs, &error_abort);
 
     g_assert(target->backing->bs == bs);
-    bdrv_attach_child(filter, target, "target", &child_file, 0, &error_abort);
+    bdrv_attach_child(filter, target, "target", &child_of_bds,
+                      BDRV_CHILD_DATA, &error_abort);
     bdrv_append(filter, bs, &error_abort);
     g_assert(target->backing->bs == bs);
 
-- 
2.26.2


