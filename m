Received: from eggs.gnu.org ([2001:4830:134:3::10]:52462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTX7Z-0000qu-UW
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTX7V-0004j4-Va
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:32:49 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865801156.17063.15618379976159104550.stgit@frigg.lan>
	<244b5aab-8863-3139-f252-09cc02333eda@twiddle.net>
	<87inj4ebqn.fsf@frigg.lan>
	<c35a41d9-4c9d-3daf-2759-17a784b8711b@twiddle.net>
Date: Fri, 07 Jul 2017 19:32:29 +0200
In-Reply-To: <c35a41d9-4c9d-3daf-2759-17a784b8711b@twiddle.net> (Richard
	Henderson's message of "Fri, 7 Jul 2017 05:46:19 -1000")
Message-ID: <87a84gcfv6.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 24/29] target/arm: [tcg,
 a64] Port to translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

Richard Henderson writes:

> On 07/07/2017 01:18 AM, Llu=C3=ADs Vilanova wrote:
>>>> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
>>>> index 9c870f6d07..586a01a2de 100644
>>>> --- a/target/arm/translate-a64.c
>>>> +++ b/target/arm/translate-a64.c
>>>> @@ -11244,6 +11244,9 @@ static void aarch64_trblock_init_disas_context=
(DisasContextBase *dcbase,
dc-> is_ldex =3D false;
dc-> ss_same_el =3D (arm_debug_target_el(env) =3D=3D dc->current_el);
>>>> +    dc->next_page_start =3D
>>>> +        (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
>>=20
>>> I think a better solution for a fixed-length ISA is to adjust max_insns=
. Perhaps
>>> the init_disas_context hook should be able to modify it?
>>=20
>> ARM has the thumb instructions, so it really isn't a fixed-length ISA.

> From the filename above we're talking about AArch64 here.
> Whcih is most definitely a fixed-width ISA.


> That said, even for AArch32 we know by the TB flags whether or not we're =
going
> to be generating arm or thumb code.  I think that these hooks will allow =
arm and
> thumb mode to finally be split apart cleanly, instead of the tangle that =
they
> are now.

> I see arm's gen_intermediate_code eventually looking like

>   const TranslatorOps *ops =3D &arm_translator_ops;
>   if (ARM_TBFLAG_THUMB(tb->flags)) {
>     ops =3D &thumb_translator_ops;
>   }
> #ifdef TARGET_AARCH64
>   if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
>     ops =3D &aarch64_translator_ops;
>   }
> #endif
>   translator_loop(ops, &dc.base, cpu, tb);

> There would certainly be some amount of shared code, but it would also al=
low
> quite a few of the existing dc->thumb checks to be eliminated.

Does this really need to be addressed on this series?


>>> And, while I'm thinking of it -- why is the init_globals hook separate?=
 There's
>>> nothing in between the two hook calls, and the more modern target front=
 ends
>>> won't need it.
>>=20
>> You mean merging init_disas_context and init_globals? I wanted to keep
>> semantically different code on separate hooks, but I can pull the init_g=
lobals
>> code into init_disas_context (hoping that as targets get modernized, the=
y won't
>> initialize any global there).

> I suppose you can leave the two hooks separate for now.  It doesn't hurt,=
 and
> it's kind of a reminder of things that need cleaning up.

Well, I've sent a (too rushed) v12 that features the merge. Since I'll have=
 to
send a v13, I can split them again if you want.


> I do wonder if we should provide a generic empty hook, so that a target t=
hat
> does not need a particular hook need not define an empty function.  It co=
uld
> just put e.g. "translator_noop" into the structure.  Ok, maybe a better n=
ame
> than that...

I'm not really sure it's worth the effort. The original version trated NULL=
s as
a "skip this operation" (as Emilio suggests to revive), but after discussin=
g the
approach it was decided that defining an empty function was not too much ef=
fort,
so that's what I went for.

I can restore the NULL approach or add a default empty hook implementation
(translator_ignored_op?) if there's a strong feeling to change it.


Cheers,
  Lluis
