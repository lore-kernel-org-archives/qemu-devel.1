Received: from eggs.gnu.org ([2001:4830:134:3::10]:33106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdbmu-0007fN-Bf
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:37:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdbmt-0006Cc-G6
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:37:40 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:45855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdbmt-0006Bc-8t
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:37:39 -0400
Received: by mail-oi0-x243.google.com with SMTP id q11-v6so30228237oic.12
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 06:37:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629132954.24269-15-luc.michel@greensocs.com>
References: <20180629132954.24269-1-luc.michel@greensocs.com>
	<20180629132954.24269-15-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 14:37:17 +0100
Message-ID: <CAFEAcA_R9zp7EBtFetH5Q1Dnzj-kjPzDKRsBAo9aVnMZ3PW0VA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 14/20] intc/arm_gic: Wire the vCPU
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, Jan Kiszka <jan.kiszka@web.de>

On 29 June 2018 at 14:29, Luc Michel <luc.michel@greensocs.com> wrote:
> Add the read/write functions to handle accesses to the vCPU interface.
> Those accesses are forwarded to the real CPU interface, with the CPU id
> being converted to the corresponding vCPU id (vCPU id = CPU id +
> GIC_NCPU).
>
> As for the CPU interface, we create a base region for the vCPU interface
> that fetches the current vCPU id using the current_cpu global variable, and
> one mirror region per vCPU which maps to that specific vCPU id. This is
> required by the GIC architecture specification.


>  static void arm_gic_realize(DeviceState *dev, Error **errp)
>  {
>      /* Device instance realize function for the GIC sysbus device */
> @@ -1531,7 +1590,7 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
>      }
>
>      /* This creates distributor and main CPU interface (s->cpuiomem[0]) */

Can we also update this comment to indicate what virt-related
memory regions are being created?

> -    gic_init_irqs_and_mmio(s, gic_set_irq, gic_ops, NULL);
> +    gic_init_irqs_and_mmio(s, gic_set_irq, gic_ops, gic_virt_ops);
>
>      /* Extra core-specific regions for the CPU interfaces. This is
>       * necessary for "franken-GIC" implementations, for example on
> @@ -1547,6 +1606,16 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
>                                &s->backref[i], "gic_cpu", 0x100);
>          sysbus_init_mmio(sbd, &s->cpuiomem[i+1]);
>      }
> +
> +    if (s->virt_extn) {

...and a comment about what these regions are for.

What requires these per-core regions anyway? There's no way to
specify them in the device tree bindings for Linux, which AFAIK
only cares about using the "vcpu i/f for this core" registers.
I don't think the GIC-400 has these. (It does have per-cpu
aliases of the GICH_* registers, but this patchset doesn't seem
to implement those.)

> +        for (i = 0; i < s->num_cpu; i++) {
> +            memory_region_init_io(&s->vcpuiomem[i + 1], OBJECT(s),
> +                                  &gic_vcpu_ops, &s->backref[i],
> +                                  "gic_vcpu", 0x2000);
> +            sysbus_init_mmio(sbd, &s->vcpuiomem[i + 1]);
> +        }
> +    }
> +
>  }

thanks
-- PMM
