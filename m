Received: from eggs.gnu.org ([2001:4830:134:3::10]:33463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRMGh-0003c8-Tk
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 13:05:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRMGe-0005hX-Pz
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 13:05:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eRMGe-0005gq-Gw
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 13:05:28 -0500
Date: Tue, 19 Dec 2017 20:05:18 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171219194951-mutt-send-email-mst@kernel.org>
References: <20171217125457.3429-1-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171217125457.3429-1-marcel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V2 0/5] hw/pvrdma: PVRDMA device
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, imammedo@redhat.com, yuval.shaia@oracle.com, pbonzini@redhat.com

On Sun, Dec 17, 2017 at 02:54:52PM +0200, Marcel Apfelbaum wrote:
> RFC -> V2:
>  - Full implementation of the pvrdma device
>  - Backend is an ibdevice interface, no need for the KDBR module
> 
> General description
> ===================
> PVRDMA is the QEMU implementation of VMware's paravirtualized RDMA device.
> It works with its Linux Kernel driver AS IS, no need for any special guest
> modifications.
> 
> While it complies with the VMware device, it can also communicate with bare
> metal RDMA-enabled machines and does not require an RDMA HCA in the host, it
> can work with Soft-RoCE (rxe).
> 
> It does not require the whole guest RAM to be pinned

What happens if guest attempts to register all its memory?

> allowing memory
> over-commit
> and, even if not implemented yet, migration support will be
> possible with some HW assistance.

What does "HW assistance" mean here?
Can it work with any existing hardware?

> 
>  Design
>  ======
>  - Follows the behavior of VMware's pvrdma device, however is not tightly
>    coupled with it

Everything seems to be in pvrdma. Since it's not coupled, could you
split code to pvrdma specific and generic parts?

> and most of the code can be reused if we decide to
>    continue to a Virtio based RDMA device.

I suspect that without virtio we won't be able to do any future
extensions.

>  - It exposes 3 BARs:
>     BAR 0 - MSIX, utilize 3 vectors for command ring, async events and
>             completions
>     BAR 1 - Configuration of registers

What does this mean?

>     BAR 2 - UAR, used to pass HW commands from driver.

A detailed description of above belongs in documentation.

>  - The device performs internal management of the RDMA
>    resources (PDs, CQs, QPs, ...), meaning the objects
>    are not directly coupled to a physical RDMA device resources.

I am wondering how do you make connections? QP#s are exposed on
the wire during connection management.

> The pvrdma backend is an ibdevice interface that can be exposed
> either by a Soft-RoCE(rxe) device on machines with no RDMA device,
> or an HCA SRIOV function(VF/PF).
> Note that ibdevice interfaces can't be shared between pvrdma devices,
> each one requiring a separate instance (rxe or SRIOV VF).

So what's the advantage of this over pass-through then?


> 
> Tests and performance
> =====================
> Tested with SoftRoCE backend (rxe)/Mellanox ConnectX3,
> and Mellanox ConnectX4 HCAs with:
>   - VMs in the same host
>   - VMs in different hosts 
>   - VMs to bare metal.
> 
> The best performance achieved with ConnectX HCAs and buffer size
> bigger than 1MB which was the line rate ~ 50Gb/s.
> The conclusion is that using the PVRDMA device there are no
> actual performance penalties compared to bare metal for big enough
> buffers (which is quite common when using RDMA), while allowing
> memory overcommit.
> 
> Marcel Apfelbaum (3):
>   mem: add share parameter to memory-backend-ram
>   docs: add pvrdma device documentation.
>   MAINTAINERS: add entry for hw/net/pvrdma
> 
> Yuval Shaia (2):
>   pci/shpc: Move function to generic header file
>   pvrdma: initial implementation
> 
>  MAINTAINERS                         |   7 +
>  Makefile.objs                       |   1 +
>  backends/hostmem-file.c             |  25 +-
>  backends/hostmem-ram.c              |   4 +-
>  backends/hostmem.c                  |  21 +
>  configure                           |   9 +-
>  default-configs/arm-softmmu.mak     |   2 +
>  default-configs/i386-softmmu.mak    |   1 +
>  default-configs/x86_64-softmmu.mak  |   1 +
>  docs/pvrdma.txt                     | 145 ++++++
>  exec.c                              |  26 +-
>  hw/net/Makefile.objs                |   7 +
>  hw/net/pvrdma/pvrdma.h              | 179 +++++++
>  hw/net/pvrdma/pvrdma_backend.c      | 986 ++++++++++++++++++++++++++++++++++++
>  hw/net/pvrdma/pvrdma_backend.h      |  74 +++
>  hw/net/pvrdma/pvrdma_backend_defs.h |  68 +++
>  hw/net/pvrdma/pvrdma_cmd.c          | 338 ++++++++++++
>  hw/net/pvrdma/pvrdma_defs.h         | 121 +++++
>  hw/net/pvrdma/pvrdma_dev_api.h      | 580 +++++++++++++++++++++
>  hw/net/pvrdma/pvrdma_dev_ring.c     | 138 +++++
>  hw/net/pvrdma/pvrdma_dev_ring.h     |  42 ++
>  hw/net/pvrdma/pvrdma_ib_verbs.h     | 399 +++++++++++++++
>  hw/net/pvrdma/pvrdma_main.c         | 664 ++++++++++++++++++++++++
>  hw/net/pvrdma/pvrdma_qp_ops.c       | 187 +++++++
>  hw/net/pvrdma/pvrdma_qp_ops.h       |  26 +
>  hw/net/pvrdma/pvrdma_ring.h         | 134 +++++
>  hw/net/pvrdma/pvrdma_rm.c           | 791 +++++++++++++++++++++++++++++
>  hw/net/pvrdma/pvrdma_rm.h           |  54 ++
>  hw/net/pvrdma/pvrdma_rm_defs.h      | 111 ++++
>  hw/net/pvrdma/pvrdma_types.h        |  37 ++
>  hw/net/pvrdma/pvrdma_utils.c        | 133 +++++
>  hw/net/pvrdma/pvrdma_utils.h        |  41 ++
>  hw/net/pvrdma/trace-events          |   9 +
>  hw/pci/shpc.c                       |  11 +-
>  include/exec/memory.h               |  23 +
>  include/exec/ram_addr.h             |   3 +-
>  include/hw/pci/pci_ids.h            |   3 +
>  include/qemu/cutils.h               |  10 +
>  include/qemu/osdep.h                |   2 +-
>  include/sysemu/hostmem.h            |   2 +-
>  include/sysemu/kvm.h                |   2 +-
>  memory.c                            |  16 +-
>  util/oslib-posix.c                  |   4 +-
>  util/oslib-win32.c                  |   2 +-
>  44 files changed, 5378 insertions(+), 61 deletions(-)
>  create mode 100644 docs/pvrdma.txt
>  create mode 100644 hw/net/pvrdma/pvrdma.h
>  create mode 100644 hw/net/pvrdma/pvrdma_backend.c
>  create mode 100644 hw/net/pvrdma/pvrdma_backend.h
>  create mode 100644 hw/net/pvrdma/pvrdma_backend_defs.h
>  create mode 100644 hw/net/pvrdma/pvrdma_cmd.c
>  create mode 100644 hw/net/pvrdma/pvrdma_defs.h
>  create mode 100644 hw/net/pvrdma/pvrdma_dev_api.h
>  create mode 100644 hw/net/pvrdma/pvrdma_dev_ring.c
>  create mode 100644 hw/net/pvrdma/pvrdma_dev_ring.h
>  create mode 100644 hw/net/pvrdma/pvrdma_ib_verbs.h
>  create mode 100644 hw/net/pvrdma/pvrdma_main.c
>  create mode 100644 hw/net/pvrdma/pvrdma_qp_ops.c
>  create mode 100644 hw/net/pvrdma/pvrdma_qp_ops.h
>  create mode 100644 hw/net/pvrdma/pvrdma_ring.h
>  create mode 100644 hw/net/pvrdma/pvrdma_rm.c
>  create mode 100644 hw/net/pvrdma/pvrdma_rm.h
>  create mode 100644 hw/net/pvrdma/pvrdma_rm_defs.h
>  create mode 100644 hw/net/pvrdma/pvrdma_types.h
>  create mode 100644 hw/net/pvrdma/pvrdma_utils.c
>  create mode 100644 hw/net/pvrdma/pvrdma_utils.h
>  create mode 100644 hw/net/pvrdma/trace-events
> 
> -- 
> 2.13.5
