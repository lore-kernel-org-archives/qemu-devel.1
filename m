Received: from eggs.gnu.org ([2001:4830:134:3::10]:48351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cy0sI-0002cg-AT
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 14:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cy0sH-0004Oi-4r
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 14:50:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cy0sG-0004ON-SO
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 14:50:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF9B94DD62
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 18:50:43 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Tue, 11 Apr 2017 13:50:23 -0500
Message-Id: <20170411185034.13460-3-eblake@redhat.com>
In-Reply-To: <20170411185034.13460-1-eblake@redhat.com>
References: <20170411185034.13460-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 02/13] pci: Reduce scope of error injection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

No one outside of pcie_aer.h was using error injection; mark them
static for internal use.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

---
v4: no change
v3: new patch, suggested by Markus
---
 include/hw/pci/pcie_aer.h | 4 ----
 hw/pci/pcie_aer.c         | 4 ++--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/hw/pci/pcie_aer.h b/include/hw/pci/pcie_aer.h
index 526802b..729a943 100644
--- a/include/hw/pci/pcie_aer.h
+++ b/include/hw/pci/pcie_aer.h
@@ -100,8 +100,4 @@ void pcie_aer_root_write_config(PCIDevice *dev,
                                 uint32_t addr, uint32_t val, int len,
                                 uint32_t root_cmd_prev);

-/* error injection */
-int pcie_aer_inject_error(PCIDevice *dev, const PCIEAERErr *err);
-void pcie_aer_msg(PCIDevice *dev, const PCIEAERMsg *msg);
-
 #endif /* QEMU_PCIE_AER_H */
diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index 653af86..828052b 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -376,7 +376,7 @@ static void pcie_aer_msg_root_port(PCIDevice *dev, co=
nst PCIEAERMsg *msg)
  *
  * Walk up the bus tree from the device, propagate the error message.
  */
-void pcie_aer_msg(PCIDevice *dev, const PCIEAERMsg *msg)
+static void pcie_aer_msg(PCIDevice *dev, const PCIEAERMsg *msg)
 {
     uint8_t type;

@@ -631,7 +631,7 @@ static bool pcie_aer_inject_uncor_error(PCIEAERInject=
 *inj, bool is_fatal)
  * Figure 6-2: Flowchart Showing Sequence of Device Error Signaling and =
Logging
  *             Operations
  */
-int pcie_aer_inject_error(PCIDevice *dev, const PCIEAERErr *err)
+static int pcie_aer_inject_error(PCIDevice *dev, const PCIEAERErr *err)
 {
     uint8_t *aer_cap =3D NULL;
     uint16_t devctl =3D 0;
--=20
2.9.3
