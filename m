Received: from eggs.gnu.org ([2001:4830:134:3::10]:39056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ctr7D-000193-V5
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 03:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ctr7D-0006ss-3m
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 03:36:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ctr7C-0006rg-UP
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 03:36:59 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 31 Mar 2017 15:36:28 +0800
Message-Id: <1490945793-21276-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 0/5] x86/vIOMMU: move init back to
 machine init phase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, Paolo Bonzini <pbonzini@redhat.com>, kevin.tian@intel.com, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, "\\  Michael S . Tsirkin \\ " <mst@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>

At the very beginning, the x86 vIOMMUs are created via "-M iommu=on".
We moved one step further a year ago to have the vIOMMUs just like a
general device, so that we can init them with far more specific
parameters with "-device" interface.

However, gradually we found that problem starts to occur due to this.
The main issue is that the DMA address space of any PCI device is
postponed to be init after device realization, while some devices'
realizations would depend on this address space. That looks like a
dead lock. We have patches and solutions for different single problem,
but, maybe it's time we can consider to solve the root cause this
time, of course after 2.9 release.

This series tries to solve the root cause, and move vIOMMU inits back
to machine init for x86 platforms. Then, we'll have solid DMA address
space for each device even during realization.

Please kindly review. Thanks.

Peter Xu (5):
  QemuOpts: introduce qemu_opts_extract()
  util: export device_init_func()
  util: propagate error for device_func_init()
  q35: init vIOMMU during machine init
  pci: move dma_as init back to bus realize

 hw/pci-host/q35.c        | 45 +++++++++++++++++++++++++++++++++++++++++++++
 hw/pci/pci.c             | 21 +--------------------
 include/hw/pci/pci_bus.h |  2 --
 include/qemu-common.h    |  1 +
 include/qemu/option.h    |  2 ++
 include/sysemu/sysemu.h  |  1 -
 util/qemu-option.c       | 24 ++++++++++++++++++++++++
 vl.c                     |  9 ++-------
 8 files changed, 75 insertions(+), 30 deletions(-)

-- 
2.7.4
