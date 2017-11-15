Received: from eggs.gnu.org ([2001:4830:134:3::10]:59084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eF2HY-00042a-F5
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:19:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eF2HQ-0003gn-24
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:19:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eF2HP-0003gd-Ov
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:19:19 -0500
Date: Wed, 15 Nov 2017 20:19:09 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1510769835-31902-11-git-send-email-mst@redhat.com>
References: <1510769835-31902-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1510769835-31902-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/10] build-sys: restrict vmcoreinfo to
 fw_cfg+dma capable targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Stefano Stabellini <sstabellini@kernel.org>, Markus Armbruster <armbru@redhat.com>, Ben Warren <ben@skyportsystems.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Krzysztof Kozlowski <krzk@kernel.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

vmcoreinfo is built for all targets. However, it requires fw_cfg with
DMA operations support (write operation). Restrict vmcoreinfo exposure
to architectures that are supporting FW_CFG_DMA, that is arm-virt and
x86 only atm.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Tested-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 default-configs/arm-softmmu.mak    | 2 ++
 default-configs/i386-softmmu.mak   | 1 +
 default-configs/x86_64-softmmu.mak | 1 +
 hw/misc/Makefile.objs              | 2 +-
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index 5059d13..d37edc4 100644
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
index a685c43..95ac4b4 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -60,3 +60,4 @@ CONFIG_SMBIOS=3Dy
 CONFIG_HYPERV_TESTDEV=3D$(CONFIG_KVM)
 CONFIG_PXB=3Dy
 CONFIG_ACPI_VMGENID=3Dy
+CONFIG_FW_CFG_DMA=3Dy
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-=
softmmu.mak
index ea69e82..0221236 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -60,3 +60,4 @@ CONFIG_SMBIOS=3Dy
 CONFIG_HYPERV_TESTDEV=3D$(CONFIG_KVM)
 CONFIG_PXB=3Dy
 CONFIG_ACPI_VMGENID=3Dy
+CONFIG_FW_CFG_DMA=3Dy
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 19202d9..10c88a8 100644
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
MST
