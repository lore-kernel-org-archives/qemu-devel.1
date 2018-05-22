Received: from eggs.gnu.org ([2001:4830:134:3::10]:38330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLBRa-0000ej-8G
	for qemu-devel@nongnu.org; Tue, 22 May 2018 13:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLBRZ-0002R8-DE
	for qemu-devel@nongnu.org; Tue, 22 May 2018 13:51:30 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:40086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLBRZ-0002Qp-7D
	for qemu-devel@nongnu.org; Tue, 22 May 2018 13:51:29 -0400
Received: by mail-oi0-x243.google.com with SMTP id c203-v6so17023540oib.7
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 10:51:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5655dec4-6d82-a02c-2155-300c4baf1adf@twiddle.net>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-15-peter.maydell@linaro.org>
	<5655dec4-6d82-a02c-2155-300c4baf1adf@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 18:51:07 +0100
Message-ID: <CAFEAcA-Cb2sLTz1RNiiPLm=+92poENNF9WHuJrgLe1VGHnPV8A@mail.gmail.com>
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
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 22 May 2018 at 18:42, Richard Henderson <rth@twiddle.net> wrote:
> On 05/21/2018 07:03 AM, Peter Maydell wrote:
>> +    /* Return the IOMMU index to use for a given set of transaction attributes.
>> +     *
>> +     * Optional method: if an IOMMU only supports a single IOMMU index then
>> +     * the default implementation of memory_region_iommu_attrs_to_index()
>> +     * will return 0.
>> +     *
>> +     * The indexes supported by an IOMMU must be contiguous, starting at 0.
>> +     *
>> +     * @iommu: the IOMMUMemoryRegion
>> +     * @attrs: memory transaction attributes
>> +     */
>> +    int (*attrs_to_index)(IOMMUMemoryRegion *iommu, MemTxAttrs attrs);
>> +
>> +    /* Return the number of IOMMU indexes this IOMMU supports.
>> +     *
>> +     * Optional method: if this method is not provided, then
>> +     * memory_region_iommu_num_indexes() will return 1, indicating that
>> +     * only a single IOMMU index is supported.
>> +     */
>
> The mispatched callback has been discussed, but would it be equally useful to
> simply have a variable here instead of a callback?  Perhaps max_index instead
> of num_indexes so that zero-initialization of the structure does the right
> thing for existing iommu's.

That wouldn't allow for multiple instances of the same class where the
answer is different (eg "my_iommu->has_trustzone_support ? 2 : 1" where
the answer depends on how the instance is configured via QOM properties).

thanks
-- PMM
