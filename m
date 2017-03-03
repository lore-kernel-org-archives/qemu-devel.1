Received: from eggs.gnu.org ([2001:4830:134:3::10]:59960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjlg8-00042n-HZ
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:47:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjlg5-0000wH-Dg
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:47:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cjlg5-0000v6-4w
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:47:17 -0500
References: <20170302195337.31558-1-alex.bennee@linaro.org>
	<20170302195337.31558-7-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2ff07353-5044-277a-4c39-48f86756443e@redhat.com>
Date: Fri, 3 Mar 2017 12:47:10 +0100
MIME-Version: 1.0
In-Reply-To: <20170302195337.31558-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 06/11] sparc/sparc64: grab BQL before
 calling cpu_check_irqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, rth@twiddle.net
Cc: qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>



On 02/03/2017 20:53, Alex Benn=C3=A9e wrote:
> IRQ modification is part of device emulation and should be done while
> the BQL is held to prevent races when MTTCG is enabled. This adds
> assertions in the hw emulation layer and wraps the calls from helpers
> in the BQL.
>=20
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  hw/sparc/sun4m.c            |  3 +++
>  hw/sparc64/sparc64.c        |  3 +++
>  target/sparc/int64_helper.c |  3 +++
>  target/sparc/win_helper.c   | 11 +++++++++++
>  4 files changed, 20 insertions(+)
>=20
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 61416a6426..873cd7df9a 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -142,6 +142,9 @@ void cpu_check_irqs(CPUSPARCState *env)
>  {
>      CPUState *cs;
> =20
> +    /* We should be holding the BQL before we mess with IRQs */
> +    g_assert(qemu_mutex_iothread_locked());
> +
>      if (env->pil_in && (env->interrupt_index =3D=3D 0 ||
>                          (env->interrupt_index & ~15) =3D=3D TT_EXTINT)=
) {
>          unsigned int i;
> diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
> index b3d219c769..4e4fdab065 100644
> --- a/hw/sparc64/sparc64.c
> +++ b/hw/sparc64/sparc64.c
> @@ -55,6 +55,9 @@ void cpu_check_irqs(CPUSPARCState *env)
>      uint32_t pil =3D env->pil_in |
>                    (env->softint & ~(SOFTINT_TIMER | SOFTINT_STIMER));
> =20
> +    /* We should be holding the BQL before we mess with IRQs */
> +    g_assert(qemu_mutex_iothread_locked());
> +
>      /* TT_IVEC has a higher priority (16) than TT_EXTINT (31..17) */
>      if (env->ivec_status & 0x20) {
>          return;
> diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
> index 605747c93c..f942973c22 100644
> --- a/target/sparc/int64_helper.c
> +++ b/target/sparc/int64_helper.c
> @@ -18,6 +18,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
>  #include "cpu.h"
>  #include "exec/helper-proto.h"
>  #include "exec/log.h"
> @@ -208,7 +209,9 @@ static bool do_modify_softint(CPUSPARCState *env, u=
int32_t value)
>          env->softint =3D value;
>  #if !defined(CONFIG_USER_ONLY)
>          if (cpu_interrupts_enabled(env)) {
> +            qemu_mutex_lock_iothread();
>              cpu_check_irqs(env);
> +            qemu_mutex_unlock_iothread();
>          }
>  #endif
>          return true;
> diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
> index 71b3dd37e8..b387b026d8 100644
> --- a/target/sparc/win_helper.c
> +++ b/target/sparc/win_helper.c
> @@ -18,6 +18,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
>  #include "cpu.h"
>  #include "exec/exec-all.h"
>  #include "exec/helper-proto.h"
> @@ -86,7 +87,9 @@ void cpu_put_psr(CPUSPARCState *env, target_ulong val=
)
>  {
>      cpu_put_psr_raw(env, val);
>  #if ((!defined(TARGET_SPARC64)) && !defined(CONFIG_USER_ONLY))
> +    qemu_mutex_lock_iothread();
>      cpu_check_irqs(env);
> +    qemu_mutex_unlock_iothread();
>  #endif
>  }

This can be called from gdbstub, so you need to put the lock/unlock
around helper_wrpsr's call to cpu_put_psr instead.  Also please add a
comment /* Called with BQL held.  */ around cpu_put_psr.

Paolo

> @@ -368,7 +371,9 @@ void helper_wrpstate(CPUSPARCState *env, target_ulo=
ng new_state)
> =20
>  #if !defined(CONFIG_USER_ONLY)
>      if (cpu_interrupts_enabled(env)) {
> +        qemu_mutex_lock_iothread();
>          cpu_check_irqs(env);
> +        qemu_mutex_unlock_iothread();
>      }
>  #endif
>  }
> @@ -381,7 +386,9 @@ void helper_wrpil(CPUSPARCState *env, target_ulong =
new_pil)
>      env->psrpil =3D new_pil;
> =20
>      if (cpu_interrupts_enabled(env)) {
> +        qemu_mutex_lock_iothread();
>          cpu_check_irqs(env);
> +        qemu_mutex_unlock_iothread();
>      }
>  #endif
>  }
> @@ -408,7 +415,9 @@ void helper_done(CPUSPARCState *env)
> =20
>  #if !defined(CONFIG_USER_ONLY)
>      if (cpu_interrupts_enabled(env)) {
> +        qemu_mutex_lock_iothread();
>          cpu_check_irqs(env);
> +        qemu_mutex_unlock_iothread();
>      }
>  #endif
>  }
> @@ -435,7 +444,9 @@ void helper_retry(CPUSPARCState *env)
> =20
>  #if !defined(CONFIG_USER_ONLY)
>      if (cpu_interrupts_enabled(env)) {
> +        qemu_mutex_lock_iothread();
>          cpu_check_irqs(env);
> +        qemu_mutex_unlock_iothread();
>      }
>  #endif
>  }
>=20
