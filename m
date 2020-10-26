Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4A5C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:29:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4490920878
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YL/3dt5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4490920878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX3VN-0003Gh-Ss
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kX3Uf-0002Lz-7l
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:29:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53404)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kX3Uc-0007dn-RT
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603722541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kj7AZndJJ18iktbCsEy3FROXPYqgmVC4RUU1x5JUT/Y=;
 b=YL/3dt5p7GCjypIJVVRhWcUOl0kJsAfa6inugr2Au5FtFA9ec5/dmdBjlVhmU2M5T8D2qj
 VmHixqZtzE3CaSqAo8VcPztKQkgZhQw1WKmFhBy5zSuXk2amYKJPSOyw+MpntXi33Kqc+v
 Mfi6yoKckKqVzZaQZ7UWLctCWR2S0Ys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-oZzWnJMUMDu1ouv0g00dJQ-1; Mon, 26 Oct 2020 10:28:59 -0400
X-MC-Unique: oZzWnJMUMDu1ouv0g00dJQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D4341016CE0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 14:28:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E811E5D9E4;
 Mon, 26 Oct 2020 14:28:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0CB9D11AB5; Mon, 26 Oct 2020 15:28:51 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] virtio-gpu: only compile virtio-gpu-3d.c for CONFIG_VIRGL=y
Date: Mon, 26 Oct 2020 15:28:51 +0100
Message-Id: <20201026142851.28735-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no actual code in the CONFIG_VIRGL=n case.  So building is
(a) pointless and (b) makes macos ranlib complain.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/virtio-gpu-3d.c | 4 ----
 hw/display/meson.build     | 4 +++-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index 1bd33d7aedc6..0b0c11474dd3 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -17,8 +17,6 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-gpu.h"
 
-#ifdef CONFIG_VIRGL
-
 #include <virglrenderer.h>
 
 static struct virgl_renderer_callbacks virtio_gpu_3d_cbs;
@@ -633,5 +631,3 @@ int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
 
     return capset2_max_ver ? 2 : 1;
 }
-
-#endif /* CONFIG_VIRGL */
diff --git a/hw/display/meson.build b/hw/display/meson.build
index 0d5ddecd6503..5906b96b830e 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -57,7 +57,9 @@ softmmu_ss.add(when: [pixman, 'CONFIG_ATI_VGA'], if_true: files('ati.c', 'ati_2d
 if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
   virtio_gpu_ss = ss.source_set()
   virtio_gpu_ss.add(when: 'CONFIG_VIRTIO_GPU',
-                    if_true: [files('virtio-gpu-base.c', 'virtio-gpu.c', 'virtio-gpu-3d.c'), pixman, virgl])
+                    if_true: [files('virtio-gpu-base.c', 'virtio-gpu.c'), pixman, virgl])
+  virtio_gpu_ss.add(when: ['CONFIG_VIRTIO_GPU', 'CONFIG_VIRGL'],
+                    if_true: [files('virtio-gpu-3d.c'), pixman, virgl])
   virtio_gpu_ss.add(when: 'CONFIG_VHOST_USER_GPU', if_true: files('vhost-user-gpu.c'))
   hw_display_modules += {'virtio-gpu': virtio_gpu_ss}
 endif
-- 
2.27.0


