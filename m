Received: from eggs.gnu.org ([2001:4830:134:3::10]:35659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eilxZ-0001eC-UA
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:57:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eilxW-0004HR-TK
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:57:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eilxW-0004H0-NE
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:57:42 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E56F249012
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 18:57:41 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 05 Feb 2018 11:57:36 -0700
Message-ID: <20180205185736.14391.44601.stgit@gimli.home>
In-Reply-To: <20180205185416.14391.5739.stgit@gimli.home>
References: <20180205185416.14391.5739.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 06/11] vfio/pci: Emulate BARs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The kernel provides similar emulation of PCI BAR register access to
QEMU, so up until now we've used that for things like BAR sizing and
storing the BAR address.  However, if we intend to resize BARs or add
BARs that don't exist on the physical device, we need to switch to the
pure QEMU emulation of the BAR.

Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 908b8dffca2b..9436ac5cc9ae 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2777,6 +2777,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     /* QEMU can choose to expose the ROM or not */
     memset(vdev->emulated_config_bits + PCI_ROM_ADDRESS, 0xff, 4);
+    /* QEMU can also add or extend BARs */
+    memset(vdev->emulated_config_bits + PCI_BASE_ADDRESS_0, 0xff, 6 * 4);
 
     /*
      * The PCI spec reserves vendor ID 0xffff as an invalid value.  The
