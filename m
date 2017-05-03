Received: from eggs.gnu.org ([2001:4830:134:3::10]:40725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d61zO-0003st-UE
	for qemu-devel@nongnu.org; Wed, 03 May 2017 17:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d61zL-0004QM-Pw
	for qemu-devel@nongnu.org; Wed, 03 May 2017 17:39:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1d61zL-0004OM-Jj
	for qemu-devel@nongnu.org; Wed, 03 May 2017 17:39:11 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 03 May 2017 15:39:08 -0600
Message-ID: <20170503213904.11828.36920.stgit@gimli.home>
In-Reply-To: <20170503213659.11828.39423.stgit@gimli.home>
References: <20170503213659.11828.39423.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 2/3] vfio: enable 8-byte reads/writes to vfio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

This patch enables 8-byte writes and reads to VFIO. Such implemention
is already done but it's missing the 'case' to handle such accesses in
both vfio_region_write and vfio_region_read and the MemoryRegionOps:
impl.max_access_size and impl.min_access_size.

After this patch, 8-byte writes such as:

qemu_mutex_lock locked mutex 0x10905ad8
vfio_region_write  (0001:03:00.0:region1+0xc0, 0x4140c, 4)
vfio_region_write  (0001:03:00.0:region1+0xc4, 0xa0000, 4)
qemu_mutex_unlock unlocked mutex 0x10905ad8

goes like this:

qemu_mutex_lock locked mutex 0x10905ad8
vfio_region_write  (0001:03:00.0:region1+0xc0, 0xbfd0008, 8)
qemu_mutex_unlock unlocked mutex 0x10905ad8

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/common.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 6572c0744cb5..a8f12eeb3589 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -119,6 +119,9 @@ void vfio_region_write(void *opaque, hwaddr addr,
     case 4:
         buf.dword = cpu_to_le32(data);
         break;
+    case 8:
+        buf.qword = cpu_to_le64(data);
+        break;
     default:
         hw_error("vfio: unsupported write size, %d bytes", size);
         break;
@@ -173,6 +176,9 @@ uint64_t vfio_region_read(void *opaque,
     case 4:
         data = le32_to_cpu(buf.dword);
         break;
+    case 8:
+        data = le64_to_cpu(buf.qword);
+        break;
     default:
         hw_error("vfio: unsupported read size, %d bytes", size);
         break;
@@ -194,6 +200,10 @@ const MemoryRegionOps vfio_region_ops = {
         .min_access_size = 1,
         .max_access_size = 8,
     },
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
 };
 
 /*
