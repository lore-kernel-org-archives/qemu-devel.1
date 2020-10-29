Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B547C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 11:14:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEDC420756
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 11:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PC1e9MqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEDC420756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY5sx-0007sR-Hf
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 07:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kY5os-0004Ms-8w
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 07:10:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kY5oo-0007he-3g
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 07:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603969807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f1vOJ63AudGIsg4/hFAcXsaUPmWd1EhvZj8XVJc1Zqs=;
 b=PC1e9MqUs7LKC/B2U7EvVxThpSkcTVEiOm6wwoy0ukm+leIjg0l2HcWLUPBUu+n/T4TuHM
 QoYuS6gWL/o7xnovaKsYbBgm2cKPyMpAukP8aH9rCae97DOAP1uVSgDe4/yOTTLqXL/wfV
 b2LIBUbqVClQtqEFsrhlCeeARR4wpUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-4z6oxn5zOxiCiqwZ16oDlg-1; Thu, 29 Oct 2020 07:10:06 -0400
X-MC-Unique: 4z6oxn5zOxiCiqwZ16oDlg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 182395703D
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 11:10:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E6095C1D0;
 Thu, 29 Oct 2020 11:09:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 58AF79D0E; Thu, 29 Oct 2020 12:09:57 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] virtio-gpu: only compile virtio-gpu-3d.c for CONFIG_VIRGL=y
Date: Thu, 29 Oct 2020 12:09:55 +0100
Message-Id: <20201029110957.11062-4-kraxel@redhat.com>
In-Reply-To: <20201029110957.11062-1-kraxel@redhat.com>
References: <20201029110957.11062-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
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
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no actual code in the CONFIG_VIRGL=n case.  So building is
(a) pointless and (b) makes macos ranlib complain.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20201026142851.28735-1-kraxel@redhat.com
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
index 11ea2895c5fe..dad3bd2b414b 100644
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


