Received: from eggs.gnu.org ([2001:4830:134:3::10]:35654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dAqVJ-0006bB-Gn
	for qemu-devel@nongnu.org; Wed, 17 May 2017 00:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dAqVG-0005IG-CT
	for qemu-devel@nongnu.org; Wed, 17 May 2017 00:24:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dAqVG-0005Hb-6N
	for qemu-devel@nongnu.org; Wed, 17 May 2017 00:24:02 -0400
Date: Wed, 17 May 2017 12:23:42 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170517042342.GA9921@pxdev.xzpeter.org>
References: <1494838260-30439-1-git-send-email-peterx@redhat.com>
	<9a93009b-f909-3142-5bc5-915b9a10ed20@redhat.com>
	<f69dcf32-b6a2-fb59-2b54-61fd7b52e66e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f69dcf32-b6a2-fb59-2b54-61fd7b52e66e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] exec: address space translation
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Tue, May 16, 2017 at 06:51:03PM +0200, Maxime Coquelin wrote:
> Hi Peter,
> 
> On 05/16/2017 03:24 PM, Maxime Coquelin wrote:
> >
> >
> >On 05/15/2017 10:50 AM, Peter Xu wrote:
> >>The problem is that, address_space_get_iotlb_entry() shares a lot with
> >>address_space_translate(). This patch tries to abstract the
> >>shared elements.
> >>
> >>Originally, this work is derived from discussion from VT-d passthrough
> >>series discussions [1]. But for sure we can just see this series as a
> >>standalone cleanup. So I posted it separately here.
> >>
> >>Smoke tests are done with general VM boots, IOs, especially with vhost
> >>dmar configurations.
> >>
> >>I believe with current series I can throw away the old patch [1],
> >>which may be good. But before that, please kindly review. Thanks.
> >
> >I faced the problem the old patch fixes when declaring and attaching an
> >IOMMU device, but booting the kernel with intel_iommu=off.
> >
> >I tested again with patches 1 & 4 of your series, and I confirm it fixes
> >the issue:
> >Tested-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> 
> I did some more testing with my "vhost-user IOMMU" setup, and the series
> actually breaks with IOMMU device attached, and intel_iommu=on.
> 
> The main difference with the previous passing test is the guest RAM
> size. In the working setup, it is 2G of 2M hugepages, vs. 4G of 2M
> hugepages in the failing one. Note that I also reproduce with vhost-kernel
> backend.
> 
> The error happens in the first vhost_device_iotlb_miss() call:
> qemu-system-x86_64: Fail to lookup the translated address b5d7c000
> 
> I don't have the root cause yet, I'll keep you updated.

Maxime,

Thanks a lot for help testing this series!

I reproduced this problem, and this is not a problem obvious enough
for me. Let me investigate as well.

-- 
Peter Xu
