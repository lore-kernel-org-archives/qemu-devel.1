Received: from eggs.gnu.org ([2001:4830:134:3::10]:48352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fDY68-0004IC-9I
	for qemu-devel@nongnu.org; Tue, 01 May 2018 12:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fDY63-0007z9-6s
	for qemu-devel@nongnu.org; Tue, 01 May 2018 12:25:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fDY62-0007yS-SS
	for qemu-devel@nongnu.org; Tue, 01 May 2018 12:25:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11FD5300248F
	for <qemu-devel@nongnu.org>; Tue,  1 May 2018 16:25:41 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 01 May 2018 10:25:30 -0600
Message-ID: <20180501161509.28517.344.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 0/3] Update linux-headers to v4.17-rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Dave Airlie <airlied@redhat.com>, mst@redhat.com

This series is based on Michael's series moving kvm_para.h out to
standard headers, which resolves the conflict in definitions of
KVM_HINTS_DEDICATED between QEMU and kernel.

Additionally, this series moves the definition of
VIRTIO_GPU_CAPSET_VIRGL2 into QEMU code as the definition does not
exist in the upstream header and it seems unreasonable to expect
anyone wanting to update headers should manually resolve this
conflict.

Finally, vmw_pvrdma-abi.h converted to a number of __aligned_u64
entries, which our current script happily converts to an
__aligned_uint64_t, which doesn't exist, while the original
__aligned_u64 does seem to exist.  Add a sed line to undo the
conversion.

I've split these patches from the vfio series requiring the
updates including in v4.17-rc for better review converage, but
the intention would be to include them in the same pull request
as the vfio consumer.

Please let me know if there are any comments or objections to
the approaches taken here, especially cross platform issues with
handling __aligned_u64.  Thanks,

Alex

---

Alex Williamson (3):
      virtio-gpu-3d: Define VIRTIO_GPU_CAPSET_VIRGL2 elsewhere
      scripts/update-linux-headers: Update handling of __aligned_u64
      linux-headers: Update to v4.17-rc3


 include/hw/virtio/virtio-gpu.h                  |    6 
 include/standard-headers/linux/ethtool.h        |   36 ++
 include/standard-headers/linux/input.h          |    4 
 include/standard-headers/linux/pci_regs.h       |    7 
 include/standard-headers/linux/virtio_balloon.h |   19 +
 include/standard-headers/linux/virtio_gpu.h     |    1 
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
 16 files changed, 193 insertions(+), 387 deletions(-)
