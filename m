Received: from eggs.gnu.org ([2001:4830:134:3::10]:59058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fEM1l-0000mt-Ks
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:44:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fEM1i-00036y-9L
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:44:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fEM1h-00034x-RK
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:44:34 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Thu, 03 May 2018 15:44:31 -0600
Message-ID: <20180503213458.2749.28566.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 0/6] vfio/quirks: ioeventfd support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, eric.auger@redhat.com, peterx@redhat.com

I've incorporated all review comments from Peter and Eric aside from
adding a new tri-state property to handle the debug options.  I'm also
pulling in the header update series and dropping the virtio GPU patch, 
manually restoring the necessary define with hopes that the upstream
discrepancy is resolved now that it has been identified to those
responsible.  This series still depends on MST's series as the header
update to v4.17-rc is still a bit nasty.  That can be found here:

https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg02510.html

Please review.  Thanks,

Alex

---

Alex Williamson (6):
      scripts/update-linux-headers: Update handling of __aligned_u64
      linux-headers: Update to v4.17-rc3
      vfio/quirks: Add common quirk alloc helper
      vfio/quirks: Add quirk reset callback
      vfio/quirks: ioeventfd quirk acceleration
      vfio/quirks: Enable ioeventfd quirks to be handled by vfio directly


 hw/vfio/pci-quirks.c                            |  268 +++++++++++++++--
 hw/vfio/pci.c                                   |    6 
 hw/vfio/pci.h                                   |   18 +
 hw/vfio/trace-events                            |    3 
 include/standard-headers/linux/ethtool.h        |   36 ++
 include/standard-headers/linux/input.h          |    4 
 include/standard-headers/linux/pci_regs.h       |    7 
 include/standard-headers/linux/virtio_balloon.h |   19 +
 include/standard-headers/rdma/vmw_pvrdma-abi.h  |   49 ++-
 linux-headers/COPYING                           |  358 +----------------------
 linux-headers/asm-arm/kvm.h                     |   15 +
 linux-headers/asm-arm64/kvm.h                   |    6 
 linux-headers/asm-s390/unistd_32.h              |    1 
 linux-headers/asm-s390/unistd_64.h              |    1 
 linux-headers/asm-x86/kvm.h                     |   19 +
 linux-headers/linux/kvm.h                       |   30 ++
 linux-headers/linux/vfio.h                      |   27 ++
 scripts/update-linux-headers.sh                 |    1 
 18 files changed, 453 insertions(+), 415 deletions(-)
