Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AB9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:00:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46AD220791
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpK7/PtF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AD220791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5C6T-0005EE-Aw
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 14:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BL5-00024e-KV
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:11:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28814
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BL3-0003Dk-BC
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TVHfqnPCLyCqcH2WZnDBBpx2lGIedhtqMSXXVfAibL4=;
 b=DpK7/PtFSddG0zCfsVJmgAZcpmcIiuu/p0Bhev+UNtqvWAyVkGYZxPXTRte0BXkhDK0D/8
 z/IUvleS4FAW357mcdsDMRtEMd11MRHO4lpO6bignitJg4hg3TpOaWdEYYf6NEXL9uTPyt
 NL7XC4rIwvffNr7C9CkOVR3ZY5io8EY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-k8pzzNUzPi-D1uH147TZWw-1; Mon, 10 Aug 2020 13:11:54 -0400
X-MC-Unique: k8pzzNUzPi-D1uH147TZWw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 871EA106B242
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:11:53 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94F0E5F1E9;
 Mon, 10 Aug 2020 17:11:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 099/147] meson: convert hw/pci-host
Date: Mon, 10 Aug 2020 19:08:17 +0200
Message-Id: <1597079345-42801-100-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:31:01
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
 hw/Makefile.objs          |  2 +-
 hw/meson.build            |  1 +
 hw/pci-host/Makefile.objs | 24 ------------------------
 hw/pci-host/meson.build   | 31 +++++++++++++++++++++++++++++++
 4 files changed, 33 insertions(+), 25 deletions(-)
 delete mode 100644 hw/pci-host/Makefile.objs
 create mode 100644 hw/pci-host/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index f28da58..0038cf8 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -22,7 +22,7 @@ devices-dirs-y += net/
 devices-dirs-y += rdma/
 devices-dirs-y += nvram/
 devices-dirs-y += pci/
-devices-dirs-$(CONFIG_PCI) += pci-bridge/ pci-host/
+devices-dirs-$(CONFIG_PCI) += pci-bridge/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index ed25644..ca36e48 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,6 +1,7 @@
 subdir('core')
 subdir('mem')
 subdir('nubus')
+subdir('pci-host')
 subdir('pcmcia')
 subdir('rtc')
 subdir('scsi')
diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
deleted file mode 100644
index e422e0a..0000000
--- a/hw/pci-host/Makefile.objs
+++ /dev/null
@@ -1,24 +0,0 @@
-common-obj-$(CONFIG_PAM) += pam.o
-
-# PPC devices
-common-obj-$(CONFIG_PREP_PCI) += prep.o
-common-obj-$(CONFIG_GRACKLE_PCI) += grackle.o
-# NewWorld PowerMac
-common-obj-$(CONFIG_UNIN_PCI) += uninorth.o
-# PowerPC E500 boards
-common-obj-$(CONFIG_PPCE500_PCI) += ppce500.o
-
-# ARM devices
-common-obj-$(CONFIG_VERSATILE_PCI) += versatile.o
-
-common-obj-$(CONFIG_PCI_SABRE) += sabre.o
-common-obj-$(CONFIG_PCI_BONITO) += bonito.o
-common-obj-$(CONFIG_PCI_I440FX) += i440fx.o
-common-obj-$(CONFIG_XEN_IGD_PASSTHROUGH) += xen_igd_pt.o
-common-obj-$(CONFIG_PCI_EXPRESS_Q35) += q35.o
-common-obj-$(CONFIG_PCI_EXPRESS_GENERIC_BRIDGE) += gpex.o
-common-obj-$(CONFIG_PCI_EXPRESS_XILINX) += xilinx-pcie.o
-
-common-obj-$(CONFIG_PCI_EXPRESS_DESIGNWARE) += designware.o
-obj-$(CONFIG_POWERNV) += pnv_phb4.o pnv_phb4_pec.o
-obj-$(CONFIG_POWERNV) += pnv_phb3.o pnv_phb3_msi.o pnv_phb3_pbcq.o
diff --git a/hw/pci-host/meson.build b/hw/pci-host/meson.build
new file mode 100644
index 0000000..cd52f6f
--- /dev/null
+++ b/hw/pci-host/meson.build
@@ -0,0 +1,31 @@
+pci_ss = ss.source_set()
+pci_ss.add(when: 'CONFIG_PAM', if_true: files('pam.c'))
+pci_ss.add(when: 'CONFIG_PCI_BONITO', if_true: files('bonito.c'))
+pci_ss.add(when: 'CONFIG_PCI_EXPRESS_DESIGNWARE', if_true: files('designware.c'))
+pci_ss.add(when: 'CONFIG_PCI_EXPRESS_GENERIC_BRIDGE', if_true: files('gpex.c'))
+pci_ss.add(when: 'CONFIG_PCI_EXPRESS_Q35', if_true: files('q35.c'))
+pci_ss.add(when: 'CONFIG_PCI_EXPRESS_XILINX', if_true: files('xilinx-pcie.c'))
+pci_ss.add(when: 'CONFIG_PCI_I440FX', if_true: files('i440fx.c'))
+pci_ss.add(when: 'CONFIG_PCI_SABRE', if_true: files('sabre.c'))
+pci_ss.add(when: 'CONFIG_XEN_IGD_PASSTHROUGH', if_true: files('xen_igd_pt.c'))
+
+# PPC devices
+pci_ss.add(when: 'CONFIG_PREP_PCI', if_true: files('prep.c'))
+pci_ss.add(when: 'CONFIG_GRACKLE_PCI', if_true: files('grackle.c'))
+# NewWorld PowerMac
+pci_ss.add(when: 'CONFIG_UNIN_PCI', if_true: files('uninorth.c'))
+# PowerPC E500 boards
+pci_ss.add(when: 'CONFIG_PPCE500_PCI', if_true: files('ppce500.c'))
+
+# ARM devices
+pci_ss.add(when: 'CONFIG_VERSATILE_PCI', if_true: files('versatile.c'))
+
+softmmu_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
+
+specific_ss.add(when: 'CONFIG_POWERNV', if_true: files(
+  'pnv_phb3.c',
+  'pnv_phb3_msi.c',
+  'pnv_phb3_pbcq.c',
+  'pnv_phb4.c',
+  'pnv_phb4_pec.c'
+))
-- 
1.8.3.1



