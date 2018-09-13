Received: from eggs.gnu.org ([2001:4830:134:3::10]:45752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g0I1o-0005HO-9S
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 23:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g0Hqi-0004j9-Ly
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 22:59:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50322 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1g0Hqi-0004is-Fw
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 22:59:20 -0400
Date: Thu, 13 Sep 2018 10:59:10 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180913025910.GB10763@xz-x1>
References: <1536684589-11718-1-git-send-email-brijesh.singh@amd.com>
	<1536684589-11718-4-git-send-email-brijesh.singh@amd.com>
	<20180912033749.GA3829@xz-x1>
	<d8bcd7ce-164a-a69f-75fe-e8ebf7345d6b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d8bcd7ce-164a-a69f-75fe-e8ebf7345d6b@amd.com>
Subject: Re: [Qemu-devel] [PATCH 3/6] x86_iommu/amd: Add interrupt remap
 support when VAPIC is not enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, Tom Lendacky <Thomas.Lendacky@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Richard Henderson <rth@twiddle.net>

On Wed, Sep 12, 2018 at 01:50:34PM -0500, Brijesh Singh wrote:

[...]

> > > +     */
> > > +    if (sid == X86_IOMMU_SID_INVALID) {
> > > +        sid = AMDVI_SB_IOAPIC_ID;
> > > +    }
> > > +
> > > +    amdvi_get_dte(iommu, sid, dte);
> > 
> > Mind to check the return value?
> > 
> > After all it's provided, and we have the fault path to handle it in
> > this function.
> > 
> 
> The amdvi_get_dte(..) does not check the IR bit. It only checks for the
> address-translation enabled bit. I can extend the function to check for
> IR flag so that we can check the error status of this function.

It seems to me that amdvi_get_dte() is checking against things like:
general read errors, reserved bits error, and proper set of
AMDVI_DEV_VALID.  These seem still make sense to IR.

> 
> 
> > > +
> > > +    /* interrupt remapping is disabled */
> > > +    if (!(dte[2] & AMDVI_IR_REMAP_ENABLE)) {
> > > +        memcpy(translated, origin, sizeof(*origin));
> > > +        goto out;
> > > +    }
> > > +
> > > +    /* deliver_mode and dest_mode from MSI data */
> > > +    dest_mode = (origin->data >> 11) & 1;       /* Bit 11 */
> > > +    delivery_mode = (origin->data >> 7) & 7;    /* Bits 10:8 */
> > 
> > Nit: The comments are already nice, though IMHO some mask macros would
> > be nicer, like AMDVI_IR_PHYS_ADDR_MASK.
> > 
> > Also, could you hint me where are these things defined in the spec?
> > I'm looking at Figure 14, but there MSI data bits 15:11 are defined as
> > "XXXXXb", and bits 10:8 seems to be part of the interrupt table offset.
> > 
> 
> Since we are not emulating the Hyper Transport hence we need to look at
> the encoding of the delivery mode of MSI data, which  is the same as
> APIC/IOAPIC delivery mode encoding. See
> 
> * For MSI Data, https://pdfs.semanticscholar.org/presentation/9420/c279e942eca568157711ef5c92b800c40a79.pdf
>   (page 5)

[1]

> * For IOAPIC, https://wiki.osdev.org/APIC
> 
> They are similar to Hyper Transport MT encoding, but not quite the same.
> 
> enum ioapic_irq_destination_types {
>         dest_Fixed              = 0,
>         dest_LowestPrio         = 1,
>         dest_SMI                = 2,
>         dest__reserved_1        = 3,
>         dest_NMI                = 4,
>         dest_INIT               = 5,
>         dest__reserved_2        = 6,
>         dest_ExtINT             = 7
> };
> 
> I will add the comments in the code and also provide the link

I just misunderstood since you did this before the switch.  Maybe you
could consider move this after the switch then since these dest_mode
things are not valid for all the cases.

Meanwhile, you are refering to general MSI/IOAPIC definitions, then I
don't see why dest_mode is bit 11 of MSI data; what I see is that it
should be bit 2 of MSI address.  That's exactly on the slides you
provided [1].  Would you help double confirm?

[...]

> > > +/* Generic IRQ entry information */
> > > +struct AMDVIIrq {
> > > +    /* Used by both IOAPIC/MSI interrupt remapping */
> > > +    uint8_t trigger_mode;
> > > +    uint8_t vector;
> > > +    uint8_t delivery_mode;
> > > +    uint32_t dest;
> > > +    uint8_t dest_mode;
> > > +
> > > +    /* only used by MSI interrupt remapping */
> > > +    uint8_t redir_hint;
> > > +    uint8_t msi_addr_last_bits;
> > > +};
> > 
> > This is VTDIrq.
> > 
> > We're having some similar codes between the vt-d and amd-vi ir
> > implementations.  I'm thinking to what extend we could share the code.
> > I don't think it would worth it if we need to spend too much extra
> > time, but things like this one might still be good candidates that we
> > can share them at the very beginning since it won't be that hard (like
> > what you did in patch 1).
> > 
> > (maybe also things like amdvi_generate_msi_message but I'm not sure)
> > 
> 
> I will see what can be done to move the VTDIrq struct and msi message
> generation in common file.

That'll be nice.  Thank you.

-- 
Peter Xu
