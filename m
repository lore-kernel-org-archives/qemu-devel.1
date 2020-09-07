Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CD5C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:48:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81DA52078E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qp55bqx5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81DA52078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDl1-0003n9-Eg
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kFDkO-0002zL-D1
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:47:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24643
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kFDkM-00069T-Ko
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599472053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4nOB6sTSk6Mdgu66QngZWZe7bAkKTT0TYirvYEyHELU=;
 b=Qp55bqx5NvAXj4Zt1brT6X0ODwnZ7wmEuw+cho06v7vRP42WxwpUwUCpL7Ad96rKaAXYbV
 9mQUYToYxCrP4uOh6wsOfmLpWA+R3bCBVPHL+mAvUjWQ1KSFDkOA0is8ROz5iFPecH4//d
 VMymJzRZ5Zjyaj2PhfhoJ+QXH1K0XZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-l7VoEntjMmKMax8oTUjPiw-1; Mon, 07 Sep 2020 05:47:31 -0400
X-MC-Unique: l7VoEntjMmKMax8oTUjPiw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 805FF420EC
 for <qemu-devel@nongnu.org>; Mon,  7 Sep 2020 09:47:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C5015D9D2;
 Mon,  7 Sep 2020 09:47:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5EB9E204AE; Mon,  7 Sep 2020 11:47:26 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] virtio-gpu: build modular
Date: Mon,  7 Sep 2020 11:47:19 +0200
Message-Id: <20200907094719.12850-3-kraxel@redhat.com>
In-Reply-To: <20200907094719.12850-1-kraxel@redhat.com>
References: <20200907094719.12850-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:05:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
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
index ef8eb093acbb..a6756c25d66e 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -58,24 +58,14 @@ if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
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


