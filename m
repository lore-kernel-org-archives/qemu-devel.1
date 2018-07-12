Received: from eggs.gnu.org ([2001:4830:134:3::10]:48828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdcZJ-0000H3-OW
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:27:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdcZI-0007Fh-To
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:27:41 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:39954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdcZI-0007F2-EF
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:27:40 -0400
Received: by mail-oi0-x242.google.com with SMTP id w126-v6so56115643oie.7
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 07:27:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629132954.24269-18-luc.michel@greensocs.com>
References: <20180629132954.24269-1-luc.michel@greensocs.com>
	<20180629132954.24269-18-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 15:27:19 +0100
Message-ID: <CAFEAcA8-Nf698hVObSyR=nNR2nNKpCcxOXYvaUux9PKX882-Pw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 17/20] intc/arm_gic: Implement
 maintenance interrupt generation
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
> Implement the maintenance interrupt generation that is part of the GICv2
> virtualization extensions.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> +static void gic_compute_misr(GICState *s, int cpu)
> +{
> +    int val;

This could be a bool.

> +    int vcpu = cpu + GIC_NCPU;
> +
> +    int num_eoi, num_valid, num_pending;
> +
> +    gic_extract_lr_info(s, cpu, &num_eoi, &num_valid, &num_pending);
> +
> +    /* EOI */
> +    val = (num_eoi != 0);
> +    s->h_misr[cpu] = FIELD_DP32(0, GICH_MISR, EOI, val);

Where you're starting with 0 and just ORing in bits, it's
probably clearer to use
     value = 0;
     if (something) {
         value |= R_GICH_MISR_EOI_MASK;
     }
     if (something) {
         value |= R_GICH_MISR_U_MASK;
     }
     etc...
     s->h_misr[cpu] = value;


All the logic here is fine though so
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
