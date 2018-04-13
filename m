Received: from eggs.gnu.org ([2001:4830:134:3::10]:55624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6ysL-0008Eq-4E
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6ysK-0000cn-BF
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:36:25 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:37661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6ysK-0000cU-6f
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:36:24 -0400
Received: by mail-ot0-x244.google.com with SMTP id y46-v6so9871762otd.4
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 06:36:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1522160122-10744-7-git-send-email-eric.auger@redhat.com>
References: <1522160122-10744-1-git-send-email-eric.auger@redhat.com>
	<1522160122-10744-7-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Apr 2018 14:36:03 +0100
Message-ID: <CAFEAcA_p+ibaMyePwKW_dMQ_M7BHADnzvN_5_mjOLmUtEp=m2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 6/8] hw/arm/virt: Allow GICv3 DT node with
 multiple redistributor regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Christoffer Dall <cdall@kernel.org>, Shannon Zhao <zhaoshenglong@huawei.com>

On 27 March 2018 at 15:15, Eric Auger <eric.auger@redhat.com> wrote:
> This patch adds the GICState handle in the virtual machine state and
> allows to create a GIC device tree node advertising multiple redistributor
> regions.
>
> There is one range per distributor region following the GIC distributor.
> Please refer to kernel documentation for further details:
> Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

> +
> +        num_reg_values =  4 * (s->nb_redist_regions + 1);
> +        regs = g_new0(uint64_t, num_reg_values);
> +        qemu_fdt_setprop_cell(vms->fdt, "/intc", "#redistributor-regions",
> +                              s->nb_redist_regions);
> +        regs[0] = 2;
> +        regs[1] = vms->memmap[VIRT_GIC_DIST].base;
> +        regs[2] = 2;
> +        regs[3] = vms->memmap[VIRT_GIC_DIST].size;
> +
> +        for (r = 1; r <= s->nb_redist_regions; r++) {
> +            regs[4 * r] = 2;
> +            regs[4 * r  + 1] = s->redist_region[r - 1].base;
> +            regs[4 * r  + 2] = 2;
> +            /* count redistributors of 2 x 64kB pages */
> +            regs[4 * r  + 3] = (uint64_t)s->redist_region[r - 1].count << 17;

Board code shouldn't be reaching into the GIC device state struct like this.

> +        }
> +        qemu_fdt_setprop_sized_cells_from_array(vms->fdt, "/intc", "reg",
> +                                                num_reg_values / 2, regs);
> +        g_free(regs);
> +
>          if (vms->virt) {
>              qemu_fdt_setprop_cells(vms->fdt, "/intc", "interrupts",

thanks
-- PMM
