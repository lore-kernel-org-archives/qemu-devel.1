Received: from eggs.gnu.org ([2001:4830:134:3::10]:54805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <daniel@drv.nu>) id 1fvPCP-0006qH-Ba
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:49:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <daniel@drv.nu>) id 1fvP8M-0005Gd-LP
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:45:23 -0400
MIME-Version: 1.0
References: <20180622112237.2131-1-gersner@gmail.com>
	<CAGFXeQL4FPVeFrEiQpRjGnBMBs5oCjxjXFJ_NGWsGmOjvk75pg@mail.gmail.com>
	<CALKrh6mPkirNjwkCMLWU4d+eQnnkYDmjPVAWccP4K4tQDxxLaA@mail.gmail.com>
In-Reply-To: <CALKrh6mPkirNjwkCMLWU4d+eQnnkYDmjPVAWccP4K4tQDxxLaA@mail.gmail.com>
From: Daniel Verkamp <daniel@drv.nu>
Date: Thu, 30 Aug 2018 08:45:05 -0700
Message-ID: <CAGFXeQKjnCvY7hRw_1MxZOROhHbsdHM9YPL-QzzWeJZcu0A8Jg@mail.gmail.com>
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

Hi Shimi,

On Sun, Aug 26, 2018 at 2:50 PM Gersner <gersner@gmail.com> wrote:
>
> Hi Daniel,
> Thanks for taking a look. Comments are inline.
>
> Gersner.
>
> On Sun, Jul 15, 2018 at 9:21 AM Daniel Verkamp <daniel@drv.nu> wrote:
>>
>> On Fri, Jun 22, 2018 at 4:22 AM, Shimi Gersner <gersner@gmail.com> wrote:
>> > PCI/e configuration currently does not meets specifications.
>> >
>> > Patch includes various configuration changes to support specifications
>> > - BAR2 to return zero when read and CMD.IOSE is not set.
>> > - Expose NVME configuration through IO space (Optional).
>> > - PCI Power Management v1.2.
>> > - PCIe Function Level Reset.
>> > - Disable QEMUs default use of PCIe Link Status (DLLLA).
>> > - PCIe missing AOC compliance flag.
>> > - Mask PCIe End-to-End TLP as RO (Unspecified by specification).
>> [...]
>> >      n->num_namespaces = 1;
>> >      n->num_queues = 64;
>> > -    n->reg_size = pow2ceil(0x1004 + 2 * (n->num_queues + 1) * 4);
>> > +    n->reg_size = pow2ceil(0x2000 + 2 * (n->num_queues + 1) * 4);
>>
>> The existing math looks OK to me (maybe already 4 bytes larger than
>> necessary?). The controller registers should be 0x1000 bytes for the
>> fixed register set, then 2 * 4 bytes for each doorbell pair (+ 1 is
>> for the admin queue, and CAP.DSTRD is set to 0, so there is no extra
>> padding between queues). The result is also rounded up to a power of
>> two, so the result will typically be 8 KB.  What is the rationale for
>> this change?
>
> You are correct, this change shouldn't be here. It was made during tests against the
> nvme compliance which failed here.

If the NVMe compliance test requires it, that is probably sufficient
reason to change it - although it would be interesting to hear their
rationale.

> The specification states that bits 0 to 13 are RO, which implicitly suggests
> that the minimal size of this BAR should be at least 16K as this is a standard
> way to determine the BAR size on PCI (AFAIK). On the contrary it doesn't
> fit very well with the memory mapped laid out on 3.1 Register Definition
> of the 1.3b nvme spec. Any idea?

You're right, the MLBAR section of the NVMe spec does seem to indicate
that up to bit 13 should be reserved/RO.  This is also probably a good
enough reason to make the change, as long as this reason is provided.

>
> Additionally it does look like it has an extra 4 bytes.
>
>>
>>
>> >      n->ns_size = bs_size / (uint64_t)n->num_namespaces;
>> >
>> >      n->namespaces = g_new0(NvmeNamespace, n->num_namespaces);
>> > @@ -1245,6 +1295,10 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>> >      pci_register_bar(&n->parent_obj, 0,
>> >          PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
>> >          &n->iomem);
>> > +
>> > +    // Expose the NVME memory through Address Space IO (Optional by spec)
>> > +    pci_register_bar(&n->parent_obj, 2, PCI_BASE_ADDRESS_SPACE_IO, &n->iomem);
>>
>> This looks like it will register the whole 4KB+ NVMe register set
>> (n->iomem) as an I/O space BAR, but this doesn't match the spec (see
>> NVMe 1.3c section 3.2, "Index/Data Pair registers"). The I/O BAR (if
>> implemented) should just contain two 4-byte registers, Index and Data,
>> that can be used to indirectly access the NVMe register set.  (Just
>> for curiosity, do you know of any software that uses this feature? It
>> could be useful for testing the implementation.)
>
> Very nice catch. We indeed totally miss-interpreted the specification here.
>
> We use the compliance suit for sanity, but it doesn't actually use this feature,
> just verifies the configuration of the registers.
>
> We will go with rolling back this feature as this is optional.

This is probably the right move; I don't know of any real hardware
devices that implement it (and therefore I doubt any software will
require it).  However, it should not be too difficult to add an
implementation of this feature; if you are interested, take a look at
the ahci_idp_read/ahci_idp_write functions - the NVMe index/data pair
should be very similar.

> Question - I'm having hard time to determine from the specification - As
> this is optional, how device drivers determine if it is available? Does it
> simply the CMD.IOSE flag from the PCI? And if so, what is
> the standard way in QEMU to disable the flag completely?

Based on the wording in NVMe 1.3 section 3.2, it seems like the only
indication of support for Index/Data Pair is whether BAR2 is filled
out.  I believe PCI defines unused BARs to be all 0s, so software
should be able to use this to determine whether the feature is
provided by a particular NVMe PCIe device, and removing the
pci_register_bar() call should be enough to accomplish this from the
QEMU side.

Thanks,
-- Daniel
