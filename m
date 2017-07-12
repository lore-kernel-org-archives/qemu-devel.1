Received: from eggs.gnu.org ([2001:4830:134:3::10]:34354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVFKe-0008R3-MJ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:57:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVFKb-0004BR-J5
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:57:24 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
	<149942834870.8972.2146924083027836035.stgit@frigg.lan>
	<87bmoq9g13.fsf@linaro.org>
Date: Wed, 12 Jul 2017 13:56:57 +0300
In-Reply-To: <87bmoq9g13.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
	message of "Wed, 12 Jul 2017 10:10:48 +0100")
Message-ID: <87wp7dexdy.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v12 03/27] target: [tcg] Use a generic enum
 for DISAS_ values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Chris Wulff <crwulff@gmail.com>, qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>, Michael Walle <michael@walle.cc>, "Emilio G. Cota" <cota@braap.org>, "open list:ARM" <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Richard Henderson <rth@twiddle.net>

Alex Benn=C3=A9e writes:

> Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> writes:

>> Used later. An enum makes expected values explicit and bounds the value =
space of
>> switches.
>>=20
>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> Reviewed-by: Emilio G. Cota <cota@braap.org>
>> Reviewed-by: Richard Henderson <rth@twiddle.net>
>> ---
>> include/exec/exec-all.h       |    6 ------
>> include/exec/translator.h     |   39 +++++++++++++++++++++++++++++++++++=
++++
>> target/arm/translate.h        |   26 ++++++++++++++++----------
>> target/cris/translate.c       |    7 ++++++-
>> target/i386/translate.c       |    4 ++++
>> target/lm32/translate.c       |    6 ++++++
>> target/m68k/translate.c       |    7 ++++++-
>> target/microblaze/translate.c |    6 ++++++
>> target/nios2/translate.c      |    6 ++++++
>> target/openrisc/translate.c   |    6 ++++++
>> target/s390x/translate.c      |    3 ++-
>> target/unicore32/translate.c  |    7 ++++++-
>> target/xtensa/translate.c     |    4 ++++
>> 13 files changed, 107 insertions(+), 20 deletions(-)
>> create mode 100644 include/exec/translator.h
>>=20
>> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
>> index 0826894ec5..27498cf740 100644
>> --- a/include/exec/exec-all.h
>> +++ b/include/exec/exec-all.h
>> @@ -35,12 +35,6 @@ typedef abi_ulong tb_page_addr_t;
>> typedef ram_addr_t tb_page_addr_t;
>> #endif
>>=20
>> -/* is_jmp field values */
>> -#define DISAS_NEXT    0 /* next instruction can be analyzed */
>> -#define DISAS_JUMP    1 /* only pc was modified dynamically */
>> -#define DISAS_UPDATE  2 /* cpu state was modified dynamically */
>> -#define DISAS_TB_JUMP 3 /* only pc was modified statically */
>> -
>> #include "qemu/log.h"
>>=20
>> void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb);
>> diff --git a/include/exec/translator.h b/include/exec/translator.h
>> new file mode 100644
>> index 0000000000..1f9697dd31
>> --- /dev/null
>> +++ b/include/exec/translator.h
>> @@ -0,0 +1,39 @@
>> +/*
>> + * Generic intermediate code generation.
>> + *
>> + * Copyright (C) 2016-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or l=
ater.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#ifndef EXEC__TRANSLATOR_H
>> +#define EXEC__TRANSLATOR_H
>> +
>> +/**
>> + * DisasJumpType:
>> + * @DISAS_NEXT: Next instruction in program order.
>> + * @DISAS_TOO_MANY: Too many instructions translated.
>> + * @DISAS_TARGET: Start of target-specific conditions.
>> + *
>> + * What instruction to disassemble next.
>> + */
>> +typedef enum DisasJumpType {
>> +    DISAS_NEXT,
>> +    DISAS_TOO_MANY,

> Is DISAS_TOO_MANY really a useful distinction. Sure we have ended the
> loop because of an instruction limit but the more important information
> is what it means for the epilogue code and how we go to the next block.

You mean this is just the sae as DISAS_NEXT? Could be, I don't know about a=
ll
the other targets.

> The recent work on fixing eret on ARM[1] has had me thinking about the
> semantics of exit conditions and how much commonality we have across the
> translators. I don't think we'll ever have a comprehensive DisasJumpType
> that all translators will only use the common exits but I think we could
> stand to have a few more.

> I think the cases we want to cover are:

>   DISAS_JUMP - the block ends with a jump to the next block (either
>                computed via PC or hard-coded with patched branch to next =
TB)

>   DISAS_NORETURN - the block exits via a helper or some other mechanism
>                   (for example cpu_loop_exit from helper)

>   DISAS_EXIT_LOOP - we need to return to the main loop before we enter
>                     again (typically to deal with IRQ issues)


> [1] https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg02963.html

Right now (v13 that I will send after this round of reviews) it only has
DISAS_TOO_MANY and DISAS_NORETURN because these are the only ones used in t=
he
generic code.

I'm not that familiar with the internals of the disassembly process of all =
the
many targets in QEMU, and so I prefer to stick to the bare minimum we clear=
ly
need now, and only later refactor target-specific DISAS_* values into gener=
ic
ones.

If you provide me a rename mapping from i386 and arm to the values you're
proposing, I can send it for v13, but would otherwise prefer to stick to the
current state of affairs.


>> +    DISAS_TARGET_0,
>> +    DISAS_TARGET_1,
>> +    DISAS_TARGET_2,
>> +    DISAS_TARGET_3,
>> +    DISAS_TARGET_4,
>> +    DISAS_TARGET_5,
>> +    DISAS_TARGET_6,
>> +    DISAS_TARGET_7,
>> +    DISAS_TARGET_8,
>> +    DISAS_TARGET_9,
>> +    DISAS_TARGET_10,
>> +    DISAS_TARGET_11,
>> +    DISAS_TARGET_12,
>> +} DisasJumpType;
>> +
>> +#endif  /* EXEC__TRANSLATOR_H */
>> diff --git a/target/arm/translate.h b/target/arm/translate.h
>> index e5da614db5..aba3f44c9f 100644
>> --- a/target/arm/translate.h
>> +++ b/target/arm/translate.h
>> @@ -1,6 +1,9 @@
>> #ifndef TARGET_ARM_TRANSLATE_H
>> #define TARGET_ARM_TRANSLATE_H
>>=20
>> +#include "exec/translator.h"
>> +
>> +
>> /* internal defines */
>> typedef struct DisasContext {
>> target_ulong pc;
>> @@ -119,30 +122,33 @@ static void disas_set_insn_syndrome(DisasContext *=
s, uint32_t syn)
s-> insn_start_idx =3D 0;
>> }
>>=20
>> -/* target-specific extra values for is_jmp */
>> +/* is_jmp field values */
>> +#define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamicall=
y */
>> +#define DISAS_UPDATE  DISAS_TARGET_1 /* cpu state was modified dynamica=
lly */
>> +#define DISAS_TB_JUMP DISAS_TARGET_2 /* only pc was modified statically=
 */
>> /* These instructions trap after executing, so the A32/T32 decoder must
>> * defer them until after the conditional execution state has been update=
d.
>> * WFI also needs special handling when single-stepping.
>> */
>> -#define DISAS_WFI 4
>> -#define DISAS_SWI 5

> So in the new model for example we only really need the special handling
> for things like WFI/SWI onwards.

And how do the previous ones map to the generic ones? And what about the i3=
86
target?


Thanks,
  Lluis
