Received: from eggs.gnu.org ([2001:4830:134:3::10]:35353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cIxy6-0004jz-Rz
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:27:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cIxy3-0001Zj-Kg
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:27:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cIxy3-0001Zb-Eh
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:27:03 -0500
Date: Mon, 19 Dec 2016 21:26:49 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161219132649.GE4155@pxdev.xzpeter.org>
References: <A2975661238FB949B60364EF0F2C257438FD8042@shsmsx102.ccr.corp.intel.com>
	<20161219100053.GD4155@pxdev.xzpeter.org>
	<A2975661238FB949B60364EF0F2C257438FD9142@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C257438FD9142@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH v7 3/5] IOMMU: enable intel_iommu map and
 unmap notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "bd.aviv@gmail.com" <bd.aviv@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, ", Jan Kiszka" <jan.kiszka@siemens.com>, ", Alex Williamson" <alex.williamson@redhat.com>, ", Jason Wang" <jasowang@redhat.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>

On Mon, Dec 19, 2016 at 11:53:32AM +0000, Liu, Yi L wrote:

[...]

> > > Regards to the s->notifiers_list, I didn't see the init op to it. Does it happen
> > > in another patch? If so, it may be better to move it in this patch since this
> > > patch introduces both the definition and usage of notifiers_list.
> > >
> > > If it is already clarified, then ignore it.
> > 
> > I think it was missing. It IMHO accidentally worked since QLIST_INIT()
> > just set the head to NULL and that's what we did when we create the
> > IntelIOMMUState object.
> > 
> > And what's worse - I found this approach may not work if we do
> > QLIST_INSERT() in the changed() hook, since if we have more than one
> > assigned devices we will only register the first one not the rest. A
> > better approach may be traversing the vt-d buses via
> > IntelIOMMUState.vtd_as_by_busptr.
> > 
> Peter,
> 
> In Oct, I also mailed Aviv about using IntelIOMMUState.vtd_as_by_busptr
> when trying to connect the vfio notifiers(map/unmap) and vIOMMU. 
> However, I reconsidered it later. If I remember correctly, 
> IntelIOMMUState.vtd_as_by_busptr not only includes vtd_as for assigned devices,
> but also includes virtual devices. When iotlb invalidation comes to vIOMMU, there
> is no indication for which device in iotlb_inv_desc. So still need to have a list to record
> vtd_as which needs to be looped. So I keep silent on it after that thought.
> 
> Now, you mentioned it may not work in multi-assigned scenario. Maybe it's
> time to reconsider it again. 

Hmm, first parameter of vtd_iommu_notify_flag_changed() is memory
region, and that's per-device. So current approach should work even
with multiple devices. Looks like I made a mistake, sorry. :) 

Thanks,

-- peterx
