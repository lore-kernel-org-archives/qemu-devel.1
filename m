Received: from eggs.gnu.org ([2001:4830:134:3::10]:39889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1e2fl9-000338-Qz
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:51:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1e2fl5-0001Gd-Qy
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:50:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1e2fl5-0001G0-Ks
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:50:51 -0400
From: Pankaj Gupta <pagupta@redhat.com>
Date: Thu, 12 Oct 2017 21:20:24 +0530
Message-Id: <20171012155027.3277-1-pagupta@redhat.com>
Subject: [Qemu-devel] [RFC 0/2] KVM "fake DAX" device flushing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, linux-mm@kvack.org
Cc: jack@suse.cz, stefanha@redhat.com, dan.j.williams@intel.com, riel@redhat.com, haozhong.zhang@intel.com, nilal@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, ross.zwisler@intel.com, david@redhat.com, xiaoguangrong.eric@gmail.com, pagupta@redhat.com

We are sharing the prototype version of 'fake DAX' flushing
interface for the initial feedback. This is still work in progress
and not yet ready for merging.

Prototype right now just implements basic functionality without advanced
features with two major parts:

- Qemu virtio-pmem device
  It exposes a persistent memory range to KVM guest which at host side is file
  backed memory and works as persistent memory device. In addition to this it
  provides a virtio flushing interface for KVM guest to do a Qemu side sync for
  guest DAX persistent memory range.  

- Guest virtio-pmem driver
  Reads persistent memory range from paravirt device and reserves system memory map.
  It also allocates a block device corresponding to the pmem range which is accessed
  by DAX capable file systems. (file system support is still pending).  
  
We shared the project idea for 'fake DAX' flushing interface here [1].
Based on suggestions here [2], we implemented guest 'virtio-pmem'
driver and Qemu paravirt device.

[1] https://www.spinics.net/lists/kvm/msg149761.html
[2] https://www.spinics.net/lists/kvm/msg153095.html

Work yet to be done:

- Separate out the common code used by ACPI pmem interface and
  reuse it.

- In pmem device memmap allocation and working. There is some parallel work
  going on upstream related to 'memory_hotplug restructuring' [3] and also hitting
  a memory section alignment issue [4].
  
  [3] https://lwn.net/Articles/712099/
  [4] https://www.mail-archive.com/linux-nvdimm@lists.01.org/msg02978.html
  
- Provide DAX capable file-system(ext4 & XFS) support.
- Qemu device flush functionality trigger with guest fsync on file.
- Qemu live migration work when host page cache is used.
- Multiple virtio-pmem disks support.
- Prepare virtio spec after we get feedback on current approach.

 drivers/nvdimm/pfn.h             |   14 -
 drivers/nvdimm/pfn_devs.c        |   20 --
 drivers/nvdimm/pmem.c            |   40 ----
 drivers/nvdimm/pmem.h            |    5 
 drivers/virtio/Kconfig           |   10 +
 drivers/virtio/Makefile          |    1 
 drivers/virtio/virtio_pmem.c     |  322 +++++++++++++++++++++++++++++++++++++++
 include/linux/memremap.h         |   23 ++
 include/linux/pfn.h              |   15 +
 include/linux/pmem_common.h      |   52 ++++++
 include/uapi/linux/virtio_pmem.h |   55 ++++++
 11 files changed, 479 insertions(+), 78 deletions(-)
