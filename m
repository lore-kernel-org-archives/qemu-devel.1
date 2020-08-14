Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC72AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:00:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A86A120716
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bY9q8UF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86A120716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6WVK-0001EG-Oo
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 06:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VnS-0007Bt-Qe
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55137)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VnQ-00036A-Pu
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kdtnYpfA9bNc4BnUL/Dc80Bvmc70dfiEOExC5HyIovE=;
 b=bY9q8UF8J04P5wiJk6E9/namMuecuugM+HKgpqcQrdgmtN67z/Nkm09LTKK6+nRxHrcNY6
 F3nAyxtEbNS5LkdC2TnXfDRguRtQ0Go9UqDrRlvzx5nebhB3jhyYRqDRA8Yj1qQLKxI4SZ
 KsXeaAihk776vRM2oy4NpEb77NhBaMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-Gxt4v_mDPaucLjRSWDBieA-1; Fri, 14 Aug 2020 05:14:42 -0400
X-MC-Unique: Gxt4v_mDPaucLjRSWDBieA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48D45802B48
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:14:41 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0764760C04;
 Fri, 14 Aug 2020 09:14:40 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 104/150] meson: convert hw/pci
Date: Fri, 14 Aug 2020 05:12:40 -0400
Message-Id: <20200814091326.16173-105-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 05:13:42
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
 hw/Makefile.objs     |  1 -
 hw/meson.build       |  1 +
 hw/pci/Makefile.objs | 14 --------------
 hw/pci/meson.build   | 19 +++++++++++++++++++
 4 files changed, 20 insertions(+), 15 deletions(-)
 delete mode 100644 hw/pci/Makefile.objs
 create mode 100644 hw/pci/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 3513040d4a..20832841d2 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -21,7 +21,6 @@ devices-dirs-y += misc/
 devices-dirs-y += net/
 devices-dirs-y += rdma/
 devices-dirs-y += nvram/
-devices-dirs-y += pci/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index a7301f21e8..53c347c395 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,6 +1,7 @@
 subdir('core')
 subdir('mem')
 subdir('nubus')
+subdir('pci')
 subdir('pci-bridge')
 subdir('pci-host')
 subdir('pcmcia')
diff --git a/hw/pci/Makefile.objs b/hw/pci/Makefile.objs
deleted file mode 100644
index c78f2fb24b..0000000000
--- a/hw/pci/Makefile.objs
+++ /dev/null
@@ -1,14 +0,0 @@
-common-obj-$(CONFIG_PCI) += pci.o pci_bridge.o
-common-obj-$(CONFIG_PCI) += msix.o msi.o
-common-obj-$(CONFIG_PCI) += shpc.o
-common-obj-$(CONFIG_PCI) += slotid_cap.o
-common-obj-$(CONFIG_PCI) += pci_host.o
-
-# The functions in these modules can be used by devices too.  Since we
-# allow plugging PCIe devices into PCI buses, include them even if
-# CONFIG_PCI_EXPRESS=n.
-common-obj-$(CONFIG_PCI) += pcie.o pcie_aer.o
-common-obj-$(CONFIG_PCI_EXPRESS) += pcie_port.o pcie_host.o
-
-common-obj-$(call lnot,$(CONFIG_PCI)) += pci-stub.o
-common-obj-$(CONFIG_ALL) += pci-stub.o
diff --git a/hw/pci/meson.build b/hw/pci/meson.build
new file mode 100644
index 0000000000..5c4bbac817
--- /dev/null
+++ b/hw/pci/meson.build
@@ -0,0 +1,19 @@
+pci_ss = ss.source_set()
+pci_ss.add(files(
+  'msi.c',
+  'msix.c',
+  'pci.c',
+  'pci_bridge.c',
+  'pci_host.c',
+  'shpc.c',
+  'slotid_cap.c'
+))
+# The functions in these modules can be used by devices too.  Since we
+# allow plugging PCIe devices into PCI buses, include them even if
+# CONFIG_PCI_EXPRESS=n.
+pci_ss.add(files('pcie.c', 'pcie_aer.c'))
+softmmu_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pcie_port.c', 'pcie_host.c'))
+softmmu_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
+
+softmmu_ss.add(when: 'CONFIG_PCI', if_false: files('pci-stub.c'))
+softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('pci-stub.c'))
-- 
2.26.2



