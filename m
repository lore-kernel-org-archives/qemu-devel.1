Received: from eggs.gnu.org ([2001:4830:134:3::10]:60667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gFiul-0003mm-TX
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 12:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gFiul-0003fn-0b
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 12:55:19 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gFiuk-0003fA-I5
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 12:55:18 -0400
Received: by mail-oi1-x244.google.com with SMTP id p125-v6so7289170oic.3
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 09:55:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <mhng-4055ca5c-cc16-4614-9e8f-d1692651282f@palmer-si-x1c4>
References: <20181020071451.27808-2-kbastian@mail.uni-paderborn.de>
	<mhng-4055ca5c-cc16-4614-9e8f-d1692651282f@palmer-si-x1c4>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Oct 2018 17:54:56 +0100
Message-ID: <CAFEAcA-b6xf5y2KFSPDB27__e8jRTm2gjbpGjLERCGtmxUyGFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, peer.adelt@hni.uni-paderborn.de, Alistair Francis <Alistair.Francis@wdc.com>, Michael Clark <mjc@sifive.com>

On 25 October 2018 at 17:38, Palmer Dabbelt <palmer@sifive.com> wrote:
> On Sat, 20 Oct 2018 00:14:23 PDT (-0700), kbastian@mail.uni-paderborn.de
> wrote:
>>
>> CPURISCVState is rarely used, so there is no need to pass it to every
>> translate function. This paves the way for decodetree which only passes
>> DisasContext to translate functions.

>> --- a/target/riscv/translate.c
>> +++ b/target/riscv/translate.c
>> @@ -52,6 +52,7 @@ typedef struct DisasContext {
>>         to any system register, which includes CSR_FRM, so we do not have
>>         to reset this known value.  */
>>      int frm;
>> +    CPURISCVState *env;
>>  } DisasContext;


> I think this is OK, but I'm not sure.  All the other ports do this in a
> different way: rather than including the CPU state structure in DisasContext
> they explicitly call out the state that can change instruction decoding by
> duplicating it within DisasContext.

Yes. The reason for doing this is that it makes it easier to avoid
a particular class of bug. Any target CPU state that we "bake into"
the generated TCG code needs to be one of:
 * constant for the life of the CPU (eg ID register values, or
   feature bits)
 * encoded into the TB flags (which are filled in by
   the target's cpu_get_tb_cpu_state())
If you generate code that depends on some other target CPU state
by accident, then this will cause hard to track down bugs when
we reuse the generated TB in an executed context where that
target CPU state has changed from what it was when the TB was
generated.

By not allowing the code generation parts of translate.c to get
hold of the CPUState pointer, we can make this kind of bug much
easier to spot at compile time, because any new state that we
want to use in codegen has to be copied into the DisasContext.
It's then fairly easy to check that we only copy into the
DisasContext state that is constant-for-the-CPU or which we've
got from the TB flags.

That said, at the moment the riscv frontend code does not
use this pattern -- it passes the CPURISCVState pointer
directly into (some of) the leaf functions, like gen_jal().
So putting the CPURISCVState into DisasContext is no worse
than passing it around all these translate.c functions as
a function parameter.

I would prefer it if the riscv code was cleaned up to
do the explicit passing of only the required bits of state
in DisasContext (as for instance target/arm/ does). But I
don't have a strong opinion on the ordering of doing that
versus doing this conversion to decodetree.

thanks
-- PMM
