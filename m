Received: from eggs.gnu.org ([2001:4830:134:3::10]:47752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1em2dq-00039P-MB
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:22:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1em2do-0008Et-US
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:22:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52014 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1em2do-0008Ej-Ow
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:22:52 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Wed, 14 Feb 2018 21:22:20 +0200
Message-Id: <20180214192230.70287-1-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH V11 00/10] hw/pvrdma: PVRDMA device
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, yuval.shaia@oracle.com, marcel@redhat.com, mst@redhat.com, dotanb@mellanox.com, yanjun.zhu@oracle.com, ghammer@redhat.com

V10 -> V11:
 - Addressed Michael S. Tsirkin comments:
    - Split the standard-headers patch in two, one dealing with the
      update-linux-headers script while the other adds the imported heade=
rs.
    - Add comments to the update-linux-headers script explaining
      the sed transformations.
  - Added Zhu Yanjun's R-B tags (rdma patches review -- Thanks!)=20
  - Added Gal Hammer's R-B tag  (update-linux-headers patch review (Thank=
s!)
  - Rebased on latest master

V9 -> V10:
 - Addressed Peter Maydell's comments:
   - Modified license to "version 2 or any later version"
   - Added license comment on top of code files
   - Move the kernel headers to "standard-headers" and modified
     the update-linux-headers script to import them and update
     the types for QEMU. (this patch has no R-B tag, maybe someone can
     have a look, I am not sure who can review it)
   - Got an R-B from Eduardo on memory-ram-backend patch (thanks!)
   - Split the pvrdma implementation patch into 6 patches,
     preserving Dotan Barak R-B since no semantic changes were made,
     only a mechanical split.
 - Rebased on latest master

V8 -> V9:
 - Addressed Dotan Barak's (offline) comments:
   - use g_malloc instead of malloc
   - re-arrange structs for better padding
   - some cosmetic changes
   - do not try to fetch CQE when CQ is going down
   - init state of QP changed to RESET
   - modify poll_cq
   - add fix to qkey handling so now qkey=3D0 is also supported
   - add validation to gid_index
   - fix memory leak with ah_key ref
 - Addressed Eduardo Habkost comments:
   - Add the mem-backed-ram "share" option to qemu-options.hx.
 - Rebased on latest master

V7 -> V8:
 - Addressed Michael S. Tsirkin comments:
   - fail to init the pvrdma device if target page size is different
     from the host size, or if the guest RAM is not backed by memory
     and shared.
   - Update documentation to include a note on huge memory regions
     registration and remove not needed info.
 - Removed "pci/shpc: Move function to generic header file" since it
   appears in latest maintainer pull request
 - Rebased on master

V6 -> V7:
 - Addressed Philippe Mathieu-Daud=C3=A9 comments
   - modified pow2roundup32 signature
   - added his RB tag (thanks)
 - Addressed Corenlia Huck comments:
   - Compiled the pvrdma for all archs and not only x86/arm (thanks)
   - Fixed typo in documentation
 - Rebased on latest master

V5 -> V6:
 - Found a ppc machine and solved ppc compilation issues
 - Tried to fix the s390x issue (still looking of a machine)

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

Marcel Apfelbaum (5):
  mem: add share parameter to memory-backend-ram
  docs: add pvrdma device documentation.
  scripts/update-linux-headers: import pvrdma headers
  include/standard-headers: add pvrdma related headers
  MAINTAINERS: add entry for hw/rdma

Yuval Shaia (5):
  hw/rdma: Add wrappers and macros
  hw/rdma: Definitions for rdma device and rdma resource manager
  hw/rdma: Implementation of generic rdma device layers
  hw/rdma: PVRDMA commands and data-path ops
  hw/rdma: Implementation of PVRDMA device

 MAINTAINERS                                        |   8 +
 Makefile.objs                                      |   2 +
 backends/hostmem-file.c                            |  25 +-
 backends/hostmem-ram.c                             |   4 +-
 backends/hostmem.c                                 |  21 +
 configure                                          |   9 +-
 docs/pvrdma.txt                                    | 255 +++++++
 exec.c                                             |  26 +-
 hw/Makefile.objs                                   |   1 +
 hw/rdma/Makefile.objs                              |   5 +
 hw/rdma/rdma_backend.c                             | 818 +++++++++++++++=
++++++
 hw/rdma/rdma_backend.h                             |  98 +++
 hw/rdma/rdma_backend_defs.h                        |  62 ++
 hw/rdma/rdma_rm.c                                  | 544 ++++++++++++++
 hw/rdma/rdma_rm.h                                  |  69 ++
 hw/rdma/rdma_rm_defs.h                             | 104 +++
 hw/rdma/rdma_utils.c                               |  51 ++
 hw/rdma/rdma_utils.h                               |  43 ++
 hw/rdma/trace-events                               |   5 +
 hw/rdma/vmw/pvrdma.h                               | 122 +++
 hw/rdma/vmw/pvrdma_cmd.c                           | 673 +++++++++++++++=
++
 hw/rdma/vmw/pvrdma_dev_ring.c                      | 155 ++++
 hw/rdma/vmw/pvrdma_dev_ring.h                      |  42 ++
 hw/rdma/vmw/pvrdma_main.c                          | 670 +++++++++++++++=
++
 hw/rdma/vmw/pvrdma_qp_ops.c                        | 222 ++++++
 hw/rdma/vmw/pvrdma_qp_ops.h                        |  27 +
 hw/rdma/vmw/trace-events                           |   5 +
 include/exec/memory.h                              |  23 +
 include/exec/ram_addr.h                            |   3 +-
 include/hw/pci/pci_ids.h                           |   3 +
 include/qemu/osdep.h                               |   2 +-
 .../infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h      | 667 +++++++++++++++=
++
 .../drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h | 114 +++
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h        | 383 ++++++++++
 include/standard-headers/rdma/vmw_pvrdma-abi.h     | 293 ++++++++
 include/sysemu/hostmem.h                           |   2 +-
 include/sysemu/kvm.h                               |   2 +-
 memory.c                                           |  16 +-
 qemu-options.hx                                    |  10 +-
 scripts/update-linux-headers.sh                    |  30 +
 target/s390x/kvm.c                                 |   4 +-
 util/oslib-posix.c                                 |   4 +-
 util/oslib-win32.c                                 |   2 +-
 43 files changed, 5570 insertions(+), 54 deletions(-)
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
 create mode 100644 hw/rdma/vmw/pvrdma_dev_ring.c
 create mode 100644 hw/rdma/vmw/pvrdma_dev_ring.h
 create mode 100644 hw/rdma/vmw/pvrdma_main.c
 create mode 100644 hw/rdma/vmw/pvrdma_qp_ops.c
 create mode 100644 hw/rdma/vmw/pvrdma_qp_ops.h
 create mode 100644 hw/rdma/vmw/trace-events
 create mode 100644 include/standard-headers/drivers/infiniband/hw/vmw_pv=
rdma/pvrdma_dev_api.h
 create mode 100644 include/standard-headers/drivers/infiniband/hw/vmw_pv=
rdma/pvrdma_ring.h
 create mode 100644 include/standard-headers/drivers/infiniband/hw/vmw_pv=
rdma/pvrdma_verbs.h
 create mode 100644 include/standard-headers/rdma/vmw_pvrdma-abi.h

--=20
2.13.5
