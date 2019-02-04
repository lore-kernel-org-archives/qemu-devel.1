Received: from eggs.gnu.org ([209.51.188.92]:47491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gqUtS-0007Iu-Eg
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 22:25:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gqUtQ-0001i3-RX
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 22:25:58 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gqUtQ-0001Zf-86
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 22:25:56 -0500
Received: by mail-pg1-x544.google.com with SMTP id g189so5668161pgc.5
	for <qemu-devel@nongnu.org>; Sun, 03 Feb 2019 19:25:55 -0800 (PST)
References: <20190122170112.8706-1-farosas@linux.ibm.com>
	<20190122170112.8706-3-farosas@linux.ibm.com>
	<30929550-4e18-6c43-1d8f-d4065ec70544@ozlabs.ru>
	<20190126015006.GB22942@umbus> <878sz41rjx.fsf@linux.ibm.com>
	<d06f8763-f994-5913-424a-542f33d6b09a@ozlabs.ru>
	<874l9q152u.fsf@linux.ibm.com>
	<c2c652ad-69af-5288-4861-aaf0e67e9b5b@ozlabs.ru>
	<871s4s1odz.fsf@linux.ibm.com>
	<e5f9b8d3-1969-d75b-c4e2-e34efa932d3b@ozlabs.ru>
	<87y36zzpi2.fsf@linux.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <15fd9fd1-8713-ce99-47d5-568f8258d60b@ozlabs.ru>
Date: Mon, 4 Feb 2019 14:25:49 +1100
MIME-Version: 1.0
In-Reply-To: <87y36zzpi2.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v4 2/3] target/ppc: Add GDB
 callbacks for SPRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, groug@kaod.org, qemu-devel@nongnu.org



On 01/02/2019 23:01, Fabiano Rosas wrote:
> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> 
>> On 01/02/2019 08:57, Fabiano Rosas wrote:
>>> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
>>>
>>>> On 31/01/2019 03:30, Fabiano Rosas wrote:
>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
>>>>>
>>>>>>
>>>>>> but this is a register which does not have endianness, the endianness
>>>>>> appears here because the interface between gdb and qemu is
>>>>>> uint8_t*==bytestream but this interface should have fixed endianness
>>>>>> imho (now it is bigendian afaict).
>>>>>>
>>>>>> Something is not right here...
>>>>>
>>>>> Having a fixed endianness would not work because GDB have no way of
>>>>> knowing how to represent what comes from the remote end.
>>>>
>>>> It definitely would. A register is stored as "unsigned long" in QEMU and
>>>> all gdb has to do is printf("%lx") and that is it. 
>>>
>>> OK, but something is not clear to me. Even if GDB just printf("%lx") the
>>> value, we would still have to bswap when the host is LE, right?
>>
>> Not for %lx, this should just print a correct value.
>>
>>> QEMU BE:
>>>  (gdb) x/8xb &env->spr[287]
>>>  0x11391760: 0x00    0x00    0x00    0x00    0x00    0x4e    0x12    0x00
>>>
>>> QEMU LE:
>>>  (gdb) x/8xb &env->spr[287]
>>>  0x7ffff5bd98c0: 0x01    0x02    0x4b    0x00    0x00    0x00    0x00    0x00
>>>
>>>> The problem is that
>>>> we want to pass it as a byte stream from the gdb_read_register() hook
>>>> all the way to gdb and for some reason gdb does not define endianness of
>>>> that stream but rather tries guessing the endianness which is broken.
>>>
>>> GDB does define the endianness of the stream (in a way):
>>>
>>>  "Each byte of register data is described by two hex digits. The bytes
>>>  with the register are transmitted in target byte order."
>>>
>>> https://sourceware.org/gdb/current/onlinedocs/gdb/Packets.html#Packets
>>
>>
>> Target byte order changes all the time so we need a endian-agnostic way
>> of knowing the current endianness.
>>
>>
>>>
>>>> Today I was debugging rtas/clientinterface calls which a little endian
>>>> kernel makes and these calls need to switch to the big endian first. And
>>>> gdb goes nuts when this switch happens (note that I did not give an ELF
>>>> to gdb this time so it picked LE itself). Even if it could fetch the
>>>> endianness from QEMU, it would fail as it is an LE bit in MSR which is a
>>>> register which is parsed according to the gdb's idea of endianness :)
>>>
>>> I think it would be possible to define another packet for the remote
>>> protocol that informs the endianness explicitly at each time the guest
>>> stops. If you provide more info on how to reproduce that issue I could
>>> put in my list or go bug GDB folks about it.
>>>
>>>>> It will
>>>>> always check the target endianness before printing a value, even if it
>>>>> refers to a register:
>>>>>
>>>>> https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=blob;f=gdb/findvar.c;hb=HEAD#l49
>>>>>
>>>>> So in our case the contents of mem_buf need to match both the guest
>>>>> endianness *and* what GDB has set for 'show endian' because it will
>>>>> detect it automatically from the ELF. If it guesses incorrectly because
>>>>> there is no ELF, we need to use the 'set endian' command.
>>>>>
>>>>> By the way, this is already the behavior for the registers that are
>>>>> already implemented (e.g. $msr). Here's the commit that introduced
>>>>> that:
>>>>>
>>>>> https://git.qemu.org/?p=qemu.git;a=commitdiff;h=8a286ce4502356ce0b97a2424a2cb7
>>>>>
>>>>> Now, what might be a source of confusion here is the fact that we
>>>>> *always* do a bswap when the host is LE because QEMU thinks that the ppc
>>>>> guest is always BE. That requires the maybe_bswap function to make
>>>>> things right in the end.
>>>>>
>>>>> What I could do is try to improve this by only swapping when the
>>>>> guest's actual endianness (msr_le) is different from the host's.
>>>>
>>>> The bytestream for registers should have fixed endianness. But looking
>>>> at the gdb code makes me think it is not going to happen :(
>>>
>>> Yes, I can't think of a way to fix that without changing the way GDB
>>> exhibits the values or the remote protocol.
>>>
>>> May I proceed with this series as it is with the bswaps?
>>>
>>>>> That
>>>>> is not entirely within the scope of this patch, though.
>>>>
>>>> True. But since you are touching this, may be you could fix gdb too :)
>>>>
>>>> Does gdb tell QEMU about what endianness it thinks that QEMU is using?
>>>> Or can it read it from QEMU? I cannot easily spot this in QEMU...
>>>
>>> GDB currently does not tell and does not ask about endianness. So I
>>> believe there is room for improvement here. I could not find it in the
>>> documentation but I think that GDB supports file transfers and it asks
>>> for the ELF in some scenarios. This approach could be one way of
>>> informing it about the endianness, although it has its own shortcomings.
>>
>>
>> There is no ELF in my scenario really. What I did was:
>>
>> 1. hack qemu to not load slof.bin but load vmlinux instead and changed
>> starting pc to where I loaded the kernel (I did not have to but it is a
>> lot easier to ditch slof and set breakpoint in gdb before starting the
>> guest).
> 
> Not sure if it improves your situation but the hack I do in this case is
> to add a:
> 
> +    if (runstate_check(6))
> +           addr += 0x400000;


I assume this 0x400000 is from FW_MAX_SIZE, right?

In my example the vmlinux is loaded at zero and changing 0x400000 is
just setting a random breakpoint.


> 
> in kvm_arch_{insert,remove}_sw_breakpoint.
> 
> Fyi, this is other thing I have been trying to fix. I am currently
> trying to figure out a way of going out to QEMU right before the kernel
> starts so we could then apply the breakpoints correctly.

For the starter (to proceed with these patches) you can just make sure
that setting breakpoints still works even if the guest has not started yet.


> But this gets
> more complicated when the kernel is loaded from disk.

True...


>> 2. start a guest, connect external gdb and observe garbage in $pc and
>> disassembly until the guest switched to LE.
>>
>> 3. trace till here:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/kernel/entry_64.S?h=v4.20#n1299
>> and set breakpoint to whatever $r4 was at this point; $r4 points to RTAS
>> which executes in BE as we remove LE bit from SRR1 (lines 1296..1298).
>>
>> When we stop at this new breakpoint - we get same biteswapped garbage as
>> in step2. Well, this is SLOF and there is an ELF somewhere but do we
>> really want to load ELF and switch endianness every time the guest
>> changes it and jumps to different chunks of code? :)
> 
> You're right, we need something more versatile than that.
> 
> Perhaps for the general scenario of debugging same endianness code it
> could work well. I think that might be a good thing anyway because it
> would provide the symbols and so on. But I get your point.
> 
> For the case where the code switches back and forth, a new, fixed
> endianness packet that tells GDB what is the current target endianness
> should work just fine I believe. Analogous to calling `set endian
> little|big` on gdb cmd line.
> 
> I'll reproduce the issue as you mentioned and will try to come up with
> something along these lines.
> 
>> It also seems like we cannot really debug slof via the gdb stub as it is
>> big endian so it will be executing instructions but the UI will look
>> byteswapped.
> 
> As a temporary workaround I believe you could use `set endian`.
> 
> 
> Thanks for the discussion so far. It's been really helpful.



-- 
Alexey
