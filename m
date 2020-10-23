Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88542C5517A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 06:47:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB8B8208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 06:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MeFWehFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8B8208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVqrL-0008I1-MO
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 02:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVqqM-0007RO-68
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 02:46:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVqqJ-0003kl-La
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 02:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603435585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=so4qs9Y46bTEtd3Tx3ZyB2EH9v3bjFsW7359+B82H8U=;
 b=MeFWehFeHg+gu+Ej4e6h5ff+rCt+WOJvNK0UigbTT+pVqM7iHwp11Q0kmdRBwoGl8z3Gx8
 OXeutqpTBq1iMoWcgD5GGcY3k5o1v3uTMwMqE5jfAJ5QxjA6c5XWxpkSE+Cf/J2rzfm+pn
 qaNTjJbNdzUOGL7UOzeX0Jkfxr5oQXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-a1-ZrUzHP3iDR0OwYQAOiA-1; Fri, 23 Oct 2020 02:46:23 -0400
X-MC-Unique: a1-ZrUzHP3iDR0OwYQAOiA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B62F3188C126
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 06:46:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0AF3B60C84;
 Fri, 23 Oct 2020 06:46:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 246C3A1EE; Fri, 23 Oct 2020 08:46:18 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] virtio-gpu: add virtio-gpu-pci module
Date: Fri, 23 Oct 2020 08:46:17 +0200
Message-Id: <20201023064618.21409-2-kraxel@redhat.com>
In-Reply-To: <20201023064618.21409-1-kraxel@redhat.com>
References: <20201023064618.21409-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Build virtio-gpu pci devices modular.  Must be a separate module because
not all qemu softmmu variants come with PCI support.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 util/module.c          |  3 +++
 hw/display/meson.build | 11 +++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/util/module.c b/util/module.c
index fe3b82dd4d37..9490f975d303 100644
--- a/util/module.c
+++ b/util/module.c
@@ -301,6 +301,9 @@ static struct {
     { "qxl",                   "hw-", "display-qxl"           },
     { "virtio-gpu-device",     "hw-", "display-virtio-gpu"    },
     { "vhost-user-gpu",        "hw-", "display-virtio-gpu"    },
+    { "virtio-gpu-pci-base",   "hw-", "display-virtio-gpu-pci" },
+    { "virtio-gpu-pci",        "hw-", "display-virtio-gpu-pci" },
+    { "vhost-user-gpu-pci",    "hw-", "display-virtio-gpu-pci" },
     { "chardev-braille",       "chardev-", "baum"             },
     { "chardev-spicevmc",      "chardev-", "spice"            },
     { "chardev-spiceport",     "chardev-", "spice"            },
diff --git a/hw/display/meson.build b/hw/display/meson.build
index 0d5ddecd6503..669935371335 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -62,8 +62,15 @@ if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
   hw_display_modules += {'virtio-gpu': virtio_gpu_ss}
 endif
 
-softmmu_ss.add(when: ['CONFIG_VIRTIO_GPU', 'CONFIG_VIRTIO_PCI'], if_true: files('virtio-gpu-pci.c'))
-softmmu_ss.add(when: ['CONFIG_VHOST_USER_GPU', 'CONFIG_VIRTIO_PCI'], if_true: files('vhost-user-gpu-pci.c'))
+if config_all_devices.has_key('CONFIG_VIRTIO_PCI')
+  virtio_gpu_pci_ss = ss.source_set()
+  virtio_gpu_pci_ss.add(when: ['CONFIG_VIRTIO_GPU', 'CONFIG_VIRTIO_PCI'],
+                        if_true: [files('virtio-gpu-pci.c'), pixman])
+  virtio_gpu_pci_ss.add(when: ['CONFIG_VHOST_USER_GPU', 'CONFIG_VIRTIO_PCI'],
+                        if_true: files('vhost-user-gpu-pci.c'))
+  hw_display_modules += {'virtio-gpu-pci': virtio_gpu_pci_ss}
+endif
+
 softmmu_ss.add(when: 'CONFIG_VIRTIO_VGA', if_true: files('virtio-vga.c'))
 softmmu_ss.add(when: 'CONFIG_VHOST_USER_VGA', if_true: files('vhost-user-vga.c'))
 
-- 
2.27.0


