Received: from eggs.gnu.org ([2001:4830:134:3::10]:54802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fLCcZ-00061G-MI
	for qemu-devel@nongnu.org; Tue, 22 May 2018 15:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fLCcW-0005sJ-FW
	for qemu-devel@nongnu.org; Tue, 22 May 2018 15:06:55 -0400
Received: from 3.mo5.mail-out.ovh.net ([46.105.40.108]:43960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fLCcW-0005q5-90
	for qemu-devel@nongnu.org; Tue, 22 May 2018 15:06:52 -0400
Received: from player715.ha.ovh.net (unknown [10.109.120.53])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 371171B15F1
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 21:06:41 +0200 (CEST)
References: <20180522173713.26282-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d8c13782-48b1-0975-ee2c-0d2ec2eecebe@kaod.org>
Date: Tue, 22 May 2018 21:06:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180522173713.26282-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Correct CPACR reset value for v7 cores
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

On 05/22/2018 07:37 PM, Peter Maydell wrote:
> In commit f0aff255700 we made cpacr_write() enforce that some CPACR
> bits are RAZ/WI and some are RAO/WI for ARMv7 cores. Unfortunately
> we forgot to also update the register's reset value. The effect
> was that (a) a guest that read CPACR on reset would not see ones in
> the RAO bits, and (b) if you did a migration before the guest did
> a write to the CPACR then the migration would fail because the
> destination would enforce the RAO bits and then complain that they
> didn't match the zero value from the source.
>=20
> Implement reset for the CPACR using a custom reset function
> that just calls cpacr_write(), to avoid having to duplicate
> the logic for which bits are RAO.
>=20
> This bug would affect migration for TCG CPUs which are ARMv7
> with VFP but without one of Neon or VFPv3.
>=20
> Reported-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
> This is sufficient that a save-and-reload while the romulus-bmc
> machine is in the bootloader will work. On the other hand if
> I do a save-and-reload after the kernel has started booting
> then we get the classic "guest hang after reload", so some
> state is still not being transferred somewhere (probably in
> a device in the machine model?)

I see the problem. Bizarre.

Thanks,

C. =20

> ---
>  target/arm/helper.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index c0f739972e..6023bf6046 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -863,6 +863,14 @@ static void cpacr_write(CPUARMState *env, const AR=
MCPRegInfo *ri,
>      env->cp15.cpacr_el1 =3D value;
>  }
> =20
> +static void cpacr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    /* Call cpacr_write() so that we reset with the correct RAO bits s=
et
> +     * for our CPU features.
> +     */
> +    cpacr_write(env, ri, 0);
> +}
> +
>  static CPAccessResult cpacr_access(CPUARMState *env, const ARMCPRegInf=
o *ri,
>                                     bool isread)
>  {
> @@ -920,7 +928,7 @@ static const ARMCPRegInfo v6_cp_reginfo[] =3D {
>      { .name =3D "CPACR", .state =3D ARM_CP_STATE_BOTH, .opc0 =3D 3,
>        .crn =3D 1, .crm =3D 0, .opc1 =3D 0, .opc2 =3D 2, .accessfn =3D =
cpacr_access,
>        .access =3D PL1_RW, .fieldoffset =3D offsetof(CPUARMState, cp15.=
cpacr_el1),
> -      .resetvalue =3D 0, .writefn =3D cpacr_write },
> +      .resetfn =3D cpacr_reset, .writefn =3D cpacr_write },
>      REGINFO_SENTINEL
>  };
> =20
>=20
