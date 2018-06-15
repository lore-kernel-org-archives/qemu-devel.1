Received: from eggs.gnu.org ([2001:4830:134:3::10]:35170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTrG9-0004nT-Gz
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:07:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTrG8-0007wC-NT
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:07:33 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:36665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTrG8-0007vq-5b
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:07:32 -0400
Received: by mail-ot0-x243.google.com with SMTP id c15-v6so11567488otl.3
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 09:07:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <64ff124d-fe34-75eb-e9e6-7c419827ee3c@redhat.com>
References: <20180604152941.20374-1-peter.maydell@linaro.org>
	<20180604152941.20374-9-peter.maydell@linaro.org>
	<64ff124d-fe34-75eb-e9e6-7c419827ee3c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 17:07:11 +0100
Message-ID: <CAFEAcA8ioVZuB61XWQKKRyGAJxn1gge4fjbrQuK21-drh6y81Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 08/13] hw/misc/tz_mpc.c: Honour the
 BLK_LUT settings in translate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On 15 June 2018 at 08:31, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Peter,
>
> On 06/04/2018 05:29 PM, Peter Maydell wrote:
>> The final part of the Memory Protection Controller we need to
>> implement is actually using the BLK_LUT data programmed by the
>> guest to determine whether to block the transaction or not.
>>
>> Since this means we now change transaction mappings when
>> the guest writes to BLK_LUT, we must also call the IOMMU
>> notifiers at that point.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

>> +        if (newlut & (1 << i)) {
> Add a comment saying the block is configured as non-secure?

Sure.

>> +            entry.target_as = &s->blocked_io_as;
>> +        } else {
>> +            entry.target_as = &s->downstream_as;
> so this disallows any secure access to non secure blocks. I have a
> reduced knowledge of TZ but I would have thought that a secure access
> would have sufficient priviledge to access NS memory?

The spec is not as clear as it could be on this point, but...

>> @@ -362,9 +407,10 @@ static IOMMUTLBEntry tz_mpc_translate(IOMMUMemoryRegion *iommu,
>>      /* Look at the per-block configuration for this address, and
>>       * return a TLB entry directing the transaction at either
>>       * downstream_as or blocked_io_as, as appropriate.
>> -     * For the moment, always permit accesses.
>> +     * If the LUT cfg_ns bit is 1, only non-secure transactions
>> +     * may pass. If the bit is 0, only secure transactions may pass.
>>       */

...as this comment says, the MPC doesn't permit wrong-secure-state
transactions either way. (This is the same behaviour as for the
Peripheral Protection Controller, whose spec is clearer.)

thanks
-- PMM
