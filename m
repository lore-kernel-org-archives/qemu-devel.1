Received: from eggs.gnu.org ([2001:4830:134:3::10]:55359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cRyEi-0007E9-Pa
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:33:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cRyEf-0006p9-IW
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:33:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cRyEf-0006ov-9g
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:33:25 -0500
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-5-git-send-email-peterx@redhat.com>
	<1e4ed054-d933-6e73-e1a1-cdf898f05ba8@redhat.com>
	<20170113091316.GW4450@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5c443f87-faf2-b7f5-c228-153a1b8c852d@redhat.com>
Date: Fri, 13 Jan 2017 17:33:16 +0800
MIME-Version: 1.0
In-Reply-To: <20170113091316.GW4450@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v3 04/14] intel_iommu: fix trace for
 inv desc handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com



On 2017=E5=B9=B401=E6=9C=8813=E6=97=A5 17:13, Peter Xu wrote:
> On Fri, Jan 13, 2017 at 03:46:31PM +0800, Jason Wang wrote:
>>
>> On 2017=E5=B9=B401=E6=9C=8813=E6=97=A5 11:06, Peter Xu wrote:
>>> VT-d codes are still using static DEBUG_INTEL_IOMMU macro. That's not
>>> good, and we should end the day when we need to recompile the code
>>> before getting useful debugging information for vt-d. Time to switch =
to
>>> the trace system.
>>>
>>> This is the first patch to do it.
>>>
>>> Generally, the rule of mine is:
>>>
>>> - for the old GENERAL typed message, I use error_report() directly if
>>>    apply. Those are something shouldn't happen, and we should print t=
hose
>>>    errors in all cases, even without enabling debug and tracing.
>> Looks like some were guest trigger-able. If yes, let's try not use
>> error_report() for not being flooded.
> Yes, it's intended. Most of the error_report()s in this patch can be
> triggered by guest, but only by illegal guest behaviors (e.g.,
> non-zero reserved fields, or illegal descriptors, etc.). In that
> sense, shall we keep them even guest can trigger them? Since people
> will never see them if they are running generic and good kernels. More
> importantly, these error_report()s can be good hints when guest
> encounters issues, for better debugging and triaging.
>
> Actually we have such usage in existing QEMU as well. For example,
> when we maintain the DMA mapping in vfio-pci, it's possible that the
> shadow page table is mapped illegally due to some reason (that depends
> on the guest as well, may not be guest kernel, but DPDK applications
> inside guest), and the map() can fail. Here we have:
>
>      ret =3D vfio_dma_map(container, iova,
>                          iotlb->addr_mask + 1, vaddr,
>                          !(iotlb->perm & IOMMU_WO) || mr->readonly);
>      if (ret) {
>          error_report("vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
>                          "0x%"HWADDR_PRIx", %p) =3D %d (%m)",
>                          container, iova,
>                          iotlb->addr_mask + 1, vaddr, ret);
>      }
>
> Which I think is playing the same role here - we will never see these
> lines if the guest is normal, and these lines will be useful when bad
> things happen.
>
> So I would slightly prefer that we keep these error_reports() for now,
> as long as they won't flush the screen for most of the users. (during
> the time I played with this series, none of them jumped out :)

I think the point is just surviving from malicious guests. So we need=20
avoid guest trigger-able thing likes this, consider if we redirect=20
stderr to a log file, malicious guest may exhaust disk space which is a=20
DOS. So we'd better avoid them.

Thanks

>
> Thanks,
>
> -- peterx
