Received: from eggs.gnu.org ([2001:4830:134:3::10]:39544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fGnAY-000102-Ct
	for qemu-devel@nongnu.org; Thu, 10 May 2018 11:07:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fGnAV-0004sv-RO
	for qemu-devel@nongnu.org; Thu, 10 May 2018 11:07:46 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:43116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fGnAV-0004sW-La
	for qemu-devel@nongnu.org; Thu, 10 May 2018 11:07:43 -0400
Received: by mail-wr0-x243.google.com with SMTP id v15-v6so2353927wrm.10
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 08:07:43 -0700 (PDT)
References: <20180510140934.22855-1-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180510140934.22855-1-peter.maydell@linaro.org>
Date: Thu, 10 May 2018 16:07:41 +0100
Message-ID: <87in7vv9aa.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] fix fp16 tininess
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Richard Henderson <rth@twiddle.net>


Peter Maydell <peter.maydell@linaro.org> writes:

> In commit d81ce0ef2c4f105 we added an extra float_status field
> fp_status_fp16 for Arm, but forgot to initialize it correctly
> by setting it to float_tininess_before_rounding. This currently
> will only cause problems for the new V8_FP16 feature, since the
> float-to-float conversion code doesn't use it yet. The effect
> would be that we failed to set the Underflow IEEE exception flag
> in all the cases where we should.
>
> Add the missing initialization.
>
> Fixes: d81ce0ef2c4f105
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index d175c5e94f..7939c6b8ae 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -324,6 +324,8 @@ static void arm_cpu_reset(CPUState *s)
>                                &env->vfp.fp_status);
>      set_float_detect_tininess(float_tininess_before_rounding,
>                                &env->vfp.standard_fp_status);
> +    set_float_detect_tininess(float_tininess_before_rounding,
> +                              &env->vfp.fp_status_f16);
>  #ifndef CONFIG_USER_ONLY
>      if (kvm_enabled()) {
>          kvm_arm_reset_vcpu(cpu);


--
Alex Benn=C3=A9e
