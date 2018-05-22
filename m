Received: from eggs.gnu.org ([2001:4830:134:3::10]:42415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL2qw-0000s4-Vo
	for qemu-devel@nongnu.org; Tue, 22 May 2018 04:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL2qv-0000PE-UD
	for qemu-devel@nongnu.org; Tue, 22 May 2018 04:41:07 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:42402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fL2qv-0000On-NP
	for qemu-devel@nongnu.org; Tue, 22 May 2018 04:41:05 -0400
Received: by mail-oi0-x242.google.com with SMTP id t27-v6so15465511oij.9
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 01:41:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180522030333.GB17282@xz-mi>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-15-peter.maydell@linaro.org>
	<20180522030333.GB17282@xz-mi>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 09:40:44 +0100
Message-ID: <CAFEAcA-iOYhuPfvDv+iD6jBqXMXqN-jfTpSSBub1Zp1i-JcDbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 14/27] iommu: Add IOMMU index concept to
 IOMMU API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "patches@linaro.org" <patches@linaro.org>

On 22 May 2018 at 04:03, Peter Xu <peterx@redhat.com> wrote:
> On Mon, May 21, 2018 at 03:03:49PM +0100, Peter Maydell wrote:
>> If an IOMMU supports mappings that care about the memory
>> transaction attributes, then it no longer has a unique
>> address -> output mapping, but more than one. We can
>> represent these using an IOMMU index, analogous to TCG's
>> mmu indexes.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  include/exec/memory.h | 52 +++++++++++++++++++++++++++++++++++++++++++
>>  memory.c              | 23 +++++++++++++++++++
>>  2 files changed, 75 insertions(+)
>>
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index 309fdfb89b..f6226fb263 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -206,6 +206,20 @@ enum IOMMUMemoryRegionAttr {
>>   * to report whenever mappings are changed, by calling
>>   * memory_region_notify_iommu() (or, if necessary, by calling
>>   * memory_region_notify_one() for each registered notifier).
>> + *
>> + * Conceptually an IOMMU provides a mapping from input address
>> + * to an output TLB entry. If the IOMMU is aware of memory transaction
>> + * attributes and the output TLB entry depends on the transaction
>> + * attributes, we represent this using IOMMU indexes. Each index
>
> Hi, Peter,
>
> In what case will an IOMMU translation depend on translation
> attributes?  It seems to me that we should always pass in the
> translation attributes into the translate() function.  The translate()
> function can omit that parameter if the specific IOMMU does not need
> that information, but still I am confused about why we need to index
> IOMMU by translation attributes.

The MPC implementation at the tail end of the patchset is
one example -- it needs to look at attrs.secure, because
"translation for secure access to address X" differs from
that for address Y". The Arm SMMUv3 is the same when it supports
TrustZone (the implementation in-tree does not), and it can also
give different permissions for transactions with attrs.user = 0 vs 1.

The reason for not just passing in the transaction attributes to
translate is that
(a) the iommu index abstraction makes the notifier setup simpler:
rather than having to have some indication in the API of which
of the transaction attributes are important and which the notifier
cares about, we can just use indexs
(b) it means that it's harder to write an iommu with the bug that
it looks at parts of the transaction attributes that it didn't
claim were important in the notifier API

> The num_indexes() definition is missing, and I saw that in the next
> patch.  We'll possibly want to move it here.

Huh. I ran into that and thought I'd fixed it in my local tree -- I must have
failed to actually move the change to the right patch. Sorry about that.

thanks
-- PMM
