Received: from eggs.gnu.org ([2001:4830:134:3::10]:35973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dABrj-0007ao-KJ
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dABrf-00013D-ME
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:00:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dABrf-000130-DO
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:00:27 -0400
Date: Mon, 15 May 2017 17:00:06 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170515090006.GA10415@pxdev.xzpeter.org>
References: <1494403315-12760-1-git-send-email-peterx@redhat.com>
	<1494403315-12760-5-git-send-email-peterx@redhat.com>
	<20170511015637.GF14408@umbus.fritz.box>
	<20170511093603.GJ28293@pxdev.xzpeter.org>
	<20170512052508.GD12908@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170512052508.GD12908@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH v3 04/12] memory: fix
 address_space_get_iotlb_entry()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, May 12, 2017 at 03:25:08PM +1000, David Gibson wrote:
> On Thu, May 11, 2017 at 05:36:03PM +0800, Peter Xu wrote:
> > On Thu, May 11, 2017 at 11:56:38AM +1000, David Gibson wrote:
> > > On Wed, May 10, 2017 at 04:01:47PM +0800, Peter Xu wrote:
> > > > This function has an assumption that we will definitely call translate()
> > > > once (or say, the addr will be located inside one IOMMU memory region),
> > > > otherwise an empty IOTLB will be returned. Nevertheless, this is not
> > > > what we want. When there is no IOMMU memory region, we should build up a
> > > > static mapping for the caller, instead of an invalid IOTLB.
> > > > 
> > > > We won't trigger this path before VT-d passthrough mode. When
> > > > passthrough mode for a vhost device is setup, VT-d is possible to
> > > > disable the IOMMU region for that device. Without current patch, we'll
> > > > get a vhost boot failure, and it'll be failed over to virtio userspace
> > > > mode.
> > > 
> > > This doesn't look right to me.  You're assuming the target is
> > > address_space_memory, which might not be the case - and you should be
> > > able to check from the MR you do hit.  Furthermore it doesn't look
> > > like you're accounting for the trivial translation if the section's
> > > offset in the address space is different from its offset in the MR.
> > 
> > Do you mean this line?
> > 
> >         addr = addr - section->offset_within_address_space
> >                + section->offset_within_region;
> 
> Uh.. where is that line?  But.. wait, yes, I think I was mistaken.  I saw:
> 	.translated_addr = iova,
> 	
> and thought that meant you were assuming an identify mapping from iova
> to translated addr.  But thinking more carefull, IIRC iova and
> translated_addr are both relative to the MR, not the AS, so I think
> that is correct after all.
> 
> > I thought it was calculating the relative address against that memory
> > region. That should only be useful if we want to do further
> > translate(), right? For the path that this patch tries to handle (when
> > there is no translate() call), then this "addr" is useless here?
> > 
> > Regarding to the address space assignment - do you mean, e.g., I
> > should use section->address_space here instead of
> > &system_address_space? If so, I can do the switch.
> 
> Yes, I think you should.
> 
> > But after all, for
> > now address_space_get_iotlb_entry() is only used by vhost codes, and
> > it only check against iotlb.target_as == NULL, so the address space
> > didn't count too much here...
> 
> > Another reason I used &address_space_memory is that in
> > vfio_iommu_map_notify() we have a check against it:
> > 
> >     if (iotlb->target_as != &address_space_memory) {
> >         error_report("Wrong target AS \"%s\", only system memory is allowed",
> >                      iotlb->target_as->name ? iotlb->target_as->name : "none");
> >         return;
> >     }
> > 
> > Or say, we have some assumptions (not only in this patch) that assumes
> > this iotlb.target_as should be system_address_space.
> 
> Right, the vhost code can only handle some IOMMU setups - something
> like nested IOMMUs would break it.  But this way if someone sets up a
> machine with an IOMMU configuration that vhost can't handle, you'll
> get an error message, rather than accesses to unexpected locations,
> which could cause really hard to debug corruption.
> 
> In other words we make assumptions, but we should _test_ those
> assumptions.
> 
> I also think it would make sense to use address_space_translate() if we
> can, since it's an existing interface for a very similar operation.

I did give it a shot to generalize these two functions in this series
(I just posted it):

  [PATCH 0/4] exec: address space translation cleanups

Please see whether that'll be a good replacement of this single patch.

Thanks,

-- 
Peter Xu
