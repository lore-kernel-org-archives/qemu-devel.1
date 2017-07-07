Received: from eggs.gnu.org ([2001:4830:134:3::10]:49538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTRHq-0006tq-Rn
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTRHl-0002Rs-S6
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:19:02 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865801156.17063.15618379976159104550.stgit@frigg.lan>
	<244b5aab-8863-3139-f252-09cc02333eda@twiddle.net>
Date: Fri, 07 Jul 2017 13:18:40 +0200
In-Reply-To: <244b5aab-8863-3139-f252-09cc02333eda@twiddle.net> (Richard
	Henderson's message of "Sat, 1 Jul 2017 18:42:09 -0700")
Message-ID: <87inj4ebqn.fsf@frigg.lan>
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

> On 06/28/2017 06:53 AM, Llu=C3=ADs Vilanova wrote:
>> Incrementally paves the way towards using the generic instruction transl=
ation
>> loop.
>>=20
>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> ---
>> target/arm/translate-a64.c |   74 +++++++++++++++++++++++++++-----------=
------
>> 1 file changed, 46 insertions(+), 28 deletions(-)
>>=20
>> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
>> index 9c870f6d07..586a01a2de 100644
>> --- a/target/arm/translate-a64.c
>> +++ b/target/arm/translate-a64.c
>> @@ -11244,6 +11244,9 @@ static void aarch64_trblock_init_disas_context(D=
isasContextBase *dcbase,
dc-> is_ldex =3D false;
dc-> ss_same_el =3D (arm_debug_target_el(env) =3D=3D dc->current_el);
>> +    dc->next_page_start =3D
>> +        (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;

> I think a better solution for a fixed-length ISA is to adjust max_insns. =
Perhaps
> the init_disas_context hook should be able to modify it?

ARM has the thumb instructions, so it really isn't a fixed-length ISA.


> And, while I'm thinking of it -- why is the init_globals hook separate? T=
here's
> nothing in between the two hook calls, and the more modern target front e=
nds
> won't need it.

You mean merging init_disas_context and init_globals? I wanted to keep
semantically different code on separate hooks, but I can pull the init_glob=
als
code into init_disas_context (hoping that as targets get modernized, they w=
on't
initialize any global there).


Thanks,
  Lluis
