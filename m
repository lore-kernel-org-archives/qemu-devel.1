Received: from eggs.gnu.org ([2001:4830:134:3::10]:55542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evJzG-0006Cy-Ak
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evJzD-0000ps-3n
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:43:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43580 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1evJzC-0000og-W7
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:43:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02195401C9AE
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 09:43:15 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Mar 2018 10:43:08 +0100
Message-Id: <20180312094308.21716-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v2] hw/i386: make IOMMUs configurable via
 default-configs/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com

Allow distributions to disable the Intel and/or AMD IOMMU devices.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        v1->v2: don't include x86-iommu.o unconditionally

 default-configs/i386-softmmu.mak   | 2 ++
 default-configs/x86_64-softmmu.mak | 2 ++
 hw/i386/Makefile.objs              | 4 ++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 3326e3e0bb..9e5a29fa4a 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -63,3 +63,5 @@ CONFIG_PXB=y
 CONFIG_ACPI_VMGENID=y
 CONFIG_FW_CFG_DMA=y
 CONFIG_I2C=y
+CONFIG_VTD=y
+CONFIG_AMD_IOMMU=y
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
index 1c6cda1d9a..7baf91b921 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -63,3 +63,5 @@ CONFIG_PXB=y
 CONFIG_ACPI_VMGENID=y
 CONFIG_FW_CFG_DMA=y
 CONFIG_I2C=y
+CONFIG_VTD=y
+CONFIG_AMD_IOMMU=y
diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index fd279e7584..fa87a14152 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -2,8 +2,8 @@ obj-$(CONFIG_KVM) += kvm/
 obj-y += multiboot.o
 obj-y += pc.o pc_piix.o pc_q35.o
 obj-y += pc_sysfw.o
-obj-y += x86-iommu.o intel_iommu.o
-obj-y += amd_iommu.o
+obj-$(CONFIG_VTD) += x86-iommu.o intel_iommu.o
+obj-$(CONFIG_AMD_IOMMU) += x86-iommu.o amd_iommu.o
 obj-$(CONFIG_XEN) += ../xenpv/ xen/
 obj-$(CONFIG_VMPORT) += vmport.o
 obj-$(CONFIG_VMMOUSE) += vmmouse.o
-- 
2.14.3
