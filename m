Received: from eggs.gnu.org ([2001:4830:134:3::10]:42379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f9RQB-0000g1-6U
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f9RQ8-0007P2-32
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:29:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54588 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f9RQ7-0007Od-Ty
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:29:28 -0400
References: <20180418045121.14233-1-peterx@redhat.com>
	<d550eb50-c9e3-838a-ac9a-4a998375572b@redhat.com>
	<20180420051106.GC873@xz-mi>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <eebb050f-eeee-cbd4-e7bc-646734510901@redhat.com>
Date: Fri, 20 Apr 2018 16:29:13 +0800
MIME-Version: 1.0
In-Reply-To: <20180420051106.GC873@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] intel-iommu: send PSI always when
 notify_unmap set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Eric Auger <eric.auger@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Alexander Witte <alexander.witte@baicanada.com>, Jintack Lim <jintack@cs.columbia.edu>



On 2018=E5=B9=B404=E6=9C=8820=E6=97=A5 13:11, Peter Xu wrote:
> On Fri, Apr 20, 2018 at 12:57:13PM +0800, Jason Wang wrote:
>> On 2018=E5=B9=B404=E6=9C=8818=E6=97=A5 12:51, Peter Xu wrote:
>>> During IOVA page table walk, there is a special case when:
>>>
>>> - notify_unmap is set, meanwhile
>>> - entry is invalid
>>>
>>> In the past, we skip the entry always.  This is not correct.  We shou=
ld
>>> send UNMAP notification to registered notifiers in this case.  Otherw=
ise
>>> some stall pages will still be mapped in the host even if L1 guest
>> You mean 'stale' here?
> Ah, yes.
>
>>> unmapped them already.
>> It looks like some IOTLB invalidation were missed? If not, the page sh=
ould
>> be unmaped during invalidation.
> I'm afraid it's not the same problem, and that's why I think we need
> two fixes.
>
> Even if the guest sends the correct invalidations, it's still possible
> that QEMU skips the PSI with current code.
>
>>> Without this patch, nested device assignment to L2 guests might dump
>>> some errors like:
>>>
>>> qemu-system-x86_64: VFIO_MAP_DMA: -17
>>> qemu-system-x86_64: vfio_dma_map(0x557305420c30, 0xad000, 0x1000,
>>>                       0x7f89a920d000) =3D -17 (File exists)
>>>
>>> To fix this, we need to apply this patch to L1 QEMU (L2 QEMU is not
>>> affected by this problem).
>>>
>>> Signed-off-by: Peter Xu<peterx@redhat.com>
>>> ---
>>>
>>> To test nested assignment, one also needs to apply below patchset:
>>> https://lkml.org/lkml/2018/4/18/5
>> Have a quick glance at it, looks like there's no need for this patch i=
s we
>> had that kernel patch applied.
> Even if guest kernel applies above fix, QEMU might still drop some of
> the PSIs.  Above error messages were captured with kernel patches
> applied already (otherwise we see no error messages, we directly miss
> them from guest).
>
> Thanks,

I see so this actually try to trigger unmap notifier for non last level=20
slpte.

Thanks
