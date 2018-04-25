Received: from eggs.gnu.org ([2001:4830:134:3::10]:33111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fBIXI-00006g-17
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fBIXE-0000xK-54
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:24:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51160 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1fBIXE-0000wu-0U
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:24:28 -0400
From: Pankaj Gupta <pagupta@redhat.com>
Date: Wed, 25 Apr 2018 16:54:12 +0530
Message-Id: <20180425112415.12327-1-pagupta@redhat.com>
Subject: [Qemu-devel] [RFC v2 0/2] kvm "fake DAX" device flushing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, linux-mm@kvack.org
Cc: jack@suse.cz, stefanha@redhat.com, dan.j.williams@intel.com, riel@surriel.com, haozhong.zhang@intel.com, nilal@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, ross.zwisler@intel.com, david@redhat.com, xiaoguangrong.eric@gmail.com, hch@infradead.org, marcel@redhat.com, mst@redhat.com, niteshnarayanlal@hotmail.com, imammedo@redhat.com, pagupta@redhat.com, lcapitulino@redhat.com

This is RFC V2 for 'fake DAX' flushing interface sharing
for review. This patchset has two main parts:

- Guest virtio-pmem driver
  Guest driver reads persistent memory range from paravirt 
  device and registers with 'nvdimm_bus'. 'nvdimm/pmem' 
  driver uses this information to allocate persistent 
  memory range. Also, we have implemented guest side of 
  VIRTIO flushing interface.

- Qemu virtio-pmem device
  It exposes a persistent memory range to KVM guest which 
  at host side is file backed memory and works as persistent 
  memory device. In addition to this it provides virtio 
  device handling of flushing interface. KVM guest performs
  Qemu side asynchronous sync using this interface.

Changes from previous RFC[1]:

- Reuse existing 'pmem' code for registering persistent 
  memory and other operations instead of creating an entirely 
  new block driver.
- Use VIRTIO driver to register memory information with 
  nvdimm_bus and create region_type accordingly. 
- Call VIRTIO flush from existing pmem driver.

Details of project idea for 'fake DAX' flushing interface is 
shared [2] & [3].

Pankaj Gupta (2):
   Add virtio-pmem guest driver
   pmem: device flush over VIRTIO

[1] https://marc.info/?l=linux-mm&m=150782346802290&w=2
[2] https://www.spinics.net/lists/kvm/msg149761.html
[3] https://www.spinics.net/lists/kvm/msg153095.html  

 drivers/nvdimm/region_devs.c     |    7 ++
 drivers/virtio/Kconfig           |   12 +++
 drivers/virtio/Makefile          |    1 
 drivers/virtio/virtio_pmem.c     |  118 +++++++++++++++++++++++++++++++++++++++
 include/linux/libnvdimm.h        |    4 +
 include/uapi/linux/virtio_ids.h  |    1 
 include/uapi/linux/virtio_pmem.h |   58 +++++++++++++++++++
 7 files changed, 201 insertions(+)
