Received: from eggs.gnu.org ([2001:4830:134:3::10]:54535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cRy7r-0001Hb-Pf
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:26:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cRy7o-0004En-GW
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:26:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cRy7o-0004Eh-AR
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:26:20 -0500
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-12-git-send-email-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c5b536a1-1f7b-965d-04b6-4f6bde19733f@redhat.com>
Date: Fri, 13 Jan 2017 17:26:06 +0800
MIME-Version: 1.0
In-Reply-To: <1484276800-26814-12-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com



On 2017=E5=B9=B401=E6=9C=8813=E6=97=A5 11:06, Peter Xu wrote:
> The default replay() don't work for VT-d since vt-d will have a huge
> default memory region which covers address range 0-(2^64-1). This will
> normally bring a dead loop when guest starts.

I think it just takes too much time instead of dead loop?

>
> The solution is simple - we don't walk over all the regions. Instead, w=
e
> jump over the regions when we found that the page directories are empty=
.
> It'll greatly reduce the time to walk the whole region.

Yes, the problem is memory_region_is_iommu_reply() not smart because:

- It doesn't understand large page
- try go over all possible iova

So I'm thinking to introduce something like iommu_ops->iova_iterate() whi=
ch

1) accept an start iova and return the next exist map
2) understand large page
3) skip unmapped iova

>
> To achieve this, we provided a page walk helper to do that, invoking
> corresponding hook function when we found an page we are interested in.
> vtd_page_walk_level() is the core logic for the page walking. It's
> interface is designed to suite further use case, e.g., to invalidate a
> range of addresses.
>
> Signed-off-by: Peter Xu<peterx@redhat.com>

For intel iommu, since we intercept all map and unmap, a more tricky=20
ieda is to we can record the mappings internally in something like a=20
rbtree which could be iterated during replay. This saves possible guest=20
io page table traversal, but drawback is it may not survive from OOM=20
attacker.

Thanks
