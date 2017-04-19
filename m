Received: from eggs.gnu.org ([2001:4830:134:3::10]:48576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1d0vXv-0008Ne-A5
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 15:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1d0vXs-0007Oo-9A
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 15:45:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43848
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1d0vXs-0007OT-2Q
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 15:45:44 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3JJiJUt073939
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 15:45:43 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29x77dd9e3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 15:45:42 -0400
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Wed, 19 Apr 2017 16:45:41 -0300
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
	by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v3JJjcvS30998744
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 16:45:38 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
	by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v3JJjcQW018368
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 16:45:38 -0300
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Wed, 19 Apr 2017 16:44:42 -0300
In-Reply-To: <1492631083-23965-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1492631083-23965-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1492631083-23965-2-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/2] vfio: Set MemoryRegionOps:max_access_size
 and min_access_size
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

Sets valid.max_access_size and valid.min_access_size to ensure safe
8-byte accesses to vfio. Today, 8-byte accesses are broken into pairs
of 4-byte calls that goes unprotected:

qemu_mutex_lock locked mutex 0x10905ad8
  vfio_region_write  (0001:03:00.0:region1+0xc0, 0x2020c, 4)
qemu_mutex_unlock unlocked mutex 0x10905ad8
qemu_mutex_lock locked mutex 0x10905ad8
  vfio_region_write  (0001:03:00.0:region1+0xc4, 0xa0000, 4)
qemu_mutex_unlock unlocked mutex 0x10905ad8

which occasionally leads to:

qemu_mutex_lock locked mutex 0x10905ad8
  vfio_region_write  (0001:03:00.0:region1+0xc0, 0x2030c, 4)
qemu_mutex_unlock unlocked mutex 0x10905ad8
qemu_mutex_lock locked mutex 0x10905ad8
  vfio_region_write  (0001:03:00.0:region1+0xc0, 0x1000c, 4)
qemu_mutex_unlock unlocked mutex 0x10905ad8
qemu_mutex_lock locked mutex 0x10905ad8
  vfio_region_write  (0001:03:00.0:region1+0xc4, 0xb0000, 4)
qemu_mutex_unlock unlocked mutex 0x10905ad8
qemu_mutex_lock locked mutex 0x10905ad8
  vfio_region_write  (0001:03:00.0:region1+0xc4, 0xa0000, 4)
qemu_mutex_unlock unlocked mutex 0x10905ad8

causing strange errors in guest OS. With this patch, such accesses
are protected by the same lock guard:

qemu_mutex_lock locked mutex 0x10905ad8
vfio_region_write  (0001:03:00.0:region1+0xc0, 0x2000c, 4)
vfio_region_write  (0001:03:00.0:region1+0xc4, 0xb0000, 4)
qemu_mutex_unlock unlocked mutex 0x10905ad8

This happens because the 8-byte write should be broken into 4-byte
writes by memory.c:access_with_adjusted_size() in order to be under
the same lock. Today, it's done in exec.c:address_space_write_continue()
which was able to handle only 4 bytes due to a zero'ed
valid.max_access_size (see exec.c:memory_access_size()).

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 hw/vfio/common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index f3ba9b9..145f2f4 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -190,6 +190,10 @@ const MemoryRegionOps vfio_region_ops = {
     .read = vfio_region_read,
     .write = vfio_region_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
 };
 
 /*
-- 
2.7.4
