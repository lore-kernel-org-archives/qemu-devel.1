Received: from eggs.gnu.org ([2001:4830:134:3::10]:46861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC4hK-0003Q9-EZ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:50:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC4hJ-0006Hl-L7
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:50:06 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:32987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC4hJ-0006HE-FD
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:50:05 -0400
Received: by mail-ot0-x242.google.com with SMTP id l22-v6so2326697otj.0
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 07:50:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180219114332.70443-10-marcel@redhat.com>
References: <20180219114332.70443-1-marcel@redhat.com>
	<20180219114332.70443-10-marcel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 15:49:44 +0100
Message-ID: <CAFEAcA8_LPFnLjCS30vWDZM49ztHE0gvqmrTNnyb4SFTE97W7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH PULL v2 09/10] hw/rdma: Implementation of
 PVRDMA device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yuval Shaia <yuval.shaia@oracle.com>

On 19 February 2018 at 11:43, Marcel Apfelbaum <marcel@redhat.com> wrote:
> From: Yuval Shaia <yuval.shaia@oracle.com>
>
> PVRDMA is the QEMU implementation of VMware's paravirtualized RDMA device.
> It works with its Linux Kernel driver AS IS, no need for any special
> guest modifications.
>
> While it complies with the VMware device, it can also communicate with
> bare metal RDMA-enabled machines and does not require an RDMA HCA in the
> host, it can work with Soft-RoCE (rxe).
>
> It does not require the whole guest RAM to be pinned allowing memory
> over-commit and, even if not implemented yet, migration support will be
> possible with some HW assistance.
>
> Implementation is divided into 2 components, rdma general and pvRDMA
> specific functions and structures.
>
> The second PVRDMA sub-module - interaction with PCI layer.
> - Device configuration and setup (MSIX, BARs etc).
> - Setup of DSR (Device Shared Resources)
> - Setup of device ring.
> - Device management.
>
> Reviewed-by: Dotan Barak <dotanb@mellanox.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@oracle.com>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>

Hi; this is something odd I noticed reading through the code.

> +static void init_bars(PCIDevice *pdev)
> +{
> +    PVRDMADev *dev = PVRDMA_DEV(pdev);
> +
> +    /* BAR 0 - MSI-X */
> +    memory_region_init(&dev->msix, OBJECT(dev), "pvrdma-msix",
> +                       RDMA_BAR0_MSIX_SIZE);
> +    pci_register_bar(pdev, RDMA_MSIX_BAR_IDX, PCI_BASE_ADDRESS_SPACE_MEMORY,
> +                     &dev->msix);
> +
> +    /* BAR 1 - Registers */
> +    memset(&dev->regs_data, 0, sizeof(dev->regs_data));
> +    memory_region_init_io(&dev->regs, OBJECT(dev), &regs_ops, dev,
> +                          "pvrdma-regs", RDMA_BAR1_REGS_SIZE);

RDMA_BAR1_REGS_SIZE is used in pvrdma.h to declare the regs array:
    uint32_t regs_data[RDMA_BAR1_REGS_SIZE];
and that and the way that get_reg_val/set_reg_val do "addr >> 2" to
convert from an address to an array index suggest that it is the
size of the BAR in 32-bit words. However here we're passing it
as the size parameter of memory_region_init_io(), which wants a
size in bytes. Which is correct ?

thanks
-- PMM
