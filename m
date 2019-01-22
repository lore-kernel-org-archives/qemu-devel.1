Received: from eggs.gnu.org ([209.51.188.92]:57886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gm1JJ-0000MM-IU
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:02:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gm1JI-0005HO-7A
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:02:09 -0500
Received: from fallback22.m.smailru.net ([94.100.176.132]:43786
	helo=fallback22.mail.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1gm1JH-0005AK-Hq
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:02:08 -0500
Received: from [10.161.64.43] (port=52558 helo=smtp35.i.mail.ru)
	by fallback22.m.smailru.net with esmtp (envelope-from <jusual@mail.ru>)
	id 1glwaN-00008h-4o
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:59:27 +0300
References: <20190115143650.15725-1-jusual@mail.ru>
	<CAKmqyKOyfP=ZT-diiFFfAieYKt98DPSxf0HyVdwYE4g+jv5w0w@mail.gmail.com>
	<797be79d-7ffc-222a-6acd-b01ff7269a63@mail.ru>
	<20190117101309.GA27840@stefanha-x1.localdomain>
	<960bbd92-a160-a65c-22c7-9e899dc3fa78@mail.ru>
	<CAFEAcA8vWOiXS7iM8heAG5wV1u8Dh_295NbWiqcXCmar9ePuPQ@mail.gmail.com>
	<CAFEAcA8=LMzbjFZh0tc5mRT8O2Kr3xKhk3xPgGZ_b53qp8qUvw@mail.gmail.com>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <d9316f47-a3fb-171c-bc06-c7f699df0400@mail.ru>
Date: Tue, 22 Jan 2019 16:59:22 +0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8=LMzbjFZh0tc5mRT8O2Kr3xKhk3xPgGZ_b53qp8qUvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Fix PC overwriting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Alistair Francis <alistair23@gmail.com>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On 21.01.2019 20:24, Peter Maydell wrote:
> On Thu, 17 Jan 2019 at 19:27, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Thu, 17 Jan 2019 at 10:58, Julia Suvorova <jusual@mail.ru> wrote:
>>>
>>> On 17.01.2019 13:13, Stefan Hajnoczi wrote:
>>>> generic_loader_reset() calls cpu_reset(s->cpu) followed by
>>>> CPUClass->set_pc(s->cpu, s->addr).
>>>>
>>>> ARM's arm_cpu_set_pc() doesn't special-case the Thumb bit (that's only
>>>> done in arm_cpu_reset()) so we end up with an invalid PC for Thumb mode
>>>> addresses.
>>>>
>>>> Maybe the following arm_cpu_reset() code should be moved to
>>>> arm_cpu_set_pc():
>>>>
>>>>     env->regs[15] = initial_pc & ~1;
>>>>     env->thumb = initial_pc & 1;
>>>>
>>>> Then arm_cpu_reset() can call arm_cpu_set_pc() instead of duplicating
>>>> this code.
>>>
>>> No, set_pc() is called in cpu_tb_exec() to restore the PC value and
>>> therefore should not be changed.
>>
>> The set_pc hook is also called for the gdbstub 'c' and 's' packets
>> if they supply an address. I am not sure what the correct behaviour
>> there is (it might be tricky to find out or test, because the
>> 'c' and 's' packets are deprecated in favour of vCont which doesn't
>> allow the address argument at all, and recent gdb neither emits
>> 'c addr' nor supports it in its gdbserver implementation).
> 
> I asked Linaro's gdb developer, and they thought that the gdb
> 'c addr' behaviour ought to be "look at bit 0 and switch to
> Thumb or Arm mode accordingly".

Thanks a lot!

>> I notice that the MIPS set_pc() hook implementation does
>> set the M16 bit based on the low bit of the PC value;
>> they avoid the problem in cpu_tb_exec() by providing
>> the alternative synchronize_from_tb hook instead.
>> 
>> I think that probably what we ought to do is define that:
>>   * set_pc has the logic that does whatever is expected
>>     when the user sets the PC either by hand or when a
>>     ELF file is loaded
>>   * if that is not what is wanted in cpu_tb_exec() then
>>     the target must implement the synchronize_from_tb hook
>>     as well
>> 
>> The trick here is figuring out whether we have a coherent
>> cross-architecture definition of what we want set_pc's
>> behaviour to be (or at least, if we are just baking in
>> "act like an ELF file" we should document that..
I checked all architectures. The trick with synchronize_from_tb() is
made in mips and tricore. Others simply set "env->pc = value", some of
them implement the more complex synchronize_from_tb() for use in
cpu_tb_exec().

I'm going to set "act like an ELF file" meaning to set_pc(), although I
cannot be sure that simply setting pc to a value always means it in
architectures other than these three.

set_pc() is also called as cpu_set_pc() in the boot files, so we can
remove all additional checks from them.

Is the definition update for set_pc() and cpu_set_pc() in
include/qom/cpu.h enough for documentation?

Best regards, Julia Suvorova.
