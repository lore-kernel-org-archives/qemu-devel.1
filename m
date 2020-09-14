Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320C7C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC58A216C4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vmj/WpXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC58A216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHona-0007Tc-Mr
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 09:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kHokj-0002dR-CS
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:42:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59910
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kHokf-00035t-Of
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600090956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DNF5p4z28QeaG1x2EHLQbdMaA+dic2WIodXw1q9aFQc=;
 b=Vmj/WpXf/OpiHZuiZ/vURb91EgCjQ6x6fmBDZBuRcxJ2tZns+8hd/AUZkgdXdUIdlmwdon
 bsOGYqcEwPfh4/CPQYWg/5DQiFJfl2zo/dVyoZ9zp4rRYFFzpSkBIN17pv0WN5tUkduEQr
 lERpnpDOMeCMg30ezpMlAZ5+BnYknn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-0FHz_ex0MOqV-c5rpCRedg-1; Mon, 14 Sep 2020 09:42:35 -0400
X-MC-Unique: 0FHz_ex0MOqV-c5rpCRedg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DD65425CD
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 13:42:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B7A5360BE2;
 Mon, 14 Sep 2020 13:42:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D3E7931FC1; Mon, 14 Sep 2020 15:42:24 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/6] virtio-gpu: build modular
Date: Mon, 14 Sep 2020 15:42:24 +0200
Message-Id: <20200914134224.29769-7-kraxel@redhat.com>
In-Reply-To: <20200914134224.29769-1-kraxel@redhat.com>
References: <20200914134224.29769-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 01:39:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only build virtio-gpu-device modular (the code which actually depends on
the external virglrenderer library).  virtio-gpu-pci and virtio-vga are
compiled into core qemu still.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 util/module.c          |  2 ++
 hw/display/meson.build | 22 ++++++----------------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/util/module.c b/util/module.c
index 6e63006a8fb2..34772e7d87eb 100644
--- a/util/module.c
+++ b/util/module.c
@@ -265,6 +265,8 @@ static struct {
     { "usb-redir",             "hw-", "usb-redirect"          },
     { "qxl-vga",               "hw-", "display-qxl"           },
     { "qxl",                   "hw-", "display-qxl"           },
+    { "virtio-gpu-device",     "hw-", "display-virtio-gpu"    },
+    { "vhost-user-gpu",        "hw-", "display-virtio-gpu"    },
     { "chardev-braille",       "chardev-", "baum"             },
 };
 
diff --git a/hw/display/meson.build b/hw/display/meson.build
index 2f07d427ddc8..0d5ddecd6503 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -59,24 +59,14 @@ if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
   virtio_gpu_ss.add(when: 'CONFIG_VIRTIO_GPU',
                     if_true: [files('virtio-gpu-base.c', 'virtio-gpu.c', 'virtio-gpu-3d.c'), pixman, virgl])
   virtio_gpu_ss.add(when: 'CONFIG_VHOST_USER_GPU', if_true: files('vhost-user-gpu.c'))
-  virtio_gpu_ss.add(when: ['CONFIG_VIRTIO_GPU', 'CONFIG_VIRTIO_PCI'], if_true: files('virtio-gpu-pci.c'))
-  virtio_gpu_ss.add(when: ['CONFIG_VHOST_USER_GPU', 'CONFIG_VIRTIO_PCI'], if_true: files('vhost-user-gpu-pci.c'))
-  virtio_gpu_ss.add(when: 'CONFIG_VIRTIO_VGA', if_true: files('virtio-vga.c'))
-  virtio_gpu_ss.add(when: 'CONFIG_VHOST_USER_VGA', if_true: files('vhost-user-vga.c'))
-
-  # FIXME: this was attempted in the Makefile build system; it was then reverted
-  # as it would try to load all devices when the module is loaded, even if
-  # config_devices for this target only has some of them.  Since virtio-gpu-pci
-  # and virtio-vga both instantiate a virtio-gpu-device, fixing it probably does
-  # not even require a dependency system, just splitting the module in three
-  # for CONFIG_VIRTIO_GPU/CONFIG_VHOST_USER_GPU, CONFIG_VIRTIO_PCI and
-  # CONFIG_VIRTIO_VGA/CONFIG_VHOST_USER_VGA.
-  # Sourcesets are a dime a dozen, so keep it and just disable module builds.
-
-  #hw_display_modules += {'virtio-gpu': virtio_gpu_ss}
-  softmmu_ss.add_all(virtio_gpu_ss)
+  hw_display_modules += {'virtio-gpu': virtio_gpu_ss}
 endif
 
+softmmu_ss.add(when: ['CONFIG_VIRTIO_GPU', 'CONFIG_VIRTIO_PCI'], if_true: files('virtio-gpu-pci.c'))
+softmmu_ss.add(when: ['CONFIG_VHOST_USER_GPU', 'CONFIG_VIRTIO_PCI'], if_true: files('vhost-user-gpu-pci.c'))
+softmmu_ss.add(when: 'CONFIG_VIRTIO_VGA', if_true: files('virtio-vga.c'))
+softmmu_ss.add(when: 'CONFIG_VHOST_USER_VGA', if_true: files('vhost-user-vga.c'))
+
 specific_ss.add(when: [x11, opengl, 'CONFIG_MILKYMIST_TMU2'], if_true: files('milkymist-tmu2.c'))
 specific_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_lcdc.c'))
 
-- 
2.27.0


