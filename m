Received: from eggs.gnu.org ([2001:4830:134:3::10]:35763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cZGKo-0005Nk-1g
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 07:17:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cZGKj-00042t-UU
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 07:17:53 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:36207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cZGKj-00041t-JU
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 07:17:49 -0500
Received: by mail-wm0-x231.google.com with SMTP id c85so87637789wmi.1
	for <qemu-devel@nongnu.org>; Thu, 02 Feb 2017 04:17:49 -0800 (PST)
References: <CAFEAcA9j47hSCHyYh5TzNh5P-V3_ddcmA=XMcini+d8PnqruZA@mail.gmail.com>
	<87bmuk4zyb.fsf@linaro.org>
	<CAFEAcA_vxpT+rErpPBmyst+g71KassD-N2755yyY8TvW6S2Y=g@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_vxpT+rErpPBmyst+g71KassD-N2755yyY8TvW6S2Y=g@mail.gmail.com>
Date: Thu, 02 Feb 2017 12:17:50 +0000
Message-ID: <87a8a44wi9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 23/25] target-arm: introduce
 ARM_CP_EXIT_PC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: MTTCG Devel <mttcg@listserver.greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, KONRAD =?utf-8?B?RnLDqWTDqXJpYw==?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Fedorov Sergey <serge.fdrv@gmail.com>, Richard Henderson <rth@twiddle.net>, Claudio Fontana <claudio.fontana@huawei.com>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 2 February 2017 at 11:03, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>> Does single-stepping (of the emulated architectural
>>> debug step, and gdbstub singlestep) work across one of
>>> these instructions?
>>
>> I'll have to test but I don't see why not. The instruction is fully
>> executed we just ensure we have exited the run loop to process the flush
>> before we get to the next instruction/
>
> The reason I ask is that the single-stepping code path involves
> doing some work at the tail end of the translate:
>
>     if (unlikely(cs->singlestep_enabled || dc->ss_active)
>         && dc->is_jmp != DISAS_EXC) {
>         /* do some stuff */
>     }
>
> The other things that jump out of the normal code flow are:
>  * exceptions (where we don't want to do finished-the-step
>    work anyway as the insn hasn't executed)
>  * SWI (hopefully we single step SWI right but maybe not)
>  * YIELD, WFE (which are special cased so that they do the
>    actual work only at the end of the gen_intermediate_code
>    function and only if not single-stepping, so they're
>    no-ops on singlestep)
>
> You've introduced a new item to this list which isn't
> handled by the singlestep code.
>
>>> This is probably a question answered in the rest of the series,
>>> but why do we need the helper to be able to longjump out to the
>>> top level? Can't we just have the helper do its work and then
>>> end the TB with tcg_gen_exit_tb(0) so we return to the top level
>>> loop in the normal way?
>>
>> Well I guess this is a philosophical question. The cputlb API is
>> offering the guarantee that when an *_all_cpus_synced() flush is done
>> everything will be complete with respect to all vCPUS. This is reliant
>> on the source vCPU executing an exclusive safe work which ensures all
>> other vCPUs have halted and therefor will have run their safe work
>> before returning to execution.
>>
>> If ARM wanted to it could call the *_all_cpus() variant, schedule its
>> own exclusive safe work (a null function - as cputlb will have scheduled
>> the flush) and exit the TB in the usual way. In fact this is the
>> mechanism ARM could use if it wanted to defer the sync point to a later
>> DMB instruction.
>>
>> I haven't implemented it yet as the flush stuff only comes up high in
>> the perf runs with my aggressive TLB flush microbenchmarks.
>>
>> However I'm wary of having a _synched() variant which will only work
>> correctly if the guest also does a bunch of other steps.
>
> Well, with the implementation as it is you need to do a bunch
> of extra steps to handle all the corner cases (condexec,
> single stepping) that would be handled for you if you exited
> the TB in the normal way rather than longjumping out of it...
> IME longjumping out should be reserved for "we don't want to
> continue executing whatever other generated code we have after
> this" situations. Here we know definitely what we're going to
> want to do, so it would be better to generate code that
> arranged to leave the TB in the usual way.

OK I can certainly see the logic in exiting the "clean" way. I guess it
really depends on how the other guests are going to handle the case. It
would be nice if there was some mechanism by which the cputlb code could
be sure whatever has just called a synched function really is going to
exit the loop.

Paolo, Richard,

Any ideas? Do the other guests have similar mechanisms?

This would mean removing the QEMU_NORETURN from the *_synched functions
(but keeping their scheduling of the safe work) and documenting the
guest translations should be exiting their TBs after this instruction.

>
>>>>      default:
>>>>          break;
>>>>      }
>>>> diff --git a/target/arm/translate.c b/target/arm/translate.c
>>>> index 444a24c2b6..7bd18cd25d 100644
>>>> --- a/target/arm/translate.c
>>>> +++ b/target/arm/translate.c
>>>> @@ -7508,6 +7508,10 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
>>>>              gen_set_pc_im(s, s->pc);
>>>>              s->is_jmp = DISAS_WFI;
>>>>              return 0;
>>>> +        case ARM_CP_EXIT_PC:
>>>> +            /* The helper may exit the cpu_loop so ensure PC is correct */
>>>> +            gen_set_pc_im(s, s->pc);
>>>> +            break;
>>>
>>> Do we also need to gen_set_condexec() ?
>>
>> Do we? This isn't an exception so we don't need to resolve the condition
>> flags as long as there is enough information preserved so the next TB
>> can resolve if it needs to.
>
> Your longjump is effectively skipping the normal "end of the TB" code,
> which is what usually does the set_condexec for you. At the end of a
> TB the expectation is that everything's been sync'd back to the CPU
> state structure.

Hmm so as long as the tlb flush helpers don't set ARM_CP_SUPPRESS_TB_END
things should just work normally? Is shouldn't matter if the TB with the
flush is chained to a new TB as the exit_request test should fire before
any more state changing operations happen?

--
Alex Bennée
