Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22BEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:52:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664E32073E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVybmmzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664E32073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZQv-0000iu-HH
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 10:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZNY-0002o8-WB
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54942
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZNR-0001dQ-OJ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592405360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MS76N2qGEoEBGWY9Y1mZmvMCgv+GQMKggv6OjvNYR5M=;
 b=cVybmmzsCRXsFzvN4aRWtHLgwy3IcD6YK2IXd71dt++n6RPnC1SNWHzj39GXFKeu+u/HQt
 w8ldVqt53lkVYsHWEL1GR86aQb2oNZG4Hux430wcTo3++w1IFunEX/GcHPbgTtYP1xo11p
 7p90bDhQC7yJytH/Ji4XKd9006qOIaY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-00nl0N0MMNSWHxExF1wgNQ-1; Wed, 17 Jun 2020 10:49:18 -0400
X-MC-Unique: 00nl0N0MMNSWHxExF1wgNQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D7FC134D3;
 Wed, 17 Jun 2020 14:49:17 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-44.ams2.redhat.com [10.36.114.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 760207CAA0;
 Wed, 17 Jun 2020 14:49:16 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 03/43] virtio-blk: Refactor the code that processes queued
 requests
Date: Wed, 17 Jun 2020 16:48:29 +0200
Message-Id: <20200617144909.192176-4-kwolf@redhat.com>
In-Reply-To: <20200617144909.192176-1-kwolf@redhat.com>
References: <20200617144909.192176-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

From: Sergio Lopez <slp@redhat.com>

Move the code that processes queued requests from
virtio_blk_dma_restart_bh() to its own, non-static, function. This
will allow us to call it from the virtio_blk_data_plane_start() in a
future patch.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Message-Id: <20200603093240.40489-2-slp@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/hw/virtio/virtio-blk.h |  1 +
 hw/block/virtio-blk.c          | 16 +++++++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index 1e62f869b2..f584ad9b86 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -86,5 +86,6 @@ typedef struct MultiReqBuffer {
 } MultiReqBuffer;
 
 bool virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq);
+void virtio_blk_process_queued_requests(VirtIOBlock *s);
 
 #endif
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index f5f6fc925e..978574e4da 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -819,15 +819,11 @@ static void virtio_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
     virtio_blk_handle_output_do(s, vq);
 }
 
-static void virtio_blk_dma_restart_bh(void *opaque)
+void virtio_blk_process_queued_requests(VirtIOBlock *s)
 {
-    VirtIOBlock *s = opaque;
     VirtIOBlockReq *req = s->rq;
     MultiReqBuffer mrb = {};
 
-    qemu_bh_delete(s->bh);
-    s->bh = NULL;
-
     s->rq = NULL;
 
     aio_context_acquire(blk_get_aio_context(s->conf.conf.blk));
@@ -855,6 +851,16 @@ static void virtio_blk_dma_restart_bh(void *opaque)
     aio_context_release(blk_get_aio_context(s->conf.conf.blk));
 }
 
+static void virtio_blk_dma_restart_bh(void *opaque)
+{
+    VirtIOBlock *s = opaque;
+
+    qemu_bh_delete(s->bh);
+    s->bh = NULL;
+
+    virtio_blk_process_queued_requests(s);
+}
+
 static void virtio_blk_dma_restart_cb(void *opaque, int running,
                                       RunState state)
 {
-- 
2.25.4


