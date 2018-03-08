Received: from eggs.gnu.org ([2001:4830:134:3::10]:56358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eu0nb-0007h9-EN
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:01:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eu0na-0001hV-Ln
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:01:55 -0500
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:43670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eu0na-0001hM-H9
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:01:54 -0500
Received: by mail-ot0-x229.google.com with SMTP id m22so6409477otf.10
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 11:01:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <c9174fa5-263a-50ec-e3c9-8272cbb08b4a@redhat.com>
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
	<1518893216-9983-4-git-send-email-eric.auger@redhat.com>
	<CAFEAcA_scj3Nw+W6a7NL6bRR3ZGvUx1NLa4cWSmvfOA1BCEPgQ@mail.gmail.com>
	<f1e870f8-9669-ffde-0556-bc8b16467356@redhat.com>
	<CAFEAcA8+CDvbsQw5EKz5t0JJa1oNpteu+=X5JHxFNdyBUu7OTw@mail.gmail.com>
	<c9174fa5-263a-50ec-e3c9-8272cbb08b4a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Mar 2018 19:01:33 +0000
Message-ID: <CAFEAcA8je7Rze39AeMDN_9RphNOvn9ycEgm3EbVL64G_+V9xPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v9 03/14] hw/arm/smmu-common: VMSAv8-64
 page table walk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>

On 8 March 2018 at 18:56, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Peter,
> On 07/03/18 17:35, Peter Maydell wrote:
>> On 7 March 2018 at 16:23, Auger Eric <eric.auger@redhat.com> wrote:
>>> Hi Peter,
>>>
>>> On 06/03/18 20:43, Peter Maydell wrote:
>>>> On 17 February 2018 at 18:46, Eric Auger <eric.auger@redhat.com> wrote:
>>>>> +#define is_permission_fault(ap, perm) \
>>>>> +    (((perm) & IOMMU_WO) && ((ap) & 0x2))
>>>>
>>>> Don't we also need to check AP bit 1 in some cases?
>>>> (when the StreamWorld is S or NS EL1 and either (a) the incoming
>>>> transaction has its attrs.user = 1 and STE.PRIVCFG is 0b0x, or
>>>> (b) STE.PRIVCFG is 0b10).
>>> I think I don't need to as I don't support this feature at the moment:
>>> spec says:
>>> "When SMMU_IDR1.ATTR_PERMS_OVR=0, this field is RES0 and the incoming
>>> PRIV attribute is used."
>>> But to be honest I was not aware this existed ;()
>>
>> I think you still need to check the incoming transaction
>> for user vs priv, even if you don't support STE.PRIVCFG.
>
> On the CPU side, you have MemTxAttrs as input from get_phys_addr_lpae().
>
> On IOMMU side, the current input callback for translation is
>
> static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr
> addr, IOMMUAccessFlags flag)
>
> where IOMMUAccessFlags just is R/W access flag.
>
> So I am not sure I have acess to those user/priv attributes.

Hmm, yes. This looks like a deficiency in our IOMMU framework.
For the moment put a TODO note that we treat all transactions
as privileged because QEMU's IOMMU code doesn't pass transaction
attributes around correctly.

(This will also be an issue for secure/nonsecure eventually.)

thanks
-- PMM
