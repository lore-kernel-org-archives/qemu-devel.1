Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33F3C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:12:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB1CF20738
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="US74HFr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1CF20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k94xk-000364-15
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94EQ-0003IU-C0
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:25:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53465
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94EG-0001l7-1d
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mf22p9EQUHIVw4IkTxQz24eDEi0w+8+chJ9OL676sQQ=;
 b=US74HFr6yPpkiYnJwHUQXTisTDc8VrXnZBImhKHPMWngDOXsDEpE7qN8mvq2Q6tFijvz+v
 OWfaYvXnqRAjCUHOItNSHDUu2mdttY5qLozFi2AhxhqGVg7ydlB3HY4dFm8GEwyi0ccK6E
 DQcLmvPadlFwVmpLZlX3k774eY6S8iw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-Bwthvc4CMcOx8P2lI6O2rA-1; Fri, 21 Aug 2020 06:24:57 -0400
X-MC-Unique: Bwthvc4CMcOx8P2lI6O2rA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9965100CF71
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:24:56 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 475EA60BF1;
 Fri, 21 Aug 2020 10:24:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v8 105/152] meson: convert hw/pci
Date: Fri, 21 Aug 2020 06:22:42 -0400
Message-Id: <20200821102329.29777-106-pbonzini@redhat.com>
In-Reply-To: <20200821102329.29777-1-pbonzini@redhat.com>
References: <20200821102329.29777-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:15:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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



