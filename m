Received: from eggs.gnu.org ([2001:4830:134:3::10]:54923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCMil-00073b-Sv
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCMij-0007er-Du
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:37:03 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gCMii-0007T1-6g
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:37:00 -0400
Received: by mail-ot1-x342.google.com with SMTP id c23so20217588otl.9
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 03:36:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181008212205.17752-11-richard.henderson@linaro.org>
References: <20181008212205.17752-1-richard.henderson@linaro.org>
	<20181008212205.17752-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 11:36:36 +0100
Message-ID: <CAFEAcA-aSSg+EujPCcLg_Fb8Q2yY=Z43bKQz_jX8UCUabX2_hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 10/10] target/arm: Convert v8.2-fp16
 from feature bit to aa64pfr0 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 October 2018 at 22:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h           | 17 +++++++++++++++-
>  target/arm/translate-a64.h |  1 +
>  target/arm/translate.h     |  1 +
>  linux-user/elfload.c       |  6 +-----
>  target/arm/cpu64.c         |  9 ++-------
>  target/arm/helper.c        |  2 +-
>  target/arm/translate-a64.c | 40 +++++++++++++++++++-------------------
>  target/arm/translate.c     |  6 +++---
>  8 files changed, 45 insertions(+), 37 deletions(-)
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index ee2c04a627..38e9afef3b 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -266,6 +266,8 @@ static void aarch64_max_initfn(Object *obj)
>
>          t =3D cpu->id_aa64pfr0;
>          t =3D FIELD_DP64(t, ID_AA64PFR0, SVE, 1);
> +        t =3D FIELD_DP64(t, ID_AA64PFR0, FP, 1);
> +        t =3D FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 1);
>          cpu->id_aa64pfr0 =3D t;
>
>          /* Replicate the same data to the 32-bit id registers.  */
> @@ -283,13 +285,6 @@ static void aarch64_max_initfn(Object *obj)
>          cpu->id_isar6 =3D u;
>
>  #ifdef CONFIG_USER_ONLY
> -        /* We don't set these in system emulation mode for the moment,
> -         * since we don't correctly set the ID registers to advertise th=
em,
> -         * and in some cases they're only available in AArch64 and not A=
Arch32,
> -         * whereas the architecture requires them to be present in both =
if
> -         * present in either.
> -         */
> -        set_feature(&cpu->env, ARM_FEATURE_V8_FP16);

FP16 is the feature that this comment refers to about not having the
AArch32 support present yet. So previously we only set that feature
bit in the user-only mode. Doesn't that mean we need to only
set the equivalent PFR0 bits in the ID register in user-only mode now?

thanks
-- PMM
