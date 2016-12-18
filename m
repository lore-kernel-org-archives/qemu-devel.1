Received: from eggs.gnu.org ([2001:4830:134:3::10]:54998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cIiLs-0001mz-6V
	for qemu-devel@nongnu.org; Sun, 18 Dec 2016 15:46:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cIiLr-0001Sb-1y
	for qemu-devel@nongnu.org; Sun, 18 Dec 2016 15:46:36 -0500
Date: Sun, 18 Dec 2016 18:46:24 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161218204624.GA3808@thinpad.lan.raisama.net>
References: <20161215123656.27985-1-alex.bennee@linaro.org>
	<20161215123656.27985-2-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20161215123656.27985-2-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qom/cpu: move tlb_flush to
 cpu_common_reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: rth@twiddle.net, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Jia Liu <proljc@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>

On Thu, Dec 15, 2016 at 12:36:55PM +0000, Alex Benn=E9e wrote:
> It is a common thing amongst the various cpu reset functions want to
> flush the SoftMMU's TLB entries. This is done either by calling
> tlb_flush directly or by way of a general memset of the CPU
> structure (sometimes both).
>=20
> This moves the tlb_flush call to the common reset function and
> additionally ensures it is only done for the CONFIG_SOFTMMU case and
> when tcg is enabled.
>=20
> In some target cases we add an empty end_of_reset_fields structure to t=
he
> target vCPU structure so have a clear end point for any memset which
> is resetting value in the structure before CPU_COMMON (where the TLB
> structures are).
>=20
> While this is a nice clean-up in general it is also a precursor for
> changes coming to cputlb for MTTCG where the clearing of entries
> can't be done arbitrarily across vCPUs. Currently the cpu_reset
> function is usually called from the context of another vCPU as the
> architectural power up sequence is run. By using the cputlb API
> functions we can ensure the right behaviour in the future.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> ---
>  qom/cpu.c                   | 10 ++++++++--
>  target-arm/cpu.c            |  5 ++---
>  target-arm/cpu.h            |  5 ++++-
>  target-cris/cpu.c           |  3 +--
>  target-cris/cpu.h           |  9 ++++++---
>  target-i386/cpu.c           |  2 --
>  target-i386/cpu.h           |  6 ++++--
>  target-lm32/cpu.c           |  3 +--
>  target-lm32/cpu.h           |  3 +++
>  target-m68k/cpu.c           |  3 +--
>  target-m68k/cpu.h           |  3 +++
>  target-microblaze/cpu.c     |  3 +--
>  target-microblaze/cpu.h     |  3 +++
>  target-mips/cpu.c           |  3 +--
>  target-mips/cpu.h           |  3 +++
>  target-moxie/cpu.c          |  4 +---
>  target-moxie/cpu.h          |  3 +++
>  target-openrisc/cpu.c       |  9 +--------
>  target-openrisc/cpu.h       |  3 +++
>  target-ppc/translate_init.c |  3 ---
>  target-s390x/cpu.c          |  7 ++-----
>  target-s390x/cpu.h          |  5 +++--
>  target-sh4/cpu.c            |  3 +--
>  target-sh4/cpu.h            |  3 +++
>  target-sparc/cpu.c          |  3 +--
>  target-sparc/cpu.h          |  3 +++
>  target-tilegx/cpu.c         |  3 +--
>  target-tilegx/cpu.h         |  3 +++
>  target-tricore/cpu.c        |  2 --
>  29 files changed, 66 insertions(+), 52 deletions(-)
>=20
> diff --git a/qom/cpu.c b/qom/cpu.c
> index 03d9190f8c..61ee0cb88c 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -270,8 +270,14 @@ static void cpu_common_reset(CPUState *cpu)
>      cpu->exception_index =3D -1;
>      cpu->crash_occurred =3D false;
> =20
> -    for (i =3D 0; i < TB_JMP_CACHE_SIZE; ++i) {
> -        atomic_set(&cpu->tb_jmp_cache[i], NULL);
> +    if (tcg_enabled()) {
> +        for (i =3D 0; i < TB_JMP_CACHE_SIZE; ++i) {
> +            atomic_set(&cpu->tb_jmp_cache[i], NULL);
> +        }
> +
> +#ifdef CONFIG_SOFTMMU
> +        tlb_flush(cpu, 0);
> +#endif

The patch is changing 3 things at the same time:

1) Moving the tb_jmp_cache reset inside if (tcg_enabled())
2) Moving the tlb_flush() call to cpu_common_reset()
3) Moving the tlb_flush() call inside if (tcg_enabled())

Are we 100% sure there's no non-TCG looking looking at tlb_*
fields or calling tlb_*() functions anywhere? Isn't it better to
add the tcg_enabled() check in a separate patch?


>      }
>  }
> =20
[...]
> diff --git a/target-i386/cpu.c b/target-i386/cpu.c
> index de1f30eeda..810893952a 100644
> --- a/target-i386/cpu.c
> +++ b/target-i386/cpu.c
> @@ -2815,8 +2815,6 @@ static void x86_cpu_reset(CPUState *s)
> =20
>      memset(env, 0, offsetof(CPUX86State, end_reset_fields));
> =20
> -    tlb_flush(s, 1);
> -
>      env->old_exception =3D -1;
> =20
>      /* init to reset state */
> diff --git a/target-i386/cpu.h b/target-i386/cpu.h
> index c605724022..95ed91d8d1 100644
> --- a/target-i386/cpu.h
> +++ b/target-i386/cpu.h
> @@ -1119,10 +1119,12 @@ typedef struct CPUX86State {
>      uint8_t nmi_injected;
>      uint8_t nmi_pending;
> =20
> +    /* Fields up to this point are cleared by a CPU reset */
> +    struct {} end_reset_fields;
> +
>      CPU_COMMON
> =20
> -    /* Fields from here on are preserved across CPU reset. */
> -    struct {} end_reset_fields;
> +    /* Fields after CPU_COMMON are preserved across CPU reset. */
> =20
>      /* processor features (e.g. for CPUID insn) */
>      /* Minimum level/xlevel/xlevel2, based on CPU model + features */

Do you have plans to move the tlb_* fields from CPUArchState to
CPUState and remove CPU_COMMON completely?


> diff --git a/target-lm32/cpu.c b/target-lm32/cpu.c
> index 8d939a7779..2b8c36b6d0 100644
> --- a/target-lm32/cpu.c
> +++ b/target-lm32/cpu.c
> @@ -128,10 +128,9 @@ static void lm32_cpu_reset(CPUState *s)
>      lcc->parent_reset(s);
> =20
>      /* reset cpu state */
> -    memset(env, 0, offsetof(CPULM32State, eba));
> +    memset(env, 0, offsetof(CPULM32State, end_reset_fields));
> =20
>      lm32_cpu_init_cfg_reg(cpu);
> -    tlb_flush(s, 1);
>  }
> =20
[...]

--=20
Eduardo
