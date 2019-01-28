Received: from eggs.gnu.org ([209.51.188.92]:58596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goED9-0002oV-OQ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 16:12:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goE8w-000865-5r
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 16:08:37 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1goE8q-00083P-Ax
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 16:08:31 -0500
Received: by mail-oi1-x243.google.com with SMTP id x202so14284752oif.13
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 13:08:26 -0800 (PST)
References: <20190110121736.23448-1-richard.henderson@linaro.org>
	<20190110121736.23448-5-richard.henderson@linaro.org>
	<CAFEAcA9Yz53O1OiG-eN=0eCdnO=Lz+yJPUtqVxfFSb3rrG4TEg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ae0d3ea5-e7e1-da8e-9b10-4534a1ff9162@linaro.org>
Date: Mon, 28 Jan 2019 13:08:20 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Yz53O1OiG-eN=0eCdnO=Lz+yJPUtqVxfFSb3rrG4TEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/11] target/arm: Record the GP bit for a
 page in MemTxAttrs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1/22/19 5:26 AM, Peter Maydell wrote:
> On Thu, 10 Jan 2019 at 12:17, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This isn't really a transaction attribute, but that's the most
>> convenient place to hold a random bit of information within the
>> softmmu tlb.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  include/exec/memattrs.h | 2 ++
>>  target/arm/helper.c     | 6 ++++++
>>  2 files changed, 8 insertions(+)
>>
>> diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
>> index d4a1642098..39d61188e1 100644
>> --- a/include/exec/memattrs.h
>> +++ b/include/exec/memattrs.h
>> @@ -35,6 +35,8 @@ typedef struct MemTxAttrs {
>>      unsigned int secure:1;
>>      /* Memory access is usermode (unprivileged) */
>>      unsigned int user:1;
>> +    /* Page is marked as "guarded" */
>> +    unsigned int guarded:1;
> 
> Given that this isn't a real transaction attribute in the traditional
> sense, and it's pretty Arm-specific, I think we could do with a
> more expansive comment than this...

I have split this out to a separate patch, rearranged this to
target_tlb_bit[0-2], with a large block comment.  We will need some more of
these bits for for system mode v8.5-MemTag anyway.


>> +        guarded |= extract64(descriptor, 50, 1);  /* GP */
> 
> Do we need to do the logical-OR here? Since this is a
> block/page entry bit with no similar bit in the table
> descriptors, there's no merging to be done (ie we
> only execute this code once and 'guarded' will always
> be 'false' before execution of the |=.)

The document that I have has exactly one sentence about this, and does not
specify whether the bit is akin to the page table attributes (which appear at
every table level) or not.

As written above, this will execute more than once.


r~
