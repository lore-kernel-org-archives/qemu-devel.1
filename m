Received: from eggs.gnu.org ([2001:4830:134:3::10]:50820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cZFAn-00027A-Dh
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 06:03:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cZFAi-0004bc-G1
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 06:03:29 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:37433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cZFAi-0004ax-6L
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 06:03:24 -0500
Received: by mail-wm0-x230.google.com with SMTP id v77so82349936wmv.0
	for <qemu-devel@nongnu.org>; Thu, 02 Feb 2017 03:03:23 -0800 (PST)
References: <CAFEAcA9j47hSCHyYh5TzNh5P-V3_ddcmA=XMcini+d8PnqruZA@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA9j47hSCHyYh5TzNh5P-V3_ddcmA=XMcini+d8PnqruZA@mail.gmail.com>
Date: Thu, 02 Feb 2017 11:03:24 +0000
Message-ID: <87bmuk4zyb.fsf@linaro.org>
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
Cc: MTTCG Devel <mttcg@listserver.greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, KONRAD =?utf-8?B?RnLDqWTDqXJpYw==?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Fedorov Sergey <serge.fdrv@gmail.com>, Richard Henderson <rth@twiddle.net>, Claudio Fontana <claudio.fontana@huawei.com>, bamvor.zhangjian@linaro.org, "open
	list:ARM" <qemu-arm@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 27 January 2017 at 10:39, Alex Bennée <alex.bennee@linaro.org> wrote:
>> Some helpers may trigger an immediate exit of the cpu_loop. If this
>> happens the PC need to be rectified to ensure the restart will begin
>> on the next instruction.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>  target/arm/cpu.h           | 3 ++-
>>  target/arm/translate-a64.c | 4 ++++
>>  target/arm/translate.c     | 4 ++++
>>  3 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index f56a96c675..1b0670ae11 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -1411,7 +1411,8 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
>>  #define ARM_CP_NZCV            (ARM_CP_SPECIAL | (3 << 8))
>>  #define ARM_CP_CURRENTEL       (ARM_CP_SPECIAL | (4 << 8))
>>  #define ARM_CP_DC_ZVA          (ARM_CP_SPECIAL | (5 << 8))
>> -#define ARM_LAST_SPECIAL       ARM_CP_DC_ZVA
>> +#define ARM_CP_EXIT_PC         (ARM_CP_SPECIAL | (6 << 8))
>> +#define ARM_LAST_SPECIAL       ARM_CP_EXIT_PC
>
> There's a comment above this list of defines that documents
> what all the flags mean; can you add an entry to it for the
> new flag?

Sure - given your comment bellow maybe AP_CP_SYNC_REGS is a better name?

>
>>  /* Used only as a terminator for ARMCPRegInfo lists */
>>  #define ARM_CP_SENTINEL 0xffff
>>  /* Mask of only the flag bits in a type field */
>> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
>> index 05162f335e..a3f37d8bec 100644
>> --- a/target/arm/translate-a64.c
>> +++ b/target/arm/translate-a64.c
>> @@ -1561,6 +1561,10 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
>>          tcg_rt = cpu_reg(s, rt);
>>          gen_helper_dc_zva(cpu_env, tcg_rt);
>>          return;
>> +    case ARM_CP_EXIT_PC:
>> +        /* The helper may exit the cpu_loop so ensure PC is correct */
>> +        gen_a64_set_pc_im(s->pc);
>> +        break;
>
> This will work, but it's a little odd because it breaks the
> existing invariant that cp helpers never throw exceptions
> (except in the access function).

We don't throw an exception but we do exit the CPU loop which has work
waiting for it.

>
> Does single-stepping (of the emulated architectural
> debug step, and gdbstub singlestep) work across one of
> these instructions?

I'll have to test but I don't see why not. The instruction is fully
executed we just ensure we have exited the run loop to process the flush
before we get to the next instruction/

> Should we also set dc->is_jmp to force ending the TB here?

Probably - there is no reason to keep translating as the next
instruction will be in its own block.

> This is probably a question answered in the rest of the series,
> but why do we need the helper to be able to longjump out to the
> top level? Can't we just have the helper do its work and then
> end the TB with tcg_gen_exit_tb(0) so we return to the top level
> loop in the normal way?

Well I guess this is a philosophical question. The cputlb API is
offering the guarantee that when an *_all_cpus_synced() flush is done
everything will be complete with respect to all vCPUS. This is reliant
on the source vCPU executing an exclusive safe work which ensures all
other vCPUs have halted and therefor will have run their safe work
before returning to execution.

If ARM wanted to it could call the *_all_cpus() variant, schedule its
own exclusive safe work (a null function - as cputlb will have scheduled
the flush) and exit the TB in the usual way. In fact this is the
mechanism ARM could use if it wanted to defer the sync point to a later
DMB instruction.

I haven't implemented it yet as the flush stuff only comes up high in
the perf runs with my aggressive TLB flush microbenchmarks.

However I'm wary of having a _synched() variant which will only work
correctly if the guest also does a bunch of other steps.

>
>>      default:
>>          break;
>>      }
>> diff --git a/target/arm/translate.c b/target/arm/translate.c
>> index 444a24c2b6..7bd18cd25d 100644
>> --- a/target/arm/translate.c
>> +++ b/target/arm/translate.c
>> @@ -7508,6 +7508,10 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
>>              gen_set_pc_im(s, s->pc);
>>              s->is_jmp = DISAS_WFI;
>>              return 0;
>> +        case ARM_CP_EXIT_PC:
>> +            /* The helper may exit the cpu_loop so ensure PC is correct */
>> +            gen_set_pc_im(s, s->pc);
>> +            break;
>
> Do we also need to gen_set_condexec() ?

Do we? This isn't an exception so we don't need to resolve the condition
flags as long as there is enough information preserved so the next TB
can resolve if it needs to.

I'm afraid my knowledge of the condition code is "it is deferred until
it is needed as it is an expensive calculation". I'll dig into the
implementation.

>
>>          default:
>>              break;
>>          }
>> --
>> 2.11.0
>
> thanks
> -- PMM


--
Alex Bennée
