Received: from eggs.gnu.org ([2001:4830:134:3::10]:54909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7HPP-0004p5-Ob
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7HPO-0007h3-Tu
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:56:03 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7HPO-0007gt-Ov
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:56:02 -0400
Received: by mail-oi1-x242.google.com with SMTP id p125-v6so1020546oic.3
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 02:56:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180926112048.17778-3-alex.bennee@linaro.org>
References: <20180926112048.17778-1-alex.bennee@linaro.org>
	<20180926112048.17778-3-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 10:55:41 +0100
Message-ID: <CAFEAcA-KK6s6DFLHkHQzQAi_Lx-UJ=2E0FaLdfN5m_oR4YgdzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/4] target/arm64: hold BQL when calling
 do_interrupt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Omair Javaid <omair.javaid@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On 26 September 2018 at 12:20, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
> Fix the assertion failure when running interrupts.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  target/arm/kvm64.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 80ad07ed0c..346e1f1a73 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -984,7 +984,9 @@ bool kvm_arm_handle_debug(CPUState *cs, struct kvm_de=
bug_exit_arch *debug_exit)
>      cs->exception_index =3D EXCP_BKPT;
>      env->exception.syndrome =3D debug_exit->hsr;
>      env->exception.vaddress =3D debug_exit->far;
> +    qemu_mutex_lock_iothread();
>      cc->do_interrupt(cs);
> +    qemu_mutex_unlock_iothread();
>
>      return false;
>  }
> --
> 2.17.1

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
