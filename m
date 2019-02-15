Received: from eggs.gnu.org ([209.51.188.92]:60077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1guYm4-0006ey-8c
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 03:23:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1guYm3-0007tT-EE
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 03:23:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1guYm3-0007pJ-5h
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 03:23:07 -0500
References: <1548824953-23413-1-git-send-email-yi.y.sun@linux.intel.com>
	<1548824953-23413-4-git-send-email-yi.y.sun@linux.intel.com>
	<20190212064629.GL1011@xz-x1> <20190215052234.GI16968@yi.y.sun>
	<20190215053905.GA5875@xz-x1>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0fd859bf-7456-7bff-6d2b-3f454e042f36@redhat.com>
Date: Fri, 15 Feb 2019 16:22:53 +0800
MIME-Version: 1.0
In-Reply-To: <20190215053905.GA5875@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v1 3/3] intel_iommu: add scalable-mode option
 to make scalable mode work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, Yi Sun <yi.y.sun@linux.intel.com>
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, yi.y.sun@intel.com, pbonzini@redhat.com, rth@twiddle.net


On 2019/2/15 =E4=B8=8B=E5=8D=881:39, Peter Xu wrote:
> On Fri, Feb 15, 2019 at 01:22:34PM +0800, Yi Sun wrote:
>
> [...]
>
>>>> +    /* TODO: read cap/ecap from host to decide which cap to be expo=
sed. */
>>>> +    if (s->scalable_mode) {
>>>> +        if (!s->caching_mode) {
>>>> +            error_report("Need to set caching-mode for scalable mod=
e");
>>> Could I ask why?
>>>
>> My intention is to make guest explicitly send to make sure SLT shadowi=
ng
>> correctly.
>>
>> For this point, I also have question. Why does legacy mode not check C=
M?
>> If CM is not set, may the DMA remapping be wrong because SLT cannot
>> match guest's latest change?
> Because CM is currently only required for device assignment.  For
> example, if you only have an emulated device like virtio-net-pci in
> the guest, then you don't need the CM capability to let it work with
> the vIOMMU.  That's because we'll walk the 2nd level IOMMU page table
> only when the virtio-net-pci device does DMA, and QEMU can easily do
> that (QEMU is emulating the DMA of the virtio-net-pci device, and QEMU
> has the knowledge of the guest 2nd level IOMMU page tables).  Assigned
> devices are special because the host hardware knows nothing about
> guest 2nd level page tables, so QEMU needs to shadow them before DMA
> starts.


+1

And there's dataplane (vhost) which implements device IOTLB that doesn't=20
require shadow page table. The can ask for translation for some address=20
themselves.


>
> That's also why I listed "device assignment" as a special case in the
> test device matrix, because that's the only case where we can torture
> the IOMMU page shadowing code a bit.
>
> For the scalable mode I would suppose you will still allow it to work
> without caching mode.  The example is the same as above - when there's
> only emulated devices in the guest.


Agree.

Thanks


>
> Regards,
>
