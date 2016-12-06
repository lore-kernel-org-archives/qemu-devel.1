Received: from eggs.gnu.org ([2001:4830:134:3::10]:54623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cED72-00076Z-2R
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:36:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cED6y-0001uU-Sw
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:36:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cED6y-0001uF-KW
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:36:36 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue,  6 Dec 2016 18:36:15 +0800
Message-Id: <1481020588-4245-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 00/13] VT-d replay and misc cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, peterx@redhat.com, alex.williamson@redhat.com, jasowang@redhat.com

This RFC series is a continue work for Aviv B.D.'s vfio enablement
series with vt-d. Aviv has done a great job there, and what we still
lack there are mostly the following:

(1) VFIO got duplicated IOTLB notifications due to splitted VT-d IOMMU
    memory region.

(2) VT-d still haven't provide a correct replay() mechanism (e.g.,
    when IOMMU domain switches, things will broke).

Here I'm trying to solve the above two issues.

(1) is solved by patch 7, (2) is solved by patch 11-12.

Basically it contains the following:

patch 1:    picked up from Jason's vhost DMAR series, which is a bugfix

patch 2-6:  Cleanups/Enhancements for existing vt-d codes (please see
            specific commit message for details, there are patches
            that I thought may be suitable for 2.8 as well, but looks
            like it's too late)

patch 7:    Solve the issue that vfio is notified more than once for
            IOTLB notifications with Aviv's patches

patch 8-10: Some trivial memory APIs added for further patches, and
            add customize replay() support for MemoryRegion (I see
            Aviv's latest v7 contains similar replay, I can rebase
            onto that, merely the same thing)

patch 11:   Provide a valid vt-d replay() callback, using page walk

patch 12:   Enable the domain switch support - we replay() when
            context entry got invalidated

patch 13:   Enhancement for existing invalidation notification,
            instead of using translate() for each page, we leverage
            the new vtd_page_walk() interface, which should be faster.

I would glad to hear about any review comments for above patches
(especially patch 8-13, which is the main part of this series),
especially any issue I missed in the series.

=========
Test Done
=========

Build test passed for x86_64/arm/ppc64.

Simply tested with x86_64, assigning two PCI devices to a single VM,
boot the VM using:

bin=x86_64-softmmu/qemu-system-x86_64
$bin -M q35,accel=kvm,kernel-irqchip=split -m 1G \
     -device intel-iommu,intremap=on,eim=off,cache-mode=on \
     -netdev user,id=net0,hostfwd=tcp::5555-:22 \
     -device virtio-net-pci,netdev=net0 \
     -device vfio-pci,host=03:00.0 \
     -device vfio-pci,host=02:00.0 \
     -trace events=".trace.vfio" \
     /var/lib/libvirt/images/vm1.qcow2

pxdev:bin [vtd-vfio-enablement]# cat .trace.vfio
vtd_page_walk*
vtd_replay*
vtd_inv_desc*

Then, in the guest, run the following tool:

  https://github.com/xzpeter/clibs/blob/master/gpl/userspace/vfio-bind-group/vfio-bind-group.c

With parameter:

  ./vfio-bind-group 00:03.0 00:04.0

Check host side trace log, I can see pages are replayed and mapped in
00:04.0 device address space, like:

...
vtd_replay_ce_valid replay valid context device 00:04.00 hi 0x301 lo 0x3be77001
vtd_page_walk Page walk for ce (0x301, 0x3be77001) iova range 0x0 - 0x8000000000
vtd_page_walk_level Page walk (base=0x3be77000, level=3) iova range 0x0 - 0x8000000000
vtd_page_walk_level Page walk (base=0x3c88a000, level=2) iova range 0x0 - 0x40000000
vtd_page_walk_level Page walk (base=0x366cb000, level=1) iova range 0x0 - 0x200000
vtd_page_walk_one Page walk detected map level 0x1 iova 0x0 -> gpa 0x366cb000 mask 0xfff perm 3
vtd_page_walk_one Page walk detected map level 0x1 iova 0x1000 -> gpa 0x366cb000 mask 0xfff perm 3
vtd_page_walk_one Page walk detected map level 0x1 iova 0x2000 -> gpa 0x366cb000 mask 0xfff perm 3
vtd_page_walk_one Page walk detected map level 0x1 iova 0x3000 -> gpa 0x366cb000 mask 0xfff perm 3
vtd_page_walk_one Page walk detected map level 0x1 iova 0x4000 -> gpa 0x366cb000 mask 0xfff perm 3
vtd_page_walk_one Page walk detected map level 0x1 iova 0x5000 -> gpa 0x366cb000 mask 0xfff perm 3
vtd_page_walk_one Page walk detected map level 0x1 iova 0x6000 -> gpa 0x366cb000 mask 0xfff perm 3
vtd_page_walk_one Page walk detected map level 0x1 iova 0x7000 -> gpa 0x366cb000 mask 0xfff perm 3
vtd_page_walk_one Page walk detected map level 0x1 iova 0x8000 -> gpa 0x366cb000 mask 0xfff perm 3
vtd_page_walk_one Page walk detected map level 0x1 iova 0x9000 -> gpa 0x366cb000 mask 0xfff perm 3
vtd_page_walk_one Page walk detected map level 0x1 iova 0xa000 -> gpa 0x366cb000 mask 0xfff perm 3
vtd_page_walk_one Page walk detected map level 0x1 iova 0xb000 -> gpa 0x366cb000 mask 0xfff perm 3
vtd_page_walk_one Page walk detected map level 0x1 iova 0xc000 -> gpa 0x366cb000 mask 0xfff perm 3
vtd_page_walk_one Page walk detected map level 0x1 iova 0xd000 -> gpa 0x366cb000 mask 0xfff perm 3
vtd_page_walk_one Page walk detected map level 0x1 iova 0xe000 -> gpa 0x366cb000 mask 0xfff perm 3
...

=========
Todo List
=========

- error reporting for the assigned devices (as Tianyu has mentioned)

- per-domain address-space: A better solution in the future may be -
  we maintain one address space per IOMMU domain in the guest (so
  multiple devices can share a same address space if they are sharing
  the same IOMMU domains in the guest), rather than one address space
  per device (which is current implementation of vt-d). However that's
  a step further than this series, and let's see whether we can first
  provide a workable version of device assignment with vt-d
  protection.

- more to come...

Thanks,

Jason Wang (1):
  intel_iommu: allocate new key when creating new address space

Peter Xu (12):
  intel_iommu: simplify irq region translation
  intel_iommu: renaming gpa to iova where proper
  intel_iommu: fix trace for inv desc handling
  intel_iommu: fix trace for addr translation
  intel_iommu: vtd_slpt_level_shift check level
  memory: add section range info for IOMMU notifier
  memory: provide iommu_replay_all()
  memory: introduce memory_region_notify_one()
  memory: add MemoryRegionIOMMUOps.replay() callback
  intel_iommu: provide its own replay() callback
  intel_iommu: do replay when context invalidate
  intel_iommu: use page_walk for iotlb inv notify

 hw/i386/intel_iommu.c | 521 ++++++++++++++++++++++++++++++++------------------
 hw/i386/trace-events  |  27 +++
 hw/vfio/common.c      |   7 +-
 include/exec/memory.h |  30 +++
 memory.c              |  42 +++-
 5 files changed, 432 insertions(+), 195 deletions(-)

-- 
2.7.4
