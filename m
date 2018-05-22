Received: from eggs.gnu.org ([2001:4830:134:3::10]:44095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL56L-00089u-7X
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:05:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL56K-00077y-0O
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:05:09 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:45213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fL56J-00077l-Rv
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:05:07 -0400
Received: by mail-oi0-x242.google.com with SMTP id b130-v6so15792481oif.12
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 04:05:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180518114424.18054-2-alex.bennee@linaro.org>
References: <20180518114424.18054-1-alex.bennee@linaro.org>
	<20180518114424.18054-2-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 12:04:46 +0100
Message-ID: <CAFEAcA9=gD31xOyvEQ-0-3f5p_Z8PQpOySpxB3fzcpWNZyeiiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] target/arm: support reading of
 CNT[VCT|FRQ]_EL0 from user-space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 18 May 2018 at 12:44, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Since kernel commit a86bd139f2 (arm64: arch_timer: Enable CNTVCT_EL0
> trap..) user-space has been able to read these system registers. As we
> can't use QEMUTimer's in linux-user mode we just directly call
> cpu_get_clock().
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v2
>   - include CNTFRQ_EL0 for PL0_R only
> ---
>  target/arm/helper.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index db8bbe52a6..39098a15bf 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2135,11 +2135,32 @@ static const ARMCPRegInfo generic_timer_cp_reginf=
o[] =3D {
>  };
>
>  #else
> -/* In user-mode none of the generic timer registers are accessible,
> - * and their implementation depends on QEMU_CLOCK_VIRTUAL and qdev gpio =
outputs,
> - * so instead just don't register any of them.
> +
> +/* In user-mode most of the generic timer registers are inaccessible
> + * however modern kernels (4.12+) allow access to cntvct_el0
>   */
> +
> +static uint64_t gt_virt_cnt_read(CPUARMState *env, const ARMCPRegInfo *r=
i)
> +{
> +    /* Currently we have no support for QEMUTimer in linux-user so we
> +     * can't call gt_get_countervalue(env), instead we directly
> +     * call the lower level functions.
> +     */
> +    return cpu_get_clock() / GTIMER_SCALE;
> +}
> +
>  static const ARMCPRegInfo generic_timer_cp_reginfo[] =3D {
> +    { .name =3D "CNTFRQ_EL0", .state =3D ARM_CP_STATE_AA64,
> +      .opc0 =3D 3, .opc1 =3D 3, .crn =3D 14, .crm =3D 0, .opc2 =3D 0,
> +      .access =3D PL0_R /* no PL1_RW in linux-user */,
> +      .fieldoffset =3D offsetof(CPUARMState, cp15.c14_cntfrq),
> +      .resetvalue =3D (1000 * 1000 * 1000) / GTIMER_SCALE,

You might as well just make this be .type =3D ARM_CP_CONST,
since the CPU state field can never change.

Also, perhaps NANOSECONDS_PER_SECOND / GTIMER_SCALE.)

> +    },
> +    { .name =3D "CNTVCT_EL0", .state =3D ARM_CP_STATE_AA64,
> +      .opc0 =3D 3, .opc1 =3D 3, .crn =3D 14, .crm =3D 0, .opc2 =3D 2,
> +      .access =3D PL0_R, .type =3D ARM_CP_NO_RAW | ARM_CP_IO,
> +      .readfn =3D gt_virt_cnt_read,
> +    },
>      REGINFO_SENTINEL
>  };

Do we need to make the 32-bit registers accessible to linux-user
processes too?

(Incidentally, another thing along these lines we should probably
look at is that I think that newer kernels emulate ID register
accesses from EL0, so we should do something to make those
registers work too.)

thanks
-- PMM
