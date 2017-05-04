Received: from eggs.gnu.org ([2001:4830:134:3::10]:56292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Ic0-00022E-F7
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Ibx-0008F5-BO
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d6Ibx-0008E7-5a
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A79763E2F
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 15:24:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  4 May 2017 17:23:41 +0200
Message-Id: <1493911445-19568-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1493911445-19568-1-git-send-email-armbru@redhat.com>
References: <1493911445-19568-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/28] pci: Reduce scope of error injection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

No one outside of pcie_aer.h was using error injection; mark them
static for internal use.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20170427215821.19397-3-eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/pci/pcie_aer.c         | 4 ++--
 include/hw/pci/pcie_aer.h | 4 ----
 2 files changed, 2 insertions(+), 6 deletions(-)

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
=20
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
diff --git a/include/hw/pci/pcie_aer.h b/include/hw/pci/pcie_aer.h
index 526802b..729a943 100644
--- a/include/hw/pci/pcie_aer.h
+++ b/include/hw/pci/pcie_aer.h
@@ -100,8 +100,4 @@ void pcie_aer_root_write_config(PCIDevice *dev,
                                 uint32_t addr, uint32_t val, int len,
                                 uint32_t root_cmd_prev);
=20
-/* error injection */
-int pcie_aer_inject_error(PCIDevice *dev, const PCIEAERErr *err);
-void pcie_aer_msg(PCIDevice *dev, const PCIEAERMsg *msg);
-
 #endif /* QEMU_PCIE_AER_H */
--=20
2.7.4
