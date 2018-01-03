Received: from eggs.gnu.org ([2001:4830:134:3::10]:42362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eWgdc-0005qj-5I
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eWgdY-00061n-5T
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:51:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eWgdX-000613-SP
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:51:08 -0500
References: <20180103102911.35562-1-marcel@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <f7c4004a-f139-ac59-2985-5024528c0078@redhat.com>
Date: Wed, 3 Jan 2018 12:51:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180103102911.35562-1-marcel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V3 0/5] hw/pvrdma: PVRDMA device
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
Cc: yuval.shaia@oracle.com, mst@redhat.com, ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, f4bug@amsat.org

On 03/01/2018 12:29, Marcel Apfelbaum wrote:
> V2 -> V3:
>   - Addressed Michael S. Tsirkin and Philippe Mathieu-Daud=C3=A9 commen=
ts:
>     - Moved the device to hw/rdma
>   - Addressed Michael S. Tsirkin comments:
>     - Split the code into generic (hw/rdma) and VMWare
>       specific (hw/rdma/vmw)
>     - Added more details to documentation - VMware guest-host protocol.

The extra-documentation is missing from this version, we will send V4 soo=
n.

Thanks,
Marcel

>     - Remove mad processing
>     - limited the memory the Guest can pin.
>   - Addressed Philippe Mathieu-Daud=C3=A9 comment:
>     - s/roundup_pow_of_two/pow2roundup32 and move it to qemu/host-utils=
.h
>   - Added Shamit Rabinovici's review to documentation
>   - Rebased to latest master
>=20
> RFC -> V2:
>   - Full implementation of the pvrdma device
>   - Backend is an ibdevice interface, no need for the KDBR module
>=20
>=20
> General description
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> PVRDMA is the QEMU implementation of VMware's paravirtualized RDMA devi=
ce.
> It works with its Linux Kernel driver AS IS, no need for any special gu=
est
> modifications.
>=20
> While it complies with the VMware device, it can also communicate with =
bare
> metal RDMA-enabled machines and does not require an RDMA HCA in the hos=
t, it
> can work with Soft-RoCE (rxe).
>=20
> It does not require the whole guest RAM to be pinned allowing memory
> over-commit and, even if not implemented yet, migration support will be
> possible with some HW assistance.
>=20
>=20
>   Design
>   =3D=3D=3D=3D=3D=3D
>   - Follows the behavior of VMware's pvrdma device, however is not tigh=
tly
>     coupled with it and most of the code can be reused if we decide to
>     continue to a Virtio based RDMA device.
>=20
>   - It exposes 3 BARs:
>      BAR 0 - MSIX, utilize 3 vectors for command ring, async events and
>              completions
>      BAR 1 - Configuration of registers
>      BAR 2 - UAR, used to pass HW commands from driver.
>=20
>   - The device performs internal management of the RDMA
>     resources (PDs, CQs, QPs, ...), meaning the objects
>     are not directly coupled to a physical RDMA device resources.
>=20
> The pvrdma backend is an ibdevice interface that can be exposed
> either by a Soft-RoCE(rxe) device on machines with no RDMA device,
> or an HCA SRIOV function(VF/PF).
> Note that ibdevice interfaces can't be shared between pvrdma devices,
> each one requiring a separate instance (rxe or SRIOV VF).
>=20
>=20
> Tests and performance
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Tested with SoftRoCE backend (rxe)/Mellanox ConnectX3,
> and Mellanox ConnectX4 HCAs with:
>    - VMs in the same host
>    - VMs in different hosts
>    - VMs to bare metal.
>=20
> The best performance achieved with ConnectX HCAs and buffer size
> bigger than 1MB which was the line rate ~ 50Gb/s.
> The conclusion is that using the PVRDMA device there are no
> actual performance penalties compared to bare metal for big enough
> buffers (which is quite common when using RDMA), while allowing
> memory overcommit.
>=20
> Marcel Apfelbaum (3):
>    mem: add share parameter to memory-backend-ram
>    docs: add pvrdma device documentation.
>    MAINTAINERS: add entry for hw/rdma
>=20
> Yuval Shaia (2):
>    pci/shpc: Move function to generic header file
>    pvrdma: initial implementation
>=20
>   MAINTAINERS                        |   8 +
>   Makefile.objs                      |   2 +
>   backends/hostmem-file.c            |  25 +-
>   backends/hostmem-ram.c             |   4 +-
>   backends/hostmem.c                 |  21 +
>   configure                          |   9 +-
>   default-configs/arm-softmmu.mak    |   1 +
>   default-configs/i386-softmmu.mak   |   1 +
>   default-configs/x86_64-softmmu.mak |   1 +
>   docs/pvrdma.txt                    | 145 +++++++
>   exec.c                             |  26 +-
>   hw/Makefile.objs                   |   1 +
>   hw/pci/shpc.c                      |  13 +-
>   hw/rdma/Makefile.objs              |   7 +
>   hw/rdma/rdma_backend.c             | 815 ++++++++++++++++++++++++++++=
+++++++++
>   hw/rdma/rdma_backend.h             |  92 +++++
>   hw/rdma/rdma_backend_defs.h        |  62 +++
>   hw/rdma/rdma_rm.c                  | 619 ++++++++++++++++++++++++++++
>   hw/rdma/rdma_rm.h                  |  69 ++++
>   hw/rdma/rdma_rm_defs.h             | 106 +++++
>   hw/rdma/rdma_utils.h               |  36 ++
>   hw/rdma/trace-events               |   5 +
>   hw/rdma/vmw/pvrdma.h               | 123 ++++++
>   hw/rdma/vmw/pvrdma_cmd.c           | 585 ++++++++++++++++++++++++++
>   hw/rdma/vmw/pvrdma_dev_api.h       | 580 ++++++++++++++++++++++++++
>   hw/rdma/vmw/pvrdma_dev_ring.c      | 140 +++++++
>   hw/rdma/vmw/pvrdma_dev_ring.h      |  43 ++
>   hw/rdma/vmw/pvrdma_ib_verbs.h      | 400 ++++++++++++++++++
>   hw/rdma/vmw/pvrdma_main.c          | 644 ++++++++++++++++++++++++++++=
+
>   hw/rdma/vmw/pvrdma_qp_ops.c        | 212 ++++++++++
>   hw/rdma/vmw/pvrdma_qp_ops.h        |  27 ++
>   hw/rdma/vmw/pvrdma_ring.h          | 134 ++++++
>   hw/rdma/vmw/pvrdma_types.h         |  38 ++
>   hw/rdma/vmw/pvrdma_utils.c         | 135 ++++++
>   hw/rdma/vmw/pvrdma_utils.h         |  26 ++
>   hw/rdma/vmw/trace-events           |   5 +
>   include/exec/memory.h              |  23 ++
>   include/exec/ram_addr.h            |   3 +-
>   include/hw/pci/pci_ids.h           |   3 +
>   include/qemu/host-utils.h          |  10 +
>   include/qemu/osdep.h               |   2 +-
>   include/sysemu/hostmem.h           |   2 +-
>   include/sysemu/kvm.h               |   2 +-
>   memory.c                           |  16 +-
>   util/oslib-posix.c                 |   4 +-
>   util/oslib-win32.c                 |   2 +-
>   46 files changed, 5165 insertions(+), 62 deletions(-)
>   create mode 100644 docs/pvrdma.txt
>   create mode 100644 hw/rdma/Makefile.objs
>   create mode 100644 hw/rdma/rdma_backend.c
>   create mode 100644 hw/rdma/rdma_backend.h
>   create mode 100644 hw/rdma/rdma_backend_defs.h
>   create mode 100644 hw/rdma/rdma_rm.c
>   create mode 100644 hw/rdma/rdma_rm.h
>   create mode 100644 hw/rdma/rdma_rm_defs.h
>   create mode 100644 hw/rdma/rdma_utils.h
>   create mode 100644 hw/rdma/trace-events
>   create mode 100644 hw/rdma/vmw/pvrdma.h
>   create mode 100644 hw/rdma/vmw/pvrdma_cmd.c
>   create mode 100644 hw/rdma/vmw/pvrdma_dev_api.h
>   create mode 100644 hw/rdma/vmw/pvrdma_dev_ring.c
>   create mode 100644 hw/rdma/vmw/pvrdma_dev_ring.h
>   create mode 100644 hw/rdma/vmw/pvrdma_ib_verbs.h
>   create mode 100644 hw/rdma/vmw/pvrdma_main.c
>   create mode 100644 hw/rdma/vmw/pvrdma_qp_ops.c
>   create mode 100644 hw/rdma/vmw/pvrdma_qp_ops.h
>   create mode 100644 hw/rdma/vmw/pvrdma_ring.h
>   create mode 100644 hw/rdma/vmw/pvrdma_types.h
>   create mode 100644 hw/rdma/vmw/pvrdma_utils.c
>   create mode 100644 hw/rdma/vmw/pvrdma_utils.h
>   create mode 100644 hw/rdma/vmw/trace-events
>=20
