Received: from eggs.gnu.org ([2001:4830:134:3::10]:45479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1eZpcr-0005Ch-4D
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 22:03:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1eZpco-0004jE-Hg
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 22:03:25 -0500
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:42893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1eZpco-0004iw-CN
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 22:03:22 -0500
Received: by mail-pg0-x22f.google.com with SMTP id q67so3657714pga.9
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 19:03:22 -0800 (PST)
Date: Thu, 11 Jan 2018 19:03:20 -0800 (PST)
In-Reply-To: <CAHNT7Nvw1J2Xv=CDLhyRNz44Ljd2ME60SjoKMGJ0uT8ZxLtrXA@mail.gmail.com>
Message-ID: <mhng-8fadbcc8-adf6-4aba-b39d-56aa8c8c4f00@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [Qemu-devel] [PATCH v3 03/21] RISC-V CPU Core Definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org, kbastian@mail.uni-paderborn.de, sagark@eecs.berkeley.edu, patches@groups.riscv.org

On Thu, 11 Jan 2018 09:55:36 PST (-0800), Michael Clark wrote:
> On Fri, Jan 12, 2018 at 3:37 AM, Richard Henderson <
> richard.henderson@linaro.org> wrote:
>
>> On 01/10/2018 06:21 PM, Michael Clark wrote:
>> > +static inline void cpu_get_tb_cpu_state(CPURISCVState *env,
>> target_ulong *pc,
>> > +                                        target_ulong *cs_base, uint32_t
>> *flags)
>> > +{
>> > +    *pc = env->pc;
>> > +    *cs_base = 0;
>> > +    *flags = 0; /* necessary to avoid compiler warning */
>> > +}
>>
>> Actually, at minimum you have to put enough into flags to differentiate
>> machine
>> vs supervisor vs user mode.  Otherwise you can wind up running a previously
>> translated block with the wrong permissions.
>>
>> The patch I saw from Stefan O'Rear would do nicely.

Thanks for pointing this out.  I've just hopped on board here (and I'm way 
oversubscribed, so I might not be that responsive), so I'm sure to have missed 
a lot.

>>
>
> OK. I didn't see the patch. I'll trawl through my email for the last couple
> of weeks before the next spin.

I think this is it

    https://github.com/riscv/riscv-qemu/commit/a038a2874a3eba27650c164f4622e47a3fe95199.patch

which I've blindly applied to our repo here:

    https://github.com/riscv/riscv-qemu/pull/93

We'll be sure to fix it for the v3.

Thanks!

> So any CPU state that can effect translation should be in flags?

That's the first comment in the patch -- though that about exhausts my 
knowledge of it :)

    +/* tb_flags must contain all information that affects execution of ordinary
    + * instructions (helpers can look at the CPURISCVState) */

> Assuming that is the case, we could probably join mode with the lower 26
> bits of misa and we probably should do a tb_flush on misa CSR writes if any
> bits are changed. i.e. if extensions such as MAFDC are added or
> removed (muldiv, atomics, fp-single, fp-double, compressed).

I agree: I think any MISA bit change would result in different translation 
behavior.
