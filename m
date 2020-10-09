Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE353C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 06:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13B0A22245
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 06:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mcv7WMXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B0A22245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQmCr-0007o0-IC
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 02:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQlzJ-00020D-3j
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 02:34:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQlzG-0008Uk-Sf
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 02:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602225282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1klNddQ1EsfOTyg/MTQM8HmrEtFuJAGy9UnFoQNHaWg=;
 b=Mcv7WMXbZ/oxtdanEsQ13/A9VKL89QLR0B23xwFRoMf9CZcr6RHsXSP47HWX5+WlZA73ct
 rvg51yqdAvjuLdWPR2RufRfJWgkO8Wn/hxjdKEC/Hx9ggMfn9jxmXsHwa8iklK+ikFh0Au
 4KLup7iMH3xgzimu0qxV4TGt+AReTRQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-HxTe5YqoPGmvbPbEfoZdFA-1; Fri, 09 Oct 2020 02:34:40 -0400
X-MC-Unique: HxTe5YqoPGmvbPbEfoZdFA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4F7D80B71D
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 06:34:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7128A10013C1;
 Fri,  9 Oct 2020 06:34:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 384F11129947; Fri,  9 Oct 2020 08:34:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/14] block: Convert 'block_resize' to coroutine
Date: Fri,  9 Oct 2020 08:34:32 +0200
Message-Id: <20201009063432.303441-15-armbru@redhat.com>
In-Reply-To: <20201009063432.303441-1-armbru@redhat.com>
References: <20201009063432.303441-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

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
Message-Id: <20201005155855.256490-15-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json |  3 ++-
 blockdev.c           | 16 ++++++++--------
 hmp-commands.hx      |  1 +
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 3758ea9912..ee5ebef7f2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1310,7 +1310,8 @@
 { 'command': 'block_resize',
   'data': { '*device': 'str',
             '*node-name': 'str',
-            'size': 'int' } }
+            'size': 'int' },
+  'coroutine': true }
 
 ##
 # @NewImageMode:
diff --git a/blockdev.c b/blockdev.c
index a6ae475dac..fe6fb5dc1d 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2449,14 +2449,14 @@ BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *node,
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
@@ -2466,9 +2466,6 @@ void qmp_block_resize(bool has_device, const char *device,
         return;
     }
 
-    aio_context = bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
-
     if (size < 0) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "size", "a >0 size");
         goto out;
@@ -2485,12 +2482,15 @@ void qmp_block_resize(bool has_device, const char *device,
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
index e43ce600b8..cd068389de 100644
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
2.26.2


