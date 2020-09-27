Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD93DC4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 15:07:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ADC023899
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 15:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdSBh/hM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADC023899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMYGT-0005IO-Fb
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 11:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kMY9A-0006om-27
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 10:59:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43929)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kMY98-0006Wl-ED
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 10:59:27 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601218765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PQD54WdAZS3iIKMslHPFTacgZs+8lfyKf4zASmwmDHo=;
 b=MdSBh/hMZbSBMDBo1ciStgazvwK4+iR7SNxBINoK2d4TzNRkLWntJsCbL3WJxM5mhp22zr
 koMX8YC/YhxHSU1WEFFzaFjaJkztNnAKo+FWSyjS+fOjhBg2hsTN3uJxd1W7Suoi+3W89T
 FKl0QucFIGWa2TqVCgYSR/ulCCbjJLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-k-zpFqQAOJ6mkyBYcCIQXg-1; Sun, 27 Sep 2020 10:59:23 -0400
X-MC-Unique: k-zpFqQAOJ6mkyBYcCIQXg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 809231DDEB;
 Sun, 27 Sep 2020 14:59:22 +0000 (UTC)
Received: from localhost (unknown [10.36.110.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F0C145D9CA;
 Sun, 27 Sep 2020 14:59:12 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH v3 6/6] virtio-gpu: set physical dimensions for EDID
Date: Sun, 27 Sep 2020 18:57:51 +0400
Message-Id: <20200927145751.365446-7-marcandre.lureau@redhat.com>
In-Reply-To: <20200927145751.365446-1-marcandre.lureau@redhat.com>
References: <20200927145751.365446-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 10:58:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.576,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: spice-devel@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-base.c   | 2 ++
 hw/display/virtio-gpu.c        | 2 ++
 include/hw/virtio/virtio-gpu.h | 1 +
 3 files changed, 5 insertions(+)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index aeb8723542..40ccd00f94 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -82,6 +82,8 @@ static int virtio_gpu_ui_info(void *opaque, uint32_t idx, QemuUIInfo *info)
     g->req_state[idx].y = info->yoff;
     g->req_state[idx].width = info->width;
     g->req_state[idx].height = info->height;
+    g->req_state[idx].width_mm = info->width_mm;
+    g->req_state[idx].height_mm = info->height_mm;
 
     if (info->width && info->height) {
         g->enabled_output_bitmask |= (1 << idx);
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 90be4e3ed7..f3b71fa9c7 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -212,6 +212,8 @@ virtio_gpu_generate_edid(VirtIOGPU *g, int scanout,
 {
     VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
     qemu_edid_info info = {
+        .width_mm = b->req_state[scanout].width_mm,
+        .height_mm = b->req_state[scanout].height_mm,
         .prefx = b->req_state[scanout].width,
         .prefy = b->req_state[scanout].height,
     };
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 455e0a7433..1aed7275c8 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -62,6 +62,7 @@ struct virtio_gpu_scanout {
 };
 
 struct virtio_gpu_requested_state {
+    uint16_t width_mm, height_mm;
     uint32_t width, height;
     int x, y;
 };
-- 
2.26.2


