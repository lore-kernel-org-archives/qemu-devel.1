Received: from eggs.gnu.org ([2001:4830:134:3::10]:41464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBfyi-000573-5Z
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:54:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBfyd-00018y-6o
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:54:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eBfyd-00017Q-0Q
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:54:03 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  6 Nov 2017 12:53:47 +0100
Message-Id: <20171106115347.19873-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] build-sys: restrict vmcoreinfo to fw_cfg+dma
 capable targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, thuth@redhat.com, danielhb@linux.vnet.ibm.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

vmcoreinfo is built for all targets. However, it requires fw_cfg with
DMA operations support (write operation). Restrict vmcoreinfo exposure
to architectures that are supporting FW_CFG_DMA, that is arm-virt and
x86 only atm.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 default-configs/arm-softmmu.mak    | 2 ++
 default-configs/i386-softmmu.mak   | 1 +
 default-configs/x86_64-softmmu.mak | 1 +
 hw/misc/Makefile.objs              | 2 +-
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index 5059d134c8..d37edc4312 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -130,3 +130,5 @@ CONFIG_SMBIOS=3Dy
 CONFIG_ASPEED_SOC=3Dy
 CONFIG_GPIO_KEY=3Dy
 CONFIG_MSF2=3Dy
+
+CONFIG_FW_CFG_DMA=3Dy
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-soft=
mmu.mak
index a685c439e7..95ac4b464a 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -60,3 +60,4 @@ CONFIG_SMBIOS=3Dy
 CONFIG_HYPERV_TESTDEV=3D$(CONFIG_KVM)
 CONFIG_PXB=3Dy
 CONFIG_ACPI_VMGENID=3Dy
+CONFIG_FW_CFG_DMA=3Dy
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-=
softmmu.mak
index ea69e8289e..0221236825 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -60,3 +60,4 @@ CONFIG_SMBIOS=3Dy
 CONFIG_HYPERV_TESTDEV=3D$(CONFIG_KVM)
 CONFIG_PXB=3Dy
 CONFIG_ACPI_VMGENID=3Dy
+CONFIG_FW_CFG_DMA=3Dy
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 19202d90cf..10c88a84b4 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -9,7 +9,7 @@ common-obj-$(CONFIG_PCI_TESTDEV) +=3D pci-testdev.o
 common-obj-$(CONFIG_EDU) +=3D edu.o
=20
 common-obj-y +=3D unimp.o
-common-obj-y +=3D vmcoreinfo.o
+common-obj-$(CONFIG_FW_CFG_DMA) +=3D vmcoreinfo.o
=20
 obj-$(CONFIG_VMPORT) +=3D vmport.o
=20
--=20
2.15.0.rc0.40.gaefcc5f6f
