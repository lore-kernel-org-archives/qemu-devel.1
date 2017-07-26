Received: from eggs.gnu.org ([2001:4830:134:3::10]:56345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mhocko@kernel.org>) id 1daKuJ-0003IN-Rq
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:55:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mhocko@kernel.org>) id 1daKuG-0003JY-GB
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:55:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:38916 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mhocko@kernel.org>) id 1daKuG-0003HR-88
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:55:12 -0400
Date: Wed, 26 Jul 2017 13:55:06 +0200
From: Michal Hocko <mhocko@kernel.org>
Message-ID: <20170726115506.GM2981@dhcp22.suse.cz>
References: <20170724090042.GF25221@dhcp22.suse.cz>
	<59771010.6080108@intel.com>
	<20170725112513.GD26723@dhcp22.suse.cz>
	<597731E8.9040803@intel.com>
	<20170725124141.GF26723@dhcp22.suse.cz>
	<286AC319A985734F985F78AFA26841F739283F62@shsmsx102.ccr.corp.intel.com>
	<20170725145333.GK26723@dhcp22.suse.cz>
	<5977FCDF.7040606@intel.com> <20170726102458.GH2981@dhcp22.suse.cz>
	<59788097.6010402@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59788097.6010402@intel.com>
Subject: Re: [Qemu-devel] [PATCH v12 6/8] mm: support reporting free page
 blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "david@redhat.com" <david@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>

On Wed 26-07-17 19:44:23, Wei Wang wrote:
[...]
> I thought about it more. Probably we can use the callback function with a
> little change like this:
> 
> void walk_free_mem(void *opaque1, void (*visit)(void *opaque2, unsigned long
> pfn,
>            unsigned long nr_pages))
> {
>     ...
>     for_each_populated_zone(zone) {
>                    for_each_migratetype_order(order, type) {
>                         report_unused_page_block(zone, order, type, &page);
> // from patch 6
>                         pfn = page_to_pfn(page);
>                         visit(opaque1, pfn, 1 << order);
>                     }
>     }
> }
> 
> The above function scans all the free list and directly sends each free page
> block to the
> hypervisor via the virtio_balloon callback below. No need to implement a
> bitmap.
> 
> In virtio-balloon, we have the callback:
> void *virtio_balloon_report_unused_pages(void *opaque,  unsigned long pfn,
> unsigned long nr_pages)
> {
>     struct virtio_balloon *vb = (struct virtio_balloon *)opaque;
>     ...put the free page block to the the ring of vb;
> }
> 
> 
> What do you think?

I do not mind conveying a context to the callback. I would still prefer
to keep the original min_order to check semantic though. Why? Well,
it doesn't make much sense to scan low order free blocks all the time
because they are simply too volatile. Larger blocks tend to surivive for
longer. So I assume you would only care about larger free blocks. This
will also make the call cheaper.
-- 
Michal Hocko
SUSE Labs
