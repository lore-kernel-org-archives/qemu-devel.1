Received: from eggs.gnu.org ([2001:4830:134:3::10]:55107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gJi3W-0004yA-EH
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:48:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gJi3R-0005q2-71
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:48:50 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gJi3Q-0005ou-Ie
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:48:45 -0500
Received: by mail-wr1-x444.google.com with SMTP id 74-v6so10273541wrb.13
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 08:48:42 -0800 (PST)
References: <20181016093703.10637-1-peter.maydell@linaro.org>
	<20181016093703.10637-3-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181016093703.10637-3-peter.maydell@linaro.org>
Date: Mon, 05 Nov 2018 16:48:39 +0000
Message-ID: <87sh0feahk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/2] target/arm: Fix ATS1Hx
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, patches@linaro.org


Peter Maydell <peter.maydell@linaro.org> writes:

> ATS1HR and ATS1HW (which allow AArch32 EL2 to do address translations
> on the EL2 translation regime) were implemented in commit 14db7fe09a2c8.
> However, we got them wrong: these should do stage 1 address translations
> as defined for NS-EL2, which is ARMMMUIdx_S1E2. We were incorrectly
> making them perform stage 2 translations.
>
> A few years later in commit 1313e2d7e2cd we forgot entirely that
> we'd implemented ATS1Hx, and added a comment that ATS1Hx were
> "not supported yet". Remove the comment; there is no extra code
> needed to handle these operations in do_ats_write(), because
> arm_s1_regime_using_lpae_format() returns true for ARMMMUIdx_S1E2,
> which forces 64-bit PAR format.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index dc849b09893..903a832f1fa 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2316,7 +2316,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint=
64_t value,
>           *
>           * (Note that HCR.DC makes HCR.VM behave as if it is 1.)
>           *
> -         * ATS1Hx always uses the 64bit format (not supported yet).
> +         * ATS1Hx always uses the 64bit format.
>           */
>          format64 =3D arm_s1_regime_using_lpae_format(env, mmu_idx);
>
> @@ -2441,7 +2441,7 @@ static void ats1h_write(CPUARMState *env, const ARM=
CPRegInfo *ri,
>      MMUAccessType access_type =3D ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DA=
TA_LOAD;
>      uint64_t par64;
>
> -    par64 =3D do_ats_write(env, value, access_type, ARMMMUIdx_S2NS);
> +    par64 =3D do_ats_write(env, value, access_type, ARMMMUIdx_S1E2);
>
>      A32_BANKED_CURRENT_REG_SET(env, par, par64);
>  }


--
Alex Benn=C3=A9e
