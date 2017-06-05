Received: from eggs.gnu.org ([2001:4830:134:3::10]:49040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dHi8k-0002lM-Lr
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 22:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dHi8h-0001ta-IY
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 22:53:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dHi8h-0001sG-9B
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 22:53:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2476DC0467C0
	for <qemu-devel@nongnu.org>; Mon,  5 Jun 2017 02:53:05 +0000 (UTC)
Date: Mon, 5 Jun 2017 10:52:57 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170605025257.GE4056@pxdev.xzpeter.org>
References: <1496404254-17429-1-git-send-email-peterx@redhat.com>
	<1496404254-17429-2-git-send-email-peterx@redhat.com>
	<20170602193713-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170602193713-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 1/3] exec: add page_mask for
 address_space_do_translate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Jason Wang <jasowang@redhat.com>

On Fri, Jun 02, 2017 at 07:45:05PM +0300, Michael S. Tsirkin wrote:
> On Fri, Jun 02, 2017 at 07:50:52PM +0800, Peter Xu wrote:
> > The function is originally used for address_space_translate() and what
> > we care about most is (xlat, plen) range. However for iotlb requests, we
> > don't really care about "plen", but the size of the page that "xlat" is
> > located on. While, plen cannot really contain this information.
> > 
> > A simple example to show why "plen" is not good for IOTLB translations:
> > 
> > E.g., for huge pages, it is possible that guest mapped 1G huge page on
> > device side that used this GPA range:
> > 
> >   0x100000000 - 0x13fffffff
> > 
> > Then let's say we want to translate one IOVA that finally mapped to GPA
> > 0x13ffffe00 (which is located on this 1G huge page). Then here we'll
> > get:
> > 
> >   (xlat, plen) = (0x13fffe00, 0x200)
> > 
> > So the IOTLB would be only covering a very small range since from
> > "plen" (which is 0x200 bytes) we cannot tell the size of the page.
> > 
> > Actually we can really know that this is a huge page - we just throw the
> > information away in address_space_do_translate().
> > 
> > This patch introduced "page_mask" optional parameter to capture that
> > page mask info. Also, I made "plen" an optional parameter as well, with
> > some comments for the whole function.
> > 
> > No functional change yet.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  exec.c | 46 ++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 40 insertions(+), 6 deletions(-)
> > 
> > diff --git a/exec.c b/exec.c
> > index 8fc0e78..63a3ff0 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -465,21 +465,45 @@ address_space_translate_internal(AddressSpaceDispatch *d, hwaddr addr, hwaddr *x
> >      return section;
> >  }
> >  
> > -/* Called from RCU critical section */
> > +/**
> > + * address_space_do_translate - translate an address in AddressSpace
> > + *
> > + * @as: the address space that we want to translate on
> > + * @addr: the address to be translated in above address space
> > + * @xlat: the translated address offset within memory region. It
> > + *        cannot be @NULL.
> > + * @plen_out: valid read/write length of the translated address. It
> > + *            can be @NULL when we don't care about it.
> > + * @page_mask_out: page mask for the translated address. This
> > + *            should only be meaningful for IOMMU translated
> > + *            addresses, since there may be huge pages that this bit
> > + *            would tell. It can be @NULL if we don't care about it.
> 
> Why do we need plen or mask at all? It seems MemoryRegionSection
> has address and length already. So if you want to find out
> distance to section end, do section.size - xlat and you are done.

Hi, Michael,

When you say:

  section.size - xlat

Do you really mean this?

  section.offset_within_address_space + section.size - xlat

Since otherwise it will make no much sense to me.

Anyway, I don't know whether it'll be okay we remove the plen...

In address_space_do_translate(), the logic is basically:

1. do internal translation (basically to find the section info from
   current address space)
2. do IOMMU translation if the MR is IOMMU typed
3. goto 1.

Along the way (1 -> 2 -> 3 -> 1 -> ...) until we finished the
translation (I don't really know whether we'll have cases for nested
IOMMU translation, but anyway we have a while loop there, so assume
the loop can be executed many times), plen can be shrinking all the
time, either by this in address_space_translate_internal():

    *plen = int128_get64(int128_min(diff, int128_make64(*plen)));

Or this in address_space_do_translate():

    *plen = MIN(*plen, (addr | iotlb.addr_mask) - addr + 1);

And I don't know only using the final section.size to decide plen
would be enough.

Also, for page_mask information - I don't quite sure
MemoryRegionSection can express that info. Again, huge page can be one
example: MemoryRegionSection doesn't really contain huge page
information, while MemoryRegionIOMMUOps.translate() does contain that
information (via addr_mask field).

(I see that you would like IOTLB to be using arbitary length rather
 than page masks. Maybe we can first decide which would be the best
 interface for IOTLB. I'll reply in that context later.)

Thanks,

-- 
Peter Xu
