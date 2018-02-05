Received: from eggs.gnu.org ([2001:4830:134:3::10]:38825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eiqVA-0005IC-9y
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:48:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eiqV5-0003BV-JB
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:48:44 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1517324542-6607-1-git-send-email-peter.maydell@linaro.org>
	<1517324542-6607-6-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7b9ed62e-7210-48a3-9c1d-8f16e3a16796@amsat.org>
Date: Mon, 5 Feb 2018 20:48:34 -0300
MIME-Version: 1.0
In-Reply-To: <1517324542-6607-6-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="zhP4fAd7UXZShWhLn9Sd0IbV600QjE0qa"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 5/7] target/arm: Make
 v7m_push_callee_stack() honour MPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zhP4fAd7UXZShWhLn9Sd0IbV600QjE0qa
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org
Message-ID: <7b9ed62e-7210-48a3-9c1d-8f16e3a16796@amsat.org>
Subject: Re: [Qemu-arm] [PATCH 5/7] target/arm: Make v7m_push_callee_stack()
 honour MPU
References: <1517324542-6607-1-git-send-email-peter.maydell@linaro.org>
 <1517324542-6607-6-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1517324542-6607-6-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 12:02 PM, Peter Maydell wrote:
> Make v7m_push_callee_stack() honour the MPU by using the
> new v7m_stack_write() function. We return a flag to indicate
> whether the pushes failed, which we can then use in
> v7m_exception_taken() to cause us to handle the derived
> exception correctly.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 64 ++++++++++++++++++++++++++++++++++++++++-----=
--------
>  1 file changed, 49 insertions(+), 15 deletions(-)
>=20
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 007e760..de0031b 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6473,7 +6473,7 @@ static uint32_t arm_v7m_load_vector(ARMCPU *cpu, =
int exc, bool targets_secure)
>      return addr;
>  }
> =20
> -static void v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotai=
lchain,
> +static bool v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotai=
lchain,
>                                    bool ignore_faults)
>  {
>      /* For v8M, push the callee-saves register part of the stack frame=
=2E
> @@ -6481,31 +6481,55 @@ static void v7m_push_callee_stack(ARMCPU *cpu, =
uint32_t lr, bool dotailchain,
>       * In the tailchaining case this may not be the current stack.
>       */
>      CPUARMState *env =3D &cpu->env;
> -    CPUState *cs =3D CPU(cpu);
>      uint32_t *frame_sp_p;
>      uint32_t frameptr;
> +    ARMMMUIdx mmu_idx;
> +    bool stacked_ok;
> =20
>      if (dotailchain) {
> -        frame_sp_p =3D get_v7m_sp_ptr(env, true,
> -                                    lr & R_V7M_EXCRET_MODE_MASK,
> +        bool mode =3D lr & R_V7M_EXCRET_MODE_MASK;
> +        bool priv =3D !(env->v7m.control[M_REG_S] & R_V7M_CONTROL_NPRI=
V_MASK) ||
> +            !mode;
> +
> +        mmu_idx =3D arm_v7m_mmu_idx_for_secstate_and_priv(env, M_REG_S=
, priv);
> +        frame_sp_p =3D get_v7m_sp_ptr(env, M_REG_S, mode,
>                                      lr & R_V7M_EXCRET_SPSEL_MASK);
>      } else {
> +        mmu_idx =3D core_to_arm_mmu_idx(env, cpu_mmu_index(env, false)=
);
>          frame_sp_p =3D &env->regs[13];
>      }
> =20
>      frameptr =3D *frame_sp_p - 0x28;
> =20
> -    stl_phys(cs->as, frameptr, 0xfefa125b);
> -    stl_phys(cs->as, frameptr + 0x8, env->regs[4]);
> -    stl_phys(cs->as, frameptr + 0xc, env->regs[5]);
> -    stl_phys(cs->as, frameptr + 0x10, env->regs[6]);
> -    stl_phys(cs->as, frameptr + 0x14, env->regs[7]);
> -    stl_phys(cs->as, frameptr + 0x18, env->regs[8]);
> -    stl_phys(cs->as, frameptr + 0x1c, env->regs[9]);
> -    stl_phys(cs->as, frameptr + 0x20, env->regs[10]);
> -    stl_phys(cs->as, frameptr + 0x24, env->regs[11]);
> +    /* Write as much of the stack frame as we can. A write failure may=

> +     * cause us to pend a derived exception.
> +     */
> +    stacked_ok =3D
> +        v7m_stack_write(cpu, frameptr, 0xfefa125b, mmu_idx, ignore_fau=
lts) &&
> +        v7m_stack_write(cpu, frameptr + 0x8, env->regs[4], mmu_idx,

nice!

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> +                        ignore_faults) &&
> +        v7m_stack_write(cpu, frameptr + 0xc, env->regs[5], mmu_idx,
> +                        ignore_faults) &&
> +        v7m_stack_write(cpu, frameptr + 0x10, env->regs[6], mmu_idx,
> +                        ignore_faults) &&
> +        v7m_stack_write(cpu, frameptr + 0x14, env->regs[7], mmu_idx,
> +                        ignore_faults) &&
> +        v7m_stack_write(cpu, frameptr + 0x18, env->regs[8], mmu_idx,
> +                        ignore_faults) &&
> +        v7m_stack_write(cpu, frameptr + 0x1c, env->regs[9], mmu_idx,
> +                        ignore_faults) &&
> +        v7m_stack_write(cpu, frameptr + 0x20, env->regs[10], mmu_idx,
> +                        ignore_faults) &&
> +        v7m_stack_write(cpu, frameptr + 0x24, env->regs[11], mmu_idx,
> +                        ignore_faults);
> =20
> +    /* Update SP regardless of whether any of the stack accesses faile=
d.
> +     * When we implement v8M stack limit checking then this attempt to=

> +     * update SP might also fail and result in a derived exception.
> +     */
>      *frame_sp_p =3D frameptr;
> +
> +    return !stacked_ok;
>  }
> =20
>  static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailc=
hain,
> @@ -6519,6 +6543,7 @@ static void v7m_exception_taken(ARMCPU *cpu, uint=
32_t lr, bool dotailchain,
>      uint32_t addr;
>      bool targets_secure;
>      int exc;
> +    bool push_failed =3D false;
> =20
>      armv7m_nvic_get_pending_irq_info(env->nvic, &exc, &targets_secure)=
;
> =20
> @@ -6546,8 +6571,8 @@ static void v7m_exception_taken(ARMCPU *cpu, uint=
32_t lr, bool dotailchain,
>                   */
>                  if (lr & R_V7M_EXCRET_DCRS_MASK &&
>                      !(dotailchain && (lr & R_V7M_EXCRET_ES_MASK))) {
> -                    v7m_push_callee_stack(cpu, lr, dotailchain,
> -                                          ignore_stackfaults);
> +                    push_failed =3D v7m_push_callee_stack(cpu, lr, dot=
ailchain,
> +                                                        ignore_stackfa=
ults);
>                  }
>                  lr |=3D R_V7M_EXCRET_DCRS_MASK;
>              }
> @@ -6589,6 +6614,15 @@ static void v7m_exception_taken(ARMCPU *cpu, uin=
t32_t lr, bool dotailchain,
>          }
>      }
> =20
> +    if (push_failed && !ignore_stackfaults) {
> +        /* Derived exception on callee-saves register stacking:
> +         * we might now want to take a different exception which
> +         * targets a different security state, so try again from the t=
op.
> +         */
> +        v7m_exception_taken(cpu, lr, true, true);
> +        return;
> +    }
> +
>      addr =3D arm_v7m_load_vector(cpu, exc, targets_secure);
> =20
>      /* Now we've done everything that might cause a derived exception
>=20


--zhP4fAd7UXZShWhLn9Sd0IbV600QjE0qa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlp47VIACgkQ4+MsLN6t
wN7wqBAAs6ZQweJcPjyJOJj6DDIfhMYZrpnlvRhE8C7cbfvPhhycVpYTaF6aI3t5
Dfz76F6Zwt7EnODPrD7B1oRDg8NCnU1+p+B5Wsaw1WT8CfSGh1WElKaBRlnWBD4O
3A/hSGn2zpXVlCub6occRoBAcFZFonGa2vOfPuN+L/tly5BXllC6/7ioMkohhPhn
7P74WFN+oGoXqxddOQcI2t06rI/mJDhmtUdJ4bBzjvXyW3DT4yqelZbkww1obQds
f/hyfnDiNRnMvOxvt55Ha+O++I0aM/Tm6FGq/YYUrIwEB9n+rH4zRFZQ0K1f/sK9
2An/zLTxoh9mDEKlXR0bBiHhWCORcdvP9Ve5KU0S7PkHXLfFgu+r5cZDspkYInv9
0PZl2couTDSIvPdb69jS2R48a8SevvWt7xHKDzoDIdBizLkwdZTXz4xRcSAZg2jr
A8I7Gh0nbX8uVhDg8Ir8WTzld30oDdSrne7MuXr6wPC80K3etlQPedDMJo5o4eZN
Bi9j1JL4IuYUYZVrTythTMGh59m70MlE8hMqF7/TfqtmgJlHFUJwJ1wgH+Nlr0MW
04H/okLQ5EKO1LT9iVauSIiDzaLs9cg/U1ORJcnq2KSDyg8ofEaKe9jbEM7GNd1Q
3egdNd7YADvd/9DHc7983jizNxq+mKyyaY4YZHuUscvVUvxim44=
=51Em
-----END PGP SIGNATURE-----

--zhP4fAd7UXZShWhLn9Sd0IbV600QjE0qa--
