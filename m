Received: from eggs.gnu.org ([2001:4830:134:3::10]:59418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dYqOO-0001i2-83
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 05:08:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dYqOJ-0003v1-5R
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 05:08:06 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:40458 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dYqOI-0003uh-Pd
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 05:08:03 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <20170715094243.28371-1-rth@twiddle.net>
	<20170715094243.28371-33-rth@twiddle.net>
Date: Sat, 22 Jul 2017 12:07:47 +0300
In-Reply-To: <20170715094243.28371-33-rth@twiddle.net> (Richard Henderson's
	message of "Fri, 14 Jul 2017 23:42:41 -1000")
Message-ID: <87r2x8g7q4.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v14 32/34] target/arm: Move ss check to
 init_disas_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, cota@braap.org, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

Richard Henderson writes:

> We can check for single-step just once.
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>


> ---
>  target/arm/translate.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 4b1230b..ebe1c1a 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -11845,6 +11845,11 @@ static int arm_tr_init_disas_context(DisasContex=
tBase *dcbase,
dc-> next_page_start =3D
>          (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
=20
> +    /* If architectural single step active, limit to 1.  */
> +    if (is_singlestepping(dc)) {
> +        max_insns =3D 1;
> +    }
> +
>      cpu_F0s =3D tcg_temp_new_i32();
>      cpu_F1s =3D tcg_temp_new_i32();
>      cpu_F0d =3D tcg_temp_new_i64();
> @@ -12000,11 +12005,9 @@ static void arm_tr_translate_insn(DisasContextBa=
se *dcbase, CPUState *cpu)
>           * Also stop translation when a page boundary is reached.  This
>           * ensures prefetch aborts occur at the right place.  */
=20
> -        if (is_singlestepping(dc)) {
> -            dc->base.is_jmp =3D DISAS_TOO_MANY;
> -        } else if ((dc->pc >=3D dc->next_page_start) ||
> -                   ((dc->pc >=3D dc->next_page_start - 3) &&
> -                    insn_crosses_page(env, dc))) {
> +        if (dc->pc >=3D dc->next_page_start ||
> +            (dc->pc >=3D dc->next_page_start - 3 &&
> +             insn_crosses_page(env, dc))) {
>              /* We want to stop the TB if the next insn starts in a new p=
age,
>               * or if it spans between this page and the next. This means=
 that
>               * if we're looking at the last halfword in the page we need=
 to
> --=20
> 2.9.4
