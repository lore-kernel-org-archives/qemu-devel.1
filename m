Received: from eggs.gnu.org ([2001:4830:134:3::10]:55706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ceD57-0002Mu-S6
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 22:50:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ceD54-0001z7-0x
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 22:50:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ceD53-0001yb-Rx
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 22:50:05 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54CDA624DB
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 03:50:05 +0000 (UTC)
Date: Thu, 16 Feb 2017 11:49:58 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170216034958.GH15985@pxdev.xzpeter.org>
References: <1487191768-8489-1-git-send-email-mst@redhat.com>
	<20170216023528.GE15985@pxdev.xzpeter.org>
	<20170215195235.660c45fe@t450s.home>
	<20170216030446.GG15985@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170216030446.GG15985@pxdev.xzpeter.org>
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

On Thu, Feb 16, 2017 at 11:04:46AM +0800, Peter Xu wrote:
> On Wed, Feb 15, 2017 at 07:52:35PM -0700, Alex Williamson wrote:
> > On Thu, 16 Feb 2017 10:35:28 +0800
> > Peter Xu <peterx@redhat.com> wrote:
> > 
> > > On Wed, Feb 15, 2017 at 10:49:47PM +0200, Michael S. Tsirkin wrote:
> > > > VFIO actually wants to create a capability with ID == 0.
> > > > This is done to make guest drivers skip the given capability.
> > > > pcie_add_capability then trips up on this capability
> > > > when looking for end of capability list.
> > > > 
> > > > To support this use-case, it's easy enough to switch to
> > > > e.g. 0xffffffff for these comparisons - we can be sure
> > > > it will never match a 16-bit capability ID.
> > > > 
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>  
> > > 
> > > Reviewed-by: Peter Xu <peterx@redhat.com>
> > > 
> > > Two nits:
> > > 
> > > (1) maybe we can s/0xffffffff/0xffff/ in the whole patch since ecap_id
> > >     is 16 bits
> > 
> > The former is used because it's beyond the address space of a valid
> > capability.  Using 0xffff just makes the situation different, not
> > better.
> 
> But isn't pcie_find_capability_list() defining cap_id parameter as
> uint16_t? In that case, 0xffffffff will be the same as 0xffff since
> we'll just take the lower 16 bits?

Alex helpped pointing out that this patch has touched the parameter
while I didn't notice that. Sorry. :(

Please take my r-b and ignore the two nits. Thanks,

-- peterx
