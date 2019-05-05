Received: from eggs.gnu.org ([209.51.188.92]:55608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hNHdr-00041r-UL
	for qemu-devel@nongnu.org; Sun, 05 May 2019 09:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hNHdr-0004Y7-2h
	for qemu-devel@nongnu.org; Sun, 05 May 2019 09:57:23 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Sun,  5 May 2019 15:56:47 +0200
Message-Id: <20190505135714.11277-2-thuth@redhat.com>
In-Reply-To: <20190505135714.11277-1-thuth@redhat.com>
References: <20190505135714.11277-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/28] hw/pci/pci-stub: Add msi_enabled() and
 msi_notify() to the pci stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

Some machines have an AHCI adapter, but no PCI. To be able to
compile hw/ide/ahci.c without CONFIG_PCI, we still need the two
functions msi_enabled() and msi_notify() for linking.
This is required for the new Kconfig-like build system, if a user
wants to compile a QEMU binary with just one machine that has AHCI,
but no PCI, like the ARM "cubieboard" for example.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/pci/pci-stub.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
index b941a0e842..c04a5df651 100644
--- a/hw/pci/pci-stub.c
+++ b/hw/pci/pci-stub.c
@@ -53,3 +53,14 @@ uint16_t pci_requester_id(PCIDevice *dev)
     g_assert(false);
     return 0;
 }
+
+/* Required by ahci.c */
+bool msi_enabled(const PCIDevice *dev)
+{
+    return false;
+}
+
+void msi_notify(PCIDevice *dev, unsigned int vector)
+{
+    g_assert_not_reached();
+}
--=20
2.21.0
