Received: from eggs.gnu.org ([2001:4830:134:3::10]:40611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eY6di-0004yj-D6
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 03:49:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eY6dd-0000iL-Gd
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 03:49:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eY6dd-0000g8-7n
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 03:49:05 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Sun,  7 Jan 2018 10:48:54 +0200
Message-Id: <20180107084859.84239-1-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH V5 0/5] hw/pvrdma: PVRDMA device implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yuval.shaia@oracle.com, marcel@redhat.com, mst@redhat.com, ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com

V4 -> V5:
 - Fixed (at least tried to) compilation issues

V3 -> V4:
 - Fixed documentation (added more impl details)
 - Fixed compilation errors discovered by patchew.
 - Addressed Michael S. Tsirkin comments:
   - Removed unnecessary typedefs and replace them with
     macros in VMware header files, together with explanations.
   - Moved more code from vmw specific to rdma generic code.
   - Added page size limitations to the documentation.

V2 -> V3:
 - Addressed Michael S. Tsirkin and Philippe Mathieu-Daud=C3=A9 comments:
   - Moved the device to hw/rdma
 - Addressed Michael S. Tsirkin comments:
   - Split the code into generic (hw/rdma) and VMWare
     specific (hw/rdma/vmw)
   - Added more details to documentation - VMware guest-host protocol.
   - Remove mad processing
   - limited the memory the Guest can pin.
 - Addressed Philippe Mathieu-Daud=C3=A9 comment:
   - s/roundup_pow_of_two/pow2roundup32 and move it to qemu/host-utils.h=20
 - Added Shamit Rabinovici's review to documentation
 - Rebased to latest master=20

RFC -> V2:
 - Full implementation of the pvrdma device
 - Backend is an ibdevice interface, no need for the KDBR module


General description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
PVRDMA is the QEMU implementation of VMware's paravirtualized RDMA device=
.
It works with its Linux Kernel driver AS IS, no need for any special gues=
t
modifications.

While it complies with the VMware device, it can also communicate with ba=
re
metal RDMA-enabled machines and does not require an RDMA HCA in the host,=
 it
can work with Soft-RoCE (rxe).

It does not require the whole guest RAM to be pinned allowing memory
over-commit and, even if not implemented yet, migration support will be
possible with some HW assistance.


 Design
 =3D=3D=3D=3D=3D=3D
 - Follows the behavior of VMware's pvrdma device, however is not tightly
   coupled with it and most of the code can be reused if we decide to
   continue to a Virtio based RDMA device.

 - It exposes 3 BARs:
    BAR 0 - MSIX, utilize 3 vectors for command ring, async events and
            completions
    BAR 1 - Configuration of registers
    BAR 2 - UAR, used to pass HW commands from driver.

 - The device performs internal management of the RDMA
   resources (PDs, CQs, QPs, ...), meaning the objects
   are not directly coupled to a physical RDMA device resources.

The pvrdma backend is an ibdevice interface that can be exposed
either by a Soft-RoCE(rxe) device on machines with no RDMA device,
or an HCA SRIOV function(VF/PF).
Note that ibdevice interfaces can't be shared between pvrdma devices,
each one requiring a separate instance (rxe or SRIOV VF).


Tests and performance
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Tested with SoftRoCE backend (rxe)/Mellanox ConnectX3,
and Mellanox ConnectX4 HCAs with:
  - VMs in the same host
  - VMs in different hosts=20
  - VMs to bare metal.

The best performance achieved with ConnectX HCAs and buffer size
bigger than 1MB which was the line rate ~ 50Gb/s.
The conclusion is that using the PVRDMA device there are no
actual performance penalties compared to bare metal for big enough
buffers (which is quite common when using RDMA), while allowing
memory overcommit.

Marcel Apfelbaum (3):
  mem: add share parameter to memory-backend-ram
  docs: add pvrdma device documentation.
  MAINTAINERS: add entry for hw/rdma

Yuval Shaia (2):
  pci/shpc: Move function to generic header file
  pvrdma: initial implementation

 MAINTAINERS                        |   8 +
 Makefile.objs                      |   2 +
 backends/hostmem-file.c            |  25 +-
 backends/hostmem-ram.c             |   4 +-
 backends/hostmem.c                 |  21 +
 configure                          |   9 +-
 default-configs/arm-softmmu.mak    |   1 +
 default-configs/i386-softmmu.mak   |   1 +
 default-configs/x86_64-softmmu.mak |   1 +
 docs/pvrdma.txt                    | 254 ++++++++++++
 exec.c                             |  26 +-
 hw/Makefile.objs                   |   1 +
 hw/pci/shpc.c                      |  13 +-
 hw/rdma/Makefile.objs              |   6 +
 hw/rdma/rdma_backend.c             | 815 +++++++++++++++++++++++++++++++=
++++++
 hw/rdma/rdma_backend.h             |  92 +++++
 hw/rdma/rdma_backend_defs.h        |  62 +++
 hw/rdma/rdma_rm.c                  | 619 ++++++++++++++++++++++++++++
 hw/rdma/rdma_rm.h                  |  69 ++++
 hw/rdma/rdma_rm_defs.h             | 106 +++++
 hw/rdma/rdma_utils.c               |  52 +++
 hw/rdma/rdma_utils.h               |  43 ++
 hw/rdma/trace-events               |   5 +
 hw/rdma/vmw/pvrdma.h               | 122 ++++++
 hw/rdma/vmw/pvrdma_cmd.c           | 679 ++++++++++++++++++++++++++++++
 hw/rdma/vmw/pvrdma_dev_api.h       | 602 +++++++++++++++++++++++++++
 hw/rdma/vmw/pvrdma_dev_ring.c      | 139 +++++++
 hw/rdma/vmw/pvrdma_dev_ring.h      |  42 ++
 hw/rdma/vmw/pvrdma_ib_verbs.h      | 433 ++++++++++++++++++++
 hw/rdma/vmw/pvrdma_main.c          | 644 +++++++++++++++++++++++++++++
 hw/rdma/vmw/pvrdma_qp_ops.c        | 212 ++++++++++
 hw/rdma/vmw/pvrdma_qp_ops.h        |  27 ++
 hw/rdma/vmw/pvrdma_ring.h          | 134 ++++++
 hw/rdma/vmw/trace-events           |   5 +
 hw/rdma/vmw/vmw_pvrdma-abi.h       | 311 ++++++++++++++
 include/exec/memory.h              |  23 ++
 include/exec/ram_addr.h            |   3 +-
 include/hw/pci/pci_ids.h           |   3 +
 include/qemu/host-utils.h          |  10 +
 include/qemu/osdep.h               |   2 +-
 include/sysemu/hostmem.h           |   2 +-
 include/sysemu/kvm.h               |   2 +-
 memory.c                           |  16 +-
 target/s390x/kvm.c                 |   2 +-
 util/oslib-posix.c                 |   4 +-
 util/oslib-win32.c                 |   2 +-
 46 files changed, 5591 insertions(+), 63 deletions(-)
 create mode 100644 docs/pvrdma.txt
 create mode 100644 hw/rdma/Makefile.objs
 create mode 100644 hw/rdma/rdma_backend.c
 create mode 100644 hw/rdma/rdma_backend.h
 create mode 100644 hw/rdma/rdma_backend_defs.h
 create mode 100644 hw/rdma/rdma_rm.c
 create mode 100644 hw/rdma/rdma_rm.h
 create mode 100644 hw/rdma/rdma_rm_defs.h
 create mode 100644 hw/rdma/rdma_utils.c
 create mode 100644 hw/rdma/rdma_utils.h
 create mode 100644 hw/rdma/trace-events
 create mode 100644 hw/rdma/vmw/pvrdma.h
 create mode 100644 hw/rdma/vmw/pvrdma_cmd.c
 create mode 100644 hw/rdma/vmw/pvrdma_dev_api.h
 create mode 100644 hw/rdma/vmw/pvrdma_dev_ring.c
 create mode 100644 hw/rdma/vmw/pvrdma_dev_ring.h
 create mode 100644 hw/rdma/vmw/pvrdma_ib_verbs.h
 create mode 100644 hw/rdma/vmw/pvrdma_main.c
 create mode 100644 hw/rdma/vmw/pvrdma_qp_ops.c
 create mode 100644 hw/rdma/vmw/pvrdma_qp_ops.h
 create mode 100644 hw/rdma/vmw/pvrdma_ring.h
 create mode 100644 hw/rdma/vmw/trace-events
 create mode 100644 hw/rdma/vmw/vmw_pvrdma-abi.h

--=20
2.13.5
