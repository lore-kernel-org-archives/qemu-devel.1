Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F16EC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E21BD20756
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Daa8pLiG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21BD20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPTRF-0004B0-Pr
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kPSu1-00017M-V3
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:59:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43310)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kPSts-0002Dj-BO
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601913583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V9hwa2yuNNhm7HvvUUGAyuEeEh3K20UpOiE4l0Q9puU=;
 b=Daa8pLiG3X2hb1nN3H/worpYJvTfRIgdVKNVIZfXTOjJi3zVCe1dR7Y28XCUjjxcSNvhnT
 JlBE+nVKT1gCZSl6VoNGQ2ZyI+9tFtsjfVxFE+qQyAP8EqQnQyq49vs2dHIDSF80oqRIui
 s8l9WI35JzXXskYNdThdco2INfEgb7k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-26B9wRJjNJ-F6OiPIRa3EQ-1; Mon, 05 Oct 2020 11:59:40 -0400
X-MC-Unique: 26B9wRJjNJ-F6OiPIRa3EQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74C8DAE820;
 Mon,  5 Oct 2020 15:59:39 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-145.ams2.redhat.com
 [10.36.113.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EFD5860C11;
 Mon,  5 Oct 2020 15:59:37 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v8 14/14] block: Convert 'block_resize' to coroutine
Date: Mon,  5 Oct 2020 17:58:55 +0200
Message-Id: <20201005155855.256490-15-kwolf@redhat.com>
In-Reply-To: <20201005155855.256490-1-kwolf@redhat.com>
References: <20201005155855.256490-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, marcandre.lureau@gmail.com, armbru@redhat.com,
 stefanha@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

block_resize performs some I/O that could potentially take quite some
time, so use it as an example for the new 'coroutine': true annotation
in the QAPI schema.

bdrv_truncate() requires that we're already in the right AioContext for
the BlockDriverState if called in coroutine context. So instead of just
taking the AioContext lock, move the QMP handler coroutine to the
context.

Call blk_unref() only after switching back because blk_unref() may only
be called in the main thread.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json |  3 ++-
 blockdev.c           | 16 ++++++++--------
 hmp-commands.hx      |  1 +
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 12a24772b5..90383b0148 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1304,7 +1304,8 @@
 { 'command': 'block_resize',
   'data': { '*device': 'str',
             '*node-name': 'str',
-            'size': 'int' } }
+            'size': 'int' },
+  'coroutine': true }
 
 ##
 # @NewImageMode:
diff --git a/blockdev.c b/blockdev.c
index bebd3ba1c3..e331f81034 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2439,14 +2439,14 @@ BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *node,
     return ret;
 }
 
-void qmp_block_resize(bool has_device, const char *device,
-                      bool has_node_name, const char *node_name,
-                      int64_t size, Error **errp)
+void coroutine_fn qmp_block_resize(bool has_device, const char *device,
+                                   bool has_node_name, const char *node_name,
+                                   int64_t size, Error **errp)
 {
     Error *local_err = NULL;
     BlockBackend *blk = NULL;
     BlockDriverState *bs;
-    AioContext *aio_context;
+    AioContext *old_ctx;
 
     bs = bdrv_lookup_bs(has_device ? device : NULL,
                         has_node_name ? node_name : NULL,
@@ -2456,9 +2456,6 @@ void qmp_block_resize(bool has_device, const char *device,
         return;
     }
 
-    aio_context = bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
-
     if (size < 0) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "size", "a >0 size");
         goto out;
@@ -2475,12 +2472,15 @@ void qmp_block_resize(bool has_device, const char *device,
     }
 
     bdrv_drained_begin(bs);
+    old_ctx = bdrv_co_enter(bs);
     blk_truncate(blk, size, false, PREALLOC_MODE_OFF, 0, errp);
+    bdrv_co_leave(bs, old_ctx);
     bdrv_drained_end(bs);
 
 out:
+    bdrv_co_lock(bs);
     blk_unref(blk);
-    aio_context_release(aio_context);
+    bdrv_co_unlock(bs);
 }
 
 void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 1088d64503..de83a5cc61 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -76,6 +76,7 @@ ERST
         .params     = "device size",
         .help       = "resize a block image",
         .cmd        = hmp_block_resize,
+        .coroutine  = true,
     },
 
 SRST
-- 
2.25.4


