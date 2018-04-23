Received: from eggs.gnu.org ([2001:4830:134:3::10]:56713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAc44-00006l-2R
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 10:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAc3y-0002jr-Fk
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 10:03:32 -0400
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:38063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fAc3y-0002jL-86
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 10:03:26 -0400
Received: by mail-ot0-x22c.google.com with SMTP id j27-v6so17159069ota.5
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 07:03:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <677f3faa-24bd-0679-47ae-2dc9bd1c9bda@redhat.com>
References: <1523518688-26674-1-git-send-email-eric.auger@redhat.com>
	<1523518688-26674-4-git-send-email-eric.auger@redhat.com>
	<CAFEAcA84iZV8vUK4DxPpuO6LwUqE=LEoW63qy=FTiF6KHvYhEw@mail.gmail.com>
	<677f3faa-24bd-0679-47ae-2dc9bd1c9bda@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Apr 2018 15:03:04 +0100
Message-ID: <CAFEAcA9C2uuvE7MRt+TUnRARytKU5aH62FHf7c6F49KwRV-nFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v11 03/17] hw/arm/smmu-common: VMSAv8-64
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
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <cdall@kernel.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

On 23 April 2018 at 13:10, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Peter,
>
> On 04/16/2018 02:59 PM, Peter Maydell wrote:
>> On 12 April 2018 at 08:37, Eric Auger <eric.auger@redhat.com> wrote:

>>> +/**
>>> + * TODO: handle the case where the level resolves less than
>>> + * granule_sz -3 IA bits.
>>> + */
>>> +static inline
>>> +uint64_t iova_level_offset(uint64_t iova, int level, int granule_sz)
>>> +{
>>> +    return (iova >> level_shift(level, granule_sz)) &
>>> +            MAKE_64BIT_MASK(0, granule_sz - 3);
>>> +}
>>> +
>>> +#endif
>>
>> When does the TODO case happen, and what goes wrong?
> Sorry for the delay [back to the office].
>
> This refers to
> D4.2 of ARM ARM , Effect of granule size on translation table addressing
> and indexing/ Reduced IA width.
>
> "
> Depending on the configuration and implementation choices, the required
> input address width for the initial level of lookup might be smaller
> than the number of address bits that can be resolved at that level"
>
> For instance with 4k granule and IA limited to 35 bit, we use a 9-bit
> mask here and initial level 1 offset is based on IA[30, 38] although IA
> is limited to 35.

Hmm. We do get this right for the table walk code in
target/arm/helper.c, so it would be kind of nice to get it
right here too.

thanks
-- PMM
