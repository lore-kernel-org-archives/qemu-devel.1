Received: from eggs.gnu.org ([2001:4830:134:3::10]:43280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cUc9C-0003nZ-6X
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:34:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cUc98-0006pZ-7n
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:34:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cUc98-0006op-1l
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:34:38 -0500
Date: Fri, 20 Jan 2017 18:34:34 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170120183215-mutt-send-email-mst@kernel.org>
References: <1482303148-22059-1-git-send-email-liang.z.li@intel.com>
	<1482303148-22059-4-git-send-email-liang.z.li@intel.com>
	<20170117211131-mutt-send-email-mst@kernel.org>
	<F2CBF3009FA73547804AE4C663CAB28E3C355672@shsmsx102.ccr.corp.intel.com>
	<20170118172401-mutt-send-email-mst@kernel.org>
	<F2CBF3009FA73547804AE4C663CAB28E3C3578BF@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F2CBF3009FA73547804AE4C663CAB28E3C3578BF@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH v6 kernel 3/5] virtio-balloon: speed up
 inflate/deflate process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Li, Liang Z" <liang.z.li@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "david@redhat.com" <david@redhat.com>, "aarcange@redhat.com" <aarcange@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>

On Thu, Jan 19, 2017 at 01:44:36AM +0000, Li, Liang Z wrote:
> > > > > +		*range = cpu_to_le64((base_pfn <<
> > > > > +				VIRTIO_BALLOON_NR_PFN_BITS) | 0);
> > > > > +		*(range + 1) = cpu_to_le64(pages);
> > > > > +		vb->resp_pos += 2;
> > > >
> > > > Pls use structs for this kind of stuff.
> > >
> > > I am not sure if you mean to use
> > >
> > > struct  range {
> > >  	__le64 pfn: 52;
> > > 	__le64 nr_page: 12
> > > }
> > > Instead of the shift operation?
> > 
> > Not just that. You want to add a pages field as well.
> > 
> 
> pages field? Could you give more hints?

Well look how you are formatting it manually above.
There is clearly a structure with two 64 bit fields.
First one includes pfn and 0 (no idea why does | 0 make
sense but that's a separate issue).
Second one includes the pages value.


> > Generally describe the format in the header in some way so host and guest
> > can easily stay in sync.
> 
> 'VIRTIO_BALLOON_NR_PFN_BITS' is for this purpose and it will be passed to the
> related function in page_alloc.c as a parameter.
> 
> Thanks!
> Liang
> > All the pointer math and void * means we get zero type safety and I'm not
> > happy about it.
> > 
> > It's not good that virtio format seeps out to page_alloc anyway.
> > If unavoidable it is not a good idea to try to hide this fact, people will assume
> > they can change the format at will.
> > 
> > --
> > MST
