Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A29C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 09:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210BE2067B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 09:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbxmGq6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210BE2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgPmI-0002A3-B4
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 05:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jgPla-0000ju-K0
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 05:32:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40918
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jgPlZ-0007zf-Cn
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 05:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591176775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1iUdiZJpEX3lon84Q5YiPusCWhIjyJg4I48QM9lLous=;
 b=JbxmGq6tcVpUNcQ2fCmnQOOa12kqrjcByn2Et4hsRMf+nHjirnx79MIe4hywthQLSEWctK
 Tl45slRIG3uICc85kWO/cVWWWbaU56R+iMM6Ye9/KqdeECXsI1OF4B3b+S4AdGVfHYBjvc
 FKuxTF41MXppeNygQux3z/ygx0MQr5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-11PEysy5MhmsDXvTAos8eg-1; Wed, 03 Jun 2020 05:32:54 -0400
X-MC-Unique: 11PEysy5MhmsDXvTAos8eg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43EE8107ACCD;
 Wed,  3 Jun 2020 09:32:53 +0000 (UTC)
Received: from dritchie.redhat.com (ovpn-112-109.rdu2.redhat.com
 [10.10.112.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 771045C5D9;
 Wed,  3 Jun 2020 09:32:51 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] virtio-blk: Refactor the code that processes queued
 requests
Date: Wed,  3 Jun 2020 11:32:39 +0200
Message-Id: <20200603093240.40489-2-slp@redhat.com>
In-Reply-To: <20200603093240.40489-1-slp@redhat.com>
References: <20200603093240.40489-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=slp@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 23:55:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Sergio Lopez <slp@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the code that processes queued requests from
virtio_blk_dma_restart_bh() to its own, non-static, function. This
will allow us to call it from the virtio_blk_data_plane_start() in a
future patch.

Signed-off-by: Sergio Lopez <slp@redhat.com>
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
2.26.2


