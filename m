Received: from eggs.gnu.org ([208.118.235.92]:48972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gf2wN-0008Uv-Vb
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:21:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gf2wM-0008Ry-WE
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:21:39 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gf2wM-0008R2-Rn
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:21:38 -0500
Received: by mail-oi1-x244.google.com with SMTP id x23so27652906oix.3
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 05:21:38 -0800 (PST)
MIME-Version: 1.0
References: <20181218164348.7127-1-richard.henderson@linaro.org>
In-Reply-To: <20181218164348.7127-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jan 2019 13:21:26 +0000
Message-ID: <CAFEAcA_RGHe6rD-hHA-H5-4pN8Oau7v8pmPa+9bcW8KqkWLFYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] target/arm: Convert ARM_TBFLAG_* to
 FIELDs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Tue, 18 Dec 2018 at 16:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Use "register" TBFLAG_ANY to indicate shared state between
> A32 and A64, and "registers" TBFLAG_A32 & TBFLAG_A64 for
> fields that are specific to the given cpu state.
>
> Move ARM_TBFLAG_BE to shared state, instead of its current
> placement within "Bit usage when in AArch32 state".

>      if (arm_cpu_data_is_big_endian(env)) {
> -        flags |= ARM_TBFLAG_BE_DATA_MASK;
> +        flags = FIELD_DP32(flags, TBFLAG_ANY, BE, 1);
>      }

Why did you rename this flag from "BE_DATA" to "BE" ? I think
the distinction is important -- the flag tells us only about
the endianness of the d-side, not the i-side. It also matches
up with the name of the function we're using to determine whether
the flag should be set, and with the name of the field in
the DisasContext struct which we populate from the flag.

Otherwise the patch looks good, so if you agree I'll apply
it to target-arm.next with the flag renamed back to BE_DATA.

thanks
-- PMM
