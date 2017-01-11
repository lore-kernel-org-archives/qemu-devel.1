Received: from eggs.gnu.org ([2001:4830:134:3::10]:33293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cREhX-0002ZZ-Ii
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:56:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cREhU-0004ou-GN
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:56:11 -0500
Received: from mga11.intel.com ([192.55.52.93]:56118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liang.z.li@intel.com>)
	id 1cREhU-0004o4-6f
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:56:08 -0500
From: Liang Li <liang.z.li@intel.com>
Date: Wed, 11 Jan 2017 16:48:38 +0800
Message-Id: <1484124524-481-1-git-send-email-liang.z.li@intel.com>
Subject: [Qemu-devel] [PATCH v4 qemu 0/6] Fast (de)inflating & fast live
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, mst@redhat.com, pbonzini@redhat.com, uintela@redhat.com, amit.shah@redhat.com, mtosatti@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com, dave.hansen@intel.com, Liang Li <liang.z.li@intel.com>

This patch set intends to do two optimizations, one is to speed up
the (de)inflating process of virtio balloon, and another one which
is to speed up the live migration process. We put them together
because both of them are required to change the virtio balloon spec.
 
The main idea of speeding up the (de)inflating process is to use
{pfn|length} to send the page information to host instead of the PFNs,
to reduce the overhead of virtio data transmission, address translation
and madvise(). This can help to improve the performance by about 85%.
 
The idea of speeding up live migration is to skip process guest's
unused pages in the first round of data copy, to reduce needless
data processing, this can help to save quite a lot of CPU cycles and
network bandwidth. We get guest's unused page information through the
virt queue of virtio-balloon, and filter out these unused pages during
live migration. For an idle 8GB guest, this can help to shorten the
total live migration time from 2Sec to about 500ms in the 10Gbps
network environment.
 
Changes from v3 to v4:
    * Update kernel head file because of ABI change 
    * Change the code to get the page information

Changes from v2 to v3:
    * Merged two patches for kernel head file updating into one 
    * Removed one patch which was unrelated with this feature 
    * Removed the patch to migrate the vq elem, use a new way instead

Changes from v1 to v2:
    * Abandon the patch for dropping page cache.
    * Get a struct from vq instead of separate variables.
    * Use two separate APIs to request free pages and query the status.
    * Changed the virtio balloon interface.
    * Addressed some of the comments of v1.

Liang Li (6):
  virtio-balloon: update linux head file
  virtio-balloon: speed up inflating & deflating process
  balloon: get unused page info from guest
  bitmap: Add a new bitmap_move function
  kvm.c: Add two new arch specific functions
  migration: skip unused pages during live migration

 balloon.c                                       |  47 +++-
 hw/virtio/virtio-balloon.c                      | 291 +++++++++++++++++++++---
 include/hw/virtio/virtio-balloon.h              |  18 +-
 include/qemu/bitmap.h                           |  13 ++
 include/standard-headers/linux/virtio_balloon.h |  34 +++
 include/sysemu/balloon.h                        |  18 +-
 include/sysemu/kvm.h                            |  18 ++
 migration/ram.c                                 |  86 ++++++-
 target/arm/kvm.c                                |  14 ++
 target/i386/kvm.c                               |  37 +++
 target/mips/kvm.c                               |  14 ++
 target/ppc/kvm.c                                |  14 ++
 target/s390x/kvm.c                              |  14 ++
 13 files changed, 587 insertions(+), 31 deletions(-)

-- 
1.9.1
