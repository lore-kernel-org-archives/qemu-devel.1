Received: from eggs.gnu.org ([2001:4830:134:3::10]:35343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cVgyL-0003C5-PM
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:55:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cVgyH-0005ZB-Hh
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:55:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cVgyH-0005Yn-85
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:55:53 -0500
Date: Mon, 23 Jan 2017 17:55:51 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170123175422-mutt-send-email-mst@kernel.org>
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484917736-32056-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v4 00/20] VT-d: vfio enablement and
 misc enhances
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com

On Fri, Jan 20, 2017 at 09:08:36PM +0800, Peter Xu wrote:
> This is v4 of vt-d vfio enablement series.
> 
> Sorry that v4 growed to 20 patches. Some newly added patches (which
> are quite necessary):
> 
> [01/20] vfio: trace map/unmap for notify as well
> [02/20] vfio: introduce vfio_get_vaddr()
> [03/20] vfio: allow to notify unmap for very large region
> 
>   Patches from RFC series:
> 
>   "[PATCH RFC 0/3] vfio: allow to notify unmap for very big region"
> 
>   Which is required by patch [19/20].
> 
> [11/20] memory: provide IOMMU_NOTIFIER_FOREACH macro
> 
>   A helper only.
> 
> [19/20] intel_iommu: unmap existing pages before replay
> 
>   This solves Alex's concern that there might have existing mappings
>   in previous domain when replay happens.
> 
> [20/20] intel_iommu: replay even with DSI/GLOBAL inv desc
> 
>   This solves Jason/Kevin's concern by handling DSI/GLOBAL
>   invalidations as well.
> 
> Each individual patch will have more detailed explanation on itself.
> Please refer to each of them.
> 
> Here I did separate work on patch 19/20 rather than squashing them
> into patch 18 for easier modification and review. I prefer we have
> them separately so we can see each problem separately, after all,
> patch 18 survives in most use cases. Please let me know if we want to
> squash them in some way. I can respin when necessary.
> 
> Besides the big things, lots of tiny tweaks as well. Here's the
> changelog.

It would be nice to add to the log
- known issues / missing features, if any
- are there patches ready to be merged here?
  if yes pls post them without the rfc tag


> v4:
> - convert all error_report()s into traces (in the two patches that did
>   that)
> - rebased to Jason's DMAR series (master + one more patch:
>   "[PATCH V4 net-next] vhost_net: device IOTLB support")
> - let vhost use the new api iommu_notifier_init() so it won't break
>   vhost dmar [Jason]
> - touch commit message of the patch:
>   "intel_iommu: provide its own replay() callback"
>   old replay is not a dead loop, but it will just consume lots of time
>   [Jason]
> - add comment for patch:
>   "intel_iommu: do replay when context invalidate"
>   telling why replay won't be a problem even without CM=1 [Jason]
> - remove a useless comment line [Jason]
> - remove dmar_enabled parameter for vtd_switch_address_space() and
>   vtd_switch_address_space_all() [Mst, Jason]
> - merged the vfio patches in, to support unmap of big ranges at the
>   beginning ("[PATCH RFC 0/3] vfio: allow to notify unmap for very big
>   region")
> - using caching_mode instead of cache_mode_enabled, and "caching-mode"
>   instead of "cache-mode" [Kevin]
> - when receive context entry invalidation, we unmap the entire region
>   first, then replay [Alex]
> - fix commit message for patch:
>   "intel_iommu: simplify irq region translation" [Kevin]
> - handle domain/global invalidation, and notify where proper [Jason,
>   Kevin]
> 
> v3:
> - fix style error reported by patchew
> - fix comment in domain switch patch: use "IOMMU address space" rather
>   than "IOMMU region" [Kevin]
> - add ack-by for Paolo in patch:
>   "memory: add section range info for IOMMU notifier"
>   (this is seperately collected besides this thread)
> - remove 3 patches which are merged already (from Jason)
> - rebase to master b6c0897
> 
> v2:
> - change comment for "end" parameter in vtd_page_walk() [Tianyu]
> - change comment for "a iova" to "an iova" [Yi]
> - fix fault printed val for GPA address in vtd_page_walk_level (debug
>   only)
> - rebased to master (rather than Aviv's v6 series) and merged Aviv's
>   series v6: picked patch 1 (as patch 1 in this series), dropped patch
>   2, re-wrote patch 3 (as patch 17 of this series).
> - picked up two more bugfix patches from Jason's DMAR series
> - picked up the following patch as well:
>   "[PATCH v3] intel_iommu: allow dynamic switch of IOMMU region"
> 
> This RFC series is a re-work for Aviv B.D.'s vfio enablement series
> with vt-d:
> 
>   https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg01452.html
> 
> Aviv has done a great job there, and what we still lack there are
> mostly the following:
> 
> (1) VFIO got duplicated IOTLB notifications due to splitted VT-d IOMMU
>     memory region.
> 
> (2) VT-d still haven't provide a correct replay() mechanism (e.g.,
>     when IOMMU domain switches, things will broke).
> 
> This series should have solved the above two issues.
> 
> Online repo:
> 
>   https://github.com/xzpeter/qemu/tree/vtd-vfio-enablement-v4
> 
> I would be glad to hear about any review comments for above patches.
> 
> =========
> Test Done
> =========
> 
> Build test passed for x86_64/arm/ppc64.
> 
> Simply tested with x86_64, assigning two PCI devices to a single VM,
> boot the VM using:
> 
> bin=x86_64-softmmu/qemu-system-x86_64
> $bin -M q35,accel=kvm,kernel-irqchip=split -m 1G \
>      -device intel-iommu,intremap=on,eim=off,caching-mode=on \
>      -netdev user,id=net0,hostfwd=tcp::5555-:22 \
>      -device virtio-net-pci,netdev=net0 \
>      -device vfio-pci,host=03:00.0 \
>      -device vfio-pci,host=02:00.0 \
>      -trace events=".trace.vfio" \
>      /var/lib/libvirt/images/vm1.qcow2
> 
> pxdev:bin [vtd-vfio-enablement]# cat .trace.vfio
> vtd_page_walk*
> vtd_replay*
> vtd_inv_desc*
> 
> Then, in the guest, run the following tool:
> 
>   https://github.com/xzpeter/clibs/blob/master/gpl/userspace/vfio-bind-group/vfio-bind-group.c
> 
> With parameter:
> 
>   ./vfio-bind-group 00:03.0 00:04.0
> 
> Check host side trace log, I can see pages are replayed and mapped in
> 00:04.0 device address space, like:
> 
> ...
> vtd_replay_ce_valid replay valid context device 00:04.00 hi 0x401 lo 0x38fe1001
> vtd_page_walk Page walk for ce (0x401, 0x38fe1001) iova range 0x0 - 0x8000000000
> vtd_page_walk_level Page walk (base=0x38fe1000, level=3) iova range 0x0 - 0x8000000000
> vtd_page_walk_level Page walk (base=0x35d31000, level=2) iova range 0x0 - 0x40000000
> vtd_page_walk_level Page walk (base=0x34979000, level=1) iova range 0x0 - 0x200000
> vtd_page_walk_one Page walk detected map level 0x1 iova 0x0 -> gpa 0x22dc3000 mask 0xfff perm 3
> vtd_page_walk_one Page walk detected map level 0x1 iova 0x1000 -> gpa 0x22e25000 mask 0xfff perm 3
> vtd_page_walk_one Page walk detected map level 0x1 iova 0x2000 -> gpa 0x22e12000 mask 0xfff perm 3
> vtd_page_walk_one Page walk detected map level 0x1 iova 0x3000 -> gpa 0x22e2d000 mask 0xfff perm 3
> vtd_page_walk_one Page walk detected map level 0x1 iova 0x4000 -> gpa 0x12a49000 mask 0xfff perm 3
> vtd_page_walk_one Page walk detected map level 0x1 iova 0x5000 -> gpa 0x129bb000 mask 0xfff perm 3
> vtd_page_walk_one Page walk detected map level 0x1 iova 0x6000 -> gpa 0x128db000 mask 0xfff perm 3
> vtd_page_walk_one Page walk detected map level 0x1 iova 0x7000 -> gpa 0x12a80000 mask 0xfff perm 3
> vtd_page_walk_one Page walk detected map level 0x1 iova 0x8000 -> gpa 0x12a7e000 mask 0xfff perm 3
> vtd_page_walk_one Page walk detected map level 0x1 iova 0x9000 -> gpa 0x12b22000 mask 0xfff perm 3
> vtd_page_walk_one Page walk detected map level 0x1 iova 0xa000 -> gpa 0x12b41000 mask 0xfff perm 3
> ...
> 
> =========
> Todo List
> =========
> 
> - error reporting for the assigned devices (as Tianyu has mentioned)
> 
> - per-domain address-space: A better solution in the future may be -
>   we maintain one address space per IOMMU domain in the guest (so
>   multiple devices can share a same address space if they are sharing
>   the same IOMMU domains in the guest), rather than one address space
>   per device (which is current implementation of vt-d). However that's
>   a step further than this series, and let's see whether we can first
>   provide a workable version of device assignment with vt-d
>   protection.
> 
> - more to come...
> 
> Thanks,
> 
> Aviv Ben-David (1):
>   IOMMU: add option to enable VTD_CAP_CM to vIOMMU capility exposoed to
>     guest
> 
> Peter Xu (19):
>   vfio: trace map/unmap for notify as well
>   vfio: introduce vfio_get_vaddr()
>   vfio: allow to notify unmap for very large region
>   intel_iommu: simplify irq region translation
>   intel_iommu: renaming gpa to iova where proper
>   intel_iommu: fix trace for inv desc handling
>   intel_iommu: fix trace for addr translation
>   intel_iommu: vtd_slpt_level_shift check level
>   memory: add section range info for IOMMU notifier
>   memory: provide IOMMU_NOTIFIER_FOREACH macro
>   memory: provide iommu_replay_all()
>   memory: introduce memory_region_notify_one()
>   memory: add MemoryRegionIOMMUOps.replay() callback
>   intel_iommu: provide its own replay() callback
>   intel_iommu: do replay when context invalidate
>   intel_iommu: allow dynamic switch of IOMMU region
>   intel_iommu: enable vfio devices
>   intel_iommu: unmap existing pages before replay
>   intel_iommu: replay even with DSI/GLOBAL inv desc
> 
>  hw/i386/intel_iommu.c          | 674 +++++++++++++++++++++++++++++++----------
>  hw/i386/intel_iommu_internal.h |   2 +
>  hw/i386/trace-events           |  30 ++
>  hw/vfio/common.c               |  68 +++--
>  hw/vfio/trace-events           |   2 +-
>  hw/virtio/vhost.c              |   4 +-
>  include/exec/memory.h          |  49 ++-
>  include/hw/i386/intel_iommu.h  |  12 +
>  memory.c                       |  47 ++-
>  9 files changed, 696 insertions(+), 192 deletions(-)
> 
> -- 
> 2.7.4
