Received: from eggs.gnu.org ([2001:4830:134:3::10]:40619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d61zB-0003ed-Mn
	for qemu-devel@nongnu.org; Wed, 03 May 2017 17:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d61zA-0004HO-RW
	for qemu-devel@nongnu.org; Wed, 03 May 2017 17:39:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1d61zA-0004Gq-LU
	for qemu-devel@nongnu.org; Wed, 03 May 2017 17:39:00 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 03 May 2017 15:38:57 -0600
Message-ID: <20170503213846.11828.57191.stgit@gimli.home>
In-Reply-To: <20170503213659.11828.39423.stgit@gimli.home>
References: <20170503213659.11828.39423.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 1/3] vfio: Set MemoryRegionOps:max_access_size
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
Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

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
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/common.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 6b33b9f55df1..6572c0744cb5 100644
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
