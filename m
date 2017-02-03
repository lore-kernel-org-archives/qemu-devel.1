Received: from eggs.gnu.org ([2001:4830:134:3::10]:38632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZc0R-0005kO-EN
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:26:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZc0Q-0003l8-Fu
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:26:19 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:36273)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZc0Q-0003kL-9o
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:26:18 -0500
Received: by mail-wm0-x233.google.com with SMTP id c85so23924812wmi.1
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 03:26:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170201150553.9381-26-alex.bennee@linaro.org>
References: <20170201150553.9381-1-alex.bennee@linaro.org>
	<20170201150553.9381-26-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 11:25:56 +0000
Message-ID: <CAFEAcA8nAQy4NNZ0RG0wOJ6rQoKz54UN22Z9LL2o2EgMdtpObQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 25/25] tcg: enable MTTCG by default for
 ARM on x86 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: MTTCG Devel <mttcg@listserver.greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Fedorov Sergey <serge.fdrv@gmail.com>, Richard Henderson <rth@twiddle.net>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>

On 1 February 2017 at 15:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> This enables the multi-threaded system emulation by default for ARMv7
> and ARMv8 guests using the x86_64 TCG backend. This is because on the
> guest side:
>
>   - The ARM translate.c/translate-64.c have been converted to
>     - use MTTCG safe atomic primitives
>     - emit the appropriate barrier ops
>   - The ARM machine has been updated to
>     - hold the BQL when modifying shared cross-vCPU state
>     - defer cpu_reset to async safe work
>
> All the host backends support the barrier and atomic primitives but
> need to provide same-or-better support for normal load/store
> operations.

> diff --git a/cpus.c b/cpus.c
> index e3d9f3fe21..e1b82bcd49 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -176,8 +176,8 @@ bool mttcg_enabled;
>
>  static bool check_tcg_memory_orders_compatible(void)
>  {
> -#if defined(TCG_DEFAULT_MO) && defined(TCG_TARGET_DEFAULT_MO)
> -    return (TCG_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO) =3D=3D 0;
> +#if defined(TCG_GUEST_DEFAULT_MO) && defined(TCG_TARGET_DEFAULT_MO)
> +    return (TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO) =3D=3D 0;

This looks like maybe something that should have been squashed
into an earlier part of the patchset?

>  #else
>      return false;
>  #endif
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index a3c4d07817..0ef31db3e0 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -30,6 +30,9 @@
>  #  define TARGET_LONG_BITS 32
>  #endif
>
> +/* ARM processors have a weak memory model */
> +#define TCG_GUEST_DEFAULT_MO      (0)

Do you need the () ?


That said, if Richard is happy with turning this on then
I'm happy to do so.

Acked-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
