Received: from eggs.gnu.org ([2001:4830:134:3::10]:34383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gMRYO-0002VE-Iq
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 00:48:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gMRYJ-0005u1-Du
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 00:48:00 -0500
Received: from mga01.intel.com ([192.55.52.88]:56893)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.c.zhang@linux.intel.com>)
	id 1gMRYJ-0005sQ-2t
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 00:47:55 -0500
Date: Tue, 13 Nov 2018 13:45:44 +0800
From: Yu Zhang <yu.c.zhang@linux.intel.com>
Message-ID: <20181113054544.y7gbcf6wkyud2igw@linux.intel.com>
References: <1541764187-10732-1-git-send-email-yu.c.zhang@linux.intel.com>
	<1541764187-10732-3-git-send-email-yu.c.zhang@linux.intel.com>
	<20181112083634.GC20675@xz-x1>
	<20181112094201.qzeateh35cfozu7n@linux.intel.com>
	<20181113033707.GH20675@xz-x1> <20181113050451.GI20675@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113050451.GI20675@xz-x1>
Subject: Re: [Qemu-devel] [PATCH v1 2/3] intel-iommu: extend VTD emulation
 to allow 57-bit IOVA address width.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, Nov 13, 2018 at 01:04:51PM +0800, Peter Xu wrote:
> On Tue, Nov 13, 2018 at 11:37:07AM +0800, Peter Xu wrote:
> > On Mon, Nov 12, 2018 at 05:42:01PM +0800, Yu Zhang wrote:
> > > On Mon, Nov 12, 2018 at 04:36:34PM +0800, Peter Xu wrote:
> > > > On Fri, Nov 09, 2018 at 07:49:46PM +0800, Yu Zhang wrote:
> > > > > A 5-level paging capable VM may choose to use 57-bit IOVA address width.
> > > > > E.g. guest applications like DPDK prefer to use its VA as IOVA when
> > > > > performing VFIO map/unmap operations, to avoid the burden of managing the
> > > > > IOVA space.
> > > > 
> > > > Since you mentioned about DPDK... I'm just curious that whether have
> > > > you tested the patchset with the 57bit-enabled machines with DPDK VA
> > > > mode running in the guest? That would be something nice to mention in
> > > > the cover letter if you have.
> > > > 
> > > 
> > > Hah. Maybe I shall not mention DPDK here. 
> > > 
> > > The story is that we heard the requirement, saying applications like DPDK
> > > would need 5-level paging in IOMMU side. And I was convinced after checked
> > > DPDK code, seeing it may use VA as IOVA directly. But I did not test this
> > > patch with DPDK.
> > > 
> > > Instead, I used kvm-unit-test to verify this patch series. And of course, I
> > > also did some modification to the test case. Patch for the test also sent out
> > > at https://www.spinics.net/lists/kvm/msg177425.html.
> > 
> > Yeah that's perfectly fine for me.  So instead maybe you can also
> > mention the kvm-unit-test in the cover letter if you gonna repost.
> > 
> > > 
> > > > [...]
> > > > 
> > > > > @@ -3264,11 +3286,19 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
> > > > >          }
> > > > >      }
> > > > >  
> > > > > -    /* Currently only address widths supported are 39 and 48 bits */
> > > > > +    /* Currently address widths supported are 39, 48, and 57 bits */
> > > > >      if ((s->aw_bits != VTD_AW_39BIT) &&
> > > > > -        (s->aw_bits != VTD_AW_48BIT)) {
> > > > > -        error_setg(errp, "Supported values for x-aw-bits are: %d, %d",
> > > > > -                   VTD_AW_39BIT, VTD_AW_48BIT);
> > > > > +        (s->aw_bits != VTD_AW_48BIT) &&
> > > > > +        (s->aw_bits != VTD_AW_57BIT)) {
> > > > > +        error_setg(errp, "Supported values for x-aw-bits are: %d, %d, %d",
> > > > > +                   VTD_AW_39BIT, VTD_AW_48BIT, VTD_AW_57BIT);
> > > > > +        return false;
> > > > > +    }
> > > > > +
> > > > > +    if ((s->aw_bits == VTD_AW_57BIT) &&
> > > > > +        !(host_has_la57() && guest_has_la57())) {
> > > > > +        error_setg(errp, "Do not support 57-bit DMA address, unless both "
> > > > > +                         "host and guest are capable of 5-level paging.\n");
> > > > 
> > > > Is there any context (or pointer to previous discussions would work
> > > > too) on explaining why we don't support some scenarios like
> > > > host_paw=48,guest_paw=48,guest_gaw=57?
> > > > 
> > > 
> > > Well, above check is only to make sure both the host and the guest can
> > > use 57bit linear address, which requires 5-level paging. So I believe
> > > we do support scenarios like host_paw=48,guest_paw=48,guest_gaw=57.
> > > The guest_has_la57() means the guest can use 57-bit linear address,
> > > regardless of its physical address width.
> > 
> > Sorry for my incorrect wording.  I mean when host/guest CPU only
> > support 4-level LA then would/should we allow the guest IOMMU to
> > support 5-level IOVA?  Asked since I'm thinking whether I can run the
> > series a bit with my laptop/servers.
> 
> [...]
> 
> > 
> > Since at it, another thing I thought about is making sure the IOMMU
> > capabilities will match between host and guest IOMMU, which I think
> > this series has ignorred so far.  E.g., when we're having assigned
> > devices in the guest and with 5-level IOVA, we should make sure the
> > host IOMMU supports 5-level as well before the guest starts since
> > otherwise the shadow page synchronization could potentially fail when
> > the requested IOVA address goes beyond 4-level.  One simple solution
> > is just to disable device assignment for now when we're with 57bits
> > vIOMMU but I'm not sure whether that's what you want, especially you
> > mentioned the DPDK case (who may use assigned devices).
> 
> Ok I totally forgot that we don't even support any kind of check like
> this before... So feel free to skip this comment if you want, or it
> would be even nicer if you want to fix it as a whole. :)
> 

Indeed. We have talked about this before. How about we focus on the 5-level
extension for now, and solve the check issue in the future? I still do not
have any clean solutions in mind. BTW, any suggestions on this issue? :)

> Regards,
> 
> -- 
> Peter Xu
> 

B.R.
Yu
