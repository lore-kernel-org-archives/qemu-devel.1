Received: from eggs.gnu.org ([208.118.235.92]:33666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfRVP-00087U-HO
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:35:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfRVO-0007Ai-KS
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:35:27 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfRVO-0007AS-ET
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:35:26 -0500
Received: by mail-ot1-x343.google.com with SMTP id u16so32381499otk.8
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 07:35:26 -0800 (PST)
MIME-Version: 1.0
References: <20181213115503.24188-1-alex.bennee@linaro.org>
	<20181213115503.24188-3-alex.bennee@linaro.org>
In-Reply-To: <20181213115503.24188-3-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jan 2019 15:35:13 +0000
Message-ID: <CAFEAcA_7OgJXKb2YwF9qMwf1J2+hkYwft1us4+yMJ_OeUiJ-jQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/2] target/arm: defer setting up of
 aarch64 gdb until arm_cpu_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Omair Javaid <omair.javaid@linaro.org>

On Thu, 13 Dec 2018 at 11:55, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> If we setup earlier we miss the parsing of the aarch64 state of the
> CPU. If the user has booted up with:
>
>   qemu-system-aarch64 -cpu host,aarch64=3Doff -enable-kvm
>
> we end up presenting an aarch64 view of the world via the gdbstub and
> hilarity ensues.
>
> Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Omair Javaid <omair.javaid@linaro.org>
> ---
>  include/hw/arm/arm.h |  2 ++
>  target/arm/cpu.c     |  4 ++++
>  target/arm/cpu64.c   | 20 +++++++++++++++-----
>  3 files changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
> index ffed39252d..f9a7a6e2fb 100644
> --- a/include/hw/arm/arm.h
> +++ b/include/hw/arm/arm.h
> @@ -171,4 +171,6 @@ void arm_write_secure_board_setup_dummy_smc(ARMCPU *c=
pu,
>     ticks.  */
>  extern int system_clock_scale;
>
> +void arm_cpu_enable_aarch64_gdbstub(CPUClass *cc);
> +
>  #endif /* HW_ARM_H */
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 60411f6bfe..100a72ff81 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -890,9 +890,13 @@ static void arm_cpu_realizefn(DeviceState *dev, Erro=
r **errp)
>       * queries ID_ISAR0_EL1 on such a host, the value is UNKNOWN.
>       * Similarly, we cannot check ID_AA64PFR0 without AArch64 support.
>       */
> +#ifdef TARGET_AARCH64
>      if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
> +        CPUClass *cc =3D CPU_GET_CLASS(cs);
>          no_aa32 =3D !cpu_isar_feature(aa64_aa32, cpu);
> +        arm_cpu_enable_aarch64_gdbstub(cc);
>      }
> +#endif

This seems weird, because the fields in cc are common
to all CPUs in the class, and so setting them on
realize of a specific instance based on properties of
the instance looks wrong... At least in theory there's
no reason we couldn't have one -cpu host CPU with
aarch64=3Doff and one with aarch64=3Don, though I'm not
sure our UI allows the user to actually set the
properties per-cpu like that.

thanks
-- PMM
