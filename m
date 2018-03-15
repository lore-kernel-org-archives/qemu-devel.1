Received: from eggs.gnu.org ([2001:4830:134:3::10]:55403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ewaTa-0007TP-E6
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 17:31:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ewaTZ-0001j6-Bi
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 17:31:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42438 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ewaTZ-0001ig-6h
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 17:31:53 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Thu, 15 Mar 2018 15:31:51 -0600
Message-ID: <20180315213151.15150.70257.stgit@gimli.home>
In-Reply-To: <20180315212634.15150.88094.stgit@gimli.home>
References: <20180315212634.15150.88094.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 2/3] vfio/pci: Use endian neutral helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com, eric.auger@redhat.com, aik@ozlabs.ru

The iowriteXX/ioreadXX functions assume little endian hardware and
convert to little endian on a write and from little endian on a read.
We currently do our own explicit conversion to negate this.  Instead,
add some endian dependent defines to avoid all byte swaps.  There
should be no functional change other than big endian systems aren't
penalized with wasted swaps.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/pci/vfio_pci_rdwr.c |   34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 5f2b376dcebd..925419e0f459 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -21,6 +21,24 @@
 
 #include "vfio_pci_private.h"
 
+#ifdef __LITTLE_ENDIAN
+#define vfio_ioread64	ioread64
+#define vfio_iowrite64	iowrite64
+#define vfio_ioread32	ioread32
+#define vfio_iowrite32	iowrite32
+#define vfio_ioread16	ioread16
+#define vfio_iowrite16	iowrite16
+#else
+#define vfio_ioread64	ioread64be
+#define vfio_iowrite64	iowrite64be
+#define vfio_ioread32	ioread32be
+#define vfio_iowrite32	iowrite32be
+#define vfio_ioread16	ioread16be
+#define vfio_iowrite16	iowrite16be
+#endif
+#define vfio_ioread8	ioread8
+#define vfio_iowrite8	iowrite8
+
 /*
  * Read or write from an __iomem region (MMIO or I/O port) with an excluded
  * range which is inaccessible.  The excluded range drops writes and fills
@@ -44,15 +62,15 @@ static ssize_t do_io_rw(void __iomem *io, char __user *buf,
 			fillable = 0;
 
 		if (fillable >= 4 && !(off % 4)) {
-			__le32 val;
+			u32 val;
 
 			if (iswrite) {
 				if (copy_from_user(&val, buf, 4))
 					return -EFAULT;
 
-				iowrite32(le32_to_cpu(val), io + off);
+				vfio_iowrite32(val, io + off);
 			} else {
-				val = cpu_to_le32(ioread32(io + off));
+				val = vfio_ioread32(io + off);
 
 				if (copy_to_user(buf, &val, 4))
 					return -EFAULT;
@@ -60,15 +78,15 @@ static ssize_t do_io_rw(void __iomem *io, char __user *buf,
 
 			filled = 4;
 		} else if (fillable >= 2 && !(off % 2)) {
-			__le16 val;
+			u16 val;
 
 			if (iswrite) {
 				if (copy_from_user(&val, buf, 2))
 					return -EFAULT;
 
-				iowrite16(le16_to_cpu(val), io + off);
+				vfio_iowrite16(val, io + off);
 			} else {
-				val = cpu_to_le16(ioread16(io + off));
+				val = vfio_ioread16(io + off);
 
 				if (copy_to_user(buf, &val, 2))
 					return -EFAULT;
@@ -82,9 +100,9 @@ static ssize_t do_io_rw(void __iomem *io, char __user *buf,
 				if (copy_from_user(&val, buf, 1))
 					return -EFAULT;
 
-				iowrite8(val, io + off);
+				vfio_iowrite8(val, io + off);
 			} else {
-				val = ioread8(io + off);
+				val = vfio_ioread8(io + off);
 
 				if (copy_to_user(buf, &val, 1))
 					return -EFAULT;
