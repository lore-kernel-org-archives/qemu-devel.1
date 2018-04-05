Received: from eggs.gnu.org ([2001:4830:134:3::10]:58142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1f42S8-0001qR-Ts
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 06:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1f42S7-0003fQ-KR
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 06:49:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60500 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1f42S7-0003fJ-Fw
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 06:49:11 -0400
From: Pankaj Gupta <pagupta@redhat.com>
Date: Thu,  5 Apr 2018 16:18:31 +0530
Message-Id: <20180405104834.10457-1-pagupta@redhat.com>
Subject: [Qemu-devel] [RFC 0/2] kvm "fake DAX" device flushing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org
Cc: jack@suse.cz, stefanha@redhat.com, dan.j.williams@intel.com, riel@surriel.com, haozhong.zhang@intel.com, nilal@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, ross.zwisler@intel.com, david@redhat.com, xiaoguangrong.eric@gmail.com, hch@infradead.org, marcel@redhat.com, mst@redhat.com, niteshnarayanlal@hotmail.com, imammedo@redhat.com, pagupta@redhat.com

We are sharing RFC version of 'fake DAX' flushing
interface for feedback. This is still work in progress
and not yet ready for merging.

Prototype implements two major parts:

- Qemu virtio-pmem device
  It exposes a persistent memory range to KVM guest which at host side is file
  backed memory and works as persistent memory device. In addition to this it
  provides a virtio flushing interface for KVM guest to do a Qemu side sync for
  guest DAX persistent memory range.  

- Guest virtio-pmem driver
  Reads persistent memory range from paravirt device and registers with 'nvdimm_bus'.
  'nvdimm/pmem' driver uses this information to allocate persistent memory range. 
  Also, we have implemented guest side of VIRTIO flushing interface.
  
Changes from previous RFC:

- Reuse existing 'pmem' code instead of creating an entirely new block driver.
- Use VIRTIO driver to register memory information with nvdimm_bus and create
  region_type accordingly. 
- Use VIRTIO flushing interface from existing pmem driver code based on
  registered flushign mechanism.

We have done the implementation based on suggestions here [1]. Previous RFC is
shared here [2]. Details of project idea for 'fake DAX' flushing is shared 
here [3] & [4].

[1] https://marc.info/?l=linux-mm&m=150782346802290&w=2
[2] https://marc.info/?l=kvm&m=151630416506527&w=2
[3] https://www.spinics.net/lists/kvm/msg149761.html
[4] https://www.spinics.net/lists/kvm/msg153095.html

Work yet to be done:

- Qemu RAM address handling independent of PC-DIMM so that memory
  operations(get_free_address) can be used for VIRTIO device type as well. 
  (David Hildenbrand CCed has a prototype for this).
- Qemu device flush functionality trigger with guest fsync on file.
- Qemu live migration work when host page cache is used.
- Multiple virtio-pmem disks support.
- Prepare virtio spec after we get feedback on current approach.

 drivers/nvdimm/region_devs.c     |    7 ++
 drivers/virtio/Kconfig           |   12 +++
 drivers/virtio/Makefile          |    1 
 drivers/virtio/virtio_pmem.c     |  122 +++++++++++++++++++++++++++++++++++++++
 include/linux/libnvdimm.h        |    2 
 include/uapi/linux/virtio_ids.h  |    1 
 include/uapi/linux/virtio_pmem.h |   61 +++++++++++++++++++
 7 files changed, 206 insertions(+)
