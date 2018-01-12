Received: from eggs.gnu.org ([2001:4830:134:3::10]:44918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ea4JS-0005MF-0g
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:44:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ea4JM-0005mp-Uq
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:44:22 -0500
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:38901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ea4JM-0005lq-P7
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:44:16 -0500
Received: by mail-pg0-x22c.google.com with SMTP id t67so5111547pgc.5
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 10:44:16 -0800 (PST)
References: <20171218173022.18418-1-richard.henderson@linaro.org>
	<20171218173022.18418-6-richard.henderson@linaro.org>
	<CAFEAcA_NXsPZYJHhYZShroXFUS_5SwpJCi8ehBL+o4OxpNqYmA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <436817d9-3377-3828-b513-42934cbaa949@linaro.org>
Date: Fri, 12 Jan 2018 10:44:12 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_NXsPZYJHhYZShroXFUS_5SwpJCi8ehBL+o4OxpNqYmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/9] target/arm: Add
 aa32_vfp_dreg/aa64_vfp_qreg helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 01/12/2018 10:24 AM, Peter Maydell wrote:
>> +/**
>> + * aa32_vfp_dreg:
>> + * Return a pointer to the Dn register within env in 32-bit mode.
>> + */
>> +static inline uint64_t *aa32_vfp_dreg(CPUARMState *env, unsigned regno)
>> +{
>> +    return &env->vfp.regs[regno];
>> +}
>> +
>> +/**
>> + * aa64_vfp_dreg:
>> + * Return a pointer to the Qn register within env in 64-bit mode.
>> + */
>> +static inline uint64_t *aa64_vfp_qreg(CPUARMState *env, unsigned regno)
> 
> Comment and code disagree about the name of the function...

Oops.

>> @@ -99,8 +99,10 @@ static int aarch64_write_elf64_prfpreg(WriteCoreDumpFunction f,
>>
>>      aarch64_note_init(&note, s, "CORE", 5, NT_PRFPREG, sizeof(note.vfp));
>>
>> -    for (i = 0; i < 64; ++i) {
>> -        note.vfp.vregs[i] = cpu_to_dump64(s, float64_val(env->vfp.regs[i]));
>> +    for (i = 0; i < 32; ++i) {
>> +        uint64_t *q = aa64_vfp_qreg(env, i);
>> +        note.vfp.vregs[2*i + 0] = cpu_to_dump64(s, q[0]);
>> +        note.vfp.vregs[2*i + 1] = cpu_to_dump64(s, q[1]);
> 
> This doesn't change the behaviour but I suspect it's wrong for big-endian...

Perhaps.  Since this doesn't change behaviour I'll leave this patch as-is.
That said, how does one go about testing aarch64-big-endian?  I don't think
I've seen a distro for that...

>> -            int elt = (rn * 2 + (index >> 3)) % 64;
>> -            int bitidx = (index & 7) * 8;
>> -            uint64_t val = extract64(env->vfp.regs[elt], bitidx, 8);
>> +            unsigned elt = (rn * 2 + (index >> 3)) % 64;
>> +            unsigned bitidx = (index & 7) * 8;
>> +            uint64_t *q = aa64_vfp_qreg(env, elt >> 1);
>> +            uint64_t val = extract64(q[elt & 1], bitidx, 8);
> 
> 
> Any particular reason for changing all these ints to unsigned ?

*shrug* unsigned division by power-of-two is simpler than signed.  And of
course we know these values must be positive.  I can drop that change if you want.

>>  vfp_reg_offset (int dp, int reg)
>>  {
>> -    if (dp)
>> +    if (dp) {
>>          return offsetof(CPUARMState, vfp.regs[reg]);
>> -    else if (reg & 1) {
>> -        return offsetof(CPUARMState, vfp.regs[reg >> 1])
>> -          + offsetof(CPU_DoubleU, l.upper);
>>      } else {
>> -        return offsetof(CPUARMState, vfp.regs[reg >> 1])
>> -          + offsetof(CPU_DoubleU, l.lower);
>> +        long ofs = offsetof(CPUARMState, vfp.regs[reg >> 1]);
>> +        if (reg & 1) {
>> +            ofs += offsetof(CPU_DoubleU, l.upper);
>> +        } else {
>> +            ofs += offsetof(CPU_DoubleU, l.lower);
>> +        }
>> +        return ofs;
>>      }
> 
> This hunk seems to just be rearranging the if-logic without
> doing anything else, right?

There is a name change in there.  But otherwise it's a re-factor to avoid
over-long lines and reduce duplication.


r~
