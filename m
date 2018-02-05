Received: from eggs.gnu.org ([2001:4830:134:3::10]:46352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eijaT-0006VP-Gr
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:25:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eijaS-0004fC-Ao
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:25:45 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:34212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eijaS-0004dm-5a
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:25:44 -0500
Received: by mail-ot0-x242.google.com with SMTP id l10so1916794oth.1
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 08:25:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3659e9bc-4b71-4785-22c7-e4cb97d7b241@amsat.org>
References: <20180205105720.14620-1-peter.maydell@linaro.org>
	<20180205105720.14620-9-peter.maydell@linaro.org>
	<3659e9bc-4b71-4785-22c7-e4cb97d7b241@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Feb 2018 16:25:23 +0000
Message-ID: <CAFEAcA9oCtpGWJhuV-j8tn=gK8NMJwm-wcA5L6J91xyDU-ATKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 8/8] hw/intc/armv7m_nvic: Fix
 byte-to-interrupt number conversions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 5 February 2018 at 16:16, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> Hi Peter,
>
> On 02/05/2018 07:57 AM, Peter Maydell wrote:
>> In many of the NVIC registers relating to interrupts, we
>> have to convert from a byte offset within a register set
>> into the number of the first interrupt which is affected.
>> We were getting this wrong for:
>>  * reads of NVIC_ISPR<n>, NVIC_ISER<n>, NVIC_ICPR<n>, NVIC_ICER<n>,
>>    NVIC_IABR<n> -- in all these cases we were missing the "* 8"
>>    needed to convert from the byte offset to the interrupt number
>>    (since all these registers use one bit per interrupt)
>>  * writes of NVIC_IPR<n> had the opposite problem of a spurious
>>    "* 8" (since these registers use one byte per interrupt)
>
> What about using inline function (suggested) with those comments to ease
> code review, since this code is kinda confusing at first.
>
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> at any rate:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
>> ---
>>  hw/intc/armv7m_nvic.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
>> index 8726be796e..9433efd1b8 100644
>> --- a/hw/intc/armv7m_nvic.c
>> +++ b/hw/intc/armv7m_nvic.c
>> @@ -1721,7 +1721,7 @@ static MemTxResult nvic_sysreg_read(void *opaque, =
hwaddr addr,
>>          /* fall through */
>>      case 0x180 ... 0x1bf: /* NVIC Clear enable */
>>          val =3D 0;
>> -        startvec =3D offset - 0x180 + NVIC_FIRST_IRQ; /* vector # */
>> +        startvec =3D 8 * (offset - 0x180) + NVIC_FIRST_IRQ; /* vector #=
 */
>
> static uint32_t off2vec_rd(uint32_t offset, uint32_t base)
> {
>     return 8 * (offset - base) + NVIC_FIRST_IRQ;
> }

This function name suggests that it's for reads, which isn't
what's going on here. The 8 * version is for registers which
have 1 bit per interrupt. The version without 8* is for
registers which have 8 bits per interrupt. It just happens
that we got the reads wrong for a bunch of 1-bit-per-interrupt
registers and the writes wrong for an 8-bit-per-interrupt reg.
(I have a feeling this is something I noticed at some point in
code review of the original author's patches, and then didn't
realize had been not quite corrected in all the places it needed
to be, and overcorrected in one spot.)

Also, if you hide the "8 *" inside a function here, you lose
the fact that it parallels the multiplication in "end =3D size * 8"
in each of these loops. So I agree that it's confusing, but
overall I think it's better to have all the logic in one
place so you can read the whole loop easily.

thanks
-- PMM
