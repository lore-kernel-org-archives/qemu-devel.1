Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1993FC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC63522B47
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ub8pB9WB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC63522B47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gym-0002y5-2e
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gJu-0001qv-Az
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:41:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gJs-0006nk-CT
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597675263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bdZIMAMnoqGyH9qLhE37JTAtwVaZ5pf9xbmcPjCZVHk=;
 b=Ub8pB9WBucXSP7NwJzyaNBzUMbjvmtBNynDM2dkrTiMNEgu1bDGw+BYQf9Djqn6f692P98
 T6hrNg4HF0lb6XFMuIqu1FWSfa5WNyKrMFRzNJaEsJ1FZ2K55hedKVPfBFLIeTJeg0g9k6
 YuRl/vbBR+jMVtlmiaVZmVm4+GGSaLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-jUQ2O1mTM6OzCS_gQetuEw-1; Mon, 17 Aug 2020 10:41:01 -0400
X-MC-Unique: jUQ2O1mTM6OzCS_gQetuEw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25B02185E525
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 14:41:01 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50CB570C3D;
 Mon, 17 Aug 2020 14:41:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 099/150] meson: convert hw/scsi
Date: Mon, 17 Aug 2020 16:40:02 +0200
Message-Id: <20200817144053.345107-4-pbonzini@redhat.com>
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 01:24:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Makefile.objs      |  1 -
 hw/meson.build        |  1 +
 hw/scsi/Makefile.objs | 15 ---------------
 hw/scsi/meson.build   | 26 ++++++++++++++++++++++++++
 4 files changed, 27 insertions(+), 16 deletions(-)
 delete mode 100644 hw/scsi/Makefile.objs
 create mode 100644 hw/scsi/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 6f9c0b7983..b6461c2f5e 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -24,7 +24,6 @@ devices-dirs-y += nvram/
 devices-dirs-y += pci/
 devices-dirs-$(CONFIG_PCI) += pci-bridge/ pci-host/
 devices-dirs-y += pcmcia/
-devices-dirs-$(CONFIG_SCSI) += scsi/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index a73f4aebde..d4abb67715 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -2,6 +2,7 @@ subdir('core')
 subdir('mem')
 subdir('nubus')
 subdir('rtc')
+subdir('scsi')
 subdir('sd')
 subdir('semihosting')
 subdir('smbios')
diff --git a/hw/scsi/Makefile.objs b/hw/scsi/Makefile.objs
deleted file mode 100644
index 54b36ed8b1..0000000000
--- a/hw/scsi/Makefile.objs
+++ /dev/null
@@ -1,15 +0,0 @@
-common-obj-y += scsi-disk.o emulation.o
-common-obj-y += scsi-generic.o scsi-bus.o
-common-obj-$(CONFIG_LSI_SCSI_PCI) += lsi53c895a.o
-common-obj-$(CONFIG_MPTSAS_SCSI_PCI) += mptsas.o mptconfig.o mptendian.o
-common-obj-$(CONFIG_MEGASAS_SCSI_PCI) += megasas.o
-common-obj-$(CONFIG_VMW_PVSCSI_SCSI_PCI) += vmw_pvscsi.o
-common-obj-$(CONFIG_ESP) += esp.o
-common-obj-$(CONFIG_ESP_PCI) += esp-pci.o
-obj-$(CONFIG_SPAPR_VSCSI) += spapr_vscsi.o
-
-ifeq ($(CONFIG_VIRTIO_SCSI),y)
-obj-y += virtio-scsi.o virtio-scsi-dataplane.o
-obj-$(CONFIG_VHOST_SCSI) += vhost-scsi-common.o vhost-scsi.o
-obj-$(CONFIG_VHOST_USER_SCSI) += vhost-scsi-common.o vhost-user-scsi.o
-endif
diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build
new file mode 100644
index 0000000000..923a34f344
--- /dev/null
+++ b/hw/scsi/meson.build
@@ -0,0 +1,26 @@
+scsi_ss = ss.source_set()
+scsi_ss.add(files(
+  'emulation.c',
+  'scsi-bus.c',
+  'scsi-disk.c',
+  'scsi-generic.c',
+))
+scsi_ss.add(when: 'CONFIG_ESP', if_true: files('esp.c'))
+scsi_ss.add(when: 'CONFIG_ESP_PCI', if_true: files('esp-pci.c'))
+scsi_ss.add(when: 'CONFIG_LSI_SCSI_PCI', if_true: files('lsi53c895a.c'))
+scsi_ss.add(when: 'CONFIG_MEGASAS_SCSI_PCI', if_true: files('megasas.c'))
+scsi_ss.add(when: 'CONFIG_MPTSAS_SCSI_PCI', if_true: files('mptsas.c', 'mptconfig.c', 'mptendian.c'))
+scsi_ss.add(when: 'CONFIG_VMW_PVSCSI_SCSI_PCI', if_true: files('vmw_pvscsi.c'))
+softmmu_ss.add_all(when: 'CONFIG_SCSI', if_true: scsi_ss)
+
+specific_scsi_ss = ss.source_set()
+
+virtio_scsi_ss = ss.source_set()
+virtio_scsi_ss.add(files('virtio-scsi.c', 'virtio-scsi-dataplane.c'))
+virtio_scsi_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi-common.c', 'vhost-scsi.c'))
+virtio_scsi_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: files('vhost-scsi-common.c', 'vhost-user-scsi.c'))
+specific_scsi_ss.add_all(when: 'CONFIG_VIRTIO_SCSI', if_true: virtio_scsi_ss)
+
+specific_scsi_ss.add(when: 'CONFIG_SPAPR_VSCSI', if_true: files('spapr_vscsi.c'))
+
+specific_ss.add_all(when: 'CONFIG_SCSI', if_true: specific_scsi_ss)
-- 
2.26.2



