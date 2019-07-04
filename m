Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DA4C0650E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 05:50:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89C6921882
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 05:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C6921882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiue2-00035t-Fs
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 01:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36232)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hiuZI-0001aX-Mm
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 01:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hiuZG-0000cv-Fy
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 01:46:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41082)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hiuZE-0000Xd-Do
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 01:46:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3E26181DE0;
 Thu,  4 Jul 2019 05:45:56 +0000 (UTC)
Received: from [10.72.12.202] (ovpn-12-202.pek2.redhat.com [10.72.12.202])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A88A71758A;
 Thu,  4 Jul 2019 05:45:43 +0000 (UTC)
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20190624091811.30412-1-peterx@redhat.com>
 <20190624091811.30412-3-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e8d78a5e-3c9a-30de-78a8-f8fdb2589bec@redhat.com>
Date: Thu, 4 Jul 2019 13:45:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190624091811.30412-3-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 04 Jul 2019 05:45:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/2] intel_iommu: Fix unexpected unmaps
 during global unmap
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>,
 Auger Eric <eric.auger@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/6/24 =E4=B8=8B=E5=8D=885:18, Peter Xu wrote:
> This is an replacement work of Yan Zhao's patch:
>
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg625340.html
>
> vtd_address_space_unmap() will do proper page mask alignment to make
> sure each IOTLB message will have correct masks for notification
> messages (2^N-1), but sometimes it can be expanded to even supercede
> the registered range.


I wonder under what circumstance that could we meet this?

Thanks


>   That could lead to unexpected UNMAP of already
> mapped regions in some other notifiers.
>
> Instead of doing mindless expension of the start address and address
> mask, we split the range into smaller ones and guarantee that each
> small range will have correct masks (2^N-1) and at the same time we
> should also try our best to generate as less IOTLB messages as
> possible.
>
> Reported-by: Yan Zhao <yan.y.zhao@intel.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/i386/intel_iommu.c | 67 ++++++++++++++++++++++++++----------------=
-
>   1 file changed, 41 insertions(+), 26 deletions(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 719ce19ab3..de86f53b4e 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3363,11 +3363,28 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUStat=
e *s, PCIBus *bus, int devfn)
>       return vtd_dev_as;
>   }
>  =20
> +static uint64_t get_naturally_aligned_size(uint64_t start,
> +                                           uint64_t size, int gaw)
> +{
> +    uint64_t max_mask =3D 1ULL << gaw;
> +    uint64_t alignment =3D start ? start & -start : max_mask;
> +
> +    alignment =3D MIN(alignment, max_mask);
> +    size =3D MIN(size, max_mask);
> +
> +    if (alignment <=3D size) {
> +        /* Increase the alignment of start */
> +        return alignment;
> +    } else {
> +        /* Find the largest page mask from size */
> +        return 1ULL << (63 - clz64(size));
> +    }
> +}
> +
>   /* Unmap the whole range in the notifier's scope. */
>   static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifie=
r *n)
>   {
> -    IOMMUTLBEntry entry;
> -    hwaddr size;
> +    hwaddr size, remain;
>       hwaddr start =3D n->start;
>       hwaddr end =3D n->end;
>       IntelIOMMUState *s =3D as->iommu_state;
> @@ -3388,39 +3405,37 @@ static void vtd_address_space_unmap(VTDAddressS=
pace *as, IOMMUNotifier *n)
>       }
>  =20
>       assert(start <=3D end);
> -    size =3D end - start;
> +    size =3D remain =3D end - start + 1;
>  =20
> -    if (ctpop64(size) !=3D 1) {
> -        /*
> -         * This size cannot format a correct mask. Let's enlarge it to
> -         * suite the minimum available mask.
> -         */
> -        int n =3D 64 - clz64(size);
> -        if (n > s->aw_bits) {
> -            /* should not happen, but in case it happens, limit it */
> -            n =3D s->aw_bits;
> -        }
> -        size =3D 1ULL << n;
> +    while (remain >=3D VTD_PAGE_SIZE) {
> +        IOMMUTLBEntry entry;
> +        uint64_t mask =3D get_naturally_aligned_size(start, remain, s-=
>aw_bits);
> +
> +        assert(mask);
> +
> +        entry.iova =3D start;
> +        entry.addr_mask =3D mask - 1;
> +        entry.target_as =3D &address_space_memory;
> +        entry.perm =3D IOMMU_NONE;
> +        /* This field is meaningless for unmap */
> +        entry.translated_addr =3D 0;
> +
> +        memory_region_notify_one(n, &entry);
> +
> +        start +=3D mask;
> +        remain -=3D mask;
>       }
>  =20
> -    entry.target_as =3D &address_space_memory;
> -    /* Adjust iova for the size */
> -    entry.iova =3D n->start & ~(size - 1);
> -    /* This field is meaningless for unmap */
> -    entry.translated_addr =3D 0;
> -    entry.perm =3D IOMMU_NONE;
> -    entry.addr_mask =3D size - 1;
> +    assert(!remain);
>  =20
>       trace_vtd_as_unmap_whole(pci_bus_num(as->bus),
>                                VTD_PCI_SLOT(as->devfn),
>                                VTD_PCI_FUNC(as->devfn),
> -                             entry.iova, size);
> +                             n->start, size);
>  =20
> -    map.iova =3D entry.iova;
> -    map.size =3D entry.addr_mask;
> +    map.iova =3D n->start;
> +    map.size =3D size;
>       iova_tree_remove(as->iova_tree, &map);
> -
> -    memory_region_notify_one(n, &entry);
>   }
>  =20
>   static void vtd_address_space_unmap_all(IntelIOMMUState *s)

