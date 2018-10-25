Received: from eggs.gnu.org ([2001:4830:134:3::10]:37285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gFj4a-0000YT-Fy
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:05:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gFj4S-0005jF-Ef
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:05:26 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gFj4N-0005fP-B7
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:05:15 -0400
Received: by mail-pf1-x444.google.com with SMTP id t10-v6so3066197pfh.12
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 10:05:10 -0700 (PDT)
Date: Thu, 25 Oct 2018 10:05:08 -0700 (PDT)
In-Reply-To: <CAFEAcA-b6xf5y2KFSPDB27__e8jRTm2gjbpGjLERCGtmxUyGFw@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-8519e2b7-b773-4760-a7f1-3f6e2ad3a03e@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 01/29] target/riscv: Move CPURISCVState
 pointer to DisasContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: kbastian@mail.uni-paderborn.de, sagark@eecs.berkeley.edu, richard.henderson@linaro.org, qemu-devel@nongnu.org, peer.adelt@hni.uni-paderborn.de, Alistair Francis <Alistair.Francis@wdc.com>, Michael Clark <mjc@sifive.com>

On Thu, 25 Oct 2018 09:54:56 PDT (-0700), Peter Maydell wrote:
> On 25 October 2018 at 17:38, Palmer Dabbelt <palmer@sifive.com> wrote:
>> On Sat, 20 Oct 2018 00:14:23 PDT (-0700), kbastian@mail.uni-paderborn.de
>> wrote:
>>>
>>> CPURISCVState is rarely used, so there is no need to pass it to every
>>> translate function. This paves the way for decodetree which only passes
>>> DisasContext to translate functions.
>
>>> --- a/target/riscv/translate.c
>>> +++ b/target/riscv/translate.c
>>> @@ -52,6 +52,7 @@ typedef struct DisasContext {
>>>         to any system register, which includes CSR_FRM, so we do not have
>>>         to reset this known value.  */
>>>      int frm;
>>> +    CPURISCVState *env;
>>>  } DisasContext;
>
>
>> I think this is OK, but I'm not sure.  All the other ports do this in a
>> different way: rather than including the CPU state structure in DisasContext
>> they explicitly call out the state that can change instruction decoding by
>> duplicating it within DisasContext.
>
> Yes. The reason for doing this is that it makes it easier to avoid
> a particular class of bug. Any target CPU state that we "bake into"
> the generated TCG code needs to be one of:
>  * constant for the life of the CPU (eg ID register values, or
>    feature bits)
>  * encoded into the TB flags (which are filled in by
>    the target's cpu_get_tb_cpu_state())
> If you generate code that depends on some other target CPU state
> by accident, then this will cause hard to track down bugs when
> we reuse the generated TB in an executed context where that
> target CPU state has changed from what it was when the TB was
> generated.
>
> By not allowing the code generation parts of translate.c to get
> hold of the CPUState pointer, we can make this kind of bug much
> easier to spot at compile time, because any new state that we
> want to use in codegen has to be copied into the DisasContext.
> It's then fairly easy to check that we only copy into the
> DisasContext state that is constant-for-the-CPU or which we've
> got from the TB flags.
>
> That said, at the moment the riscv frontend code does not
> use this pattern -- it passes the CPURISCVState pointer
> directly into (some of) the leaf functions, like gen_jal().
> So putting the CPURISCVState into DisasContext is no worse
> than passing it around all these translate.c functions as
> a function parameter.
>
> I would prefer it if the riscv code was cleaned up to
> do the explicit passing of only the required bits of state
> in DisasContext (as for instance target/arm/ does). But I
> don't have a strong opinion on the ordering of doing that
> versus doing this conversion to decodetree.

OK, that makes sense.  Since our port is already broken WRT this behavior and 
the decode tree stuff will be nice to have, I'm happy taking this change now 
and fixing this later -- that way we won't have to couple two major changes 
into a single patch set.

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Thanks!
