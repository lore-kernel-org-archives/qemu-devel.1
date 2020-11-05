Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12CAC00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46AB12083B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KN87+4XU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AB12083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaehe-00013j-9f
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 07:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaecg-0003Rp-Gm
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 07:44:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46321)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaecd-0000q9-UN
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 07:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604580250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qnXFKvPT1o0VTR2smUlGauG0ibfVMGznfVlfrMUGLE8=;
 b=KN87+4XUdzBxpZlEsBLYqQI/vr5QO6DrlXd83AUZP6ELUYZNGIQomt0jbULh5GiQT44m6m
 F2q98FXgK8N73lOPlBeWXtREiL1oD0qc64Y8VS60D4doLJKKNBPB20brbv5agZDUKjU0FR
 /dzvK8gBzQJVp3kVk1MLi0mzQUS1faA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-yw1GPmpfOHeMT5vHWnoGCQ-1; Thu, 05 Nov 2020 07:44:09 -0500
X-MC-Unique: yw1GPmpfOHeMT5vHWnoGCQ-1
Received: by mail-wr1-f70.google.com with SMTP id t17so657286wrm.13
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 04:44:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qnXFKvPT1o0VTR2smUlGauG0ibfVMGznfVlfrMUGLE8=;
 b=DjZTSrrm2eYmbJcANQ3GrzIiiJsLvLvMyWxWAFaTqUTzhPVbEJJTYKiiGc775WDLNn
 DGniypY2KqF8tDyBEhkBiczunZXM7i4BS9WTqhOjY/l0muHWokVsDKGxbReLkBL20BCD
 /lOB5yWnVPOaaE19Cw+oW5fHcUUb8CuMoLZP2q61nedRbzs8uevBUNqzhKPFn1wrYvUr
 1RmgsAzacTlFRzx3YbXfTlTNorUd67UGPgindk4Y58QvoKhzxH6vHxuZXdwGwt+NYFIR
 2yOT/R7c8rNHXykNcFD/wv6kwZPRRrw9L9mNmxIuTm6xOWSIhGPkIPL+50BkAyRrVH4f
 eujg==
X-Gm-Message-State: AOAM533Cm/BUQuFjzw3kefypwHhmNCir6x5bzSnI0qJtvEvlNgLpdT2L
 jkuy20iitxvQRsOvCiBokjsmf3t0y/3FoTJWQ9Qcsz3FtOY8Uv0r2HbOBBDatBiLzV2IU/xBql2
 5XahSvQaoFanZl2E=
X-Received: by 2002:a1c:c912:: with SMTP id f18mr2602444wmb.150.1604580247354; 
 Thu, 05 Nov 2020 04:44:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJycMZGYAqkWvUm4ti0KNbj3uR1qWoZk8mAAoVfJIvz+XFcQUGZxVsgOrCv+hbJC5AhUxiCYWQ==
X-Received: by 2002:a1c:c912:: with SMTP id f18mr2602420wmb.150.1604580247183; 
 Thu, 05 Nov 2020 04:44:07 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id o3sm2341584wru.15.2020.11.05.04.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 04:44:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 2/3] hw/virtio: Build most of virtio devices as
 arch-independent objects
Date: Thu,  5 Nov 2020 13:43:52 +0100
Message-Id: <20201105124353.3680057-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201105124353.3680057-1-philmd@redhat.com>
References: <20201105124353.3680057-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Jagannathan Raman <jag.raman@oracle.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VirtIO devices shouldn't be arch-specific. Some device have to
use PAGE_SIZE definition or access to CPUState. Keep building
them as arch-specific objects. Move all we can to libcommon.fa.

Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/9pfs/meson.build            |  2 +-
 hw/block/dataplane/meson.build |  2 +-
 hw/block/meson.build           |  2 +-
 hw/char/meson.build            |  2 +-
 hw/net/meson.build             |  2 +-
 hw/scsi/meson.build            |  2 +-
 hw/virtio/meson.build          | 15 +++++++++------
 7 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/hw/9pfs/meson.build b/hw/9pfs/meson.build
index cc094262122..ac964be15ce 100644
--- a/hw/9pfs/meson.build
+++ b/hw/9pfs/meson.build
@@ -17,4 +17,4 @@
 fs_ss.add(when: 'CONFIG_XEN', if_true: files('xen-9p-backend.c'))
 softmmu_ss.add_all(when: 'CONFIG_9PFS', if_true: fs_ss)
 
-specific_ss.add(when: 'CONFIG_VIRTIO_9P', if_true: files('virtio-9p-device.c'))
+softmmu_ss.add(when: 'CONFIG_VIRTIO_9P', if_true: files('virtio-9p-device.c'))
diff --git a/hw/block/dataplane/meson.build b/hw/block/dataplane/meson.build
index 12c6a264f10..e2f3721ce24 100644
--- a/hw/block/dataplane/meson.build
+++ b/hw/block/dataplane/meson.build
@@ -1,2 +1,2 @@
-specific_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
+softmmu_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
 specific_ss.add(when: 'CONFIG_XEN', if_true: files('xen-block.c'))
diff --git a/hw/block/meson.build b/hw/block/meson.build
index 602ca6c8541..497592c33ac 100644
--- a/hw/block/meson.build
+++ b/hw/block/meson.build
@@ -15,7 +15,7 @@
 softmmu_ss.add(when: 'CONFIG_SH4', if_true: files('tc58128.c'))
 softmmu_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('nvme.c', 'nvme-ns.c'))
 
-specific_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
+softmmu_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
 specific_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-user-blk.c'))
 
 subdir('dataplane')
diff --git a/hw/char/meson.build b/hw/char/meson.build
index 196ac91fa29..7496594ea07 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -37,5 +37,5 @@
 
 specific_ss.add(when: 'CONFIG_HTIF', if_true: files('riscv_htif.c'))
 specific_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('terminal3270.c'))
-specific_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-serial-bus.c'))
+softmmu_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-serial-bus.c'))
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_vty.c'))
diff --git a/hw/net/meson.build b/hw/net/meson.build
index 4a7051b54a0..c795af23eee 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -43,7 +43,7 @@
 specific_ss.add(when: 'CONFIG_XILINX_ETHLITE', if_true: files('xilinx_ethlite.c'))
 
 softmmu_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('net_rx_pkt.c'))
-specific_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio-net.c'))
+softmmu_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio-net.c'))
 
 softmmu_ss.add(when: ['CONFIG_VIRTIO_NET', 'CONFIG_VHOST_NET'], if_true: files('vhost_net.c'), if_false: files('vhost_net-stub.c'))
 softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('vhost_net-stub.c'))
diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build
index 923a34f344c..fdf27156f6a 100644
--- a/hw/scsi/meson.build
+++ b/hw/scsi/meson.build
@@ -19,7 +19,7 @@
 virtio_scsi_ss.add(files('virtio-scsi.c', 'virtio-scsi-dataplane.c'))
 virtio_scsi_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi-common.c', 'vhost-scsi.c'))
 virtio_scsi_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: files('vhost-scsi-common.c', 'vhost-user-scsi.c'))
-specific_scsi_ss.add_all(when: 'CONFIG_VIRTIO_SCSI', if_true: virtio_scsi_ss)
+softmmu_ss.add_all(when: 'CONFIG_VIRTIO_SCSI', if_true: virtio_scsi_ss)
 
 specific_scsi_ss.add(when: 'CONFIG_SPAPR_VSCSI', if_true: files('spapr_vscsi.c'))
 
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 95415913a9a..40df99f1a48 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -9,12 +9,15 @@
 
 softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('vhost-stub.c'))
 
+virtio_arch_ss = ss.source_set()
+virtio_arch_ss.add(files('virtio.c'))
+virtio_arch_ss.add(when: 'CONFIG_VIRTIO_LEGACY', if_true: files('virtio-legacy.c'))
+virtio_arch_ss.add(when: 'CONFIG_VHOST_USER', if_true: files('vhost-user.c'))
+virtio_arch_ss.add(when: 'CONFIG_VHOST_VDPA', if_true: files('vhost-vdpa.c'))
+virtio_arch_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu.c'))
+
 virtio_ss = ss.source_set()
-virtio_ss.add(files('virtio.c'))
-virtio_ss.add(when: 'CONFIG_VIRTIO_LEGACY', if_true: files('virtio-legacy.c'))
 virtio_ss.add(when: 'CONFIG_VHOST', if_true: files('vhost.c', 'vhost-backend.c'))
-virtio_ss.add(when: 'CONFIG_VHOST_USER', if_true: files('vhost-user.c'))
-virtio_ss.add(when: 'CONFIG_VHOST_VDPA', if_true: files('vhost-vdpa.c'))
 virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
 virtio_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypto.c'))
 virtio_ss.add(when: ['CONFIG_VIRTIO_CRYPTO', 'CONFIG_VIRTIO_PCI'], if_true: files('virtio-crypto-pci.c'))
@@ -24,7 +27,6 @@
 virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c', 'vhost-vsock-common.c'))
 virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c', 'vhost-vsock-common.c'))
 virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
-virtio_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu.c'))
 virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
 
 virtio_pci_ss = ss.source_set()
@@ -49,4 +51,5 @@
 
 virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
 
-specific_ss.add_all(when: 'CONFIG_VIRTIO', if_true: virtio_ss)
+softmmu_ss.add_all(when: 'CONFIG_VIRTIO', if_true: virtio_ss)
+specific_ss.add_all(when: 'CONFIG_VIRTIO', if_true: virtio_arch_ss)
-- 
2.26.2


