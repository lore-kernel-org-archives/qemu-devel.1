Received: from eggs.gnu.org ([2001:4830:134:3::10]:56224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cT40L-0004Pe-7K
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:55:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cT40I-0002Ks-68
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:55:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cT40I-0002Kf-0P
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:55:06 -0500
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-15-git-send-email-peterx@redhat.com>
	<fad506bc-2398-fef9-b720-7720569ac0a6@redhat.com>
	<20170116091801.GL30108@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0eedf780-16b2-ca5c-8eea-5d41e6837f23@redhat.com>
Date: Mon, 16 Jan 2017 17:54:55 +0800
MIME-Version: 1.0
In-Reply-To: <20170116091801.GL30108@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v3 14/14] intel_iommu: enable vfio
 devices
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



On 2017=E5=B9=B401=E6=9C=8816=E6=97=A5 17:18, Peter Xu wrote:
>>>   static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t =
domain_id,
>>>                                         hwaddr addr, uint8_t am)
>>>   {
>>> @@ -1222,6 +1251,7 @@ static void vtd_iotlb_page_invalidate(IntelIOMM=
UState *s, uint16_t domain_id,
>>>       info.addr =3D addr;
>>>       info.mask =3D ~((1 << am) - 1);
>>>       g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_page, =
&info);
>>> +    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am);
>> Is the case of GLOBAL or DSI flush missed, or we don't care it at all?
> IMHO we don't. For device assignment, since we are having CM=3D1 here,
> we should have explicit page invalidations even if guest sends
> global/domain invalidations.
>
> Thanks,
>
> -- peterx

Is this spec required? Btw, it looks to me that both DSI and GLOBAL are=20
indeed explicit flush.

Just have a quick go through on driver codes and find this something=20
interesting in intel_iommu_flush_iotlb_psi():

...
     /*
      * Fallback to domain selective flush if no PSI support or the size =
is
      * too big.
      * PSI requires page size to be 2 ^ x, and the base address is=20
naturally
      * aligned to the size
      */
     if (!cap_pgsel_inv(iommu->cap) || mask > cap_max_amask_val(iommu->ca=
p))
         iommu->flush.flush_iotlb(iommu, did, 0, 0,
                         DMA_TLB_DSI_FLUSH);
     else
         iommu->flush.flush_iotlb(iommu, did, addr | ih, mask,
                         DMA_TLB_PSI_FLUSH);
...

It looks like DSI_FLUSH is possible even for CM on.

And in flush_unmaps():

...
         /* In caching mode, global flushes turn emulation expensive */
         if (!cap_caching_mode(iommu->cap))
             iommu->flush.flush_iotlb(iommu, 0, 0, 0,
                      DMA_TLB_GLOBAL_FLUSH);
...

If I understand the comments correctly, GLOBAL is ok for CM too (though=20
the code did not do it for performance reason).

Thanks
