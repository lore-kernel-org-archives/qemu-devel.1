Received: from eggs.gnu.org ([2001:4830:134:3::10]:42518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emI1h-0006vx-NX
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 06:48:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emI1g-0002YK-LA
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 06:48:33 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:42210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1emI1g-0002Y6-Dd
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 06:48:32 -0500
Received: by mail-ot0-x244.google.com with SMTP id a7so23149259otk.9
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 03:48:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180208055039.24666-2-penberg@iki.fi>
References: <20180208055039.24666-1-penberg@iki.fi>
	<20180208055039.24666-2-penberg@iki.fi>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 11:48:11 +0000
Message-ID: <CAFEAcA8EWmaf5JWEmgBsNknTHuKDaHCnEAQgatn7Ppq-Gy8Fzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/3] bcm2836: Make CPU type configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pekka Enberg <penberg@iki.fi>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 8 February 2018 at 05:50, Pekka Enberg <penberg@iki.fi> wrote:
> This patch adds a "cpu-type" property to BCM2836 SoC in preparation for
> reusing the code for the Raspberry Pi 3, which has a different processor
> model.
>
> Signed-off-by: Pekka Enberg <penberg@iki.fi>

> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -135,6 +135,8 @@ static void raspi2_init(MachineState *machine)
>      /* Setup the SOC */
>      object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ram),
>                                     &error_abort);
> +    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
> +                            &error_abort);
>      object_property_set_int(OBJECT(&s->soc), smp_cpus, "enabled-cpus",
>                              &error_abort);
>      object_property_set_int(OBJECT(&s->soc), 0xa21041, "board-rev",
> @@ -166,6 +168,7 @@ static void raspi2_machine_init(MachineClass *mc)
>      mc->no_parallel = 1;
>      mc->no_floppy = 1;
>      mc->no_cdrom = 1;
> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
>      mc->max_cpus = BCM2836_NCPUS;
>      mc->min_cpus = BCM2836_NCPUS;
>      mc->default_cpus = BCM2836_NCPUS;

This change means that instead of ignoring the user's -cpu argument
we'll now unconditionally accept it even if it's nonsense for this
board. Neither behaviour is great. However, the patchset to allow
boards to easily specify the valid set of CPU types is still in
code review:
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg00308.html

so I'm happy to take this as-is, and we'll add the validity check
when that patchset goes in.

thanks
-- PMM
