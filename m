Received: from eggs.gnu.org ([2001:4830:134:3::10]:55681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gHUFE-0007k8-AT
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gHUF7-0001rH-Ak
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:39:44 -0400
References: <20181029134000.11157-1-mark.cave-ayland@ilande.co.uk>
	<97900b04-28f0-975f-b3c0-2c0aa7039a4f@linaro.org>
	<5c41b46c-70e3-33a0-76cf-ba2fd8155d33@ilande.co.uk>
	<393eca98-a092-80aa-2016-f14cd2e02d45@vivier.eu>
	<3b1f8942-d8c7-04db-45bc-a7c30de9d769@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ad444bbf-0606-2b80-7f7d-389a6df29cfe@vivier.eu>
Date: Tue, 30 Oct 2018 14:39:14 +0100
MIME-Version: 1.0
In-Reply-To: <3b1f8942-d8c7-04db-45bc-a7c30de9d769@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 00/11] hw/m68k: add Apple Machintosh
 Quadra 800 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, hpoussin@reactos.org, kraxel@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net, Thomas Huth <huth@tuxfamily.org>

Le 30/10/2018 à 14:12, Mark Cave-Ayland a écrit :
> On 30/10/2018 12:49, Laurent Vivier wrote:
> 
>> Le 30/10/2018 à 12:48, Mark Cave-Ayland a écrit :
>>> On 30/10/2018 08:15, Richard Henderson wrote:
>>>
>>>> On 10/29/18 1:39 PM, Mark Cave-Ayland wrote:
>>>>> You can install your own disk using debian-installer, with:
>>>>>
>>>>>     ...
>>>>>     -M q800 \
>>>>>     -serial none -serial mon:stdio \
>>>>>     -m 1000M -drive file=m68k.qcow2,format=qcow2 \
>>>>>     -net nic,model=dp83932,addr=09:00:07:12:34:57 \
>>>>>     -append "console=ttyS0 vga=off" \
>>>>>     -kernel vmlinux-4.15.0-2-m68k \
>>>>>     -initrd initrd.gz \
>>>>>     -drive file=debian-9.0-m68k-NETINST-1.iso \
>>>>>     -drive file=m68k.qcow2,format=qcow2 \
>>>>>     -nographic
>>>>
>>>> I tried this and got
>>>>
>>>> Trace 0: 0x7f2e886c7140 [00000000/0000d404/0xe000]
>>>> INT      1: Unassigned(0xf4) pc=0000d404 sp=00393e60 sr=2700
>>>> INT      2: Access Fault(0x8) pc=00000000 sp=00393e58 sr=2700
>>>>             ssw:  00000506 ea:   00000000 sfc:  5    dfc: 5
>>>>
>>>> which lead straight to buserr and panic.  This happens way early in boot --
>>>> only 1926 TranslationBlocks generated.
>>>>
>>>> Is there some device missing from the command-line that the kernel is expecting?
>>>
>>> Heh that's annoying. The original branch I forked that Laurent was working on had
>>> some extra patches at the start of the series: some were required for q800 whilst
>>> others were for new development. I thought that all of the patches required for q800
>>> had been applied over the past few months, but sadly that isn't the case :(
>>>
>>> I've pushed an updated branch to https://github.com/mcayland/qemu/tree/q800-test
>>> which contains the patchset plus two extra patches that are still needed to boot to
>>> the debian installer here:
>>>
>>> 9281a5371f "tmp"
>>> 629754d847 "target/m68k: manage FPU exceptions"
>>>
>>> Laurent, are these patches ready for upstream or do they need work in which case we
>>> should leave q800 until the 3.2 cycle?
>>
>> The only needed part is from 9281a5371f.
> 
> Yeah I think you're right, sorry about that. I'm sure I tried without 629754d847 and
> I got a premature exit from QEMU but only in graphic mode, but I've just tried again
> and can't seem to recreate it now.
> 
>> --- a/target/m68k/translate.c
>> +++ b/target/m68k/translate.c
>> @@ -1552,7 +1552,7 @@ DISAS_INSN(undef)
>>         but actually illegal for CPU32 or pre-68020.  */
>>      qemu_log_mask(LOG_UNIMP, "Illegal instruction: %04x @ %08x\n",
>>                    insn, s->base.pc_next);
>> -    gen_exception(s, s->base.pc_next, EXCP_UNSUPPORTED);
>> +    gen_exception(s, s->base.pc_next, EXCP_ILLEGAL);
>>  }
>>
>>  DISAS_INSN(mulw)
>> @@ -2799,7 +2799,7 @@ DISAS_INSN(mull)
>>
>>      if (ext & 0x400) {
>>          if (!m68k_feature(s->env, M68K_FEATURE_QUAD_MULDIV)) {
>> -            gen_exception(s, s->base.pc_next, EXCP_UNSUPPORTED);
>> +            gen_exception(s, s->base.pc_next, EXCP_ILLEGAL);
>>              return;
>>          }
>>
>> @@ -4509,7 +4509,7 @@ DISAS_INSN(strldsr)
>>      addr = s->pc - 2;
>>      ext = read_im16(env, s);
>>      if (ext != 0x46FC) {
>> -        gen_exception(s, addr, EXCP_UNSUPPORTED);
>> +        gen_exception(s, addr, EXCP_ILLEGAL);
>>          return;
>>      }
>>      ext = read_im16(env, s);
>>
>> Because kernel only manages illegal instruction exception not unsupported.
>>
>> Without the patch, we have:
>>
>> IN:
>> 0x0000d454:  071400
>>
>> INT      1: Unassigned(0xf4) pc=0000d454 sp=00331e60 sr=2700
>>
>> with the patch:
>>
>> IN:
>> 0x0000d454:  071400
>>
>> INT      1: Illegal Instruction(0x10) pc=0000d454 sp=00331e60 sr=2700
>>
>> We have in linux/arch/m68k/kernel/vectors.c:
>>
>> /*
>>  * this must be called very early as the kernel might
>>  * use some instruction that are emulated on the 060
>>  * and so we're prepared for early probe attempts (e.g. nf_init).
>>  */
>> void __init base_trap_init(void)
>> {
>> ...
>>
>>         vectors[VEC_BUSERR] = buserr;
>>         vectors[VEC_ILLEGAL] = trap;
>>         vectors[VEC_SYS] = system_call;
>> }
>>
>> So I think the unsupported vector jumps to an invalid address.
>>
>> This seems triggered by the aranym native feature:
>>
>>     d454:       7300            mvsb %d0,%d1
>>
>> from linux/arch/m68k/emu/natfeat.c
> 
> Interesting. So is this an actual bug in QEMU in terms of implementing the processor
> specification, or is it relying on undefined behaviour on real hardware?

It's a bug in QEMU.

EXCP_UNSUPPORTED is defined to a QEMU specific value (61) that is in the
Unassigned/Reserved range of the vector table.

It is used by QEMU user-mode to trigger illegal instruction, whereas
illegal is also used to do simcalls (some thing like a syscall with an
illegal instruction trap). I think this should be deprecated as no one
is maintaining that and knows how to use that.

Perhaps Thomas as an idea as it comes with the coldfire implementation?
(e6e5906b6e ColdFire target)

Thanks,
Laurent
