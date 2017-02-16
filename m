Received: from eggs.gnu.org ([2001:4830:134:3::10]:49932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ceCNN-0003lZ-7J
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 22:04:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ceCNJ-0003ZV-85
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 22:04:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ceCNJ-0003ZL-06
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 22:04:53 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD7ABC04B321
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 03:04:52 +0000 (UTC)
Date: Thu, 16 Feb 2017 11:04:46 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170216030446.GG15985@pxdev.xzpeter.org>
References: <1487191768-8489-1-git-send-email-mst@redhat.com>
	<20170216023528.GE15985@pxdev.xzpeter.org>
	<20170215195235.660c45fe@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170215195235.660c45fe@t450s.home>
Subject: Re: [Qemu-devel] [PATCH] pci/pcie: don't assume cap id 0 is reserved
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>

On Wed, Feb 15, 2017 at 07:52:35PM -0700, Alex Williamson wrote:
> On Thu, 16 Feb 2017 10:35:28 +0800
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Wed, Feb 15, 2017 at 10:49:47PM +0200, Michael S. Tsirkin wrote:
> > > VFIO actually wants to create a capability with ID == 0.
> > > This is done to make guest drivers skip the given capability.
> > > pcie_add_capability then trips up on this capability
> > > when looking for end of capability list.
> > > 
> > > To support this use-case, it's easy enough to switch to
> > > e.g. 0xffffffff for these comparisons - we can be sure
> > > it will never match a 16-bit capability ID.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>  
> > 
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > 
> > Two nits:
> > 
> > (1) maybe we can s/0xffffffff/0xffff/ in the whole patch since ecap_id
> >     is 16 bits
> 
> The former is used because it's beyond the address space of a valid
> capability.  Using 0xffff just makes the situation different, not
> better.

But isn't pcie_find_capability_list() defining cap_id parameter as
uint16_t? In that case, 0xffffffff will be the same as 0xffff since
we'll just take the lower 16 bits?

> 
> > 
> > (2) maybe we can add one more sentence in the comment below showing
> >     where the 0xffff thing comes from (it comes from PCIe spec 7.9.2)
> 
> The capability in hardware is 16bits, thus a value that exceeds 16 bits
> can never match a valid ID.  It has nothing to do with 7.9.2.  Thanks,
> 
> Alex
> 
> > > ---
> > >  hw/pci/pcie.c | 11 +++++++----
> > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > > index cbd4bb4..f4dd177 100644
> > > --- a/hw/pci/pcie.c
> > > +++ b/hw/pci/pcie.c
> > > @@ -610,7 +610,8 @@ bool pcie_cap_is_arifwd_enabled(const PCIDevice *dev)
> > >   * uint16_t ext_cap_size
> > >   */
> > >  
> > > -static uint16_t pcie_find_capability_list(PCIDevice *dev, uint16_t cap_id,
> > > +/* Passing a cap_id value > 0xffff will return 0 and put end of list in prev */
> > > +static uint16_t pcie_find_capability_list(PCIDevice *dev, uint32_t cap_id,
> > >                                            uint16_t *prev_p)
> > >  {
> > >      uint16_t prev = 0;
> > > @@ -679,9 +680,11 @@ void pcie_add_capability(PCIDevice *dev,
> > >      } else {
> > >          uint16_t prev;
> > >  
> > > -        /* 0 is reserved cap id. use internally to find the last capability
> > > -           in the linked list */
> > > -        next = pcie_find_capability_list(dev, 0, &prev);
> > > +        /*
> > > +         * 0xffffffff is not a valid cap id (it's a 16 bit field). use
> > > +         * internally to find the last capability in the linked list.
> > > +         */
> > > +        next = pcie_find_capability_list(dev, 0xffffffff, &prev);
> > >  
> > >          assert(prev >= PCI_CONFIG_SPACE_SIZE);
> > >          assert(next == 0);
> > > -- 
> > > MST  
> > 
> > -- peterx
> 

-- peterx
