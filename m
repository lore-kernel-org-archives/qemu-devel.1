Received: from eggs.gnu.org ([2001:4830:134:3::10]:56470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fLS7K-0003Hg-2i
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:39:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fLS7G-0000Fy-Vy
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:39:42 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:37640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fLS7G-0000Fc-N1
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:39:38 -0400
Received: by mail-wm0-x244.google.com with SMTP id l1-v6so8332617wmb.2
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 04:39:38 -0700 (PDT)
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-27-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180521140402.23318-27-peter.maydell@linaro.org>
Date: Wed, 23 May 2018 12:39:36 +0100
Message-ID: <87tvqytxc7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 26/27] hw/arm/iotkit: Wire up MPC interrupt
 lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


Peter Maydell <peter.maydell@linaro.org> writes:

> The interrupt outputs from the MPC in the IoTKit and the expansion
> MPCs in the board must be wired up to the security controller, and
> also all ORed together to produce a single line to the NVIC.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/hw/arm/iotkit.h |  6 ++++
>  hw/arm/iotkit.c         | 74 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+)
>
> diff --git a/include/hw/arm/iotkit.h b/include/hw/arm/iotkit.h
> index b21cf1ab9d..2cddde55dd 100644
> --- a/include/hw/arm/iotkit.h
> +++ b/include/hw/arm/iotkit.h
> @@ -42,6 +42,9 @@
>   *  + named GPIO outputs ahb_ppcexp{0,1,2,3}_irq_enable
>   *  + named GPIO outputs ahb_ppcexp{0,1,2,3}_irq_clear
>   *  + named GPIO inputs ahb_ppcexp{0,1,2,3}_irq_status
> + * Controlling each of the 16 expansion MPCs which a system using the Io=
TKit
> + * might provide:
> + *  + named GPIO inputs mpcexp_status[0..15]
>   */
>
>  #ifndef IOTKIT_H
> @@ -81,6 +84,8 @@ typedef struct IoTKit {
>      qemu_or_irq ppc_irq_orgate;
>      SplitIRQ sec_resp_splitter;
>      SplitIRQ ppc_irq_splitter[NUM_PPCS];
> +    SplitIRQ mpc_irq_splitter[IOTS_NUM_EXP_MPC + IOTS_NUM_MPC];
> +    qemu_or_irq mpc_irq_orgate;
>
>      UnimplementedDeviceState dualtimer;
>      UnimplementedDeviceState s32ktimer;
> @@ -99,6 +104,7 @@ typedef struct IoTKit {
>      qemu_irq nsc_cfg_in;
>
>      qemu_irq irq_status_in[NUM_EXTERNAL_PPCS];
> +    qemu_irq mpcexp_status_in[IOTS_NUM_EXP_MPC];
>
>      uint32_t nsccfg;
>
> diff --git a/hw/arm/iotkit.c b/hw/arm/iotkit.c
> index 160e40c744..133d5bb34f 100644
> --- a/hw/arm/iotkit.c
> +++ b/hw/arm/iotkit.c
> @@ -131,6 +131,18 @@ static void iotkit_init(Object *obj)
>      init_sysbus_child(obj, "apb-ppc1", &s->apb_ppc1, sizeof(s->apb_ppc1),
>                        TYPE_TZ_PPC);
>      init_sysbus_child(obj, "mpc", &s->mpc, sizeof(s->mpc), TYPE_TZ_MPC);
> +    object_initialize(&s->mpc_irq_orgate, sizeof(s->mpc_irq_orgate),
> +                      TYPE_OR_IRQ);
> +    object_property_add_child(obj, "mpc-irq-orgate",
> +                              OBJECT(&s->mpc_irq_orgate), &error_abort);
> +    for (i =3D 0; i < ARRAY_SIZE(s->mpc_irq_splitter); i++) {
> +        char *name =3D g_strdup_printf("mpc-irq-splitter-%d", i);
> +        SplitIRQ *splitter =3D &s->mpc_irq_splitter[i];
> +
> +        object_initialize(splitter, sizeof(*splitter), TYPE_SPLIT_IRQ);
> +        object_property_add_child(obj, name, OBJECT(splitter), &error_ab=
ort);
> +        g_free(name);
> +    }
>      init_sysbus_child(obj, "timer0", &s->timer0, sizeof(s->timer0),
>                        TYPE_CMSDK_APB_TIMER);
>      init_sysbus_child(obj, "timer1", &s->timer1, sizeof(s->timer1),
> @@ -163,6 +175,12 @@ static void iotkit_exp_irq(void *opaque, int n, int =
level)
>      qemu_set_irq(s->exp_irqs[n], level);
>  }
>
> +static void iotkit_mpcexp_status(void *opaque, int n, int level)
> +{
> +    IoTKit *s =3D IOTKIT(opaque);
> +    qemu_set_irq(s->mpcexp_status_in[n], level);
> +}
> +
>  static void iotkit_realize(DeviceState *dev, Error **errp)
>  {
>      IoTKit *s =3D IOTKIT(dev);
> @@ -328,6 +346,22 @@ static void iotkit_realize(DeviceState *dev, Error *=
*errp)
>                                  sysbus_mmio_get_region(SYS_BUS_DEVICE(&s=
->mpc),
>                                                         0));
>
> +    /* We must OR together lines from the MPC splitters to go to the NVI=
C */
> +    object_property_set_int(OBJECT(&s->mpc_irq_orgate),
> +                            IOTS_NUM_EXP_MPC + IOTS_NUM_MPC, "num-lines"=
, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    object_property_set_bool(OBJECT(&s->mpc_irq_orgate), true,
> +                             "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    qdev_connect_gpio_out(DEVICE(&s->mpc_irq_orgate), 0,
> +                          qdev_get_gpio_in(DEVICE(&s->armv7m), 9));
> +
>      /* Devices behind APB PPC0:
>       *   0x40000000: timer0
>       *   0x40001000: timer1
> @@ -536,6 +570,46 @@ static void iotkit_realize(DeviceState *dev, Error *=
*errp)
>          g_free(gpioname);
>      }
>
> +    /* Wire up the splitters for the MPC IRQs */
> +    for (i =3D 0; i < IOTS_NUM_EXP_MPC + IOTS_NUM_MPC; i++) {
> +        SplitIRQ *splitter =3D &s->mpc_irq_splitter[i];
> +        DeviceState *dev_splitter =3D DEVICE(splitter);
> +
> +        object_property_set_int(OBJECT(splitter), 2, "num-lines", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +        object_property_set_bool(OBJECT(splitter), true, "realized", &er=
r);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +
> +        if (i < IOTS_NUM_EXP_MPC) {
> +            /* Splitter input is from GPIO input line */
> +            s->mpcexp_status_in[i] =3D qdev_get_gpio_in(dev_splitter, 0);
> +            qdev_connect_gpio_out(dev_splitter, 0,
> +                                  qdev_get_gpio_in_named(dev_secctl,
> +                                                         "mpcexp_status"=
, i));
> +        } else {
> +            /* Splitter input is from our own MPC */
> +            qdev_connect_gpio_out_named(DEVICE(&s->mpc), "irq", 0,
> +                                        qdev_get_gpio_in(dev_splitter, 0=
));
> +            qdev_connect_gpio_out(dev_splitter, 0,
> +                                  qdev_get_gpio_in_named(dev_secctl,
> +                                                         "mpc_status", 0=
));
> +        }
> +
> +        qdev_connect_gpio_out(dev_splitter, 1,
> +                              qdev_get_gpio_in(DEVICE(&s->mpc_irq_orgate=
), i));
> +    }
> +    /* Create GPIO inputs which will pass the line state for our
> +     * mpcexp_irq inputs to the correct splitter devices.
> +     */
> +    qdev_init_gpio_in_named(dev, iotkit_mpcexp_status, "mpcexp_status",
> +                            IOTS_NUM_EXP_MPC);
> +
>      iotkit_forward_sec_resp_cfg(s);
>
>      system_clock_scale =3D NANOSECONDS_PER_SECOND / s->mainclk_frq;


--
Alex Benn=C3=A9e
