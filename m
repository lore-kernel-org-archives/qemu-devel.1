Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485D4C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 11:15:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B05B20756
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 11:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fG848nm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B05B20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY5u7-0000eP-Fb
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 07:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kY5or-0004La-4w
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 07:10:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kY5on-0007hG-Sz
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 07:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603969807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=blvAeadQEj5T+rSb+VOay4hehN/8U9jU+0z8C9GxjC4=;
 b=fG848nm4tVKCntpelrYwt9TupRem1Q94INJUJPHC9mU+WQBYYq7M903rjfoG1VMvEhneWS
 tvq0Ns4MGn3awRghSJ0Vth42WLTct2HHpBaNdtf1BxBTCl0E5++xbg/Huqjv+cekP6c2eU
 RKnFgDgzqklvedli0meb7PfDVJhDRWQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-Z7louZC3NCGBdecLIWz6_w-1; Thu, 29 Oct 2020 07:10:05 -0400
X-MC-Unique: Z7louZC3NCGBdecLIWz6_w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABBE557039
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 11:10:04 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 194671975E;
 Thu, 29 Oct 2020 11:09:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4E06D9D0D; Thu, 29 Oct 2020 12:09:57 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/5] virtio-gpu: add virtio-vga module
Date: Thu, 29 Oct 2020 12:09:54 +0100
Message-Id: <20201029110957.11062-3-kraxel@redhat.com>
In-Reply-To: <20201029110957.11062-1-kraxel@redhat.com>
References: <20201029110957.11062-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Build virtio-gpu vga devices modular.  Must be a separate module because
not all qemu softmmu variants come with VGA support.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20201023064618.21409-3-kraxel@redhat.com
---
 util/module.c          |  3 +++
 hw/display/meson.build | 10 ++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/util/module.c b/util/module.c
index 9490f975d303..503c399421c5 100644
--- a/util/module.c
+++ b/util/module.c
@@ -304,6 +304,9 @@ static struct {
     { "virtio-gpu-pci-base",   "hw-", "display-virtio-gpu-pci" },
     { "virtio-gpu-pci",        "hw-", "display-virtio-gpu-pci" },
     { "vhost-user-gpu-pci",    "hw-", "display-virtio-gpu-pci" },
+    { "virtio-vga-base",       "hw-", "display-virtio-vga"    },
+    { "virtio-vga",            "hw-", "display-virtio-vga"    },
+    { "vhost-user-vga",        "hw-", "display-virtio-vga"    },
     { "chardev-braille",       "chardev-", "baum"             },
     { "chardev-spicevmc",      "chardev-", "spice"            },
     { "chardev-spiceport",     "chardev-", "spice"            },
diff --git a/hw/display/meson.build b/hw/display/meson.build
index 669935371335..11ea2895c5fe 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -71,8 +71,14 @@ if config_all_devices.has_key('CONFIG_VIRTIO_PCI')
   hw_display_modules += {'virtio-gpu-pci': virtio_gpu_pci_ss}
 endif
 
-softmmu_ss.add(when: 'CONFIG_VIRTIO_VGA', if_true: files('virtio-vga.c'))
-softmmu_ss.add(when: 'CONFIG_VHOST_USER_VGA', if_true: files('vhost-user-vga.c'))
+if config_all_devices.has_key('CONFIG_VIRTIO_VGA')
+  virtio_vga_ss = ss.source_set()
+  virtio_vga_ss.add(when: 'CONFIG_VIRTIO_VGA',
+                    if_true: [files('virtio-vga.c'), pixman])
+  virtio_vga_ss.add(when: 'CONFIG_VHOST_USER_VGA',
+                    if_true: files('vhost-user-vga.c'))
+  hw_display_modules += {'virtio-vga': virtio_vga_ss}
+endif
 
 specific_ss.add(when: [x11, opengl, 'CONFIG_MILKYMIST_TMU2'], if_true: files('milkymist-tmu2.c'))
 specific_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_lcdc.c'))
-- 
2.27.0


