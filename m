Received: from eggs.gnu.org ([2001:4830:134:3::10]:39253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etDuo-0002KG-9f
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:50:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etDuk-0000zp-AO
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:50:06 -0500
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:42474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1etDuk-0000zQ-4K
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:50:02 -0500
Received: by mail-oi0-x234.google.com with SMTP id c18so14978353oiy.9
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 06:50:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e54bcea4-3b04-7409-89c1-b2a79010c969@redhat.com>
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
	<1518893216-9983-3-git-send-email-eric.auger@redhat.com>
	<CAFEAcA-uMZwR8HfVDx0Rau9G2unMypWJEL0o3ACPHxCqZ+g=_Q@mail.gmail.com>
	<e54bcea4-3b04-7409-89c1-b2a79010c969@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Mar 2018 14:49:40 +0000
Message-ID: <CAFEAcA_mtH-=tKzJP=iFeABK+_4Lp6rapnXdJKT9OCxLqyLQgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v9 02/14] hw/arm/smmu-common: IOMMU memory
 region and address space setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Tomasz Nowicki <tn@semihalf.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Christoffer Dall <christoffer.dall@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linuc.decode@gmail.com, Bharat Bhushan <bharat.bhushan@nxp.com>, Prem Mallappa <prem.mallappa@gmail.com>, eric.auger.pro@gmail.com

On 6 March 2018 at 14:47, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Peter,
>
> On 06/03/18 15:08, Peter Maydell wrote:
>> On 17 February 2018 at 18:46, Eric Auger <eric.auger@redhat.com> wrote:
>>> +    if (!smmu_pci_bus) {
>>> +        GHashTableIter iter;
>>> +
>>> +        g_hash_table_iter_init(&iter, s->smmu_as_by_busptr);
>>> +        while (g_hash_table_iter_next(&iter, NULL, (void **)&smmu_pci_bus)) {
>>> +            if (pci_bus_num(smmu_pci_bus->bus) == bus_num) {
>>> +                s->smmu_as_by_bus_num[bus_num] = smmu_pci_bus;
>>> +                return smmu_pci_bus;
>>> +            }
>>> +        }
>>
>> Why do we populate this hashtable lazily rather than when we
>> put the SMMUPciBus in the smmu_as_by_busptr table? Do we
>> expect this function not to ordinarily be called?
>
> This function only is used when handling invalidations (vhost/vfio). I
> can even remove it from this series at this stage and re-introduce
> latter on. From the SID, you retrieve bus_num, retrieve the SMMUPciBus.
> Andd from the function number you can then retrieve the IOMMU mr at
> smmu_bus->pbdev[devfn]
>
> That's the purpose of ths function. But I will remove it.

No, it's fine here. You should just have a comment about why
it makes sense to lazily populate the hashtable (it's overall
going to be slower than if we populated it up front), to
document the rationale for the design decision.

thanks
-- PMM
