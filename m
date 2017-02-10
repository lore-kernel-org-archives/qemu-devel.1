Received: from eggs.gnu.org ([2001:4830:134:3::10]:48284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccCa9-0007QL-AE
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:53:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccCa8-0007Ha-Ge
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:53:53 -0500
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:33378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ccCa8-0007HJ-9C
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:53:52 -0500
Received: by mail-wr0-x233.google.com with SMTP id i10so109769991wrb.0
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 06:53:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170209170904.5713-24-alex.bennee@linaro.org>
References: <20170209170904.5713-1-alex.bennee@linaro.org>
	<20170209170904.5713-24-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 14:53:30 +0000
Message-ID: <CAFEAcA8_UNip6QooREop-T5RBpdo1me0piEAscJRC+G7tGcNrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 23/24] hw/misc/imx6_src: defer clearing
 of SRC_SCR reset bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, MTTCG Devel <mttcg@listserver.greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Fedorov Sergey <serge.fdrv@gmail.com>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, Peter Chubb <peter.chubb@nicta.com.au>, "open list:i.MX31" <qemu-arm@nongnu.org>

On 9 February 2017 at 17:09, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> The arm_reset_cpu/set_cpu_on/set_cpu_off() functions do their work
> asynchronously in the target vCPUs context. As a result we need to
> ensure the SRC_SCR reset bits correctly report the reset status at the
> right time. To do this we defer the clearing of the bit with an async
> job which will run after the work queued by ARM powerctl functions.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  hw/misc/imx6_src.c | 58 +++++++++++++++++++++++++++++++++++++++++++++---=
------
>  1 file changed, 49 insertions(+), 9 deletions(-)
>
> diff --git a/hw/misc/imx6_src.c b/hw/misc/imx6_src.c
> index 55b817b8d7..f7c1d94a3e 100644
> --- a/hw/misc/imx6_src.c
> +++ b/hw/misc/imx6_src.c
> @@ -14,6 +14,7 @@
>  #include "qemu/bitops.h"
>  #include "qemu/log.h"
>  #include "arm-powerctl.h"
> +#include "qom/cpu.h"
>
>  #ifndef DEBUG_IMX6_SRC
>  #define DEBUG_IMX6_SRC 0
> @@ -113,6 +114,45 @@ static uint64_t imx6_src_read(void *opaque, hwaddr o=
ffset, unsigned size)
>      return value;
>  }
>
> +
> +/* The reset is asynchronous so we need to defer clearing the reset
> + * bit until the work is completed.
> + */
> +
> +struct src_scr_reset_info {

Struct names should be CamelCase.

> +    IMX6SRCState *s;
> +    unsigned long reset_bit;

Unsigned long ? That's always a bit of a red flag because it's
variable in size from host to host. I think you want "int".

> +};
> +
> +static void imx6_clear_reset_bit(CPUState *cpu, run_on_cpu_data data)
> +{
> +    struct src_scr_reset_info *ri =3D data.host_ptr;
> +    IMX6SRCState *s =3D ri->s;
> +
> +    assert(qemu_mutex_iothread_locked());
> +
> +    s->regs[SRC_SCR] =3D deposit32(s->regs[SRC_SCR], ri->reset_bit, 1, 0=
);
> +    DPRINTF("reg[%s] <=3D 0x%" PRIx32 "\n",
> +            imx6_src_reg_name(SRC_SCR), s->regs[SRC_SCR]);
> +
> +    g_free(ri);
> +}
> +
> +static void imx6_defer_clear_reset_bit(int cpuid,
> +                                       IMX6SRCState *s,
> +                                       unsigned long reset_shift)
> +{
> +    struct src_scr_reset_info *ri;
> +
> +    ri =3D g_malloc(sizeof(struct src_scr_reset_info));
> +    ri->s =3D s;
> +    ri->reset_bit =3D reset_shift;
> +
> +    async_run_on_cpu(arm_get_cpu_by_id(cpuid), imx6_clear_reset_bit,
> +                     RUN_ON_CPU_HOST_PTR(ri));
> +}

What happens if we do a system reset between calling this
and the async hook running? Do all the outstanding async
run hooks guarantee to run first?

I guess a malloc-and-free is OK since the guest isn't going to be
bouncing CPUs through reset very often, though it's a bit ugly to
see in device code.

Otherwise this looks OK.

thanks
-- PMM
