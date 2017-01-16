Received: from eggs.gnu.org ([2001:4830:134:3::10]:57169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cT1lG-0006NT-SY
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 02:31:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cT1lB-0006GJ-UI
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 02:31:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cT1lB-0006Ft-Nv
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 02:31:21 -0500
Date: Mon, 16 Jan 2017 15:31:16 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170116073116.GC30108@pxdev.xzpeter.org>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-12-git-send-email-peterx@redhat.com>
	<c5b536a1-1f7b-965d-04b6-4f6bde19733f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c5b536a1-1f7b-965d-04b6-4f6bde19733f@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v3 11/14] intel_iommu: provide its own
 replay() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com

On Fri, Jan 13, 2017 at 05:26:06PM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B401=E6=9C=8813=E6=97=A5 11:06, Peter Xu wrote:
> >The default replay() don't work for VT-d since vt-d will have a huge
> >default memory region which covers address range 0-(2^64-1). This will
> >normally bring a dead loop when guest starts.
>=20
> I think it just takes too much time instead of dead loop?

Hmm, I can touch the commit message above to make it more precise.

>=20
> >
> >The solution is simple - we don't walk over all the regions. Instead, =
we
> >jump over the regions when we found that the page directories are empt=
y.
> >It'll greatly reduce the time to walk the whole region.
>=20
> Yes, the problem is memory_region_is_iommu_reply() not smart because:
>=20
> - It doesn't understand large page
> - try go over all possible iova
>=20
> So I'm thinking to introduce something like iommu_ops->iova_iterate() w=
hich
>=20
> 1) accept an start iova and return the next exist map
> 2) understand large page
> 3) skip unmapped iova

Though I haven't tested with huge pages yet, but this patch should
both solve above issue? I don't know whether you went over the page
walk logic - it should both support huge page, and it will skip
unmapped iova range (at least that's my goal to have this patch). In
that case, looks like this patch is solving the same problem? :)
(though without introducing iova_iterate() interface)

Please correct me if I misunderstood it.

>=20
> >
> >To achieve this, we provided a page walk helper to do that, invoking
> >corresponding hook function when we found an page we are interested in=
.
> >vtd_page_walk_level() is the core logic for the page walking. It's
> >interface is designed to suite further use case, e.g., to invalidate a
> >range of addresses.
> >
> >Signed-off-by: Peter Xu<peterx@redhat.com>
>=20
> For intel iommu, since we intercept all map and unmap, a more tricky ie=
da is
> to we can record the mappings internally in something like a rbtree whi=
ch
> could be iterated during replay. This saves possible guest io page tabl=
e
> traversal, but drawback is it may not survive from OOM attacker.

I think the problem is that we need this rbtree per guest-iommu-domain
(because mapping can be different per domain). In that case, I failed
to understand how the tree can help here. :(

Thanks,

-- peterx
