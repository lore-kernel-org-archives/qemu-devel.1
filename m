Received: from eggs.gnu.org ([2001:4830:134:3::10]:39631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDXmH-0007Ka-Ro
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDXmG-0003GG-US
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:37:33 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDXmE-0003FH-Uq
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:37:31 -0400
Received: by mail-ot1-x341.google.com with SMTP id l1so33774091otj.5
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 09:37:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2c425566-53b5-e299-ccb1-09793ab673d5@linaro.org>
References: <20181019015617.22583-1-richard.henderson@linaro.org>
	<20181019015617.22583-4-richard.henderson@linaro.org>
	<CAFEAcA81rDucGOEVYi1LCw=1eiHisuM8+yXGzaw2dMktdU99cw@mail.gmail.com>
	<1dda484c-1fc8-f75e-3150-111b0c7d85f9@linaro.org>
	<CAFEAcA8f2SvmsABANVrWLZo8NzeAirMOqsm7AnyPCVVKL_z0Sw@mail.gmail.com>
	<2c425566-53b5-e299-ccb1-09793ab673d5@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:37:09 +0100
Message-ID: <CAFEAcA-NK7sMBBXg4e1c=B_BxypKWAiBnZu1p4gMohTqL=gT8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] target/arm: Flush only the TLBs
 affected by TTBR*_EL1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 October 2018 at 17:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 10/19/18 9:12 AM, Peter Maydell wrote:
>> A conservative check is probably:
>>   if arm_current_el() < 3
>>      // TTBR definitely can only be affecting the EL0/1
>>      // translation regime for the current security state
>>      if arm_is_secure_below_el3()
>>         if EL3 is AArch32
>>             flush S1SE0, S1E3
>>         else
>>             flush S1SE0, S1SE1
>>      else
>>         flush S12NSE1, S12NSE0
>>   else
>>      // err on the side of flushing more than maybe we need to
>>      flush S1SE0, S12NSE1, S12NSE0
>>      if EL3 is AArch32
>>           flush S1E3
>>      else
>>           flush S1SE1
>>
>> (but you should check my logic ;-))
>
> Riiight.
>
> Clearly it would be simpler and safer to track unused tlbs within cputlb.c.

The advantage of the above logic is that it means that even
when we do have trustzone and are using the secure TLBs,
we only flush the side we need to, not the whole lot.
(But yeah, it's a bit hairy.)

> So drop this patch for now and I'll get back to it.  The other two in this
> series are at least incremental improvement in the meantime.

OK, I'll put those in target-arm.next.

thanks
-- PMM
