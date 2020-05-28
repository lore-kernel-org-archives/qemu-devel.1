Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EAAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:47:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78A06207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHh7nNcw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A06207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeKkP-0007Eo-Lr
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 11:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jeKbw-0004CE-TH
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:38:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41462
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jeKbw-000416-3l
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590680302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=azQnLQ1i1iyF2ictkgxkew2ELybC3QNbZ2FtOoUwk78=;
 b=SHh7nNcwihrohUbjpZyBLcTN6aGu1OJkl3gU4nuSH0yoeR8JcL0YqrItALCwkH6EtsGOyN
 eDB9LrmzcPr09sWzYdDo6OAHLwPkNn514ya0lW+6/hyCubwebQOqwmZnJegaQjDJnIMkWZ
 NB6Pkq8IxtfVM0ThlsgJ7m2db74iYAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-pB2zTdvZOiu_UG-nw35fkw-1; Thu, 28 May 2020 11:38:21 -0400
X-MC-Unique: pB2zTdvZOiu_UG-nw35fkw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F134080572F;
 Thu, 28 May 2020 15:38:19 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-117.ams2.redhat.com
 [10.36.114.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D2BC10013D0;
 Thu, 28 May 2020 15:38:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 12/12] block: Convert 'block_resize' to coroutine
Date: Thu, 28 May 2020 17:37:42 +0200
Message-Id: <20200528153742.274164-13-kwolf@redhat.com>
In-Reply-To: <20200528153742.274164-1-kwolf@redhat.com>
References: <20200528153742.274164-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 01:51:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, marcandre.lureau@gmail.com, armbru@redhat.com,
 qemu-devel@nongnu.org
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
 blockdev.c           | 13 ++++++-------
 hmp-commands.hx      |  1 +
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 6fbacddab2..a6003d8a92 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1291,7 +1291,8 @@
 { 'command': 'block_resize',
   'data': { '*device': 'str',
             '*node-name': 'str',
-            'size': 'int' } }
+            'size': 'int' },
+  'coroutine': true }
 
 ##
 # @NewImageMode:
diff --git a/blockdev.c b/blockdev.c
index 72df193ca7..9b9287b5d6 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2410,14 +2410,14 @@ BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *node,
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
@@ -2427,8 +2427,7 @@ void qmp_block_resize(bool has_device, const char *device,
         return;
     }
 
-    aio_context = bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
+    old_ctx = bdrv_co_move_to_aio_context(bs);
 
     if (size < 0) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "size", "a >0 size");
@@ -2450,8 +2449,8 @@ void qmp_block_resize(bool has_device, const char *device,
     bdrv_drained_end(bs);
 
 out:
+    aio_co_reschedule_self(old_ctx);
     blk_unref(blk);
-    aio_context_release(aio_context);
 }
 
 void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 7f0f3974ad..4e56fe08ca 100644
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


