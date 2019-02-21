Received: from eggs.gnu.org ([209.51.188.92]:49594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwpX1-00019e-E7
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwpWz-000201-5z
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:40:59 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33769)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gwpWy-0001xH-SR
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:40:57 -0500
Received: by mail-wr1-x444.google.com with SMTP id i12so30757540wrw.0
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 06:40:56 -0800 (PST)
References: <20190215180500.6906-1-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190215180500.6906-1-peter.maydell@linaro.org>
Date: Thu, 21 Feb 2019 14:40:54 +0000
Message-ID: <87h8cx432h.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/arm/armsse: Make 0x5... alias region
 work for per-CPU devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, patches@linaro.org


Peter Maydell <peter.maydell@linaro.org> writes:

> The region 0x40010000 .. 0x4001ffff and its secure-only alias
> at 0x50010000... are for per-CPU devices. We implement this by
> giving each CPU its own container memory region, where the
> per-CPU devices live. Unfortunately, the alias region which
> makes devices mapped at 0x4... addresses also appear at 0x5...
> is only implemented in the overall "all CPUs" container. The
> effect of this bug is that the CPU_IDENTITY register block appears
> only at 0x4001f000, but not at the 0x5001f000 alias where it should
> also appear. Guests (like very recent Arm Trusted Firmware-M)
> which try to access it at 0x5001f000 will crash.
>
> Fix this by moving the handling for this alias from the "all CPUs"
> container to the per-CPU container. (We leave the aliases for
> 0x1... and 0x3... in the overall container, because there are
> no per-CPU devices there.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Looks good from code inspection. However I'm having trouble getting the
right runes for building the firmware. What TARGET_PLATFORM matches the
IoTKit SSE2 that uses this?

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/hw/arm/armsse.h |  2 +-
>  hw/arm/armsse.c         | 26 ++++++++++++++++----------
>  2 files changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
> index f800bafb14a..5a845b3478d 100644
> --- a/include/hw/arm/armsse.h
> +++ b/include/hw/arm/armsse.h
> @@ -182,7 +182,7 @@ typedef struct ARMSSE {
>      MemoryRegion cpu_container[SSE_MAX_CPUS];
>      MemoryRegion alias1;
>      MemoryRegion alias2;
> -    MemoryRegion alias3;
> +    MemoryRegion alias3[SSE_MAX_CPUS];
>      MemoryRegion sram[MAX_SRAM_BANKS];
>
>      qemu_irq *exp_irqs[SSE_MAX_CPUS];
> diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
> index d0207dbabc7..ee1357312f1 100644
> --- a/hw/arm/armsse.c
> +++ b/hw/arm/armsse.c
> @@ -110,15 +110,16 @@ static bool irq_is_common[32] =3D {
>      /* 30, 31: reserved */
>  };
>
> -/* Create an alias region of @size bytes starting at @base
> +/*
> + * Create an alias region in @container of @size bytes starting at @base
>   * which mirrors the memory starting at @orig.
>   */
> -static void make_alias(ARMSSE *s, MemoryRegion *mr, const char *name,
> -                       hwaddr base, hwaddr size, hwaddr orig)
> +static void make_alias(ARMSSE *s, MemoryRegion *mr, MemoryRegion *contai=
ner,
> +                       const char *name, hwaddr base, hwaddr size, hwadd=
r orig)
>  {
> -    memory_region_init_alias(mr, NULL, name, &s->container, orig, size);
> +    memory_region_init_alias(mr, NULL, name, container, orig, size);
>      /* The alias is even lower priority than unimplemented_device region=
s */
> -    memory_region_add_subregion_overlap(&s->container, base, mr, -1500);
> +    memory_region_add_subregion_overlap(container, base, mr, -1500);
>  }
>
>  static void irq_status_forwarder(void *opaque, int n, int level)
> @@ -608,16 +609,21 @@ static void armsse_realize(DeviceState *dev, Error =
**errp)
>      }
>
>      /* Set up the big aliases first */
> -    make_alias(s, &s->alias1, "alias 1", 0x10000000, 0x10000000, 0x00000=
000);
> -    make_alias(s, &s->alias2, "alias 2", 0x30000000, 0x10000000, 0x20000=
000);
> +    make_alias(s, &s->alias1, &s->container, "alias 1",
> +               0x10000000, 0x10000000, 0x00000000);
> +    make_alias(s, &s->alias2, &s->container,
> +               "alias 2", 0x30000000, 0x10000000, 0x20000000);
>      /* The 0x50000000..0x5fffffff region is not a pure alias: it has
>       * a few extra devices that only appear there (generally the
>       * control interfaces for the protection controllers).
>       * We implement this by mapping those devices over the top of this
> -     * alias MR at a higher priority.
> +     * alias MR at a higher priority. Some of the devices in this range
> +     * are per-CPU, so we must put this alias in the per-cpu containers.
>       */
> -    make_alias(s, &s->alias3, "alias 3", 0x50000000, 0x10000000, 0x40000=
000);
> -
> +    for (i =3D 0; i < info->num_cpus; i++) {
> +        make_alias(s, &s->alias3[i], &s->cpu_container[i],
> +                   "alias 3", 0x50000000, 0x10000000, 0x40000000);
> +    }
>
>      /* Security controller */
>      object_property_set_bool(OBJECT(&s->secctl), true, "realized", &err);


--
Alex Benn=C3=A9e
