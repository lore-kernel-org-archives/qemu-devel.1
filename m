Received: from eggs.gnu.org ([2001:4830:134:3::10]:44541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edegM-0005dl-FT
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:10:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edegH-0000hv-EJ
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:10:50 -0500
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:32940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1edegH-0000hb-8W
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:10:45 -0500
Received: by mail-pg0-x233.google.com with SMTP id u1so7436826pgr.0
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 08:10:45 -0800 (PST)
References: <20180119045438.28582-1-richard.henderson@linaro.org>
	<20180119045438.28582-12-richard.henderson@linaro.org>
	<CAFEAcA_ACU1KRgth8B+hNr2BeDYzRQEz4KeA2cOytPsn_xfKjQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5be6eafb-7315-d33c-9bb6-19f975be1bbf@linaro.org>
Date: Mon, 22 Jan 2018 08:10:40 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ACU1KRgth8B+hNr2BeDYzRQEz4KeA2cOytPsn_xfKjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 11/16] target/arm: Add SVE to migration
 state
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

On 01/22/2018 06:16 AM, Peter Maydell wrote:
>> +/* The first two words of each Zreg is stored in VFP state.  */
>> +static const VMStateDescription vmstate_zreg_hi_reg = {
>> +    .name = "cpu/sve/zreg_hi",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT64_SUB_ARRAY(d, ARMVectorReg, 2, ARM_MAX_VQ - 2),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +static const VMStateDescription vmstate_preg_reg = {
>> +    .name = "cpu/sve/preg",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT64_ARRAY(p, ARMPredicateReg, 2 * ARM_MAX_VQ / 8),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +static const VMStateDescription vmstate_sve = {
>> +    .name = "cpu/sve",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = sve_needed,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_STRUCT_ARRAY(env.vfp.zregs, ARMCPU, 32, 0,
>> +                             vmstate_zreg_hi_reg, ARMVectorReg),
>> +        VMSTATE_STRUCT_ARRAY(env.vfp.pregs, ARMCPU, 17, 0,
>> +                             vmstate_preg_reg, ARMPredicateReg),
> 
> Is it the QEMU_ALIGNED attribute that means we need to do the pregs
> via a STRUCT_ARRAY rather than being able to use a UINT64_2DARRAY ?

I didn't try; I was copying from the x86 code.


r~
