Received: from eggs.gnu.org ([2001:4830:134:3::10]:39148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <daniel@drv.nu>) id 1feaP7-0005ZU-2q
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 02:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <daniel@drv.nu>) id 1feaP6-00031m-70
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 02:21:09 -0400
MIME-Version: 1.0
In-Reply-To: <20180622112237.2131-1-gersner@gmail.com>
References: <20180622112237.2131-1-gersner@gmail.com>
From: Daniel Verkamp <daniel@drv.nu>
Date: Sat, 14 Jul 2018 23:20:56 -0700
Message-ID: <CAGFXeQL4FPVeFrEiQpRjGnBMBs5oCjxjXFJ_NGWsGmOjvk75pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/5] nvme: PCI/e configuration from
 specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shimi Gersner <gersner@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>, David Sariel <davidsa@openu.ac.il>, Max Reitz <mreitz@redhat.com>

On Fri, Jun 22, 2018 at 4:22 AM, Shimi Gersner <gersner@gmail.com> wrote:
> PCI/e configuration currently does not meets specifications.
>
> Patch includes various configuration changes to support specifications
> - BAR2 to return zero when read and CMD.IOSE is not set.
> - Expose NVME configuration through IO space (Optional).
> - PCI Power Management v1.2.
> - PCIe Function Level Reset.
> - Disable QEMUs default use of PCIe Link Status (DLLLA).
> - PCIe missing AOC compliance flag.
> - Mask PCIe End-to-End TLP as RO (Unspecified by specification).
[...]
>      n->num_namespaces = 1;
>      n->num_queues = 64;
> -    n->reg_size = pow2ceil(0x1004 + 2 * (n->num_queues + 1) * 4);
> +    n->reg_size = pow2ceil(0x2000 + 2 * (n->num_queues + 1) * 4);

The existing math looks OK to me (maybe already 4 bytes larger than
necessary?). The controller registers should be 0x1000 bytes for the
fixed register set, then 2 * 4 bytes for each doorbell pair (+ 1 is
for the admin queue, and CAP.DSTRD is set to 0, so there is no extra
padding between queues). The result is also rounded up to a power of
two, so the result will typically be 8 KB.  What is the rationale for
this change?

>      n->ns_size = bs_size / (uint64_t)n->num_namespaces;
>
>      n->namespaces = g_new0(NvmeNamespace, n->num_namespaces);
> @@ -1245,6 +1295,10 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>      pci_register_bar(&n->parent_obj, 0,
>          PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
>          &n->iomem);
> +
> +    // Expose the NVME memory through Address Space IO (Optional by spec)
> +    pci_register_bar(&n->parent_obj, 2, PCI_BASE_ADDRESS_SPACE_IO, &n->iomem);

This looks like it will register the whole 4KB+ NVMe register set
(n->iomem) as an I/O space BAR, but this doesn't match the spec (see
NVMe 1.3c section 3.2, "Index/Data Pair registers"). The I/O BAR (if
implemented) should just contain two 4-byte registers, Index and Data,
that can be used to indirectly access the NVMe register set.  (Just
for curiosity, do you know of any software that uses this feature? It
could be useful for testing the implementation.)

Other minor nitpicks:
- Comment style is inconsistent with the rest of the file (// vs /* */)
- PCIe and NVMe are incorrectly capitalized a few times in comments

Thanks,
-- Daniel
