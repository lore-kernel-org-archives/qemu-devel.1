Received: from eggs.gnu.org ([2001:4830:134:3::10]:42997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYXrP-00058t-OU
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:25:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYXrO-0004IZ-T4
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:25:23 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:42814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYXrO-0004Hn-Mg
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:25:22 -0400
Received: by mail-oi0-x244.google.com with SMTP id n84-v6so5347464oib.9
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 07:25:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180625160009.17437-3-alex.bennee@linaro.org>
References: <20180625160009.17437-1-alex.bennee@linaro.org>
	<20180625160009.17437-3-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 15:25:01 +0100
Message-ID: <CAFEAcA8JHHp2oVvUqX0oGhc+R7u1PNCWW1Q052ujpTx9WbVNDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/5] target/arm: relax permission checks
 for HWCAP_CPUID registers
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

On 25 June 2018 at 17:00, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Although technically not visible to userspace the kernel does make
> them visible via trap and emulate. For user mode we can provide the
> value directly but we need to relax our permission checks to do this.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  target/arm/helper.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 6e6b1762e8..9d81feb124 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5813,7 +5813,19 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu=
,
>      if (r->state !=3D ARM_CP_STATE_AA32) {
>          int mask =3D 0;
>          switch (r->opc1) {
> -        case 0: case 1: case 2:
> +        case 0:
> +#ifdef CONFIG_USER_ONLY
> +            /* Some AArch64 CPU ID/feature are exported to userspace
> +             * by the kernel (see HWCAP_CPUID) */
> +            if (r->opc0 =3D=3D 3 && r->crn =3D=3D 0 &&
> +                (r->crm =3D=3D 0 ||
> +                 (r->crm >=3D 4 && r->crm <=3D 7))) {
> +                mask =3D PL0_R;
> +                break;
> +            }
> +#endif
> +            /* fall-through */
> +        case 1: case 2:
>              /* min_EL EL1 */
>              mask =3D PL1_RW;
>              break;

This looks like a rather inelegant place to shove a CONFIG_USER_ONLY
special case. Isn't there a cleaner way to do whatever this is trying
to achieve?

thanks
-- PMM
