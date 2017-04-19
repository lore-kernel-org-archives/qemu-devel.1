Received: from eggs.gnu.org ([2001:4830:134:3::10]:48611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1d0vY1-0008Po-L3
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 15:45:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1d0vXy-0007R5-Cc
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 15:45:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1d0vXx-0007Qd-Vq
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 15:45:50 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3JJiOHP010064
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 15:45:48 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29x0wjvhxr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 15:45:48 -0400
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Wed, 19 Apr 2017 16:45:45 -0300
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
	by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v3JJjhuP2359732
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 16:45:43 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
	by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v3JJjhAP018412
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 16:45:43 -0300
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Wed, 19 Apr 2017 16:44:43 -0300
In-Reply-To: <1492631083-23965-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1492631083-23965-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1492631083-23965-3-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 2/2] vfio: enable 8-byte reads/writes to vfio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, pbonzini@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru

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
---
 hw/vfio/common.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 145f2f4..43c8e98 100644
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
-- 
2.7.4
