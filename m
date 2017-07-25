Received: from eggs.gnu.org ([2001:4830:134:3::10]:38198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1da17N-0006MU-E4
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1da17I-0003nF-Hm
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:47:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:23388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1da17I-0003mV-8P
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:47:20 -0400
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Tue, 25 Jul 2017 14:47:16 +0000
Message-ID: <286AC319A985734F985F78AFA26841F739283F62@shsmsx102.ccr.corp.intel.com>
References: <20170714123023.GA2624@dhcp22.suse.cz>
	<20170714181523-mutt-send-email-mst@kernel.org>
	<20170717152448.GN12888@dhcp22.suse.cz> <596D6E7E.4070700@intel.com>
	<20170719081311.GC26779@dhcp22.suse.cz> <596F4A0E.4010507@intel.com>
	<20170724090042.GF25221@dhcp22.suse.cz> <59771010.6080108@intel.com>
	<20170725112513.GD26723@dhcp22.suse.cz> <597731E8.9040803@intel.com>
	<20170725124141.GF26723@dhcp22.suse.cz>
In-Reply-To: <20170725124141.GF26723@dhcp22.suse.cz>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Michal Hocko <mhocko@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "david@redhat.com" <david@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>

On Tuesday, July 25, 2017 8:42 PM, hal Hocko wrote:
> On Tue 25-07-17 19:56:24, Wei Wang wrote:
> > On 07/25/2017 07:25 PM, Michal Hocko wrote:
> > >On Tue 25-07-17 17:32:00, Wei Wang wrote:
> > >>On 07/24/2017 05:00 PM, Michal Hocko wrote:
> > >>>On Wed 19-07-17 20:01:18, Wei Wang wrote:
> > >>>>On 07/19/2017 04:13 PM, Michal Hocko wrote:
> > >>>[...
> > We don't need to do the pfn walk in the guest kernel. When the API
> > reports, for example, a 2MB free page block, the API caller offers to
> > the hypervisor the base address of the page block, and size=3D2MB, to
> > the hypervisor.
>=20
> So you want to skip pfn walks by regularly calling into the page allocato=
r to
> update your bitmap. If that is the case then would an API that would allo=
w you
> to update your bitmap via a callback be s sufficient? Something like
> 	void walk_free_mem(int node, int min_order,
> 			void (*visit)(unsigned long pfn, unsigned long nr_pages))
>=20
> The function will call the given callback for each free memory block on t=
he given
> node starting from the given min_order. The callback will be strictly an =
atomic
> and very light context. You can update your bitmap from there.

I would need to introduce more about the background here:
The hypervisor and the guest live in their own address space. The hyperviso=
r's bitmap
isn't seen by the guest. I think we also wouldn't be able to give a callbac=
k function=20
from the hypervisor to the guest in this case.

>=20
> This would address my main concern that the allocator internals would get
> outside of the allocator proper.=20

What issue would it have to expose the internal, for_each_zone()?
I think new code which would call it will also be strictly checked when the=
y
are pushed to upstream.

Best,
Wei
