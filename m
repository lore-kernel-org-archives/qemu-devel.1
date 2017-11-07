Received: from eggs.gnu.org ([2001:4830:134:3::10]:41915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eCCjJ-00035X-3P
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 17:52:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eCCjE-0001ks-Vq
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 17:52:25 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:43406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eCCjE-0001kB-LQ
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 17:52:20 -0500
Received: by mail-pl0-x244.google.com with SMTP id t7so1264plm.0
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 14:52:20 -0800 (PST)
References: <1467696699-8941-9-git-send-email-david@gibson.dropbear.id.au>
	<52275d2d-0a93-fe92-56ed-7841fa5a79dc@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <518a60a2-9c65-9eda-471c-83596e746bfb@ozlabs.ru>
Date: Wed, 8 Nov 2017 09:52:12 +1100
MIME-Version: 1.0
In-Reply-To: <52275d2d-0a93-fe92-56ed-7841fa5a79dc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL,
 08/14] spapr_pci/spapr_pci_vfio: Support Dynamic DMA Windows (DDW)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org, agraf@suse.de, qemu-devel@nongnu.org, alex.williamson@redhat.com, qemu-ppc@nongnu.org

On 07/11/17 19:42, Laurent Vivier wrote:
> On 05/07/2016 07:31, David Gibson wrote:
>> From: Alexey Kardashevskiy <aik@ozlabs.ru>
>>
>> This adds support for Dynamic DMA Windows (DDW) option defined by
>> the SPAPR specification which allows to have additional DMA window(s)
>>
>> The "ddw" property is enabled by default on a PHB but for compatibility
>> the pseries-2.6 machine and older disable it.
>> This also creates a single DMA window for the older machines to
>> maintain backward migration.
>>
>> This implements DDW for PHB with emulated and VFIO devices. The host
>> kernel support is required. The advertised IOMMU page sizes are 4K and
>> 64K; 16M pages are supported but not advertised by default, in order to
>> enable them, the user has to specify "pgsz" property for PHB and
>> enable huge pages for RAM.
> 
> Why is it not advirtised by default?

I do not remember clearly but this kind of automation is usually less
manageable. What if we do not want huge IOMMU pages for some reason?


> When we start qemu with hugepage memory ("mount -t hugetlbfs none
> /mnt/kvm_hugepage" and ".. -mem-path /mnt/kvm_hugepage .."), we have an
> ugly message:
> 
> "qemu-kvm: System page size 0x1000000 is not enabled in page_size_mask
> (0x11000). Performance may be slow"
> 
> I understand if we want to use this with VFIO, we need something like
> "-global spapr-pci-host-bridge.pgsz=0x1011000".
> 
> But is it needed if we don't use VFIO?

Yes, TCE tables are still created in KVM so the size matters.

> Is it a way QEMU adds automatically the 0x1000000 mask to page_size_mask?

No. That thing which decides about -mem-path should also add the pgsz mask.


-- 
Alexey
