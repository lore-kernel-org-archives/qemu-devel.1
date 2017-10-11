Received: from eggs.gnu.org ([2001:4830:134:3::10]:50452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1e2M6w-00075s-Bc
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 14:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1e2M6t-0001Cq-6z
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 14:52:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1e2M6t-0001C5-0P
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 14:52:03 -0400
From: Pankaj Gupta <pagupta@redhat.com>
Date: Thu, 12 Oct 2017 00:21:46 +0530
Message-Id: <20171011185146.20295-1-pagupta@redhat.com>
Subject: [Qemu-devel] [RFC] KVM "fake DAX" device flushing
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

Protoype right now just implements basic functionality without advanced
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
- Qemu device flush functionality.
- Qemu live migration work when host page cache is used.
- Multiple virtio-pmem disks support.

Prototype implementation for feedback:

Kernel: https://github.com/pagupta/linux/commit/d15cf90074eae91aeed7a228da3faf319566dd40
Qemu  : https://github.com/pagupta/qemu/commit/9c428db1e1076970e097e2b0ef8afe52509af823

Please provide feedback. Also, I would be attending KVM Forum in Prague from (25-27 Oct). 
If you are attending KVM forum/Linux conference, I would love to have a discussion on ideas 
and future work.

Thank you,
Pankaj Gupta
