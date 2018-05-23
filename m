Received: from eggs.gnu.org ([2001:4830:134:3::10]:60300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLSMB-0001ke-Og
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:55:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLSMA-0006iQ-UQ
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:55:03 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:44668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLSMA-0006i6-PE
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:55:02 -0400
Received: by mail-ot0-x244.google.com with SMTP id g7-v6so24827305otj.11
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 04:55:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87y3gatznc.fsf@linaro.org>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-21-peter.maydell@linaro.org>
	<87y3gatznc.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 23 May 2018 12:54:41 +0100
Message-ID: <CAFEAcA82=CU=Pksgs5YO9_Vw5jqFgQqxnuFN+KZ1dw-ao8D7Xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 20/27] hw/misc/tz-mpc.c: Implement correct
 blocked-access behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 23 May 2018 at 11:49, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> The MPC is guest-configurable for whether blocked accesses:
>>  * should be RAZ/WI or cause a bus error
>>  * should generate an interrupt or not
>>
>> Implement this behaviour in the blocked-access handlers.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  hw/misc/tz-mpc.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 48 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
>> index 93453cbef2..39a72563b7 100644
>> --- a/hw/misc/tz-mpc.c
>> +++ b/hw/misc/tz-mpc.c
>> @@ -43,6 +43,9 @@ REG32(INT_EN, 0x28)
>>      FIELD(INT_EN, IRQ, 0, 1)
>>  REG32(INT_INFO1, 0x2c)
>>  REG32(INT_INFO2, 0x30)
>> +    FIELD(INT_INFO2, HMASTER, 0, 16)
>> +    FIELD(INT_INFO2, HNONSEC, 16, 1)
>> +    FIELD(INT_INFO2, CFG_NS, 17, 1)
>>  REG32(INT_SET, 0x34)
>>      FIELD(INT_SET, IRQ, 0, 1)
>>  REG32(PIDR4, 0xfd0)
>> @@ -266,6 +269,45 @@ static const MemoryRegionOps tz_mpc_reg_ops =3D {
>>      .impl.max_access_size =3D 4,
>>  };
>>
>> +static inline bool tz_mpc_cfg_ns(TZMPC *s, hwaddr addr)
>> +{
>> +    /* Return the cfg_ns bit from the LUT for the specified address */
>> +    hwaddr blknum =3D addr / s->blocksize;
>> +    hwaddr blkword =3D blknum / 32;
>> +    uint32_t blkbit =3D 1U << (blknum % 32);
>> +
>> +    /* This would imply the address was larger than the size we
>> +     * defined this memory region to be, so it can't happen.
>> +     */
>> +    assert(blkword < s->blk_max);
>> +    return s->blk_lut[blkword] & blkbit;
>> +}
>> +
>> +static MemTxResult tz_mpc_handle_block(TZMPC *s, hwaddr addr, MemTxAttr=
s attrs)
>> +{
>> +    /* Handle a blocked transaction: raise IRQ, capture info, etc */
>> +    if (!s->int_stat) {
>> +        /* First blocked transfer: capture information into INT_INFO1 a=
nd
>> +         * INT_INFO2. Subsequent transfers are still blocked but don't
>> +         * capture information until the guest clears the interrupt.
>> +         */
>> +
>> +        s->int_info1 =3D addr;
>> +        s->int_info2 =3D 0;
>> +        s->int_info2 =3D FIELD_DP32(s->int_info2, INT_INFO2, HMASTER,
>> +                                  attrs.requester_id & 0xffff);
>
> Does this actually need masking given the source is a 16 bit wide bitfiel=
d?

That might change in future (eg Eric was talking about wanting
to put SMMUv3 substream IDs in transaction attributes, and those
are 20 bits wide, so we might want to widen requester_id to fit them).

thanks
-- PMM
