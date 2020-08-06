Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9357EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8691C2173E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORDJWVHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8691C2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3m2M-0006T2-Kb
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 15:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lQ0-00007G-Hq
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:19:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51978
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lPy-0006if-7H
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ugDcYuIzdP8Nrf8EU2dGGi9zNntTRxfmFKqcvef77l4=;
 b=ORDJWVHRmMm4SGJmz25QA7VqdaQ0heNS3ad8RmEe7UZdEbpnqLYEnazeDWzAKjaVTygW4/
 4VKcEsxHI9TTThGcg0G5ky2kb7FMWzkN2CJDO8P5AHsLLDbF+JApJP7tAv4pqudRvTD+1X
 ouhD4kfiCBrpo1RUl9U8Ql++Yhp5wuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-bb-blzDhM0epgIasAOs5-A-1; Thu, 06 Aug 2020 15:19:07 -0400
X-MC-Unique: bb-blzDhM0epgIasAOs5-A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA0BA100AA22
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:19:06 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA28469315;
 Thu,  6 Aug 2020 19:19:05 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 096/143] meson: convert hw/scsi
Date: Thu,  6 Aug 2020 21:15:32 +0200
Message-Id: <1596741379-12902-97-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
index 6f9c0b7..b6461c2 100644
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
index a73f4ae..d4abb67 100644
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
index 54b36ed..0000000
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
index 0000000..923a34f
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
1.8.3.1



