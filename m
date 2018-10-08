Received: from eggs.gnu.org ([2001:4830:134:3::10]:34179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g9P76-0002Mh-At
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 02:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g9P73-0002QD-2T
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 02:33:56 -0400
Date: Mon, 8 Oct 2018 14:33:41 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181008063341.GG18728@xz-x1>
References: <20180913075517.11140-1-peterx@redhat.com>
	<e7cc5dbe-d577-2b41-517d-0d32e9d6ebd7@redhat.com>
	<20181008060620.GF18728@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181008060620.GF18728@xz-x1>
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: handle invalid ce for shadow
 sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, QEMU Stable <qemu-stable@nongnu.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, Pei Zhang <pezhang@redhat.com>

On Mon, Oct 08, 2018 at 02:06:20PM +0800, Peter Xu wrote:
> > > -static int vtd_sync_shadow_page_table(VTDAddressSpace *vtd_as)
> > > -{
> > > -    return vtd_sync_shadow_page_table_range(vtd_as, NULL, 0, UINT64_MAX);
> > > +    return vtd_sync_shadow_page_table_range(vtd_as, &ce, 0, UINT64_MAX);
> > >   }
> > 
> > As has been discussed, this will left addr UINT64_MAX, it's better to have
> > [start, end] instead of (start, range).
> 
> Hmm, this size is inclusive, so we should be fine.  Though I'll take
> your advise to use start/end pair to be clearer.

Sorry it's not...

Actually vtd_page_walk() itself is not inclusive, so we will need to
touch that up if we want to let the whole stack use the [start, end]
inclusive way.  However I would try not to bother with it since after
all page sync operation is per-small-page granularity, so imho missing
the last addr UINT64_MAX is ok (as long as we're covering the last
page, which is UINT64_MAX - PAGE_SIZE + 1).  I'm not sure whether
it'll worth it then to change the whole stack into inclusive way... so
I'll temporarily keep it as is.

Regards,

-- 
Peter Xu
