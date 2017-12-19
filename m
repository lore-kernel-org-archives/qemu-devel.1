Received: from eggs.gnu.org ([2001:4830:134:3::10]:45106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRLzm-0003Id-1H
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:48:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRLzk-0002q0-HO
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:48:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eRLzk-0002p6-8I
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:48:00 -0500
Date: Tue, 19 Dec 2017 19:47:55 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171219194739-mutt-send-email-mst@kernel.org>
References: <20171217125457.3429-1-marcel@redhat.com>
	<20171217125457.3429-4-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171217125457.3429-4-marcel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V2 3/5] docs: add pvrdma device
 documentation
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

On Sun, Dec 17, 2017 at 02:54:55PM +0200, Marcel Apfelbaum wrote:
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>  docs/pvrdma.txt | 145 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 145 insertions(+)
>  create mode 100644 docs/pvrdma.txt
> 
> diff --git a/docs/pvrdma.txt b/docs/pvrdma.txt
> new file mode 100644
> index 0000000000..74c5cf2495
> --- /dev/null
> +++ b/docs/pvrdma.txt
> @@ -0,0 +1,145 @@
> +Paravirtualized RDMA Device (PVRDMA)
> +====================================
> +
> +
> +1. Description
> +===============
> +PVRDMA is the QEMU implementation of VMware's paravirtualized RDMA device.
> +It works with its Linux Kernel driver AS IS, no need for any special guest
> +modifications.
> +
> +While it complies with the VMware device, it can also communicate with bare
> +metal RDMA-enabled machines and does not require an RDMA HCA in the host, it
> +can work with Soft-RoCE (rxe).
> +
> +It does not require the whole guest RAM to be pinned allowing memory
> +over-commit and, even if not implemented yet, migration support will be
> +possible with some HW assistance.
> +
> +A project presentation accompany this document:
> +- http://events.linuxfoundation.org/sites/events/files/slides/lpc-2017-pvrdma-marcel-apfelbaum-yuval-shaia.pdf
> +
> +
> +
> +2. Setup
> +========
> +
> +
> +2.1 Guest setup
> +===============
> +Fedora 27+ kernels work out of the box, older distributions
> +require updating the kernel to 4.14 to include the pvrdma driver.
> +
> +However the libpvrdma library needed by User Level Software is still
> +not available as part of the distributions, so the rdma-core library
> +needs to be compiled and optionally installed.
> +
> +Please follow the instructions at:
> +  https://github.com/linux-rdma/rdma-core.git
> +
> +
> +2.2 Host Setup
> +==============
> +The pvrdma backend is an ibdevice interface that can be exposed
> +either by a Soft-RoCE(rxe) device on machines with no RDMA device,
> +or an HCA SRIOV function(VF/PF).
> +Note that ibdevice interfaces can't be shared between pvrdma devices,
> +each one requiring a separate instance (rxe or SRIOV VF).
> +
> +
> +2.2.1 Soft-RoCE backend(rxe)
> +===========================
> +A stable version of rxe is required, Fedora 27+ or a Linux
> +Kernel 4.14+ is preferred.
> +
> +The rdma_rxe module is part of the Linux Kernel but not loaded by default.
> +Install the User Level library (librxe) following the instructions from:
> +https://github.com/SoftRoCE/rxe-dev/wiki/rxe-dev:-Home
> +
> +Associate an ETH interface with rxe by running:
> +   rxe_cfg add eth0
> +An rxe0 ibdevice interface will be created and can be used as pvrdma backend.
> +
> +
> +2.2.2 RDMA device Virtual Function backend
> +==========================================
> +Nothing special is required, the pvrdma device can work not only with
> +Ethernet Links, but also Infinibands Links.
> +All is needed is an ibdevice with an active port, for Mellanox cards
> +will be something like mlx5_6 which can be the backend.
> +
> +
> +2.2.3 QEMU setup
> +================
> +Configure QEMU with --enable-rdma flag, installing
> +the required RDMA libraries.
> +
> +
> +3. Usage
> +========
> +Currently the device is working only with memory backed RAM
> +and it must be mark as "shared":
> +   -m 1G \
> +   -object memory-backend-ram,id=mb1,size=1G,share \
> +   -numa node,memdev=mb1 \
> +
> +The pvrdma device is composed of two functions:
> + - Function 0 is a vmxnet Ethernet Device which is redundant in Guest
> +   but is required to pass the ibdevice GID using its MAC.
> +   Examples:
> +     For an rxe backend using eth0 interface it will use its mac:
> +       -device vmxnet3,addr=<slot>.0,multifunction=on,mac=<eth0 MAC>
> +     For an SRIOV VF, we take the Ethernet Interface exposed by it:
> +       -device vmxnet3,multifunction=on,mac=<RoCE eth MAC>
> + - Function 1 is the actual device:
> +       -device pvrdma,addr=<slot>.1,backend-dev=<ibdevice>,backend-gid-idx=<gid>,backend-port=<port>
> +   where the ibdevice can be rxe or RDMA VF (e.g. mlx5_4)
> + Note: Pay special attention that the GID at backend-gid-idx matches vmxnet's MAC.
> + The rules of conversion are part of the RoCE spec, but since manual conversion
> + is not required, spotting problems is not hard:
> +    Example: GID: fe80:0000:0000:0000:7efe:90ff:fecb:743a
> +             MAC: 7c:fe:90:cb:74:3a
> +    Note the difference between the first byte of the MAC and the GID.
> +
> +
> +4. Implementation details
> +=========================
> +The device acts like a proxy between the Guest Driver and the host
> +ibdevice interface.
> +On configuration path:
> + - For every hardware resource request (PD/QP/CQ/...) the pvrdma will request
> +   a resource from the backend interface, maintaining a 1-1 mapping
> +   between the guest and host.
> +On data path:
> + - Every post_send/receive received from the guest will be converted into
> +   a post_send/receive for the backend. The buffers data will not be touched
> +   or copied resulting in near bare-metal performance for large enough buffers.
> + - Completions from the backend interface will result in completions for
> +   the pvrdma device.


Where's the host/guest interface documented?

> +
> +
> +5. Limitations
> +==============
> +- The device obviously is limited by the Guest Linux Driver features implementation
> +  of the VMware device API.
> +- Memory registration mechanism requires mremap for every page in the buffer in order
> +  to map it to a contiguous virtual address range. Since this is not the data path
> +  it should not matter much.
> +- QEMU cannot map guest RAM from a file descriptor if a pvrdma device is attached,
> +  so it can't work with huge pages. The limitation will be addressed in the future,
> +  however QEMU allocates Gust RAM with MADV_HUGEPAGE so if there are enough huge
> +  pages available, QEMU will use them.
> +- As previously stated, migration is not supported yet, however with some hardware
> +  support can be done.
> +
> +
> +
> +6. Performance
> +==============
> +By design the pvrdma device exits on each post-send/receive, so for small buffers
> +the performance is affected; however for medium buffers it will became close to
> +bare metal and from 1MB buffers and  up it reaches bare metal performance.
> +(tested with 2 VMs, the pvrdma devices connected to 2 VFs of the same device)
> +
> +All the above assumes no memory registration is done on data path.
> -- 
> 2.13.5
